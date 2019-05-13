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
    Set rstBROPass = server.CreateObject("ADODB.RecordSet")
	sql = "select * from BROPASS where ID = '" & session("USERNAME") & "' "
	sql = sql & " and PWDMNT = 'Y'" 
    rstBROPass.Open sql, conn, 3, 3
	if rstBROPass.eof then
        response.redirect("login.asp")
	end if

    Session.Timeout = 1440
    
    sUser_ID = request("txtstring")
   
    if reqForm("btnSubmit") <> "" then
        sUser_ID = reqform("txtUser_ID")
      
        sSQL = "delete from BROPASS where ID = '" & sUser_ID & "'"
        conn.execute sSQL     
        
        sSQL = "delete from TSPASS where ID = '" & sUser_ID & "'"
        conn.execute sSQL
        
        sSQL = "delete from CSPASS where ID = '" & sUser_ID & "'"
        conn.execute sSQL
         
        sSQL = "delete from TMPASS where ID = '" & sUser_ID & "'"
        conn.execute sSQL
    
        sMainURL = "bropass.asp?"
        sAddURL = "txtUser_ID=" & sUser_ID & "&txtSearch=" & sSearch & "&Page=" & iPage 

        call confirmBox("Delete Successful!", sMainURL&sAddURL)
    End If

%>

</head>
<body>
    <form class="form-horizontal" action="bropass_del.asp" method="post">
        <input type="hidden" name="Page" value='<%=iPage%>' />
        <input type="hidden" name="txtUser_ID" value='<%=sUser_ID%>' />
        <div class="box-body">
            <div class="form-group">
                <div class="col-lg-3">
                    <div style="text-align:center">
                         <img src="dist/img/warning.png" width="70" height="70" style="margin-left:30px" />
                   </div>
                </div>
                <div class="col-sm-7">
                     <span style="color: blue"><h3>DELETE USER ID : <% response.write sUser_ID %></h3></span>
                     <span style="color: blue"><h3>AND ALL THE ACCESS</h3></span>
                     <span style="color: red"><h4>Are you sure to delete all these records?</h4></span>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
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
