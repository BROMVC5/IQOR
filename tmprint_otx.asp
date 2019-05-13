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

Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
sSQL = "select OTXHOUR from TMPATH"
rstTMPATH.Open sSQL, conn, 3, 3
if not rstTMPATH.eof then
    sOTX = (rstTMPATH("OTXHOUR"))
    sOTXMin = Cint((mid(sOTX,1,2))*60) + Cint((mid(sOTX,4,2)))
end if
%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=850 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Overtime Exceeded " & sOTXhour & " Hours</td>"
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
	
	response.write "<table cellSpacing=0 cellpadding=0 width=850 class='fontrptdetail' >"			
    
        response.write "<tr class='spacing'>"
                response.write "<td colspan=12>&nbsp;</td>"
        response.write "</tr>"	
	    response.write "<tr class='topLine'>"
            response.write "<td style='width:3%'>No</td>"
			response.write "<td style='width:9%'>Employee</td>"
			response.write "<td style='width:23%'>Employee Name</td>"
			response.write "<td style='width:23%'>Superior</td>"
            response.write "<td style='width:7%'>Contract</td>"
			response.write "<td style='width:19%'>Cost Center</td>"
            response.write "<td style='width:8%' align='right'>Total</td>"
			response.write "<td style='width:8%' align='right'>Exceeded</td>"
        response.write "</tr>"
		response.write "<tr class='botLine' >"
			response.write "<td>&nbsp;</td>"
			response.write "<td>Code</td>"
			response.write "<td>&nbsp;</td>"
			response.write "<td>&nbsp;</td>"
			response.write "<td>&nbsp;</td>"
            response.write "<td>&nbsp;</td>"
			response.write "<td align='right'>OT</td>"
	        response.write "<td align='right'>OT</td>"
		response.write "</tr>"
		response.write "<tr>"
		    response.write "<td colspan='10' align='left'>"
		    response.write "Date : "& dtFrDate &"  To "& dtToDate &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Contract : "& sContID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Employee Code : "& sEmpCode &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
		    response.write "Cost Center : "& sCostID &" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
 
%>

<%
Set rstTMEmply = server.CreateObject("ADODB.RecordSet") 
sSQL = "select tmclk2.dt_work, tmemply.emp_code,tmemply.name, tmemply.sup_code, tmemply.cont_id, tmemply.cost_id, " 
sSQL = sSQL & " tmcost.part, tmworkgrp.WORKGRP_ID, tmworkgrp.HOL_ID, tmclk2.* from tmemply"
sSQL = sSQL & " left join tmworkgrp on tmemply.EMP_CODE = tmworkgrp.EMP_CODE "
sSQL = sSQL & " left join tmclk2 on tmemply.emp_code = tmclk2.emp_code "  
sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id "  
sSQL = sSQL & " where (DT_WORK BETWEEN '" & fDate2(dtFrDate) & "' AND '" & fDate2(dtToDate) & "') "
sSQL = sSQL & " AND OTAPV = 'Y' " '=== only after OT approved
sSQL = sSQL & " AND GENSHF='Y' "  '=== only those that punch in and punch out
'sSQL = sSQL & " AND isnull(DT_RESIGN) " '=== Only those employed
sSQL = sSQL & " AND SHF_CODE <> 'REST' " '=== Eliminate OT payout 2.0

if sEmpCode <> "ALL" then
	sSQL = sSQL & " and tmemply.EMP_CODE ='" & pRTIN(sEmpCode) & "' "
end if

if sContID <> "ALL" then
	sSQL = sSQL & " and tmemply.CONT_ID ='" & pRTIN(sContID) & "' "
end if

if sCostID <> "ALL" then
	sSQL = sSQL & " and tmemply.COST_ID ='" & pRTIN(sCostID) & "' "
end if

sSQL = sSQL & " order by tmclk2.emp_code,dt_work"

