<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<!-- #include file="../tm_process.asp" -->

<!-- JQuery 2.2.3 Compressed -->

<style>
    td.highlight {
    border: 1px solid blue;
    border-style:double;
}
</style>
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

sSQL = "select tmclk2.*, tmemply.NAME from TMCLK2 "
sSQL = sSQL & " left join tmemply on tmclk2.EMP_CODE = tmemply.EMP_CODE "
sSQL = sSQL & " where ((TIN = '' or TOUT = '') or (OTIN='' or OTOUT='') or IRREG = 'Y' ) "  '=== Incomplete triggers
sSQL = sSQL & " and DT_WORK < '" & fdate2(Date) & "'"

'=== Login as Verifier ====================================
if sAtype = "V" and sApprov = "V" and sDown <> "A" then '=== Take the role as Verifier, Approval Himself
    
    '=== Only see all the final approval
    sSQL = sSQL & " and  (not isnull(1DTAPV) and isnull(2DTAPV)) " 

elseif sAType = "V" and sApprov = "M" and sDown = "A" then '=== Take the role as Manager, All pending manager approval
    
    '=== Wanna look at all Manager's subordinate
    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
    sSQL1 = "select * from TMEMPLY where "
    sSQL1 = sSQL1 & " ATYPE = 'M' "  '=== Retrieve all Manager
    sSQL1 = sSQL1 & " order by  EMP_CODE" 
    rstTMDOWN1.Open sSQL1, conn, 3, 3
    if not rstTMDOWN1.eof then
       
        sSQL = sSQL & " and ( "
    
        Do while not rstTMDOWN1.eof
            sSQL = sSQL & " ( isnull(1DTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR "
        rstTMDOWN1.movenext
        loop
    
        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR from the string because of the loop above

        sSQL = sSQL & " )"

    end if

elseif sAType = "V" and sApprov = "M" and sDown <> "A" then '=== Take the role as Manager, sDown <> "A" is the Name/Code and his Direct subordiante  
    
    sSQL = sSQL & " and isnull(1DTAPV) and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sDown & "')" 

elseif sAType = "V" and sApprov = "S" and sDown = "A" then '=== Take the role as Superior, All thier subordinate pending 1st level approval

    '=== Wanna look at my subordinate must be a Superior's subordinate
    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
    sSQL1 = "select * from TMEMPLY where "
    sSQL1 = sSQL1 & " ATYPE = 'S' "  
    sSQL1 = sSQL1 & " order by  EMP_CODE" 
    rstTMDOWN1.Open sSQL1, conn, 3, 3
    if not rstTMDOWN1.eof then
       
        sSQL = sSQL & " and ( "
    
        Do while not rstTMDOWN1.eof
            sSQL = sSQL & " ( isnull(1DTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR "
        rstTMDOWN1.movenext
        loop
    
        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR from the string because of the loop above

        sSQL = sSQL & " )"

    end if


    'sSQL = sSQL & " and isnull(1DTAPV) and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where ATYPE = 'E')"

elseif sAType = "V" and sApprov = "S" and sDown <> "A" then '=== Take the role as Superior, sDown <> "A" is the Name/Code and his Direct subordiante 
    
    sSQL = sSQL & " and isnull(1DTAPV) and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sDown & "')" 

'=== Login as Manager ====================================
elseif sAType = "M" and sApprov = "M" and sDown <> "A" then  '===Take the role as Manager, sDown <> "A" is his Name/Code and his direct subordinate
    
    sSQL = sSQL & " and ( "
    sSQL = sSQL & " isnull(1DTAPV) and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sDown & "')"
    sSQL = sSQL & " )"

elseif sAType = "M" and sApprov = "S" and sDown = "A" then '=== Login as manager, take the role as Superior, All Superior.

    '=== Wanna look at my subordinate must be a Superior's subordinate
    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
    sSQL1 = "select * from TMEMPLY where "
    sSQL1 = sSQL1 & " SUP_CODE ='" & session("USERNAME") & "'" '=== Select All Retrieve all Manager's Superior subordinate
    sSQL1 = sSQL1 & " AND ATYPE = 'S' "  
    sSQL1 = sSQL1 & " order by  EMP_CODE" 
    rstTMDOWN1.Open sSQL1, conn, 3, 3
    if not rstTMDOWN1.eof then
       
        sSQL = sSQL & " and ( "
    
        Do while not rstTMDOWN1.eof
            sSQL = sSQL & " ( isnull(1DTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR "
        rstTMDOWN1.movenext
        loop
    
        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR from the string because of the loop above

        sSQL = sSQL & " )"

    end if

