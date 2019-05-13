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

%>


<%
private sub pageHeader()

	response.write "<table cellSpacing=0 cellpadding=0 width=1100 >"
		response.write "<tr>"
			response.write "<td width=100 align=left>  Report : Daily Attendance Report</td>"
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
		response.write "<td style='width:7%'>Shift Date</td>"
        response.write "<td style='width:6%'>Contract</td>"
		response.write "<td style='width:13%'>Cost Center</td>"
		response.write "<td style='width:12%'>Shift</td>"
		response.write "<td align=center colspan='2' style='width:10%'>Time</td>"
		response.write "<td align=center style='width:6%'>Total</td>"
		response.write "<td align=center style='width:6%'>Total</td>"
		response.write "<td align=center style='width:6%'>Approved</td>"
        response.write "<td style='width:17%'>Time Off</td>"
		response.write "<td style='width:14%'>Status</td>"
	response.write "</tr>"
	response.write "<tr class='botLine'>"
		response.write "<td>&nbsp;</td>"
		response.write "<td>&nbsp;</td>"
		response.write "<td>&nbsp;</td>"
		response.write "<td>&nbsp;</td>"
		response.write "<td>&nbsp;</td>"
		response.write "<td align=center>In</td>"
		response.write "<td align=center>Out</td>"
		response.write "<td>&nbsp;</td>"
		response.write "<td align=center>OT</td>"
		response.write "<td align=center>OT</td>"
		response.write "<td colspan=2>&nbsp;</td>"
        response.write "<td colspan=2>&nbsp;</td>"
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


</head>
<body>
<center>
<%

 call pageHeader()
 
%>

<%

Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    

sSQL = "select tmshiftot.DT_SHIFT, tmshiftot.EMP_CODE as EMP_CODEFrSched, tmshiftot.SHF_CODE as SHF_CODEFrSched, " 
sSQL = sSQL & " tmshfcode.STIME as START_TIME,tmshfcode.ETIME as END_TIME, " 
sSQL = sSQL & " tmclk2.SHF_CODE as SHIFT_CODE, tmclk2.*,tmemply.*, tmcost.cost_id as COST_ID,tmcost.part as COST_PART from tmshiftot " 
sSQL = sSQL & " left join tmshfcode on tmshiftot.SHF_CODE = tmshfcode.SHF_CODE"  
sSQL = sSQL & " left join tmclk2 on tmshiftot.DT_SHIFT = tmclk2.DT_WORK and tmshiftot.EMP_CODE= tmclk2.EMP_CODE"
sSQL = sSQL & " left join tmemply on tmshiftot.EMP_CODE= tmemply.EMP_CODE"
sSQL = sSQL & " left join tmcost on tmemply.COST_ID= tmcost.COST_ID"
sSQL = sSQL & " where (DT_SHIFT between '" & fdate2(dtFrDate) & "' and '" & fdate2(dtToDate) & "')"     
    
    if sAtype = "V" then
        'sSQL = sSQL & " and isnull(DT_RESIGN) "
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
                'sSQL1 = sSQL1 & " and isnull(DT_RESIGN) "
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
        'sSQL1 = sSQL1 & " and isnull(DT_RESIGN) "
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
	    sSQL = sSQL & "AND tmshiftot.EMP_CODE ='" & pRTIN(sEmpCode) & "' "
    end if

sSQL = sSQL & "order by tmshiftot.EMP_CODE,tmshiftot.DT_SHIFT asc "

