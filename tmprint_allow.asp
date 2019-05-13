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
    margin-right: 5mm;
    margin-left: 5mm;
  

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
sCostID = request("txtCostID")
sEmpCode = request("txtEmpCode")
sPageBreak = request("cboPageBreak")
'sWorkGrpID = request("txtWorkGrpID")
sPage = 1

if sContID = "" then
    sContID = "ALL"
end if

if sCostID = "" then
    sCostID = "ALL"
end if

if sEmpCode = "" then
    sEmpCode = "ALL"
end if

'if sWorkGrpID = "" then
'    sWorkGrpID = "ALL"
'end if
%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Allowance Transaction</td>"
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
	
	response.write "<table cellSpacing=0 cellpadding=0 width=1100 class='fontrptdetail' >"			
				
		response.write "<tr class='spacing'>"
            response.write "<td colspan=12>&nbsp;</td>"
        response.write "</tr>"

        response.write "<tr class='topLine'>"
			response.write "<td style='width:3%'>Day</td>"
		    response.write "<td style='width:6%'>Shift Date</td>"
            response.write "<td style='width:6%'>Emp</td>"
			response.write "<td style='width:21%'>Employee Name</td>"
            response.write "<td style='width:7%'>Contract</td>"
		    response.write "<td style='width:15%'>Cost Center</td>"
            response.write "<td style='width:12%'>Shift</td>"
			response.write "<td align=center colspan='2' style='width:8%'>Time</td>"
			response.write "<td align=center style='width:5%'>Total</td>"
			response.write "<td align=center style='width:5%'>Min</td>"
            response.write "<td align=center style='width:5%'>Allow</td>"
            response.write "<td align=center style='width:5%'>Amount</td>"
            response.write "<td align=center style='width:5%'>SAP</td>"
        response.write "</tr>"

		response.write "<tr class='botLine'>"
			response.write "<td>&nbsp;</td>"
			response.write "<td>&nbsp;</td>"
			response.write "<td>Code</td>"
	        response.write "<td>&nbsp;</td>"
            response.write "<td>&nbsp;</td>"
			response.write "<td>&nbsp;</td>"
            response.write "<td>&nbsp;</td>"
            response.write "<td align=center>In</td>"
			response.write "<td align=center>Out</td>"
			response.write "<td>&nbsp;</td>"
            response.write "<td align=center>Work</td>"
            response.write "<td align=center>Code</td>"
            response.write "<td>&nbsp;</td>"
            response.write "<td align=center>Code</td>"
		response.write "</tr>"

	response.write "<tr>"
		response.write "<td colspan='12' align='left'>"
		    response.write "Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Contract : "& sContID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Employee Code : "& sEmpCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Cost Center : "& sCostID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp"
      	    'response.write "Work Group : "& sWorkGrpID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
 
	Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select tmemply.NAME, tmemply.CONT_ID, tmemply.COST_ID, tmcost.PART as COST_PART, tmemply.SUP_CODE," 
    sSQL = sSQL & " tmworkgrp.HOL_ID,tmclk2.*, tmallow.*, tmclk2.ALLCODE as AllowanceCode from tmclk2 "
	sSQL = sSQL & " left join tmemply on tmclk2.EMP_CODE = tmemply.EMP_CODE "
    sSQL = sSQL & " left join TMWORKGRP on tmclk2.EMP_CODE = tmworkgrp.EMP_CODE "
    sSQL = sSQL & " left join TMCOST on tmemply.COST_ID = tmcost.COST_ID "
    sSQL = sSQL & " left join TMALLOW on tmclk2.ALLCODE = tmallow.ALLCODE "
    sSQL = sSQL & " WHERE DT_WORK BETWEEN '" & fDate2(dtFrDate) & "' AND '" & fDate2(dtToDate) & "' "
	sSQL = sSQL & " and tmclk2.ALLCODE <> '' and tmclk2.TOTAL <> '' and MINWORK <> '' "
    
	if sAtype = "V" then
       ' sSQL = sSQL & " AND isnull(DT_RESIGN) "

    elseif sAType = "M" then

        '==== All the subordinates under his cost center which include employees and supervisors 
        Set rstTMCOST = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMCOST where "
        sSQL1 = sSQL1 & " COSTMAN_CODE ='" & sLogin & "'"  '=== Check the Login is a Cost Manager for which Cost Center
        rstTMCOST.Open sSQL1, conn, 3, 3
        if not rstTMCOST.eof then
            sCount = 0
            Do while not rstTMCOST.eof '=== if got record, loop through each Cost Center that he is a Cost Manager
                Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                sSQL1 = "select * from TMEMPLY where "
                sSQL1 = sSQL1 & " COST_ID ='" & rstTMCOST("COST_ID")  & "'"  '=== Retrieve all Employees belong to the Cost Center
                'sSQL1 = sSQL1 & " AND isnull (DT_RESIGN)"  '=== Retrieve all Employees belong to the Cost Center
                rstTMEMPLY.Open sSQL1, conn, 3, 3
                if not rstTMEMPLY.eof then
                    
                    Do while not rstTMEMPLY.eof 
                        sCount = sCount + 1
                        '==== Insert into the sql the Employee who Manager of that Cost Center           
                        if sCount = 1 then 
                            sSQL = sSQL & "and ( ( ( tmemply.EMP_CODE = '" & rstTMEMPLY("EMP_CODE") & "')"
                        else
                            sSQL = sSQL & "or ( tmemply.EMP_CODE = '" & rstTMEMPLY("EMP_CODE") & "')"
                        end if  
                    rstTMEMPLY.movenext
                    loop
                end if
            rstTMCOST.movenext
            loop
        sSQL = sSQL & " ) )"
        end if

    elseif sAtype = "S" then

        Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMEMPLY where "
        sSQL1 = sSQL1 & " SUP_CODE ='" & sLogin & "'"  
        'sSQL1 = sSQL1 & " AND isnull(DT_RESIGN) " 
        rstTMDOWN1.Open sSQL1, conn, 3, 3
        if not rstTMDOWN1.eof then
            sCount = 0 
            sSQL = sSQL & " AND ( "
            Do while not rstTMDOWN1.eof
                sCount = sCount + 1
                if sCount = 1 then
                    sSQL = sSQL & " tmemply.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "'"
                else
                    sSQL = sSQL & " or tmemply.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "'"
                    
                end if
                sSQL = sSQL &   " or tmemply.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"  

            rstTMDOWN1.movenext
            loop
        sSQL = sSQL & " ) " 
        end if

    end if

	if sContID <> "ALL" then
        sSQL = sSQL & "AND tmemply.CONT_ID ='" & pRTIN(sContID) & "' "
    end if 

	if sCostID <> "ALL" then
		sSQL = sSQL & "AND tmemply.COST_ID ='" & pRTIN(sCostID) & "' "
	end if

    if sEmpCode <> "ALL" then
	    sSQL = sSQL & "AND tmemply.EMP_CODE ='" & pRTIN(sEmpCode) & "' "
    end if

    'if sWorkGrpID <> "ALL" then
    '    sSQL = sSQL & " and tmworkgrp.WORKGRP_ID = '" & sWorkGrpID & "' "
    'end if

	sSQL = sSQL & " order by tmclk2.DT_WORK asc, tmemply.SUP_CODE  "
    rstTMClk2.Open sSQL, conn, 3, 3
	if not rstTMClk2.eof then

	    do while not rstTMClk2.eof
				
			response.write "<tr valign=top>"
			    response.write "<td>" & Weekdayname(weekday(rstTMClk2("DT_WORK"),1),True) & "</td>"
			    response.write "<td>" & rstTMClk2("DT_WORK") & "</td>"
			    response.write "<td>" & rstTMClk2("EMP_CODE") & "</td>"
			    response.write "<td>" & rstTMClk2("NAME") & "</td>"
                response.write "<td>" & rstTMCLK2("CONT_ID") & "</td>"    
                response.write "<td>" & rstTMCLK2("COST_PART") & "</td>" '==Cost Center
                
                Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
			    sSQL = "select STIME,ETIME from TMSHFCODE where SHF_CODE='" & rstTMCLK2("SHF_CODE") & "'" 
			    rstTMSHFCODE.Open sSQL, conn, 3, 3
			    if not rstTMSHFCODE.eof then
				    sSTIME = rstTMSHFCODE("STIME")
                    sETIME = rstTMSHFCODE("ETIME")
			    end if
                call pCloseTables(rstTMSHFCODE)

                if rstTMCLK2("SHF_CODE") = "REST" or rstTMCLK2("SHF_CODE") = "OFF"  then  '=== It's a REST Day
                    response.write "<td>" & rstTMCLK2("SHF_CODE")
                else
			        response.write "<td>" & rstTMCLK2("SHF_CODE") & " " & sSTIME & "-" & sETIME & "</td>"
                end if

                response.write "<td align=center>" & rstTMCLK2("TIN") & "</td>"
                response.write "<td align=center>" & rstTMCLK2("TOUT") & "</td>"
                response.write "<td align=center>" & rstTMCLK2("TOTAL") & "</td>"
			    response.write "<td align=center>" & rstTMClk2("MINWORK") & "</td>"
			    response.write "<td align=center>" & rstTMClk2("AllowanceCode") & "</td>"
			    response.write "<td align=center>" & pFormatDec(rstTMClk2("ALLOW"),2) & "</td>" '=== Allowance Amount 
                response.write "<td align=center>" & rstTMClk2("SAPALLCODE") & "</td>" 
            response.write "</tr>"

		rstTMClk2.movenext

		if sPageBreak = "Y" then

			record = record + 1

			if record >= 37 and not rstTMClk2.eof then
				
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
		call pCloseTables(rstTMClk2)
	end if
    response.write "</tr>"
		
	response.write "</table>"

%>

<table cellSpacing=0 cellpadding=0 width=1100 class="fontrptdetail">
	<tr>
        </br>
		<td colspan=5><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
    </tr>
    <tr>
      <td style="text-align:left">Total Approved OT From <%=dtFrDate %> To <%=dtToDate %> : <%=MinToTime(iTotalOTForThePeriod)%></td>
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


