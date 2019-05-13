<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<!-- JQuery 2.2.3 Compressed -->
<%

Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd

sOrderBy = trim(request("txtOrderBy"))
sAscDesc = trim(request("txtAscDesc"))   

sLogin = request("txtLogin")
sApprov = request("txtApprov")
sDown = request("txtDown")
sEMP_CODE = trim(request("txtEMP_CODE"))
sWorkGrp_ID = request("txtWorkGrp_ID")
sWork_ID = request("txtWork_ID")                                       

Set rstBROPATH = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from BROPATH" 
rstBROPATH.Open sSQL, conn, 3, 3
if not rstBROPATH.eof then
    sNumRows = rstBROPATH("NUMROWS")
end if
pCloseTables(rstBROPATH)

PageLen = Cint(sNumRows)

if request("Page") <> "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if


Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMEMPLY where "
sSQL = sSQL & " EMP_CODE ='" & sLogin & "'"  
rstTMEMPLY.Open sSQL, conn, 3, 3
if not rstTMEMPLY.eof then
    sAType = rstTMEMPLY("ATYPE")
    sDept_ID = rstTMEMPLY("DEPT_ID")
end if 

sSQL = "select tmclk2.*, tmemply.NAME from TMCLK2  "
sSQL = sSQL & " left join tmemply on tmclk2.EMP_CODE = tmemply.EMP_CODE "
sSQL = sSQL & " where " 
sSQL = sSQL & " OT = 'Y' and ( "
sSQL = sSQL & "  TIN <> '' and TOUT <> '' and "
sSQL = sSQL & " ( (isnull(1DTAPV) and isnull(2DTAPV)) or (not isnull(1DTAPV) and not isnull(2DTAPV))  )"
sSQL = sSQL & " )"

'=== Login in as Verifier ===================================================================================
if sAtype = "V" and sApprov = "V" and sDown <> "A" then '=== Approve as Verifier, sDown <> "A" is his name only not important or use for filtering.

    '==== Pending final approval
    sSQL = sSQL & " and (not isnull(1OTDTAPV) and not isnull(2OTDTAPV) and isnull(3OTDTAPV) )"
    
elseif sAType = "V" and sApprov = "M" and sDown = "A" then '=== Take the role as Manager, All pending manager approval  
    
    Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
    sSQL1 = "select * from TMEMPLY where "
    sSQL1 = sSQL1 & " ATYPE = 'M' "  '=== All Managers
    sSQL1 = sSQL1 & " order by EMP_CODE "
    rstTMEMPLY.Open sSQL1, conn, 3, 3
    if not rstTMEMPLY.eof then
    
        sSQL = sSQL & " and ( "

        Do while not rstTMEMPLY.eof '=== Loop through every manager
            Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
            sSQL1 = "select * from TMEMPLY where "
            sSQL1 = sSQL1 & " SUP_CODE ='" & rstTMEMPLY("EMP_CODE") & "'" '=== Retrieve all Manager's subordinate  
            sSQL1 = sSQL1 & " order by ATYPE, EMP_CODE" 
            rstTMDOWN1.Open sSQL1, conn, 3, 3
            if not rstTMDOWN1.eof then
                Do while not rstTMDOWN1.eof '=== Loop every subordinates
                    if rstTMDOWN1("ATYPE") = "E" then '=== Direct subordinates which is an Employee
                        '=== Verifier will approve once at Manager's screen and 1st Level and 2nd Level will be approved automatically
                        '=== Then route to Verifier for final approval
                        sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') OR " 
                
                    '=== Subordinate is a SUPERIOR that punch in
                    '=== Verifier will approve once at Manager's screen and 1st Level and 2nd Level will be approved automatically
                    '=== Then route to Verifier for final approval
                    elseif rstTMDOWN1("ATYPE") = "S" then 
                        '=== Subordinate which is a Superior, Pending 1st level approval
                        sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')  OR " 
                        '=== Subordinate's subordinate pending Superior's approval
                        sSQL = sSQL & " ( ( not isnull(1OTDTAPV) and isnull(2OTDTAPV) ) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR"
                
                    end if
    
                    rstTMDOWN1.movenext
                loop
            end if

        rstTMEMPLY.movenext
        loop

        
        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR from the string because of the loop above

        sSQL = sSQL & " )" 
    end if

