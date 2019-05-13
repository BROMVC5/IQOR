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
dtFrCDate = request("dtFrCDate")
dtToCDate = request("dtToCDate")
dtFrADate = request("dtFrADate")
dtToADate = request("dtToADate")
sEmp_ID = request("txtEmp_ID")
sEnType = request("txtEn_Name")
sInsertType = request("cboType")
sDtType = request("txtDtType")
sPanelCode = request("txtPanelCode")
sImpType = request("cboImpType")
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
if sType = "CR" then	
	sFileName = "ClaimR_" & sDtTime & ".xls"
elseif sType = "BE" then
	sFileName = "BlcEn_" & sDtTime & ".xls"
elseif sType = "EX" then
	sFileName = "Except_" & sDtTime & ".xls"
end if
	
sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
				
if sType = "CR" then
	
	Set rstMSTrns = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT REFNO, EMP_CODE, EMP_NAME, ENTITLEMENT, DT_CLAIM, DT_ATTEND, CLAIMA, TYPE, PANELC, MSPANELC.PANELNAME, MSSTAFFC.OTHERC "
	sSQL = sSQL & "FROM MSSTAFFC LEFT JOIN MSPANELC ON MSSTAFFC.PANELC = MSPANELC.PANELCODE "
    if sDtType = "CL" then 
	    sSQL = sSQL & "WHERE MID(DT_CLAIM,1,10) BETWEEN '" & Mid(fdatetime2(dtFrCDate),1,10) & "' AND '" & Mid(fdatetime2(dtToCDate),1,10) & "' "
	else
        sSQL = sSQL & "WHERE MID(DT_ATTEND,1,10) BETWEEN '" & Mid(fdatetime2(dtFrADate),1,10) & "' AND '" & Mid(fdatetime2(dtToADate),1,10) & "' "
    end if
	
	if sEmp_ID <> "" then
		sSQL = sSQL & "AND EMP_CODE ='" & pRTIN(sEmp_ID) & "'"
	end if
	
	if sEnType <> "" then
		sSQL = sSQL & "AND ENTITLEMENT ='" & pRTIN(sEnType) & "'"
	end if
	
	if sInsertType <> "" then
		sSQL = sSQL & "AND TYPE ='" & pRTIN(sInsertType) & "'"
	end if
	
	if sPanelCode <> "" then
		sSQL = sSQL & "AND PANELC ='" & pRTIN(sPanelCode) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY EMP_CODE, DT_ATTEND ASC "
	rstMSTrns.Open sSQL, conn, 3, 3
		if not rstMSTrns.EOF then
			i = 0
			
            if sDtType = "CL" then
			    sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Reference No") & sep & fCol("Entitlement Type") & sep & fCol("Panel Clinic") & sep & fCol("Claim Date") & sep & fCol("Claim Amt")
            else
                sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Reference No") & sep & fCol("Entitlement Type") & sep & fCol("Panel Clinic") & sep & fCol("Attend Date") & sep & fCol("Claim Amt")
            end if
			objOpenFile.WriteLine sStr
								  
			do while not rstMSTrns.eof
				
				i = i + 1
				sEmpCode = rstMSTrns("EMP_CODE")
				sEmp_Name = rstMSTrns("EMP_NAME")
				sRefNo = rstMSTrns("REFNO")
				sEnType = rstMSTrns("ENTITLEMENT")
 
				dtClaim = rstMSTrns("DT_CLAIM")
				dtAttend = rstMSTrns("DT_ATTEND")
				dClaimA = rstMSTrns("CLAIMA")	

				sPanelName = Ucase(rstMSTrns("PANELNAME"))			
				
                if sDtType = "CL" then
				    sStr = i & sep & sEmpCode & sep & sEmp_Name & sep & sRefNo & sep & sEnType & sep & sPanelName & sep & dtClaim	& sep & pFormat(dClaimA,2)		
                else
                    sStr = i & sep & sEmpCode & sep & sEmp_Name & sep & sRefNo & sep & sEnType & sep & sPanelName & sep & dtAttend & sep & pFormat(dClaimA,2)		
                end if

				objOpenFile.WriteLine sStr
				
			rstMSTrns.movenext
			loop
		end if
		call pCloseTables(rstMSTrns)
		
