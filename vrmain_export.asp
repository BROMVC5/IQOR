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
sCompID = request("txtComp_Name")
sStatus = request("sStatus")
	    
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
if sType = "CP" then	
	sFileName = "CompanyM_" & sDtTime & ".xls"
end if
	
sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
				
if sType = "CP" then
	
	Set rstVRMain = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT COMPNAME, ADD1, ADD2, CITY, POST, TEL, STATUS "
	sSQL = sSQL & "FROM VRCOMP "
	sSQL = sSQL & "where 1=1 "
	
	if sCompID <> "" then
		sSQL = sSQL & "AND COMPNAME ='" & pRTIN(sCompID) & "'"
	end if
	
	if sStatus <> "" then
		sSQL = sSQL & " AND STATUS ='" & pRTIN(sStatus) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY COMPNAME ASC "
	rstVRMain.Open sSQL, conn, 3, 3
		if not rstVRMain.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("Company Name") & sep & fCol("Address") & sep & fCol("Tel") & sep & fCol("Status")
			objOpenFile.WriteLine sStr
								  
			do while not rstVRMain.eof
				
				i = i + 1
				sEmpCode = rstVRMain("COMPNAME")
				sAdd = rstVRMain("ADD1") & " " & rstVRMain("ADD2") & " " &rstVRMain("CITY") & " " & rstVRMain("POST") 
				sTel = rstVRMain("TEL")
				if rstVRMain("STATUS") = "Y" then
               		sStatus = "Active"
                else
                	sStatus = "Inactive"
				end if				
					
				sStr = i & sep & sEmpCode & sep & sAdd & sep & sTel & sep & sStatus	
				objOpenFile.WriteLine sStr
				
			rstVRMain.movenext
			loop
		end if
		call pCloseTables(rstVRMain)
		
end if


objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>