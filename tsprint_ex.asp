<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Print Report</title>

    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- DataTables -->
    <link rel="stylesheet" href="dist/css/dataTables.bootstrap.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
        folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <!-- REPORT CSS -->
    <!-- #include file="include/reportcss.asp" -->
    
<style type="text/css" media="print">
@page {
	
    margin-top: 3mm;
    margin-bottom: 0mm;
    margin-right: 10mm;
    margin-left: 10mm;
  

}
  html,body{
height:auto;
}

p.break { page-break-before: always; }

</style>


<%

dtFrDate = request("dtFrDate")
dtToDate = request("dtToDate")
sPageBreak = request("cboPageBreak")
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=800 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Exceptional Report</td>"
			response.write "<td width=300 align=center><STRONG style='font-weight: 400'>OT TRANSPORTATION SYSTEM</STRONG></td>"
			response.write "<td width=80 align=right>Date : "& fDateLong(Now()) &"</td>"
		response.write "</tr>"
		
		response.write "<tr>"
			response.write "<td width=50 align=left>Page : "& sPage &"</td>"
			response.write "<td align=center><STRONG style='font-weight: 400'>" & session("CONAME") & "</STRONG></td>"
			response.write "<td align=right> Time : "& ampmTime(Now()) &"</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td align=left bgcolor='white' width=250></td>"
			response.write "<td align=center bgcolor='white'></td>"
			response.write "<td align=right bgcolor='white' width=250></td>"
		response.write "</tr>"
	response.write "</table>"
	
	response.write "<table cellSpacing=0 cellpadding=0 width=800 >"
				
			response.write "<tr>"
			response.write "<td colspan=7 align=left bgcolor='white'>"
				response.write "<hr class='side' size=1 noshade style='margin-top: 10px;margin-bottom: 0px;'>"
			response.write "</td>"
			response.write "</tr>"	
			response.write "<tr>"
			response.write "<td>Ticket No</td>"
			response.write "<td>Date</td>"
			response.write "<td>Shift</td>"
			response.write "<td>Employee Code</td>"
			response.write "<td>Employee Name</td>"
			response.write "<td align='right'>Area Code</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=7 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			response.write "</td>"
		response.write "</tr>"
		
	'response.write "</table>"
		
	'response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail'>"
	
	response.write "<tr>"
		response.write "<td colspan=7>"
		response.write "From Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "<br/>"
		response.write "<br/>"
		response.write "</td>"
	response.write "</tr>"
		
	'response.write "</table>"
	'response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail' style='table-layout: fixed;'>"
end sub
%>


</head>
<body>
<center>
<%

 call pageHeader()
 
%>

<%	
Set rstTSTrns = server.CreateObject("ADODB.RecordSet")    
sSQL = "select tstrns.TICKET_NO, tstrns.DT_TRNS, tstrns.SHIFT, tstrns1.EMP_CODE, tmemply.AREACODE, tmemply.NAME from tstrns "
sSQL = sSQL & "left join tstrns1 on tstrns.TICKET_NO = tstrns1.TICKET_NO "
sSQL = sSQL & "left join tmemply on tstrns1.EMP_CODE = tmemply.EMP_CODE "
sSQL = sSQL & "left join tsexcept on tstrns.DT_TRNS = tsexcept.DT_EXCEPT "
sSQL = sSQL & "where MID(tsexcept.DT_EXCEPT,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "								
sSQL = sSQL & "order by TICKET_NO, tstrns1.EMP_CODE asc "
rstTSTrns.Open sSQL, conn, 3, 3
if not rstTSTrns.eof then
	record = 0
	sPrevDtDate = rstTSTrns("DT_TRNS")
	sPrevShift = rstTSTrns("SHIFT")
	bPrint = true
	
	do while not rstTSTrns.eof
			
		if rstTSTrns("DT_TRNS") <> sPrevDtDate or rstTSTrns("SHIFT") <> sPrevShift then
			record = record + 1
		 	sPrevDtDate = rstTSTrns("DT_TRNS")
		 	sPrevShift = rstTSTrns("SHIFT")
		 	response.write "<tr valign=top>"
			response.write "<td><br></td>"
			response.write "</tr>"
		 	bPrint = true
		end if
		
		response.write "<tr valign=top>"
		if bPrint = true then
			response.write "<td>" & rstTSTrns("TICKET_NO") & "</td>"
			response.write "<td>" & rstTSTrns("DT_TRNS") & "</td>"
			if rstTSTrns("SHIFT") = "M" then
			response.write "<td>Morning</td>"
			else
			response.write "<td>Night</td>"
			end if
			bPrint = false
		else
			response.write "<td></td>"
			response.write "<td></td>"
			response.write "<td></td>"
			
		end if
		
		response.write "<td>" & rstTSTrns("EMP_CODE") & "</td>"
		response.write "<td>" & rstTSTrns("NAME") & "</td>"
		response.write "<td align=right>" & rstTSTrns("AREACODE") & "</td>"
		response.write "</tr>"			
	
	rstTSTrns.movenext
	if sPageBreak = "Y" then
		record = record + 1
		if record >= 53 and not rstTSTrns.eof then
		
			response.write "</table>"
			record = 0
			response.write "<br/>"
			response.Write "Continue Next Page..."    
			response.write "<p style='page-break-before: always'></p>"
			response.write "<br/>"
			sPage = sPage + 1
			call pageHeader()
		end if
	end if						
	loop	
	
	response.write "</table>"	
				
end if
call pCloseTables(rstTSTrns)

%>

<table cellSpacing=0 cellpadding=0 width=800 class="fontrptdetail">
	
	<tr>
		<td colspan=5><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
	</tr>
	<tr>
		<td align=left>End of Report</td>
	</tr>
</table>
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
</center>
</body>


</html>


