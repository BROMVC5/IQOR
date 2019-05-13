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
			response.write "<td width=100 align=left>  Report : Outgoing Log File</td>"
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
			response.write "<td colspan=4 align=left bgcolor='white'>"
				response.write "<hr class='side' size=1 noshade style='margin-top: 10px;margin-bottom: 0px;'>"
			response.write "</td>"
		response.write "</tr>"	
		response.write "<tr>"
			response.write "<td width='10%'>User ID</td>"
			response.write "<td width='10%'>Date Time</td>"
			response.write "<td width='5%'>Type</td>"
			response.write "<td width='70%'>Remark</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=4 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			response.write "</td>"
		response.write "</tr>"
		
	'response.write "</table>"
		
	'response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail'>"
	
	response.write "<tr>"
		response.write "<td colspan=4>"
		response.write "From Date : "& dtFrDate &"  To "& dtToDate &" "
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
Set rstOGLog = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from oglog "
sSQL = sSQL & "where MID(DATETIME,1,10) BETWEEN '" & MID(fDate2(dtFrDate),1,10) & "' AND '" & MID(fDate2(dtToDate),1,10) & "' "
sSQL = sSQL & "order by autoinc asc "
rstOGLog.Open sSQL, conn, 3, 3
if not rstOGLog.eof then
	
	record = 0
	do while not rstOGLog.eof
	
		response.write "<tr valign=top>"
		response.write "<td>" & rstOGLog("USER_ID") & "</td>"
		response.write "<td>" & fDateLong(rstOGLog("DATETIME")) & "</td>"
		response.write "<td>" & rstOGLog("TYPE") & "</td>"
		response.write "<td>" & rstOGLog("REMARK") & "</td>"
		response.write "</tr>"
			
	rstOGLog.movenext
	if sPageBreak = "Y" then
		record = record + 1
		if record >= 44 and not rstOGLog.eof then
		
			response.write "</table>"
			record = 0
			response.write "<br/>"
			response.Write "Continue Next Page..."    
			response.write "<p style='page-break-before: always'></p>"
			call pageHeader()
		end if
	end if
	loop		
	call pCloseTables(rstOGLog)
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