elseif sAType = "V" and sApprov = "M" and sDown <> "A" then '=== Login as Verifier, take the role as particular Manager, sDown <> "A" his direct subordinate 
    
    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
    sSQL1 = "select * from TMEMPLY where "
    sSQL1 = sSQL1 & " SUP_CODE ='" & sDown & "'" '=== Retrieve all his subordinate  
    sSQL1 = sSQL1 & " order by ATYPE, EMP_CODE" 
    rstTMDOWN1.Open sSQL1, conn, 3, 3
    if not rstTMDOWN1.eof then

        sSQL = sSQL & " and ( "

        Do while not rstTMDOWN1.eof

            if rstTMDOWN1("ATYPE") = "E" then
                '=== Manager with Direct Subordinate which is an Employee
                '=== Managers will approve once at his screen 1stLevel and 2nd Level will be approved automatically
                '=== and route to Verifier for final approval
                sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') OR " 
                
            '=== Subordinate is a SUPERIOR that punch in
            '=== Managers will approve once at his screen 1stLevel and 2nd Level will be approved automatically
            '=== and route to Verifier for final approval
            elseif rstTMDOWN1("ATYPE") = "S" then 
                '=== Subordinate which is Superior
                sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')  OR " 
                '=== Subordinate's subordinate pending Superior 's approval
                sSQL = sSQL & " ( ( not isnull(1OTDTAPV) and isnull(2OTDTAPV) ) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR"
                
            end if
    
        rstTMDOWN1.movenext
        loop

        
        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR out because of the loop above

        sSQL = sSQL & " )"  
    
    end if

elseif sAType = "V" and sApprov = "S" and sDown = "A" then '=== Login as Verifier, take the role as Superior, All employee who has Superior and pending 1st level approval
    
    '=== This is for Employee who is pending his superior 1st level approval
    sSQL = sSQL & " and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where ATYPE = 'E' or ATYPE = 'S') and isnull(1OTDTAPV) and isnull(2OTDTAPV)) " 

elseif sAType = "V" and sApprov = "S" and sDown <> "A" then '=== Login as Verifier, take the role as Superior, sDown <> "A" meaning sDown is the SUP_CODE 

    '=== This is for his direct subordinate
    sSQL = sSQL & " and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sDown & "') and isnull(1OTDTAPV) and isnull(2OTDTAPV)) " 
'========================================================================================================================

'======Login as Manager =================================================================================================
elseif sAType = "M" and sApprov = "M" and sDown <> "A" then  '=== Approve as Manager, sDown <> "A" meaning Manager's Name and all his subordinate

    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
    sSQL1 = "select * from TMEMPLY where "
    sSQL1 = sSQL1 & " SUP_CODE ='" & sDown & "'" '=== Retrieve all his subordinate  
    sSQL1 = sSQL1 & " order by ATYPE, EMP_CODE" 
    rstTMDOWN1.Open sSQL1, conn, 3, 3
    if not rstTMDOWN1.eof then
        
        sSQL = sSQL & " and ( "

        Do while not rstTMDOWN1.eof

            if rstTMDOWN1("ATYPE") = "E" then
                '=== Manager with Direct Subordinate which is an Employee
                '=== Managers will approve once at his screen 1stLevel and 2nd Level will be approved automatically
                '=== and route to Verifier for final approval
                sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') OR " 
                
            '=== Subordinate is a SUPERIOR that punch in
            '=== Managers will approve once at his screen 1stLevel and 2nd Level will be approved automatically
            '=== and route to Verifier for final approval
            elseif rstTMDOWN1("ATYPE") = "S" then 
                '=== Subordinate which is Superior
                sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')  OR " 
                '=== Subordinate's subordinate pending Manager's approval
                sSQL = sSQL & " ( not isnull(1OTDTAPV) and isnull(2OTDTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR "
                
            end if
        rstTMDOWN1.movenext
        loop
        
        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR of the string because of the loop above

        sSQL = sSQL & " )" 
    
    end if

elseif sAType = "M" and sApprov = "S" and sDown = "A" then '=== Login as manager, take the role as Superior, select all my Superior
    
    '=== Wanna look at my subordinate must be a Superior's subordinate
    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
    sSQL1 = "select * from TMEMPLY where "
    sSQL1 = sSQL1 & " SUP_CODE ='" & sLogin & "'" '=== Select All Retrieve all his subordinate  
    sSQL1 = sSQL1 & " AND ATYPE = 'S' " 
    sSQL1 = sSQL1 & " order by  EMP_CODE" 
    rstTMDOWN1.Open sSQL1, conn, 3, 3
    if not rstTMDOWN1.eof then

        sSQL = sSQL & " and ( "

        Do while not rstTMDOWN1.eof

            sSQL = sSQL & " ( (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) and isnull(1OTDTAPV) ) OR"
        
        rstTMDOWN1.movenext
        loop
        
        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR from the string because of the loop above
    
        sSQL = sSQL & " )"

    end if
    
