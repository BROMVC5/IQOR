<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/clsUpload.asp"-->
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Mid Month Process</title>
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
            sMMDays = rstTMPATH("MMDAYS")
            sMMAmt = rstTMPATH("MMAMT")
            sPayFrom = rstTMPATH("PAYFROM")
        end if

        if request("btnProcess") <> "" then

            dtpDtFr = reqForm("dtpDtFr")
            dtpDtTo = reqForm("dtpDtTo")

            '==== Copy to text file =========================================
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

            '<!-- DateTime -->

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

            sFileName = "01advlist_" & sDtTime & ".txt"

            sFilePath = server.mappath("MIDMTH\" & sFileName)

            '==== Insert 1st and one record of FILEDIR and DTFR and DTTO
            '==== So that after process, the txt file generated, will have Process Date and Payroll Schedule.
            '==== Later we will filter out EMP_CODE <> '' to filter out the empty record.
            sSQL = "INSERT into TMMIDMTH (DTFR,DTTO,FILEDIR,USER_ID,DATETIME,CREATE_ID, DT_CREATE)"
            sSQL = sSQL & " values ("
            sSQL = sSQL & "'" & fdate2(dtpDtFr) & "',"
            sSQL = sSQL & "'" & fdate2(dtpDtTo) & "',"
            sSQL = sSQL & "'" & sFileName & "',"
            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
            conn.execute sSQL

            '==================================================================
            set rstTMMIDMTH = server.createobject("adodb.recordset")
            sSQL = "select tmemply.EMP_CODE, tmemply.NAME, SUP_CODE, tmworkgrp.HOL_ID, tmshiftot.SHF_CODE, DT_SHIFT, DT_WORK, tmgrade.GRADE_ID, tmgrade.SHFALL, tmgrade.OT, tmgrade.MTHEND from tmemply" 
            sSQL = sSQL & " left join tmshiftot on tmemply.EMP_CODE = tmshiftot.EMP_CODE "
            sSQL = sSQL & " left join tmworkgrp on tmemply.EMP_CODE = tmworkgrp.EMP_CODE "
            sSQL = sSQL & " left join tmclk2 on tmshiftot.EMP_CODE = tmclk2.EMP_CODE and  DT_SHIFT = DT_WORK"
            sSQL = sSQL & " left join tmgrade on tmemply.GRADE_ID = tmgrade.GRADE_ID "
            sSQL = sSQL & " where (   (DT_SHIFT between '" & fdate2(dtpDtFr) & "' and '" & fdate2(dtpDtTo) & "') "
            sSQL = sSQL & " and isnull(DT_RESIGN) ) "
            sSQL = sSQL & " and tmgrade.MIDMTH = 'Y'" '=== only the GRADE with generate Mid Month will process.
            sSQL = sSQL & " order by EMP_CODE, DT_SHIFT desc"
            rstTMMIDMTH.Open sSQL, conn, 3, 3
            if not rstTMMIDMTH.eof then

                Do while not rstTMMIDMTH.eof

                    if sEmp_Code <> rstTMMIDMTH("EMP_CODE") then
                        
                        if bInsert = "Y" then
                            '==== Insert the previous record ==========================
                            sSQL = "INSERT into TMMIDMTH (DTFR,DTTO,EMP_CODE,NAME,SUP_CODE,SUPNAME,TOTDAYS,TOTAMT,FILEDIR,USER_ID,DATETIME,CREATE_ID, DT_CREATE)"
                            sSQL = sSQL & " values ("
                            sSQL = sSQL & "'" & fdate2(dtpDtFr) & "',"
                            sSQL = sSQL & "'" & fdate2(dtpDtTo) & "',"
                            sSQL = sSQL & "'" & sEmp_Code & "',"
                            sSQL = sSQL & "'" & sName & "',"
                            sSQL = sSQL & "'" & sSup_Code & "',"
                        
                            sSQLSUP = "select * from TMEMPLY where EMP_CODE = '" & sSup_Code & "'"
		                    set rstTMSUP = server.CreateObject("ADODB.Recordset")
		                    rstTMSUP.open sSQLSUP, conn, 3, 3
                            if not rstTMSUP.eof then
                                sSQL = sSQL & "'" & rstTMSUP("NAME") & "',"
                            end if 

                            sSQL = sSQL & "'" & iDays & "',"
                            sSQL = sSQL & "'" & sMMAmt & "',"
                            sSQL = sSQL & "'" & sFileName & "',"
                            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                            sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                            'response.write " Insert : "  & sSQL & "<br>"
                                ' response.end  
                            conn.execute sSQL
                        end if

                        iDays = 0  '=== Initialize back to 0
                        bInsert = "N" '=== Initialize back to No
         
                    end if

'response.write "@@@ -- } -- " & rstTMMIDMTH("EMP_CODE") & " SHF_CODE : " & rstTMMIDMTH("SHF_CODE") & " DT SHIFT : " & rstTMMIDMTH("DT_SHIFT") & " DTWORK : " & rstTMMIDMTH("DT_WORK") & " HOL_ID : " & rstTMMIDMTH("HOL_ID") &"<br>" 

                    sHoliday = "N"
                    Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMHOL1 where HOL_ID = '" & rstTMMIDMTH("HOL_ID") & "'"
                    sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMMIDMTH("DT_SHIFT")) & "'" 
                    rstDT_HOL.Open sSQL, conn, 3, 3
                    if not rstDT_HOL.eof then 
                        sHoliday = "Y"
                    end if
        
                    bPaid = "N"
                    sSQL = "select * from TMEOFF where EMP_CODE = '" & rstTMMIDMTH("EMP_CODE") & "'"
		            sSQL =  sSQL & " and DTFR <= '" & fdate2(rstTMMIDMTH("DT_SHIFT")) & "'"  
		            sSQL =  sSQL & " and DTTO >= '" & fdate2(rstTMMIDMTH("DT_SHIFT")) & "'"  
                    set rstTMEOFF = server.CreateObject("ADODB.Recordset")
		            rstTMEOFF.open sSQL, conn, 3, 3
		            if not rstTMEOFF.eof then
                        bPaid = rstTMEOFF("PAID")
		            end if
   
                    if rstTMMIDMTH("SHF_CODE") = "OFF" and isnull(rstTMMIDMTH("DT_WORK")) then
                        
                        iDays = iDays + 1

        'response.write " DT_SHIFT: " &  rstTMMIDMTH("DT_SHIFT") & " iDays Off, null DT_WORK : " & iDays & "<br>"
                    
                    elseif not isnull(rstTMMIDMTH("DT_WORK")) then
                        iDays = iDays + 1
          'response.write " DT_SHIFT: " &  rstTMMIDMTH("DT_SHIFT") & " iDays DT_WORK : " & iDays & "<br>"  
                    elseif isnull(rstTMMIDMTH("DT_WORK")) and (bPaid = "Y" or sHoliday = "Y") then
                        
                        iDays = iDays + 1
      'response.write " DT_SHIFT: " &  rstTMMIDMTH("DT_SHIFT") & " iDays null DT_WORK, bPaid or sHoliday : " & iDays & "<br>"                             
                    end if
                    
                    '=== I do the following because I want iDays to keep on add on even after 10 days
                    '=== and when only change to the next EMP_CODE, we will insert the earlier stuff.
                    if iDays >= Cint(sMMDays) then 

                        bInsert = "Y"

                    end if 
                    
                    '=== Retain the last record so when movenext if change of Emp_Code will insert.
                    '=== Or when movenext it is the last record, it will insert the last record. 
                    sEmp_Code = rstTMMIDMTH("EMP_CODE")
                    sName = rstTMMIDMTH("NAME")
                    sSup_Code = rstTMMIDMTH("SUP_CODE")

                    rstTMMIDMTH.movenext

                    if rstTMMIDMTH.eof and bInsert = "Y" then
                        
                        '==== Insert the previous record ==========================
                        sSQL = "INSERT into TMMIDMTH (DTFR,DTTO,EMP_CODE,NAME,SUP_CODE,SUPNAME,TOTDAYS,TOTAMT,FILEDIR,USER_ID,DATETIME,CREATE_ID, DT_CREATE)"
                        sSQL = sSQL & " values ("
                        sSQL = sSQL & "'" & fdate2(dtpDtFr) & "',"
                        sSQL = sSQL & "'" & fdate2(dtpDtTo) & "',"
                        sSQL = sSQL & "'" & sEmp_Code & "',"
                        sSQL = sSQL & "'" & sName & "',"
                        sSQL = sSQL & "'" & sSup_Code & "',"
                        
                        sSQLSUP = "select * from TMEMPLY where EMP_CODE = '" & sSup_Code & "'"
		                set rstTMSUP = server.CreateObject("ADODB.Recordset")
		                rstTMSUP.open sSQLSUP, conn, 3, 3
                        if not rstTMSUP.eof then
                            sSQL = sSQL & "'" & rstTMSUP("NAME") & "',"
                        end if 

                        sSQL = sSQL & "'" & iDays & "',"
                        sSQL = sSQL & "'" & sMMAmt & "',"
                        sSQL = sSQL & "'" & sFileName & "',"
                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                        sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
