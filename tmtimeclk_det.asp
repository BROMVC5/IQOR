<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <!-- #include file="tm_process.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Time Clock Entry</title>
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
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
    
    <%

    Dim sOrigValue(11)
    Dim sNewValue(11)

    iPage = request("Page")
    sEMP_CODE = UCase(request("txtEMP_CODE"))
    dtpFrDate = request("dtpFrDate")
    dtpToDate = request("dtpToDate")
    dt_Work = request("txtdt_Work")
    bFrInCom = request("bFrInCom")
   
    if sEMP_CODE <> "" then
        sID = sEMP_CODE
    else
        sID = UCase(reqForm("txtID"))
    end if

    if dt_Work <> "" then
        dtWork = dt_Work
    else
        dtWork = reqForm("dt_Work")
    end if
    
    sModeSub = request("sub")
    
    sMainURL = "tmtimeclk.asp?"
	sAddURL = "Page=" & iPage & "&txtEMP_CODE=" & sID & "&dtpFrDate=" & fdate2(dtpFrDate) & "&dtpToDate=" & fdate2(dtpToDate) & "&txtdt_Work=" & dtWork
    
    Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMClk2 where EMP_CODE='" & sEMP_CODE & "'"  
    sSQL = sSQL & " and DT_WORK='" & fdate2(dt_Work) & "'"  
    rstTMClk2.Open sSQL, conn, 3, 3
    if not rstTMClk2.eof then
        sUpdate = "Y"
    end if


    if sModeSub <> "" Then
        
        sSHF_CODE = reqForm("txtShf_Code")
        sAllCode = reqForm("txtAllCode") 

        sTIn = reqForm("txtTIN")
        sTOut = reqForm("txtTOUT")
        sTotal = reqForm("txtTotal")
        sHalfDay = reqForm("txtHalfDay")

        selLate = reqForm("selLate")
        selEarly = reqForm("selEarly")
        sIrreg = reqForm("txtIrreg")
        
        sOT = reqForm("txtOT")
        sTotalOT = reqForm("txtTotalOT")
        s3ATotalOT = reqForm("txt3ATotalOT")
        
            
        Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMSHFCODE where SHF_CODE='" & sSHF_CODE & "'"  
        rstTMSHFCODE.Open sSQL, conn, 3, 3
        if not rstTMSHFCODE.eof then
            sSTime = rstTMSHFCODE("STIME")
            sETime = rstTMSHFCODE("ETIME")
        end if 
         
        if sUpdate = "Y" Then

            '==================== Insert into LOG ================================================

            fieldNames =Array("SHF_CODE","TIN","TOUT","TOTAL","LATE","EARLY","ALLCODE","OT","TOTALOT","3ATOTALOT","HALFDAY", "IRREG")
           
            for i = 0 to Ubound(fieldNames) 
                
                Set rstTMCLK2 = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMCLK2 where EMP_CODE='" & sID & "'"
                sSQL = sSQL & " and DT_WORK = '" & fdate2(dtWork) & "'"   
                rstTMCLK2.Open sSQL, conn, 3, 3
                if not rstTMCLK2.eof then

                    value = rstTMCLK2("" & fieldNames(i) & "")
                    sOrigValue(i) = value
                end if
            next
            
            variableNames =Array("txtShf_Code","txtTIN","txtTOUT","txtTotal","selLate","selEarly","txtAllCode","txtOT","txtTotalOT","txt3ATotalOT","txtHalfDay", "IRREG")

            for i = 0 to Ubound(variableNames) 
                
                value = reqForm("" & variableNames(i) & "")
                sNewValue(i) = value

            next

            '====== Check is Original Value is different from Field Values insert into LOG ===========
            For i = 0 To UBound(fieldNames)
                if sOrigValue(i) <> sNewValue(i) then
                    sChangesM = sChangesM & fieldNames(i) & " change from " & sOrigValue(i) & " to " & sNewValue(i) & " "  
                    
                end if
            Next            
          
            if sChangesM <> "" then
                sSQLLog = "insert into TMLOG (EMP_CODE,DT_WORK,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		        sSQLLog = sSQLLog & "values ("
                sSQLLog = sSQLLog & "'" & sID & "',"
                sSQLLog = sSQLLog & "'" & fdate2(dtwork) & "',"
                sSQLLog = sSQLLog & "'Time Clock',"
                sSQLLog = sSQLLog & "'Success',"
                sSQLLog = sSQLLog & "'" & sChangesM & "',"
                sSQLLog = sSQLLog & "'" & session("USERNAME") & "'," 
                sSQLLog = sSQLLog & "'" & fdatetime2(Now()) & "'"
		        sSQLLog = sSQLLog & ") "
                conn.execute sSQLLog
            end if
            
            '===== End insert into LOG ==============================================================
            
            sSQL = "UPDATE tmclk2 SET "             
            sSQL = sSQL & "SHF_CODE = '" & UCase(sSHF_CODE) & "',"
            sSQL = sSQL & "STIME = '" & sSTIME & "',"
            sSQL = sSQL & "ETIME = '" & sETIME & "',"
            sSQL = sSQL & "ALLCODE = '" & UCase(sAllCode) & "',"
            sSQL = sSQL & "TIN = '" & sTIn & "',"
            sSQL = sSQL & "TOUT = '" & sTOut & "',"
            sSQL = sSQL & "TOTAL = '" & sTotal & "',"
            sSQL = sSQL & "LATE = '" & selLate & "',"
            sSQL = sSQL & "EARLY = '" & selEarly & "',"
            sSQL = sSQL & "IRREG = '" & sIRREG & "',"
            sSQL = sSQL & "HALFDAY = '" & sHalfDay & "',"
            sSQL = sSQL & "OT = '" & sOT & "',"
            sSQL = sSQL & "TOTALOT = '" & sTotalOT & "',"
            sSQL = sSQL & "ATOTALOT = '" & s3ATotalOT & "',"
            
            if reqForm("chkByPass") = "" then  '==== By Pass not selected will go back to be approved by supervisor

                '=== 1st and 2nd level approval for ABNORMAL
                sSQL = sSQL & "1DTAPV = null,"
                sSQL = sSQL & "1APVBY = '',"
                sSQL = sSQL & "2DTAPV = null,"
                sSQL = sSQL & "2APVBY = '',"
                '===========================================
                '=== 1st, 2nd and 3rd level of approval for OT
                sSQL = sSQL & "1ATOTALOT = '',"
                sSQL = sSQL & "2ATOTALOT = '',"
                sSQL = sSQL & "3ATOTALOT = '',"
                sSQL = sSQL & "1OTDTAPV = null,"
                sSQL = sSQL & "2OTDTAPV = null,"
                sSQL = sSQL & "3OTDTAPV = null,"
                sSQL = sSQL & "1OTAPVBY = '',"
                sSQL = sSQL & "2OTAPVBY = '',"
                sSQL = sSQL & "3OTAPVBY = '',"
                sSQL = sSQL & "OTAPV = '',"
                '=============================================

            elseif reqForm("chkByPass") <> "" then '=== By Pass selected and straight away approve

                '=== 1st and 2nd level approval for ABNORMAL
                sSQL = sSQL & "1DTAPV = '" & fdate2(Date()) & "',"
                sSQL = sSQL & "1APVBY = '" & session("USERNAME") & "',"
                sSQL = sSQL & "2DTAPV = '" & fdate2(Date()) & "',"
                sSQL = sSQL & "2APVBY = '" & session("USERNAME") & "',"
                '===========================================
                '=== 1st, 2nd and 3rd level of approval for OT
                sSQL = sSQL & "1ATOTALOT = '" & s3ATotalOT & "',"
                sSQL = sSQL & "2ATOTALOT = '" & s3ATotalOT & "',"
                sSQL = sSQL & "3ATOTALOT = '" & s3ATotalOT & "',"
                sSQL = sSQL & "1OTDTAPV = '" & fdate2(Date()) & "',"
                sSQL = sSQL & "2OTDTAPV = '" & fdate2(Date()) & "',"
                sSQL = sSQL & "3OTDTAPV = '" & fdate2(Date()) & "',"
                sSQL = sSQL & "1OTAPVBY = '" & session("USERNAME") & "',"
                sSQL = sSQL & "2OTAPVBY = '" & session("USERNAME") & "',"
                sSQL = sSQL & "3OTAPVBY = '" & session("USERNAME") & "',"
                sSQL = sSQL & "OTAPV = 'Y',"
                sSQL = sSQL & "TOTALOT = '" & sTotalOT & "',"
                sSQL = sSQL & "ATOTALOT = '" & s3ATotalOT & "',"
                '=============================================

            end if

            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
            sSQL = sSQL & "DATETIME = '" & fdatetime2(Now())  & "',"
            sSQL = sSQL & "COMMENT = '" & pRTIN(sComment) & "'"
            sSQL = sSQL & " WHERE EMP_CODE = '" & sID & "' AND DT_WORK ='" & fdate2(dtWork) & "'"
            conn.execute sSQL

            sSQL = "delete from TMABSENT where EMP_CODE = '" & sID & "'"
            sSQL = sSQL & " and DT_ABSENT = '" & fdate2(dt_Work) & "'"
            conn.execute sSQL
          
            call fAbsent3(dt_Work, dt_Work, sID, "Y")
  
            sAddURL = "Page=" & iPage & "&txtEMP_CODE=" & sID & "&dtpFrDate=" & fdate2(dtpFrDate) & "&dtpToDate=" & fdate2(dtpToDate) & "&txtdt_Work=" & dtWork
   
            call confirmBox("Update Successful!", sMainURL&sAddURL)

        elseif sUpdate = "" Then
            
            if sSHF_CODE = "" then
                call alertbox("Please select a Shift Code")
            end if

            'if sTIN = "" then
             '   call alertbox("Please enter Time In")
            'end if
            
            'if sTIN = "" then
             '   call alertbox("Please enter Time Out")
            'end if
    
            sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,ALLCODE,OSTIME,OETIME,STIME,ETIME,OTIN,OTOUT,TIN,TOUT,"
            sSQL = sSQL & " TOTAL,LATE,EARLY,IRREG,HALFDAY,OT,"
            sSQL = sSQL & " 1DTAPV,1APVBY,2DTAPV,2APVBY,"
            sSQL = sSQL & " TOTALOT,ATOTALOT,1ATOTALOT,2ATOTALOT,3ATOTALOT,"
            sSQL = sSQL & " 1OTDTAPV,1OTAPVBY,2OTDTAPV,2OTAPVBY,3OTDTAPV,3OTAPVBY,OTAPV,"
            
            sSQL = sSQL & "USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & UCase(sID) & "',"		
		    sSQL = sSQL & "'" & fdate2(dtWork) & "',"
		    sSQL = sSQL & "'" & Ucase(sSHF_CODE) & "',"	'=== Original 	
		    sSQL = sSQL & "'" & Ucase(sSHF_CODE) & "'," '=== Actual
            sSQL = sSQL & " '" & sAllCode & "',"
            sSQL = sSQL & "'" & sSTIME & "',"	'===Original
		    sSQL = sSQL & "'" & sETIME & "',"   '===Original    
            sSQL = sSQL & "'" & sSTIME & "',"	'===Actual
		    sSQL = sSQL & "'" & sETIME & "',"	'===Actual
		    sSQL = sSQL & "'" & sTIn & "',"
		    sSQL = sSQL & "'" & sTOut & "',"
            sSQL = sSQL & "'" & sTIn & "',"
		    sSQL = sSQL & "'" & sTOut & "',"
            sSQL = sSQL & "'" & sTotal & "',"
            sSQL = sSQL & "'" & selLate & "',"
            sSQL = sSQL & "'" & selEarly & "',"
            sSQL = sSQL & "'" & sIrreg & "',"
            sSQL = sSQL & "'" & sHalfDay & "',"
            sSQL = sSQL & "'" & sOT & "',"

		    if reqForm("chkByPass") = "" then

                '=== 1st and 2nd level approval for ABNORMAL
                sSQL = sSQL & "null,"
                sSQL = sSQL & "'',"
                sSQL = sSQL & "null,"
                sSQL = sSQL & "'',"
                '===========================================
                '=== 1st, 2nd and 3rd level of approval for OT
                sSQL = sSQL & "'" & sTotalOT & "',"
                sSQL = sSQL & "'" & s3ATotalOT & "',"
                sSQL = sSQL & "''," '===1st level approval
                sSQL = sSQL & "''," '===2nd level approval
                sSQL = sSQL & "''," '===3rd level approval
                sSQL = sSQL & "null,"
                sSQL = sSQL & "''," 
                sSQL = sSQL & "null,"
                sSQL = sSQL & "''," 
                sSQL = sSQL & "null,"
                sSQL = sSQL & "''," 
                sSQL = sSQL & "'" & sOT & "',"

            elseif reqForm("chkByPass") <> "" then

                '=== 1st and 2nd level approval for ABNORMAL
                sSQL = sSQL & "'" & fdate2(Date()) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "',"
                sSQL = sSQL & "'" & fdate2(Date()) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "',"
                '===========================================
                '=== 1st, 2nd and 3rd level of approval for OT
                sSQL = sSQL & "'" & sTotalOT & "',"
                sSQL = sSQL & "'" & s3ATotalOT & "',"
                sSQL = sSQL & "'" & s3ATotalOT & "',"
                sSQL = sSQL & "'" & s3ATotalOT & "',"
                sSQL = sSQL & "'" & s3ATotalOT & "',"
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'Y',"
                
            end if

            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
		    conn.execute sSQL

            sSQL = "delete from TMABSENT where EMP_CODE = '" & sID & "'"
            sSQL = sSQL & " and DT_ABSENT = '" & fdate2(dt_Work) & "'"
            conn.execute sSQL

             call fAbsent3(dt_Work, dt_Work, sID, "Y")
            
            sAddURL = "Page=" & iPage & "&txtEMP_CODE=" & sID & "&dtpFrDate=" & fdate2(dtpFrDate) & "&dtpToDate=" & fdate2(dtpToDate) & "&txtdt_Work=" & dtWork
   
            call confirmBox("Save Successful!", sMainURL&sAddURL)

         End If 
    End If
          
    Set rstTMCLK2 = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select tmshiftot.DT_SHIFT, tmshiftot.SHF_CODE as ORISHF_CODE, tmshfcode.STIME as ORISTIME, tmshfcode.ETIME as ORIETIME," 
    sSQL = sSQL & " tmclk2.SHF_CODE as SHIFT_CODE, tmclk2.STIME,tmclk2.ETIME, "
    sSQL = sSQL & " tmclk2.* from tmshiftot" 
    sSQL = sSQL & " left join tmshfcode on tmshiftot.shf_code = tmshfcode.shf_code"  
    sSQL = sSQL & " left join tmclk2 on tmshiftot.DT_SHIFT = tmclk2.DT_WORK and tmshiftot.EMP_CODE= tmclk2.EMP_CODE "
    sSQL = sSQL & " where (tmshiftot.EMP_CODE = '" & sEMP_CODE & "') "
    sSQL = sSQL & " and (DT_SHIFT = '" & fdate2(dt_Work) & "')"     
    rstTMCLK2.Open sSQL, conn, 3, 3
    if not rstTMCLK2.eof then

        sSHF_CODE = rstTMCLK2("SHIFT_CODE")
        '=== if tmclk2 is null, we take the original assigned ShiftCode from TMSHIFTOT

        'response.write "***sSHF_CODE : " & sSHF_CODE & "****<br>"

        if sSHF_CODE = "" or isnull(sSHF_CODE) then
            sSHF_CODE = rstTMCLK2("ORISHF_CODE")
            sSTIME = rstTMCLK2("ORISTIME")
            sETIME = rstTMCLK2("ORIETIME")
        else '=== if not we shall take the procesed, finalized, clock in shift
            sSTIME = rstTMCLK2("STIME")
            sETIME = rstTMCLK2("ETIME")
        end if

        sTIN = rstTMCLK2("TIN")
        sTOUT = rstTMCLK2("TOUT")
        sAllCode = rstTMCLK2("ALLCODE")

        sTotal = rstTMCLK2("TOTAL")
        selLate = rstTMCLK2("LATE")
        selEarly = rstTMCLK2("EARLY")
        sIrreg = rstTMCLK2("IRREG")
        sHalfDay = rstTMCLK2("HALFDAY")
        sOT = rstTMCLK2("OT")
        sTotalOT = rstTMClk2("TOTALOT")
        s3ATotalOT = rstTMClk2("3ATOTALOT")
    end if
    pCloseTables(rstTMCLK2)

    '=== Check the employee Grade and whether SHFALL is yes
    Set rstTMGRADE = server.CreateObject("ADODB.RecordSet")
    sSQLTMGRADE = "select tmemply.GRADE_ID, tmGRADE.* from tmemply "
    sSQLTMGRADE = sSQLTMGRADE & " left join tmgrade on TMEMPLY.GRADE_ID = TMGRADE.GRADE_ID " 
    sSQLTMGRADE = sSQLTMGRADE & " where tmemply.EMP_CODE ='" & sID & "'" 
    rstTMGRADE.Open sSQLTMGRADE, conn, 3, 3
    if not rstTMGRADE.eof then
        sGradeID = rstTMGRADE("GRADE_ID")
        sSHFALL = rstTMGRADE("SHFALL")
        sAllowOT = rstTMGRADE("OT")
    end if
    
    Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMPATH" 
    rstTMPATH.Open sSQL, conn, 3, 3
    if not rstTMPATH.eof then
        sLateGR = rstTMPATH("LATEGR")
        sEarlyGR = rstTMPATH("EARLYGR")
        sMINOT = rstTMPATH("MINOT")
        sMINM4OT = rstTMPATH("MINM4OT")
        sHalfDayGr =rstTMPATH("HALFDAYGR")
    end if
    pCloseTables(rstTMPATH)
    
    Set rstHOL_ID = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select HOL_ID from TMWORKGRP where EMP_CODE = '" & sID & "'"
    rstHOL_ID.Open sSQL, conn, 3, 3
    if not rstHOL_ID.eof then
                        
        Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMHOL1 where HOL_ID = '" & rstHOL_ID("HOL_ID") & "'"
        sSQL = sSQL & " and DT_HOL = '" & fdate2(dtWork) & "'" 
        rstDT_HOL.Open sSQL, conn, 3, 3
        if not rstDT_HOL.eof then '==== Check if that day is a Holiday, if yes, OT
            sHoliday = "Y"
        else
            sHoliday = "N"
        end if
    end if

    %>

</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_tm.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Time Clock Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" id="form1" action="tmtimeclk_det.asp" method="post">
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <input type="hidden" name="txtEMP_CODE" value='<%=sEMP_CODE%>' />
                            <input type="hidden" name="dtpFrDate" value='<%=dtpFrDate%>' />
                            <input type="hidden" name="dtpToDate" value='<%=dtpToDate%>' />
                            <input type="hidden" id="txtDt_Work" name="txtDt_Work" value='<%=dt_Work%>' />
                            <input type="hidden" id="txtGrade_ID" name="txtGrade_ID" value='<%=sGradeID%>' />
                            <input type="hidden" id="txtShfAll" name="txtShfAll" value='<%=sShfAll%>' />
                            <input type="hidden" id="txtAllowOT" name="txtAllowOT" value='<%=sAllowOT%>' />
                            <input type="hidden" id="txtLateGr" name="txtLateGr" value='<%=sLateGR%>' />
                            <input type="hidden" id="txtEarlyGr" name="txtEarlyGr" value='<%=sEarlyGR%>' />
                            <input type="hidden" id="txtMinOT" name="txtMinOT" value='<%=sMinOT%>' />
                            <input type="hidden" id="txtMinM4OT" name="txtMinM4OT" value='<%=sMinM4OT%>' />
                            <input type="hidden" id="txtHoliday" name="txtHoliday" value='<%=sHoliday%>' />
                            <input type="hidden" id="txtHalfDayGr" name="txtHalfDayGr" value='<%=sHalfDayGr%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <%if bFrInCom <> "" then%>
                                        <input type="button" class="btn btn-new" name="btnReturn" value="Back" 
                                            onclick="window.location = ('tmabnorm.asp?<%=sAddURL%>');" />
                                    <%else%>
                                        <input type="button" class="btn btn-new" name="btnReturn" value="Back" 
                                            onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                    <%end if%>
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <%if sEMP_CODE <> "" then %>
                                                    <span class="mod-form-control"><% response.write sEMP_CODE %></span>
                                                <%else%>
                                                    <input class="form-control" id="txtID" name="txtID" maxlength="10" 
                                                        style="text-transform: uppercase">
                                                    <span class="input-group-btn">
                                                        <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default"
                                                            onclick ="fOpen('EMP','mycontent','#mymodal')">
                                                            <i class="fa fa-search"></i>
                                                        </a>
                                                    </span>
                                                <%end if%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Working Date : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                <%if dt_Work <> "" then %>
                                                    <span class="mod-form-control"><% response.write fdatelong(dt_Work) %></span>
                                                <%else%>
                                                    <input id="dt_Work" name="dt_Work" value="<%=dt_Work%>" type="text" 
                                                        class="form-control" date-picker>
                                                    <span class="input-group-btn">
                                                        <a href="javascript:void(0);" id="btnDtpWork" class="btn btn-default">
                                                            <i class="fa fa-calendar"></i>
                                                        </a>
                                                    </span>
                                                <%end if%>
                                             </div>
                                        </div>
                                    </div>
                                    <div class="form-group input_field">
                                        <label class="col-sm-3 control-label">Shift Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtSHF_CODE" name="txtSHF_CODE" value="<%=sSHF_CODE%>" 
                                                    maxlength="6" style="text-transform: uppercase" onchange="compute();">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('SHFCODE','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <input id="txtSTIME" name="txtSTIME" value='<%=sSTIME%>' type="hidden">
                                            <input id="txtETIME" name="txtETIME" value='<%=sETIME%>' type="hidden">
                                        </div>
                                    </div>
                                    <div class="form-group" id="showAllow" style="display: none" >
                                        <label class="col-sm-3 control-label">Shift Allowance : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtAllCode" name="txtAllCode" value="<%=sAllCode%>" 
                                                    maxlength="6" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('ALLCODE','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group input_field">
                                        <label class="col-sm-3 control-label">Time In : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                 <input id="txtTIN" name="txtTIN" value='<%=sTIN%>' type="text" 
                                                     class="form-control enterInput" time-maskprocess >
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    <div class="form-group input_field">
                                        <label class="col-sm-3 control-label">Time Out : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                 <input id="txtTOUT" name="txtTOUT" value='<%=sTOUT%>' type="text" 
                                                     class="form-control enterInput" time-maskprocess >
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    <div class="form-group input_field">
                                        <label class="col-sm-3 control-label">Total Work : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                 <input id="txtTotal" name="txtTotal" value='<%=sTotal%>' type="text" 
                                                     class="form-control enterInput"  time-mask >
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group" style="display: none" >
                                        <label class="col-sm-3 control-label">Late : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <select id="selLate" name="selLate" class="form-control">
                                                <option value="" selected="selected">Please select</option>
                                                <option value="Y" <%if selLate = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if selLate = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group" style="display: none">
                                        <label class="col-sm-3 control-label">Early Dismiss : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <select id="selEarly" name="selEarly" class="form-control">
                                                <option value="" selected="selected">Please select</option>
                                                <option value="Y" <%if selEarly = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if selEarly = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group" style="display: none" >
                                        <label class="col-sm-3 control-label">Irregular : </label>
                                        <div class="col-sm-1 col-lg-1">
                                           <input class="form-control" id="txtIRREG" name="txtIRREG" value="<%=sIRREG%>" readonly/>
                                        </div>
                                    </div>
                                    <div class="form-group" style="display: none"  >
                                        <label class="col-sm-3 control-label">Half Day : </label>
                                        <div class="col-sm-1 col-lg-1">
                                            <input class="form-control" id="txtHalfDay" name="txtHalfDay" value="<%=sHalfDay%>" readonly />
                                        </div>
                                    </div>
                                    
                                    <div class="form-group" style="display: none" >
                                        <label class="col-sm-3 control-label">OT : </label>
                                        <div class="col-sm-1 col-lg-1">
                                           <input class="form-control" id="txtOT" name="txtOT" value="<%=sOT%>" readonly/>
                                        </div>
                                    </div>
                                    
                                    <div id="otStuff">
                                        <%if sAllowOT = "Y" then %>
                                        <div class="form-group input_field">
                                            <label class="col-sm-3 control-label">Total OT : </label>
                                            <div class="col-sm-5 col-lg-3">
                                                <div class="input-group">
                                                     <input id="txtTotalOT" name="txtTotalOT" value='<%=sTotalOT%>' type="text" 
                                                         class="form-control enterInput" time-maskprocess>
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-clock-o"></i>
                                                        </div>
                                                 </div>
                                            </div>
                                        </div>
                                        <div class="form-group input_field">
                                            <label class="col-sm-3 control-label">Final Approved Total OT : </label>
                                            <div class="col-sm-5 col-lg-3">
                                                <div class="input-group">
                                                     <input id="txt3ATotalOT" name="txt3ATotalOT" value='<%=s3ATotalOT%>' type="text" 
                                                         class="form-control enterInput" onblur="chk00or30('txt3ATotalOT');" time-mask>
                                                        <div class="input-group-addon">
                                                            <i class="fa fa-clock-o"></i>
                                                        </div>
                                                 </div>
                                            </div>
                                        </div>
                                        <%end if %>
                                        <div class="form-group input_field">
                                            <label class="col-sm-3 control-label">Bypass Approval Cycle : </label>
                                            <div class="col-sm-3 ">
                                                <%if s3ATotalOT <> "" then %>
                                                    <input type="checkbox" id="chkByPass" name="chkByPass" style="margin-top:12px" checked/>
                                                <%else %>
                                                    <input type="checkbox" id="chkByPass" name="chkByPass" style="margin-top:12px" />
                                                <%end if %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sUpdate = "Y" then %>
                                        <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                        <a href='#' class="btn btn-danger pull-left" style="width: 90px" data-toggle="modal" data-target="#modal-deltimeclk" 
                                            data-emp_code="<%=sEMP_CODE%>"  data-dtwork="<%=dt_Work%>" 
                                            data-dtfrom="<%=fdatelong(dtpFrDate)%>" data-dtto="<%=fdatelong(dtpToDate)%>"
                                             data-bfrincom="<%=bFrInCom%>">Delete</a>
                                    <%else %>
                                        <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
                                    <%end if %>
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal fade bd-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                            </div>
                            <div id="mycontent">
                                <!--- Content ---->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="modal-deltimeclk" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="exampleModalLabel2"></h4>
                            </div>
                            <div class="modal-body">
                                <div id="del-content">
                                    <!--- Content ---->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->

    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- TimeMask -->
    <script src="plugins/input-mask/jquery.mask.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

    <script>

    $(document).ready(function(){ //====== When Page finish loading
        
        var sShfAll = document.getElementById('txtShfAll').value;
        var sHoliday = document.getElementById('txtHoliday').value;

        if (sShfAll == "Y" || sHoliday == "Y") {
            $("#showAllow").show();
        }
    });

    //=== This is for time mask and run compute function on blur
    $('[time-maskprocess]').mask('00:00', TimeOpts).on('blur', function () {
        var $this = $(this),
            v = $this.val();
        v = v.length == 0 ? '00:00' :
            (v.length == 1 ? '0' + v + ':00' :
                (v.length == 2 ? v + ':00' :
                    (v.length == 3 ? v + '00' :
                        (v.length == 4 ? v + '0' : v))));
        $this.val(v);

        compute();
    });

    //=== This is diasble enter key to POST back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    //===Hit Enter and it will go to the next input field 
    $('#form1').on('keyup', '.input_field', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        var next_input_index = $('.input_field').index(this) + 1;
        $('.input_field').eq(next_input_index).find('.enterInput').focus();
      }
    });

    //=== To calculate, Total Work, Total OT, Approve OT, Late, Early Dismiss, OT yes/no
    //=== With Given ShfCode

    //Convert a time in hh:mm format to minutes
    function timeToMins(time) {
        var b = time.split(':');
        return b[0] * 60 + +b[1];
    }

    //Convert minutes to a time in format hh:mm
    //Returned value is in range 00  to 24 hrs
    function timeFromMins(mins) {
        function z(n) { return (n < 10 ? '0' : '') + n; }
        var h = (mins / 60 | 0) % 24;
        var m = mins % 60;
        return z(h) + ':' + z(m);
    }

    function timeFromMins30(mins) {
        function z(n) { 
            return (n < 10 ? '0' : '') + n; 
            }
        var h = (mins / 60 | 0) % 24;
        var m = 30;
        return z(h) + ':' + z(m);
    }

    function timeFromMins0(mins) {
        function z(n) { return (n < 10 ? '0' : '') + n; }
        var h = (mins / 60 | 0) % 24;
        var m = 00;
        return z(h) + ':' + z(m);
    }

    //Add two times in hh:mm format
    function addTimes(t0, t1) {
        return timeFromMins(timeToMins(t0) + timeToMins(t1));
    }

    function calATotalOT(pTotalWork) {
        
        if(pTotalWork > 0){
            document.getElementById('txtOT').value = "Y";
        }else{
            document.getElementById('txtOT').value = "N";
        }

        var ATotalOT = pTotalWork;
        
        document.getElementById('txtTotalOT').value = timeFromMins(ATotalOT);
        document.getElementById('txt3ATotalOT').value = timeFromMins30(ATotalOT);

        var i3ATotalOT = ATotalOT / 60; // Divide by 60 will get like 20.578
        var f3ATotalOT = parseInt(i3ATotalOT); // parseInt 20.578 will get 20. 

        if ((i3ATotalOT - f3ATotalOT) > 0.5) {  // minus the 20 will get 0.578

            document.getElementById('txt3ATotalOT').value = timeFromMins30(ATotalOT);

        } else {

            document.getElementById('txt3ATotalOT').value = timeFromMins0(ATotalOT);

        }

    }

    function chk00or30(inputID) {
        
        var text = $("#"+inputID);
        var  v = text.val();
        
        v = v.length == 0 ? '00:00' :
            (v.length == 1 ? '0' + v + ':00' :
                (v.length == 2 ? v + ':00' :
                    (v.length == 3 ? v + '00' :
                        (v.length == 4 ? v + '0' : v))));
        
        var apvTimeMin = timeToMins(v) ;

        var fapvTimeMin = apvTimeMin / 60; // Divide by 60 will get like 20.578
        var iapvTimeMin = parseInt(fapvTimeMin); // parseInt 20.578 will get 20. 

        if ((fapvTimeMin - iapvTimeMin) > 0.5) {  // minus the 20 will get 0.578
            
            document.getElementById(inputID).value = timeFromMins30(apvTimeMin);

        } else {
            
            document.getElementById(inputID).value = timeFromMins0(apvTimeMin);

        }

    }

    function calTotal(pTotal) {
        
        if ( timeFromMins(pTotal).length == 5 ) {
        
            document.getElementById('txtTotal').value = timeFromMins(pTotal);
        }
    }


    function noOT() {
        document.getElementById('txtOT').value = "N";
        document.getElementById('txtTotalOT').value = "00:00";
        document.getElementById('txt3ATotalOT').value = "";
    }

    function compute() {

        var sShfCode = document.getElementById('txtSHF_CODE').value;
        var sSTIME = timeToMins(document.getElementById('txtSTIME').value);
        var sETIME = timeToMins(document.getElementById('txtETIME').value);
        var sTIN = timeToMins(document.getElementById('txtTIN').value);
        var sTOUT = timeToMins(document.getElementById('txtTOUT').value);
        var sGradeID = document.getElementById('txtGrade_ID').value;
        var sShfAll = document.getElementById('txtShfAll').value;
        var sAllowOT = document.getElementById('txtAllowOT').value;
        var sEarlyGR = timeToMins(document.getElementById('txtEarlyGr').value);
        var sLateGR = timeToMins(document.getElementById('txtLateGr').value);
        var sMinOT = timeToMins(document.getElementById('txtMinOT').value);
        var sMinM4OT = timeToMins(document.getElementById('txtMinM4OT').value);
        var sHoliday = document.getElementById('txtHoliday').value;
        var sHalfDayGr = timeToMins(document.getElementById('txtHalfDayGr').value);

        if (sGradeID == "M4") {
            var sMinOTStart = sMinM4OT;
        } else {
            var sMinOTStart = sMinOT;
        }
        
        if (sShfCode == "REST" || sShfCode == "OFF" || sHoliday == "Y") {
        
            document.getElementById('selLate').value = "N";
            document.getElementById('selEarly').value = "N";
            document.getElementById('txtHalfDay').value = "N";

            if (sTOUT >= sTIN) { 

                var iTotal = sTOUT - sTIN;  //=== this is in mins

                document.getElementById('txtTotal').value = timeFromMins(iTotal);
                
                if (iTotal >= sMinOTStart && sAllowOT == "Y") {

                        calATotalOT(iTotal);
                    
                } else {  //=== if it is not OT then set value to ''

                    noOT();
                }


            } else if (sTIN >= sTOUT) {  //=== TIN is >= TOUT but still OFF and REST DAY 

                var iTotal = ((sTOUT + 1440) - sTIN);   //=== this is in mins
                document.getElementById('txtTotal').value = timeFromMins(iTotal);

                if (iTotal >= sMinOTStart && sAllowOT == "Y") {

                    calATotalOT(iTotal);

                }else {  //=== if it is not OT then set value to ''
                    
                    noOT();
                }

            }

        } else {  //=== Normal Shift, Not REST or OFF or HolidayDay *****************************************************************************

            
            if (sShfCode == "DW08" && sShfAll =="Y" ){

                document.getElementById('txtAllCode').value = "DW08";
            
            }

            if (sSTIME > sETIME){

                //==== For Night Shift calculation tweak
                sETIME = sETIME + 1440;
                sTOUT = sTOUT + 1440
                var iHalfOfShiftMins = (sETIME - sSTIME)/2;
            
                //=== Punch in 00:00am onwards must add 24hours mins
                if(sTIN <=720){ 
                    sTIN = sTIN + 1440
                }

                //==== If TOUT is more than sSTIME, must reduce back to normal hours.
                //=== Prevent work beyond 24hours
                if (sTOUT >= (sSTIME + 1440)) { 
                    sTOUT = sTOUT - 1440
                }

                if ((sTIN <= (sSTIME + iHalfOfShiftMins )) && (sTIN >= (sSTIME - iHalfOfShiftMins )) && !isNaN(sTOUT)){
                    if (sAllowOT =="Y"){
                        var sIrreg = calTotalOT(sSTIME,sETIME,sTIN,sTOUT,iHalfOfShiftMins,sMinOTStart);
                    }
                    document.getElementById('txtIRREG').value = "N";
                }else{
                    var sIrreg = "Y"
                    document.getElementById('txtIRREG').value = "Y";
                }
    
            } else if (sSTIME < sETIME) {

                var iHalfOfShiftMins = (sETIME - sSTIME)/2;
                
                //=== Punch out from 00:00am till 07:00am, ADD 24Hours for calculation
                if ( (sTOUT < sSTIME) && (sTOUT <=720) ){ 
                    sTOUT = sTOUT + 1440
                }
        
                if ((sTIN <= (sSTIME + iHalfOfShiftMins )) && (sTIN >= (sSTIME - iHalfOfShiftMins )) && !isNaN(sTOUT)){
                    
                    if (sAllowOT =="Y"){
                        var sIrreg = calTotalOT(sSTIME,sETIME,sTIN,sTOUT,iHalfOfShiftMins,sMinOTStart);
                    }                    
                    document.getElementById('txtIRREG').value = "N";
                }else{
                    if (sAllowOT =="Y"){
                        calTotalOT(sSTIME,sETIME,sTIN,sTOUT,iHalfOfShiftMins,sMinOTStart);
                    }
                    var sIrreg = "Y"
                    document.getElementById('txtIRREG').value = "Y";
                }
                
            } //=== sSTIME > sETIME
        } // === End REST,OFF and Normal shift

    } //=== End Function compute    

    function calTotalOT(sSTIME, sETIME, sTIN, sTOUT,iHalfOfShiftMins,sMinOTStart){

        var sEarlyGR = timeToMins(document.getElementById('txtEarlyGr').value);
        var sLateGR = timeToMins(document.getElementById('txtLateGr').value);
        var sHalfDayGr = timeToMins(document.getElementById('txtHalfDayGr').value);

        //=== Early In
        if (sTIN < sSTIME){
                                                
            //====Early In More then MinOT
            if ((sSTIME - sTIN) >= sMinOTStart){
                                                    
                //=== Late Out or Normal
                if ( (sTOUT > sETIME) && ((sTOUT - sETIME) >= sMinOTStart) ){ 
        
                    //=== "EarlyInOT and LateOutOT"
                    document.getElementById('selLate').value = "N";
                    document.getElementById('selEarly').value = "N";

                    iOTIn = sSTIME-sTIN;
                    iOTOut = sTOUT - sETIME;
                                
                    iTotal = sTOUT - sTIN;
                    iTotalOT = iOTIn + iOTOut;
                                
                    calTotal(iTotal);
                    calATotalOT(iTotalOT);
                                              
                } else{
                            
                    //=== "EarlyInOT and NormalOut"
                    document.getElementById('selLate').value = "N";

                    iOTIn = sSTIME - sTIN;

                    iTotal = sTOUT - sTIN;
                    iTotalOT = iOTIn;

                    calTotal(iTotal);
                    calATotalOT(iTotalOT);
                }

            }else { //=== Not more than MinOT In
                    //=== Late Out or Normal
                if ( (sTOUT > sETIME) && ((sTOUT - sETIME) >= sMinOTStart) ){ 
                                
                    document.getElementById('selEarly').value = "N";
                    iOTOut = sTOUT - sETIME;
                    iTotal = sTOUT - sTIN;
                    iTotalOT = iOTOut;
                            
                    calTotal(iTotal);
                    calATotalOT(iTotalOT);
                } else {
                                
                    if ((sETIME - sTOUT) > sEarlyGR ) {
                        document.getElementById('selEarly').value = "Y";
                    } else {
                        document.getElementById('selEarly').value = "N";
                    }

                    iTotal = sTOUT - sTIN;
                    iTotalOT = 0;
                    calTotal(iTotal);
                    calATotalOT(iTotalOT);
                }
            }

        }else {  //=== Punch in after STIME (sTIN >sSTIME)

            if ( (sTIN - sSTIME) > sLateGR ){
                //==== "late"
                document.getElementById('selLate').value = "Y";
            }else{
                document.getElementById('selLate').value = "N";
            }

            //==== Late out or Normal
                if ( (sTOUT > sETIME) && ((sTOUT - sETIME) >= sMinOTStart) ){ 
        
                    //=== " Normal IN and LateOutOT "
                    document.getElementById('selEarly').value = "N";
                    iOTOut = sTOUT - sETIME;
                                
                    iTotal = sTOUT - sTIN;
                    iTotalOT = iOTOut;
                    calTotal(iTotal);
                    calATotalOT(iTotalOT);
                }else{
                    //=== " Normal IN and Normal Out"
                         
                    if ((sETIME - sTOUT) > sEarlyGR ) {
                        document.getElementById('selEarly').value = "Y";
                    } else {
                        document.getElementById('selEarly').value = "N";
                    }
        
                    iTotal = sTOUT - sTIN;
                    iTotalOT = 0;
                    calTotal(iTotal);
                    calATotalOT(iTotalOT);
                }
        } //=== sTIN < sSTIME then
                        
        //==== For Half Day 
        if (iTotal != "" ) {
            if (iTotal <= (iHalfOfShiftMins + sHalfDayGr)) {
                document.getElementById('txtHalfDay').value = "Y";
                    calTotal(iTotal);
            }else{
                document.getElementById('txtHalfDay').value = "N";
            }
        }
        
    }

    function fOpen(pType,pContent,pModal) {
        
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function showDetails(str,pType,pContent) {

        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

        if (pType=="SHFCODE") { 

            var search = document.getElementById("txtSearch_shfcode");
            
        }else if (pType=="ALLCODE") { 

            var search = document.getElementById("txtSearch_allcode");

	  	}
                
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="SHFCODE") {
	  	    xhttp.open("GET", "ajax/ax_view_tmshfcode.asp?"+str, true);
	  	}else if (pType=="ALLCODE") {
	  	    xhttp.open("GET", "ajax/ax_view_tmallow.asp?"+str, true);
	  	}

  	    xhttp.send();

    }
    
   function getValue3(svalue1, svalue2, svalue3,pFldName1,pFldName2,pFldName3) {
        document.getElementById(pFldName1).value = svalue1;
        document.getElementById(pFldName2).value = svalue2;
        document.getElementById(pFldName3).value = svalue3;
        $('#mymodal').modal('hide');
        compute();
    }
    
    function getValue1(svalue1,pFldName1) {
        document.getElementById(pFldName1).value = svalue1;
        $('#mymodal').modal('hide');
    }

    $('#modal-deltimeclk').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var timeclkinfo = button.data('emp_code')
        timeclkinfo = timeclkinfo + "-" + button.data('dtwork')
        timeclkinfo = timeclkinfo + "-" + button.data('dtfrom')
        timeclkinfo = timeclkinfo + "-" + button.data('dtto')
        timeclkinfo = timeclkinfo + "-" + button.data('bfrincom')
        var modal = $(this)
        modal.find('.modal-body input').val(timeclkinfo)
        showDelmodal(timeclkinfo)
    })

    function showDelmodal(str){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("del-content").innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "tmtimeclk_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

	$( "#txtSHF_CODE" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=TC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtSHF_CODE").val(ui.item.value);
                $("#txtSTIME").val(ui.item.data);
				var str = document.getElementById("txtSHF_CODE").value;
				var res = str.split(" | ");
                var str2 = document.getElementById("txtSTIME").value;
                var res2 = str2.split(" | ");
				document.getElementById("txtSHF_CODE").value = res[0];
                document.getElementById("txtSTIME").value = res2[0];
                document.getElementById("txtETIME").value = res2[1];

                compute();
                
			},0);
		}
	});

    $( "#txtAllCode" ).autocomplete({
	    delay:0,
	    maxShowItems: 6,
	    source: "intelli.asp?Type=ALLOW",
	    select: function (event, ui) {
		    setTimeout(function() {
			    $("#txtAllCode").val(ui.item.value);
                var str = document.getElementById("txtAllCode").value;
			    var res = str.split(" | ");
                document.getElementById("txtAllCode").value = res[0];
                
                compute();
                
		    },0);
	    }
    });
    </script>
</body>
</html>
