<!DOCTYPE html>
<html>
<head>
    <!--#include file="include/clsUpload.asp"-->
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Month End Process</title>
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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" />
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    <link href="plugins/Custom/css/component.css" rel="stylesheet" />
    <style>
    #loader-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1000;
    /*background-color:#EBEBEB;
    filter:alpha(opacity=70);
    opacity:0.7;*/
    }
        #loader {
            display: block;
            position: relative;
            left: 50%;
            top: 50%;
            width: 150px;
            height: 150px;
            margin: -75px 0 0 -75px;
     border: 3px solid transparent;
        border-top-color: #3498db;
            z-index: 1500;
            border-radius: 50%;
  
            -webkit-animation: spin 2s linear infinite;
        animation: spin 2s linear infinite;
    
        }
        #loader:before {
        content: "";
        position: absolute;
        top: 5px;
        left: 5px;
        right: 5px;
        bottom: 5px;
        border: 3px solid transparent;
        border-top-color: #e74c3c;
        border-radius: 50%;
        -webkit-animation: spin 3s linear infinite;
        animation: spin 3s linear infinite;

    }
    #loader:after {
        content: "";
        position: absolute;
        top: 15px;
        left: 15px;
        right: 15px;
        bottom: 15px;
        border: 3px solid transparent;
        border-top-color: #f9c922;
         border-radius: 50%;
     
    -webkit-animation: spin 1.5s linear infinite;
    animation: spin 1.5s linear infinite;
    }

 
    /* include this only once */
    @-webkit-keyframes spin {
        0%   {
            -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(0deg);  /* IE 9 */
            transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
        }
        100% {
            -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(360deg);  /* IE 9 */
            transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
        }
    }
    @keyframes spin {
        0%   {
            -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(0deg);  /* IE 9 */
            transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
        }
        100% {
            -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(360deg);  /* IE 9 */
            transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
        }
    }
    </style>
    <%
        Server.ScriptTimeout = 1000000

        Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMPATH"
        rstTMPATH.Open sSQL, conn, 3, 3
        if not rstTMPATH.eof then
            sPayFrom = rstTMPATH("PAYFROM")
            sPayTo = rstTMPATH("PAYTO")
        end if

        if request("btnProcess") <> "" then

            dtpDtFr = reqForm("dtpDtFr")
            dtpDtTo = reqForm("dtpDtTo")
             
            '===============================
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
            '================================

            '==== DateTime ==================
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
            
            sFileName = "01Time_" & sDtTime & ".txt"
            sFilePath = server.mappath("MTHEND\" & sFileName)

            set rstTMMTHEND= server.createobject("adodb.recordset")
            sSQL = "select tmemply.EMP_CODE, tmemply.NAME, SUP_CODE, tmemply.GRADE_ID, tmworkgrp.HOL_ID, tmclk2.*, tmgrade.MTHEND from tmemply" 
            sSQL = sSQL & " left join tmworkgrp on tmemply.EMP_CODE = tmworkgrp.EMP_CODE "
            sSQL = sSQL & " left join tmclk2 on tmemply.EMP_CODE = tmclk2.EMP_CODE "
            sSQL = sSQL & " left join tmgrade on tmemply.GRADE_ID = tmgrade.GRADE_ID "
            sSQL = sSQL & " where (   (DT_WORK between '" & fdate2(dtpDtFr) & "' and '" & fdate2(dtpDtTo) & "') "
            sSQL = sSQL & " and (TIN<>'' and TOUT <>'')  )"
            sSQL = sSQL & " and tmgrade.MTHEND = 'Y'" 
            sSQL = sSQL & " order by tmclk2.EMP_CODE, DT_WORK desc"
            rstTMMTHEND.Open sSQL, conn, 3, 3
            if not rstTMMTHEND.eof then

                Do while not rstTMMTHEND.eof
                    
                    sSAPCODE = ""
                    sTotalHour = ""
                    
                    sSQL = "select * from TMALLOW where ALLCODE = '" & rstTMMTHEND("ALLCODE") & "'"
                    set rstTMALLOW = server.CreateObject("ADODB.Recordset")
		            rstTMALLOW.open sSQL, conn, 3, 3
                    if not rstTMALLOW.eof then
                        if Cint(TimetoMin(rstTMMTHEND("TOTAL"))) >= Cint(TimetoMin(rstTMALLOW("MINWORK"))) then  '==== Only get the allowances if it is more than min working hours for the Allowances, usually half day.
                            
                            sSAPCODE = rstTMALLOW("SAPALLCODE")
                            sTotalHour = "1.00"  '====== 1 Unit if ALLCODE matches the ALLOWANCE table
      
                            sSQL = "INSERT into TMMTHEND (DTFR,DTTO,EMP_CODE,NAME,SUP_CODE,DT_WORK,WHATCODE,SAPCODE, TOTALHOUR,FILEDIR, CREATE_ID, DT_CREATE,USER_ID,DATETIME)"
                            sSQL = sSQL & " values ("
                            sSQL = sSQL & "'" & fdate2(dtpDtFr) & "',"
                            sSQL = sSQL & "'" & fdate2(dtpDtTo) & "',"
                            sSQL = sSQL & "'" & rstTMMTHEND("EMP_CODE") & "',"
                            sSQL = sSQL & "'" & rstTMMTHEND("NAME") & "',"
                            sSQL = sSQL & "'" & rstTMMTHEND("SUP_CODE") & "',"
                            sSQL = sSQL & "'" & fdate2(rstTMMTHEND("DT_WORK")) & "',"
                            sSQL = sSQL & "'2002',"  '===== Attendances for SAP Code Hard coded
                            sSQL = sSQL & "'" & sSAPCODE & "',"
                            sSQL = sSQL & "'" & sTotalHour & "',"
                            sSQL = sSQL & "'" & sFileName & "',"
                            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                            sSQL = sSQL & "'" & fdatetime2(Now()) & "')" 
                            conn.execute sSQL
                        end if
                    end if 

                    if rstTMMTHEND("OTAPV") <> "" then
                        
                        sSQL = "select * from TMOTCODE where GRADE_ID = '" & rstTMMTHEND("GRADE_ID") & "'"
		                set rstTMOTCODE = server.CreateObject("ADODB.Recordset")
                        rstTMOTCODE.open sSQL, conn, 3, 3
                        if not rstTMOTCODE.eof then  '=== M0,M1,M2, M4 are OT considerable. There are either OT1 or OT2
                            Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
                            sSQL = "select * from TMHOL1 where HOL_ID = '" & rstTMMTHEND("HOL_ID") & "'"
                            sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMMTHEND("DT_WORK")) & "'" 
                            rstDT_HOL.Open sSQL, conn, 3, 3
                            if not rstDT_HOL.eof then '==== It is a holiday
                                if rstDT_HOL("REPLA") ="N" then '=== Not it is not a replacement, 3.0
                                    sSAPCODE = rstTMOTCODE("PUBLICCODE")
                                    sTotalHour =  rstTMMTHEND("ATOTALOT")
                                else '=== Replacement, normal 1.5
                                    sSAPCODE = rstTMOTCODE("NORMALCODE")
                                    sTotalHour =  rstTMMTHEND("ATOTALOT")
                                end if

                            else '==== Not a holiday
                                if rstTMMTHEND("SHF_CODE") ="OFF" then '=== Off is 2.0
                            
                                    sSAPCODE = rstTMOTCODE("OFFCODE")
                                    sTotalHour =  rstTMMTHEND("ATOTALOT")   
         
                                elseif rstTMMTHEND("SHF_CODE") = "REST" then '=== Rest is 3.0
                                
                                    sSAPCODE = rstTMOTCODE("RESTCODE")
                                    sTotalHour =  rstTMMTHEND("ATOTALOT")
                                else
                                    sSAPCODE = rstTMOTCODE("NORMALCODE") '==== Normal OT is 1.5
                                    sTotalHour =  rstTMMTHEND("ATOTALOT")
                                end if
                            end if 
                        end if
                        
                        sTotalHour = TimetoDec(sTotalHour)

                        sSQL = "INSERT into TMMTHEND (DTFR,DTTO,EMP_CODE,NAME,SUP_CODE,DT_WORK,WHATCODE,SAPCODE, TOTALHOUR, FILEDIR, CREATE_ID, DT_CREATE,USER_ID,DATETIME)"
                        sSQL = sSQL & " values ("
                        sSQL = sSQL & "'" & fdate2(dtpDtFr) & "',"
                        sSQL = sSQL & "'" & fdate2(dtpDtTo) & "',"
                        sSQL = sSQL & "'" & rstTMMTHEND("EMP_CODE") & "',"
                        sSQL = sSQL & "'" & rstTMMTHEND("NAME") & "',"
                        sSQL = sSQL & "'" & rstTMMTHEND("SUP_CODE") & "',"
                        sSQL = sSQL & "'" & fdate2(rstTMMTHEND("DT_WORK")) & "',"
                        sSQL = sSQL & "'2002',"
                        sSQL = sSQL & "'" & sSAPCode & "',"
                        sSQL = sSQL & "'" & sTotalHour & "',"
                        sSQL = sSQL & "'" & sFileName & "',"
                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                        sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                        conn.execute sSQL

                    end if 
                   
                rstTMMTHEND.movenext
                loop

            end if '==== end  if not rstTMMTHEND.eof
            
            '=== Absences
            '===== Insert Absences but must check if Employee work half day on that day then Total Hour is Half only 
            '===== SAP Code 2001 is Absences and 9000 is without any reason. 
            Set rstTMABSENT = server.CreateObject("ADODB.RecordSet")    
	        sSQL = "select tmabsent.*, tmemply.SUP_CODE, tmemply.EMP_CODE, tmemply.NAME, "
            sSQL = sSQL & " tmgrade.MTHEND from tmabsent "
            sSQL = sSQL & " left join tmemply on tmemply.EMP_CODE = tmabsent.EMP_CODE "
            sSQL = sSQL & " left join tmgrade on tmemply.GRADE_ID = tmgrade.GRADE_ID "
            sSQL = sSQL & " where DT_ABSENT BETWEEN '" & fDate2(dtpDtFr) & "' AND '" & fDate2(dtpDtTo) & "' "
            sSQL = sSQL & " and tmgrade.MTHEND = 'Y' "
            rstTMABSENT.Open sSQL, conn, 3, 3
	        if not rstTMABSENT.eof then
                
                Do while not rstTMABSENT.eof

                    if  rstTMABSENT("TYPE") ="H"  then
                        
                        sSQL = "select * from tmshfcode "
                        sSQL = sSQL & " where SHF_CODE ='" & rstTMABSENT("SHF_CODE") & "'"
                        set rstTMSHFCODE= server.createobject("adodb.recordset")
                        rstTMSHFCODE.Open sSQL, conn, 3, 3
                        if not rstTMSHFCODE.eof then
                            sTotalHour = Cint(TimetoMin(rstTMSHFCODE("SHFLEN")))/2
                            sTotalHour = MintoTime(sTotalHour)
                            sTotalHour = TimetoDec(sTotalHour)
                        end if
        
                        sSQL = "INSERT into TMMTHEND (DTFR,DTTO,EMP_CODE,NAME,SUP_CODE,DT_WORK,WHATCODE,SAPCODE, TOTALHOUR,FILEDIR, CREATE_ID, DT_CREATE,USER_ID,DATETIME)"
                        sSQL = sSQL & " values ("
                        sSQL = sSQL & "'" & fdate2(dtpDtFr) & "',"
                        sSQL = sSQL & "'" & fdate2(dtpDtTo) & "',"
                        sSQL = sSQL & "'" & rstTMABSENT("EMP_CODE") & "',"
                        sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                        sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                        sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_ABSENT")) & "',"
                        sSQL = sSQL & "'2001'," '=== SAP Code Hard coded for Absent
                        sSQL = sSQL & "'9000'," '=== Hard coded SAP Absence without leave 9000
                        sSQL = sSQL & "'" & sTotalHour & "',"
                        sSQL = sSQL & "'" & sFileName & "',"
                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                        sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
      'response.write "Half Day : " & rstTMABSENT("EMP_CODE") & " , " & pRTIN(rstTMABSENT("NAME")) & " , " & fdate2(rstTMABSENT("DT_ABSENT")) & " , " & sTotalHour &  " <br>"
                     conn.execute sSQL
                        
                    else

                        sSQL = "select * from tmshfcode "
                        sSQL = sSQL & " where SHF_CODE ='" & rstTMABSENT("SHF_CODE") & "'"
                        set rstTMSHFCODE= server.createobject("adodb.recordset")
                        rstTMSHFCODE.Open sSQL, conn, 3, 3

                        if not rstTMSHFCODE.eof then
                            sTotalHour = Cint(TimetoMin(rstTMSHFCODE("SHFLEN")))
                            sTotalHour = MintoTime(sTotalHour)
                            sTotalHour = TimetoDec(sTotalHour)
                        end if
        
                        sSQL = "INSERT into TMMTHEND (DTFR,DTTO,EMP_CODE,NAME,SUP_CODE,DT_WORK,WHATCODE,SAPCODE, TOTALHOUR,FILEDIR, CREATE_ID, DT_CREATE,USER_ID,DATETIME)"
                        sSQL = sSQL & " values ("
                        sSQL = sSQL & "'" & fdate2(dtpDtFr) & "',"
                        sSQL = sSQL & "'" & fdate2(dtpDtTo) & "',"
                        sSQL = sSQL & "'" & rstTMABSENT("EMP_CODE") & "',"
                        sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                        sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                        sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_ABSENT")) & "',"
                        sSQL = sSQL & "'2001'," '=== SAP Code Hard coded for Absent
                        sSQL = sSQL & "'9000'," '=== Hard coded SAP Absence without leave 9000
                        sSQL = sSQL & "'" & sTotalHour & "',"
                        sSQL = sSQL & "'" & sFileName & "',"
                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                        sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
    'response.write rstTMABSENT("EMP_CODE") & " , " & pRTIN(rstTMABSENT("NAME")) & " , " & fdate2(rstTMABSENT("DT_ABSENT")) & " , " & sTotalHour &  " <br>"
                        conn.execute sSQL
                    end if
        
                    rstTMABSENT.movenext
                loop
            end if

           '==== Copy to text file =====
            Set fso = Server.CreateObject("Scripting.FileSystemObject")
            Set objCreatedFile = fso.CreateTextFile(sFilePath)
            objCreatedFile.close
            Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)

            sSQL = " select * from TMMTHEND "
            sSQL = sSQL & " where DTFR = '" & fdate2(dtpDtFr) & "' and DTTO ='" & fdate2(dtpDtTo) & "'"
            sSQL = sSQL & " and FILEDIR ='" & sFileName & "'" '=== Filter the right file during reprocessing the same period
            sSQL = sSQL & " order by EMP_CODE, DT_WORK"
            set rstTMMTHEND = server.CreateObject("ADODB.Recordset")
		    rstTMMTHEND.open sSQL, conn, 3, 3
            if not rstTMMTHEND.eof then
                do while not rstTMMTHEND.eof
                    sEmpCode = rstTMMTHEND("EMP_CODE")
                    sStr = 	LPad(sEmpCode,8,"0") & "," & fDateonly(rstTMMTHEND("DT_WORK")) 
                    sStr = sStr & "," & rstTMMTHEND("WHATCODE") & "," & rstTMMTHEND("SAPCODE") & "," 
                    sStr = sStr & rstTMMTHEND("TOTALHOUR")
    				objOpenFile.WriteLine sStr
                    rstTMMTHEND.movenext
                loop
                sStr = "$$$$"
                objOpenFile.WriteLine sStr
                
            end if

            '======= INSERT INTO LOG ============================
            sChangesM = sFileName
            sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,DTFR,DTTO,USER_ID,DATETIME) "
	        sSQL = sSQL & "values ("
            sSQL = sSQL & "'MONTHEND',"
            sSQL = sSQL & "'Success',"
            sSQL = sSQL & "'" & sChangesM & "',"
            sSQL = sSQL & "'" & fdate2(dtpDtFr) & "',"
            sSQL = sSQL & "'" & fdate2(dtpDtTo) & "',"
            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	        sSQL = sSQL & ") "
            conn.execute sSQL
       
        sMainURL = "tmmthend.asp?"
        call confirmBox("Process Complete!", sMainURL&sAddURL)   

    end if
        
    Set rstTMMTHEND = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select DTFR, DTTO from TMMTHEND order by DTFR desc limit 1"
    rstTMMTHEND.Open sSQL, conn, 3, 3
    if not rstTMMTHEND.eof then
        dtpDtFr = sPayFrom & "-" &  Month(Date) & "-" & Year(Date)  '==== This month 22nd
        dtpDtTo = sPayTo & "-" &  Month(DateAdd("m",1,CDate(dtpDtFr))) & "-" & Year(Date) '=== Next month 21st
    end if
        
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div id="loader-wrapper" style="display:none">
         <div id="loader"></div>
    </div>
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_tm.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Month End Process</h1>
            </section>
           <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <div class="box box-info">
                            <div class="box-body">
                                <form id="form1" class="form-horizontal" action="tmmthend.asp" method="post" name="form2">
                                    <!--<div class="form-group">
                                        <label class="col-sm-3 col-lg-3 control-label">Last Processing Date : </label>
                                        <div class="col-sm-6 col-lg-6">
                                            <div class="input-group">
                                                <%
                                                    Set rstTMMTHEND = server.CreateObject("ADODB.RecordSet")    
                                                    sSQL = "select DTFR, DTTO from TMMTHEND order by DTFR desc limit 1"
                                                    rstTMMTHEND.Open sSQL, conn, 3, 3
                                                    if not rstTMMTHEND.eof then
                                                        response.write "<span class='mod-form-control'>" & rstTMMTHEND("DTFR") & " - " & rstTMMTHEND("DTTO") & "</span>"
                                                        bSuccess = "Y" 
                                                    end if
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Status : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                <%
                                                    if bSuccess = "Y" then
                                                        response.write "<span class='mod-form-control'>Successful</span>"
                                                    else
                                                        response.write "<span class='mod-form-control'>Unsuccessful</span>"
                                                    end if
                                                %>
                                            </div>
                                        </div>
                                    </div>-->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">From Date : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpDtFr" name="dtpDtFr" type="text" value='<%=fdatelong(dtpDtFr)%>' class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpDtFr" class="btn btn-default">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <label class="col-sm-3 col-lg-3 control-label" style="width: 100px">To Date : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpDtTo" name="dtpDtTo" type="text"  value='<%=fdatelong(dtpDtTo)%>' class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpDtTo" class="btn btn-default">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
										<div class="col-sm-2"></div>
                                        <label class="col-sm-9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Before processing please ensure the following items are carried out</label><br />
										<div class="col-sm-2"></div>
                                        <label class="col-sm-9" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. Incomplete Attendance Corrected</label><br />
										<div class="col-sm-2"></div>
                                        <label class="col-sm-9" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. Irregular Attendance Corrected</label><br />
										<div class="col-sm-2"></div>
                                        <label class="col-sm-9" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. Employee Time off is Entered</label>
									</div>
                                    <div class="form-group">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-7">
                                            <input type="SUBMIT" name="btnProcess" value="Process" style="width: 90px; margin-right: 10px" onclick="turnon();">
                                        </div>
                                    </div>
                                </form>
                                <div class="col-sm-2"></div>
                                <div class="col-lg-7">
                                    <table class="table table-bordered table-striped" >
                                    <%
                                        Dim objFSO, objFile, objFolder
                                            sFilePath = server.mappath("MTHEND\" & sFileName)
                                            Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
                                            Set objFolder = objFSO.GetFolder(sFilePath)
                                            response.write "<tr>"
                                                response.write "<td width='5%'>No"
                                                response.write "<td width='30%'>File Name"
                                                response.write "<td width='30%'>Process Date"
                                                response.write "<td width='40%'>Payroll Period"
                                                response.write "<td width='15%' align=center>Delete"
                                            response.write "<tr>"

                                            For Each objFile in objFolder.Files
	                                            i = i + 1

                                                sSQL = " select * from TMMTHEND "
                                                sSQL = sSQL & " where FILEDIR = '" & objFile.Name & "'"
                                                sSQL = sSQL & " order by EMP_CODE limit 1"
                                                set rstTMMIDMTH2 = server.CreateObject("ADODB.Recordset")
		                                        rstTMMIDMTH2.open sSQL, conn, 3, 3
                                                if not rstTMMIDMTH2.eof then
                                                    sPayPeriod = fDateLong(rstTMMIDMTH2("DTFR")) & " - " & fDateLong(rstTMMIDMTH2("DTTO"))
                                                    sProcess =  rstTMMIDMTH2("DateTime")
                                                end if

                                                response.write "<tr>"
                                                    response.write "<td >" & i & "</td>"
	                                                response.write "<td><a href='MTHEND/" & objFile.Name & "'>" & objFile.Name & "</a></td>"
                                                    response.write "<td >" & sProcess & "</td>"
	                                                response.write "<td >" & sPayPeriod & "</td>"
                                                    response.write "<td><a href='javascript:void(0);' class='btn btn-danger pull-left' style='width: 90px' onclick=""fDel('" & objFile.Name & "','mycontent-del','#mymodal-del')"">Delete</a>"
	                                                response.write "<input type='hidden' name='id' value='" & objFile.Name & "'>"
	                                                response.write "</td>"
	                                            response.write "</tr>"
                                            Next
                                            
                                        Set objFolder = Nothing
                                        Set objFSO = Nothing
                                    %>
                                    </table>                                                       
                                </div>
                            </div>
                            <!-- box body-->
                        </div>
                        <!-- box info -->
                        </div>
                        <!-- box info -->
                        <div class="modal fade " id="mymodal-del" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span></button>
                                    </div>
                                    <div class="modal-body">
                                        <div id="mycontent-del">
                                            <!--- Content ---->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--col-sm-12-->
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
    <script src="plugins/input-mask/jquery.mask.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
    <!-- JQuery for the Choose a file label -->
    <script src="plugins/Custom/custom-file-input.js"></script>

    <script>
    
    //====Date picker without today's date==========================
    $(document).ready(function(){ //====== When Page finish loading
      
        $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            orientation: "bottom",
            })

        $('[date-picker]').mask('00/00/0000');
    });

    $('#btndtpDtFr').click(function () {
        $('#dtpDtFr').datepicker("show");
    });

    $('#btndtpDtTo').click(function () {
        $('#dtpDtTo').datepicker("show");
    });    

    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    function turnon(){
         document.getElementById("loader-wrapper").style.display = "";
    }

    function fDel(str, pContent,pModal) {
        showDelmodal(str, pContent)
		$(pModal).modal('show');
	}

    function showDelmodal(str,pContent){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "tmmthendfile_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    </script>
</body>
</html>
