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
	sBadge_No = UCase(request("txtBadge_No"))
	sRmark = request("txtRmark")
	
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "vrout.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage 
	
    if sModeSub <> "" Then 
		sBadge_No = reqForm("txtBadge_No")
		sRmark = reqForm("txtRmark")

		if sBadge_No = "" then
		    call alertbox("Badge No cannot be empty")
		end if
		
		if sModeSub = "Cout" Then
            
            sSQL = "UPDATE vrtrns SET "             
			sSQL = sSQL & "GD_OT = '" & session("USERNAME") & "',"
			sSQL = sSQL & "DT_OT = '" & fdatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
			sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "',"
			sSQL = sSQL & "REMARK = '" & pRTIN(sRmark) & "'"
            sSQL = sSQL & "WHERE BADGE_NO = '" & sBadge_No & "'"
            conn.execute sSQL
        
            call confirmBox("Check Out Successful!", sMainURL&sAddURL&"&txtBadge_No=" & sBadge_No & "")	
		end if
    End If
          
    Set rstVRIn = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from vrtrns where BADGE_NO ='" & sBadge_No & "'" 
    rstVRIn.Open sSQL, conn, 3, 3
        if not rstVRIn.eof then
            sBadge_No = rstVRIn("BADGE_NO")
        end if
    pCloseTables(rstVRIn)
        
    %>
</head>
<body class="hold-transition skin-blue sICebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left sICe column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_vr.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Check Out</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="vrout_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
								<div class = "box-body">
								</div>
                                <!-- /.box-header -->
                                <div class="box-body">
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Badge No : </label>
                                        <div class="col-sm-3">
											<span class="mod-form-control"><% response.write sBadge_No %> </span>
                                            <input type="hidden" id="txtBadge_No" name="txtBadge_No" value='<%=sBadge_No%>' />
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Remark : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" id="txtRmark" name="txtRmark" value="<%=server.htmlencode(sRmark)%>" maxlength="50">
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sBadge_No<> "" then %>
                                        <button type="submit" name = "sub" value="Cout" class="btn btn-danger pull-right" style="width: 90px">Check Out</button>
                                    <%else %>
                                        <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
                                    <%end if %>
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
                        </form>
                    </div>
                </div>
				<div class="modal fade bd-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                            </div>
                            <div id="mycontent">
                                <!--- Content ---->
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

    <script>

    $(document).ready(function(){
        document.getElementById('txtRmark').focus();
        }); 
    </script>
	<script>
    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }
    
    </script>

</body>
</html>
