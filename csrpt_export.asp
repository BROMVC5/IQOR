<!-- #include file="include/connection.asp" -->
<!-- #include file="include/validate.asp" -->
<!-- #include file="include/proc.asp" -->
<html>
<head>
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>
</head>
<body style="background-color: white">
<%

sType = request("txtType")
dtFrDate = request("dtFrDate")
dtToDate = request("dtToDate")
sEmpCode = request("txtEmpCode")
sDeptID = request("txtDeptID")
sGradeID = request("txtGradeID")
sCostID = request("txtCostID")
sContID = request("txtContID")
sDisType = request("cboDisType")
sSup_Code = request("txtSup_CODE")
sSubType = request("txtSubType")

sPage = 1

%>
<!-- AM/PM Time -->
<%
function ampmTime(InTime)
    dim OutHour, ampm
        if hour(InTime) < 12 then
            OutHour = hour(InTime)
            ampm = "AM"
        end if
        if hour(InTime) = 12 then
            OutHour = hour(InTime)
            ampm = "PM"
        end if
        if hour(InTime) > 12 then
            OutHour = hour(InTime) - 12
            ampm = "PM"
        end if
        ampmTime = FormatDateTime(OutHour & ":" & minute(Intime),4) & " " & ampm
	end function
%>

<!-- Column Function -->
<%
sep = chr(9)

Function fCol(dTemp)

	fCol = dTemp
	
End Function

%>

<!-- DateTime -->
<%
tsYear = Year(date())
tsMonth = month(date())
tsDay = day(date())
If len(tsMonth)=1 then tsMonth = "0" & tsMonth
If len(tsDay)=1 then tsDay = "0" & tsDay

tsHour = Hour(formatdatetime(now(),4))
tsMinute = Minute(formatdatetime(now(),4))
tsSecond = Second(formatdatetime(now(),3))
If len(tsHour) = 1 then tsHour = "0" & tsHour
If len(tsMinute) = 1 then tsMinute = "0" & tsMinute
If len(tsSecond) = 1 then tsSecond = "0" & tsSecond
sDtTime = tsYear & tsMonth & tsDay & tsHour & tsMinute & tsSecond

%>

<%
if sType = "SD" then	
	sFileName = "CS_SumDate_" & sDtTime & ".xls"
elseif sType = "ES" then
	sFileName = "CS_EmpSum_" & sDtTime & ".xls"
elseif sType = "ED" then
	sFileName = "CS_EmpDet_" & sDtTime & ".xls"
elseif sType = "ET" then
	sFileName = "CS_SubEnt_" & sDtTime & ".xls"
elseif sType = "SS" then
	sFileName = "CS_SubEntSummary_" & sDtTime & ".xls"
elseif sType = "EMT" then
	sFileName = "CS_EmpTrans_" & sDtTime & ".xls"
end if

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
				
if sType = "SD" then
				 
		Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select sum(case when cstrns.type = 'N' then cstrns.COUPON else 0 end) as sumCoupon, sum(case when cstrns.type <> 'N' then cstrns.COUPON else 0 end) as sumExtra, "
		sSQL = sSQL & "csemply.EMP_CODE as EMP_CODE,csemply.NAME as NAME, tmemply.DEPT_ID as DEPT_ID, "
		sSQL = sSQL & "tmemply.GRADE_ID as GRADE_ID, tmemply.COST_ID as COST_ID,  tmemply.CONT_ID as CONT_ID,cstrns.* from cstrns "
		sSQL = sSQL & "left join csemply on cstrns.CARDNO = csemply.CARDNO "
		sSQL = sSQL & "left join tmemply on csemply.EMP_CODE = tmemply.EMP_CODE where cstrns.status = 'Y' "
		sSQL = sSQL & "AND MID(cstrns.DT_TRNS,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "
		
		if sEmpCode <> "" then
			sSQL = sSQL & "AND csemply.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
		end if
					
		if sDeptID <> "" then
			sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
		end if
		
		if sGradeID <> "" then
			sSQL = sSQL & "AND GRADE_ID ='" & pRTIN(sGradeID) & "'"
		end if	
		
		if sCostID <> "" then
			sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
		end if
		
		if sContID <> "" then
			sSQL = sSQL & "AND CONT_ID ='" & pRTIN(sContID) & "'"
		end if
		
		if sDisType = "E" then 
			if sSubType <> "" then
				sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
			end if
		end if
		
		if sSup_Code <> "" then
			sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
		end if		
		
		sSQL = sSQL & "group by MID(cstrns.DT_TRNS,1,10) "
		sSQL = sSQL & "order by MID(cstrns.DT_TRNS,1,10) asc "
		rstCSTrns.Open sSQL, conn, 3, 3
		if not rstCSTrns.EOF then
			
			if sDisType = "N" then
				sStr = fCol("Date") & sep & fCol("Normal(RM)")
			elseif sDisType = "E" then
				sStr = fCol("Date") & sep & fCol("Extra (RM)")
			elseif sDisType = "B" then
				sStr = fCol("Date") & sep & fCol("Normal(RM)") & sep & fCol("Extra (RM)") & sep & fCol("Total")	
			end if 
			objOpenFile.WriteLine sStr
								  
			do while not rstCSTrns.eof
								
				dCoupon = rstCSTrns("sumCoupon")
				dECoupon = rstCSTrns("sumExtra")
				dTotCoupon = dCoupon + dECoupon		
					
				if sDisType = "N" then
					sStr = fdatelong(rstCSTrns("DT_TRNS")) & sep & pFormat(dCoupon,2)
				elseif sDisType = "E" then
					sStr = fdatelong(rstCSTrns("DT_TRNS")) & sep & pFormat(dECoupon,2)
				elseif sDisType = "B" then
					sStr = fdatelong(rstCSTrns("DT_TRNS")) & sep & pFormat(dCoupon,2) & sep & pFormat(dECoupon,2) & sep & pFormat(dTotCoupon,2)		
				end if
				objOpenFile.WriteLine sStr
				
			rstCSTrns.movenext
			loop
		end if
		call pCloseTables(rstCSTrns)
		
