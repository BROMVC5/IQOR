<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->
    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>IQOR</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <!-- Bootstrap 3.3.6 CSS -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="dist/css/dataTables.bootstrap.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
        folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css">
   
<%
    Session.Timeout = 1440
  
    sString = request("txtstring")
    if sString <> "" then
        sSplit = split(sString,"-")
        sEMP_CODE = sSplit(0)
        dtWrk = sSplit(1)
        dtFr = sSplit(2)
        dtTo = sSplit(3)
        bFrInCom = sSplit(4)
    end if
    
    'response.write "@@@ sEMP_CODE: " & sEMP_CODE & "<br>"
    'response.write "@@@ dt_Work: " & dt_Work & "<br>"
    'response.write "@@@ dtpDateFr: " & dtpDateFr & "<br>"
    'response.write "@@@ dtpDateTo: " & dtpDateTo & "<br>"
    'response.end

    if reqForm("btnSubmit") <> "" then
        sID = reqFormU("txtEMP_CODE")
        dtpDateFr = reqForm("txtdtpDateFr")
        dtpDateTo = reqForm("txtdtpDateTo")
        dt_Work = reqForm("txtDt_Work")
        bFrInCom = reqForm("txtbFrInCom")
          
        sSQL = "delete from TMCLK2 where EMP_CODE = '" & sID & "'"
        sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_Work) & "'"
        conn.execute sSQL
        
        '==== After delete the TMCLK2 record, the TMSHIFTOT still will show Normal and No Info, 
        '==== We need to record that day the Employee is Absent
        sSQL = "select tmemply.EMP_CODE as EMPCODE, tmemply.NAME, SUP_CODE, tmemply.GRADE_ID, tmemply.GENSHF, WORKGRP_ID, tmworkgrp.HOL_ID, "
        sSQL = sSQL & " tmshiftot.SHF_CODE as SHIFT_CODE, tmshiftot.DT_SHIFT, tmclk2.* from tmemply" 
        sSQL = sSQL & " left join tmworkgrp on tmemply.EMP_CODE = tmworkgrp.EMP_CODE "
        sSQL = sSQL & " left join tmshiftot on tmemply.EMP_CODE = tmshiftot.EMP_CODE "
        sSQL = sSQL & " left join tmclk2 on tmshiftot.EMP_CODE = tmclk2.EMP_CODE and  DT_SHIFT = DT_WORK"
        sSQL = sSQL & " where isnull(DT_RESIGN) "
        sSQL = sSQL & " and tmshiftot.SHF_CODE <> 'OFF' and tmshiftot.SHF_CODE <> 'REST' "  
        sSQL = sSQL & " and GENSHF = 'Y' "
        'sSQL = sSQL & " and IRREG <> 'Y' "
        sSQL = sSQL & " and tmshiftOT.EMP_CODE = '" & pRTIN(sID) & "'" 
    
        sSQL = sSQL & " and  (DT_SHIFT = '" & fdate2(dt_Work) & "')  "
        sSQL = sSQL & " order by tmemply.EMP_CODE, DT_SHIFT desc"
        set rstTMABSENT = server.createobject("adodb.recordset")

