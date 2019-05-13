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
    
    sEMP_CODE = request("txtstring")
    dtFr = request("dtFr")
    dtTo = request("dtTo")
  
    if reqForm("btnSubmit") <> "" then

        sID = reqform("txtEMP_CODE")
        dtFr = reqForm("dtpFr")
        dtTo = reqForm("dtpTo")

        '=== Delete the original Time OFf
        sSQL = " DELETE FROM tmeoff "    
        sSQL = sSQL & " WHERE EMP_CODE = '" & sID & "'"
        sSQL = sSQL & " AND DTFR = '" & fdate2(dtFr) & "'"
        sSQL = sSQL & " AND DTTO = '" & fdate2(dtTo) & "'"
        conn.execute sSQL

        sMainURL = "tmeoff.asp?"

        dtLoopAbsent = dtFr
        do while datevalue(dtLoopAbsent) <= datevalue(dtTo)
            call fAbsent(dtLoopAbsent,sID)
            dtLoopAbsent = DateAdd("d",1,datevalue(dtLoopAbsent))
        loop

        '===== Process and record 3 days absents consecutively=====================================================
        '===== From Program setup =====
        Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMPATH" 
        rstTMPATH.Open sSQL, conn, 3, 3
        if not rstTMPATH.eof then
            sPayFrom = rstTMPATH("PAYFROM") 
            sPayTo = rstTMPATH("PAYTO")
        end if
        pCloseTables(rstTMPATH)
               
        if Cint(day(dtFr)) > Cint(sPayTo) + 1 then '=== + 1 because during dtProcess 22 I want to process till 21
            dtAbsent3Fr = CDate(sPayFrom & "-" & Month(dtFr) & "-" & Year(dtFr))
        else
            dtAbsent3Fr = CDate(sPayFrom & "-" & GetLastMonth(Month(dtFr), Year(dtFr)) & "-" & GetLastMonthYear(Month(dtFr), Year(dtFr)))
        end if

        dtAbsent3To = CDate(sPayTo & "-" & Month(dtTo) & "-" & Year(dtTo))
        
        call fAbsent3(dtAbsent3Fr, dtAbsent3To, sID , "Y")

        call confirmBox("Delete Successful!", sMainURL)

    End If

%>

</head>
<body>
    <form class="form-horizontal" action="tmeoff_del.asp" method="post">
        <input type="hidden" name="txtEMP_CODE" value='<%=sEMP_CODE%>' />
        <input type="hidden" name="dtpFr" value='<%=dtFr%>' />
        <input type="hidden" name="dtpTo" value='<%=dtTo%>' />
        <div class="box-body">
            <div class="form-group">
                <div class="col-lg-4">
                    <div style="text-align:center">
                        <img src="dist/img/warning.png" width="70" height="70" style="margin-left:30px" />
                    </div>
                </div>
                <div class="col-sm-7">
                    <span style="color:blue"><h3>EMPLOYEE NO : <% response.write sEMP_CODE %></h3></span>
                    <span style="color:blue"><h3>LEAVE DATE FROM <% response.write dtFr %> TO <% response.write dtTo %></h3></span>
                    <span style="color:blue"><h3>ABSENT RECORDS WILL BE UPDATED</h3></span>
                    <span style="color:red"><h4>Are you sure to delete this Leave?</h4></span>
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
