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

sFileName = "Absent_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
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
	    sSQL = sSQL & "AND tmshiftot.EMP_CODE ='" & pRTIN(sEmpCode) & "' "
    end if

	sSQL = sSQL & " order by DT_ABSENT asc, tmemply.SUP_CODE  "
    
    rstTMABSENT.Open sSQL, conn, 3, 3
	if not rstTMABSENT.eof then
		
        sStr = fCol("Day") & sep & fCol("Shift Date") & sep & fCol("Superior") & sep & fCol("Emp Code") & sep & fCol("Employee Name") & sep & fCol("Contract") & sep & fCol("Cost Center") & sep
        sStr = sStr & fCol("Shift") & sep & fCol("Code") & sep & fCol("Description") 	
	    objOpenFile.WriteLine sStr		

        do while not rstTMABSENT.eof
                	
            Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")    
			sSQL = "select * from TMEMPLY where EMP_CODE='" & rstTMABSENT("SUP_CODE") & "'" 
			rstTMSUPNAME.Open sSQL, conn, 3, 3
			if not rstTMSUPNAME.eof then
				sSupName = rstTMSUPNAME("NAME")
			else
				sSupName = ""
			end if
            call pCloseTables(rstTMSUPNAME)

            Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
			sSQL = "select STIME,ETIME from TMSHFCODE where SHF_CODE='" & rstTMABSENT("SHF_CODE") & "'" 
			rstTMSHFCODE.Open sSQL, conn, 3, 3
			if not rstTMSHFCODE.eof then
				sSTIME = rstTMSHFCODE("STIME")
                sETIME = rstTMSHFCODE("ETIME")
			end if
            call pCloseTables(rstTMSHFCODE)
			
            sShift = rstTMABSENT("SHF_CODE") & " " & sSTIME & "-" & sETIME 
            sCOde = "9000"
			sDesc = "Absent" 
	            
            if rstTMABSENT("TYPE") = "H" then
				sDesc = "Absent 0.5"    
            else
                sDesc = "Absent"
            end if
            
            sStr = Weekdayname(weekday(rstTMABSENT("DT_ABSENT"),1),True) & sep &  rstTMABSENT("DT_ABSENT") & sep 
            sStr = sStr & sSupName & sep & rstTMABSENT("EMP_CODE") & sep & rstTMABSENT("NAME") & sep & rstTMABSENT("CONT_ID") &sep
            sStr = sStr & rstTMABSENT("COST_PART") & sep & sShift & sep & sCode & sep & sDesc 
	    	objOpenFile.WriteLine sStr

    		rstTMABSENT.movenext
       	loop
	end if
	call pCloseTables(rstTMABSENT)

objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>