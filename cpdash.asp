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

<%
    sSearch = request("txtSearch")
    iPage = request("page") 
%>

</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
      
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cp.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Dash Board</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box">
							<h3 style="color:#3c8dbc; margin:20px 0px 0px 20px;">Pending Reservation</h3>
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <div id="pend">
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
            <section class="content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box">
							<h3 style="color:#3c8dbc; margin:20px 0px 0px 20px;">Approved Reservation</h3>
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <div id="app">
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
            <section class="content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box">
							<h3 style="color:#3c8dbc; margin:20px 0px 0px 20px;">Rejected Reservation</h3>
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <div id="rej">
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
            showApp('page=1');
            showPend('page=1');
            showRej('page=1');
            });
    </script>

   <script>
    function showApp(str) {
  	    var xhttp;
  	
  	    if (str.length == 0) { 
    	    document.getElementById("app").innerHTML = "";
    	    return;
  	    }
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("app").innerHTML = xhttp.responseText;
    	    }
  	    };
  	
  	    xhttp.open("GET", "ajax/ax_cpapp.asp?"+str, true);
  	    xhttp.send();
    }
    
    function showPend(str) {
  	    var xhttp;
  	
  	    if (str.length == 0) { 
    	    document.getElementById("pend").innerHTML = "";
    	    return;
  	    }
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("pend").innerHTML = xhttp.responseText;
    	    }
  	    };
  	
  	    xhttp.open("GET", "ajax/ax_cppend.asp?"+str, true);
  	    xhttp.send();
    }

    function showRej(str) {
  	var xhttp;
  	
  	if (str.length == 0) { 
    	document.getElementById("rej").innerHTML = "";
    	return;
  	}
  	xhttp = new XMLHttpRequest();
  	xhttp.onreadystatechange = function() {
    	if (xhttp.readyState == 4 && xhttp.status == 200) {
      	document.getElementById("rej").innerHTML = xhttp.responseText;
    	}
  	};
  	
  	xhttp.open("GET", "ajax/ax_cprej.asp?"+str, true);
  	xhttp.send();
    }

    function go(str) {
          window.location=(str);
        }

    </script>

</body>
</html>
