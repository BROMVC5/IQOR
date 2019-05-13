<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>IQOR</title>
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

    <%
    
    sMainURL = "bropath.asp?"
	
    sModeSub = request("sub")
                    
    if sModeSub <> "" Then
        
        sSdEmail = reqForm("txtSdEmail")
        sSdPw = reqForm("txtSdPw")
        sSMTP = reqForm("txtSMTP")
        sPort = reqForm("txtPort")
        sUseSSL = reqForm("selUseSSL")
        sNumRows = reqForm("txtNumRows")
        
        if sModeSub = "up" Then
                
            sSQL = "UPDATE BROPATH SET "             
            sSQL = sSQL & "SDEMAIL = '" & sSdEmail & "',"
            sSQL = sSQL & "SDPW = '" & sSdPw & "',"
            sSQL = sSQL & "SMTP = '" & sSMTP & "',"
            sSQL = sSQL & "PORT = '" & sPort & "',"
            sSQL = sSQL & "USESSL = '" & sUseSSL & "',"
            sSQL = sSQL & "NUMROWS = '" & sNumRows & "'"
            conn.execute sSQL
            call confirmBox("Update Successful!", sMainURL)
        end if

    End If
          
    Set rstBROPATH = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from BROPATH" 
    rstBROPATH.Open sSQL, conn, 3, 3
    if not rstBROPATH.eof then
        sSdEmail = rstBROPATH("SDEMAIL")
        sSdPW = rstBROPATH("SDPW")
        sSMTP = rstBROPATH("SMTP")
        sPort = rstBROPATH("PORT")
        sUseSSL = rstBROPATH("USESSL")
        sNumRows = rstBROPATH("NUMROWS")
    end if
    pCloseTables(rstBROPATH)
        
        
    %>
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_pass.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Program Setup</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="bropath.asp" method="post">
                            <div class="box box-info">
                                <div class="box-body" style="padding-top:30px">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Send Email : </label>
                                        <div id="divEmail" class="col-sm-8">
                                            <input class="form-control" id="txtSdEmail" name="txtSdEmail" value="<%=sSdEmail%>" maxlength="50" onblur="validateEmail(this.value);">
                                            <span id="errEmail" class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Send Password : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" type="password" id="txtSdPW" name="txtSdPW" value="<%=sSdPW%>" maxlength="20" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">SMTP : </label>
                                        <div class="col-sm-5">
                                            <input class="form-control" id="txtSMTP" name="txtSMTP" value="<%=sSMTP%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Port : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" id="txtPort" name="txtPort" value="<%=sPort%>" maxlength="5">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Use SSL : </label>
                                        <div class="col-sm-3">
                                            <select name="selUseSSL" class="form-control">
                                                <option value="T" <%if sUseSSL = "T" then%>Selected<%end if%>>True</option>
                                                <option value="F" <%if sUseSSL = "F" then%>Selected<%end if%>>False</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Number of Rows : </label>
                                        <div class="col-sm-3">
											<input class="form-control" type="text" style="text-align:right;" id="txtNumRows" name="txtNumRows" value="<%=sNumRows%>" maxlength="3" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" placeholder="NUM OF ROWS"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button type="submit" id="btnUpdate" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                </div>
                                <!-- /.box-footer -->
                             </div>
                             <!-- /.box -->
                        </form>
                    </div>
                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->

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
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

    <script>

    function validateEmail(sEmail) {
      var reEmail = /^(?:[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+\.)*[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!\.)){0,61}[a-zA-Z0-9]?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\[(?:(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\]))$/;

      if(!sEmail.match(reEmail)) {
       // alert("Invalid email address");
        document.getElementById("divEmail").className += ' has-error'
        document.getElementById("errEmail").innerHTML = "Please key in valid email address" 
        document.getElementById("txtSdEmail").focus();  
        return false;
      }else {
        document.getElementById("divEmail").className -= ' has-error'
        document.getElementById("divEmail").className += ' col-sm-8'
        document.getElementById("errEmail").innerHTML = "" 
        return true;
        }
      
    }
    </script>

</body>
</html>
