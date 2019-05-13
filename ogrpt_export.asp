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
sDay = request("sDay")
dtDate = request("dtDate")
dtFrDate = request("dtFrDate")
dtToDate = request("dtToDate")


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
if sType = "AG" then
	sFileName = "OG_Aging_" & sDtTime & ".xls"
elseif sType = "OG" then
	sFileName = "OG_OGPList_" & sDtTime & ".xls"
elseif sType = "OD" then
	sFileName = "OG_Overdue_" & sDtTime & ".xls"
elseif sType = "LF" then
	sFileName = "OG_LogFile_" & sDtTime & ".xls"

end if

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
if sType = "AG" then

	dtFrDate = (DateAdd("d",-sDay,dtDate))
	Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select ogprop1.TICKET_NO,ogprop1.SERIAL, ogprop1.PART,ogprop1.ORI_DUE, ogprop1.DT_DUE,ogprop1.QTY,ogprop1.DT_CREATE,ogprop.TICKET_NO,ogprop.DT_OUT,ogprop.STATUS,ogprop.SSTATUS from ogprop "
	sSQL = sSQL & "left join ogprop1 on ogprop.TICKET_NO = ogprop1.TICKET_NO "
	sSQL = sSQL & "where MID(ogprop1.DT_CREATE,1,10) BETWEEN '" & MID(fDate2(dtFrDate),1,10) & "' AND '" & MID(fDate2(dtDate),1,10) & "' "
	sSQL = sSQL & "and STATUS = 'A' and SSTATUS = 'A' "
	sSQL = sSQL & "order by ogprop.TICKET_NO,ogprop1.SERIAL asc "
	rstOGProp.Open sSQL, conn, 3, 3
	if not rstOGProp.eof then
		sStr = fCol("Ticket No") & sep & fCol("Serial / Part No") & sep & fCol("Property Description") & sep & fCol("Quantity") & sep & fCol("Checkout") & sep & fCol("Original Date")  & sep & fCol("Due Date")			
		objOpenFile.WriteLine sStr
							  
		do while not rstOGProp.eof
										
			sStr = rstOGProp("TICKET_NO") & sep & rstOGProp("SERIAL") & sep & rstOGProp("PART")  & sep & rstOGProp("QTY") & sep & rstOGProp("DT_OUT") & sep &  fdatelong(rstOGProp("ORI_DUE"))  & sep &  fdatelong(rstOGProp("DT_DUE"))
			objOpenFile.WriteLine sStr
			
		rstOGProp.movenext
		loop
	end if
	call pCloseTables(rstOGProp)
	
elseif sType = "OG" then	

	Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select ogprop1.TICKET_NO,ogprop1.SERIAL,ogprop1.ORI_DUE, ogprop1.PART,ogprop1.DT_DUE,ogprop1.QTY,ogprop1.DT_CREATE,ogprop2.RQTY,ogprop.TICKET_NO,ogprop.EMP_CODE,ogprop.DT_OUT,ogprop.STATUS,ogprop.SSTATUS, "
	sSQL = sSQL & "tmemply.DEPT_ID,tmemply.GRADE_ID,tmemply.COST_ID,tmemply.CONT_ID from ogprop "
	sSQL = sSQL & "left join ogprop1 on ogprop.TICKET_NO = ogprop1.TICKET_NO "
	sSQL = sSQL & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
	sSQL = sSQL & "left join ogprop2 on ogprop1.AUTOINC = ogprop2.ITEMINC "
	sSQL = sSQL & "where MID(ogprop1.DT_CREATE,1,10) BETWEEN '" & MID(fDate2(dtFrDate),1,10) & "' AND '" & MID(fDate2(dtToDate),1,10) & "' "
	sSQL = sSQL & "and STATUS = 'A' and SSTATUS = 'A' "
	sSQL = sSQL & "order by ogprop.TICKET_NO,ogprop1.SERIAL asc "
	rstOGProp.Open sSQL, conn, 3, 3
	if not rstOGProp.eof then

		sStr = fCol("Ticket No") & sep & fCol("Serial / Part No") & sep & fCol("Property Description") & sep & fCol("Quantity") & sep & fCol("Returned Quantity") & sep & fCol("Date Created") & sep & fCol("Original Date")  & sep & fCol("Due Date")			
		objOpenFile.WriteLine sStr
	  
		do while not rstOGProp.eof
										
			sStr = rstOGProp("TICKET_NO") & sep & rstOGProp("SERIAL") & sep & rstOGProp("PART")  & sep & rstOGProp("QTY") & sep & rstOGProp("RQTY") & sep & rstOGProp("DT_OUT") & sep &  fdatelong(rstOGProp("ORI_DUE"))  & sep &  fdatelong(rstOGProp("DT_DUE"))
			objOpenFile.WriteLine sStr
			
		rstOGProp.movenext
		loop
	end if
	call pCloseTables(rstOGProp)