elseif sType = "ES" then
	
		Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select sum(case when cstrns.type = 'N' then cstrns.COUPON else 0 end) as sumCoupon, sum(case when cstrns.type <> 'N' then cstrns.COUPON else 0 end) as sumExtra, "
		sSQL = sSQL & "csemply.EMP_CODE as EMP_CODE,csemply.NAME as NAME, tmemply.DEPT_ID as DEPT_ID, "
		sSQL = sSQL & "tmemply.GRADE_ID as GRADE_ID, tmemply.COST_ID as COST_ID,  tmemply.CONT_ID as CONT_ID,cstrns.* from cstrns "
		sSQL = sSQL & "left join csemply on cstrns.CARDNO = csemply.CARDNO "
		sSQL = sSQL & "left join tmemply on csemply.EMP_CODE = tmemply.EMP_CODE "
		sSQL = sSQL & "where cstrns.STATUS= 'Y' "
		sSQL = sSQL & "AND MID(cstrns.DT_TRNS,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "			
		
		if sEmpCode <> "" then
			sSQL = sSQL & "AND csemply.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
		end if
								
		if sDeptID <> "" then
			sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
		end if
		
		if sGradeID <> "" then
			sSQL = sSQL & "AND GRADE_ID ='" & pRTIN(sGradeID) & "'"
		end if	
		
		if sCostID <> "" then
			sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
		end if
		
		if sContID <> "" then
			sSQL = sSQL & "AND CONT_ID ='" & pRTIN(sContID) & "'"
		end if
		
		if sDisType = "E" then 
			if sSubType <> "" then
				sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
			end if
		end if
		
		if sSup_Code <> "" then
			sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
		end if		
		
		sSQL = sSQL & "group by cstrns.CARDno "
		sSQL = sSQL & "order by EMP_CODE asc "
		rstCSTrns.Open sSQL, conn, 3, 3

	   if not rstCSTrns.eof then
		
			if sDisType = "N" then
				sStr = fCol("Employee Code") & sep & fCol("Full Name") & sep & fCol("Normal(RM)")
			elseif sDisType = "E" then
				sStr = fCol("Employee Code") & sep & fCol("Full Name") & sep & fCol("Extra (RM)")
			elseif sDisType = "B" then
				sStr = fCol("Employee Code") & sep & fCol("Full Name") & sep & fCol("Normal(RM)") & sep & fCol("Extra (RM)") & sep & fCol("Total")
			end if 
			objOpenFile.WriteLine sStr
								  
			do while not rstCSTrns.eof
								
				dCoupon = rstCSTrns("sumCoupon")
				dECoupon = rstCSTrns("sumExtra")
				dTotCoupon = dCoupon + dECoupon		
					
				if sDisType = "N" then
					sStr = rstCSTrns("EMP_CODE") & sep & rstCSTrns("NAME") & sep & pFormat(dCoupon,2)
				elseif sDisType = "E" then
					sStr = rstCSTrns("EMP_CODE") & sep & rstCSTrns("NAME") & sep & pFormat(dECoupon,2)
				elseif sDisType = "B" then
					sStr = rstCSTrns("EMP_CODE") & sep & rstCSTrns("NAME") & sep & pFormat(dCoupon,2) & sep & pFormat(dECoupon,2) & sep & pFormat(dTotCoupon,2)
				end if
				objOpenFile.WriteLine sStr
				
			rstCSTrns.movenext
			loop
			
		end if
		call pCloseTables(rstCSTrns)
		
