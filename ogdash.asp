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
    
	Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select count(TICKET_NO) as TodayReq from ogprop "
    sSQL = sSQL & "where DT_CREATE LIKE '" & fDate2(Now()) & "%'"
    rstOGProp.Open sSQL, conn, 3, 3
    if not rstOGProp.eof then
    	iTodayReq = rstOGProp("TodayReq")         
    end if
    pCloseTables(rstOGProp) 
    
    Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select count(TICKET_NO) as TotalPend from ogprop "
    sSQL = sSQL & "where STATUS = 'P' "
    rstOGProp.Open sSQL, conn, 3, 3
    if not rstOGProp.eof then
    	iTodayPend = rstOGProp("TotalPend")         
    end if
    pCloseTables(rstOGProp)
    
    Set rstOGProp1 = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select count(ogprop1.TICKET_NO) as TotalOver,ogprop.STATUS, ogprop.SSTATUS, ogprop1.*  from ogprop1 "
    sSQL = sSQL & "left join ogprop on ogprop1.TICKET_NO = ogprop.TICKET_NO "	
    sSQL = sSQL & "where DT_RETURN IS NULL and DT_DUE < '"& fDate2(Now()) & "' "
    sSQL = sSQL & "and STATUS = 'A' and SSTATUS = 'A' "
    rstOGProp1.Open sSQL, conn, 3, 3 
    if not rstOGProp1.eof then
    	iTotalOver = rstOGProp1("TotalOver")         
    end if
    pCloseTables(rstOGProp1)

%>

        
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">

        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_og.asp" -->

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
                    	<!-- Small boxes (Stat box) -->
				        
				          <!-- small box -->
				          <div class="col-lg-4 col-xs-6">
				          <div class="small-box bg-aqua">
				            <div class="inner">
				              <h3><% response.write iTodayReq %></h3>
				
				              <p>Today's request</p>
				            </div>
				            <div class="icon">
				              <i class="ion ion-android-person"></i>
				            </div>
				            <a href="oglist.asp" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
				          </div>
				        </div>
				        <!-- ./col --> 
				        
						
						<!-- small box -->
						<div class="col-lg-4 col-xs-6">
						<div class="small-box bg-orange color-palette">
						    <div class="inner">
						      <h3><% response.write iTodayPend %></h3>
						
						      <p>Total Pending</p>
						    </div>
						    <div class="icon">
						      <i class="ion ion-load-a"></i>
						    </div>
						    <a href="oglist.asp" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
						  </div>
						</div>
						<!-- ./col --> 
						
						<!-- small box -->
						<div class="col-lg-4 col-xs-6">
						<div class="small-box bg-red color-palette">
						    <div class="inner">
						      <h3><% response.write iTotalOver %></h3>
						
						      <p>Total Overdue</p>
						    </div>
						    <div class="icon">
						      <i class="ion ion-thumbsdown"></i>
						    </div>
						    <a href="ogreport.asp?type=OD" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
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

                                    </div>
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
