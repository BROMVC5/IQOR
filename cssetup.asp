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
	    dCoupon = reqForm("txtCoupon")
    	sNmStart = reqForm("txtNmStart")
    	sNmEnd = reqForm("txtNmEnd")
	    sServerIp = reqForm("txtServerIp")
	    sCounter = reqForm("txtCounter")
        sOffMode = reqForm("sOffMode")
		
		sCheckdtNmStart = InStr( sNmStart, "_" )
		sCheckdtNmEnd = InStr( sNmEnd, "_" )
		
		if sCheckdtNmStart <> "0" then
			call alertbox("Start Invalid Format")
		end if
		
		if sCheckdtNmEnd <> "0" then
			call alertbox("End Invalid Format")
		end if

	    if sModeSub = "save" Then

            if sNmStart = "" then
		    call alertbox("Start cannot be empty")
		    end if
		
		    if sNmEnd = "" then
		        call alertbox("End cannot be empty")
		    end if

            if sNmEnd <= sNmStart then
                call alertbox("Invalid Time")
            end if
	    
	    	Set rstCSPath = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from cspath "
            rstCSPath.Open sSQL, conn, 3, 3		            
            if not rstCSPath.eof then
            
                sSQL = "UPDATE cspath SET "                      
	            sSQL = sSQL & "COUPON = '" & pFormat(dCoupon,2) & "',"
	            sSQL = sSQL & "N_STIME = '" & sNmStart & "',"
	            sSQL = sSQL & "N_ETIME = '" & sNmEnd & "',"
	            sSQL = sSQL & "SERVERDIR = '" & sServerIp & "',"
	            sSQL = sSQL & "COUNTER = '" & sCounter & "',"
	           	sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"       
	            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
                sSQL = sSQL & "OFF_MODE = '" & sOffMode & "'"
	            conn.execute sSQL
					
 			else
 				     			
		        sSQL = "insert into cspath ( COUPON, N_STIME, N_ETIME, E1_STIME, E1_ETIME,"
	            sSQL = sSQL & " E2_STIME, E2_ETIME, USER_ID, DATETIME) "
			    
	            sSQL = sSQL & "values ("
			    sSQL = sSQL & "'" & pFormat(dCoupon,2) & "',"
			    sSQL = sSQL & "'" & sNmStart & "',"
			    sSQL = sSQL & "'" & sNmEnd & "',"
			    sSQL = sSQL & "'" & session("USERNAME") & "'," 
			    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	 	  	    conn.execute sSQL
		 	  	     
	        end if  
            call pCloseTables(rstCSPath)
			
			call alertbox("Update Successful")
	    
		elseif sModeSub = "optimize" then
			
			sSQL = "OPTIMIZE TABLE csemply, csemply1, cstrns"
			conn.execute sSQL
			
 			Dim objFSO, objFile, objFolder
			Dim fs
			
			Set fs=Server.CreateObject("Scripting.FileSystemObject")
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			Set objFolder = objFSO.GetFolder(Server.MapPath("EXCEL"))
			
			on error resume next
			For Each objFile in objFolder.Files
				sFile = objFile.Name
				fs.DeleteFile(Server.MapPath("EXCEL\" & sFile))
			Next
			Set objFolder = Nothing
			Set objFSO = Nothing
			
			call alertbox("Optimize Successful")
			
	    end if
	end if
	
	Set rstCSPath = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from cspath" 
    rstCSPath.Open sSQL, conn, 3, 3
    if not rstCSPath.eof then

    	dCoupon = rstCSPath("COUPON")
    	sNmStart = rstCSPath("N_STIME")
    	sNmEnd = rstCSPath("N_ETIME")     
    	sServerIp = rstCSPath("SERVERDIR")
    	sCounter = rstCSPath("COUNTER")    
        sOffMode = rstCSPath("OFF_MODE")
    end if
    pCloseTables(rstCSPath)
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->

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
                        	<form class="form-horizontal" action="cssetup.asp" method="post">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">

	                        	  <!-- Default Coupon -->
                              	  <h3>Normal</h3>
	                              <div class="form-group">
	                                <label class="col-sm-3 control-label">Default Subsidy : </label>
	                                <div class="col-sm-2">
	                                    <input  class="form-control" id="txtCoupon" name="txtCoupon" value="<%=server.htmlencode(pFormatDec(dCoupon,2))%>" maxlength="5" placeholder="RM" onkeypress='return isNumberKey(event)' style="text-align:right;" >
	                                </div>
	                              </div>
	                              
                              	  <!-- Normal Start -->
	                              <div class="form-group">
                                        <label class="col-sm-3 control-label">Start : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtNmStart" name="txtNmStart" value='<%=sNmStart%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask >
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                  
                                  <!-- Normal End -->
	                              <div class="form-group">
                                        <label class="col-sm-3 control-label">End : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtNmEnd" name="txtNmEnd" value='<%=sNmEnd%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                  
								<!-- Setting -->
								<h3>Setting</h3>
 								<!-- Server Setting -->
								<div class="form-group">
									<label class="col-sm-3 control-label">Server IP ; Database : </label>
								<div class="col-sm-6">
									<input  class="form-control" id="txtServerIp" name="txtServerIp" value="<%=sServerIp%>" maxlength="50" >
								</div>
								</div>

                                <div class="form-group">
									<label class="col-sm-3 control-label">Counter : </label>
								<div class="col-sm-2">
									<input  class="form-control" id="txtCounter" name="txtCounter" value="<%=sCounter%>" maxlength="3">
								</div>
								</div>

                                <div class="form-group">
										<label class="col-sm-3 control-label">Offline Mode : </label>
								<div class="col-sm-2">
				                             	<select id="sOffMode" name="sOffMode" class="form-control">
	                                                <option value="Y" <%if sOffMode = "Y" then%>Selected<%end if%>>Yes</option>
                                                	<option value="N" <%if sOffMode = "N" then%>Selected<%end if%>>No</option>
                                            	</select>
                                        </div>
								</div>
             
                                	
								 <!-- Footer Button -->
                                 <div class="box-footer">
									<button type="submit" name="sub" value="optimize" class="btn btn-warning " style="width: 95px">Optimize</button>
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
