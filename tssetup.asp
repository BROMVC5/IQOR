<!DOCTYPE html>
<html>

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
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI CSS -->
    <link href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" rel="stylesheet" type="text/css" />
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
	
	if sModeSub <> "" Then
		sCutOff = reqForm("txtCutOff") 
		sSendMail = reqForm("cboSendMail")
		
		sCheckdtCutOff = InStr( sCutOff, "_" )
		
		if sCheckdtCutOff <> "0" then
			call alertbox("Cut off time Invalid Format")
		end if
 
	    if sModeSub = "save" Then
	    
	    	Set rstTSPath = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tspath "
            rstTSPath.Open sSQL, conn, 3, 3		            
            if not rstTSPath.eof then
            
                sSQL = "UPDATE tspath SET "                      
	            sSQL = sSQL & "DT_CUT = '" & sCutOff & "',"
	            sSQL = sSQL & "SENDMAIL = '" & sSendMail & "',"
	            sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"       
	            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
	            conn.execute sSQL
				
				call alertbox("Update Successful")
					
 			else
 				     			
		        sSQL = "insert into tspath (DT_CUT, SENDMAIL, "
	            sSQL = sSQL & "CREATE_ID, DT_CREATE , USER_ID, DATETIME) "
	            sSQL = sSQL & "values ("
			    sSQL = sSQL & "'" & sCutOff & "',"
			    sSQL = sSQL & "'" & sSendMail & "',"
			    sSQL = sSQL & "'" & session("USERNAME") & "'," 
			    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
			    sSQL = sSQL & "'" & session("USERNAME") & "'," 
			    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	 	  	    conn.execute sSQL
	 	  	    
		 	  	call alertbox("Update Successful")
	        end if  
            call pCloseTables(rstTSPath)
	    
	    end if
	end if
	
	Set rstTSPath = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from tspath" 
    rstTSPath.Open sSQL, conn, 3, 3
    if not rstTSPath.eof then

    	sCutOff = rstTSPath("DT_CUT") 
		sSendMail = rstTSPath("SENDMAIL")  
    
            
    end if
    pCloseTables(rstTSPath)
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ts.asp" -->

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
                        	<form class="form-horizontal" action="tssetup.asp" method="post">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">

	                        	  <!-- Default Coupon -->
                              	   <div class="form-group">
                                        <label class="col-sm-3 control-label">Cut Off Time : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                 <input id="txtCutOff" name="txtCutOff" value='<%=fTime(sCutOff)%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask >
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Send Mail -->
                                    <div class="form-group">
										
											<label class="col-sm-3 control-label">Send Mail : </label>
										
										<div class="col-sm-3">
				                             	<select id="cboSendMail" name="cboSendMail" class="form-control">
	                                                <option value="Y" <%if sSendMail = "Y" then%>Selected<%end if%>>Yes</option>
                                                	<option value="N" <%if sSendMail = "N" then%>Selected<%end if%>>No</option>
                                            	</select>
                  
                                            </div>
									</div>

	                              
                              	                                 	
								 <!-- Footer Button -->
                                 <div class="box-footer">
									<button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>                                 
                                 </div>
                            	 <!-- /.box-footer -->
                                	
							   </div>
							   <!-- /.body end -->  
						   	</div>
							  <!-- /.box info end -->
					 		</form>
						 	 <!-- /.form end -->
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
    
   
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
     <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

    <!--Script Start-->
    
    <!--check numeric-->
    <script>
	 function isNumberKey(evt) {
     var charCode = (evt.which) ? evt.which : evt.keyCode;
     if (charCode != 46 && charCode > 31 
       && (charCode < 48 || charCode > 57))
        return false;
  
      return true;
 	} 
 	
 	$(document).ready(function() {
		$("#txtCoupon").keydown(function (e) {
			// Allow: backspace, delete, tab, escape, enter and .
			if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
				 // Allow: Ctrl+A, Command+A
				(e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || 
				 // Allow: home, end, left, right, down, up
				(e.keyCode >= 35 && e.keyCode <= 40)) {
					 // let it happen, don't do anything
					 return;
			}
			// Ensure that it is a number and stop the keypress
			if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
				e.preventDefault();
			}
		});
	});
	
	$('#txtCoupon').keyup(function () {
		if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
       this.value = this.value.replace(/[^0-9\.]/g, '');
		}
	});

    </script>
  		
	<script>
    $(function () {

        //Time mask
        $("[data-mask]").inputmask();
    
    });

    
    </script>

	<!--Script End-->
	

</body>
</html>