rstTMEmply.Open sSQL, conn, 3, 3
if not rstTMEmply.eof then

    if sEmpCode <> "ALL" then '=== Only that particular Employee
    
        do while not rstTMEmply.eof
	        sHoliday = ""
            
            Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMHOL1 where HOL_ID = '" & rstTMEmply("HOL_ID") & "'"
            sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMEmply("DT_WORK")) & "'" 
            rstDT_HOL.Open sSQL, conn, 3, 3
            if rstDT_HOL.eof then ' Empty not a Holiday

                iAddOT = iAddOT + Cint(TimetoMin(rstTMEmply("ATOTALOT")))
    
            end if        
            
            rstTMEMPLY.movenext
        loop		
	
        if iAddOT >=Cint(sOTXMin)  then ' ========= Cint(sOTXMin)

            dAddOT = iAddOT / 60 '=== Need to show them in decimal
            
            iExceed = Cint(iAddOT)-Cint(sOTXMin) ' ========= Cint(sOTXMin)
            dExceed = iExceed / 60  '=== Need to show them in decimal format

            sRecord = sRecord + 1
        
			response.write "<tr valign=top>"
				response.write "<td>" & sRecord & "</td>"
    			response.write "<td>" & sEmpCode & "</td>"

    			Set rstTMPREV = server.CreateObject("ADODB.RecordSet")  
                sSQL = "select tmemply.NAME, SUP_CODE, CONT_ID, tmemply.COST_ID, tmcost.part from TMEMPLY "
                sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id " 
                sSQL = sSQL & " where EMP_CODE ='" & sEmpCode & "'"
		        rstTMPREV.Open sSQL, conn, 3, 3
		        if not rstTMPREV.eof then
                    
                    response.write "<td>" & rstTMPREV("NAME") & "</td>"
                    'response.write "<td>" & rstTMPREV("SUP_CODE") & "</td>"
                
                    Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")  
                    sSQL = "select NAME from TMEMPLY where EMP_CODE ='" & rstTMPREV("SUP_CODE") & "'"
		            rstTMSUPNAME.Open sSQL, conn, 3, 3
		            if not rstTMSUPNAME.eof then
                        response.write "<td>" & rstTMSUPNAME("NAME") & "</td>"
                    end if

                    response.write "<td>" & rstTMPREV("CONT_ID") & "</td>"
                    response.write "<td>" & rstTMPREV("PART") & "</td>"
                end if

				response.write "<td align='right'>" & pFormatDec(dAddOT,2) & "</td>"
				response.write "<td align='right'>" & pFormatDec(dExceed,2) & "</td>"

			response.write "</tr>"
	
			if sPageBreak = "Y" then
				
                record = record + 1

				if record >= 37 and not rstTMEMPLY.eof then
				
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

            iAddOT = 0	
		end if
    	
    else
     
        do while not rstTMEmply.eof
            
            if sPreEmpCode <> rstTMEmply("EMP_CODE") then '=== Initial sPreEmp_Code is empty, then it is different with new recordset rstTMEMply("EMP_CODE")
                
                sPreEmpCode = rstTMEmply("EMP_CODE") '==== Then it take on the new record set value, but when new record set changes, it will be different with sPreEmp_Code
                
                Set rstTMEmply2 = server.CreateObject("ADODB.RecordSet")
                sSQL = "select tmclk2.dt_work, tmemply.emp_code,tmemply.name, tmemply.sup_code, tmemply.cont_id, tmemply.cost_id, " 
                sSQL = sSQL & " tmcost.part, tmworkgrp.WORKGRP_ID, tmworkgrp.HOL_ID, tmclk2.* from tmemply"
                sSQL = sSQL & " left join tmworkgrp on tmemply.EMP_CODE = tmworkgrp.EMP_CODE "
                sSQL = sSQL & " left join tmclk2 on tmemply.emp_code = tmclk2.emp_code "  
                sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id " 
                sSQL = sSQL & "where (DT_WORK BETWEEN '" & fDate2(dtFrDate) & "' AND '" & fDate2(dtToDate) & "') "
                sSQL = sSQL & " AND OTAPV = 'Y' " '=== only after OT approved
                sSQL = sSQL & " AND GRADE_ID <> 'M6' and GRADE_ID <> 'M8'"  '=== only those that punch in and punch out
                'sSQL = sSQL & " AND isnull(DT_RESIGN) " '=== Only those employed
                sSQL = sSQL & " AND SHF_CODE <> 'REST' " '=== Eliminate OT payout 2.0
                sSQL = sSQL & " and tmemply.EMP_CODE ='" & sPreEmpCode & "' "
                sSQL = sSQL & " order by tmclk2.emp_code,dt_work"
                rstTMEmply2.Open sSQL, conn, 3, 3
                if not rstTMEmply2.eof then
                    do while not rstTMEmply2.eof

                        Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMHOL1 where HOL_ID = '" & rstTMEmply("HOL_ID") & "'"
                        sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMEmply("DT_WORK")) & "'" 
                        rstDT_HOL.Open sSQL, conn, 3, 3
                        if rstDT_HOL.eof then 
                           iAddOT = iAddOT + Cint(TimetoMin(rstTMEmply2("ATOTALOT")))
                        end if
                        rstTMEMply2.movenext
                    loop
                end if

	        
                if iAddOT >=Cint(sOTXMin) then ' ========= Cint(sOTXMin)

                    dAddOT = iAddOT / 60 '=== Need to show them in decimal
            
                    iExceed = Cint(iAddOT)-Cint(sOTXMin) ' ========= Cint(sOTXMin)
                    dExceed = iExceed / 60  '=== Need to show them in decimal format
                    
                    sRecord = sRecord + 1
        
			        response.write "<tr valign=top>"

				        response.write "<td>" & sRecord & "</td>"
    			        response.write "<td>" & sPreEmpCode & "</td>"

    			        Set rstTMPREV = server.CreateObject("ADODB.RecordSet") 
                        sSQL = "select tmemply.NAME, SUP_CODE, CONT_ID, tmemply.COST_ID, tmcost.part from TMEMPLY "
                        sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id " 
                        sSQL = sSQL & " where EMP_CODE ='" & sPreEmpCode & "'"
		                rstTMPREV.Open sSQL, conn, 3, 3
		                if not rstTMPREV.eof then
                            response.write "<td>" & rstTMPREV("NAME") & "</td>"
                            'response.write "<td>" & rstTMPREV("SUP_CODE") & "</td>"
                
                            Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")  
                            sSQL = "select NAME from TMEMPLY where EMP_CODE ='" & rstTMPREV("SUP_CODE") & "'"
		                    rstTMSUPNAME.Open sSQL, conn, 3, 3
		                    if not rstTMSUPNAME.eof then
                                response.write "<td>" & rstTMSUPNAME("NAME") & "</td>"
                            end if

                            response.write "<td>" & rstTMPREV("CONT_ID") & "</td>"
                            response.write "<td>" & rstTMPREV("PART") & "</td>"
                            
                        end if
				        response.write "<td align='right'>" & pFormatDec(dAddOT,2) & "</td>"
				        response.write "<td align='right'>" & pFormatDec(dExceed,2) & "</td>"

			        response.write "</tr>"
	
			        if sPageBreak = "Y" then
				        record = record + 1

				        if record >= 37 and not rstTMEMPLY.eof then
				
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

                    iAddOT = 0	
			    
                end if		
    
            end if
            rstTMEMPLY.movenext
        loop		
	    call pCloseTables(rstTMEMPLY)   
	    
    end if
end if
%>

<table cellSpacing=0 cellpadding=0 width=850 class="fontrptdetail">
	
	<tr>
        <br />
		<td colspan=8><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
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


