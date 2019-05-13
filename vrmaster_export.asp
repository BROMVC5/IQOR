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
	sType = request("txtType")
    sMainURL = "vrmaster_export.asp?"
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_vr.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
            <%if sType = "CP" then %>
                <h1>Export Company Maintenance</h1>
			<%elseif sType = "VD" then %>
				<h1>Export Vendor Maintenance</h1>
            <%end if%>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form name="Form1" class="form-horizontal" action="vrmaster_export.asp" method="post">
                        	<input type="hidden" name="txtType" id="txtType" value="<%=sType%>">
                            <div class="box box-info">   
								<%if sType = "CP" then%>
								   <!--body start-->
								   <div class="box-body">
									   <!-- form group -->
										<div class="form-group">
									   <!--Department-->
										   <label class="col-sm-3 control-label">Company Name : </label>
											<div class="col-sm-5">
												<div class="input-group">
												   <input class="form-control" id="txtComp_Name" name="txtComp_Name" value="<%=sCompID%>" maxlength="50" style="text-transform: uppercase" placeholder="Empty For All" input-check  >
												   <span class="input-group-btn">
														<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('COMP','txtComp_Name','mycontent','#mymodal')">
														   <i class="fa fa-search"></i>
														</a>
												   </span>
											   </div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">Status :</label>
											<div class="col-sm-3">
												<select name="sStatus" id = "sStatus" class="form-control">
													<option value="" selected="selected">ALL</option>
													<option value="Y" <%if sStatus = "Y" then%>Selected<%end if%>>Active</option>
													<option value="N" <%if sStatus = "N" then%>Selected<%end if%>>Inactive</option>
												</select>
											</div>
										</div>
									</div>
								
									 <!-- Footer Button -->
									 <div class="box-footer">
										 <button type="button" name="sub" value="reset" class="btn btn-info" style="width: 94px" onclick="txtReset();">Clear</button>
										 <button type="button" name="sub" value="print" class="btn bg-green-active pull-right" style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
									 </div>
									 <!-- /.box-footer -->
								<%end if%>    	
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

    
   <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
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
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

    <!--Script Start-->
    <!--date picker-->
    <script>
	
	$(document).ready(function(){
        document.getElementById('txtEmp_ID').focus();
    }); 
    </script>
	<script>
	
    function fOpen(pType,pFldName,pContent,pModal) {
		document.getElementById(pContent).innerHTML = ""
		showDetails('page=1',pFldName,pType,pContent)
		$(pModal).modal('show');
	}
	
	function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');        
    }
    
    function showDetails(str,pFldName,pType,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };
  	    
		if (pType=="COMP") { 
            var search = document.getElementById("txtSearch_comp");
        }
		
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
			
		if (pType=="COMP") {
	  	    xhttp.open("GET", "ajax/ax_view_compid.asp?"+str, true);
	  	}
		
  	    xhttp.send();
    }
	 
	</script>
  		
	<!--Reset Button-->
    <script>
	function txtReset()
	{
		document.getElementById("txtComp_Name").value = "";
		document.getElementById("sStatus").value = "";
	}
	</script>
	
	<!--open modal-->
	
	<!--Print Button-->
	
	<script>
	
	function exportReport() {

	   var sURL = "";
		
		sType = Form1.txtType.value;
		sCompID = Form1.txtComp_Name.value;
		sStatus = Form1.sStatus.value; 

		sURL= "txtType=" + sType + "&" ;
	    sURL= sURL + "txtComp_Name=" + sCompID + "&" ;
	    sURL= sURL + "sStatus=" + sStatus + "&";

	    window.open("vrmain_export.asp?" + sURL);
	 }
	 
	$( "#txtComp_Name" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CI",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtComp_Name").val(ui.item.value);
				var str = document.getElementById("txtComp_Name").value;
				var res = str.split(" | ");
				document.getElementById("txtComp_Name").value = res[0];
			},0);
		}
	});	
	</script>


	<!--Script End-->
	

</body>
</html>
