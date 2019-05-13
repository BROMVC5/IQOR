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
      font-size:12px;
    }
</style>

<%

sType = request("txtType")
dtFrADate = request("dtFrADate")
dtToADate = request("dtToADate")
sPageBreak = request("cboPageBreak")
sImpType = request("cboImpType")
	    
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100>"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Exception Report</td>"
			response.write "<td width=200 align=center><STRONG style='font-weight: 400'>MEDICAL SYSTEM</STRONG></td>"
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
			response.write "<td align=left width=40>No</td>"
			response.write "<td align=left width=50>Emp Code</td>"
			response.write "<td align=left width=130>Emp Name</td>"
			response.write "<td align=left width=130>Entitlement Type</td>"
			response.write "<td align=left width=50>Claim Date</td>"
			response.write "<td align=left width=50>Attend Date</td>"
			response.write "<td align=left width=50>Reference No</td>"
			if sImpType = "IC" then
				response.write "<td align=left width=200>Clinic</td>"
			else
				response.write "<td align=left width=200>Panel Clinic</td>"
			end if
			response.write "<td align=right width=30>Amount</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=9 align=left bgcolor='white'>"
			response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
			response.write "From Date : "& dtFrADate &"  To "& dtToADate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Import Type : "& sImpType &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "<br>"
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
	Set rstMSExcept = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT MSEXCEPT.EMP_CODE, MSEXCEPT.EMP_NAME, MSEXCEPT.ENTITLEMENT, MSEXCEPT.DT_CLAIM, MSEXCEPT.DT_ATTEND, MSEXCEPT.REMARK, "
	sSQL = sSQL & "MSEXCEPT.CLAIMA, MSEXCEPT.REFNO, MSEXCEPT.PANELC, MSPANELC.PANELNAME "
	sSQL = sSQL & "FROM MSEXCEPT left join MSPANELC on MSEXCEPT.PANELC = MSPANELC.PANELCODE "
	sSQL = sSQL & "WHERE MID(MSEXCEPT.DT_CREATE,1,10) BETWEEN '" & Mid(fDate2(dtFrADate),1,10) & "' AND '" & Mid(fDate2(dtToADate),1,10) & "' "
	sSQL = sSQL & " and IMP_TYPE = '" & sImpType & "' "
	sSQL = sSQL & "ORDER BY EMP_NAME ASC"
	rstMSExcept.Open sSQL, conn, 3, 3
	if not rstMSExcept.eof then
		record = 0
		sPrevEmpCode = rstMSExcept("EMP_CODE")
		bPrint = true
		dMaxc = 0
		dSumClaim = 0 
		
		do while not rstMSExcept.eof
			
			sPanelName = ""
			
			sPanelName = rstMSExcept("PANELNAME")
			' Set rstMSPanelC = server.CreateObject("ADODB.RecordSet")    
			' sSQL = "SELECT PANELCODE, PANELNAME FROM MSPANELC "
			' sSQL = sSQL & " WHERE PANELCODE = '" & rstMSExcept("PANELC") & "'"
			' rstMSPanelC.Open sSQL, conn, 3, 3
			' if not rstMSPanelC.eof then
				' sPanelName = rstMSPanelC("PANELNAME")
			' end if
				
			if rstMSExcept("EMP_CODE") <> sPrevEmpCode then		
				sPrevEmpCode = rstMSExcept("EMP_CODE")
				bPrint = true
				record = record + 1
				response.write "</tr>"
				response.write "<tr valign=top>"
				response.write "<td><br/></td>"
				response.write "</tr>"
			end if
			
				response.write "<tr valign=top>"
				if bPrint = true then
					i = i + 1
					response.write "<td align=left width=20>" & i & "</td>"
					response.write "<td align=left width=40>" & rstMSExcept("EMP_CODE") & "</td>"
					response.write "<td align=left width=150>" & rstMSExcept("EMP_NAME") & "</td>"
					bPrint = false
				else
					response.write "<td align=left width=40></td>"
					response.write "<td align=left width=40></td>"
					response.write "<td align=left width=150></td>"
				end if
				response.write "<td align=left width=100>" & rstMSExcept("ENTITLEMENT") & "</td>"
				response.write "<td align=left width=50>" & rstMSExcept("DT_CLAIM") & "</td>"
				response.write "<td align=left width=62>" & rstMSExcept("DT_ATTEND") & "</td>"
				response.write "<td align=left width=62>" & rstMSExcept("REFNO") & "</td>"

				if rstMSExcept("PANELC") = "NPC" and sImpType = "IC" then
					response.write "<td align=left width=200>" & rstMSExcept("REMARK") & "</td>"
				elseif rstMSExcept("PANELC") = "NPC" and sImpType = "CH" then
					response.write "<td align=left width=200>" & rstMSExcept("PANELNAME") & "</td>"
				else
					response.write "<td align=left width=200>" & rstMSExcept("PANELNAME") & "</td>"
				end if
				
				response.write "<td align=right width=30>" & pFormatDec(rstMSExcept("CLAIMA"),2) & "</td>"
				response.write "</tr>"
		
		rstMSExcept.movenext
		if sPageBreak = "Y" then
			record = record + 1
			if record >= 40 and not rstMSExcept.eof then
			
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
		call pCloseTables(rstMSExcept)
	end if
		response.write "</tr>"
		
	response.write "</table>"

%>
		

	<table cellSpacing=0 cellpadding=0 width=1100 class="fontrptdetail">		
		<tr>
			<td colspan=5><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
		</tr>
		<tr>
			<td align=left>End of Report</td>
		</tr>
	</table>
	
	
</center>
</body>


</html>


