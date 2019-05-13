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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css"/>
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    <link href="font_awesome/fontawesome-free-5.8.1-web/css/all.css" rel="stylesheet" />

    <%
    sUser_ID = Session("USERNAME")
    
    if sUser_ID <> "" then
        sID = sUser_ID
    else
        sID = UCase(reqForm("txtID"))
    end if
        
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "system.asp?"
	
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 
   
    if sModeSub <> "" Then
        
        sPassword = reqForm("txtPassword")
        sConPass = reqForm("txtConPass")
         
        if sModeSub = "up" Then
            
            sSQL = "UPDATE BROPASS SET "             
            
            if sPassword <>"" then
                sSQL = sSQL & "PASSWORD = '" & (pPassConv(sPassword)+CLng(Now - CDate("01/01/1980"))) & "',"
                sSQL = sSQL & "DATELASTUSE ='" & fDatetime2(Now()) & "',"
            end if
            
            sSQL = sSQL & "DATEUPDT = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & " WHERE ID = '" & sUser_ID & "'"
            conn.execute sSQL
            
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtUser_ID=" & sUser_ID & "")

         End If 
    End If   
        
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
                <h1>User Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="chgpass.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <input type="hidden" name="txtUser_ID" value='<%=sUser_ID%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">User ID : </label>
                                        <div class="col-sm-7">
                                            <%if sUser_ID <> "" then %>
                                            <span class="mod-form-control"><% response.write sUser_ID %></span>
                                            <%else%>
                                            <input class="form-control" name="txtID" value="<%=sID%>" maxlength="6" style="text-transform: uppercase"/>
                                            <%end if%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">New Password : </label>
                                        <div id="divPassword" class="col-sm-4">
                                            <div class="input-group">
                                                <input id="txtPassword" name="txtPassword" type="password" 
                                                       class="form-control" maxlength="30" onfocus="clearBoth('Password','Confirm');" >
                                                <div class="input-group-addon">
                                                    <span toggle="#txtPassword" class="far fa-eye toggle-password"></span>
                                                </div>
                                            </div>
                                            <span id="errorPassword" class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Confirm Password : </label>
                                        <div id="divConfirm" class="col-sm-4">
                                            <div class="input-group">
                                                <input id="txtConfirm" name="txtConfirm" type="password" 
                                                       class="form-control" maxlength="30" onfocus="clearBoth('Password','Confirm');">
                                                <div class="input-group-addon">
                                                    <span toggle="#txtConfirm" class="far fa-eye toggle-password"></span>
                                                </div>

                                            </div>
                                            <span id="errorConfirm" class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sUser_ID <> "" then %>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkPass();">Update</button>
                                        <button type="submit" id="btnSubmit" name="sub" value="up" class="btnSaveHide" ></button>
                                    <%else %>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkPass();">Save</button>
                                        <button type="submit" id="btnSubmit" name="sub" value="save" class="btnSaveHide" ></button>
                                    <%end if %>
                                    
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="exampleModalLabel"></h4>
                            </div>
                            <div class="modal-body">
                                <div id="content4">
                                    <!--- Content ---->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade bd-example-modal-lg" id="modal-deluser" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="exampleModalLabel2"></h4>
                            </div>
                            <div class="modal-body">
                                <div id="deluser-content">
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

    //=== Show and unshow password
    $(".toggle-password").click(function () {
        $(this).toggleClass("fa-eye fa-eye-slash");
        var input = $($(this).attr("toggle"));
        if (input.attr("type") == "password") {
            input.attr("type", "text");
        } else {
            input.attr("type", "password");
        }
    });

    function checkPass(){

        if ($("#txtPassword").val() == "") {
        
            document.getElementById("divPassword").className += ' has-error'
            document.getElementById("errorPassword").innerHTML = "Password cannot be empty "
            return false;

        }else if($("#txtConfirm").val() == ""){
        
            document.getElementById("divConfirm").className += ' has-error'
            document.getElementById("errorConfirm").innerHTML = "Confirm Password cannot be empty"
            return false;

        }else if($("#txtPassword").val() != $("#txtConfirm").val()) {
        
            document.getElementById("divPassword").className += ' has-error'
            document.getElementById("errorPassword").innerHTML = "Password does not match"
            document.getElementById("divConfirm").className += ' has-error'
            document.getElementById("errorConfirm").innerHTML = "Password does not match"
            return false;

        } else {

             $('#btnSubmit').click();
        }
    }

    //=== Remove validation messages when a text-field is onfocus
    function clearError(FieldName) {
        $("#div" + FieldName).removeClass('has-error');
        $("#error" + FieldName).html("");
    };

    function clearBoth(FieldName1, FieldName2) {
        $("#div" + FieldName1).removeClass('has-error');
        $("#error" + FieldName1).html("");
        $("#div" + FieldName2).removeClass('has-error');
        $("#error" + FieldName2).html("");

    };
</script>
</body>
</html>
