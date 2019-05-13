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

sFileName = "DailyAtt_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")

sSQL = "select tmshiftot.DT_SHIFT, tmshiftot.EMP_CODE as EMP_CODEFrSched, tmshiftot.SHF_CODE as SHF_CODEFrSched, " 
sSQL = sSQL & " tmshfcode.STIME as START_TIME,tmshfcode.ETIME as END_TIME, " 
sSQL = sSQL & " tmclk2.SHF_CODE as SHIFT_CODE, tmclk2.*,tmemply.* , tmcost.cost_id as COST_ID,tmcost.part as COST_PART from tmshiftot " 
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

    'response.write sSQL &"<br>"


rstTMClk2.Open sSQL, conn, 3, 3
if not rstTMClk2.eof then

	sStr = fCol("Day") & sep & fCol("Shift Date") & sep & fCol("Emp Code") & sep & fCol("Name") & sep & fCol("Contract") & sep & fCol("Cost Center") & sep 
    sStr = sStr & fCol("Shift") & sep
    sStr = sStr & fCol("In") & sep & fCol("Out") & sep & fCol("Total") & sep & fCol("Total OT")	 & sep 
    sStr = sStr & fCol("Approved OT")& sep & fCol("Time Off") & sep & fCol("Status")		
	objOpenFile.WriteLine sStr

	do while not rstTMClk2.eof

        sTimeOffColumn = ""
        sStatus  = ""
        sStr = "" 

        if isNull(rstTMCLK2("DT_RESIGN")) then
            sDtResign = "9999-12-31" '=== Not resign field is null, hence put a future date
        else
            sDtResign = rstTMCLK2("DT_RESIGN")
        end if 

        if CDate(rstTMCLK2("DT_SHIFT")) <= CDate(sDtResign) then '=== Anything before resign date
            sEMP_CODE = rstTMCLK2("EMP_CODE")
            sStr = Weekdayname(weekday(rstTMCLK2("DT_SHIFT"),1),True) & sep & rstTMCLK2("DT_SHIFT") & sep
            sStr = sStr & rstTMCLK2("EMP_CODEFrSched") & sep & rstTMCLK2("NAME") & sep & rstTMCLK2("CONT_ID") & sep 
            sStr = sStr & rstTMCLK2("COST_PART") & sep
        
            '===Shift column==========================================================
            if not isnull(rstTMCLK2("SHIFT_CODE")) then

                if rstTMCLK2("SHIFT_CODE") ="OFF" or rstTMCLK2("SHIFT_CODE") ="REST" then
                    sStr = sStr & rstTMCLK2("SHIFT_CODE") & sep
                    sStatus = sStatus & rstTMCLK2("SHIFT_CODE") & " " 
                else
                    sStr = sStr & rstTMCLK2("SHIFT_CODE") & " " & rstTMCLK2("STIME") & "-" & rstTMCLK2("ETIME") & sep
                            
                    if  rstTMCLK2("SHIFT_CODE") <> "" and ( rstTMCLK2("HALFDAY") = "" or rstTMCLK2("HALFDAY") = "N" ) then
                        sStatus = sStatus & "Normal " 
                    elseif rstTMCLK2("SHIFT_CODE") <> "" and rstTMCLK2("HALFDAY") = "Y" then
                        sStatus = sStatus & "0.5 Day Work"
                    else
                        sStatus = sStatus & "No Schedule " 
                    end if
                end if
            else
                if rstTMCLK2("SHF_CODEFrSched") ="OFF" or rstTMCLK2("SHF_CODEFrSched") ="REST" then
                    sStr = sStr & rstTMCLK2("SHF_CODEFrSched") & sep
                    sStatus = sStatus & rstTMCLK2("SHF_CODEFrSched") & " " 
                else
                    sStr = sStr & rstTMCLK2("SHF_CODEFrSched") & " " & rstTMCLK2("START_TIME") & "-" & rstTMCLK2("END_TIME") & sep
                            
                    if  rstTMCLK2("SHF_CODEFrSched") <> "" and ( rstTMCLK2("HALFDAY") = "" or rstTMCLK2("HALFDAY") = "N" ) then
                        sStatus = sStatus & "Normal " 
                    elseif rstTMCLK2("SHF_CODEFrSched") <> "" and rstTMCLK2("HALFDAY") = "Y" then
                        sStatus = sStatus & "0.5 Day Work"
                    else
                        sStatus = sStatus & "No Schedule " 
                    end if
                end if
            end if
            '=========================================================================
            
            sStr = sStr & rstTMCLK2("TIN") & sep & rstTMCLK2("TOUT") & sep & TimeToDec2(rstTMCLK2("TOTAL")) & sep 
            
            if rstTMCLK2("OT") = "Y" then
                sStr = sStr & TimeToDec2(rstTMCLK2("TOTALOT")) & sep 
            else
                sStr = sStr & sep
            end if

            sStr = sStr & TimeToDec(rstTMCLK2("3ATOTALOT")) & sep '=== Only Final approval by Verifier then only APVOT will appear
                        
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

            sStr = sStr & sTimeOffColumn & sep

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
                sStr = sStr & sStatus 
            else
                sStr = sStr & sStatus & " No info "
            end if

            '=====================================================================================================  
        
        elseif CDate(rstTMCLK2("DT_SHIFT")) > CDate(sDtResign) then

            sStr = Weekdayname(weekday(rstTMCLK2("DT_SHIFT"),1),True) & sep & rstTMCLK2("DT_SHIFT") & sep
            sStr = sStr & rstTMCLK2("EMP_CODEFrSched") & sep & rstTMCLK2("NAME") & sep & "Resigned"

        end if

        objOpenFile.WriteLine sStr
        rstTMCLK2.movenext
    loop
    call pCloseTables(rstTMCLK2)
     'response.end
end if

objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	   
%>

</body>
</html>