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

sFileName = "EOFF_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    iPage = request("page")
    sOrderBy = trim(request("txtOrderBy"))
    sAscDesc = trim(request("txtAscDesc"))     
    sEMP_CODE = UCase(request("txtEMP_CODE"))
    dtpFrDate = request("dtpFrDate")
    dtpToDate = request("dtpToDate")
    sTOff_ID = request("txtTOff_ID")

    if sEMP_CODE <> "" then
        sSQL_1 = " and ( tmeoff.EMP_CODE = '" & sEMP_CODE & "') "
    end if

    if dtpFrDate <> "" then 
        sSQL_1 = sSQL_1 & " and DTFR >= '" & fdate2(dtpFrDate) & "' and DTTO <='" & fdate2(dtpToDate) & "'"
    end if

    if sTOff_ID <> "" then 
        sSQL_1 = sSQL_1 & " and TOFF_ID = '" & sTOff_ID & "'"
    end if

    sSQL = "select tmemply.EMP_CODE, tmemply.NAME, TMEOFF.*"
    sSQL = sSQL & " from TMEMPLY left join TMEOFF"
    sSQL = sSQL & " on tmemply.EMP_CODE = tmeoff.EMP_CODE" 
    sSQL = sSQL & " where not isnull(DTFR)"
    if sSQL_1 <> "" then
	    sSQL = sSQL & sSQL_1
    end if 

    if sOrderBy = "undefined"  then
        sSQL = sSQL & " order by tmeoff.EMP_CODE  asc"
    else
        if sAscDesc = "Asc" then
            sSQL = sSQL & " order by " & sOrderBy & " asc "
        elseif sAscDesc = "Desc" then
            sSQL = sSQL & " order by " & sOrderBy & " desc"
        end if
    end if
    
    response.write sSQL

    set rstTMEOff = server.createobject("adodb.recordset")
    rstTMEOff.Open sSQL, conn, 3, 3
	if not rstTMEOff.eof then
    
	    sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Date From") & sep & fCol("Date To") & sep & fCol("Duration") & sep
        sStr = sStr & fCol("Time Off ID") & sep & fCol("Description") & sep & fCol("Paid") & sep  
        sStr = sStr  & fCol("Remark") 
        objOpenFile.WriteLine sStr
		
		do while not rstTMEOff.eof
            sRecord = sRecord + 1
		    sStr = sRecord & sep & rstTMEOff("EMP_CODE") & sep & rstTMEOff("DTFR") & sep & rstTMEOff("DTTO") & sep & rstTMEOff("DURA") & sep
		    sStr = sStr & rstTMEOff("TOFF_ID") & sep & rstTMEOff("PART") & sep & rstTMEOff("PAID") & sep 
        	sStr = sStr & rstTMEOff("REMARK") 
            objOpenFile.WriteLine sStr
				
		rstTMEOff.movenext
    	loop
			
	end if
	call pCloseTables(rstTMEOff)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>