elseif sType = "ED" then
		
		Set rstCSTrns = server.CreateObject("ADODB.RecordSet")
		sSQL = "select sum(case when cstrns.type = 'N' then cstrns.COUPON else 0 end) as sumCoupon, sum(case when cstrns.type <> 'N' then cstrns.COUPON else 0 end) as sumExtra, "
		sSQL = sSQL & "csemply.EMP_CODE as EMP_CODE,csemply.NAME as NAME, tmemply.DEPT_ID as DEPT_ID, "
		sSQL = sSQL & "tmemply.GRADE_ID as GRADE_ID, tmemply.COST_ID as COST_ID,  tmemply.CONT_ID as CONT_ID,cstrns.* from cstrns "
		sSQL = sSQL & "left join csemply on cstrns.CARDNO = csemply.CARDNO "
		sSQL = sSQL & "left join tmemply on csemply.EMP_CODE = tmemply.EMP_CODE "
		sSQL = sSQL & "where cstrns.STATUS= 'Y' "
		sSQL = sSQL & "AND MID(cstrns.DT_TRNS,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "								
		
		if sEmpCode <> "" then
			sSQL = sSQL & "AND csemply.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
		end if
					
		if sDeptID <> "" then
			sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
		end if
		
		if sGradeID <> "" then
			sSQL = sSQL & "AND GRADE_ID ='" & pRTIN(sGradeID) & "'"
		end if	
		
		if sCostID <> "" then
			sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
		end if
		
		if sContID <> "" then
			sSQL = sSQL & "AND CONT_ID ='" & pRTIN(sContID) & "'"
		end if
		
		if sDisType = "E" then 
			if sSubType <> "" then
				sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
			end if
		end if
		
		if sSup_Code <> "" then
			sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
		end if		
		
		sSQL = sSQL & "group by cstrns.CARDno,MID(cstrns.DT_TRNS,1,10)"
		sSQL = sSQL & "order by EMP_CODE, cstrns.DT_TRNS asc "
		rstCSTrns.Open sSQL, conn, 3, 3
	
		if not rstCSTrns.eof then
			
			if sDisType = "N" then
				sStr = fCol("Employee Code") & sep & fCol("Full Name") & sep & fCol("Date") & sep & fCol("Normal(RM)")
			elseif sDisType = "E" then
				sStr = fCol("Employee Code") & sep & fCol("Full Name") & sep & fCol("Date") & sep & fCol("Extra (RM)")
			elseif sDisType = "B" then
				sStr = fCol("Employee Code") & sep & fCol("Full Name") & sep & fCol("Date") & sep & fCol("Normal(RM)") & sep & fCol("Extra (RM)") & sep & fCol("Total")	
			end if
			objOpenFile.WriteLine sStr

			do while not rstCSTrns.eof
					
				dCoupon = rstCSTrns("sumCoupon")
				dECoupon = rstCSTrns("sumExtra")
				dTotCoupon = dCoupon + dECoupon	
				
				if sDisType = "N" then				
					sStr = rstCSTrns("EMP_CODE") & sep & rstCSTrns("NAME") & sep &  fdatelong(rstCSTrns("DT_TRNS")) & sep & pFormat(dCoupon,2)
				elseif sDisType = "E" then
					sStr = rstCSTrns("EMP_CODE") & sep & rstCSTrns("NAME") & sep &  fdatelong(rstCSTrns("DT_TRNS")) & sep & pFormat(dECoupon,2)
				elseif sDisType = "B" then
					sStr = rstCSTrns("EMP_CODE") & sep & rstCSTrns("NAME") & sep &  fdatelong(rstCSTrns("DT_TRNS")) & sep & pFormat(dCoupon,2) & sep & pFormat(dECoupon,2) & sep & pFormat(dTotCoupon,2)
				end if
				objOpenFile.WriteLine sStr
										
			rstCSTrns.movenext
														
			loop	
										
		end if
		call pCloseTables(rstCSTrns)
		