elseif sType = "BE" then
	
		Set rstMSTrns = server.CreateObject("ADODB.RecordSet")    
		sSQL = "SELECT REFNO, EMP_CODE, EMP_NAME, ENTITLEMENT, MAXC ,CLAIMA ,SUM(CLAIMA) as ACCU, MAXC - CLAIMA AS BALANCE, PANELC, MSPANELC.PANELNAME, MSSTAFFC.OTHERC "
		sSQL = sSQL & "FROM MSSTAFFC LEFT JOIN MSPANELC ON MSSTAFFC.PANELC = MSPANELC.PANELCODE "
        if sDtType = "CL" then
		    sSQL = sSQL & "WHERE MID(DT_CLAIM,1,10) BETWEEN '" & Mid(fdatetime2(dtFrCDate),1,10) & "' AND '" & Mid(fdatetime2(dtToCDate),1,10) & "' "
        else
		    sSQL = sSQL & "WHERE MID(DT_ATTEND,1,10) BETWEEN '" & Mid(fdatetime2(dtFrADate),1,10) & "' AND '" & Mid(fdatetime2(dtToADate),1,10) & "' "
        end if
		
		if sEmp_ID <> "" then
			sSQL = sSQL & "AND EMP_CODE ='" & pRTIN(sEmp_ID) & "'"
		end if
		
		if sEnType <> "" then
			sSQL = sSQL & "AND ENTITLEMENT ='" & pRTIN(sEnType) & "'"
		end if
		
		if sInsertType <> "" then
			sSQL = sSQL & "AND TYPE ='" & pRTIN(sInsertType) & "'"
		end if
		
		if sPanelCode <> "" then
			sSQL = sSQL & "AND PANELC ='" & pRTIN(sPanelCode) & "'"
		end if
		
		sSQL = sSQL & "GROUP BY EMP_CODE, ENTITLEMENT "
		sSQL = sSQL & "ORDER BY EMP_CODE ASC "
		rstMSTrns.Open sSQL, conn, 3, 3
		
	   if not rstMSTrns.eof then
			record = 0
			sPrevEmpCode = rstMSTrns("EMP_CODE")
			bPrint = true
			dMaxC = 0
			dSumClaim = 0
			
			sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Reference No") & sep & fCol("Entitlement Type") & sep & fCol("Panel Clinic") & sep & fCol("Max Claim") & sep & fCol("Claim Amt") & sep & fCol("Balance")
			objOpenFile.WriteLine sStr
								  
			do while not rstMSTrns.eof
		
				sEmpCode = rstMSTrns("EMP_CODE")
				sEmp_Name = rstMSTrns("EMP_NAME")
				sRefno = rstMSTrns("REFNO")
				dMaxC = rstMSTrns("MAXC")
				dSumClaim = rstMSTrns("CLAIMA")
				dAccu = rstMSTrns("ACCU")
				dTotal = dMaxC - dAccu	
				dGMClaim = dGMClaim + dMaxc
				
				sPanelName = Ucase(rstMSTrns("PANELNAME"))
				
				if Ucase(rstMSTrns("ENTITLEMENT")) = "PANEL CLINIC VISITATION" then
					dTotal = 0
				else
					dGTot = dGTot + dTotal
				end if
				
				if rstMSTrns("EMP_CODE") <> sPrevEmpCode then
					sStr = sep & sep & sep & sep & sep & sep
					objOpenFile.WriteLine sStr
					
					dSubMaxc = 0
					dSubSumClaim = 0
					dSubTotal = 0
					record = record + 2
					sPrevEmpCode = rstMSTrns("EMP_CODE")
					bPrint = true
				end if
				
				if bPrint = true then
					i = i + 1
					sStr = i & sep & sEmpCode & sep & sEmp_Name & sep & sRefno 
					bPrint = false
					
				else
					sStr = sep & sep & sep
				end if
					sStr = sStr & sep & rstMSTrns("ENTITLEMENT") & sep & sPanelName  & sep & pFormat(dMaxC,2) & sep & pFormat(dAccu,2) & sep & pFormat(dTotal,2)
					objOpenFile.WriteLine sStr

					dSubMaxc = dSubMaxc + dMaxc
					dSubSumClaim = dSubSumClaim + dAccu
					dSubTotal = dSubTotal + dTotal
			rstMSTrns.movenext
			record = record + 1
			loop
			
		end if
		call pCloseTables(rstMSTrns)	
		
		Set rstMSTrns = server.CreateObject("ADODB.RecordSet")    
		sSQL = "SELECT EMP_CODE, EMP_NAME, ENTITLEMENT,MAXC, SUM(MAXC) AS SUMMAXC, SUM(CLAIMA) AS SUMCLAIM, PANELC, MSPANELC.PANELNAME "
		sSQL = sSQL & "FROM MSSTAFFC LEFT JOIN MSPANELC ON MSSTAFFC.PANELC = MSPANELC.PANELCODE "
        if sDtType  = "CL" then
		    sSQL = sSQL & "WHERE MID(DT_CLAIM,1,10) BETWEEN '" & Mid(fdatetime2(dtFrCDate),1,10) & "' AND '" & Mid(fdatetime2(dtToCDate),1,10) & "' "
		else    
            sSQL = sSQL & "WHERE MID(DT_ATTEND,1,10) BETWEEN '" & Mid(fdatetime2(dtFrADate),1,10) & "' AND '" & Mid(fdatetime2(dtToADate),1,10) & "' "
	    end if	

		if sEmp_ID <> "" then
			sSQL = sSQL & "AND EMP_CODE ='" & pRTIN(sEmp_ID) & "'"
		end if
		
		if sEnType <> "" then
			sSQL = sSQL & "AND ENTITLEMENT ='" & pRTIN(sEnType) & "'"
		end if
		
		if sInsertType <> "" then
			sSQL = sSQL & "AND TYPE ='" & pRTIN(sInsertType) & "'"
		end if
		
		if sPanelCode <> "" then
			sSQL = sSQL & "AND PANELC ='" & pRTIN(sPanelCode) & "'"
		end if

		sSQL = sSQL & "ORDER BY EMP_CODE ASC "
		rstMSTrns.Open sSQL, conn, 3, 3
		
	   if not rstMSTrns.eof then
								  
			do while not rstMSTrns.eof
			
			dTotClaimA = rstMSTrns("SUMCLAIM")
				
			rstMSTrns.movenext
			loop

			sStr = sep & sep & sep & sep & sep & sep
			objOpenFile.WriteLine sStr
			
			sTemp1 = "Grand Total : "
			sTotal = sep & sep & sep & sep & sep & sTemp1 & sep & pFormat(dGMClaim,2) & sep & pFormat(dTotClaimA,2) & sep & pFormat(dGTot,2)
			objOpenFile.WriteLine sTotal
		end if
		call pCloseTables(rstMSTrns)
		
