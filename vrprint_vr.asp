<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
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
dtFrDate = request("dtFrDate2")
dtToDate = request("dtToDate2")
sCompID = request("txtComp_Name")
sDept = request("txtDept_ID")
sVend_Name = request("txtVend_Name2")
sPageBreak = request("cboPageBreak")
sIC = request("txtNRIC")
	    
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100>"
		response.write "<tr>"
				response.write "<td width=100 align=left>  Report : Vendor Check In Report</td>"
		
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
		response.write "<td colspan=9 align=left bgcolor='white'>"
			response.write "<hr size=1 noshade style='margin-top: 10px;margin-bottom: 0px'>"
		response.write "</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td align=left width=20>No</td>"
			response.write "<td align=left width=80>NRIC/Passport</td>"
			response.write "<td align=left width=70>Vendor Name</td>"
			response.write "<td align=left width=70>Company Name</td>"
			response.write "<td align=left width=80>Appointment With</td>"
			response.write "<td align=left width=50>Department</td>"
			response.write "<td align=left width=120>Date/Time In</td>"
			response.write "<td align=left width=120>Date/Time Out</td>"
			response.write "<td align=right width=50>Badge No</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=9 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			
			
			response.write "From Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "<br>"
			response.write "NRIC/Passport : "& UCase(sIC) &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Vendor Name : "& UCase(sVend_Name) &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Company Name : "& sCompID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Department ID : "& sDept &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
	Set rstVRTrns = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select VRVEND.NRIC, VRVEND.VNAME, VRVEND.COMPNAME, VRTRNS.APP_NAME, VRTRNS.DEPT, VRTRNS.DT_IN, VRTRNS.DT_OT,VRTRNS.BADGE_NO "
	sSQL = sSQL & "FROM VRTRNS "
	sSQL = sSQL & "LEFT JOIN VRVEND ON VRVEND.NRIC = VRTRNS.NRIC "
	sSQL = sSQL & "WHERE VRTRNS.BADGE_NO IS NOT NULL "
	sSQL = sSQL & "AND MID(vrtrns.DT_CREATE,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "
	
	if sIC <> "" then
		sSQL = sSQL & "AND VRVEND.NRIC like '" & pRTIN(sIC) & "%'"
	end if
	
	if sCompID <> "" then
		sSQL = sSQL & "AND COMPNAME ='" & pRTIN(sCompID) & "'"
	end if
	
	if sDept <> "" then
		sSQL = sSQL & "AND DEPT ='" & pRTIN(sDept) & "'"
	end if
	
	if sVend_Name <> "" then
		sSQL = sSQL & "AND VNAME like'%" & pRTIN(sVend_Name) & "%'"
	end if
	
	if sStatus <> "" then
		sSQL = sSQL & "AND BLIST like'" & pRTIN(sStatus) & "'"
	end if
	
	sSQL = sSQL & "GROUP BY VRTRNS.BADGE_NO,VRVEND.NRIC,VRTRNS.DT_IN,VRTRNS.DT_IN "
	sSQL = sSQL & "ORDER BY VRTRNS.NRIC ASC "
	rstVRTrns.Open sSQL, conn, 3, 3
	 
	if not rstVRTrns.eof then
		record = 0
		i = 0
		do while not rstVRTrns.eof

				dCoupon = 0
				dECoupon = 0				
				
				i = i + 1
				response.write "<tr valign=top>"
				response.write "<td align=left width=20>" & i & "</td>"
				response.write "<td align=left width=90>" & rstVRTrns("NRIC") & "</td>"
				response.write "<td align=left width=150>" & rstVRTrns("VNAME") & "</td>"
				response.write "<td align=left width=250>" & rstVRTrns("COMPNAME") & "</td>"
				response.write "<td align=left width=150>" & rstVRTrns("APP_NAME") & "</td>"
				response.write "<td align=left width=50>" & rstVRTrns("DEPT") & "</td>"
				response.write "<td align=left width=100>" & rstVRTrns("DT_IN") & "</td>"
				response.write "<td align=left width=100>" & rstVRTrns("DT_OT") & "</td>"
				response.write "<td align=right width=30>" & rstVRTrns("BADGE_NO") & "</td>"
				response.write "</tr>"
		
		rstVRTrns.movenext
		if sPageBreak = "Y" then
			record = record + 1
			if record >= 40 and not rstVRTrns.eof then
			
				response.write "</table>"
				record = 0
				response.write "<br/>"
				response.Write "Continue Next Page..."    
				response.write "<p style='page-break-before: always'></p>"
				sPage = sPage + 1
				response.write "<br/>"
				call pageHeader()
			end if
		end if 

		loop		
		call pCloseTables(rstVRTrns)
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


