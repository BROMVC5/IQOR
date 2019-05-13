<!-- #include file="include/connection.asp" -->
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

sFileName = "WorkGrp_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sSQL_1 = "where (workgrp_id like '%" & ScStr & "%') "
  	sSQL_1 = sSQL_1 & " or (part like '%" & ScStr & "%') "
    end if

    sSQL = "select workgrp_id, part, HOL_ID, tmworkgrp.EMP_CODE, tmemply.NAME from tmworkgrp "
    sSQL = sSQL & " left join tmemply on tmworkgrp.emp_code = tmemply.emp_code "
    if sSQL_1 <> "" then
	    sSQL = sSQL & sSQL_1
    end if 
    sSQL = sSQL & "order by workgrp_id"
    'response.write sSQL
    set rstTMWORKGRP = server.createobject("adodb.recordset")
    rstTMWORKGRP.Open sSQL, conn, 3, 3
	if not rstTMWORKGRP.eof then
    
	    sStr = fCol("No") & sep & fCol("Work Group") & sep & fCol("Description") & sep 
        sStr = sStr & fCol("Holiday Calendar") & sep & fCol("Employee Code") & sep & fCol("Name")
        objOpenFile.WriteLine sStr
		
		do while not rstTMWORKGRP.eof
            sRecord = sRecord + 1
		    sStr = sRecord & sep & rstTMWORKGRP("WORKGRP_ID") & sep & rstTMWORKGRP("PART") & sep 
            sStr = sStr & rstTMWORKGRP("HOL_ID") & sep & rstTMWORKGRP("EMP_CODE") & sep & rstTMWORKGRP("NAME") 
            objOpenFile.WriteLine sStr
				
		rstTMWORKGRP.movenext
    	loop
			
	end if
	call pCloseTables(rstTMWORKGRP)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>