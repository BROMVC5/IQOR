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
sEmpCode = request("txtEmpCode")
sDeptID = request("txtDeptID")
sGradeID = request("txtGradeID")
sCostID = request("txtCostID")
sContID = request("txtContID")
sDisType = request("cboDisType")
sSubType = request("txtSubType")
sSup_Code = request("txtSup_CODE")
sPageBreak = request("cboPageBreak")	    
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=800 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Summary by Date Report</td>"
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
			response.write "<td align=left width=120>Date</td>"
			
			if sDisType = "N" then
				response.write "<td align=right width=50>Normal (RM)</td>"
			elseif sDisType = "B" then
				response.write "<td align=right width=50>Normal (RM)</td>"
				response.write "<td align=right width=50>Extra (RM)</td>"
				response.write "<td align=right width=50>Total (RM)</td>"
			else
				response.write "<td align=right width=50>Extra (RM)</td>"
				' response.write "<td align=right width=50>Total (RM)</td>"
			end if
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
		response.write "Employee Code : "& sEmpCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Department : "& sDeptID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "<br/>"
		response.write "Grade : "& sGradeID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Cost Center : "& sCostID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Contract : "& sContID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Superior : "& sSup_Code &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		response.write "Type : "& sDisType &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		if sDisType <> "N" and sDisType <> "B" then 
			response.write "Subsidy Type : "& sSubType &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		end if
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
sSQL = "select sum(case when cstrns.type = 'N' then cstrns.COUPON else 0 end) as sumCoupon, sum(case when cstrns.type <> 'N' then cstrns.COUPON else 0 end) as sumExtra, "
sSQL = sSQL & "csemply.EMP_CODE as EMP_CODE,csemply.NAME as NAME, tmemply.DEPT_ID as DEPT_ID, "
sSQL = sSQL & "tmemply.GRADE_ID as GRADE_ID, tmemply.COST_ID as COST_ID,  tmemply.CONT_ID as CONT_ID,cstrns.* from cstrns "
sSQL = sSQL & "left join csemply on cstrns.CARDNO = csemply.CARDNO "
sSQL = sSQL & "left join tmemply on csemply.EMP_CODE = tmemply.EMP_CODE where cstrns.status = 'Y' "
sSQL = sSQL & "AND MID(cstrns.DT_TRNS,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "

if sEmpCode <> "" then
	sSQL = sSQL & "AND csemply.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
end if
			
if sDeptID <> "" then
	sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
end if

if sGradeID <> "" then
	sSQL = sSQL & "AND GRADE_ID ='" & pRTIN(sGradeID) & "'"
end if	

if sCostID <> "" then
	sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
end if

if sContID <> "" then
	sSQL = sSQL & "AND CONT_ID ='" & pRTIN(sContID) & "'"
end if

if sDisType = "E" then 
	if sSubType <> "" then
		sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
	end if
end if

if sSup_Code <> "" then
	sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
end if 

sSQL = sSQL & " group by MID(cstrns.DT_TRNS,1,10) "
sSQL = sSQL & " order by MID(cstrns.DT_TRNS,1,10) asc "
rstCSTrns.Open sSQL, conn, 3, 3
if not rstCSTrns.eof then
	record = 0
	do while not rstCSTrns.eof
			dCoupon = 0
			dECoupon = 0
			
			dCoupon = rstCSTrns("sumCoupon")
			dECoupon = rstCSTrns("sumExtra")
			dTotCoupon = dCoupon + dECoupon			
		
			response.write "<tr valign=top>"
			response.write "<td align=left width=120>" & fdatelong(rstCSTrns("DT_TRNS")) & "</td>"
			
			if sDisType = "N" then
				response.write "<td align=right width=50>" & pFormatDash(dCoupon,2) & "</td>"
			elseif sDisType = "E" then
				response.write "<td align=right width=50>" & pFormatDash(dECoupon,2) & "</td>"
				' response.write "<td align=right width=50>" & pFormatDash(dTotCoupon,2) & "</td>"
			elseif sDisType = "B" then
				response.write "<td align=right width=50>" & pFormatDash(dCoupon,2) & "</td>"
				response.write "<td align=right width=50>" & pFormatDash(dECoupon,2) & "</td>"
				response.write "<td align=right width=50>" & pFormatDash(dTotCoupon,2) & "</td>"
			end if
			response.write "</tr>"
	

	rstCSTrns.movenext
	if sPageBreak = "Y" then
		record = record + 1
		if record >= 49 and not rstCSTrns.eof then
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
	sSQL = "select sum(case when cstrns.type = 'N' then cstrns.COUPON else 0 end) as sumCoupon, sum(case when cstrns.type <> 'N' then cstrns.COUPON else 0 end) as sumExtra, "
	sSQL = sSQL & "csemply.EMP_CODE as EMP_CODE,csemply.NAME as NAME, tmemply.DEPT_ID as DEPT_ID, "
	sSQL = sSQL & "tmemply.GRADE_ID as GRADE_ID, tmemply.COST_ID as COST_ID,  tmemply.CONT_ID as CONT_ID,cstrns.* from cstrns "
	sSQL = sSQL & "left join csemply on cstrns.CARDNO = csemply.CARDNO "
	sSQL = sSQL & "left join tmemply on csemply.EMP_CODE = tmemply.EMP_CODE where cstrns.status = 'Y' "
	sSQL = sSQL & "AND MID(cstrns.DT_TRNS,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "
	
	if sEmpCode <> "" then
	sSQL = sSQL & "AND csemply.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
	end if
	
	if sDeptID <> "" then
		sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
	end if
	
	if sGradeID <> "" then
		sSQL = sSQL & "AND GRADE_ID ='" & pRTIN(sGradeID) & "'"
	end if	
	
	if sCostID <> "" then
		sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
	end if
	
	if sContID <> "" then
		sSQL = sSQL & "AND CONT_ID ='" & pRTIN(sContID) & "'"
	end if
	
	if sDisType = "E" then 
		if sSubType <> "" then
			sSQL = sSQL & "AND TYPE ='" & pRTIN(sSubType) & "'"
		end if
	end if
	
	if sSup_Code <> "" then
		sSQL = sSQL & "AND SUP_CODE ='" & pRTIN(sSup_Code) & "'"
	end if 

	rstCSTrns.Open sSQL, conn, 3, 3
	
	if not rstCSTrns.eof then
		dCoupon = rstCSTrns("sumCoupon")
		dECoupon = rstCSTrns("sumExtra")
		dTotCoupon = dCoupon + dECoupon
							
		response.write "<td align=right width=120>Total : </td>"
		
		if sDisType = "N" then
			response.write "<td align=right width=50>" & pFormatDash(dCoupon,2) & "</td>"
		elseif sDisType = "E" then
			response.write "<td align=right width=50>" & pFormatDash(dECoupon,2) & "</td>"
			' response.write "<td align=right width=49>" & pFormatDash(dTotCoupon,2) & "</td>"
		elseif sDisType = "B" then
			response.write "<td align=right width=50>" & pFormatDash(dCoupon,2) & "</td>"
			response.write "<td align=right width=50>" & pFormatDash(dECoupon,2) & "</td>"
			response.write "<td align=right width=49>" & pFormatDash(dTotCoupon,2) & "</td>"
		end if
		
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


