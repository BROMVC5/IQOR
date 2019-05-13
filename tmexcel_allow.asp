<!-- #include file="include/connection.asp" -->
<!-- #include file="include/validate.asp" -->
<!-- #include file="include/proc.asp" -->
<html>
<head>
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>
</head>
<body style="background-color: white">
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
sDtTime = tsYear & tsMonth & tsDay & tsHour & tsMinute & tsSecond

%>

<%

sFileName = "Allow_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
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
    
	    sStr = fCol("Day") & sep & fCol("Shift Date") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep 
        sStr = sStr & fCol("Contract") & sep & fCol("Cost Center") & sep & fCol("Shift") & sep 
        sStr = sStr & fCol("Time In") & sep & fCol("Time Out") & sep & fCol("Total ") & sep 
        sStr = sStr & fCol("Minimum Work") & sep & fCol("Allowance Code")	& sep & fCol("Amount") & sep & fCol("SAP Code") 
		objOpenFile.WriteLine sStr
        
		do while not rstTMCLK2.eof
            
            sStr = Weekdayname(weekday(rstTMClk2("DT_WORK"),1),True)  & sep & rstTMCLK2("DT_WORK") & sep & rstTMCLK2("EMP_CODE") & sep & rstTMCLK2("NAME") & sep 
            sStr = sStr & rstTMCLK2("CONT_ID") & sep & rstTMCLK2("COST_PART") & sep & rstTMCLK2("SHF_CODE") & " " & rstTMCLK2("STIME") & "-" & rstTMCLK2("ETIME") & sep
            sStr = sStr & rstTMClk2("TIN") & sep & rstTMClk2("TOUT") & sep & rstTMClk2("TOTAL") & sep 
            sStr = sStr & rstTMClk2("MINWORK") & sep & rstTMClk2("AllowanceCode") & sep & rstTMClk2("ALLOW") & sep & rstTMClk2("SAPALLCODE")
		    objOpenFile.WriteLine sStr
				
		rstTMCLK2.movenext
    	loop
			
	end if
	call pCloseTables(rstTMCLK2)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>