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

sFileName = "Holiday_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "where (dt_hol like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (part like '%" & ScStr & "%') "
    end if

    sql = "select dt_hol, part from tmhol "
    if sql_1 <> "" then
	    sql = sql & sql_1
    end if 
    sql = sql & "order by autoinc asc "

    set rstTMHol = server.createobject("adodb.recordset")
    rstTMHol.Open sql, conn, 3, 3
	if not rstTMHol.eof then

	    sStr = fCol("No") & sep & fCol("Holiday Date") & sep & fCol("Description")  
	    objOpenFile.WriteLine sStr
		
		do while not rstTMHol.eof
            sRecord = sRecord + 1
		    sStr = sRecord & sep & rstTMHol("DT_HOL") & sep & rstTMHol("PART") 
		    objOpenFile.WriteLine sStr
				
		rstTMHol.movenext
    	loop
			
	end if
	call pCloseTables(rstTMHol)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>