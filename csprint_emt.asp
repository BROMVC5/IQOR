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
sCostID = request("txtCostID")
sSup_Code = request("txtSup_CODE")
sPageBreak = request("cboPageBreak")
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=800 >"
		response.write "<tr>"
			response.write "<td width=100 align=left> Report : Employee Transaction Report</td>"
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
		response.write "<td colspan=6 align=left bgcolor='white'>"
			response.write "<hr size=1 noshade style='margin-top: 10px;margin-bottom: 0px'>"
		response.write "</td>"
	response.write "</tr>"
	
	response.write "<tr>"
		response.write "<td align=left width=53>Employee Code</td>"
		response.write "<td align=left width=135>Employee Name</td>"
		response.write "<td align=left width=64>Card No</td>"
		response.write "<td align=left width=55>Type</td>"
		response.write "<td align=right width=60>Coupon</td>"
		response.write "<td align=right width=100>Datetime</td>"
	response.write "</tr>"
	response.write "<tr>"
		response.write "<td colspan=6 align=left bgcolor='white'>"
			response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
		response.write "</td>"
	response.write "</tr>"
		
	response.write "</table>"
		
	response.write "<table cellSpacing=0 cellpadding=0 width=800 class='fontrptdetail' style='table-layout: fixed;'>"
	
	response.write "<tr>"
		response.write "<td>"
		response.write "From Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
		sSQL = "select cstrns.cardno, cstrns.coupon, cstrns.type, cstrns.dt_trns, csemply.emp_code, csemply.name from cstrns "
		sSQL = sSQL & "left join csemply on cstrns.cardno = csemply.cardno "
		sSQL = sSQL & "left join tmemply on csemply.emp_code = tmemply.emp_code "
		sSQL = sSQL & "where MID(DT_TRNS,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "								
		
		if sEmpCode <> "" then
			sSQL = sSQL & "AND csemply.EMP_CODE ='" & pRTIN(sEmpCode) & "'"
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

		sSQL = sSQL & "order by EMP_CODE,DT_TRNS"
		rstCSTrns.Open sSQL, conn, 3, 3
		
		if not rstCSTrns.eof then
			record = 0
			sPrevEmpCode = rstCSTrns("EMP_CODE")
			bPrint = true
			dCoupon = 0
			dECoupon = 0
			
			do while not rstCSTrns.eof
			
				sSubType = ""
						
				if rstCSTrns("TYPE") = "N" then
					sSubType = "NORMAL"
				else
					sSubType = rstCSTrns("TYPE")
				end if
											
				if rstCSTrns("EMP_CODE") <> sPrevEmpCode then		
					sPrevEmpCode = rstCSTrns("EMP_CODE")
					bPrint = true
					record = record + 1
					response.write "</tr>"
					response.write "<tr valign=top>"
					response.write "<td><br/></td>"
					response.write "</tr>"
				end if

				response.write "<tr valign=top>"
				if bPrint = true then
					response.write "<td align=left width=53>" & rstCSTrns("EMP_CODE") & "</td>"
					response.write "<td align=left width=125>" & rstCSTrns("NAME") & "</td>"
					response.write "<td align=left width=60>" & rstCSTrns("CARDNO") & "</td>"
					bPrint = false
				else
					response.write "<td align=left width=53></td>"
					response.write "<td align=left width=125></td>"
					response.write "<td align=left width=60></td>"
				end if
				response.write "<td align=left width=50>" & sSubType & "</td>"
				response.write "<td align=right width=50>" & rstCSTrns("COUPON") & "</td>"
				response.write "<td align=right width=95>" & rstCSTrns("DT_TRNS") & "</td>"
				response.write "</tr>"
					
			
			rstCSTrns.movenext
			if sPageBreak = "Y" then
				record = record + 1
				if record >= 53 and not rstCSTrns.eof then
					response.write "</table>"
					record = 0
					response.write "<br/>"
					response.Write "Continue Next Page..."    
					response.write "<p style='page-break-before: always'></p>"
					call pageHeader()
				end if
			end if								
			loop	
						
		end if
		call pCloseTables(rstCSTrns)

		%>

	
	

	<table cellSpacing=0 cellpadding=0 width=800 class="fontrptdetail">
		<tr>
			<td colspan=5><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
		</tr>
		<tr>
		
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


