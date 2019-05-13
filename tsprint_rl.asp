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

sAreaCode = request("txtAreaCode")
sPageBreak = request("cboPageBreak")
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=800 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Route Listing Report</td>"
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
			response.write "<td align=left width=5>Area Code</td>"
			response.write "<td align=left width=54>Area</td>"
			response.write "<td align=left width=128>Route</td>"
			response.write "<td align=right width=10>Status</td>"
			response.write "</tr>"
			response.write "<tr>"
			response.write "<td colspan=7 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			response.write "</td>"
		response.write "</tr>"
		
	response.write "</table>"
		
	response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail'>"
	
	response.write "<tr>"
		response.write "<td>"
		response.write "Area Code : "& sAreaCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "<br/>"
		response.write "<br/>"
		response.write "</td>"
	response.write "</tr>"
		
	response.write "</table>"
	response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail' style='table-layout: fixed;'>"
end sub
%>


</head>
<body>
<center>
<%

 call pageHeader()
 
%>

<%
Set rstTSArea = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from tsarea where 1=1 "
if sAreaCode <> "" then
	sSQL = sSQL & "AND AREACODE ='" & pRTIN(sAreaCode) & "'"
end if
			
sSQL = sSQL & "order by STATUS,AREACODE asc "
rstTSArea.Open sSQL, conn, 3, 3
if not rstTSArea.eof then

	record = 0
	do while not rstTSArea.eof
	
		response.write "<tr valign=top>"
		response.write "<td align=left width=10>" & rstTSArea("AREACODE") & "</td>"
		response.write "<td align=left width=20>" & rstTSArea("AREA") & "</td>"
		response.write "<td align=justify width=50>" & rstTSArea("ROUTE") & "</td>"
		if rstTSArea("STATUS") = "A" then
			response.write "<td align=right width=10>Active</td>"
		else
			response.write "<td align=right width=10>Inactive</td>"
		end if
		response.write "</tr>"
		response.write "<tr valign=top>"
			response.write "<td><br></td>"
			response.write "</tr>"

	rstTSArea.movenext
	if sPageBreak = "Y" then
		record = record + 3
		if record >= 67 and not rstTSArea.eof then
		
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
	call pCloseTables(rstTSArea)
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