elseif sAType = "M" and sApprov = "S" and sDown <> "A" then  '=== Take the role as Superior, sDown <> "A" meaning sDown is the Superior and his direct subordinate

    sSQL = sSQL & " and isnull(1DTAPV) and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sDown & "')"

'=== Login as Verifier ====================================
elseif sAType = "S" and sApprov = "S" and sDown <> "A" then '=== Approve as Superior, sDown <> "A" meaning sDown is his name and his direct subordinate

    '=== See the Superior direct subordinate 
    sSQL = sSQL & " and isnull(1DTAPV) and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sDown & "')"
    
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

if sOrderBy = "undefined" or sOrderBy = ""  then
    sSQL = sSQL & " order by tmclk2.DT_WORK asc"
else
    if sAscDesc = "Asc" then
        sSQL = sSQL & " order by " & sOrderBy & " , tmclk2.DT_WORK asc"
    elseif sAscDesc = "Desc" then
        sSQL = sSQL & " order by " & sOrderBy & " desc" & " ,  tmclk2.DT_WORK desc"
    end if
end if

set rstTMAbnorm = server.createobject("adodb.recordset")
rstTMAbnorm.cursortype = adOpenStatic
rstTMAbnorm.cursorlocation = adUseClient
rstTMAbnorm.locktype = adLockBatchOptimistic
rstTMAbnorm.pagesize = PageLen		
rstTMAbnorm.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMAbnorm.eof then
 	rstTMAbnorm.absolutepage = iCurPage
 	'iPageCount = rstTMAbnorm.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMAbnorm.RecordCount
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
   
    if reqForm("btnSave") <> "" then
    
        j=0
     
        do while j < PageLen
         
            j = j + 1
        
            if reqForm("txtchkbox" & j ) <> "" then
                                
                sString = reqForm("txtchkbox" & j)
                sSplit = split(sString,",")
                sEmp_Code = sSplit(0)
                sDt_Work = sSplit(1)

                sTIN = reqForm("txtTimeIn" & j)
                sTOUT = reqForm("txtTimeOut" & j)
    
                sSHF_CODE = reqForm("selShfCode" & j) '=== This is from the form
                sComment = reqForm("txtComment" & j) 

                Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")
                sSQLShfCode = "select STIME,ETIME from TMSHFCODE where SHF_CODE ='" & sSHF_CODE & "'" 
                rstTMSHFCODE.Open sSQLShfCode, conn, 3, 3
                if not rstTMSHFCODE.eof then
                    if rstTMSHFCODE("STIME") <> "" and rstTMSHFCODE("ETIME") <> "" then
                        sSTIME = rstTMSHFCODE("STIME")
                        sETIME = rstTMSHFCODE("ETIME")
                    else
                        sSTIME = rstTMAbnorm("STIME")
                        sETIME = rstTMAbnorm("ETIME")
                    end if 
                end if
                
                '========= Check if there is Anychanges, this is insert in TMLOG
                '==== Get the orginal records from Database and if "" put EMPTY if any changes it will started inserting
                sOTIN = rstTMAbnorm("TIN")
                sOTOUT = rstTMAbnorm("TOUT")
                sOSHF_CODE = rstTMAbnorm("SHF_CODE")
                
                '==== Compare the original to the newly Input data, if different, add Comment
                if sOSHF_CODE <> sSHF_CODE then
                    sChangesM = " SHIFT CODE change from " & sOSHF_CODE & " to " & sSHF_CODE & " "
                end if
    
                if sOTIN <> sTIN then
                    if sOTIN = "" then
                        SOTIN = "EMPTY"
                    end if 
                    sChangesM = sChangesM & " TIME IN change from " & sOTIN & " to " & sTIN & " "
                end if
                
                if sOTOUT <> sTOUT then
                    if sOTOUT = "" then
                        SOTOUT = "EMPTY"
                    end if                 
                    sChangesM = sChangesM & " TIME OUT change from " & sOTOUT & " to " & sTOUT & " "
                end if
                '===========================
                '==============================================================

                sSQL = "UPDATE TMCLK2 SET "             
                sSQL = sSQL & "SHF_CODE = '" & sSHF_CODE & "'," 

                '===AllCode, Check the employee Grade to if Shift Allowance is yes
                Set rstTMGRADE = server.CreateObject("ADODB.RecordSet")
                sSQLTMGRADE = "select tmemply.GRADE_ID, tmGRADE.* from tmemply "
                sSQLTMGRADE = sSQLTMGRADE & " left join tmgrade on TMEMPLY.GRADE_ID = TMGRADE.GRADE_ID " 
                sSQLTMGRADE = sSQLTMGRADE & " where tmemply.EMP_CODE ='" & sEmp_Code & "'" 
                sSQLTMGRADE = sSQLTMGRADE & " and tmgrade.SHFALL ='Y'" 
                rstTMGRADE.Open sSQLTMGRADE, conn, 3, 3
                if not rstTMGRADE.eof then
                    '=== Check Allowance if exist, Allowance COde is similar to SHF_CODE
                    Set rstTMALLOW = server.CreateObject("ADODB.RecordSet")
                    sSQLTMALLOW = "SELECT * FROM  tmallow "
                    sSQLTMALLOW = sSQLTMALLOW & " where tmallow.ALLCODE ='" & sSHF_CODE & "'" 
                    rstTMALLOW.Open sSQLTMALLOW, conn, 3, 3
                    if not rstTMALLOW.eof then
                        sSQL = sSQL & " ALLCODE = '" & rstTMALLOW("ALLCODE") & "',"
                    else
                        sSQL = sSQL & " ALLCODE = '',"
                    end if
                else
                    sSQL = sSQL & " ALLCODE = '',"
                end if
                '================================================================

                if sSHF_CODE = "REST" or sSHF_CODE = "OFF" then
                    sSQL = sSQL & " TIN = '" & sTIn & "',"
                    sSQL = sSQL & " TOUT = '" & sTOut & "',"
                else
                    sSQL = sSQL & " STIME = '" & sSTIME & "',"
                    sSQL = sSQL & " ETIME = '" & sETIME & "',"
                    sSQL = sSQL & " TIN = '" & sTIn & "',"
                    sSQL = sSQL & " TOUT = '" & sTOut & "',"
                end if
                
                Set rst2NDLVL = server.CreateObject("ADODB.RecordSet")
                sSQL2NDLVL = "select * from TMClk2 where EMP_CODE ='" & sEmp_Code & "'" 
                sSQL2NDLVL = sSQL2NDLVL & " and DT_WORK = '" & fdate2(sDt_Work) & "'"
                rst2NDLVL.Open sSQL2NDLVL, conn, 3, 3
                if not rst2NDLVL.eof then
                    if not isNull(rst2NDLVL("1DTAPV")) then '===2nd level approval, Verifier approval 
                        sSQL = sSQL & "2DTAPV = '" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "2APVBY = '" & session("USERNAME") & "',"
                        sSQL = sSQL & "ABCOMMENT2 = '" & pRTIN(sComment) & "',"
                        
                        '===== Insert into LOG file ======
                        '==== Get the orginal records from Database and if "" put EMPTY
                        sOComment = rstTMAbnorm("ABCOMMENT")
                        
                        if sComment <> sOComment then
                            if sOComment = "" then
                                SOComment = "EMPTY"
                            end if 
                            sChangesM = sChangesM & " COMMENT change from " & sOComment & " to " & sComment & " "
                        end if

                        if sChangesM <> "" then
                            sSQLLog = "insert into TMLOG (EMP_CODE,DT_WORK,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		                    sSQLLog = sSQLLog & "values ("
                            sSQLLog = sSQLLog & "'" & sEmp_Code & "',"		
		                    sSQLLog = sSQLLog & "'" & fdate2(sDt_Work) & "',"
                            sSQLLog = sSQLLog & "'2nd lvl Abnormal Approval',"
                            sSQLLog = sSQLLog & "'Success',"
                            sSQLLog = sSQLLog & "'" & pRTIN(sChangesM) & "',"
                            sSQLLog = sSQLLog & "'" & session("USERNAME") & "'," 
                            sSQLLog = sSQLLog & "'" & fdatetime2(Now()) & "'"
		                    sSQLLog = sSQLLog & ") "
                            conn.execute sSQLLog
                        end if
                        '===============================
                    else
                        sSQL = sSQL & "1DTAPV = '" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "1APVBY = '" & session("USERNAME") & "',"
                        sSQL = sSQL & "ABCOMMENT = '" & pRTIN(sComment) & "',"
        
                        '===== Insert into LOG file ======
                        '==== Get the orginal records from Database and if "" put EMPTY
                        sOComment = rstTMAbnorm("ABCOMMENT")
                
                        if sComment <> sOComment then
                            if sOComment = "" then
                                SOComment = "EMPTY"
                            end if 
                            sChangesM = sChangesM & " COMMENT change from " & sOComment & " to " & sComment & " "
                        end if
                
                        if sChangesM <> "" then
                            sSQLLog = "insert into TMLOG (EMP_CODE,DT_WORK,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		                    sSQLLog = sSQLLog & "values ("
                            sSQLLog = sSQLLog & "'" & sEmp_Code & "',"		
		                    sSQLLog = sSQLLog & "'" & fdate2(sDt_Work) & "',"
                            sSQLLog = sSQLLog & "'1st lvl Abnormal Approval',"
                            sSQLLog = sSQLLog & "'Success',"
                            sSQLLog = sSQLLog & "'" & pRTIN(sChangesM) & "',"
                            sSQLLog = sSQLLog & "'" & session("USERNAME") & "'," 
                            sSQLLog = sSQLLog & "'" & fdatetime2(Now()) & "'"
		                    sSQLLog = sSQLLog & ") "
                            conn.execute sSQLLog
                        end if
                        '===============================
                    end if
                end if
    
                sSQL = sSQL & " USER_ID = '" & session("USERNAME") & "',"
                sSQL = sSQL & " DATETIME = '" & fdatetime2(Now()) & "'"
                sSQL = sSQL & " WHERE EMP_CODE = '" & sEmp_Code & "' AND DT_WORK ='" & fdate2(sDt_Work) & "'"
                conn.execute sSQL        
    
                '==========After insert calculate and process OT, LATE, EARLY====================
                '=== the following method will always have sEmp_Code so LATEST changes here will override any previous stuff.
                call fProcAbOT((sDt_Work), sEmp_Code, "N")
                '================================================================================

                '=== Since this is abnormal, we shall keep it as abnormal.
                '=== After fProcAbOt, IRREG will be removed because Supervisor/Verifier already change the Status
                '=== We need to maintain it. Once abnormal always abnormal.
                sSQL = "UPDATE TMCLK2 SET "             
                sSQL = sSQL & " IRREG = 'Y'" 
                sSQL = sSQL & " WHERE EMP_CODE = '" & sEmp_Code & "' AND DT_WORK ='" & fdate2(sDt_Work) & "'"
                conn.execute sSQL   
                
            end if  '=== End if reqForm("txtchkbox" & j ) <> "" then

        loop

        sMainURL = "../tmabnorm.asp?"
        sAddURL = "txtApprov=" & sApprov & "&txtDown=" & sDown & "&AfterApprove=Y" & "&txtWorkGrp_ID=" & sWorkGrp_ID & "&txtWork_ID=" & sWork_ID
        sAddURL = sAddURL & "&txtOrderBy=" & sOrderBy & "&txtAscDesc=" & sAscDesc 
        call confirmBox("Approved Successful!", sMainURL&sAddURL)
         
    end if

%>
<form id="form2" name="form2" action="ajax/ax_tmabnorm.asp" method="post">
<input type="hidden" name="txtLogin" value="<%=sLogin%>" />
<input type="hidden" name="txtApprov" value="<%=sApprov%>" />
<input type="hidden" name="txtDown" value="<%=sDown%>" />
<input type="hidden" name="txtEmp_Code" value="<%=sEMP_CODE%>" />
<input type="hidden" name="txtWorkGrp_ID" value="<%=sWorkGrp_ID%>" />
<input type="hidden" name="txtWork_ID" value="<%=sWork_ID%>" />
<input type="hidden" name="txtOrderBy" value="<%=sOrderBy%>" />
<input type="hidden" name="txtAscDesc" value="<%=sAscDesc%>" />

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
                    <th style="width:8%">Adj Shift Code</th>
                    <th style="width:8%"><a href="javascript:showContent2('page=<%=PageNo%>','TIN','Asc');">Time In</a></th>
                    <th style="width:8%"><a href="javascript:showContent2('page=<%=PageNo%>','TOUT','Asc');">Time Out</a></th>
                    <th style="width:15%">Comment</th>
                    <th style="width:5%">History</th>
                    <th style="width:6%"><a href="javascript:showContent2('page=<%=PageNo%>','1APVBY','Asc');">1st Apv</a></th>
                <%else %>
                    <th style="width:6%"><a href="javascript:showContent2('page=<%=PageNo%>','EMP_CODE','Desc');">Emp Code</a></th>
                    <th style="width:14%"><a href="javascript:showContent2('page=<%=PageNo%>','NAME','Desc');">Name</a></th>
                    <th style="width:3%">Day</th>
                    <th style="width:7%"><a href="javascript:showContent2('page=<%=PageNo%>','DT_WORK','Desc');">Work Date</a></th>
                    <th style="width:10%"><a href="javascript:showContent2('page=<%=PageNo%>','SHF_CODE','Desc');">Shift</a></th>
                    <th style="width:8%">Adj Shift Code</th>
                    <th style="width:8%"><a href="javascript:showContent2('page=<%=PageNo%>','TIN','Desc');">Time In</a></th>
                    <th style="width:8%"><a href="javascript:showContent2('page=<%=PageNo%>','TOUT','Desc');">Time Out</a></th>
                    <th style="width:15%">Comment</th>
                    <th style="width:5%">History</th>
                    <th style="width:6%"><a href="javascript:showContent2('page=<%=PageNo%>','1APVBY','Desc');">1st Apv</a></th>
                <%end if %>
                    <th style="width:5%;text-align:center">
						<input type="checkbox" 
							onclick="if (this.checked) { checkAll() } else { uncheckAll() }" /></br>
							<span>Approve</span>
					</th>
                    <th style="width:5%;text-align:center">Delete</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                do while not rstTMAbnorm.eof and i < pageLen ' When recordset is not EOF and i < pageLen continue to do, stop when 
                                            
                i = i + 1                             
                response.write "<tr>"
                
                response.write "<td>" & rstTMAbnorm("EMP_CODE") & "</td>"
               
                response.write "<td>" & rstTMAbnorm("NAME") & "</td>"
                
                response.write "<td>" & Weekdayname(weekday(rstTMAbnorm("DT_WORK"),1),True) & "</td>"
                response.write "<td>" & rstTMAbnorm("DT_WORK") & "</td>"
                
                if rstTMAbnorm("SHF_CODE") = "OFF" or rstTMAbnorm("SHF_CODE") = "REST" then
                    response.write "<td>" & rstTMAbnorm("SHF_CODE") & "</td>"
                else
                    response.write "<td>" & rstTMAbnorm("SHF_CODE") & " " & rstTMAbnorm("STIME") & " - " & rstTMAbnorm("ETIME") & "</td>"
                end if

                response.write "<td>"
                    response.write "<div class='input-group'>"
				    response.write "<select class='form-control' name='selShfCODE" & i &"'>"
                    response.write "<option value='' disabled>Select</option>"
                    Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMSHFCODE order by SHF_CODE" 
                    rstTMSHFCODE.Open sSQL, conn, 3, 3
                    if not rstTMSHFCODE.eof then
                        do while not rstTMSHFCODE.eof
                            if  rstTMSHFCODE("SHF_CODE") = rstTMAbnorm("SHF_CODE") then
                                response.write "<option value='" & rstTMSHFCODE("SHF_CODE") & "' selected='selected'>" & rstTMSHFCODE("SHF_CODE") & "</option>"
                            else
                                response.write "<option value='" & rstTMSHFCODE("SHF_CODE") & "'>" & rstTMSHFCODE("SHF_CODE") & "</option>" 
                            end if
                            rstTMSHFCODE.movenext
                        loop
                    end if
                    pClosetables(rstTMSHFCODE)
                    response.write "</select>"
                    response.write "</div>"
                response.write "</td>"

                response.write "<input type='hidden' id='txtEmpCode"& i & "' value='" & rstTMAbnorm("EMP_CODE") & "' />"
                response.write "<input type='hidden' id='dtWork" & i & "' value='" & rstTMAbnorm("DT_WORK")  & "' />"

                if rstTMAbnorm("TIN") = "" then '=== Highlight incomplete
                    response.write "<td>"
                    response.write      "<div class='input-group input_TIN'>"
                    response.write          "<input style='border-color:red;' class='form-control inputTINBox'  id='txtTimeIn" & i & "' name='txtTimeIn" & i & "' value='" & rstTMAbnorm("TIN")  & "' type='text' data-inputmask=""'alias': 'hh:mm'"" time-maskprocess />"
                    response.write      "</div>"
                    response.write "</td>"
                else
                    response.write "<td>"
                    response.write      "<div class='input-group input_TIN'>"
                    response.write          "<input class='form-control inputTINBox'  id='txtTimeIn" & i & "' name='txtTimeIn" & i & "' value='" & rstTMAbnorm("TIN")  & "' type='text' data-inputmask=""'alias': 'hh:mm'"" time-maskprocess />"
                    response.write      "</div>"
                    response.write "</td>"
                end if
                
                if rstTMAbnorm("TOUT") = "" then '====Highlight incomplete
                    response.write "<td>"
                    response.write      "<div class='input-group input_TOUT'>"
                    response.write          "<input style='border-color:red;' class='form-control inputTOUTBox'  id='txtTimeOut" & i & "' name='txtTimeOut" & i & "' value='" & rstTMAbnorm("TOUT") & "' type='text' data-inputmask=""'alias': 'hh:mm'"" time-maskprocess />"
                    response.write      "</div>"
                    response.write "</td>"
                else
                    response.write "<td>"
                    response.write      "<div class='input-group input_TOUT'>"
                    response.write          "<input class='form-control inputTOUTBox' id='txtTimeOut" & i & "' name='txtTimeOut" & i & "' value='" & rstTMAbnorm("TOUT") & "' type='text' data-inputmask=""'alias': 'hh:mm'"" time-maskprocess />"
                    response.write      "</div>"
                    response.write "</td>"
                end if

                response.write "<td><input id='txtComment" & i & "' name='txtComment" & i & "' class='form-control' maxlength='30'/></td>"
                
                response.write "<td style='text-align:center'><a href=""javascript:fABShowHis('" & rstTMAbnorm("EMP_CODE") & "','" & rstTMAbnorm("DT_WORK") & "','mycontent','#mymodal')"">Show</a></td>"
              
                response.write "<td>" & rstTMABNORM("1APVBY") & "</td>"
                
                response.write "<td style=""text-align:center""><input type='checkbox' id='txtchkbox" & i & "' name='txtchkbox" & i & "' value = '" & rstTMAbnorm("EMP_CODE") & "," & rstTMAbnorm("DT_WORK") & "'/></td>"
                
                if rstTMAbnorm("IRREG") = "Y" then
                    response.write "<td style='text-align:center'><a href=""javascript:DelTrans('page=" & PageNo & "','IRREG','" & i & "','" & sOrderBy & "','" & sAscDesc & "');""><img src=""dist/img/x-mark-24.png"" /></a></button></td>"
                else
                    response.write "<td style='text-align:center'><a href=""javascript:DelTrans('page=" & PageNo & "','INCOM','" & i & "','" & sOrderBy & "','" & sAscDesc & "');""><img src=""dist/img/x-mark-24.png"" /></a></button></td>"
                end if
                response.write "</tr>"
                rstTMAbnorm.movenext
            loop
            call pCloseTables(rstTMAbnorm)

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
  