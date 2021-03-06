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

sFileName = "HolCal_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "where (hol_id like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (name like '%" & ScStr & "%') "
    end if

    sql = "select hol_id, name, dt_hol, part from tmhol1 "
    if sql_1 <> "" then
	    sql = sql & sql_1
    end if 
    sql = sql & "order by autoinc asc "

    set rstTMHolCal = server.createobject("adodb.recordset")
    rstTMHolCal.Open sql, conn, 3, 3
	if not rstTMHolCal.eof then
    
	    sStr = fCol("No") & sep & fCol("Holiday Group Code") & sep & fCol("Name") & sep
        sStr = sStr & fCol("Holiday Date") & sep & fCol("Description")  
	    objOpenFile.WriteLine sStr
		
		do while not rstTMHolCal.eof
            sRecord = sRecord + 1
		    sStr = sRecord & sep & rstTMHolCal("HOL_ID") & sep & rstTMHolCal("NAME") & sep & rstTMHolCal("DT_HOL") & sep & rstTMHolCal("PART") 
		    objOpenFile.WriteLine sStr
				
		rstTMHolCal.movenext
    	loop
			
	end if
	call pCloseTables(rstTMHolCal)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>