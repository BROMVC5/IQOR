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
sEmpCode = request("txtEmpCode")
sSupCode = request("txtSupCode")
sCostID = request("txtCostID")
sWorkGrpID = request("txtWorkGrpID")
sPageBreak = request("cboPageBreak")
sPage = 1

if sContID = "" then
    sContID = "ALL"
end if

if sEmpCode = "" then
    sEmpCode = "ALL"
end if

if sSupCode = "" then
    sSupCode = "ALL"
end if

if sCostID = "" then
    sCostID = "ALL"
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
sDtTime = tsYear & tsMonth & tsDay & tsHour & tsMinute & tsSecond

%>

<%
sFileName = "MidMth_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
				
	Set rstTMMIDMTH = server.CreateObject("ADODB.RecordSet")    
    sSQL = " select tmmidmth.*, tmemply.CONT_ID, tmemply.COST_ID, tmcost.PART as COST_PART, tmworkgrp.WORKGRP_ID, tmworkgrp.part as WORKGRP_PART from TMMIDMTH "
    sSQL = sSQL & " left join tmemply on tmmidmth.emp_code = tmemply.emp_code "
    sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id "
    sSQL = sSQL & " left join tmworkgrp on tmemply.emp_code = tmworkgrp.emp_code "
    sSQL = sSQL & " where DTFR ='" & fdate2(dtFrDate) & "' and DTTO = '" & fdate2(dtToDate) & "'"
    sSQL = sSQL & " and TOTDAYS <> '' " '=== I insert a file name as 1 record in the table, so the TOTDAYS = '', filter it out.  

    if sContID <> "ALL" then
	    sSQL = sSQL & " and tmemply.CONT_ID = '" & pRTIN(sContID) & "'"
    end if

    if sEmpCode <> "ALL" then
	    sSQL = sSQL & " and tmmidmth.EMP_CODE = '" & pRTIN(sEmpCode) & "'"
    end if
			
    if sSupCode <> "ALL" then
	    sSQL = sSQL & " and tmmidmth.SUP_CODE = '" & pRTIN(sSupCode) & "'"
    end if

    if sCostID <> "ALL" then
	    sSQL = sSQL & " and tmemply.COST_ID = '" & pRTIN(sCostID) & "'"
    end if	

    if sWorkGrpID <> "ALL" then
	    sSQL = sSQL & " and tmworkgrp.WORKGRP_ID = '" & pRTIN(sWorkGrpID) & "'"
    end if	

    sSQL = sSQL & " order by tmmidmth.EMP_CODE asc, tmmidmth.SUPNAME desc "

    rstTMMIDMTH.Open sSQL, conn, 3, 3
    if not rstTMMIDMTH.eof then
	
    	sStr = fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Superior") & sep 
        sStr = sStr & fCol("Work Group") & sep & fCol("Contract") & sep & fCol("Cost Center") & sep
        sStr = sStr & fCol("Total Days") & sep & fCol("Total Amount")
        objOpenFile.WriteLine sStr
	
	    do while not rstTMMIDMTH.eof
			sStr = rstTMMIDMTH("EMP_CODE") & sep & rstTMMIDMTH("NAME") & sep & rstTMMIDMTH("SUPNAME") & sep 
            sStr = sStr & rstTMMIDMTH("WORKGRP_ID") & sep & rstTMMIDMTH("CONT_ID") & sep & rstTMMIDMTH("COST_PART") & sep
	        sStr = sStr & rstTMMIDMTH("TOTDAYS") & sep & rstTMMIDMTH("TOTAMT")
            objOpenFile.WriteLine sStr
		rstTMMIDMTH.movenext
		loop
			
	end if
	call pCloseTables(rstTMMIDMTH)

objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>