elseif sAType = "M" and sApprov = "S" and sDown <> "A" then '=== Login as Manager, take the role as Superior, select a particular Superior
    
    '=== All the subordinate of that particular Superior  where NO 1st and 2nd approval.
    sSQL = sSQL & " and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sDown & "') and isnull(1OTDTAPV))"


'=== Login in as Superior ================================================================================    
elseif sAType = "S" and sApprov = "S" and sDown <> "A" then '=== All his subordinates
    '=== His subordinate with pending 1st and 2nd approval    
    sSQL = sSQL & " and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sDown & "') and isnull(1OTDTAPV))"

end if

if sEMP_CODE <> "" then
    sSQL_1 = " and tmclk2.EMP_CODE='" & sEMP_CODE & "'"
end if

if sWorkGrp_ID <> "" then
    sSQL_1 = sSQL_1 & " and tmclk2.EMP_CODE in (select EMP_CODE from TMWORKGRP where WORKGRP_ID = '" & sWorkGrp_ID & "')"
end if 

if sWork_ID <> "" then
    sSQL_1 = sSQL_1 & " and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where WORK_ID = '" & sWork_ID & "')"
end if

sSQL = sSQL & sSQL_1

if sOrderBy = "undefined" or sOrderBy = "" then
    sSQL = sSQL & " order by tmclk2.DT_WORK, tmclk2.EMP_CODE"
else
    if sAscDesc = "Asc" then
        sSQL = sSQL & " order by " & sOrderBy & " asc"
    elseif sAscDesc = "Desc" then
        sSQL = sSQL & " order by " & sOrderBy & " desc"
    end if
end if
set rstTMClk2 = server.createobject("adodb.recordset")
rstTMClk2.cursortype = adOpenStatic
rstTMClk2.cursorlocation = adUseClient
rstTMClk2.locktype = adLockBatchOptimistic
rstTMClk2.pagesize = PageLen		
rstTMClk2.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMClk2.eof then
 	rstTMClk2.absolutepage = iCurPage
 	'iPageCount = rstTMClk2.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMClk2.RecordCount
PageStart = ((PageLen*PageNo)-PageLen)
PageEnd = PageLen

If TotalRecord <= PageLen Then
	TotalPage =1
ElseIf (TotalRecord Mod PageLen = 0) Then
	TotalPage =(TotalRecord/PageLen)
Else
	TotalPage =(TotalRecord/PageLen)
	
	if TotalPage > Cint(TotalPage) then
	
		TotalPage = Cint(TotalPage)+1
	else
		TotalPage = Cint(TotalPage)
	end if