rstTMClk2.Open sSQL, conn, 3, 3
if not rstTMClk2.eof then
	sPrevEmpCode = rstTMClk2("EMP_CODE")
	record = 0
	bPrint = true
		
	do while not rstTMClk2.eof
	    
        sTimeOffColumn = ""
        sStatus  = ""

        if isNull(rstTMCLK2("DT_RESIGN")) then
            sDtResign = "9999-12-31"
        else
            sDtResign = rstTMCLK2("DT_RESIGN")
        end if 

		if rstTMClk2("EMP_CODE") <> sPrevEmpCode then
			record = record + 1
		 	sPrevEmpCode = rstTMClk2("EMP_CODE")
		 	response.write "<tr valign=top>"
			response.write "<td><br></td>"
			response.write "</tr>"
			record = record + 1
		 	bPrint = true
		end if	
		
		if bPrint = true then
			response.write "<tr valign=top>"
			response.write "<td style='font-weight:bold' align=left colspan='2'>" & rstTMClk2("EMP_CODE") & "</td>"
			response.write "<td colspan='5' style='font-weight:bold' align=left width=260>" & rstTMClk2("NAME") & "</td>"
			response.write "</tr>"
			bPrint = false
		else
			response.write "<tr valign=top>"
			response.write "<td></td>"
			response.write "<td></td>"
			response.write "</tr>"	
		end if
	
        response.write "<tr>"
    
            if CDate(rstTMCLK2("DT_SHIFT")) <= CDate(sDtResign) then '=== Anything before resign date
                sEMP_CODE = rstTMCLK2("EMP_CODE")
                response.write "<td>" & Weekdayname(weekday(rstTMCLK2("DT_SHIFT"),1),True) & "</td>"
                response.write "<td>" & rstTMCLK2("DT_SHIFT") & "</td>"
                response.write "<td>" & rstTMCLK2("CONT_ID") & "</td>"
                response.write "<td>" & rstTMCLK2("COST_PART") & "</td>"
                'response.write "<td>" & rstTMCLK2("COST_ID") & " - " & rstTMCLK2("COST_PART") & "</td>"

                '===Shift column==========================================================
                if not isnull(rstTMCLK2("SHIFT_CODE")) then

                    if rstTMCLK2("SHIFT_CODE") ="OFF" or rstTMCLK2("SHIFT_CODE") ="REST" then
                        response.write "<td>" & rstTMCLK2("SHIFT_CODE") & "</td>"
                        sStatus = sStatus & rstTMCLK2("SHIFT_CODE") & " " 
                    else
                        response.write "<td>" & rstTMCLK2("SHIFT_CODE") & " " & rstTMCLK2("STIME") & "-" & rstTMCLK2("ETIME") & "</td>"
                            
                        if  rstTMCLK2("SHIFT_CODE") <> "" and ( rstTMCLK2("HALFDAY") = "" or rstTMCLK2("HALFDAY") = "N" ) then
                            sStatus = sStatus & "Normal " 
                        elseif rstTMCLK2("SHIFT_CODE") <> "" and rstTMCLK2("HALFDAY") = "Y" then
                            sStatus = sStatus & "0.5 Day Work"
                        elseif isnull(rstTMCLK2("SHIFT_CODE")) then
                            sStatus = sStatus & "No Schedule " 
                        end if
                    end if
                else
                    if rstTMCLK2("SHF_CODEFrSched") ="OFF" or rstTMCLK2("SHF_CODEFrSched") ="REST" then
                        response.write "<td>" & rstTMCLK2("SHF_CODEFrSched") & "</td>"
                        sStatus = sStatus & rstTMCLK2("SHF_CODEFrSched") & " " 
                    else
                        response.write "<td>" & rstTMCLK2("SHF_CODEFrSched") & " " & rstTMCLK2("START_TIME") & "-" & rstTMCLK2("END_TIME") & "</td>"
                            
                        if  rstTMCLK2("SHF_CODEFrSched") <> "" and ( rstTMCLK2("HALFDAY") = "" or rstTMCLK2("HALFDAY") = "N" ) then
                            sStatus = sStatus & "Normal " 
                        elseif rstTMCLK2("SHF_CODEFrSched") <> "" and rstTMCLK2("HALFDAY") = "Y" then
                            sStatus = sStatus & "0.5 Day Work"
                        elseif isnull(rstTMCLK2("SHF_CODEFrSched")) then
                            sStatus = sStatus & "No Schedule " 
                        end if
                    end if
                end if
                '=========================================================================
            
                response.write "<td align=center>" & rstTMCLK2("TIN") & "</td>"
                response.write "<td align=center>" & rstTMCLK2("TOUT") & "</td>"
                response.write "<td align=center>" & TimeToDec2(rstTMCLK2("TOTAL")) & "</td>"

                if rstTMCLK2("OT") = "Y" then
                    response.write "<td align=center>" & TimeToDec2(rstTMCLK2("TOTALOT")) & "</td>"
                else
                    response.write "<td align=center></td>"
                end if
                response.write "<td align=center>" & TimeToDec(rstTMCLK2("3ATOTALOT")) & "</td>" '=== Only Final approval by Verifier then only APVOT will appear
                
                '=======Time Off column consist of Employee Time Off=============
                Set rstTMABSENT = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMABSENT where EMP_CODE = '" & sEMP_CODE & "'"
                sSQL = sSQL & " and DT_ABSENT = '" & fdate2(rstTMClk2("DT_SHIFT")) & "'" 
                rstTMABSENT.Open sSQL, conn, 3, 3
                if not rstTMABSENT.eof then '=== Absent is recorded
                    Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMEOFF where "
                    sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                    sSQL = sSQL & " and ('" & fdate2(rstTMABSENT("DT_ABSENT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                    rstTMEOFF.Open sSQL, conn, 3, 3
                    if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off

                        if rstTMABSENT("TYPE") = "F" then '=== Check the ABSENT recorded as FULL or HALF
                            sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                        else '=== Half Day leave
                            sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART") & " - " & rstTMEOFF("DURA") & " Day 0.5 Absent"
                        end if

                    else '=== Never Apply leave
                        sTimeOffColumn =  "Absent"
                    end if

                else '=== No Absent recorded, Not working check if is it a Holiday
    'response.write " 1s: " & sSQL &"<br>"
                    if isNull(rstTMCLK2("TOTAL")) then
                        Set rstTMHOL1 = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "SELECT tmworkgrp.HOL_ID, tmhol1.* FROM tmworkgrp "
                        sSQL = sSQL & " left join tmhol1 on tmhol1.HOL_ID = tmworkgrp.HOL_ID "
                        sSQL = sSQL & " where tmworkgrp.EMP_CODE = '" & sEMP_CODE & "'"
                        sSQL = sSQL & " and tmhol1.DT_HOL = '" & fdate2(rstTMClk2("DT_SHIFT")) & "'" 
                        rstTMHOL1.Open sSQL, conn, 3, 3
                        if not rstTMHOL1.eof then '=== it is a holiday

        'response.write " 2s: " & sSQL &"<br>"
                            sTimeOffColumn = rstTMHOL1("PART")
                            sStatus = "Holiday"
                            '=== Check if the person accidentally apply for leave on Holiday
                            Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                            sSQL = "select * from TMEOFF where "
                            sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                            sSQL = sSQL & " and ('" & fdate2(rstTMCLk2("DT_SHIFT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                            rstTMEOFF.Open sSQL, conn, 3, 3
                            if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off
                                if rstTMEOFF("LTYPE") = "F" then '=== Check the Leave applied is Full or Half
                                    sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                                else '=== Half Day leave
                                        sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART") & " - " & rstTMEOFF("DURA") & " Day "
                                end if
                            end if
                        else '===Not holiday, A Normal Working with Scheduled day 
                            if rstTMCLK2("SHF_CODEFrSched") ="OFF" or rstTMCLK2("SHF_CODEFrSched") ="REST" then
                                sTimeOffColumn = ""
                            else
                                '=== Check if it is on sick leave 
                                Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMEOFF where "
                                sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                                sSQL = sSQL & " and ('" & fdate2(rstTMCLk2("DT_SHIFT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                                rstTMEOFF.Open sSQL, conn, 3, 3
    'response.write sSQL
    'response.end
                                if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off
                                    if rstTMEOFF("LTYPE") = "F" then '=== Check the Leave applied is Full or Half
                                        sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                                    else '=== Half Day leave
                                        sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART") & " - " & rstTMEOFF("DURA") & " Day "
                                    end if
                                end if
                            end if
                        end if
                    else
                        '=== Check if it is on sick leave 
                        Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEOFF where "
                        sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                        sSQL = sSQL & " and ('" & fdate2(rstTMCLk2("DT_SHIFT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                        rstTMEOFF.Open sSQL, conn, 3, 3
'response.write sSQL
'response.end
                        if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off
                            if rstTMEOFF("LTYPE") = "F" then '=== Check the Leave applied is Full or Half
                                sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                            else '=== Half Day leave
                                sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART") & " - " & rstTMEOFF("DURA") & " Day "
                            end if
                        end if
                    end if
                end if

                response.write "<td>" & sTimeOffColumn & "</td>"

                '==================================================================================================

                '===== STATUS column NORMAL, OFF, REST and OT if got, IRREG or INCOMPLETE============================
                if (rstTMCLK2("OTIN") = "" or rstTMCLK2("OTOUT") = "") and isNull(rstTMCLK2("2DTAPV")) then '==Incomplete, only after verifier will not show
                    sStatus = sStatus & " Incomplete " 
                    
                elseif rstTMCLK2("IRREG") = "Y" and isNull(rstTMCLK2("2DTAPV")) then '=== Only after verifier approve will disappear
                    sStatus = sStatus & " Irregular " 
                end if    
                    
                if rstTMCLK2("TOTALOT") <> "00:00" and rstTMCLK2("TOTALOT") <> ""  then
                    sStatus = sStatus & " OT "
                end if

                if rstTMCLK2("LATE") = "Y" and rstTMCLK2("EARLY") ="Y" then
                    sStatus = sStatus & " Late and Early Dimiss "
                elseif rstTMCLK2("LATE") = "Y" then
                    sStatus = sStatus & " Late "
                elseif rstTMCLK2("EARLY") = "Y" then
                    sStatus = sStatus & " Early Dismiss "
                end if
                
                if not isnull(rstTMCLK2("EARLY")) then '=== Simply that a field that will be null if no record
                    response.write "<td>" & sStatus & "</td>"
                else
                    response.write "<td>" & sStatus & " No info </td>"
                end if
                '=====================================================================================================  
            
            elseif CDate(rstTMCLK2("DT_SHIFT")) > CDate(sDtResign) then

                response.write "<td>" & Weekdayname(weekday(rstTMCLK2("DT_SHIFT"),1),True) & "</td>"
                response.write "<td>" & rstTMCLK2("DT_SHIFT") & "</td>"  
                response.write "<td>Resigned</td>"

            end if
        response.write "</tr>"
			
	    rstTMClk2.movenext

	    if sPageBreak = "Y" then

		    record = record + 1
	
            if record >= 42 and not rstTMClk2.eof then
		
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


