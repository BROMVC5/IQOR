﻿<!DOCTYPE html>
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
    
    sCont_ID = request("txtstring")

    if sCont_ID <> "" then
        sID = sCont_ID
    else
        sID = reqformU("txtCont_ID")
    end if
  
    if reqForm("btnSubmit") <> "" then
        
        sSQL = "delete from TMCONT where Cont_ID='" & sID & "'"
        conn.execute sSQL     
        
        sMainURL = "TMCONT.asp?"
        sAddURL = "txtCont_ID=" & sID & "&txtSearch=" & sSearch & "&Page=" & iPage 

        call confirmBox("Delete Successful!", sMainURL&sAddURL)
    End If

    bDel = "Y"
    Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select EMP_CODE,NAME, CONT_ID from TMEMPLY" 
    rstTMEMPLY.Open sSQL, conn, 3, 3
        do while not rstTMEMPLY.eof
            if sID = rstTMEMPLY("CONT_ID") then
                sWho = rstTMEMPLY("EMP_CODE")
                sName = rstTMEMPLY("NAME")
                bDel = "N"
                Exit Do
            end if        
            rstTMEMPLY.movenext
        loop
    pCloseTables(rstTMEMPLY)

%>

</head>
<body>
    <form class="form-horizontal" action="TMCONT_del.asp" method="post">
        <input type="hidden" name="txtCont_ID" value='<%=sCont_ID%>' />
        <div class="box-body">
            <div class="form-group">
                <div class="col-lg-3">
                    <div style="text-align:center">
                        <img src="dist/img/warning.png" width="70" height="70" style="margin-left:30px" />
                    </div>
                </div>
                <div class="col-sm-7">
                    <%if bDel = "Y" then %>
                       <span style="color:blue"><h3>Contract Code : <% response.write sCont_ID %></h3></span>
                       <span style="color:red"><h4>Are you sure to delete this Contract?</h4></span>
                    <%else%>
                        <span style="color:blue"><h3><% response.write sID %> is used by <%response.write sWho & "-" & sName %></h3></span>
                        <span style="color:red"><h4>Cannot delete this Contract</h4></span>
                    <%end if%>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
            <button type="button" class="btn btn-default pull-left" data-dismiss="modal" aria-label="Close" style="width: 90px;">Close</button>
            <%if bDel = "Y" then %>
                <input type="submit" name="btnSubmit" value="Delete" class="btn btn-danger pull-right" style="width: 90px"/>
            <%end if%>
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
