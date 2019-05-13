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

dtDate = request("dtDate")
sPageBreak = request("cboPageBreak")
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=800 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Overdue Report</td>"
			response.write "<td width=300 align=center><STRONG style='font-weight: 400'>OUTGOING GOODS PASS SYSTEM</STRONG></td>"
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
			response.write "<td colspan=9 align=left bgcolor='white'>"
				response.write "<hr class='side' size=1 noshade style='margin-top: 10px;margin-bottom: 0px;'>"
			response.write "</td>"
		response.write "</tr>"	
		response.write "<tr>"
			response.write "<td align=left width='8%'>Ticket</td>"
			response.write "<td align=left width='20%'>Serial / Part No</td>"
			response.write "<td align=left width='25%'>Property Description</td>"
			response.write "<td align=right width='5%'>Qty</td>"
			response.write "<td align=right width='5%'>R.Qty</td>"
			response.write "<td align=right width='2%'></td>"
			response.write "<td align=left width='7%'>Ori. Date</td>"
			response.write "<td align=left width='7%'>Due Date</td>"
			response.write "<td align=right width='6%'>OD Days</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=9 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			response.write "</td>"
		response.write "</tr>"
		
	'response.write "</table>"
		
	'response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail'>"
	
	response.write "<tr>"
		response.write "<td colspan=9>"
		response.write "Date : "& dtDate &" "
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
Set rstOGProp1 = server.CreateObject("ADODB.RecordSet")    
sSQL = "select ogprop.STATUS,ogprop.SSTATUS,ogprop2.RQTY,ogprop1.* from ogprop1 "
sSQL = sSQL & "left join ogprop on ogprop1.TICKET_NO = ogprop.TICKET_NO "
sSQL = sSQL & "left join ogprop2 on ogprop1.AUTOINC = ogprop2.ITEMINC "
sSQL = sSQL & "where ogprop1.BAL <> '0' and DT_DUE < '"& fDate2(dtDate) & "' "
sSQL = sSQL & "and STATUS = 'A' and SSTATUS = 'A' "
rstOGProp1.Open sSQL, conn, 3, 3
if not rstOGProp1.eof then
	
	record = 0
	do while not rstOGProp1.eof
		sDueDay = DATEDIFF("d",rstOGProp1("DT_DUE"),fDate2(dtDate))
		
		response.write "<tr valign=top>"
		response.write "<td>" & rstOGProp1("TICKET_NO") & "</td>"
		response.write "<td>" & rstOGProp1("SERIAL") & "</td>"
		response.write "<td>" & rstOGProp1("PART") & "</td>"
		response.write "<td align=right width=10>" & pFormatDash(rstOGProp1("QTY"),2) & "</td>"
		response.write "<td align=right width=10>" & pFormatDash(rstOGProp1("RQTY"),2) & "</td>"
		response.write "<td></td>"
		response.write "<td>" & fDateLong(rstOGProp1("ORI_DUE")) & "</td>"
		response.write "<td>" & fDateLong(rstOGProp1("DT_DUE")) & "</td>"
		response.write "<td align=right>" & sDueDay & "</td>"
		response.write "</tr>"
			
	rstOGProp1.movenext
	if sPageBreak = "Y" then
		record = record + 1
		if record >= 55 and not rstOGProp1.eof then
		
			response.write "</table>"
			record = 0
			response.write "<br/>"
			response.Write "Continue Next Page..."    
			response.write "<p style='page-break-before: always'></p>"
			call pageHeader()
		end if
	end if
	loop		
	call pCloseTables(rstOGProp1)
	response.write "</table>"
end if


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


