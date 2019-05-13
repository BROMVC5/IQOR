<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->
	<!-- #include file="include/reportcss.asp" -->

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

sType = request("txtType")
dtFrDate = request("dtFrDate")
dtToDate = request("dtToDate")
sReq_Name = request("txtEmp_Name")
sTicket_No = request("txtTicket_No")
sLQty = request("txtLot_Qty")
sPageBreak = request("cboPageBreak")
	    
sPage = 1

Set rstCPPass = server.CreateObject("ADODB.RecordSet")
sql = "select * from CPPASS where ID = '" & session("USERNAME") & "' "
rstCPPass.Open sql, conn, 3, 3
if not rstCPPass.eof then
	if rstCPPass("CPACCESS") = "H" then
		sAccess = "H"
	elseif rstCPPass("CPACCESS") = "A" then
		sAccess = "A"
	elseif rstCPPass("CPACCESS") = "S" then
		sAccess = "S"
	elseif rstCPPass("CPACCESS") = "N" then
		sAccess = "N"
	end if
end if
call pCloseTables(rstCPPass)

Set rstCPPass = server.CreateObject("ADODB.RecordSet")
sql = "SELECT TMEMPLY.DEPT_ID, CPPASS.ID "
sql = sql & "FROM CPPASS LEFT JOIN TMEMPLY ON TMEMPLY.EMP_CODE = CPPASS.ID "
sql = sql & "WHERE ID = '" & session("USERNAME") & "'"
rstCPPass.Open sql, conn, 3, 3
if not rstCPPass.eof then
	sDeptID = rstCPPass("DEPT_ID")
end if
call pCloseTables(rstCPPass)
%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100 >"
		response.write "<tr>"
				response.write "<td width=100 align=left>  Report : Parking Report</td>"
		
			response.write "<td width=200 align=center><STRONG style='font-weight: 400'>CARPARK RESERVATION SYSTEM</STRONG></td>"
			response.write "<td width=80 align=right>Date : "& fDateLong(Now()) &"</td>"
		response.write "</tr>"
		
		response.write "<tr>"
			response.write "<td width=50 align=left>Page : "& sPage &"</td>"
			response.write "<td align=center><STRONG style='font-weight: 400'>IQor Global Services Malaysia Sdn Bhd</STRONG></td>"
			response.write "<td align=right> Time : "& fTime(Now()) &"</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td align=left bgcolor='white' width=250></td>"
			response.write "<td align=center bgcolor='white'></td>"
			response.write "<td align=right bgcolor='white' width=250></td>"
		response.write "</tr>"
	response.write "</table>"
	
	response.write "<table cellSpacing=0 cellpadding=0 width=1100 >"
		
		response.write "<tr>"
			response.write "<td colspan=8 align=left bgcolor='white'>"
				response.write "<hr class='side' size=1 noshade style='margin-top: 10px;margin-bottom: 0px;'>"
			response.write "</td>"
		response.write "</tr>"	
		response.write "<tr>"
			response.write "<td align=left width=40>No</td>"
			response.write "<td align=left width=50>Ticket No</td>"
			response.write "<td align=left width=40>Reserve For</td>"
			response.write "<td align=left width=60>Vehicle No</td>"
			response.write "<td align=left width=60>Lot Quantity</td>"
			response.write "<td align=left width=50>Date From</td>"
			response.write "<td align=left width=50>Date To</td>"
			response.write "<td align=left width=100>Requestor Name</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=8 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			
			
			response.write "From Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "<br>"
			response.write "Requestor Name : "& sReq_Name &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Ticket No : "& UCase(sTicket_No) &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Lot Quantity : "& sLQty &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "<br/>"
			response.write "<br/>"
			response.write "</td>"		

end sub
%>

   
<%
Function GetTodayDate()
	GetTodayDate = fDateLong(Date)
end Function 

Function GetFirstDate()
	GetFirstDate = fDateLong("01/" & mid(fDate(Date),4))
end Function 
%>


</head>
<body>
<center>
<%

 call pageHeader()
 
%>
<%
	Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select cpresv.ticket_no, cpresv.r_name, cpresv.car_no,cpresv.lot_qty , cpresv.d_in, cpresv.d_out, cpresv.t_in, cpresv.t_out, tmemply.name, tmemply.dept_id from cpresv "
		sSQL = sSQL & "left join tmemply on cpresv.emp_code = tmemply.emp_code "
		sSQL = sSQL & "WHERE MID(cpresv.DT_CREATE,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "

			if sReq_Name <> "" then
				sSQL = sSQL & "AND tmemply.name like'%" & pRTIN(sReq_Name) & "%'"
			end if

			if sTicket_No <> "" then
				sSQL = sSQL & "AND cpresv.ticket_no ='" & pRTIN(sTicket_No) & "'"
			end if

			if sLQty <> "" then
				sSQL = sSQL & "AND cpresv.lot_qty ='" & pRTIN(sLQty) & "'"
			end if
			
			if sAccess = "N" then
				sSQL = sSQL & "AND tmemply.dept_id ='" & pRTIN(sDeptID) & "'"
			end if
			
			sSQL = sSQL & "ORDER BY cpresv.ticket_no ASC "
			rstCSTrns.Open sSQL, conn, 3, 3
			
			if not rstCSTrns.eof then
				record = 0
				i = 0
				do while not rstCSTrns.eof			
						
						i = i + 1
						response.write "<tr valign=top>"
						response.write "<td align=left width=40>" & i & "</td>"
						response.write "<td align=left width=50>" & rstCSTrns("TICKET_NO") & "</td>"
						response.write "<td align=left width=200>" & rstCSTrns("R_NAME") & "</td>"
						response.write "<td align=left width=50>" & rstCSTrns("CAR_NO") & "</td>"
						response.write "<td align=center width=40>" & rstCSTrns("LOT_QTY") & "</td>"
						response.write "<td align=left width=80>" & rstCSTrns("D_IN") & "</td>"
						response.write "<td align=left width=80>" & rstCSTrns("D_OUT") & "</td>"
						response.write "<td align=left width=180>" & rstCSTrns("NAME") & "</td>"
						response.write "</tr>"
				
				rstCSTrns.movenext
				if sPageBreak = "Y" then
					record = record + 1
					if record >= 40 and not rstCSTrns.eof then
						sPage = sPage + 1
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
			
		response.write "</tr>"
		
	response.write "</table>"

%>
		

	<table cellSpacing=0 cellpadding=0 width=1100 class="fontrptdetail">		
		<tr>
			<td colspan=5><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
		</tr>
		<tr>
			<td colspan=8 align=left bgcolor='white'>
				<hr size=1 noshade style='margin-bottom: 0px; margin-top:1px;'>
			</td>
		</tr>
		<tr>
			<td align=left>End of Report</td>
		</tr>
	</table>
	
	
</center>
</body>


</html>


