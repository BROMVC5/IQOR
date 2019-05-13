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
dtFrCDate = request("dtFrCDate")
dtToCDate = request("dtToCDate")
dtFrADate = request("dtFrADate")
dtToADate = request("dtToADate")
sEmp_ID = request("txtEmp_ID")
sEnType = request("txtEn_Name")
sPageBreak = request("cboPageBreak")
sInsertType = request("cboType")
sDtType = request("txtDtType")
sPanelCode = request("txtPanelCode") 
sPage = 1

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100>"
		response.write "<tr>"
				response.write "<td width=100 align=left>  Report : Medical's Claim Report</td>"
		
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
			response.write "<td align=left width=20>No</td>"
			response.write "<td align=left width=60>Emp Code</td>"
			response.write "<td align=left width=130>Emp Name</td>"
			response.write "<td align=left width=50>Ref No</td>"
			response.write "<td align=left width=180>Entitlement Type</td>"
			response.write "<td align=left width=280>Panel Clinic</td>"
			response.write "<td align=right width=50>Claim Date</td>"
			response.write "<td align=right width=50>Attend Date</td>"
			response.write "<td align=right width=80>Claim Amount</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=9 align=left bgcolor='white'>"
			response.write "<hr size=1 noshade style='margin-top: 0px;margin-bottom: 0px'>"
            if sDtType = "CL" then
			    response.write "From Claim Date : "& dtFrCDate &"  To "& dtToCDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            else
			    response.write "From Attend Date : "& dtFrADate &"  To "& dtToADate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            end if
			response.write "<br>"
			response.write "Employee Code : "& sEmp_ID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Entitlement Type : "& UCase(sEnType) &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
			response.write "Panel Clinic : "& UCase(sPanelCode) &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
	sSQL = "SELECT REFNO ,EMP_CODE, EMP_NAME, ENTITLEMENT, DT_CLAIM, DT_ATTEND, CLAIMA, TYPE, PANELC, MSPANELC.PANELNAME, MSSTAFFC.OTHERC "
	sSQL = sSQL & "FROM MSSTAFFC LEFT JOIN MSPANELC ON MSSTAFFC.PANELC = MSPANELC.PANELCODE "
    if sDtType = "CL" then
	    sSQL = sSQL & "WHERE MID(DT_CLAIM,1,10) BETWEEN '" & Mid(fDate2(dtFrCDate),1,10) & "' AND '" & Mid(fDate2(dtToCDate),1,10) & "' "
    else 
	    sSQL = sSQL & "WHERE MID(DT_ATTEND,1,10) BETWEEN '" & Mid(fDate2(dtFrADate),1,10) & "' AND '" & Mid(fDate2(dtToADate),1,10) & "' "
    end if
	
	if sEmp_ID <> "" then
		sSQL = sSQL & "AND EMP_CODE ='" & pRTIN(sEmp_ID) & "'"
	end if
	
	if sEnType <> "" then
		sSQL = sSQL & "AND ENTITLEMENT ='" & pRTIN(sEnType) & "'"
	end if
	
	if sInsertType <> "" then
		sSQL = sSQL & "AND TYPE ='" & pRTIN(sInsertType) & "'"
	end if
	
	if sPanelCode <> "" then
		sSQL = sSQL & "AND PANELC ='" & pRTIN(sPanelCode) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY EMP_NAME, DT_ATTEND ASC "
	rstVRTrns.Open sSQL, conn, 3, 3
	 
	if not rstVRTrns.eof then
		record = 0
		sPrevEmpCode = rstVRTrns("EMP_CODE")
		bPrint = true
		dMaxc = 0
		dSumClaim = 0 
		
		do while not rstVRTrns.eof		
				
			if rstVRTrns("EMP_CODE") <> sPrevEmpCode then		
				sPrevEmpCode = rstVRTrns("EMP_CODE")
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
					response.write "<td align=left width=40>" & rstVRTrns("EMP_CODE") & "</td>"
					response.write "<td align=left width=180>" & rstVRTrns("EMP_NAME") & "</td>"
					response.write "<td align=left width=50>" & rstVRTrns("REFNO") & "</td>"
					bPrint = false
				else
					response.write "<td align=left width=20></td>"
					response.write "<td align=left width=40></td>"
					response.write "<td align=left width=180></td>"
					response.write "<td align=left width=50></td>"
				end if
				response.write "<td align=left width=180>" & Ucase(rstVRTrns("ENTITLEMENT")) & "</td>"
				response.write "<td align=left width=280>" & Ucase(rstVRTrns("PANELNAME")) & "</td>"
				response.write "<td align=right width=50>" & rstVRTrns("DT_CLAIM") & "</td>"
				response.write "<td align=right width=62>" & rstVRTrns("DT_ATTEND") & "</td>"
				response.write "<td align=right width=62>" & pFormatDec(rstVRTrns("CLAIMA"),2) & "</td>"
				response.write "</tr>"
				
			if sPageBreak = "Y" then
				record = record + 1
				if record >= 35 and not rstVRTrns.eof then
				
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
		
		rstVRTrns.movenext

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
		<%
			Set rstMSTrns = server.CreateObject("ADODB.RecordSet")    
			sSQL = "SELECT EMP_CODE, EMP_NAME, ENTITLEMENT, SUM(MAXC) AS SUMMAXC, SUM(CLAIMA) AS SUMCLAIM, SUM(MAXC) - SUM(CLAIMA) AS BALANCE, PANELC "
			sSQL = sSQL & "FROM MSSTAFFC LEFT JOIN MSPANELC ON MSSTAFFC.PANELC = MSPANELC.PANELCODE "
            if sDtType = "CL" then
			    sSQL = sSQL & "WHERE MID(DT_CLAIM,1,10) BETWEEN '" & Mid(fDate2(dtFrCDate),1,10) & "' AND '" & Mid(fDate2(dtToCDate),1,10) & "' "
			else
                sSQL = sSQL & "WHERE MID(DT_ATTEND,1,10) BETWEEN '" & Mid(fDate2(dtFrADate),1,10) & "' AND '" & Mid(fDate2(dtToADate),1,10) & "' "
			end if

			if sEmp_ID <> "" then
				sSQL = sSQL & "AND EMP_CODE ='" & pRTIN(sEmp_ID) & "'"
			end if
			
			if sEnType <> "" then
				sSQL = sSQL & "AND ENTITLEMENT ='" & pRTIN(sEnType) & "'"
			end if
			
			if sInsertType <> "" then
				sSQL = sSQL & "AND TYPE ='" & pRTIN(sInsertType) & "'"
			end if
			
			if sPanelCode <> "" then
				sSQL = sSQL & "AND PANELC ='" & pRTIN(sPanelCode) & "'"
			end if
			
			sSQL = sSQL & " ORDER BY EMP_CODE ASC "
			
			rstMSTrns.Open sSQL, conn, 3, 3
			 
			if not rstMSTrns.eof then
				dTot = rstMSTrns("SUMCLAIM")

				response.write "<td align=right width=390>Total Claim : </td>"
				response.write "<td align=right width=10>" & pFormatDash(dTot,2) & "</td>"
				response.write "<tr>"
				response.write "<td colspan=8 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-bottom: 0px; margin-top:1px;'>"
				response.write "</td>"
				response.write "</tr>"
				response.write "<tr>"
				response.write "<td colspan=8 align=left bgcolor='white'>"
				response.write "<hr size=1 noshade style='margin-bottom: 0px; margin-top:1px;'>"
				response.write "</td>"
				response.write "</tr>"
			end if		
			call pCloseTables(rstMSTrns)
			
		%>
		<tr>
			<td align=left>End of Report</td>
		</tr>
	</table>
	
	
</center>
</body>


</html>