End If
	
    j=0
    
    if reqForm("btnSave") <> "" then

        do while not rstTMClk2.eof and j < pageLen
            j = j + 1
               
            if reqForm("txtchkbox" & j ) <> "" then
                                
                sString = reqForm("txtchkbox" & j)
                sSplit = split(sString,",")
                sCode = sSplit(0)
                sdt_Work = sSplit(1)
                
                sApvOT = reqForm("txtApvOT" & j)
                sAllCode = reqForm("selAllCode" & j) 
                sComment = reqForm("txtComment" & j) 

                '==========Update Approved Total OT, SHF Allowance and Send Email if Final Approved======
                sSQL = " UPDATE TMCLK2 SET "             
                
                Set rstTMAPVLVL = server.CreateObject("ADODB.RecordSet")
                sSQLAPVLVL = "select tmclk2.*, tmemply.SUP_CODE from TMClk2 left join TMEMPLY on tmclk2.EMP_CODE = tmemply.EMP_CODE " 
                sSQLAPVLVL = sSQLAPVLVL & " where tmclk2.EMP_CODE ='" & sCode & "'" 
                sSQLAPVLVL = sSQLAPVLVL & " and DT_WORK = '" & fdate2(sdt_Work) & "'"
                rstTMAPVLVL.Open sSQLAPVLVL, conn, 3, 3
                if not rstTMAPVLVL.eof then
                    if isNull(rstTMAPVLVL("1OTDTAPV")) and isNull(rstTMAPVLVL("2OTDTAPV")) then '1st level approve
                        
                        sSQL = sSQL & "1OTDTAPV = '" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "1OTAPVBY = '" & session("USERNAME") & "',"
                        sSQL = sSQL & "COMMENT = '" & sComment & "'," '=== 1st Level Comment
                        sSQL = sSQL & "1ATOTALOT = '" & sApvOT & "'," '=== 1st Level ApproveOT               
    
                        '=== Manager with direct subordinate as Superior, Employee, 
                        '=== straight away approve 2 level and route to Verifier
                        Set rstChkDirectSup = server.CreateObject("ADODB.RecordSet")
                        sSQLChk = "select ATYPE from TMEMPLY " 
                        sSQLChk = sSQLChk & " where EMP_CODE ='" & rstTMAPVLVL("SUP_CODE") & "'" 
                        rstChkDirectSup.Open sSQLChk, conn, 3, 3
                        if not rstChkDirectSup.eof then
                            if rstChkDirectSup("ATYPE") ="M" then
                                sSQL = sSQL & "2OTDTAPV = '" & fdatetime2(Now()) & "',"
                                sSQL = sSQL & "2OTAPVBY = '" & session("USERNAME") & "',"
                                sSQL = sSQL & "COMMENT2 = '" & sComment & "'," '=== 2nd Level Comment
                                sSQL = sSQL & "2ATOTALOT = '" & sApvOT & "'," '=== 2nd Level ApproveOT  
                            end if
                        end if

                        '===== Insert into LOG file ======
                        '==== Get the orginal records from Database and if "" put EMPTY
                        sOApvOT = rstTMClk2("ATOTALOT")
                        sOAllCode = rstTMClk2("ALLCODE")
                        sOComment = rstTMClk2("COMMENT") '=== 1st Level Comment

                        '==== Compare the original to the newly Input data, if different, log
                        if sOApvOT = "" then
                            sOApvOT = "EMPTY"
                        end if 
                        sChangesM = " APPROVED OT change from " & sOApvOT & " to " & sApvOT & " "
                
                        if sOAllCode <> sAllCode then
                            if sOAllCode = "" then
                                sOAllCode = "EMPTY"
                            end if                 
                            sChangesM = sChangesM & " SHIFT ALLOWANCE change from " & sOAllCode & " to " & sAllCode & " "
                        end if

                        if sOComment <> sComment then
                            if sOComment = "" then
                                SOComment = "EMPTY"
                            end if 
                            sChangesM = sChangesM & " COMMENT change from " & sOComment & " to " & sComment & " "
                        end if

                        if sChangesM <> "" then
                            sSQLLog = "insert into TMLOG (EMP_CODE,DT_WORK,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		                    sSQLLog = sSQLLog & "values ("
                            sSQLLog = sSQLLog & "'" & sCode & "',"		
		                    sSQLLog = sSQLLog & "'" & fdate2(sdt_work) & "',"		
		                    sSQLLog = sSQLLog & "'1st lvl OT Approval',"
                            sSQLLog = sSQLLog & "'Success',"
                            sSQLLog = sSQLLog & "'" & sChangesM & "',"
                            sSQLLog = sSQLLog & "'" & session("USERNAME") & "'," 
                            sSQLLog = sSQLLog & "'" & fdatetime2(Now()) & "'"
		                    sSQLLog = sSQLLog & ") "
                            conn.execute sSQLLog
                        end if
                        '=========================================
     
                   elseif not isNull(rstTMAPVLVL("1OTDTAPV")) and isNull(rstTMAPVLVL("2OTDTAPV")) then
                        
                        sSQL = sSQL & "2OTDTAPV = '" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "2OTAPVBY = '" & session("USERNAME") & "',"
                        sSQL = sSQL & "COMMENT2 = '" & sComment & "',"
                        sSQL = sSQL & "2ATOTALOT = '" & sApvOT & "'," '=== 1st Level ApproveOT
              
                        '===== Insert into LOG file ======
                        '==== Get the orginal records from Database and if "" put EMPTY
                        sOApvOT = rstTMClk2("1ATOTALOT")
                        sOAllCode = rstTMClk2("ALLCODE")
                        sOComment = rstTMClk2("COMMENT2") '=== 2nd Level Comment

                        '==== Compare the original to the newly Input data, if different, log
                        if sOApvOT = "" then
                            sOApvOT = "EMPTY"
                        end if 
                        
                        sChangesM = " APPROVED OT change from " & sOApvOT & " to " & sApvOT & " "
                
                        if sOAllCode <> sAllCode then
                            if sOAllCode = "" then
                                sOAllCode = "EMPTY"
                            end if                 
                            sChangesM = sChangesM & " SHIFT ALLOWANCE change from " & sOAllCode & " to " & sAllCode & " "
                        end if

                        if sOComment <> sComment then
                            if sOComment = "" then
                                SOComment = "EMPTY"
                            end if 
                            sChangesM = sChangesM & " COMMENT change from " & sOComment & " to " & sComment & " "
                        end if

                        if sChangesM <> "" then
                            sSQLLog = "insert into TMLOG (EMP_CODE,DT_WORK,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		                    sSQLLog = sSQLLog & "values ("
                            sSQLLog = sSQLLog & "'" & sCode & "',"		
		                    sSQLLog = sSQLLog & "'" & fdate2(sdt_work) & "',"		
		                    sSQLLog = sSQLLog & "'2nd lvl OT Approval',"
                            sSQLLog = sSQLLog & "'Success',"
                            sSQLLog = sSQLLog & "'" & sChangesM & "',"
                            sSQLLog = sSQLLog & "'" & session("USERNAME") & "'," 
                            sSQLLog = sSQLLog & "'" & fdatetime2(Now()) & "'"
		                    sSQLLog = sSQLLog & ") "
                            conn.execute sSQLLog
                        end if
                        '=========================================
    
                    elseif not isNull(rstTMAPVLVL("1OTDTAPV")) and not isNull(rstTMAPVLVL("2OTDTAPV")) then
                         
                        sSQL = sSQL & "3OTDTAPV = '" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "3OTAPVBY = '" & session("USERNAME") & "',"
                        sSQL = sSQL & "OTAPV = 'Y',"
                        sSQL = sSQL & "3ATOTALOT = '" & sApvOT & "'," '=== 1st Level ApproveOT          

                        '===== Insert into LOG file ======
                        '==== Get the orginal records from Database and if "" put EMPTY
                        sOApvOT = rstTMClk2("2ATOTALOT")
                        sOAllCode = rstTMClk2("ALLCODE")
                        sOComment = rstTMClk2("COMMENT3") '=== 3rd Level Comment

                        '==== Compare the original to the newly Input data, if different, log
                        if sOApvOT <> sApvOT then
                            if sOApvOT = "" then
                                sOApvOT = "EMPTY"
                            end if 
                            sChangesM = " APPROVED OT change from " & sOApvOT & " to " & sApvOT & " "
                        end if
                
                        if sOAllCode <> sAllCode then
                            if sOAllCode = "" then
                                sOAllCode = "EMPTY"
                            end if                 
                            sChangesM = sChangesM & " SHIFT ALLOWANCE change from " & sOAllCode & " to " & sAllCode & " "
                        end if

                        if sOComment <> sComment then
                            if sOComment = "" then
                                SOComment = "EMPTY"
                            end if 
                            sChangesM = sChangesM & " COMMENT change from " & sOComment & " to " & sComment & " "
                        end if

                        if sChangesM <> "" then
                            sSQLLog = "insert into TMLOG (EMP_CODE,DT_WORK,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		                    sSQLLog = sSQLLog & "values ("
                            sSQLLog = sSQLLog & "'" & sCode & "',"		
		                    sSQLLog = sSQLLog & "'" & fdate2(sdt_work) & "',"		
		                    sSQLLog = sSQLLog & "'Final OT Approval',"
                            sSQLLog = sSQLLog & "'Success',"
                            sSQLLog = sSQLLog & "'" & sChangesM & "',"
                            sSQLLog = sSQLLog & "'" & session("USERNAME") & "'," 
                            sSQLLog = sSQLLog & "'" & fdatetime2(Now()) & "'"
		                    sSQLLog = sSQLLog & ") "
                            conn.execute sSQLLog
                        end if
                        '=========================================

                    end if
                end if 
                
                '=== Check the employee Grade and whether SHFALL is yes
                Set rstTMGRADE = server.CreateObject("ADODB.RecordSet")
                sSQLTMGRADE = "select tmemply.GRADE_ID, tmGRADE.* from tmemply "
                sSQLTMGRADE = sSQLTMGRADE & " left join tmgrade on TMEMPLY.GRADE_ID = TMGRADE.GRADE_ID " 
                sSQLTMGRADE = sSQLTMGRADE & " where tmemply.EMP_CODE ='" & sCode & "'" 
                sSQLTMGRADE = sSQLTMGRADE & " and tmgrade.SHFALL ='Y'" 
                rstTMGRADE.Open sSQLTMGRADE, conn, 3, 3
                if not rstTMGRADE.eof then
                    sSQL = sSQL & "ALLCODE = '" & sAllCode & "',"
                end if

                sSQL = sSQL & "ATOTALOT = '" & sApvOT & "'" 
                sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "' AND DT_WORK ='" & fdate2(sdt_Work) & "'"
                conn.execute sSQL        
      
            end if    
            rstTMClk2.movenext
        loop
   
        sMainURL = "../tmot.asp?"
        sAddURL = "txtApprov=" & sApprov & "&txtDown=" & sDown & "&txtEmp_Code=" & sEmp_Code & "&AfterApprove=Y" & "&txtWorkGrp_ID=" & sWorkGrp_ID & "&txtWork_ID=" & sWork_ID
        sAddURL = sAddURL & "&txtOrderBy=" & sOrderBy & "&txtAscDesc=" & sAscDesc 
        'response.write sAddURL & "<br>"
    'response.end
        call confirmBox("Approved Successful!", sMainURL&sAddURL)
         
    end if
	
%>
<form id="form2" name="form2" action="ajax/ax_tmot.asp" method="post">
<input type="hidden" name="txtLogin" value="<%=sLogin%>" />
<input type="hidden" name="txtApprov" value="<%=sApprov%>" />
<input type="hidden" name="txtDown" value="<%=sDown%>" />
<input type="hidden" name="txtEmp_Code" value="<%=sEMP_CODE%>" />
<input type="hidden" name="txtWorkGrp_ID" value="<%=sWorkGrp_ID%>" />
<input type="hidden" name="txtWork_ID" value="<%=sWork_ID%>" />
<input type="hidden" id="txtOrderBy" name="txtOrderBy" value="<%=sOrderBy%>" />
<input type="hidden" id="txtAscDesc" name="txtAscDesc" value="<%=sAscDesc%>" />

<div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
        
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <%If sAscDesc ="Desc" then %>
                    <th style="width:6%"><a href="javascript:showContent2('page=<%=PageNo%>','EMP_CODE','Asc');">Emp Code</a></th>
                    <th style="width:14%"><a href="javascript:showContent2('page=<%=PageNo%>','NAME','Asc');">Name</a></th>
                    <th style="width:3%">Day</th>
                    <th style="width:7%"><a href="javascript:showContent2('page=<%=PageNo%>','DT_WORK','Asc');">Work Date</a></th>
                    <th style="width:10%"><a href="javascript:showContent2('page=<%=PageNo%>','SHF_CODE','Asc');">Shift</a></th>
                    <th style="width:8%"><a href="javascript:showContent2('page=<%=PageNo%>','TIN','Asc');">OT From</a></th>
                    <th style="width:5%"><a href="javascript:showContent2('page=<%=PageNo%>','TOTALOT','Asc');">Total OT</a></th>
                    <th style="width:7%"><a href="javascript:showContent2('page=<%=PageNo%>','ATOTALOT','Asc');">Apv OT</a></th>
                    <th style="width:7%"><a href="javascript:showContent2('page=<%=PageNo%>','ALLCODE','Asc');">Shift Allow</a></th>
                    <th style="width:15%">Comment</th>
                    <th style="width:4%;text-align:center">History</th>
                    <th style="width:5%;text-align:center"><a href="javascript:showContent2('page=<%=PageNo%>','1OTAPVBY','Asc');">1st Apv</a></th>
                    <th style="width:5%;text-align:center"><a href="javascript:showContent2('page=<%=PageNo%>','2OTAPVBY','Asc');">2nd Apv</a></th>
                <%else %>
                    <th style="width:6%"><a href="javascript:showContent2('page=<%=PageNo%>','EMP_CODE','Desc');">Emp Code</a></th>
                    <th style="width:14%"><a href="javascript:showContent2('page=<%=PageNo%>','NAME','Desc');">Name</a></th>
                    <th style="width:3%">Day</th>
                    <th style="width:7%"><a href="javascript:showContent2('page=<%=PageNo%>','DT_WORK','Desc');">Work Date</a></th>
                    <th style="width:10%"><a href="javascript:showContent2('page=<%=PageNo%>','SHF_CODE','Desc');">Shift</a></th>
                    <th style="width:8%"><a href="javascript:showContent2('page=<%=PageNo%>','TIN','Desc');">OT From</a></th>
                    <th style="width:5%"><a href="javascript:showContent2('page=<%=PageNo%>','TOTALOT','Desc');">Total OT</a></th>
                    <th style="width:7%"><a href="javascript:showContent2('page=<%=PageNo%>','ATOTALOT','Desc');">Apv OT</a></th>
                    <th style="width:7%"><a href="javascript:showContent2('page=<%=PageNo%>','ALLCODE','Desc');">Shift Allow</a></th>
                    <th style="width:15%">Comment</th>
                    <th style="width:4%;text-align:center">History</th>
                    <th style="width:5%;text-align:center"><a href="javascript:showContent2('page=<%=PageNo%>','1OTAPVBY','Desc');">1st Apv</a></th>
                    <th style="width:5%;text-align:center"><a href="javascript:showContent2('page=<%=PageNo%>','2OTAPVBY','Desc');">2nd Apv</a></th>
                <%end if %>
                <th style="width:5%;text-align:center">
					<input type="checkbox" 
						onclick="if (this.checked) { checkAll() } else { uncheckAll() }" /></br>
						<span>Approve</span>
				</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                do while not rstTMClk2.eof and i < pageLen' When recordset is not EOF and i < iRecCount continue to do, stop when 
				sHoliday = ""
				sOffRest = ""
                i = i + 1                             
                response.write "<tr>"
                
                response.write "<td>" & rstTMClk2("EMP_CODE") & "</td>"
                response.write "<input type='hidden' id='txtEmpCode"& i & "' value='" & rstTMClk2("EMP_CODE") & "' />"
                
                Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMEMPLY where EMP_CODE ='" & rstTMClk2("EMP_CODE") & "'" 
                rstTMEMPLY.Open sSQL, conn, 3, 3
                if not rstTMEMPLY.eof then
                    sEntShfA = rstTMEMPLY("EntShfA")
                    response.write "<td>" & rstTMEMPLY("NAME") & "</td>"
                else
                    response.write "<td></td>"
                end if
                pCloseTables(rstTMEMPLY)

                response.write "<td>" & Weekdayname(weekday(rstTMClk2("DT_WORK"),1),True) & "</td>"
                response.write "<td>" & rstTMClk2("DT_WORK") & "</td>"
                response.write "<input type='hidden' id='dtWork" & i & "' value='" & rstTMClk2("DT_WORK")  & "' />"

                if rstTMClk2("SHF_CODE") = "OFF" or rstTMClk2("SHF_CODE") = "REST" then
                    response.write "<td>" & rstTMClk2("SHF_CODE") & "</td>"
                else
                    response.write "<td>" & rstTMClk2("SHF_CODE") & " " & rstTMClk2("STIME") & " - " & rstTMClk2("ETIME") & "</td>"
                end if

                response.write "<td>" & rstTMClk2("TIN") & " - " & rstTMClk2("TOUT") & "</td>"

                sTotalOT = rstTMClk2("TOTALOT")
                sApvOT = rstTMClk2("ATOTALOT")
                
                if sApvOT = "" then
                    iTotalOT = TimetoMin(sToTalOT)
                
                    iApvOT = Cdbl(iTotalOT)/60
                    iApvOTH = Fix(iApvOT)
                
                    if iApvOTH < 10 then
                        sApvOTH = "0" & iApvOTH
                    else
                        sApvOTH = iApvOTH 
                    end if
           
                    if (cdbl(iApvOT) - cint(sApvOTH)) > 0.5 then
                        sApvOT = sApvOTH & ":" & "30"
                    else   
                        sApvOT = sApvOTH & ":" & "00"
                    end if 
                
                    sTotalOT = MintoTime(iTotalOT)      
                end if

                response.write "<td>" & sTotalOT & "</td>"

                if sApvOT = "" or sApvOT = "00:00" then '=== Highlight incomplete
                    response.write "<td>"
                    response.write      "<div class='input-group input_APVOT'>"
                    response.write "        <input style='border-color:red;' class='form-control inputAPVBox' onfocusout=""chk00or30('txtApvOT" & i & "');"" id='txtApvOT" & i & "' name='txtApvOT" & i & "' value='" & sApvOT & "' type='text' time-mask />"
                    response.write      "</div>"
                    response.write "</td>"
                else
                    response.write "<td>"
                    response.write      "<div class='input-group input_APVOT'>"
                    response.write "        <input class='form-control inputAPVBox' onfocusout=""chk00or30('txtApvOT" & i & "');"" id='txtApvOT" & i & "' name='txtApvOT" & i & "' value='" & sApvOT & "' type='text' time-mask />"
                    response.write      "</div>"
                    response.write "</td>"
                end if

				response.write "<input type='hidden'id='txtCalMaxOT" & i & "' value='" & timeToMin(sTotalOT) & "' />"           
                
                '=== Check the employee Grade and whether SHFALL is yes
                Set rstTMGRADE = server.CreateObject("ADODB.RecordSet")
                sSQLTMGRADE = "select tmemply.GRADE_ID, tmGRADE.* from tmemply "
                sSQLTMGRADE = sSQLTMGRADE & " left join tmgrade on TMEMPLY.GRADE_ID = TMGRADE.GRADE_ID " 
                sSQLTMGRADE = sSQLTMGRADE & " where tmemply.EMP_CODE ='" & rstTMClk2("EMP_CODE") & "'" 
                rstTMGRADE.Open sSQLTMGRADE, conn, 3, 3
                if not rstTMGRADE.eof then
                    sSHFALL = rstTMGRADE("SHFALL")
                end if

                Set rstHOL_ID = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select HOL_ID from TMWORKGRP where EMP_CODE = '" & rstTMClk2("EMP_CODE") & "'"
                rstHOL_ID.Open sSQL, conn, 3, 3
                if not rstHOL_ID.eof then
                    Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMHOL1 where HOL_ID = '" & rstHOL_ID("HOL_ID") & "'"
                    sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMClk2("DT_WORK")) & "'" 
                    rstDT_HOL.Open sSQL, conn, 3, 3
                    if not rstDT_HOL.eof then '==== Check if that day is a Holiday, if yes, OT
                        sHoliday = "Y"
					else '=== if not a holiday
                        '=== is it Rest or OFF day
                        if rstTMClk2("SHF_CODE") = "REST" or rstTMCLK2("SHF_CODE") ="OFF" then 
                            sOffRest = "Y"
                        end if
                    end if
                
                end if
                
                if sSHFALL = "Y" and (sHoliday = "Y" or sOffRest = "Y") then

                    response.write "<td>"
                        response.write "<div class='input-group'>"
				        response.write "<select class='form-control' name='selAllCode" & i &"'>"
                        response.write "<option value=''></option>"
                        Set rstTMALLOW = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMALLOW order by ALLCODE" 
                        rstTMALLOW.Open sSQL, conn, 3, 3
                        if not rstTMALLOW.eof then
                            do while not rstTMALLOW.eof
                                if  rstTMALLOW("ALLCODE") = rstTMClk2("ALLCODE") then
                                    response.write "<option value='" & rstTMALLOW("ALLCODE") & "' selected='selected'>" & rstTMALLOW("ALLCODE") & "</option>"
                                else
                                    response.write "<option value='" & rstTMALLOW("ALLCODE") & "'>" & rstTMALLOW("ALLCODE") & "</option>" 
                                end if
                                rstTMALLOW.movenext
                            loop
                        end if
                        pClosetables(rstTMALLOW)
                        response.write "</select>"
                        response.write "</div>"
                         
                    response.write "</td>"
                else
                    response.write "<td></td>"
                end if
                
                response.write "<td><input name='txtComment" & i & "' class='form-control' maxlength='30'/></td>"
                
                response.write "<td style='text-align:center'><a href=""javascript:fOTShowHis('" & rstTMClk2("EMP_CODE") & "','" & rstTMClk2("DT_WORK") & "','mycontent','#mymodal')"">Show</a></td>"
                
                response.write "<td>" & rstTMCLK2("1OTAPVBY") & "</td>"
                response.write "<td>" & rstTMCLK2("2OTAPVBY") & "</td>"
                
                response.write "<td style=""text-align:center""><input type='checkbox' class='chkBox' id='txtchkbox" & i & "' name='txtchkbox" & i & "' value = '" & rstTMClk2("EMP_CODE") & "," & rstTMClk2("DT_WORK") & "'/></td>"
       
                response.write "</tr>"
                rstTMClk2.movenext
            loop
            call pCloseTables(rstTMClk2)

            %>
           
        </tbody>
    </table>
    </div>
    <div class="col-lg-12"> 
    <div class="row">
         <%if sApprov <> "" then %>
            <div class="pull-right" >
                <button type="button" id="btnCheck" name="btnCheck" value="Check" class="btn btn-primary"
                    style="width: 90px" onclick="checkempty();">
                    Approve</button>
                <button type="submit" id="btnSave" name="btnSave" value="Save" class="btnSaveHide"></button>
            </div>
        <%end if %>
     </div>
    </div>
 </form>

    <div class="row">
        <div class="col-sm-5" style="margin-top:5px">
        <br />  TOTAL RECORDS (<%=TotalRecord%>) <%=lg_page%> <%=PageNo%> / <%=TotalPage%>
        </div>
        <div class="col-sm-7">
            <br />
            <div class="dataTables_paginate">
                <ul class="pagination">
                    <%IF Cint(PageNo) > 1 then %>
                        <li class="paginate_button"><a href="javascript:showContent2('page=1','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showContent2('page=<%=PageNo-1%>','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" >< Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showContent2('page=<%=intID%>','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showContent2('page=<%=PageNo+1%>','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showContent2('page=<%=TotalPage%>','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" >Last >></a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>