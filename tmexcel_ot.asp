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

sFileName = "OT_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")  
    sSQL = "SELECT TMCLK2.DT_WORK, TMCLK2.EMP_CODE, TMEMPLY.NAME, TMEMPLY.CONT_ID, TMEMPLY.GRADE_ID, tmworkgrp.HOL_ID, TMCLK2.*, TMCOST.COST_ID, TMCOST.PART as COST_PART "
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
	    sSQL = sSQL & "AND tmclk2.EMP_CODE ='" & pRTIN(sEmpCode) & "' "
    end if

	sSQL = sSQL & "order by tmclk2.EMP_CODE,DT_WORK asc "
	rstTMClk2.Open sSQL, conn, 3, 3
	if not rstTMClk2.eof then
        
        if sApprvOrPend = "P" then '=== Pending OT approval

            sStr = fCol("Day") & sep & fCol("Shift Date") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep 
            sStr = sStr & fCol("Contract") & sep & fCol("Cost Center") & sep & fCol("Shift") & sep 
            sStr = sStr & fCol("Time In") & sep & fCol("Time Out") & sep & fCol("Total ") & sep & fCol("Total OT ") & sep 
            sStr = sStr & fCol("Rounded OT ") & sep & fCol("Approved OT")	& sep & fCol("OT Code/Rate") & sep & fCol("Manager") & sep & fCol("Superior")
		    objOpenFile.WriteLine sStr

        else '== Approved OT 

            sStr = fCol("Day") & sep & fCol("Shift Date") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep 
            sStr = sStr & fCol("Contract") & sep & fCol("Cost Center") & sep & fCol("Shift") & sep 
            sStr = sStr & fCol("Time In") & sep & fCol("Time Out") & sep & fCol("Total ") & sep & fCol("Total OT ") & sep 
            sStr = sStr & fCol("Rounded OT ") & sep & fCol("Approved OT") & sep & fCol("OT Code/Rate")
		    objOpenFile.WriteLine sStr

        end if
    		
		do while not rstTMClk2.eof
				
            sTotalOT = rstTMClk2("TOTALOT")
            iTotalOT = TimetoMin(sToTalOT)
            
            '==== SHFCODE and STIME ETIME take care of OFF and REST
            if rstTMCLK2("SHF_CODE") <> "OFF" and rstTMCLK2("SHF_CODE") <> "REST" then
	    		sShift = rstTMCLK2("SHF_CODE") & " " & rstTMCLK2("STIME") & "-" & rstTMCLK2("ETIME")
            else
        		sShift = rstTMCLK2("SHF_CODE")
            end if

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
                        sOTCodeRate =  rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("PUBLIC")
    				else  '=== is a replacement then rate is 1.5
                        sOTCodeRate = rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("NORMAL")
    				end if
                else '=== Not a holiday
                    if rstTMCLK2("SHF_CODE") = "REST" then  '=== It's a REST Day
                        sOTCodeRate = rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("REST")
                	elseif rstTMCLK2("SHF_CODE") = "OFF" then '=== It's a OFF day 
                        sOTCodeRate = rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("OFF")
                    else '=== Normal OT
                        sOTCodeRate = rstTMOTCODE("OTCODE") & " - " & rstTMOTCODE("NORMAL")
    				end if
                end if
            end if

            if sApprvOrPend = "P" then '=== Pending OT approval

                sStr = Weekdayname(weekday(rstTMClk2("DT_WORK"),1),True)  & sep & rstTMCLK2("DT_WORK") & sep & rstTMCLK2("EMP_CODE") & sep & rstTMCLK2("NAME") & sep 
                sStr = sStr & rstTMCLK2("CONT_ID") & sep & rstTMCLK2("COST_PART") & sep & sShift & sep
                sStr = sStr & rstTMClk2("TIN") & sep & rstTMClk2("TOUT") & sep & TimeToDec2(rstTMClk2("TOTAL")) & sep & TimeToDec2(sTotalOT) & sep 
                sStr = sStr & RoundOT(sTotalOT) & sep & TimeToDec2(rstTMClk2("ATOTALOT")) & sep & sOTCOdeRate & sep & rstTMClk2("2OTAPVBY") & sep & rstTMClk2("1OTAPVBY") 
		        objOpenFile.WriteLine sStr

            else '== Approved OT 

		        sStr = Weekdayname(weekday(rstTMClk2("DT_WORK"),1),True)  & sep & rstTMCLK2("DT_WORK") & sep & rstTMCLK2("EMP_CODE") & sep & rstTMCLK2("NAME") & sep 
                sStr = sStr & rstTMCLK2("CONT_ID") & sep & rstTMCLK2("COST_PART") & sep & sShift & sep
                sStr = sStr & rstTMClk2("TIN") & sep & rstTMClk2("TOUT") & sep & TimeToDec2(rstTMClk2("TOTAL")) & sep & TimeToDec2(sTotalOT) & sep 
                sStr = sStr & RoundOT(sTotalOT) & sep & TimeToDec2(rstTMClk2("ATOTALOT")) & sep & sOTCOdeRate
		        objOpenFile.WriteLine sStr		
    		end if

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