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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" />

    <%
    sSearch = request("txtSearch")
    iPage = request("page") 
	
	Set rstvrTrns = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select COUNT(DT_IN) AS CheckIn,COUNT(DT_OT) AS CheckOut from vrtrns "
    sSQL = sSQL & "where DT_IN LIKE '" & fDate2(Now()) & "%'"
    rstvrTrns.Open sSQL, conn, 3, 3
    if not rstvrTrns.eof then
    
        dt_checkIn = rstvrTrns("CheckIn")
        dt_checkOut = rstvrTrns("CheckOut")
           
    end if
    pCloseTables(rstvrTrns) 
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">

        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_vr.asp" -->

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
                        </div>
                    	<!-- Small boxes (Stat box) -->
				        <div class="col-lg-3 col-xs-6">
				          <!-- small box -->
				          <div class="small-box bg-green">
				            <div class="inner">
				              <h3>In : <% response.write dt_checkIn %></h3>
				
				              <p>Today's Total Check In</p>
				            </div>
				            <div class="icon">
				              <i class="fa fa-sign-in"></i>
				            </div>
				            <a href="vrreport.asp?type=VR" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
				          </div>
				        </div>
				        <!-- ./col --> 
				        
						<div class="col-lg-3 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-red color-palette">
						    <div class="inner">
						      <h3>Out : <% response.write dt_checkOut %></h3>
						
						      <p>Today's Total Check Out</p>
						    </div>
						    <div class="icon">
						      <i class="fa fa-sign-out"></i>
						    </div>
						    <a href="vrout.asp" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
						  </div>
						</div>
						<!-- ./col -->
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
                                        
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

                                    </div>
                                </form>
                                <div id="content2">
                                    <!-- CONTENT HERE -->
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                        <!-- /.box -->
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


</body>
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

</html>
