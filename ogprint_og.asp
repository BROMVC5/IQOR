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
			response.write "<td width=100 align=left>  Report : Outgoing Goods Report</td>"
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
			response.write "<td align=left width='10%'>Ticket</td>"
			response.write "<td align=left width='20%'>Serial / Part No</td>"
			response.write "<td align=left width='25%'>Property Description</td>"
			response.write "<td align=right width='5%'>Qty</td>"
			response.write "<td align=right width='5%'>R.Qty</td>"
			response.write "<td align=right width='2%'></td>"
			response.write "<td align=left width='8%'>Date Created</td>"
			response.write "<td align=left width='7%'>Ori. Date</td>"
			response.write "<td align=right width='7%'>Due Date</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=9 align=left bgcolor='white'>"
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
	
	record = 0
	do while not rstOGProp.eof
	
		response.write "<tr valign=top>"
		response.write "<td>" & rstOGProp("TICKET_NO") & "</td>"
		response.write "<td>" & rstOGProp("SERIAL") & "</td>"
		response.write "<td>" & rstOGProp("PART") & "</td>"
		response.write "<td align=right>" & pFormatDash(rstOGProp("QTY"),2) & "</td>"
		response.write "<td align=right>" & pFormatDash(rstOGProp("RQTY"),2) & "</td>"
		response.write "<td></td>"
		response.write "<td>" & fDateLong(rstOGProp("DT_CREATE")) & "</td>"
		response.write "<td>" & fDateLong(rstOGProp("ORI_DUE")) & "</td>"
		response.write "<td align=right>" & fDateLong(rstOGProp("DT_DUE")) & "</td>"
		response.write "</tr>"
			
	rstOGProp.movenext
	if sPageBreak = "Y" then
		record = record + 1
		if record >= 55 and not rstOGProp.eof then
		
			response.write "</table>"
			record = 0
			response.write "<br/>"
			response.Write "Continue Next Page..."    
			response.write "<p style='page-break-before: always'></p>"
			call pageHeader()
		end if
	end if
	loop		
	call pCloseTables(rstOGProp)
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


