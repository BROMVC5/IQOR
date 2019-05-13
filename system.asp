<%@ LANGUAGE = VBScript.Encode %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #inlcude file="include/validate.asp" -->

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>IQOR</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css" />
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css" />
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI CSS -->
    <link href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <!--<script src="dist/js/pages/dashboard.js"></script>-->
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap 3.3.6 CSS-->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />

</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- Content Wrapper. Contains page content -->
        <div>
            <header class="main-header">
                <!-- Logo -->
                <a href="system.asp" class="logo">
                    <!-- mini logo for sidebar mini 50x50 pixels -->
                    <span class="logo-mini"><img src="dist/img/iqor-icon-30x30.png"/></span>
                    <!-- logo for regular state and mobile devices -->
                    <span class="logo-lg"><img src="dist/img/iqor-logo-white-109x35.png"/></span>
                </a>

                <!-- Header Navbar: style can be found in header.less -->
                <nav class="navbar navbar-static-top">
                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">
                            <!-- User Account: style can be found in dropdown.less -->
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <img src="dist/img/user2-160x160.png" class="user-image" alt="User Image">
                                    <span class="hidden-xs"><%=#@~^DwAAAA==d/dbW	`Jgbt3J*ugQAAA==^#~@%></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <!-- User image -->
                                    <li class="user-header">
                                        <img src="dist/img/user2-160x160.png" class="img-circle" alt="User Image">
                                        <p>
                                            <font size="2">Welcome <%=#@~^DwAAAA==d/dbW	`Jgbt3J*ugQAAA==^#~@%></font>
                                            <br />
                                            <a href="broprofile.asp" class="btn btn-info">View Profile</a>
                                        </p>
                                        <p id="demo"></p>
                                    </li>
                                    <!-- Menu Body -->
                                    <!-- Menu Footer-->
                                    <li class="user-footer">
                                        <div class="pull-left">
                                            <a href="chgpass.asp" class="btn btn-default btn-flat">Change Password</a>
                                        </div>
                                        <div class="pull-right">
                                            <a href="login.asp" class="btn btn-default btn-flat">Sign out</a>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                            <!-- Control Sidebar Toggle Button -->
                            <%#@~^dAEAAA==~,?nDPM/Y~I}KbU?~',/n.7+Dc/DlY68LmD`Eb96GA I^WMNjnDJ#~~,P@#@&,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PPkj}S,',Jd+sn1Y~e,WDK:~$"rn)jUPAt.P(G'EJPLPkn/kkGxvJijAI1z\2r#PL~EBrP@#@&~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,D/DA"6nz?jR}wnU,/?5J~,mW	USP2~,&~P~@#@&P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,r0,xGY,DdO~Irh)?UR+KW~Y4+	@#@&P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,r0,DdY~I6Kz??vEnqfHgPE#{JIJ~Y4n	GlQAAA==^#~@%>
                                        <li>
                                            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                                        </li>
                                    <%#@~^UwAAAA==n	N~b0@#@&P,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~n	N~k6@#@&,P~~,PP~~,P~P,~,P~,P,PP,P,~P,WgwAAA==^#~@%>
                        </ul>
                    </div>
                    <!--<div style="margin: 6px 0px 0px 6px;">
                        <h4 style="color:white;">IQOR</h4>
                    </div>!-->
                </nav>
            </header>
        </div>
        <div class="content-wrapper" style="margin: 0px; min-height: 1000px;">
            <!-- Content Header (Page header) -->
            <section class="content">
                <!-- Small boxes (Stat box) -->
                <div class="row">

					<%#@~^IQAAAA==r6Pd/kkW	`rP?zZ/2U?Eb,'PreJ,YtUygkAAA==^#~@%>
						<div class="col-lg-4 col-xs-4">
							<!-- small box -->
							<div class="small-box bg-red">
							<a href="tsdash.asp" style="text-decoration:none">
								<div class="inner" style="padding:10px;">
									<h3 style="color:white">TS</h3>
									<p>&nbsp;&nbsp;</p>
								</div>
								<div class="icon">
									<i class="ion ion-document"></i>
								</div>
								</a>
								<a href="tsdash.asp" class="small-box-footer">Transport System <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                    <!-- ./col -->
					<%#@~^IQAAAA==r6Pd/kkW	`r\?zZ/2U?Eb,'PreJ,YtUwwkAAA==^#~@%>
						<div class="col-lg-4 col-xs-4">
							<!-- small box -->	
							<div class="small-box bg-red" >
								<a href="msdash.asp" style="text-decoration:none">
								<div class="inner" style="padding:10px;">
									<h3 style="color:white">MS</h3>
									<p>&nbsp;&nbsp;</p>
								</div>
								<div class="icon">
									<i class="ion ion-document"></i>
								</div>
								<a href="msdash.asp" class="small-box-footer">Medical System <i class="fa fa-arrow-circle-right"></i></a>
								</a>
							</div>
						</div>
					<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                    <!-- ./col -->
					<%#@~^IQAAAA==r6Pd/kkW	`r/?zZ/2U?Eb,'PreJ,YtUuQkAAA==^#~@%>
						<div class="col-lg-4 col-xs-4">
							<!-- small box -->
							<div class="small-box bg-red">
								<a href="csdash.asp" style="text-decoration:none">
								<div class="inner" style="padding:10px;">
									<h3 style="color:white">CS</h3>
									<p>&nbsp;&nbsp;</p>
								</div>
								<div class="icon">
									<i class="ion ion-document"></i>
								</div>
								</a>
								<a href="csdash.asp" class="small-box-footer">Canteen System <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                    <!-- ./col -->
					<%#@~^IQAAAA==r6Pd/kkW	`rPHzZ/2U?Eb,'PreJ,YtUxAkAAA==^#~@%>
						<div class="col-lg-4 col-xs-4">
							<!-- small box -->
							<div class="small-box bg-aqua">
								<a href="tmdash.asp" style="text-decoration:none">
								<div class="inner" style="padding:10px;">
									<h3 style="color:white">TM</h3>
									<p>&nbsp;&nbsp;</p>
								</div>
								<div class="icon">
									<i class="ion-document"></i>
								</div>
								<a href="tmdash.asp" class="small-box-footer">Time Management <i class="fa fa-arrow-circle-right"></i></a>
								</a>
							</div>
						</div>
					<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                    <!-- ./col -->
					<%#@~^IQAAAA==r6Pd/kkW	`r#IzZ/2U?Eb,'PreJ,YtUywkAAA==^#~@%>
						<div class="col-lg-4 col-xs-4">
							<!-- small box -->
							<div class="small-box bg-aqua">
								<a href="vrdash.asp" style="text-decoration:none">
								<div class="inner" style="padding:10px;">
									<h3 style="color:white">VR</h3>
									<p>&nbsp;&nbsp;</p>
								</div>
								<div class="icon">
									<i class="ion-document"></i>
								</div>
								<a href="vrdash.asp" class="small-box-footer">Vendor Registration <i class="fa fa-arrow-circle-right"></i></a>
								</a>
							</div>
						</div>
					<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                    <!-- ./col -->
					<%#@~^IQAAAA==r6Pd/kkW	`r6MzZ/2U?Eb,'PreJ,YtUuQkAAA==^#~@%>
						<div class="col-lg-4 col-xs-4">
							<!-- small box -->
							<div class="small-box bg-aqua">
								<a href="ogdash.asp" style="text-decoration:none">
								<div class="inner" style="padding:10px;">
									<h3 style="color:white">OG</h3>
									<p>&nbsp;&nbsp;</p>
								</div>
								<div class="icon">
									<i class="ion-document"></i>
								</div>
								</a>
								<a href="ogdash.asp" class="small-box-footer">Out Going Good Pass <i class="fa fa-arrow-circle-right"></i></a>
							</div>
						</div>
					<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                    <!-- ./col -->
                
					<%#@~^IQAAAA==r6Pd/kkW	`r/nzZ/2U?Eb,'PreJ,YtUtgkAAA==^#~@%>
						<div class="col-lg-4 col-xs-4">
							<!-- small box -->
							<div class="small-box bg-green">
								<a href="cpdash.asp" style="text-decoration:none">
								<div class="inner" style="padding:10px;">
									<h3 style="color:white">CP</h3>
									<p>&nbsp;&nbsp;</p>
								</div>
								<div class="icon">
									<i class="ion ion-document"></i>
								</div>
								<a href="cpdash.asp" class="small-box-footer">Car Park Reservation <i class="fa fa-arrow-circle-right"></i></a>
								</a>
							</div>
						</div>
					<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                </div>
            </section>
        </div>

        <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark">
            <!-- Create the tabs -->
            <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
                <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
               <!-- <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>-->
            </ul>
            <!-- Tab panes -->
            <div class="control-sidebar" style="width:200px;margin: 50px 0px 0px 0px ">
                <!-- Home tab content -->
                <div class="tab-pane" id="control-sidebar-home-tab">
                    <h3 class="control-sidebar-heading">General Settings</h3>
                    <ul class="control-sidebar-menu">
                        <li>
                            <a href="bropass.asp">
                                <i class="menu-icon fa fa-gears bg-green"></i>

                                <div class="menu-info">
                                    <h4 class="control-sidebar-subheading">Maintain Password</h4>

                                    <p>To change and update password and to change access level of user</p>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="bropath.asp">
                                <i class="menu-icon fa fa-envelope bg-blue"></i>

                                <div class="menu-info">
                                    <h4 class="control-sidebar-subheading">Program Setup</h4>

                                    <p>SMTP email, SSL, Password and Port setup</p>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </aside>
        <!-- /.control-sidebar -->
        <!-- Add the sidebar's background. This div must be placed
               immediately after the control sidebar -->
        <div class="control-sidebar-bg"></div>
   </div>

    <!-- /.content-wrapper -->
    <footer class="main-footer" style="margin: 0px">
        <div class="pull-right hidden-xs">
            <b>Version</b> 1705.01
        </div>
        <strong>Copyright &copy; 2017 <a href="http://www.bro.com.my/">BRO Software House (M) Sdn Bhd</a>.</strong> All rights
    reserved.
    </footer>
  

</body>
</html>
