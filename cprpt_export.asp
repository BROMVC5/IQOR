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
dtFrDate = request("dtFrDate")
dtToDate = request("dtToDate")
sReq_Name = request("txtEmp_Name")
sTicket_No = request("txtTicket_No")
sLQty = request("txtLot_Qty")
	    
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
if sType = "PR" then	
	sFileName = "ParkR_" & sDtTime & ".xls"
end if
	
sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
				
if sType = "PR" then
	
	Set rstCPTrns = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select cpresv.ticket_no, cpresv.r_name, cpresv.car_no,cpresv.lot_qty , cpresv.d_in, cpresv.d_out, cpresv.t_in, cpresv.t_out, tmemply.name from cpresv "
	sSQL = sSQL & "left join tmemply on cpresv.emp_code = tmemply.emp_code "
	sSQL = sSQL & "WHERE MID(cpresv.DT_CREATE,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "
	
	if sReq_Name <> "" then
		sSQL = sSQL & "AND NAME like'%" & pRTIN(sReq_Name) & "%'"
	end if

	if sTicket_No <> "" then
		sSQL = sSQL & "AND TICKET_NO ='" & pRTIN(sTicket_No) & "'"
	end if

	if sLQty <> "" then
		sSQL = sSQL & "AND LOT_QTY ='" & pRTIN(sLQty) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY cpresv.AUTOINC ASC "
	response.write(sSQL)
	rstCPTrns.Open sSQL, conn, 3, 3
		if not rstCPTrns.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("Ticket No") & sep & fCol("Reserve For") & sep & fCol("Vehicle No") & sep & fCol("Lot Quantity")	& sep & fCol("Date From") & sep & fCol("Date To") & sep & fCol("Requestor Name")
			objOpenFile.WriteLine sStr
								  
			do while not rstCPTrns.eof
				
				i = i + 1
				sTicket_No = rstCPTrns("TICKET_NO")
				sReq_Name = rstCPTrns("R_NAME")
				sCarNo = rstCPTrns("CAR_NO")
				sLQty = rstCPTrns("LOT_QTY")
				dt_In = rstCPTrns("D_IN")
				dt_Out = rstCPTrns("D_OUT")
				sName = rstCPTrns("NAME")			
					
				sStr = i & sep & sTicket_No & sep & sReq_Name & sep & sCarNo & sep & sLQty & sep & dt_In & sep & dt_Out & sep & sName
				objOpenFile.WriteLine sStr
				
			rstCPTrns.movenext
			loop
		end if
		call pCloseTables(rstCPTrns)	
		
end if


objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>