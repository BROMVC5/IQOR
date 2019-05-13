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

Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
sSQL = "select OTXHOUR from TMPATH"
rstTMPATH.Open sSQL, conn, 3, 3
if not rstTMPATH.eof then
    sOTX = (rstTMPATH("OTXHOUR"))
    sOTXMin = Cint((mid(sOTX,1,2))*60) + Cint((mid(sOTX,4,2)))
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

sFileName = "OTExceed_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)

    sStr = fCol("Employee Code") & sep & fCol("Employee Name") & sep & fCol("Superior") & sep & fCol("Contract") & sep
    sStr = sStr & fCol("Cost Center") & sep & fCol("Total OT") & sep & fCol("Exceeded OT") 
	objOpenFile.WriteLine sStr    
	
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
	
            if iAddOT >= Cint(sOTXMin) then ' ========= 

                dAddOT = iAddOT / 60 '=== Need to show them in decimal
            
                iExceed = Cint(iAddOT)-Cint(sOTXMin) ' ========= Cint(sOTXMin)
                dExceed = iExceed / 60  '=== Need to show them in decimal format

                sRecord = sRecord + 1
                
                Set rstTMPREV = server.CreateObject("ADODB.RecordSet")  
                sSQL = "select tmemply.NAME, SUP_CODE, CONT_ID, tmemply.COST_ID, tmcost.part from TMEMPLY "
                sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id " 
                sSQL = sSQL & " where EMP_CODE ='" & sEmpCode & "'"
		        rstTMPREV.Open sSQL, conn, 3, 3
		        if not rstTMPREV.eof then

                    sName = rstTMPREV("NAME") 
                    sSupCode = rstTMPREV("SUP_CODE") 
                
                    Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")  
                    sSQL = "select NAME from TMEMPLY where EMP_CODE ='" & rstTMPREV("SUP_CODE") & "'"
		            rstTMSUPNAME.Open sSQL, conn, 3, 3
		            if not rstTMSUPNAME.eof then
                        sSupName = rstTMSUPNAME("NAME")
                    end if

                    sCont_ID = rstTMPREV("CONT_ID")
                    sCost_Part = rstTMPREV("PART")

                end if

                sStr = sEmpCode & sep & sName & sep & sSupName & sep
                sStr = sStr & sCont_ID & sep & sCost_Part & sep & pFormatDec(dAddOT,2) & sep & pFormatDec(dExceed,2)
		        objOpenFile.WriteLine sStr
    
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
	        
                    if iAddOT >= Cint(sOTXMin) then 
             
                        dAddOT = iAddOT / 60 '=== Need to show them in decimal
            
                        iExceed = Cint(iAddOT)-Cint(sOTXMin) ' ========= Cint(sOTXMin)
                        dExceed = iExceed / 60  '=== Need to show them in decimal format 
                    
			            Set rstTMPREV = server.CreateObject("ADODB.RecordSet") 
                        sSQL = "select tmemply.NAME, SUP_CODE, CONT_ID, tmemply.COST_ID, tmcost.part from TMEMPLY "
                        sSQL = sSQL & " left join tmcost on tmemply.cost_id = tmcost.cost_id " 
                        sSQL = sSQL & " where EMP_CODE ='" & sPreEmpCode & "'"
		                rstTMPREV.Open sSQL, conn, 3, 3
		                if not rstTMPREV.eof then
                            sName = rstTMPREV("NAME")
                            sSupCode = rstTMPREV("SUP_CODE")
                
                            Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")  
                            sSQL = "select NAME from TMEMPLY where EMP_CODE ='" & rstTMPREV("SUP_CODE") & "'"
		                    rstTMSUPNAME.Open sSQL, conn, 3, 3
		                    if not rstTMSUPNAME.eof then
                                sSupName = rstTMSUPNAME("NAME")
                            end if
                            sCont_ID = rstTMPREV("CONT_ID") 
                            sCost_Part = rstTMPREV("PART") '=== Cost Center part
                        end if
	
	                    sStr = sPreEmpCode & sep & sName & sep & sSupName & sep
                        sStr = sStr & sCont_ID & sep & sCost_Part & sep & pFormatDec(dAddOT,2) & sep & pFormatDec(dExceed,2)
		                objOpenFile.WriteLine sStr

                        iAddOT = 0	
			    
                    end if		
    
                end if
                rstTMEMPLY.movenext
            loop		
	        call pCloseTables(rstTMEMPLY)
    
        end if '==== end if sEmpCode <> "ALL" then
    
    end if '==== end if not rstTMEmply.eof

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>