'RESPONSE.WRITE sSQL & "<br>"
    	rstTMABSENT.Open sSQL, conn, 3, 3
        if not rstTMABSENT.eof then

            Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMHOL1 where HOL_ID = '" & rstTMABSENT("HOL_ID") & "'"
            sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMABSENT("DT_SHIFT")) & "'" 
            rstDT_HOL.Open sSQL, conn, 3, 3
            if not rstDT_HOL.eof then 
                sHoliday = "Y"
            end if
       
            sSQL = "select * from TMEOFF where EMP_CODE = '" & pRTIN(sID) & "'"
		    sSQL =  sSQL & " and '" & fdate2(dt_Work) & "'"  
		    sSQL =  sSQL & " between DTFR and DTTO "  
    	    set rstTMEOFF = server.CreateObject("ADODB.Recordset")
		    rstTMEOFF.open sSQL, conn, 3, 3
		    if not rstTMEOFF.eof then
                sLeave = "Y"
            end if
    
            if isnull(rstTMABSENT("DT_WORK")) and sHoliday <> "Y" and sLeave <> "Y" then
           
                sSQL = "select * from TMABSENT where EMP_CODE = '" & pRTIN(sID) & "'"
                sSQL = sSQL & " and DT_ABSENT = '" &  fdate2(dt_Work) & "'"
                set rstTMABS = server.CreateObject("ADODB.Recordset")
                rstTMABS.open sSQL, conn, 3, 3
                if rstTMABS.eof then 
                    '=== This will be the 1st PLACE I insert ABSENT as FULL DAY
                    '=== Then every 15 mins I will still update BUT
                    '=== If user LATER added timeoff at tmeoff_det from FULL DAY to HALF, I will maintain as Half Day **
                    '=== If EARLIER tmeoff_det never insert into TMABSENT
                    '=== If LATER GetFrSAP, UPDATED the FULL DAY to HALF, i Will also maintain as Half Day
                    '=== If EARLIER  GetFrSAP, GetFrSAP will never insert into TMABSENT
                    sSQL = "INSERT into TMABSENT (EMP_CODE,NAME,GRADE_ID,WORKGRP_ID,SHF_CODE,DT_ABSENT,"
                    sSQl = sSQL & " ATTENDANCE,TYPE,SUP_CODE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                    sSQL = sSQL & " values ("
                    sSQL = sSQL & "'" & pRTIN(sID) & "',"
                    sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("GRADE_ID") & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("WORKGRP_ID") & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("SHIFT_CODE") & "',"
                    sSQL = sSQL & "'" & fdate2(dt_Work) & "',"
                    sSQL = sSQL & "'Absent',"
                    sSQL = sSQL & "'F',"
                    sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                    sSQL = sSQL & "'" & fdate2(dt_Work) & "',"
                    sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                    sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
                    sSQL = sSQL & " )"
                    
    'response.write " 1 insert : " & sSQL & "<br>" 
'response.end
                    conn.execute sSQL
                else
                    sSQL = "UPDATE TMABSENT SET "
                    sSQL = sSQL & " NAME='" & pRTIN(rstTMABSENT("NAME")) & "',"
                    sSQL = sSQL & " GRADE_ID='" & rstTMABSENT("GRADE_ID") & "',"
                    sSQL = sSQL & " WORKGRP_ID='" & rstTMABSENT("WORKGRP_ID") & "',"
                    sSQL = sSQL & " SHF_CODE='" & rstTMABSENT("SHIFT_CODE") & "',"
                    sSQL = sSQL & " DT_ABSENT='" & fdate2(dt_Work) & "',"
                    sSQL = sSQL & " ATTENDANCE='Absent',"
                    if rstTMABS("TYPE") <> "H" then '=== ** I will maintain as Half Day if Half is 
                        sSQL = sSQL & " TYPE='F',"
                    end if
                    sSQL = sSQL & " SUP_CODE='" & rstTMABSENT("SUP_CODE") & "',"
                    sSQL = sSQL & " DTPROCESS='" & fdate2(dt_Work) & "',"
                    sSQL = sSQL & " USER_ID = '" & session("USERNAME") & "',"
                    sSQL = sSQL & " DATETIME = '" & fdatetime2(Now())  & "',"
                    sSQL = sSQL & " WHERE EMP_CODE= '"& pRTIN(sID)  & "'" 
                    sSQL = sSQL & " AND DT_ABSENT='" & fdate2(dt_Work) & "'"
    response.write " 1 Update :  " & sSQL & "<br>" 
response.end
                    conn.execute sSQL
                end if

            elseif not isnull(rstTMABSENT("DT_WORK")) and sHoliday <> "Y" and sLeave <> "Y" and rstTMABSENT("HALFDAY") = "Y" then
            
                sSQL = "select * from TMABSENT where EMP_CODE = '" & rstTMABSENT("EMPCODE") & "'"
                sSQL = sSQL & " and DT_ABSENT = '" &  fdate2(dt_Work) & "'"
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
                    sSQL = sSQL & "'" & fdate2(dt_Work) & "',"
                    sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                    sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
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
                    sSQL = sSQL & " DTPROCESS='" & fdate2(dt_Work) & "',"
                    sSQL = sSQL & " USER_ID = '" & session("USERNAME") & "',"
                    sSQL = sSQL & " DATETIME = '" & fdatetime2(Now())  & "',"
                    sSQL = sSQL & " WHERE EMP_CODE= '"& pRTIN(sID) & "'" 
                    sSQL = sSQL & " AND DT_ABSENT='" & fdate2(dt_Work) & "'"
    'response.write " 2 Update : " & sSQL & "<br>" 
'response.end       
                    conn.execute sSQL
                end if

            end if '=== end if not is null (DT_WORK)
           
        end if '=== end if sSQL
  
        if bFrInCom <> "" then
            sMainURL = "tmabnorm.asp?"
        else
            sMainURL = "tmtimeclk.asp?"
        end if
    	    
        sAddURL = "Page=" & iPage & "&txtEMP_CODE=" & sID & "&dtpDateFr=" & fdate2(dtpDateFr) & "&dtpDateTo=" & fdate2(dtpDateTo) & "&txtdt_Work=" & dt_Work
    
        call confirmBox("Delete Successful!", sMainURL&sAddURL&"")
        
    End If
%>

</head>
<body>
    <form class="form-horizontal" action="tmtimeclk_del.asp" method="post">
        <input type="hidden" name="txtEMP_CODE" value='<%=sEMP_CODE%>' />
        <input type="hidden" name="txtdtpDateFr" value='<%=dtFr%>' />
        <input type="hidden" name="txtdtpDateTo" value='<%=dtTo%>' />
        <input type="hidden" name="txtDt_Work" value='<%=dtWrk%>' />
        <input type="hidden" name="txtbFrInCom" value='<%=bFrInCom%>' />
        <div class="box-body">
            <div class="form-group">
                <div class="col-lg-4">
                    <div style="text-align:center">
                        <img src="dist/img/warning.png" width="70" height="70" style="margin-left:30px" />
                    </div>
                </div>
                <div class="col-sm-7">
                    <span style="color:blue"><h3>EMPLOYEE NO : <% response.write sEMP_CODE %></h3></span>
                    <span style="color:blue"><h3>WORK DATE : <% response.write dtWrk %></h3></span>
                    <span style="color:red"><h4>Are you sure to delete this record?</h4></span>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
            <button type="button" class="btn btn-default pull-left" data-dismiss="modal" aria-label="Close" style="width: 90px;">Close</button>
            <input type="submit" name="btnSubmit" value="Delete" class="btn btn-danger pull-right" style="width: 90px"/>
        </div>
        <!-- /.box-footer --> 
    </form>                  
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
</body>
</html>
