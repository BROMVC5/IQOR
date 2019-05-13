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


<style>

    * {
      font-family:"Times New Roman";
      font-size:small;
    }
</style>

<%
Server.ScriptTimeout = 10000000

sLogin = session("USERNAME")

Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMEMPLY where "
sSQL = sSQL & " EMP_CODE ='" & sLogin & "'"  
rstTMEMPLY.Open sSQL, conn, 3, 3
if not rstTMEMPLY.eof then
    sAType = rstTMEMPLY("ATYPE")
end if 

dtFrDate = request("dtFrDate")
dtToDate = request("dtToDate")
sContID = request("txtContID")
sEmpCode = request("txtEmpCode")
sSupCode = request("txtSupCode")
sCostID = request("txtCostID")
sWorkGrpID = request("txtWorkGrpID")
sPageBreak = request("cboPageBreak")
sPage = 1

if sContID = "" then
    sContID = "ALL"
end if

if sEmpCode = "" then
    sEmpCode = "ALL"
end if

if sSupCode = "" then
    sSupCode = "ALL"
end if

if sCostID = "" then
    sCostID = "ALL"
end if

if sWorkGrpID = "" then
    sWorkGrpID = "ALL"
end if

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=800 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : DL Mid Month Advance</td>"
			response.write "<td width=300 align=center><STRONG style='font-weight: 400'>TIME MANAGEMENT SYSTEM</STRONG></td>"
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
	
	response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail' >"
				
		response.write "<tr class='spacing'>"
            response.write "<td colspan=12>&nbsp;</td>"
        response.write "</tr>"
		response.write "<tr class='topBotLine'>"
        	response.write "<td style='width:3%'>No</td>"
			response.write "<td style='width:7%'>Emp Code</td>"
			response.write "<td style='width:17%'>Employee Name</td>"
			response.write "<td style='width:17%'>Superior</td>"
            response.write "<td style='width:20%'>Work Group</td>"
			response.write "<td style='width:8%'>Contract</td>"
			response.write "<td style='width:16%'>Cost Center</td>"
            response.write "<td style='width:6%' align='right'>Tot Days</td>"
            response.write "<td style='width:6%' align='right'>Tot Amt</td>"
        response.write "</tr>"
	    response.write "<tr>"
		    response.write "<td colspan='10' align='left'>"
		    response.write "Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Contract : "& sContID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Employee Code : "& sEmpCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Superior : "& sSupCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Cost Center : "& sCostID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp"
      	    response.write "Work Group : "& sWorkGrpID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            response.write "<br/>"
		    response.write "<br/>"
		    response.write "</td>"
	    response.write "</tr>"
end sub
%>

</head>
<body>
<center>
<%

 call pageHeader()
 
%>

<%	
Set rstTMMIDMTH = server.CreateObject("ADODB.RecordSet")    
sSQL = " select tmmidmth.*, tmemply.CONT_ID, tmemply.COST_ID, tmcost.PART as COST_PART, tmworkgrp.WORKGRP_ID, tmworkgrp.part as WORKGRP_PART from TMMIDMTH "
sSQL = sSQL & " left join tmemply on tmmidmth.emp_code = tmemply.emp_code "
sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id "
sSQL = sSQL & " left join tmworkgrp on tmemply.emp_code = tmworkgrp.emp_code "
sSQL = sSQL & " where DTFR ='" & fdate2(dtFrDate) & "' and DTTO = '" & fdate2(dtToDate) & "'"
sSQL = sSQL & " and TOTDAYS <> '' " '=== I insert a file name as 1 record in the table, so the TOTDAYS = '', filter it out.  

if sContID <> "ALL" then
	sSQL = sSQL & " and tmemply.CONT_ID = '" & pRTIN(sContID) & "'"
end if

if sEmpCode <> "ALL" then
	sSQL = sSQL & " and tmmidmth.EMP_CODE = '" & pRTIN(sEmpCode) & "'"
end if
			
if sSupCode <> "ALL" then
	sSQL = sSQL & " and tmmidmth.SUP_CODE = '" & pRTIN(sSupCode) & "'"
end if

if sCostID <> "ALL" then
	sSQL = sSQL & " and tmemply.COST_ID = '" & pRTIN(sCostID) & "'"
end if	

if sWorkGrpID <> "ALL" then
	sSQL = sSQL & " and tmworkgrp.WORKGRP_ID = '" & pRTIN(sWorkGrpID) & "'"
end if	

sSQL = sSQL & " order by tmmidmth.EMP_CODE asc, tmmidmth.SUPNAME desc "

rstTMMIDMTH.Open sSQL, conn, 3, 3
if not rstTMMIDMTH.eof then
	record = 0
	
	do while not rstTMMIDMTH.eof
	    record = record + 1 
        count = count + 1   
      	response.write "<tr>"			
		response.write "<td>" & count & "</td>"
		response.write "<td>" & rstTMMIDMTH("EMP_CODE") & "</td>"
		response.write "<td>" & rstTMMIDMTH("NAME") & "</td>"
        response.write "<td>" & rstTMMIDMTH("SUPNAME") & "</td>"
        response.write "<td>" & rstTMMIDMTH("WORKGRP_ID") & "</td>"
        response.write "<td>" & rstTMMIDMTH("CONT_ID") & "</td>"
        response.write "<td>" & rstTMMIDMTH("COST_PART") & "</td>"
        response.write "<td align='right'>" & rstTMMIDMTH("TOTDAYS") & "</td>"
		response.write "<td align='right'>" & rstTMMIDMTH("TOTAMT") & "</td>"
		response.write "</tr>"			
	
	rstTMMIDMTH.movenext
    
        if sPageBreak = "Y" then
	
			if record >= 37 and not rstTMMIDMTH.eof then
				
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
call pCloseTables(rstTMMIDMTH)

%>

<table cellSpacing=0 cellpadding=0 width=800 class="fontrptdetail">
	
	<tr>
        <br />
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


