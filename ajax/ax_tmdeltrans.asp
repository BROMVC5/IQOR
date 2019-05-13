<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
    Response.ContentType = "application/json"	
	Server.ScriptTimeout = 1000000
	
    sWhat = request("txtWhat")
    sID = request("txtID")
    dtWork = request("dtWork")
    sComment = request("txtComment")

    sSQL = "select tmemply.EMP_CODE as EMPCODE, tmemply.NAME, SUP_CODE, tmemply.GRADE_ID, tmemply.GENSHF, WORKGRP_ID, tmworkgrp.HOL_ID, "
    sSQL = sSQL & " tmshiftot.SHF_CODE as SHIFT_CODE, tmshiftot.DT_SHIFT, tmclk2.* from tmemply" 
    sSQL = sSQL & " left join tmworkgrp on tmemply.EMP_CODE = tmworkgrp.EMP_CODE "
    sSQL = sSQL & " left join tmshiftot on tmemply.EMP_CODE = tmshiftot.EMP_CODE "
    sSQL = sSQL & " left join tmclk2 on tmshiftot.EMP_CODE = tmclk2.EMP_CODE and  DT_SHIFT = DT_WORK"
    sSQL = sSQL & " where isnull(DT_RESIGN) "
    sSQL = sSQL & " and tmshiftot.SHF_CODE <> 'OFF' and tmshiftot.SHF_CODE <> 'REST' "  
    sSQL = sSQL & " and GENSHF = 'Y' "
    sSQL = sSQL & " and tmshiftOT.EMP_CODE = '" & sID & "'" 
    sSQL = sSQL & " and  (DT_SHIFT = '" & fdate2(dtWork) & "')  "
    sSQL = sSQL & " order by tmemply.EMP_CODE, DT_SHIFT desc"
    set rstTMABSENT = server.createobject("adodb.recordset")
    rstTMABSENT.Open sSQL, conn, 3, 3
    if not rstTMABSENT.eof then
        sHoliday = ""
        sLeave = ""
        
        Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMHOL1 where HOL_ID = '" & sID & "'"
        sSQL = sSQL & " and DT_HOL = '" & fdate2(dtWork) & "'" 
        rstDT_HOL.Open sSQL, conn, 3, 3
        if not rstDT_HOL.eof then 
            sHoliday = "Y"
        end if
       
        sSQL = "select * from TMEOFF where EMP_CODE = '" & sID & "'"
		sSQL =  sSQL & " and '" & fdate2(dtWork) & "'"  
		sSQL =  sSQL & " between DTFR and DTTO "  
		set rstTMEOFF = server.CreateObject("ADODB.Recordset")
		rstTMEOFF.open sSQL, conn, 3, 3
		if not rstTMEOFF.eof then
            sLeave = "Y"
        end if
    
        if sHoliday <> "Y" and sLeave <> "Y" then
           
            sSQL = "select * from TMABSENT where EMP_CODE = '" & sID & "'"
            sSQL = sSQL & " and DT_ABSENT = '" &  fdate2(dtWork) & "'"
            set rstTMABS = server.CreateObject("ADODB.Recordset") 
            rstTMABS.open sSQL, conn, 3, 3
            if rstTMABS.eof then 
                sSQL = "INSERT into TMABSENT (EMP_CODE,NAME,GRADE_ID,WORKGRP_ID,SHF_CODE,DT_ABSENT,"
                sSQl = sSQL & " ATTENDANCE,TYPE,SUP_CODE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                sSQL = sSQL & " values ("
                sSQL = sSQL & "'" & rstTMABSENT("EMPCODE") & "',"
                sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                sSQL = sSQL & "'" & rstTMABSENT("GRADE_ID") & "',"
                sSQL = sSQL & "'" & rstTMABSENT("WORKGRP_ID") & "',"
                sSQL = sSQL & "'" & rstTMABSENT("SHIFT_CODE") & "',"
                sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                sSQL = sSQL & "'Absent',"
                sSQL = sSQL & "'F',"
                sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                sSQL = sSQL & "'" & fdate2(Date()) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "',"  
                sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
'response.write " 1 insert : " & sSQL & "<br>" 
'response.end
                conn.execute sSQL
            else
                sSQL = "UPDATE TMABSENT SET "
                sSQL = sSQL & " NAME='" & pRTIN(rstTMABSENT("NAME")) & "',"
                sSQL = sSQL & " GRADE_ID='" & rstTMABSENT("GRADE_ID") & "',"
                sSQL = sSQL & " WORKGRP_ID='" & rstTMABSENT("WORKGRP_ID") & "',"
                sSQL = sSQL & " SHF_CODE='" & rstTMABSENT("SHIFT_CODE") & "',"
                sSQL = sSQL & " DT_ABSENT='" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                sSQL = sSQL & " ATTENDANCE='Absent',"
                if rstTMABS("TYPE") <> "H" then '=== ** I will maintain as Half Day if Half is 
                    sSQL = sSQL & " TYPE='F',"
                end if
                sSQL = sSQL & " SUP_CODE='" & rstTMABSENT("SUP_CODE") & "',"
                sSQL = sSQL & " DTPROCESS='" & fdate2(Date())  & "',"
                sSQL = sSQL & " USER_ID='" & session("USERNAME") & "',"  
                sSQL = sSQL & " DATETIME='" & fdatetime2(Now()) & "'"
                sSQL = sSQL & " WHERE EMP_CODE= '"& rstTMABSENT("EMPCODE")  & "'" 
                sSQL = sSQL & " AND DT_ABSENT='" & fdate2(rstTMABSENT("DT_SHIFT")) & "'"
'response.write " 1 Update :  " & sSQL & "<br>" 
'response.end
                conn.execute sSQL
            end if

        elseif sHoliday <> "Y" and sLeave <> "Y" and rstTMABSENT("HALFDAY") = "Y" then
            
            sSQL = "select * from TMABSENT where EMP_CODE = '" & rstTMABSENT("EMPCODE") & "'"
            sSQL = sSQL & " and DT_ABSENT = '" &  fdate2(rstTMABSENT("DT_SHIFT")) & "'"
            set rstTMABS = server.CreateObject("ADODB.Recordset")
            rstTMABS.open sSQL, conn, 3, 3
            if rstTMABS.eof then  
                sSQL = "INSERT into TMABSENT (EMP_CODE,NAME,GRADE_ID,WORKGRP_ID,SHF_CODE,DT_ABSENT,"
                sSQl = sSQL & " ATTENDANCE,TYPE,SUP_CODE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                sSQL = sSQL & " values ("
                sSQL = sSQL & "'" & rstTMABSENT("EMPCODE") & "',"
                sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                sSQL = sSQL & "'" & rstTMABSENT("GRADE_ID") & "',"
                sSQL = sSQL & "'" & rstTMABSENT("WORKGRP_ID") & "',"
                sSQL = sSQL & "'" & rstTMABSENT("SHIFT_CODE") & "',"
                sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                sSQL = sSQL & "'Absent',"
                sSQL = sSQL & "'H',"
                sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                sSQL = sSQL & "'" & fdate2(Date())  & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "',"  
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                conn.execute sSQL
'response.write " 2 Insert :  " & sSQL & "<br>" 
            else
                sSQL = "UPDATE TMABSENT SET "
                sSQL = sSQL & " NAME='" & pRTIN(rstTMABSENT("NAME")) & "',"
                sSQL = sSQL & " GRADE_ID='" & rstTMABSENT("GRADE_ID") & "',"
                sSQL = sSQL & " WORKGRP_ID='" & rstTMABSENT("WORKGRP_ID") & "',"
                sSQL = sSQL & " SHF_CODE='" & rstTMABSENT("SHIFT_CODE") & "',"
                sSQL = sSQL & " DT_ABSENT='" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                sSQL = sSQL & " ATTENDANCE='Absent',"
                sSQL = sSQL & " TYPE='H',"
                sSQL = sSQL & " SUP_CODE='" & rstTMABSENT("SUP_CODE") & "',"
                sSQL = sSQL & " DTPROCESS='" & fdate2(Date())  & "',"
                sSQL = sSQL & " USER_ID'" & session("USERNAME") & "',"  
                sSQL = sSQL & " DATETIME='" & fdatetime2(Now()) & "'"
                sSQL = sSQL & " WHERE EMP_CODE= '"& rstTMABSENT("EMPCODE")  & "'" 
                sSQL = sSQL & " AND DT_ABSENT='" & fdate2(rstTMABSENT("DT_SHIFT")) & "'"
'response.write " 2 Update : " & sSQL & "<br>" 
'response.end
                conn.execute sSQL
            end if

        end if '=== end if not is null (DT_WORK)
       
    end if '=== end if sSQL

    'response.write "{ ""data"": { ""status"": """ & sSQL & """ } }"
       ' response.end    

    if sWhat = "INCOM" then
        
        sSQL = "DELETE from TMCLK2 where EMP_CODE='" & sID & "'"
        sSQL = sSQL & " and DT_WORK='" & fdate2(dtWork) & "'" 
        conn.execute sSQL
    
        Set rstTMEmply = server.CreateObject("ADODB.RecordSet") 
        sSQLE = "select EMAIL, NAME from TMEMPLY where EMP_CODE = '" & sID & "'" 
        rstTMEmply.Open sSQLE, conn, 3, 3
        if not rstTMEmply.eof then
            sName = rstTMEmply("NAME")
            sEmail = rstTMEmply("EMAIL")
        end if

        sSubject = "Incomplete attendance on " & dtWork & " has been Rejected"
        sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
        sContent = sContent & "Your Incomplete attendance on " & dtWork & " has been Rejected.<br>"
        sContent = sContent & "Reason : " & sComment & " </html>"

        '=== Send Email                    
        sSQLE = "insert into BROMAIL (EMP_CODE,NAME,RECEIVER,SUBJECT,CONTENT,TYPE,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		sSQLE = sSQLE & "values ("
        sSQLE = sSQLE & "'" & sID & "',"		
		sSQLE = sSQLE & "'" & sName & "',"
        sSQLE = sSQLE & "'" & sEmail & "',"
        sSQLE = sSQLE & "'" & sSubject & "',"
        sSQLE = sSQLE & "'" & sContent & "',"
        sSQLE = sSQLE & "'REJ_INCOM',"
        sSQLE = sSQLE & "'" & session("USERNAME") & "'," 
        sSQLE = sSQLE & "'" & fdatetime2(Now()) & "',"
	    sSQLE = sSQLE & "'" & session("USERNAME") & "'," 
        sSQLE = sSQLE & "'" & fdatetime2(Now()) & "'"
		sSQLE = sSQLE & ") "
        conn.execute sSQLE
    
        '=== Insert into LOG
        sChangesM = "DELETE INCOMPLETE RECORD Employee : " & sID & " Working On : " & dtWork 
        sSQL = "insert into TMLOG (EMP_CODE,DT_WORK,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		sSQL = sSQL & "values ("
        sSQL = sSQL & "'" & sID & "',"		
		sSQL = sSQL & "'" & fdate2(dtWork) & "',"
        sSQL = sSQL & "'Delete Incomplete',"
        sSQL = sSQL & "'Success',"
        sSQL = sSQL & "'" & sChangesM & "',"
        sSQL = sSQL & "'" & session("USERNAME") & "'," 
        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		sSQL = sSQL & ") "
        conn.execute sSQL 

        response.write "{ ""data"": { ""status"": ""OK"" } }"
        response.end
    
    elseif sWhat = "IRREG" then
        
        sSQL = "DELETE from TMCLK2 where EMP_CODE='" & sID & "'"
        sSQL = sSQL & " and DT_WORK='" & fdate2(dtWork) & "'" 
        conn.execute sSQL    
    
        Set rstTMEmply = server.CreateObject("ADODB.RecordSet") 
        sSQLE = "select EMAIL, NAME from TMEMPLY where EMP_CODE = '" & sID & "'" 
        rstTMEmply.Open sSQLE, conn, 3, 3
        if not rstTMEmply.eof then
            sName = rstTMEmply("NAME")
            sEmail = rstTMEmply("EMAIL")
        end if

        sSubject = "Irregular attendance on " & dtWork & " has been Rejected"
        sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
        sContent = sContent & "Your Irregular attendance on " & dtWork & " has been Rejected.<br>"
        sContent = sContent & "Reason : " & sComment & " </html>"

        '=== Send Email                    
        sSQLE = "insert into BROMAIL (EMP_CODE,NAME,RECEIVER,SUBJECT,CONTENT,TYPE,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		sSQLE = sSQLE & "values ("
        sSQLE = sSQLE & "'" & sID & "',"		
		sSQLE = sSQLE & "'" & sName & "',"
        sSQLE = sSQLE & "'" & sEmail & "',"
        sSQLE = sSQLE & "'" & sSubject & "',"
        sSQLE = sSQLE & "'" & sContent & "',"
        sSQLE = sSQLE & "'REJ_IRREG',"
        sSQLE = sSQLE & "'" & session("USERNAME") & "'," 
        sSQLE = sSQLE & "'" & fdatetime2(Now()) & "',"
	    sSQLE = sSQLE & "'" & session("USERNAME") & "'," 
        sSQLE = sSQLE & "'" & fdatetime2(Now()) & "'"
		sSQLE = sSQLE & ") "
        conn.execute sSQLE
    
        '=== Insert into LOG
        sChangesM = "DELETE IRREGULAR RECORD Employee : " & sID & " Working On : " & dtWork 
        sSQL = "insert into TMLOG (EMP_CODE,DT_WORK,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		sSQL = sSQL & "values ("
        sSQL = sSQL & "'" & sID & "',"		
		sSQL = sSQL & "'" & fdate2(dtWork) & "',"
        sSQL = sSQL & "'Delete Irregular',"
        sSQL = sSQL & "'Success',"
        sSQL = sSQL & "'" & sChangesM & "',"
        sSQL = sSQL & "'" & session("USERNAME") & "'," 
        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		sSQL = sSQL & ") "
        conn.execute sSQL 

        response.write "{ ""data"": { ""status"": ""OK"" } }"
        response.end    
 
    end if
%>


