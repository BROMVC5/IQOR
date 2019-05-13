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
Server.ScriptTimeout = 10000000

sLogin = session("USERNAME")

Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMEMPLY where "
sSQL = sSQL & " EMP_CODE ='" & sLogin & "'"  
rstTMEMPLY.Open sSQL, conn, 3, 3
if not rstTMEMPLY.eof then
    sAType = rstTMEMPLY("ATYPE")
end if 

sContID = request("txtContID")
sCostID = request("txtCostID")
sEmpCode = request("txtEmpCode")
sPageBreak = request("cboPageBreak")
sWorkGrpID = request("txtWorkGrpID")
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

if sWorkGrpID = "" then
    sWorkGrpID = "ALL"
end if
%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100 >"
		response.write "<tr>"
				response.write "<td width=100 align=left>  Report : Absent for 3 Consecutive Days Report</td>"
		
			response.write "<td width=200 align=center><STRONG style='font-weight: 400'>TIME MANAGEMENT</STRONG></td>"
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
	
	response.write "<table cellSpacing=0 cellpadding=0 width=1100 class='fontrptdetail' >"
		
        response.write "<tr class='spacing'>"
            response.write "<td colspan=12>&nbsp;</td>"
        response.write "</tr>"
		response.write "<tr class='topBotLine'>"
			response.write "<td style='width:6%'>Emp Code</td>"
			response.write "<td style='width:20%'>Employee Name</td>"
			response.write "<td style='width:20%'>Superior</td>"
            response.write "<td style='width:14%'>Work Group</td>"
			response.write "<td style='width:7%'>Contract</td>"
			response.write "<td style='width:12%'>Cost Center</td>"
            response.write "<td style='width:7%'>Date From</td>"
			response.write "<td style='width:7%'>Date To</td>"
			response.write "<td style='width:6%'>Total Days</td>"
		response.write "</tr>"
		response.write "<tr>"
			response.write "<td colspan=7>"
		        response.write "Work Group ID : "& sWorkGrpID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	            response.write "Employee Code : "& sEmpCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	            response.write "Contract ID : "& sContID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	            response.write "Cost Center : "& sCostID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                response.write "<br/>"
	            response.write "<br/>"
		    response.write "</td>"	
        response.write "</tr>"
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
    Set rstTMABSENT3 = server.CreateObject("ADODB.RecordSet")    
	sSQL = "SELECT TMABSENT3.*, TMEMPLY.NAME, TMEMPLY.SUP_CODE, TMEMPLY.CONT_ID, "
    sSQL = sSQL & " TMCOST.PART as COST_PART FROM TMABSENT3 "
	sSQL = sSQL & " LEFT JOIN TMEMPLY ON TMABSENT3.EMP_CODE = TMEMPLY.EMP_CODE "
    sSQL = sSQL & " LEFT JOIN TMCOST ON TMEMPLY.COST_ID = TMCOST.COST_ID "
    sSQL = sSQL & " where 1=1 "

	if sAtype = "V" then
        'sSQL = sSQL & " AND isnull(DT_RESIGN) "

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

    if sWorkGrpID <> "ALL" then
        sSQL = sSQL & " and tmabsent3.WORKGRP_ID = '" & sWorkGrpID & "' "
    end if

    sSQL = sSQL & "order by DTFR desc, tmemply.SUP_CODE asc, tmabsent3.workgrp_id asc "

	rstTMABSENT3.Open sSQL, conn, 3, 3
	if not rstTMABSENT3.eof then
		record = 0
		do while not rstTMABSENT3.eof

            Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select NAME from TMEMPLY where "
            sSQL = sSQL & " EMP_CODE = '" & rstTMABSENT3("SUP_CODE") & "'"  
            rstTMEMPLY.Open sSQL, conn, 3, 3
            if not rstTMEMPLY.eof then 
                sSupName = rstTMEMPLY("NAME")
            end if
            call pCloseTables(rstTMEMPLY)
									
			response.write "<tr valign=top>"
			    response.write "<td>" & rstTMABSENT3("EMP_CODE") & "</td>"
			    response.write "<td>" & rstTMABSENT3("NAME") & "</td>"
                response.write "<td>" & sSupName & "</td>"
                response.write "<td>" & rstTMABSENT3("WORKGRP_ID") & "</td>"
                response.write "<td>" & rstTMABSENT3("CONT_ID") & "</td>"
                response.write "<td>" & rstTMABSENT3("COST_PART") & "</td>"
			    response.write "<td>" & rstTMABSENT3("DTFR")& "</td>"
			    response.write "<td>" & rstTMABSENT3("DTTO") & "</td>"
			    response.write "<td align='center'>" & rstTMABSENT3("DURA") & "</td>"
			response.write "</tr>"		
							
		    rstTMABSENT3.movenext

		    record = record + 1

		    if record >= 37 and not rstTMABSENT3.eof then
        	    response.write "</table>"
			    record = 0
			    response.write "<br/>"
			    response.Write "Continue Next Page..."    
			    response.write "<p style='page-break-before: always'></p>"
			    sPage = sPage + 1
                call pageHeader()
		    end if
					
		loop		
		call pCloseTables(rstTMABSENT3)
	end if
	
	response.write "</table>"

%>		
	<table cellSpacing=0 cellpadding=0 width=1100 class="fontrptdetail">		
		<tr>
            <br />
		    <td colspan=5><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
	    </tr>
	    <tr>
		    <td align=left>End of Report</td>
	    </tr>
	</table>

</center>
</body>


</html>


