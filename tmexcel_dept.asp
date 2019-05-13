﻿<!-- #include file="include/connection.asp" -->
<!-- #include file="include/validate.asp" -->
<!-- #include file="include/proc.asp" -->
<html>
<head>
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>
</head>
<body style="background-color: white">
<%

txtSearch = trim(request("txtSearch"))

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

sFileName = "Depart_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    txtSearch = trim(request("txtSearch"))
    if txtSearch <> "" then
	    ScStr = txtSearch
 	    ScStr = replace(ScStr,"'","''")
  	    sql_1 = "where (DEPT_ID like '%" & ScStr & "%') "
  	    sql_1 = sql_1 & " or (part like '%" & ScStr & "%') "
    end if

    sql = "select DEPT_ID, PART, DEPMAN_CODE from TMDEPT "
    if sql_1 <> "" then
	    sql = sql & sql_1
    end if 
    sql = sql & "order by autoinc asc"

    set rstTMDEPT = server.createobject("adodb.recordset")
    rstTMDEPT.Open sql, conn, 3, 3
	if not rstTMDEPT.eof then
    
	    sStr = fCol("No") & sep & fCol("Department Code") & sep & fCol("Description") & sep & fCol("Department Manager") & sep  
        objOpenFile.WriteLine sStr
		
		do while not rstTMDEPT.eof
            sRecord = sRecord + 1
		    sStr = sRecord & sep & rstTMDEPT("DEPT_ID") & sep & rstTMDEPT("PART") & sep & rstTMDEPT("DEPMAN_CODE") & sep  
            objOpenFile.WriteLine sStr
				
		rstTMDEPT.movenext
    	loop
			
	end if
	call pCloseTables(rstTMDEPT)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>