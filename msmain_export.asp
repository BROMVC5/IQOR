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
sEnType = request("txtEn_Name")
sStatus = request("sStatus")
sGrade_ID = request("txtGrade_ID")
sDesign = request ("txtDesig")
sEmp_ID = request("txtEmp_ID")
sEmpName = request("txtEmp_Name")
sPanelCode = request("txtPanelCode")
	    
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
if sType = "ET" then	
	sFileName = "EntitlementT_" & sDtTime & ".xls"
elseif sType = "EN" then 
	sFileName = "Entitlement_" & sDtTime & ".xls"
elseif sType = "FM" then 
	sFileName = "Family_" & sDtTime & ".xls"
elseif sType = "PC" then 
	sFileName = "PanelC_" & sDtTime & ".xls"
end if
	
sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
				
if sType = "ET" then
	
	Set rstMSMain = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT ENTITLEMENT, STATUS "
	sSQL = sSQL & "FROM MSENTYPE "
	sSQL = sSQL & "where 1=1 "
	
	if sEnType <> "" then
		sSQL = sSQL & "AND ENTITLEMENT ='" & pRTIN(sEnType) & "'"
	end if
	
	if sStatus <> "" then
		sSQL = sSQL & " AND STATUS ='" & pRTIN(sStatus) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY ENTITLEMENT ASC "
	rstMSMain.Open sSQL, conn, 3, 3
		if not rstMSMain.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("Entitlement Type") & sep & fCol("Status")
			objOpenFile.WriteLine sStr
								  
			do while not rstMSMain.eof
				
				i = i + 1
				sEnType = rstMSMain("ENTITLEMENT")
				if rstMSMain("STATUS") = "Y" then
               		sStatus = "Active"
                else
                	sStatus = "Inactive"
				end if				
					
				sStr = i & sep & sEnType & sep & sStatus
				objOpenFile.WriteLine sStr
				
			rstMSMain.movenext
			loop
		end if
	call pCloseTables(rstMSMain)
		
elseif sType = "EN" then

	Set rstMSMain = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT ENTITLEMENT, MAXC, GRADE_ID, DESIG, STATUS, REMARK  "
	sSQL = sSQL & "FROM MSEN "
	sSQL = sSQL & "where 1=1 "
	
	if sEnType <> "" then
		sSQL = sSQL & "AND ENTITLEMENT ='" & pRTIN(sEnType) & "'"
	end if
	
	if sGrade_ID <> "" then
		sSQL = sSQL & "AND GRADE_ID ='" & pRTIN(sGrade_ID) & "'"
	end if
	
	if sDesign <> "" then
		sSQL = sSQL & "AND DESIG ='" & pRTIN(sDesign) & "'"
	end if
	
	if sStatus <> "" then
		sSQL = sSQL & " AND STATUS ='" & pRTIN(sStatus) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY ENTITLEMENT ASC "
	rstMSMain.Open sSQL, conn, 3, 3
		if not rstMSMain.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("Entitlement Type") & sep & fCol("Grade Code") & sep & fCol("Designation") & sep & fCol("Max Claim") & sep & fCol("Remark") & sep & fCol("Status")
			objOpenFile.WriteLine sStr
								  
			do while not rstMSMain.eof
				
				i = i + 1
				sEnType = rstMSMain("ENTITLEMENT")
				sGrade_ID = rstMSMain("GRADE_ID")
				sDesign = rstMSMain("DESIG")
				dMaxC = rstMSMain("MAXC")
				sRemark = rstMSMain("REMARK")
				if rstMSMain("STATUS") = "Y" then
               		sStatus = "Active"
                else
                	sStatus = "Inactive"
				end if				
					
				sStr = i & sep & sEnType & sep & sGrade_ID & sep & sDesign & sep & dMaxC & sep & sRemark  & sep & sStatus 
				objOpenFile.WriteLine sStr
				
			rstMSMain.movenext
			loop
		end if
	call pCloseTables(rstMSMain)

elseif sType = "FM" then
	Set rstMSMain = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT EMP_CODE, EMP_NAME, NAME, RELATION, DT_RESIGN, STATUS "
	sSQL = sSQL & "FROM MSFAMILY "
	sSQL = sSQL & "where 1=1 "
	
	if sEmp_ID <> "" then
		sSQL = sSQL & "AND EMP_CODE ='" & pRTIN(sEmp_ID) & "'"
	end if
	
	if sEmpName <> "" then
		sSQL = sSQL & " AND EMP_NAME like '" & pRTIN(sEmpName) & "%'"
	end if
	
	if sStatus <> "" then
		sSQL = sSQL & " AND STATUS ='" & pRTIN(sStatus) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY EMP_CODE ASC "
	rstMSMain.Open sSQL, conn, 3, 3
		if not rstMSMain.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Relation") & sep & fCol("Name") & sep & fCol("Resign Date") & sep & fCol("Status") 
			objOpenFile.WriteLine sStr
								  
			do while not rstMSMain.eof
				
				i = i + 1
				sEmp_ID = rstMSMain("EMP_CODE")
				sEmpName = rstMSMain("EMP_NAME")
				if rstMSMain("RELATION") = "S" then
               		sRelation = "Spouse"
                else
                	sRelation = "Child"
				end if	
				sName = rstMSMain("NAME")
				dtResign = rstMSMain("DT_RESIGN")
				if rstMSMain("STATUS") = "Y" then
               		sStatus = "Active"
                else
                	sStatus = "Inactive"
				end if				
					
				sStr = i & sep & sEmp_ID & sep & sEmpName & sep & sRelation & sep & sName & sep & dtResign & sep & sStatus
				objOpenFile.WriteLine sStr
				
			rstMSMain.movenext
			loop
		end if
	call pCloseTables(rstMSMain)
	
elseif sType = "PC" then
	Set rstMSMain = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT PANELCODE, PANELNAME, ADD1, ADD2, ADD3, ADD4, TEL, STATUS "
	sSQL = sSQL & "FROM MSPANELC "
	sSQL = sSQL & "WHERE 1=1 "
	
	if sPanelCode <> "" then
		sSQL = sSQL & " AND PANELCODE ='" & pRTIN(sPanelCode) & "'"
	end if
	
	if sStatus <> "" then
		sSQL = sSQL & " AND STATUS ='" & pRTIN(sStatus) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY PANELCODE ASC "
	rstMSMain.Open sSQL, conn, 3, 3
		if not rstMSMain.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("Panel Clinic Code") & sep & fCol("Panel Clinic Name") & sep & fCol("Address") & sep & fCol("Tel") & sep & fCol("Status")
			objOpenFile.WriteLine sStr
								  
			do while not rstMSMain.eof
				
				i = i + 1
				sPanelCode = rstMSMain("PANELCODE")
				sPanelName = rstMSMain("PANELNAME")
				sAdd = rstMSMain("ADD1") & " " & rstMSMain("ADD2") & " " & rstMSMain("ADD3") & " " & rstMSMain("ADD4")
				sTel = rstMSMain("TEL")
				if rstMSMain("STATUS") = "Y" then
               		sStatus = "Active"
                else
                	sStatus = "Inactive"
				end if				
					
				sStr = i & sep & sPanelCode & sep & sPanelName & sep & sAdd & sep & sTel & sep & sStatus
				objOpenFile.WriteLine sStr
				
			rstMSMain.movenext
			loop
		end if
	call pCloseTables(rstMSMain)
end if


objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>