elseif sType = "ET" then

	Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select csemply1.emp_code, tmemply.name, csemply1.dt_sub,csemply1.amount from csemply1 "
	sSQL = sSQL & " left join tmemply on csemply1.emp_code = tmemply.emp_code "
	sSQL = sSQL & "where MID(DT_SUB,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "

	if sSubType <> "" then
		sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
	end if

	if sEmpCode <> "" then
		sSQL = sSQL & "AND csemply1.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
	end if

	if sDeptID <> "" then
		sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
	end if

	if sCostID <> "" then
		sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
	end if

	if sSup_Code <> "" then
		sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
	end if		

	sSQL = sSQL & "order by EMP_CODE asc "
	rstCSTrns.Open sSQL, conn, 3, 3
	if not rstCSTrns.eof then
		i = 0
		sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Date") & sep & fCol("Amount (RM)")
		objOpenFile.WriteLine sStr
			
		do while not rstCSTrns.eof

			i = i + 1
			sStr = i & sep & rstCSTrns("EMP_CODE") & sep &  rstCSTrns("NAME") & sep & rstCSTrns("DT_SUB") & sep & pFormatDash(rstCSTrns("AMOUNT"),2)
			objOpenFile.WriteLine sStr
									
		rstCSTrns.movenext
													
		loop	
	end if
	call pCloseTables(rstCSTrns)
	
elseif sType = "SS" then
	
	Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select csemply1.emp_code, tmemply.name, sum(csemply1.amount) as dSumAmount from csemply1 "
	sSQL = sSQL & " left join tmemply on csemply1.emp_code = tmemply.emp_code "
	sSQL = sSQL & "where MID(DT_SUB,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "

	if sSubType <> "" then
		sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
	end if	

	if sSubType <> "" then
		sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
	end if

	if sEmpCode <> "" then
		sSQL = sSQL & "AND csemply1.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
	end if

	if sDeptID <> "" then
		sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
	end if

	if sCostID <> "" then
		sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
	end if

	if sSup_Code <> "" then
		sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
	end if	

	sSQL = sSQL & "group by EMP_CODE "
	sSQL = sSQL & "order by EMP_CODE asc "
	rstCSTrns.Open sSQL, conn, 3, 3
	if not rstCSTrns.eof then
		i = 0
		sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Amount (RM)")
		objOpenFile.WriteLine sStr
			
		do while not rstCSTrns.eof

			i = i + 1
			sStr = i & sep & rstCSTrns("EMP_CODE") & sep &  rstCSTrns("NAME") & sep & pFormatDash(rstCSTrns("dSumAmount"),2)
			objOpenFile.WriteLine sStr
									
		rstCSTrns.movenext
													
		loop	
	end if
	call pCloseTables(rstCSTrns)
	
elseif sType = "EMT" then

	Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select cstrns.cardno, cstrns.coupon, cstrns.type, cstrns.dt_trns, csemply.emp_code, csemply.name from cstrns "
	sSQL = sSQL & "left join csemply on cstrns.cardno = csemply.cardno "
	sSQL = sSQL & "left join tmemply on csemply.emp_code = tmemply.emp_code "
	sSQL = sSQL & "where MID(DT_TRNS,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "								
	
	if sEmpCode <> "" then
		sSQL = sSQL & "AND csemply.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
	end if
	
	if sDeptID <> "" then
		sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
	end if
	
	if sCostID <> "" then
		sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
	end if
	
	if sSup_Code <> "" then
		sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
	end if 

	sSQL = sSQL & "order by EMP_CODE,DT_TRNS"
	rstCSTrns.Open sSQL, conn, 3, 3
	if not rstCSTrns.eof then
		i = 0
		sStr = fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Card No") & sep & fCol("Type") & sep & fCol("Coupon") & sep & fCol("Datetime")
		objOpenFile.WriteLine sStr
			
		do while not rstCSTrns.eof
		
			sSubType = ""
						
			if rstCSTrns("TYPE") = "N" then
				sSubType = "NORMAL"
			else
				sSubType = rstCSTrns("TYPE")
			end if

			sStr = rstCSTrns("EMP_CODE") & sep &  rstCSTrns("NAME") & sep & "'" & rstCSTrns("CARDNO") & sep & sSubType & sep & rstCSTrns("COUPON") & sep & rstCSTrns("DT_TRNS")
			objOpenFile.WriteLine sStr
									
		rstCSTrns.movenext
													
		loop	
	end if 
end if


objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>