elseif sType = "EX" then

	Set rstMSExcept = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT MSEXCEPT.EMP_CODE, MSEXCEPT.EMP_NAME, MSEXCEPT.ENTITLEMENT, MSEXCEPT.DT_CLAIM, MSEXCEPT.DT_ATTEND, MSEXCEPT.REMARK, "
	sSQL = sSQL & "MSEXCEPT.CLAIMA, MSEXCEPT.REFNO, MSEXCEPT.PANELC, MSPANELC.PANELNAME "
	sSQL = sSQL & "FROM MSEXCEPT left join MSPANELC on MSEXCEPT.PANELC = MSPANELC.PANELCODE "
	sSQL = sSQL & "WHERE MID(MSEXCEPT.DT_CREATE,1,10) BETWEEN '" & Mid(fDate2(dtFrADate),1,10) & "' AND '" & Mid(fDate2(dtToADate),1,10) & "' "
	sSQL = sSQL & " and IMP_TYPE = '" & sImpType & "' "
	sSQL = sSQL & "ORDER BY EMP_NAME ASC"
	rstMSExcept.Open sSQL, conn, 3, 3
	if not rstMSExcept.EOF then
		i = 0
		
		sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Entitlement Type") & sep & fCol("Claim Date") & sep & fCol("Attend Date") & sep & fCol("Reference No") & sep & fCol("Panel Clinic") & sep & fCol("Claim Amount")
		objOpenFile.WriteLine sStr
							  
		do while not rstMSExcept.eof
		
			sPanelName = ""

			if rstMSExcept("PANELC") = "NPC" then
				sPanelName = Ucase(rstMSExcept("REMARK"))
			else
				sPanelName = Ucase(rstMSExcept("PANELNAME"))
			end if
			
			if rstMSExcept("PANELC") = "NPC" and sImpType = "IC" then
				sPanelName = Ucase(rstMSExcept("REMARK"))
			elseif rstMSExcept("PANELC") = "NPC" and sImpType = "CH" then
				sPanelName = Ucase(rstMSExcept("PANELNAME"))
			else
				sPanelName = Ucase(rstMSExcept("PANELNAME"))
			end if
			
			i = i + 1
			sEmpCode = rstMSExcept("EMP_CODE")
			sEmp_Name = rstMSExcept("EMP_NAME")
			sEnType = rstMSExcept("ENTITLEMENT")
			dtClaim = rstMSExcept("DT_CLAIM")
			dtAttend = rstMSExcept("DT_ATTEND")
			sRefNo = rstMSExcept("REFNO")
			dClaimA = rstMSExcept("CLAIMA")				
				
			sStr = i & sep & sEmpCode & sep & sEmp_Name & sep & sEnType & sep & dtClaim	& sep & dtAttend & sep & sRefNo & sep & sPanelName	& sep & pFormat(dClaimA,2)		
			objOpenFile.WriteLine sStr
			
		rstMSExcept.movenext
		loop
	end if
	call pCloseTables(rstMSExcept)
		
end if


objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>