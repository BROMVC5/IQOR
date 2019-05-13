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
	<!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
    <%
	
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "vrpurge.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage 
                
    if sModeSub <> "" Then
        
		dtFrDate = reqForm("dtpFrDate")
		dtToDate = reqForm("dtpToDate")
		sTemp = datediff("d",dtFrDate,dtToDate)
        
		if dtFrDate = "" then
		    call alertbox("Date From cannot be empty")
		end if
		
		if dtToDate = "" then
		    call alertbox("Date To cannot be empty")
		end if
		
		if sTemp < 0 then
			 call alertbox("Date to cannot smaller then Date From")
		end if
				
        if sModeSub = "purge" Then
		
			sSQL = "delete from vrvend where DT_CREATE between '" & fdate2(dtFrDate) & " 00:00:00' and '" & fdate2(dtToDate) & " 23:59:59'"
			conn.execute sSQL
			
			call confirmBox("Purged Successful!", sMainURL&sAddURL)
        end if
    End If
         
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_vr.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Vendor Data Purging</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="vrpurge.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <br>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
										<!--Date-->
										<label class="col-sm-2  control-label">Date From: </label>
										<div class="col-sm-3">
											<div class="input-group">
												<input id="dtpFrDate" name="dtpFrDate" value="<%=fDatelong(dtFrDate)%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_Frdate" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>
										
										<label class="col-sm-2  control-label">Date To : </label>
										<div class="col-sm-3">
											<div class="input-group">
												<input id="dtpToDate" name="dtpToDate" value="<%=fDatelong(dtToDate)%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>
									</div>
                                </div>
                                <div class="box-footer">
									<button type="submit" name="sub" value="purge" class="btn btn-info pull-right" style="width: 90px">Purge</button>
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal fade in" id="modal-delcomp" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="exampleModalLabel"></h4>
                            </div>
                            <div class="modal-body">
                                <div id="del-content">
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
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
	<!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
	
	<script>
	
	$('#btndt_Frdate').click(function () {
		$('#dtpFrDate').datepicker("show");
	});
	
	$('#btndt_Todate').click(function () {
		$('#dtpToDate').datepicker("show");
	});

	$(function () {        
	   $("[date-picker]").datepicker({
			format: "dd/mm/yyyy",
			autoclose: true,
			})
	});
	
    </script>

</body>
</html>
