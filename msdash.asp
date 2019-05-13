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
    sSQL = "select COUNT(CLAIMA) AS ClaimA, SUM(CLAIMA) AS TotalC from msstaffc "
	sSQL = sSQL & "WHERE MID(DT_ATTEND,1,10) BETWEEN '" & Mid(fdate2(DateSerial(Year(now()), Month(now()), 1)),1,10) & "' AND '" & Mid(fdate2(DateSerial(Year(now()), Month(now()), 31)),1,10) & "' "
    rstvrTrns.Open sSQL, conn, 3, 3

    if not rstvrTrns.eof then
    
        ClaimA = rstvrTrns("ClaimA")
		TotalC = rstvrTrns("TotalC")
		
           
    end if
    pCloseTables(rstvrTrns) 
    %>
	<%
		m = Month(now())
		y = Year(now())
	%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">

        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ms.asp" -->

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
				        <div class="col-lg-6 col-xs-6">
				          <!-- small box -->
				          <div class="small-box bg-green">
				            <div class="inner">
				              <h3><% response.write ClaimA %></h3>
				
				              <p>Person Claim in <%response.write(MonthName(m)) & " "  %><%response.write(y)%></p>
				            </div>
				            <div class="icon">
				              <i class="fa fa-user"></i>
				            </div>
				          </div>
				        </div>
				        <!-- ./col --> 
				        
						<div class="col-lg-6 col-xs-6">
						<!-- small box -->
						<div class="small-box bg-red color-palette">
						    <div class="inner">
						      <h3>RM<% response.write pFormatDec(TotalC,2) %></h3>
						
						      <p>Total Claim's Amount in <%response.write(MonthName(m)) & " "  %><%response.write(y)%></p>
						    </div>
						    <div class="icon">
						      <i class="fa fa-dollar"></i>
						    </div>
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
