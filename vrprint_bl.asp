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
dtFrDate = request("dtFrDate1")
dtToDate = request("dtToDate1")
sCompID = request("txtComp_Name")
sDept = request("txtDept_ID")
sVend_Name = request("txtVend_Name1")
sStatus = request("sStatus1")
sIC = request("txtNRIC1")
sPageBreak = request("cboPageBreak")
	    
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100 >"
		response.write "<tr>"
				response.write "<td width=100 align=left>  Report : Blacklist Report</td>"
		
			response.write "<td width=200 align=center><STRONG style='font-weight: 400'>VENDOR REGISTRATION SYSTEM</STRONG></td>"
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
			response.write "<td align=left width=50>NRIC/Passport</td>"
			response.write "<td align=left width=40>Vendor Name</td>"
			response.write "<td align=left width=80>Company Name</td>"
			response.write "<td align=left width=50>H/P</td>"
			response.write "<td align=left width=80>Vehicle No</td>"
			response.write "<td align=left width=80>Reason</td>"
			response.write "<td align=right width=50>Blacklist</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=8 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			
			
			'response.write "From Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			'response.write "<br>"
			response.write "NRIC/Passport : "& UCase(sIC) &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Vendor Name : "& UCase(sVend_Name) &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Company Name : "& sCompID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Blacklist : "& sStatus &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
		sSQL = "select NRIC, VNAME, COMPNAME, HP, CAR_NO, BLREASON,BLIST "
		sSQL = sSQL & "from vrvend "
		' sSQL = sSQL & "WHERE MID(DT_CREATE,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "
		sSQL = sSQL & " where 1=1 "
		
			if sIC <> "" then
				sSQL = sSQL & "AND NRIC like '" & pRTIN(sIC) & "%'"
			end if

			if sCompID <> "" then
				sSQL = sSQL & "AND COMPNAME ='" & pRTIN(sCompID) & "'"
			end if

			if sVend_Name <> "" then
				sSQL = sSQL & "AND VNAME like'%" & pRTIN(sVend_Name) & "%'"
			end if

			if sStatus <> "" then
				sSQL = sSQL & "AND BLIST like'" & pRTIN(sStatus) & "'"
			end if

			sSQL = sSQL & "ORDER BY NRIC ASC"
			rstCSTrns.Open sSQL, conn, 3, 3

			if not rstCSTrns.eof then
				record = 0
				i = 0
				do while not rstCSTrns.eof

						dCoupon = 0
						dECoupon = 0				
						
						i = i + 1
						response.write "<tr valign=top>"
						response.write "<td align=left width=50>" & i & "</td>"
						response.write "<td align=left width=80>" & rstCSTrns("NRIC") & "</td>"
						response.write "<td align=left width=180>" & rstCSTrns("VNAME") & "</td>"
						response.write "<td align=left width=250>" & rstCSTrns("COMPNAME") & "</td>"
						response.write "<td align=left width=80>" & rstCSTrns("HP") & "</td>"
						response.write "<td align=left width=80>" & rstCSTrns("CAR_NO") & "</td>"
						response.write "<td align=left width=180>" & rstCSTrns("BLREASON") & "</td>"
						response.write "<td align=right width=50>" & rstCSTrns("BLIST") & "</td>"
						response.write "</tr>"
				
				rstCSTrns.movenext
				if sPageBreak = "Y" then
					record = record + 1
					if record >= 40 and not rstCSTrns.eof then
					
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
			<td colspan=6><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
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


