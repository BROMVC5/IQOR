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
sEmp_ID = request("txtEmp_ID")
sEmpName = request("txtEmp_Name")
sDept_ID = request("txtDept_ID")
	    
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
if sType = "CE" then	
	sFileName = "CarRegis_" & sDtTime & ".xls"
end if
	
sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
				
if sType = "CE" then
	
	Set rstCPMain = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT CPREG.EMP_CODE, TMEMPLY.NAME, CPREG.DEPT_ID, CPREG.EXT_NO, CPREG.TEL, CPREG.CAR_NO "
	sSQL = sSQL & "FROM CPREG LEFT JOIN TMEMPLY ON CPREG.EMP_CODE = TMEMPLY.EMP_CODE "
	sSQL = sSQL & "where 1=1 "
	
	if sEmp_ID <> "" then
		sSQL = sSQL & "AND CPREG.EMP_CODE ='" & pRTIN(sEmp_ID) & "'"
	end if
	
	if sEmpName <> "" then
		sSQL = sSQL & " AND TMEMPLY.NAME LIKE '%" & pRTIN(sEmpName) & "%'"
	end if
	
	if sDept_ID <> "" then
		sSQL = sSQL & " AND CPREG.DEPT_ID ='" & pRTIN(sDept_ID) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY EMP_CODE ASC "
	rstCPMain.Open sSQL, conn, 3, 3
		if not rstCPMain.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Department ID") & sep & fCol("Ext No")	& sep & fCol("Tel") & sep & fCol("Vehicle No")
			objOpenFile.WriteLine sStr
								  
			do while not rstCPMain.eof
				
				i = i + 1
				sEmpCode = rstCPMain("EMP_CODE")
				sEmp_Name = rstCPMain("NAME")
				sDept_ID = rstCPMain("DEPT_ID")
				sExt_No = rstCPMain("EXT_NO")
				sTel = rstCPMain("TEL")
				sCar = rstCPMain("CAR_NO")				
					
				sStr = i & sep & sEmpCode & sep & sEmp_Name & sep & sDept_ID & sep & sExt_No	& sep & sTel & sep & sCar	
				objOpenFile.WriteLine sStr
				
			rstCPMain.movenext
			loop
		end if
		call pCloseTables(rstCPMain)
		
end if


objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>