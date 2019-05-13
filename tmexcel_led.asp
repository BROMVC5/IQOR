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

sFileName = "LateNEarly_" & sDtTime & ".xls"

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
    sSQL = sSQL & " and ( TIN <> '' and TOUT <> '' )"
    sSQL = sSQL & " and ( LATE = 'Y' or EARLY = 'Y' )"
    
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
	    sSQL = sSQL & "AND tmclk2.EMP_CODE ='" & pRTIN(sEmpCode) & "' "
    end if

	sSQL = sSQL & "order by tmclk2.EMP_CODE,DT_WORK asc "

    rstTMClk2.Open sSQL, conn, 3, 3
    if not rstTMClk2.eof then
        sStr = fCol("Day") & sep & fCol("Shift Date") & sep & fCol("Employee Code") & sep & fCol("Employee Name") & sep 
        sStr = sStr & fCol("Contract") & sep & fCol("Cost Center") & sep & fCol("Shift") & sep 
        sStr = sStr & fCol("Time In") & sep & fCol("Time Out") & sep & fCol("Total ") & sep & fCol("Remark") 
    	objOpenFile.WriteLine sStr

        do while not rstTMClk2.eof 

            if rstTMClk2("LATE") ="Y" and rstTMClk2("EARLY") ="Y" then
    		    sRemark = "Late and Early Dismiss"
            elseif rstTMClk2("LATE") ="Y" then
                sRemark = "Late"
            elseif rstTMClk2("EARLY") ="Y" then
                sRemark = "Early Dismiss"
            end if 
		
		    sStr = Weekdayname(weekday(rstTMClk2("DT_WORK"),1),True)  & sep & rstTMCLK2("DT_WORK") & sep & rstTMCLK2("EMP_CODE") & sep & rstTMCLK2("NAME") & sep 
            sStr = sStr & rstTMCLK2("CONT_ID") & sep & rstTMCLK2("COST_PART") & sep & rstTMCLK2("SHF_CODE") & " " & rstTMCLK2("STIME") & "-" & rstTMCLK2("ETIME") & sep
            sStr = sStr & rstTMClk2("TIN") & sep & rstTMClk2("TOUT") & sep & rstTMClk2("TOTAL") & sep & sRemark
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