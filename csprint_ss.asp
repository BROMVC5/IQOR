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

sType = request("txtType")
dtFrDate = request("dtFrDate")
dtToDate = request("dtToDate")
sSubType = request("txtSubType")
sEmpCode = request("txtEmpCode")
sDeptID = request("txtDeptID")
sCostID = request("txtCostID")
sSup_Code = request("txtSup_CODE")
sPageBreak = request("cboPageBreak")	    
sPage = 1

set rstCSType = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from cstype where SUBTYPE = '" & sSubType & "' " 
rstCSType.Open sSQL, conn, 3, 3
if not rstCSType.eof then
	sSubName = rstCSType("PART")
end if
pCloseTables(rstCSType)

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=800 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Subsidy Entitlement Summary</td>"
			response.write "<td width=300 align=center><STRONG style='font-weight: 400'>CANTEEN SYSTEM</STRONG></td>"
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
			response.write "<td colspan=5 align=left bgcolor='white'>"
				response.write "<hr class='side' size=1 noshade style='margin-top: 10px;margin-bottom: 0px;'>"
			response.write "</td>"
		response.write "</tr>"	
		response.write "<tr>"
			response.write "<td align=left width=40>No</td>"
			response.write "<td align=left width=80>Employee Code</td>"
			response.write "<td align=left width=150>Employee Name</td>"
			response.write "<td align=right width=50>Amount (RM)</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=5 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			response.write "</td>"
		response.write "</tr>"
		
	response.write "</table>"
		
	response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail'>"
	
	response.write "<tr>"
		response.write "<td>"
		response.write "From Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Subsidy Type : "& sSubName &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Employee Code : "& sEmpCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "<br/>"
		response.write "Department : "& sDeptID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Cost Center : "& sCostID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Superior : "& sSup_Code &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
sSQL = "select csemply1.emp_code, sum(csemply1.amount) as dSumAmount from csemply1 "
sSQL = sSQL & " left join tmemply on csemply1.emp_code = tmemply.emp_code "
sSQL = sSQL & "where MID(DT_SUB,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "

if sSubType <> "" then
	sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
end if

if sEmpCode <> "" then
	sSQL = sSQL & "AND csemply1.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
end if

if sDeptID <> "" then
	sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
end if

if sCostID <> "" then
	sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
end if

if sSup_Code <> "" then
	sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
end if			

sSQL = sSQL & "group by csemply1.EMP_CODE "
sSQL = sSQL & "order by csemply1.EMP_CODE asc "
rstCSTrns.Open sSQL, conn, 3, 3
if not rstCSTrns.eof then
	record = 0
	i = 0
	sPrevEmpCode = rstCSTrns("EMP_CODE")
	bPrint = true
	
	do while not rstCSTrns.eof
		sEmpName = ""
		dSumAmount = 0
		bPrint = true
		set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select emp_code, name from tmemply where EMP_CODE = '" & rstCSTrns("EMP_CODE") & "' " 
		rstTMEmply.Open sSQL, conn, 3, 3
		if not rstTMEmply.eof then
			sEmpName = rstTMEmply("NAME")
		end if
		pCloseTables(rstTMEmply)

		response.write "<tr valign=top>"
		if bPrint = true then
			i = i + 1
			response.write "<td align=left width=40>" & i & "</td>"
			response.write "<td align=left width=80>" & rstCSTrns("EMP_CODE") & "</td>"
			response.write "<td align=left width=150>" & sEmpName & "</td>"
			response.write "<td align=right width=50>" & pFormatDash(rstCSTrns("dSumAmount"),2) & "</td>"
			bPrint = false
		else
			response.write "<td align=left width=40></td>"
			response.write "<td align=left width=40></td>"
			response.write "<td align=left width=150></td>"
		end if
		
		response.write "</tr>"

	rstCSTrns.movenext
	if sPageBreak = "Y" then
		record = record + 1
		if record >= 43 and not rstCSTrns.eof then
			response.write "</table>"
			record = 0
			response.write "<br/>"
			response.Write "Continue Next Page..."    
			response.write "<p style='page-break-before: always'></p>"
			call pageHeader()
		end if
	end if

	loop		
	call pCloseTables(rstCSTrns)
end if


%>

<table cellSpacing=0 cellpadding=0 width=800 class="fontrptdetail">
	<tr>
		<td colspan=5><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
	</tr>
	<tr>
	<%
	Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select sum(amount) as dTotal from csemply1 "
	sSQL = sSQL & " left join tmemply on csemply1.emp_code = tmemply.emp_code "
	sSQL = sSQL & "where MID(DT_SUB,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "
	
	if sSubType <> "" then
		sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
	end if	
	
	if sEmpCode <> "" then
		sSQL = sSQL & "AND csemply1.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
	end if

	if sDeptID <> "" then
		sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
	end if

	if sCostID <> "" then
		sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
	end if

	if sSup_Code <> "" then
		sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
	end if	

	rstCSTrns.Open sSQL, conn, 3, 3
	
	if not rstCSTrns.eof then
							
		response.write "<td align=right width=200>Total : </td>"
		response.write "<td align=right width=49>" & pFormatDash(rstCSTrns("dTotal"),2) & "</td>"
		
	end if
	call pCloseTables(rstCSTrns)						
	%>
	</tr>		
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


