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
sApprvOrPend = request("ApprvOrPend") '=== P = Pending, A= Approved

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

if sApprvOrPend = "P" then
    sStatus = "Pending"
else
    sStatus = "Approved"
end if



%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : OT Transaction</td>"
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

        if sApprvOrPend = "P" then '=== Pending
            response.write "<tr class='topLine'>"
			    response.write "<td align=left style='width:3%'>Day</td>"
		        response.write "<td align=left style='width:6%'>Shift Date</td>"
                response.write "<td align=left style='width:5%'>Employee</td>"
			    response.write "<td align=leftstyle='width:17%'>Employee Name</td>"
                response.write "<td align=left style='width:6%'>Contract</td>"
		        response.write "<td align=left style='width:12%'>Cost Center</td>"
                response.write "<td align=left style='width:10%'>Shift</td>"
			    response.write "<td align=center colspan='2' style='width:8%'>Time</td>"
			    response.write "<td align=center style='width:4%'>Total</td>"
			    response.write "<td align=center style='width:4%'>Total</td>"
			    response.write "<td align=center style='width:5%'>Rounded</td>"
			    response.write "<td align=center style='width:5%'>Apprv</td>"
                response.write "<td align=center style='width:6%'>OT Code</td>"
                response.write "<td align=center style='width:5%'>Manager</td>"
                response.write "<td align=center style='width:4%'>Superior</td>"
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
			    response.write "<td align=center>OT</td>"
                response.write "<td align=center>OT</td>"
                response.write "<td align=center>OT</td>"
                response.write "<td align=center>/Rate</td>"
			    response.write "<td>&nbsp;</td>"
                response.write "<td>&nbsp;</td>"
                response.write "<td>&nbsp;</td>"
		    response.write "</tr>"

        else '=== Approved

		    response.write "<tr class='topLine'>"
			    response.write "<td style='width:3%'>Day</td>"
		        response.write "<td style='width:7%'>Shift Date</td>"
                response.write "<td style='width:6%'>Emp</td>"
			    response.write "<td style='width:20%'>Employee Name</td>"
                response.write "<td style='width:6%'>Contract</td>"
		        response.write "<td style='width:13%'>Cost Center</td>"
                response.write "<td style='width:10%'>Shift</td>"
			    response.write "<td align=center colspan='2' style='width:8%'>Time</td>"
			    response.write "<td align=center style='width:6%'>Total</td>"
			    response.write "<td align=center style='width:6%'>Total</td>"
			    response.write "<td align=center style='width:5%'>Rounded</td>"
			    response.write "<td align=center style='width:5%'>Apprv</td>"
                response.write "<td align=center style='width:5%'>OT Code</td>"
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
			    response.write "<td align=center></td>"
                response.write "<td align=center>OT</td>"
			    response.write "<td align=center>OT</td>"
                response.write "<td align=center>OT</td>"
                response.write "<td align=center>/Rate</td>"
			response.write "</tr>"

	    end if

	response.write "<tr>"
		response.write "<td colspan='12' align='left'>"
		    response.write "From Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	        response.write "Employee Code : "& sEmpCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	        response.write "Contract ID : "& sContID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	        response.write "Cost Center : "& sCostID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            response.write "Status : " & sStatus &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
    sSQL = "SELECT TMCLK2.DT_WORK, TMCLK2.EMP_CODE, TMEMPLY.NAME, TMEMPLY.CONT_ID, TMEMPLY.GRADE_ID, tmworkgrp.HOL_ID, "
    sSQL = sSQL & " TMCLK2.*, TMCOST.COST_ID, TMCOST.PART as COST_PART "
    sSQL = sSQL & " FROM TMCLK2 LEFT JOIN TMEMPLY ON TMEMPLY.EMP_CODE = TMCLK2.EMP_CODE  "
    sSQL = sSQL & " left join tmcost on tmemply.COST_ID= tmcost.COST_ID"
    sSQL = sSQL & " left join TMWORKGRP on TMWORKGRP.EMP_CODE = TMCLK2.EMP_CODE "
	sSQL = sSQL & " WHERE DT_WORK BETWEEN '" & fDate2(dtFrDate) & "' AND '" & fDate2(dtToDate) & "' "
    sSQL = sSQL & " AND ( OT = 'Y' " 

    if sApprvOrPend = "P" then
        sSQL = sSQL & " AND isnull(3OTDTAPV) ) " '==== Anything before Final 3rd level Final Approval
    else
        sSQL = sSQL & " AND not isnull(3OTDTAPV) ) " '==== Only Final approval will show
    end if
	
	if sAtype = "V" then
      '  sSQL = sSQL & " AND isnull(DT_RESIGN) "
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
	    sSQL = sSQL & "AND tmclk2.EMP_CODE ='" & pRTIN(sEmpCode) & "' "
    end if

	sSQL = sSQL & "order by tmclk2.EMP_CODE,DT_WORK asc "

    rstTMClk2.Open sSQL, conn, 3, 3
	if not rstTMClk2.eof then
			
    	do while not rstTMClk2.eof
				
            sTotalOT = rstTMClk2("TOTALOT")
  
            iTotalOTForThePeriod = iTotalOTForThePeriod + Cint(TimeToMin(rstTMClk2("ATOTALOT")))
    		
            if sApprvOrPend = "P" then
                response.write "<tr valign=top>"
                    response.write "<td>" & Weekdayname(weekday(rstTMCLK2("DT_WORK"),1),True) & "</td>"
				    response.write "<td>" & rstTMCLK2("DT_WORK") & "</td>"
				    response.write "<td>" & rstTMClk2("EMP_CODE") & "</td>"
    		        response.write "<td>" & rstTMClk2("NAME") & "</td>"
                    response.write "<td>" & rstTMClk2("CONT_ID") & "</td>"
			        response.write "<td>" & rstTMCLK2("COST_PART") &  "</td>" 

                    if rstTMCLK2("SHF_CODE") <> "OFF" and rstTMCLK2("SHF_CODE") <> "REST" then
	    			    response.write "<td>" & rstTMCLK2("SHF_CODE") & " " & rstTMCLK2("STIME") & "-" & rstTMCLK2("ETIME") & "</td>"
                    else
        			    response.write "<td>" & rstTMCLK2("SHF_CODE") & "</td>"
                    end if

				    response.write "<td align=center>" & rstTMClk2("TIN") & "</td>"
			        response.write "<td align=center>" & rstTMClk2("TOUT") & "</td>"
			        response.write "<td align=center>" & TimeToDec2(rstTMClk2("TOTAL")) & "</td>"
			        response.write "<td align=center>" & TimeToDec2(sTotalOT) & "</td>"
			        response.write "<td align=center>" & RoundOT(sTotalOT) & "</td>"
			        response.write "<td align=center>" & TimeToDec2(rstTMClk2("ATOTALOT")) & "</td>"
                    
                    '=== OT Code/Rate Column
			        Set rstTMOTCODE = server.CreateObject("ADODB.RecordSet")  
                    sSQL = "select * from TMOTCODE where GRADE_ID ='" & rstTMClk2("GRADE_ID") & "'"
		            rstTMOTCODE.Open sSQL, conn, 3, 3
		            if not rstTMOTCODE.eof then
                        Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMHOL1 where HOL_ID = '" & rstTMCLK2("HOL_ID") & "'"
                        sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMCLK2("DT_WORK")) & "'" 
                        rstDT_HOL.Open sSQL, conn, 3, 3
                        if not rstDT_HOL.eof then '=== It's a holiday
                            if rstDT_HOL("REPLA") = "N" then  '==== Not a replacement then rate is 3.0
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("PUBLIC") & "</td>"
    				        else  '=== is a replacement then rate is 1.5
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("NORMAL") & "</td>"
    				        end if
                        else '=== Not a holiday
                            if rstTMCLK2("SHF_CODE") = "REST" then  '=== It's a REST Day
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("REST") & "</td>"
                	        elseif rstTMCLK2("SHF_CODE") = "OFF" then '=== It's a OFF day 
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("OFF") & "</td>"
                            else '=== Normal OT
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("NORMAL") & "</td>"
    				        end if
                        end if
                    end if

                    response.write "<td>" & rstTMClk2("2OTAPVBY") & "</td>"
                    response.write "<td>" & rstTMClk2("1OTAPVBY") & "</td>"

                response.write "</tr>"

            else

			    response.write "<tr valign=top>"
                    response.write "<td>" & Weekdayname(weekday(rstTMCLK2("DT_WORK"),1),True) & "</td>"
				    response.write "<td>" & rstTMCLK2("DT_WORK") & "</td>"
				    response.write "<td>" & rstTMClk2("EMP_CODE") & "</td>"
    		        response.write "<td>" & rstTMClk2("NAME") & "</td>"
                    response.write "<td>" & rstTMClk2("CONT_ID") & "</td>"
			        'response.write "<td align=left>" & rstTMCLK2("COST_ID") & "-" & rstTMCLK2("COST_PART") &  "</td>"
                    response.write "<td>" & rstTMCLK2("COST_PART") &  "</td>"

				    if rstTMCLK2("SHF_CODE") <> "OFF" and rstTMCLK2("SHF_CODE") <> "REST" then
	    			    response.write "<td>" & rstTMCLK2("SHF_CODE") & " " & rstTMCLK2("STIME") & "-" & rstTMCLK2("ETIME") & "</td>"
                    else
        			    response.write "<td>" & rstTMCLK2("SHF_CODE") & "</td>"
                    end if

                    response.write "<td align=center>" & rstTMClk2("TIN") & "</td>"
			        response.write "<td align=center>" & rstTMClk2("TOUT") & "</td>"
			        response.write "<td align=center>" & TimeToDec2(rstTMClk2("TOTAL")) & "</td>"
			        response.write "<td align=center>" & TimeToDec2(sTotalOT) & "</td>"
			        response.write "<td align=center>" & RoundOT(sApvOT) & "</td>"
			        response.write "<td align=center>" & TimeToDec2(rstTMClk2("ATOTALOT")) & "</td>"

                    Set rstTMOTCODE = server.CreateObject("ADODB.RecordSet")  
                    sSQL = "select * from TMOTCODE where GRADE_ID ='" & rstTMClk2("GRADE_ID") & "'"
		            rstTMOTCODE.Open sSQL, conn, 3, 3
		            if not rstTMOTCODE.eof then
                        Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMHOL1 where HOL_ID = '" & rstTMCLK2("HOL_ID") & "'"
                        sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMCLK2("DT_WORK")) & "'" 
                        rstDT_HOL.Open sSQL, conn, 3, 3
                        if not rstDT_HOL.eof then '=== It's a holiday
                            if rstDT_HOL("REPLA") = "N" then  '==== Not a replacement then rate is 3.0
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("PUBLIC") & "</td>"
    				        else  '=== is a replacement then rate is 1.5
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("NORMAL") & "</td>"
    				        end if
                        else '=== Not a holiday
                            if rstTMCLK2("SHF_CODE") = "REST" then  '=== It's a REST Day
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("REST") & "</td>"
                	        elseif rstTMCLK2("SHF_CODE") = "OFF" then '=== It's a OFF day 
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("OFF") & "</td>"
                            else '=== Normal OT
                                response.write "<td align=center>" & rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("NORMAL") & "</td>"
    				        end if
                        end if
                    end if
                response.write "</tr>"
	        end if				
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
    <%if iTotalOTForThePeriod <> "" then %> 
        <tr>
          <td style="text-align:left">Total Approved OT From <%=dtFrDate %> To <%=dtToDate %> : <%=pFormatDec((iTotalOTForThePeriod/60),2)%></td>
        </tr>
    <%end if%>
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


