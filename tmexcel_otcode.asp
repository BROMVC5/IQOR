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

sFileName = "OTCode_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "where (otcode like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (part like '%" & ScStr & "%') "
    end if

    sql = "select * from tmotcode "
    if sql_1 <> "" then
	    sql = sql & sql_1
    end if 
    sql = sql & "order by otcode asc "

    set rstTMOTCODE = server.createobject("adodb.recordset")
    rstTMOTCODE.Open sql, conn, 3, 3
	if not rstTMOTCODE.eof then
    
	    sStr = fCol("OT Code") & sep & fCol("Description") & sep 
        sStr = sStr & fCol("Min Daily Paid Overtime Hour") & sep & fCol("Max overtime hour per payroll period")  & sep & fCol("Normal Working Day Overtime ") & sep 
        sStr = sStr & fCol("Rest Day Overtime") & sep & fCol("Off Day Overtime")  & sep & fCol("Public Holiday Overtime")  & sep & fCol("Assigned Grade ID")  
        objOpenFile.WriteLine sStr
		
		do while not rstTMOTCODE.eof
            sStr = rstTMOTCODE("OTCODE") & sep & rstTMOTCODE("PART") & sep 
            sStr = sStr & rstTMOTCODE("MINOT") & sep & rstTMOTCODE("MAXOT") & sep & rstTMOTCODE("NORMAL") & sep 
            sStr = sStr & rstTMOTCODE("REST") & sep & rstTMOTCODE("OFF") & sep & rstTMOTCODE("PUBLIC") & sep & rstTMOTCODE("GRADE_ID") 
            objOpenFile.WriteLine sStr
				
		rstTMOTCODE.movenext
    	loop
			
	end if
	call pCloseTables(rstTMOTCODE)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>