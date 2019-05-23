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

dtFrDate = request("dtFrDate")
dtToDate = request("dtToDate")
sContID = request("txtContID")
sCostID = request("txtCostID")
sEmpCode = request("txtEmpCode")
sPageBreak = request("cboPageBreak")

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
%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100 >"
		response.write "<tr>"
				response.write "<td width=100 align=left>  Report : Absense Without Leave Report</td>"
		
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
            response.write "<td style='width:3%'>No</td>"
            response.write "<td style='width:3%'>Day</td>"
		    response.write "<td style='width:7%'>Shift Date</td>"
            response.write "<td style='width:20%'>Superior</td>"
            response.write "<td style='width:7%'>Emp Code</td>"
			response.write "<td style='width:20%'>Employee Name</td>"
            response.write "<td style='width:6%'>Contract</td>"
		    response.write "<td style='width:13%'>Cost Center</td>"
            response.write "<td style='width:11%'>Shift</td>"
			response.write "<td style='width:4%'>Code</td>"
            response.write "<td style='width:6%'>Description</td>"

		response.write "</tr>"
		response.write "<tr>"
		    response.write "<td colspan='12' align='left'>"
			    response.write "From Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
	
	Set rstTMABSENT = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select tmabsent.*, tmemply.SUP_CODE, tmemply.EMP_CODE, tmemply.NAME,tmemply.CONT_ID, "
    sSQL = sSQL & " tmcost.PART as COST_PART, tmshiftot.SHF_CODE from tmabsent "
    sSQL = sSQL & " left join tmemply on tmemply.EMP_CODE = tmabsent.EMP_CODE "
    sSQL = sSQL & " left join tmcost on tmcost.COST_ID = tmemply.COST_ID "
    sSQL = sSQL & " left join tmshiftot on tmshiftot.DT_SHIFT = tmabsent.DT_ABSENT and tmshiftot.EMP_CODE = tmabsent.EMP_CODE "
    sSQL = sSQL & " where DT_ABSENT BETWEEN '" & fDate2(dtFrDate) & "' AND '" & fDate2(dtToDate) & "' "
    sSQL = sSQL & " and GENSHF = 'Y' " '=== Only those that got Shift Schedule

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
	    sSQL = sSQL & "AND tmabsent.EMP_CODE ='" & pRTIN(sEmpCode) & "' "
    end if

	sSQL = sSQL & " order by DT_ABSENT asc, tmemply.SUP_CODE  "
    
    rstTMABSENT.Open sSQL, conn, 3, 3
	if not rstTMABSENT.eof then
		do while not rstTMABSENT.eof
			'=== Check if the recorded Absent day got any leave applied
			sSQL = "select * from tmeoff "
			sSQL = sSQL & " where '" & fdate2(rstTMABSENT("DT_ABSENT")) & "' between DTFR and DTTO "
			sSQL = sSQL & " and EMP_CODE ='" & rstTMABSENT("EMP_CODE") & "'"
			set rstTMEOFF= server.createobject("adodb.recordset")
			rstTMEOFF.Open sSQL, conn, 3, 3
			if rstTMEOFF.eof then '=== No leave was applied on this day. Insert as Absence without leave
				i = i + 1
				response.write "<tr valign=top>"
					response.write "<td>" & i & "</td>"
					response.write "<td>" & Weekdayname(weekday(rstTMABSENT("DT_ABSENT"),1),True) & "</td>"
					response.write "<td>" & rstTMABSENT("DT_ABSENT") & "</td>"

					Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")    
					sSQL = "select * from TMEMPLY where EMP_CODE='" & rstTMABSENT("SUP_CODE") & "'" 
					rstTMSUPNAME.Open sSQL, conn, 3, 3
					if not rstTMSUPNAME.eof then
						response.write "<td>" & rstTMSUPNAME("NAME") & "</td>"
					else
						response.write "<td></td>"
					end if
					call pCloseTables(rstTMSUPNAME)

					response.write "<td>" & rstTMABSENT("EMP_CODE") & "</td>"
					response.write "<td>" & rstTMABSENT("NAME") & "</td>"
					response.write "<td>" & rstTMABSENT("CONT_ID") & "</td>"
					response.write "<td>" & rstTMABSENT("COST_PART") &  "</td>"
					
					Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
					sSQL = "select STIME,ETIME from TMSHFCODE where SHF_CODE='" & rstTMABSENT("SHF_CODE") & "'" 
					rstTMSHFCODE.Open sSQL, conn, 3, 3
					if not rstTMSHFCODE.eof then
						sSTIME = rstTMSHFCODE("STIME")
						sETIME = rstTMSHFCODE("ETIME")
					end if
					call pCloseTables(rstTMSHFCODE)

					response.write "<td>" & rstTMABSENT("SHF_CODE") & " " & sSTIME & "-" & sETIME & "</td>"
					
					response.write "<td>9000</td>"
					
					if rstTMABSENT("TYPE") = "H" then
						response.write "<td>Absent 0.5</td>"    
					else
						response.write "<td>Absent</td>"
					end if
				response.write "</tr>"		
			
				record = record + 1
			end if
			call pCloseTables(rstTMEOFF)
			
			rstTMABSENT.movenext
			
		    if record >= 40 and not rstTMABSENT.eof then
				
			    response.write "</table>"
			    record = 0
			    response.write "<br/>"
			    response.Write "Continue Next Page..."    
			    response.write "<p style='page-break-before: always'></p>"
			    sPage = sPage + 1
			    response.write "<br/>"
			    call pageHeader()
		    end if
		
		loop		
		call pCloseTables(rstTMABSENT)
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


