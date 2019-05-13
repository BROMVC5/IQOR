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
	sType = request("type")
    sMainURL = "vrreport.asp?"
         
    dtFrDate = reqForm("dtFrDate")
    dtToDate = reqForm("dtToDate")
	sCompID = reqForm("txtComp_Name")
	sDept = reqForm("txtDept_ID")
	sVend_Name = reqForm("txtVend_Name")
	sStatus = reqForm("sStatus")
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_vr.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
            <%if sType = "BL" then %>
                <h1>Print Blacklist Report</h1>
            <%elseif sType= "VR" then%>
            	<h1>Print Vendor Check In Report</h1>
            <%end if%>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form name="Form1" class="form-horizontal" action="vrprint.asp" method="post">
                        	<input type="hidden" name="txtType" id="txtType" value="<%=sType%>">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">
									<!-- form group -->
									<%if sType = "BL" then %>
									
									<!--<div class="form-group">
		                           		
				                       <label class="col-sm-3 control-label">From Date : </label>
										<div class="col-sm-3 col-lg-3">
											<div class="input-group">
												<input id="dtFrDate1" name="dtFrDate1" value="<%=fdatelong(DateSerial(Year(now()), Month(now()), 1))%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
													<a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
														<i class="fa fa-calendar"></i>
													</a>
												</span>
											</div>
										</div>
										
				                        <label class="col-sm-3 col-lg-1 control-label">To Date : </label>
										<div class="col-sm-3 col-lg-3">
											<div class="input-group">
												<input id="dtToDate1" name="dtToDate1" value="<%=fdatelong(now())%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
													<a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
														<i class="fa fa-calendar"></i>
													</a>
												</span>
											</div>
										</div>  
								   </div>-->
								   <!--/.form group -->
								   
								   <!-- form group -->
								   <div class="form-group">
										<label class="col-sm-3 control-label">NRIC/Passport : </label>
										<div class="col-sm-5">
											<input class="form-control" id="txtNRIC1" name="txtNRIC1" value="<%=sIC%>" maxlength="15" style="text-transform: uppercase" placeholder="Empty For All">
                                        </div>
								   </div>
								   <!--/.form group -->
								   <!-- form group -->
								   <div class="form-group">
										<label class="col-sm-3 control-label">Vendor Name : </label>
										<div class="col-sm-5">
											<input class="form-control" id="txtVend_Name1" name="txtVend_Name1" value="<%=sVend_Name%>" maxlength="50" style="text-transform: uppercase" placeholder="Empty For All">
                                        </div>
								   </div>
								   <!--/.form group -->
								   
								   <!-- form group -->
									<div class="form-group">
									
								   <!--Company-->
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
										<label class="col-sm-3 control-label">Blacklist :</label>
										<div class="col-sm-3">
                                            <select name="sStatus1" id = "sStatus1" class="form-control">
												<option value="Y" <%if sStatus = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sStatus = "N" then%>Selected<%end if%>>No</option>
                                                <option value="">ALL</option>
                                            </select>
										</div>
									</div>
									<!-- form group -->
									<div class="form-group">
										<!--Page Break-->
										<label class="col-sm-3 control-label">Page Break : </label>
										<div class="col-sm-3">
											<select id="cboPageBreak" name="cboPageBreak" class="form-control">
												<option value="N" <%if sType = "N" then%>Selected<%end if%>>No</option>
												<option value="Y" <%if sType = "Y" then%>Selected<%end if%>>Yes</option>
											</select>
										</div>
									</div>
									<!--/.form group -->
									<%elseif sType = "VR" then%>
									<div class="form-group">
		                           		<!--From Date-->
				                        <label class="col-sm-3 control-label">From Date : </label>
										<div class="col-sm-3 col-lg-3">
											<div class="input-group">
				                                <input id="dtFrDate2" name="dtFrDate2" value="<%=fdatelong(DateSerial(Year(now()), Month(now()), 1))%>" type="text" class="form-control" date-picker >
				                                <span class="input-group-btn">
				                                    <a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
				                                        <i class="fa fa-calendar"></i>
				                                    </a>
				                                </span>
				                            </div>
				                        </div>
				                        
										<!--To Date-->
				                        <label class="col-sm-3 col-lg-1 control-label">To Date : </label>
										<div class="col-sm-3 col-lg-3">
											<div class="input-group">
				                                <input id="dtToDate2" name="dtToDate2" value="<%=fdatelong(now())%>" type="text" class="form-control" date-picker >
				                                <span class="input-group-btn">
				                                    <a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
				                                        <i class="fa fa-calendar"></i>
				                                    </a>
				                                </span>
				                            </div>
				                        </div>  
								   </div>
								   <!--/.form group -->
								   <!-- form group -->
								   <div class="form-group">
										<label class="col-sm-3 control-label">NRIC/Passport : </label>
										<div class="col-sm-5">
											<input class="form-control" id="txtNRIC" name="txtNRIC" value="<%=sIC%>" maxlength="15" style="text-transform: uppercase" placeholder="Empty For All">
                                        </div>
								   </div>
								   <!--/.form group -->
								   <!-- form group -->
								   <div class="form-group">
										<label class="col-sm-3 control-label">Vendor Name : </label>
										<div class="col-sm-5">
											<input class="form-control" id="txtVend_Name2" name="txtVend_Name2" value="<%=sVend_Name%>" maxlength="50" style="text-transform: uppercase" placeholder="Empty For All">
                                        </div>
								   </div>
								   <!--/.form group -->
								   
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
										<label class="col-sm-3 control-label">Department : </label>
										<div class="col-sm-3">
											<div class="input-group">
				                               <input class="form-control" id="txtDept_ID" name="txtDept_ID" value="<%=sDept%>" maxlength="30" style="text-transform: uppercase" placeholder="Empty For All" input-check  >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('DEPT','txtDept_ID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>
                                        </div>
									</div>
									<!-- form group -->
									<div class="form-group">
										<!--Page Break-->
										<label class="col-sm-3 control-label">Page Break : </label>
										<div class="col-sm-3">
											<select id="cboPageBreak" name="cboPageBreak" class="form-control">
												<option value="N" <%if sType = "N" then%>Selected<%end if%>>No</option>
												<option value="Y" <%if sType = "Y" then%>Selected<%end if%>>Yes</option>
											</select>
										</div>
									</div>
									<!--/.form group -->
									<%end if%>
								   <!--/.form group -->
                                	
								 <!-- Footer Button -->
                                 <div class="box-footer">
									<%if sType = "BL" then%>
										<button type="button" id="A4" class="btn btn-info pull-left" style="width: 150px;background-color:yellow;color:black;pointer-events: none;border-radius: 0px;">A4 Landscape</button>
										<button type="button" name="sub" value="print" class="btn btn-primary pull-right" style="width: 90px" onclick="printReport();">Print</button>
										<button type="button" name="sub" value="print" class="btn bg-green-active pull-right" style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
										<button type="button" name="sub" value="reset" class="btn bg-purple pull-right" style="width: 94px;margin-right:5px;" onclick="txtReset();">Clear</button>
									<%elseif sType = "VR" then%>
										<button type="button" id="A4" class="btn btn-info pull-left" style="width: 150px;border-radius: 0px;background-color:yellow;color:black;pointer-events: none;">A4 Landscape</button>
										<button type="button" name="sub" value="print" class="btn btn-primary pull-right" style="width: 90px" onclick="printReport1();">Print</button>
										<button type="button" name="sub" value="export" class="btn bg-green-active pull-right" style="width: 100px;margin-right: 5px;" onclick="exportReport1()">Export Excel</button>
										<button type="button" name="sub" value="reset" class="btn bg-purple pull-right" style="width: 94px;margin-right: 5px;" onclick="txtReset1();">Clear</button>
									<%end if%>
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
    $('#btndt_date').click(function () {
        $('#dtFrDate1').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtToDate1').datepicker("show");
    }); 
	
	$('#btndt_date').click(function () {
        $('#dtFrDate2').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtToDate2').datepicker("show");
    }); 
    
    $(function () {        
       $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            })
    });
	$(function () {
	    //Date picker
	    $("[date-picker]").datepicker({
	        format: "dd/mm/yyyy",
	        autoclose: true,
	        })
	});
	
    </script>
  		
	<!--Reset Button-->
    <script>
	
		function txtReset()
		{
			document.getElementById("txtNRIC1").value = "";
			document.getElementById("txtComp_Name").value = "";
			document.getElementById("txtVend_Name1").value = "";
			document.getElementById("sStatus1").value = "";
		}
		
		function txtReset1()
		{
			document.getElementById("txtNRIC").value = "";
			document.getElementById("txtComp_Name").value = "";
			document.getElementById("txtVend_Name2").value = "";
			document.getElementById("txtDept_ID").value = "";
			document.getElementById("sStatus2").value = "";
		}
	</script>
	
	<!--open modal-->
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
        }else if (pType=="DEPT") {
			var search = document.getElementById("txtSearch_dept");
		}
		
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
			
		if (pType=="COMP") {
	  	    xhttp.open("GET", "ajax/ax_view_compid.asp?"+str, true);
	  	}else if (pType=="DEPT") {
			xhttp.open("GET", "ajax/ax_vrview_deptid.asp?"+str, true);
        }
		
  	    xhttp.send();
    }
	
	$(document).ready(function(){
			document.getElementById('txtNRIC').focus();
			document.getElementById('txtNRIC1').focus();
        }); 
	</script>
	
	<!--Print Button-->
	
	<script>
	function printReport() {

	   var sURL = "";
		
		sType = Form1.txtType.value;
		//sFrDate = Form1.dtFrDate1.value;
		//sToDate = Form1.dtToDate1.value;
		sIC = Form1.txtNRIC1.value;
		sVend_Name = Form1.txtVend_Name1.value;
		sCompID = Form1.txtComp_Name.value;
		sStatus = Form1.sStatus1.value;
		sPageBreak = Form1.cboPageBreak.value;
	    
	    //if (sFrDate == "") {
	    //  alert("Invalid From Date");
	    //  return false;
	   // }
	    //if (sToDate == "") {
	   //   alert("Invalid To Date");
	    //  return false;
	   // }

		sURL= "txtType=" + sType + "&" ;
	   // sURL= sURL + "dtFrDate1=" + sFrDate + "&" ;
	   // sURL= sURL + "dtToDate1=" + sToDate + "&";
		sURL= sURL + "txtNRIC1=" + sIC + "&";
		sURL= sURL + "txtVend_Name1=" + sVend_Name + "&";
	    sURL= sURL + "txtComp_Name=" + sCompID + "&";
		sURL= sURL + "sStatus1=" + sStatus + "&";
		sURL= sURL + "cboPageBreak=" + sPageBreak;
		
		window.open("vrprint_bl.asp?" + sURL, "mswindow","width=1200,height=500,top=50,left=50,scrollbars=yes,toolbar=no");

	}
	 
	function printReport1() {

	   var sURL = "";
		
		sType = Form1.txtType.value;
		sFrDate = Form1.dtFrDate2.value;
		sToDate = Form1.dtToDate2.value;
		sIC = Form1.txtNRIC.value;
		sVend_Name = Form1.txtVend_Name2.value;
		sCompID = Form1.txtComp_Name.value;
		sDept = Form1.txtDept_ID.value;
		sPageBreak = Form1.cboPageBreak.value;
	    
	    if (sFrDate == "") {
	      alert("Invalid From Date");
	      return false;
	    }
	    if (sToDate == "") {
	      alert("Invalid To Date");
	      return false;
	    }

		sURL= "txtType=" + sType + "&" ;
	    sURL= sURL + "dtFrDate2=" + sFrDate + "&" ;
	    sURL= sURL + "dtToDate2=" + sToDate + "&";
		sURL= sURL + "txtNRIC=" + sIC + "&";
		sURL= sURL + "txtVend_Name2=" + sVend_Name + "&";
	    sURL= sURL + "txtComp_Name=" + sCompID + "&";
		sURL= sURL + "txtDept_ID=" + sDept + "&";
		sURL= sURL + "cboPageBreak=" + sPageBreak;
		
		window.open("vrprint_vr.asp?" + sURL, "mswindow","width=1200,height=500,top=50,left=50,scrollbars=yes,toolbar=no");

	}
	
	function exportReport() {
		
	   var sURL = "";
		
		sType = Form1.txtType.value;
		dtFrDate = Form1.dtFrDate1.value;
		dtToDate = Form1.dtToDate1.value;
		sIC = Form1.txtNRIC1.value;
		sVend_Name = Form1.txtVend_Name1.value;
		sCompID = Form1.txtComp_Name.value;
		sStatus = Form1.sStatus1.value;
		
		if (dtFrDate == "") {
		  alert("Invalid From Attend Date");
		  return false;
		}
		
		if (dtToDate == "") {
		  alert("Invalid To Attend Date");
		  return false;
		}

		sURL= "txtType=" + sType + "&" ;
		sURL= sURL + "dtFrDate1=" + dtFrDate + "&" ;
		sURL= sURL + "dtToDate1=" + dtToDate + "&";
		sURL= sURL + "txtNRIC1=" + sIC + "&";
		sURL= sURL + "txtVend_Name1=" + sVend_Name + "&";
		sURL= sURL + "txtComp_Name=" + sCompID + "&";
		sURL= sURL + "sStatus1=" + sStatus + "&";

		window.open("vrrpt_export.asp?" + sURL);
	}
	
	function exportReport1() {
	
		var sURL = "";
		
		sType = Form1.txtType.value;
		dtFrDate = Form1.dtFrDate2.value;
		dtToDate = Form1.dtToDate2.value;
		sIC = Form1.txtNRIC.value;
		sVend_Name = Form1.txtVend_Name2.value;
		sCompID = Form1.txtComp_Name.value;
		sDept = Form1.txtDept_ID.value;
		
		if (dtFrDate == "") {
		  alert("Invalid From Date");
		  return false;
		}
		if (dtToDate == "") {
		  alert("Invalid To Date");
		  return false;
		}

		sURL= "txtType=" + sType + "&" ;
		sURL= sURL + "dtFrDate2=" + dtFrDate + "&" ;
		sURL= sURL + "dtToDate2=" + dtToDate + "&";
		sURL= sURL + "txtNRIC=" + sIC + "&";
		sURL= sURL + "txtVend_Name2=" + sVend_Name + "&";
		sURL= sURL + "txtComp_Name=" + sCompID + "&";
		sURL= sURL + "txtDept_ID=" + sDept + "&";

		window.open("vrrpt_export.asp?" + sURL);
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
	
	$( "#txtDept_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DP",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDept_ID").val(ui.item.value);
				var str = document.getElementById("txtDept_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtDept_ID").value = res[0];
			},0);
		}
	});	
	
	</script>


	<!--Script End-->
	

</body>
</html>
