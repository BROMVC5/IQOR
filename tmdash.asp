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
    
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <!-- Bootstrap 3.3.6 CSS -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="dist/css/dataTables.bootstrap.css">
    <!-- Font Awesome Minimum -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
        folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
     <!-- Jquery 1.12.0 UI CSS -->
    <%
        sLogin = session("USERNAME")
        
        Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMEMPLY where "
        sSQL = sSQL & " EMP_CODE = '" & sLogin & "'"  
        rstTMEMPLY.Open sSQL, conn, 3, 3
        if not rstTMEMPLY.eof then
            sAType = rstTMEMPLY("ATYPE") 
            sCost_ID = rstTMEMPLY("Cost_ID")
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
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Home</h1>
            </section>
            <!-- Main content -->
            <section class="content" style="min-height:215px;">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box">
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <div id="absent">
                                    <!-- CONTENT HERE -->
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </section>
            <!-- /.content -->
            <section class="content" style="min-height:215px;">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box">
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <div id="absent3">
                                    <!-- CONTENT HERE -->
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </section>
            <!-- /.content -->
            <%
                '==== Abnormal ======
                sSQL = "select * from TMCLK2 "
                sSQL = sSQL & " where ((TIN = '' or TOUT = '') or (OTIN='' or OTOUT='') or IRREG = 'Y' ) "  '=== Incomplete triggers
                sSQL = sSQL & " and DT_WORK < '" & fdate2(Date) & "'"
                       
                '=== Login in as Verifier ===========================================================================
                if sAType = "V" then '=== For manager and Supervisor and their immediate subordinate
                
                    '=== Only see all the final approval
                    sSQL = sSQL & " and ( "
                    sSQL = sSQL & " ( not isnull(1DTAPV) and isnull(2DTAPV) and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sLogin & "') )"

                    '=== Wanna look at all Manager's subordinate
                    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
                    sSQL1 = "select * from TMEMPLY where "
                    sSQL1 = sSQL1 & " ATYPE = 'M' "  '=== Retrieve all Manager
                    sSQL1 = sSQL1 & " order by  EMP_CODE" 
                    rstTMDOWN1.Open sSQL1, conn, 3, 3
                    if not rstTMDOWN1.eof then
       
                        sSQL = sSQL & " OR "
    
                        Do while not rstTMDOWN1.eof
                            sSQL = sSQL & " ( isnull(1DTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR "
                        rstTMDOWN1.movenext
                        loop
    
                        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR from the string because of the loop above

                        sSQL = sSQL & " )"

                    end if

                    set rstTMClk2 = server.createobject("adodb.recordset")
                    rstTMClk2.cursortype = adOpenStatic
                    rstTMClk2.cursorlocation = adUseClient
                    rstTMClk2.locktype = adLockBatchOptimistic
                    rstTMClk2.Open sSQL, conn, 3, 3
                    if not rstTMClk2.eof then
                        sTotAbnormPendVeriMgrs = rstTMClk2.RecordCount
                    end if 
                    pCloseTables(rstTMCLK2)

                    '=== All pending 1st level superior ===============
                    sSQL = "select * from TMCLK2 "
                    sSQL = sSQL & " where ((TIN = '' or TOUT = '') or (OTIN='' or OTOUT='') or IRREG = 'Y' ) "  '=== Incomplete triggers
                    sSQL = sSQL & " and DT_WORK < '" & fdate2(Date) & "'"
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
                    set rstTMClk2 = server.createobject("adodb.recordset")
                    rstTMClk2.cursortype = adOpenStatic
                    rstTMClk2.cursorlocation = adUseClient
                    rstTMClk2.locktype = adLockBatchOptimistic
                    rstTMClk2.Open sSQL, conn, 3, 3
                    if not rstTMClk2.eof then
                        sTotAbnormPendSup = rstTMClk2.RecordCount
                    end if 
                    pCloseTables(rstTMCLK2)

                    sTotAbnorm = sTotAbnormPendVeriMgrs + sTotAbnormPendSup

                '=== Login in as Manager ===================================================================
                elseif sAType = "M" then
                
                    sSQL = sSQL & " and ( "
                    sSQL = sSQL & " ( isnull(1DTAPV) and tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & sLogin & "') )"
                    
                   '=== Wanna look at manager's subordinate must be a Superior's subordinate
                    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
                    sSQL1 = "select * from TMEMPLY where "
                    sSQL1 = sSQL1 & " SUP_CODE ='" & sLogin & "'" '=== Retrieve all Manager's Superior subordinate
                    sSQL1 = sSQL1 & " AND ATYPE = 'S' "  
                    sSQL1 = sSQL1 & " order by  EMP_CODE" 
                    rstTMDOWN1.Open sSQL1, conn, 3, 3
                    if not rstTMDOWN1.eof then
       
                        sSQL = sSQL & " OR "
    
                        Do while not rstTMDOWN1.eof
                            sSQL = sSQL & " ( isnull(1DTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR "
                        rstTMDOWN1.movenext
                        loop
    
                        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR from the string because of the loop above

                    end if  

                    sSQL = sSQL & " )"

                    set rstTMClk2 = server.createobject("adodb.recordset")
                    rstTMClk2.cursortype = adOpenStatic
                    rstTMClk2.cursorlocation = adUseClient
                    rstTMClk2.locktype = adLockBatchOptimistic
                    rstTMClk2.Open sSQl, conn, 3, 3
                    if not rstTMClk2.eof then
                        sTotAbnorm = rstTMClk2.RecordCount
                    end if 
                    pCloseTables(rstTMClk2)
                
                '=== Login as Superior======================================================================================
                elseif sAType = "S" then
                    
                    sSQL = sSQL & " and isnull(1DTAPV) and EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & session("USERNAME") & "')"  
                    set rstTMClk2 = server.createobject("adodb.recordset")
                    rstTMClk2.cursortype = adOpenStatic
                    rstTMClk2.cursorlocation = adUseClient
                    rstTMClk2.locktype = adLockBatchOptimistic
                    rstTMClk2.Open sSQl, conn, 3, 3
                    if not rstTMClk2.eof then
                        sTotAbnorm = rstTMClk2.RecordCount
                    end if 
                    pCloseTables(rstTMClk2)
                
                end if
 

                '==== OT Count ======================================================================================
                sSQL = "select tmclk2.*, tmemply.NAME from TMCLK2  "
                sSQL = sSQL & " left join tmemply on tmclk2.EMP_CODE = tmemply.EMP_CODE "
                sSQL = sSQL & " where " 
                sSQL = sSQL & " OT = 'Y' and ( "
                sSQL = sSQL & "  TIN <> '' and TOUT <> '' and "
                sSQL = sSQL & " ( (isnull(1DTAPV) and isnull(2DTAPV)) or (not isnull(1DTAPV) and not isnull(2DTAPV))  )"
                sSQL = sSQL & " )"
                
                '=== Login in as Verifier ===========================================================================
                if sAType = "V" then
                    
                    sSQL = sSQL & " and ( " 

                    '==== Pending Verifier final approval
                    sSQL = sSQL & " (not isnull(1OTDTAPV) and not isnull(2OTDTAPV) and isnull(3OTDTAPV) ) "

                    Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                    sSQL1 = "select * from TMEMPLY where "
                    sSQL1 = sSQL1 & " ATYPE = 'M' "  '=== All Managers
                    sSQL1 = sSQL1 & " order by EMP_CODE "
                    rstTMEMPLY.Open sSQL1, conn, 3, 3
                    if not rstTMEMPLY.eof then
                
                        sSQL = sSQL & " OR " 

                        Do while not rstTMEMPLY.eof '=== Loop through every manager
                            Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
                            sSQL1 = "select * from TMEMPLY where "
                            sSQL1 = sSQL1 & " SUP_CODE ='" & rstTMEMPLY("EMP_CODE") & "'" '=== Retrieve all Manager's subordinate  
                            sSQL1 = sSQL1 & " order by ATYPE, EMP_CODE" 
                            rstTMDOWN1.Open sSQL1, conn, 3, 3
                            if not rstTMDOWN1.eof then
                                Do while not rstTMDOWN1.eof '=== Loop every subordinates
                                    if rstTMDOWN1("ATYPE") = "E" then '=== Direct subordinates which is an Employee
                                        sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') OR " 
                                    '=== Subordinate is a SUPERIOR that punch in
                                    elseif rstTMDOWN1("ATYPE") = "S" then 
                                        '=== Subordinate which is a Superior, Pending 1st level approval
                                        sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')  OR " 
                                        '=== Subordinate's subordinate pending Superior's approval
                                        sSQL = sSQL & " ( isnull(1OTDTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR"
                                    end if
    
                                    rstTMDOWN1.movenext
                                loop
                            end if

                        rstTMEMPLY.movenext
                        loop
                    
                        sSQL = left(sSQL, instrrev(sSQL, "OR") - 1) '=== Remove the last OR from the string because of the loop above
                        sSQL = sSQL & " )"  

                    end if
                 

                    set rstTMClk2 = server.createobject("adodb.recordset")
                    rstTMClk2.cursortype = adOpenStatic
                    rstTMClk2.cursorlocation = adUseClient
                    rstTMClk2.locktype = adLockBatchOptimistic
                    rstTMClk2.Open sSQL, conn, 3, 3
                    if not rstTMClk2.eof then
                        sTotOTPendVeriMgrs = rstTMClk2.RecordCount
                    end if 
                    pCloseTables(rstTMCLK2)

                    '=== This is for Employee/Subordinates who punch in who is pending his superior 1st level approval"
                    sSQL = "select tmclk2.*, tmemply.NAME from TMCLK2  "
                    sSQL = sSQL & " left join tmemply on tmclk2.EMP_CODE = tmemply.EMP_CODE "
                    sSQL = sSQL & " where " 
                    sSQL = sSQL & " OT = 'Y' and ( "
                    sSQL = sSQL & "  TIN <> '' and TOUT <> '' and "
                    sSQL = sSQL & " ( (isnull(1DTAPV) and isnull(2DTAPV)) or (not isnull(1DTAPV) and not isnull(2DTAPV))  )"
                    sSQL = sSQL & " )"
                    sSQL = sSQL & " and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where ATYPE = 'E' or ATYPE = 'S') and isnull(1OTDTAPV) and isnull(2OTDTAPV)) " 
                    set rstTMClk2 = server.createobject("adodb.recordset")
                    rstTMClk2.cursortype = adOpenStatic
                    rstTMClk2.cursorlocation = adUseClient
                    rstTMClk2.locktype = adLockBatchOptimistic
                    rstTMClk2.Open sSQL, conn, 3, 3
                    if not rstTMClk2.eof then
                        sTotOTPendSup = rstTMClk2.RecordCount
                    end if 
                    pCloseTables(rstTMCLK2)
                
                    sTotOT = sTotOTPendVeriMgrs + sTotOTPendSup

                '=== Login in as Manager ===================================================================
                elseif sAType = "M" then 

                    '=== Pending 2nd level Manager's Approval OR
                    '=== his direct subordinates that required punch in and pending 1st and 2nd level approval OR
                    '=== his subordinate's subordinate that pending 1st level SUPERIOR approval
                    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
                    sSQL1 = "select * from TMEMPLY where "
                    sSQL1 = sSQL1 & " SUP_CODE ='" & sLogin & "'" '=== Retrieve all his subordinate  
                    sSQL1 = sSQL1 & " order by ATYPE, EMP_CODE" 
                    rstTMDOWN1.Open sSQL1, conn, 3, 3
                    if not rstTMDOWN1.eof then

                        sSQL = sSQL & " and ( "

                        Do while not rstTMDOWN1.eof

                            if rstTMDOWN1("ATYPE") = "E" then
                                '=== Manager with Direct Subordinate which is an Employee
                                '=== Managers will approve once at his screen 1stLevel and 2nd Level will be approved automatically
                                '=== and route to Verifier for final approval
                                sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') " 
                
                            '=== Subordinate is a SUPERIOR that punch in
                            '=== Managers will approve once at his screen 1stLevel and 2nd Level will be approved automatically
                            '=== and route to Verifier for final approval
                            elseif rstTMDOWN1("ATYPE") = "S" then 
                                '=== Subordinate which is a Manager
                                sSQL = sSQL & " ( isnull(1OTDTAPV) and tmclk2.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')  OR " 
                                '=== Subordinate's subordinate pending Manager's approval
                                sSQL = sSQL & " ( not isnull(1OTDTAPV) and isnull(2OTDTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) ) OR"
                                '=== Subordinate's subordinate pending Superior's approval
                                sSQL = sSQL & " ( isnull(1OTDTAPV) and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "') ) )"
    
                            end if
    
                            rstTMDOWN1.movenext
                            if not rstTMDOWN1.eof then
                                sSQL = sSQL & " OR " '=== Add a OR but not at the last sSQL concatenate
                            end if
                        loop
                    
                        sSQL = sSQL & " )" 

                        set rstTMClk2 = server.createobject("adodb.recordset")
                    end if

                    rstTMClk2.cursortype = adOpenStatic
                    rstTMClk2.cursorlocation = adUseClient
                    rstTMClk2.locktype = adLockBatchOptimistic
                    rstTMClk2.Open sSQL, conn, 3, 3
                    if not rstTMClk2.eof then
                        sTotOT = rstTMClk2.RecordCount
                    end if 
                    pCloseTables(rstTMCLK2)
                '===========================================================================================================

                '=== Login as Superior======================================================================================
                elseif sAType = "S" then 

                    sSQL = sSQL & " and (tmclk2.EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & session("USERNAME") & "') and isnull(1OTDTAPV))"
                    set rstTMClk2 = server.createobject("adodb.recordset")
                    rstTMClk2.cursortype = adOpenStatic
                    rstTMClk2.cursorlocation = adUseClient
                    rstTMClk2.locktype = adLockBatchOptimistic
                    rstTMClk2.Open sSQL, conn, 3, 3
                    if not rstTMClk2.eof then
                        sTotOT = rstTMClk2.RecordCount
                    end if 
                    pCloseTables(rstTMCLK2)

                end if

                if sTotAbnorm = "" then
                    sTotAbnorm = 0
                end if
                
                if sToTOT = "" then
                    sTotOT = 0
                end if
                
             %>
            <section class="content" style="min-height:215px;">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box">
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <div id="late">
                                    <a href="tmabnorm.asp">Abnormal attendance pending your approval (<%=sTotAbnorm %>)</a>
                                    <br />
                                    <a href="tmot.asp">Overtime pending your approval(<%=sTotOT %>)</a>
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
            </section>
         </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->
    
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css">
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
    
    <script>
    $(document).ready(function(){
        showAbsent('page=1');
        showAbsent3('page=1');
    });
    
    function showAbsent(str) {
  	    var xhttp;
  	
  	    if (str.length == 0) { 
    	    document.getElementById("absent").innerHTML = "";
    	    return;
  	    }
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("absent").innerHTML = xhttp.responseText;
    	    }
  	    };
  	
  	    xhttp.open("GET", "ajax/ax_tmabsent.asp?"+str, true);
  	    xhttp.send();
    }
    
    function showAbsent3(str) {
  	    var xhttp;
  	
  	    if (str.length == 0) { 
    	    document.getElementById("absent3").innerHTML = "";
    	    return;
  	    }
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("absent3").innerHTML = xhttp.responseText;
    	    }
  	    };
  	
  	    xhttp.open("GET", "ajax/ax_tmabsent3.asp?"+str, true);
  	    xhttp.send();
    }

    </script>

</body>
</html>
