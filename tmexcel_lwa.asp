<!-- #include file="include/connection.asp" -->
<!-- #include file="include/validate.asp" -->
<!-- #include file="include/proc.asp" -->
<html>
<head>
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>
</head>
<body style="background-color: white">
<%
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
<!-- AM/PM Time -->
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

<!-- Column Function -->
<%
sep = chr(9)

Function fCol(dTemp)

	fCol = dTemp
	
End Function

%>

<!-- DateTime -->
<%
tsYear = Year(date())
tsMonth = month(date())
tsDay = day(date())
If len(tsMonth)=1 then tsMonth = "0" & tsMonth
If len(tsDay)=1 then tsDay = "0" & tsDay

tsHour = Hour(formatdatetime(now(),4))
tsMinute = Minute(formatdatetime(now(),4))
tsSecond = Second(formatdatetime(now(),3))
If len(tsHour) = 1 then tsHour = "0" & tsHour
If len(tsMinute) = 1 then tsMinute = "0" & tsMinute
If len(tsSecond) = 1 then tsSecond = "0" & tsSecond
sDtTime = tsYear & tsMonth & tsDay & "_" & tsHour & tsMinute & tsSecond

%>

<%

sFileName = "LeaveWithAttend_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select tmclk2.*, tmeoff.* ,tmemply.EMP_CODE, tmemply.NAME, tmemply.COST_ID, tmcost.PART as COST_PART, "
    sSQL = sSQL & " tmemply.SUP_CODE, tmemply.CONT_ID, tmworkgrp.WORKGRP_ID from tmclk2 "
    sSQL = sSQL & " left join tmeoff on tmclk2.EMP_CODE = tmeoff.EMP_CODE "
    sSQL = sSQL & " left join tmworkgrp on tmclk2.EMP_CODE = tmworkgrp.EMP_CODE "
    sSQL = sSQL & " left join tmemply on tmclk2.EMP_CODE = tmemply.EMP_CODE "
    sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id "  
    sSQL = sSQL & " where DT_WORK BETWEEN DTFR AND DTTO "
    sSQL = sSQL & " and DT_WORK BETWEEN '" & fDate2(dtFrDate) & "' AND '" & fDate2(dtToDate) & "' "
    
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
        sSQL = sSQL & " and tmworkgrp.WORKGRP_ID = '" & sWorkGrpID & "' "
    end if

	sSQL = sSQL & " order by tmclk2.DT_WORK asc, tmemply.SUP_CODE  "
    	
    rstTMClk2.Open sSQL, conn, 3, 3
	    
        sStr = fCol("Day") & sep & fCol("Date") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Contract") & sep
        sStr = sStr & fCol("Cost Center") & sep & fCol("Work Group") & sep & fCol("Shift") & sep & fCol("Time In") & sep & fCol("Time Out") & sep & fCol("Code") & sep & fCol("Description") 	
	    objOpenFile.WriteLine sStr		

		if not rstTMClk2.eof then
	
			do while not rstTMClk2.eof
                	
                'Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")    
				'sSQL = "select * from TMEMPLY where EMP_CODE='" & rstTMClk2("SUP_CODE") & "'" 
				'rstTMSUPNAME.Open sSQL, conn, 3, 3
				'if not rstTMSUPNAME.eof then
				'	sSupName = rstTMSUPNAME("NAME")
				'else
				'	sSupName = ""
				'end if
					
                Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")    
				sSQL = "select * from tmshfcode where SHF_CODE='" & rstTMClk2("SHF_CODE") & "'" 
				rstTMSUPNAME.Open sSQL, conn, 3, 3
				if not rstTMSUPNAME.eof then
					sSTime = rstTMSUPNAME("STIME") 
					sETime = rstTMSUPNAME("ETIME") 
				end if
				    
                sCOde = "9000"
				sDesc = "Absent" 
	
                sStr = Weekdayname(weekday(rstTMClk2("DT_WORK"),1),True)  & sep & rstTMClk2("DT_WORK") & sep & rstTMClk2("EMP_CODE") & sep
                sStr = sStr & rstTMClk2("NAME") & sep & rstTMClk2("CONT_ID") & sep & rstTMCLK2("COST_PART") & sep & rstTMCLK2("WORKGRP_ID") & sep 
                sStr = sStr & rstTMCLK2("SHF_CODE") & " " & sSTIME & "-" & sETIME & sep & rstTMClk2("TIN") & sep & rstTMClk2("TOUT") & sep 
                sStr = sStr & rstTMClk2("TOFF_ID") & sep & rstTMClk2("PART") 
	    	    objOpenFile.WriteLine sStr
	
    		rstTMClk2.movenext
       	loop
	end if
	call pCloseTables(rstTMClk2)

objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>