elseif sType = "OD" then

	Set rstOGProp1 = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select ogprop.STATUS,ogprop.SSTATUS,ogprop2.RQTY,ogprop1.* from ogprop1 "
	sSQL = sSQL & "left join ogprop on ogprop1.TICKET_NO = ogprop.TICKET_NO "
	sSQL = sSQL & "left join ogprop2 on ogprop1.AUTOINC = ogprop2.ITEMINC "
	sSQL = sSQL & "where ogprop1.BAL <> '0' and DT_DUE < '"& fDate2(dtDate) & "' "
	sSQL = sSQL & "and STATUS = 'A' and SSTATUS = 'A' "	
	rstOGProp1.Open sSQL, conn, 3, 3
	if not rstOGProp1.eof then
		sStr = fCol("Ticket No") & sep & fCol("Serial / Part No") & sep & fCol("Property Description") & sep & fCol("Quantity") & sep & fCol("Returned Quantity") & sep & fCol("Original Date")  & sep & fCol("Due Date") & sep & fCol("Overdue Days")			
		objOpenFile.WriteLine sStr

		do while not rstOGProp1.eof
			sDueDay = DATEDIFF("d",rstOGProp1("DT_DUE"),fDate2(dtDate))
										
			sStr = rstOGProp1("TICKET_NO") & sep & rstOGProp1("SERIAL") & sep & rstOGProp1("PART")  & sep & rstOGProp1("QTY") & sep & rstOGProp1("RQTY") & sep &  fdatelong(rstOGProp1("ORI_DUE"))  & sep &  fdatelong(rstOGProp1("DT_DUE")) & sep & sDueDay 
			objOpenFile.WriteLine sStr
			
		rstOGProp1.movenext
		loop
	end if
	call pCloseTables(rstOGProp1)
	
elseif sType = "LF" then
	
	Set rstOGLog = server.CreateObject("ADODB.RecordSet")
	sSQL = "select * from oglog "
	sSQL = sSQL & "where MID(DATETIME,1,10) BETWEEN '" & MID(fDate2(dtFrDate),1,10) & "' AND '" & MID(fDate2(dtToDate),1,10) & "' "
	sSQL = sSQL & "order by autoinc asc "
	rstOGLog.Open sSQL, conn, 3, 3
	if not rstOGLog.eof then
	
		sStr = fCol("User ID") & sep & fCol("Date Time") & sep & fCol("Type") & sep & fCol("Remark")
		objOpenFile.WriteLine sStr

		do while not rstOGLog.eof
										
			sStr = rstOGLog("USER_ID") & sep & rstOGLog("DATETIME") & sep & rstOGLog("TYPE")  & sep & rstOGLog("REMARK")
			objOpenFile.WriteLine sStr
			
		rstOGLog.movenext
		loop
	end if
	call pCloseTables(rstOGLog)


end if


objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>