'response.write " Insert end of file : "  & sSQL & "<br>"
                        conn.execute sSQL

                        iDays = 0  '=== Initialize back to 0
                        bInsert = "N" '=== Initialize back to No
                    end if

                loop
        
            end if    

            Set fso = Server.CreateObject("Scripting.FileSystemObject")
            Set objCreatedFile = fso.CreateTextFile(sFilePath)
            objCreatedFile.close
            Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)

            sSQL = " select * from TMMIDMTH "
            sSQL = sSQL & " where DTFR = '" & fdate2(dtpDtFr) & "' and DTTO ='" & fdate2(dtpDtTo) & "'"
            sSQL = sSQL & " and FILEDIR ='" & sFileName & "'" '=== Filter the right file during reprocessing the same period
            sSQL = sSQL & " and EMP_CODE <> '' " '=== Filter out the 1st and one record inserted for FILEDIR and DTFR DTTO
            sSQL = sSQL & " order by EMP_CODE, SUP_CODE"
            set rstTMMIDMTH = server.CreateObject("ADODB.Recordset")
		    rstTMMIDMTH.open sSQL, conn, 3, 3
            if not rstTMMIDMTH.eof then
                do while not rstTMMIDMTH.eof
        
                    sStr = 	rstTMMIDMTH("EMP_CODE")
                    sStr = Lpad(sStr,8,"0")

    				objOpenFile.WriteLine sStr
                    rstTMMIDMTH.movenext
                loop
                sStr = "$$$$"
                objOpenFile.WriteLine sStr
                
            end if

        'response.end
            sMainURL = "tmmidmth.asp?"
            call confirmBox("Process Complete!", sMainURL&sAddURL)

        end if
        
    Set rstTMMIDMTH = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMMIDMTH order by DTFR desc limit 1"
    rstTMMIDMTH.Open sSQL, conn, 3, 3
    if not rstTMMIDMTH.eof then
        dtpDtFr = sPayFrom & "-" &  Month(Date) & "-" & Year(Date)
        'dtpDtFrJ = mid(dtpDtFr,7,4) & "," & mid(dtpDtFr,4,2) & "," & mid(dtpDtFr,1,2)
        dtpDtTo = DateAdd("d",15,Cdate(dtpDtFr))
        'dtpDtToJ =  mid(dtpDtTo,7,4) & "," & mid(dtpDtTo,4,2) & "," & mid(dtpDtTo,1,2)
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
                <h1>Mid Month Process</h1>
            </section>
           <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <div class="box box-info">
                            <div class="box-body">
                                <!--<div id="darkLayerproc" class="darkClass" style="display:none">                     
                                </div>-->
                                <form id="form1" class="form-horizontal" action="tmmidmth.asp" method="post" name="form2">
                                    <!--<div class="form-group">
                                        <label class="col-sm-3 control-label">Last Processing Date : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                <%
                                                    Set rstTMMIDMTH = server.CreateObject("ADODB.RecordSet")    
                                                    sSQL = "select * from TMMIDMTH order by DTFR desc limit 1"
                                                    rstTMMIDMTH.Open sSQL, conn, 3, 3
                                                    if not rstTMMIDMTH.eof then
                                                        response.write "<span class='mod-form-control'>" & rstTMMIDMTH("DTFR") & " - " & rstTMMIDMTH("DTTO") & "</span>"
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
                                                <input id="dtpDtTo" name="dtpDtTo" type="text" value='<%=fdatelong(dtpDtTo)%>' class="form-control" date-picker>
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
                                        <label class="col-sm-9" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. Irregular Attendance Corrected</label>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-7">
                                            <input type="SUBMIT" name="btnProcess" value="Process" style="width: 90px; margin-right: 10px" onclick="turnon();">
                                        </div>
                                    </div>
                                </form>
                                <div class="col-sm-2"></div>
                                <div class="col-lg-8">
                                    <table class="table table-bordered table-striped" >
                                        <%
                                        Dim objFSO, objFile, objFolder
                                            sFilePath = server.mappath("MIDMTH\" & sFileName)
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

                                                sSQL = " select * from TMMIDMTH "
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
	                                                response.write "<td><a href='MIDMTH/" & objFile.Name & "'>" & objFile.Name & "</a></td>"
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
                </div>
                <!-- row -->
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

  	    xhttp.open("GET", "tmmidmthfile_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }
    </script>
</body>
</html>
