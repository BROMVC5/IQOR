<% Server.ScriptTimeout = 1000000 %>
<!DOCTYPE html>
<html>

    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <head>

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
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
<%
  	sModeSub = request("sub")
    sMainURL = "msimportclaim_ext.asp?"
%>


	</head>


<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ms.asp" -->
		<!-- #include file="include/clsUpload.asp" -->
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Import Claim History</h1>
            </section>
            <!-- Main content -->
            <section class="content">
            	  <!--/row -->
                <div class="row">
                	   <!-- col-md-12 -->
                    <div class="col-md-12">
                        <!-- form start -->
                        <form class="form-horizontal" action="msimportclaim.asp" ENCTYPE="multipart/form-data" method="post">
                        	<!-- box box-info -->
                            <div class="box box-info">
                                <!-- box body -->
                                <div class="box-body">
									<!-- form group -->
                                   <div class="form-group">
										<label class="col-sm-3 control-label">File Name : </label>
										<div class="col-sm-3">
											<input type ="file" name="txtFile" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style = "margin-top:5px;">
                                        </div>
                                   </div>
                                   <!--/.form group -->
								   <!-- form group -->
                                   <div class="form-group">
										<label class="col-sm-5 control-label"><font color = "red">* Please upload the file format .csv</font></label>
                                   </div>
                                   <!--/.form group -->						
	                                   
								   </div>

									<!-- box-footer -->
									<div class="box-footer"> 
										<input name="btnSubmit" style = "width:90px;" align="right" type="submit" value='      Upload      ' class="btn btn-info pull-right" onclick="javascript:if (confirm('Are you sure you want to procced?')==0) {return false}">
										<!-- Coupon -->
	                                </div>
	                                <!-- /.box-footer -->
	                                
                                </div>
                                <!--/.box body-->
                            </div>
                            
                            <!-- /.box box-info -->
                        </form>
                        <!-- form end -->
                    </div>
                    <!--/.col-md-12 -->
                </div>
                <!--/.row -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->
    
     <!--mymodal start-->   
    <div class="modal fade bd-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel"></h4>
                </div>
                <div class="modal-body">
                    <div id="mycontent">
                        <!---mymodal content ---->
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!--mymodal end-->

	<!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

<%
	set o = new clsUpload

	if o.Exists("btnSubmit") then
	
	'get client file name without path
	
	dtTemp = year(now) & right("00" & month(now),2) & day(now) & hour(now) & minute(now) & second(now)
	
	sFileSplit = split(o.FileNameOf("txtFile"), ".")
	sFileType = sFileSplit(Ubound(sFileSplit))

	sFile = dtTemp & "." & sFileType

		if o.Field("txtFile" & i).FileName <> "" then
		
			sFileTo = Server.MapPath(".") & "\EXCEL\MS\"
			
			Dim fs 
			Set fs = CreateObject("Scripting.FileSystemObject")
			For Each File In fs.GetFolder(sFileTo).Files
				If fs.GetExtensionName(File) = "xls" or fs.GetExtensionName(File) = "xlsx" or fs.GetExtensionName(File) = "xlsm" or fs.GetExtensionName(File) = "xlsb" or fs.GetExtensionName(File) = "csv" Then
					fs.DeleteFile File
				End If
			Next
		
			o.FileInputName = "txtFile"
			o.FileFullPath = Server.MapPath(".") & "\EXCEL\MS\" & sFile
			o.save
			
			if o.Error = "" then
				'response.write "Success. File saved to  " & o.FileFullPath & ". "
				
				sFL = replace(sFile,".zip","")
				call confirmBox("Save Successful!", sMainURL&"txtFileName="& sFile)  
				
				' ssql= "SELECT * FROM SFNEWS WHERE REFNO = '" & sRef & "'"
				' Set rstSFNEWS = Server.CreateObject("ADODB.Recordset")
				' rstSFNEWS.Open sSQL, conn, 3, 3
				' if not rstSFNEWS.bof then 
					' ssql = "UPDATE SFNEWS SET IMAGE= '" & sFile & "',"
					' ssql = ssql & "DATETIME = '" & fDatetime2(Now()) & "',"
					' ssql = ssql & "USER_ID = '" & session("USERNAME") & "'"
					' ssql = ssql & " WHERE REFNO = '" & sRef & "'"
					' conn.execute ssql
				' end if 

			else
				response.write "Failed due to the following error: " & o.Error
			end if
		else
			call alertbox("Please insert a file")
		end if
	end if
	set o = nothing
%>
</body>
</html>
