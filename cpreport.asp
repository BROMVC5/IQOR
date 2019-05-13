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
    sMainURL = "cpreport.asp?"
         
    dtFrDate = reqForm("dtFrDate")
    dtToDate = reqForm("dtToDate")
	sReq_Name = reqForm("txtEmp_Name")
	sTicket_No = reqForm("txtTicket_No")
	sLQty = reqForm("txtLot_Qty")
	
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cp.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
            <%if sType = "PR" then %>
                <h1>Print Parking Report</h1>
            <%end if%>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form name="Form1" class="form-horizontal" action="cpprint.asp" method="post">
                        	<input type="hidden" name="txtType" id="txtType" value="<%=sType%>">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">
									<!-- form group -->
									<div class="form-group">
		                           
		                           		<!--From Date-->
				                        <label class="col-sm-3 control-label">From Date : </label>
										<div class="col-sm-3 col-lg-3">
											<div class="input-group">
				                                <input id="dtFrDate" name="dtFrDate" value="<%=fdatelong(DateSerial(Year(now()), Month(now()), 1))%>" type="text" class="form-control" date-picker >
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
				                                <input id="dtToDate" name="dtToDate" value="<%=fdatelong(now())%>" type="text" class="form-control" date-picker >
				                                <span class="input-group-btn">
				                                    <a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
				                                        <i class="fa fa-calendar"></i>
				                                    </a>
				                                </span>
				                            </div>
				                        </div>  
								   </div>
								   <!--/.form group -->
								   <div class="form-group">
									   <label class="col-sm-3 control-label">Requestor Name : </label>
										<div class="col-sm-5">
											<div class="input-group">
											  <input class="form-control" id="txtEmp_Name" name="txtEmp_Name" value="<%=sEmpName%>" maxlength="50" placeholder="EMPTY FOR ALL"/>
											   <span class="input-group-btn">
													<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('EMP','txtEmp_ID','mycontent','#mymodal')">
													   <i class="fa fa-search"></i>
													</a>
											   </span>
										   </div>
										</div>
									</div>
									<div class="form-group" hidden>
									   <div class="col-sm-6" >
										   <label>ID :</label>
										   <div class="input-group">
											   <input class="form-control" id="txtEmp_ID" name="txtEmp_ID" value="<%=sEmp_ID%>" maxlength="50" style="text-transform: uppercase" input-check  >
											   <span class="input-group-btn">
													<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('EMP','txtEmp_ID','mycontent','#mymodal')">
													   <i class="fa fa-search"></i>
													</a>
											   </span>
										   </div>
										</div>
									</div>
									<div class="form-group" hidden>
									   <div class="col-sm-6" >
										   <label>Date :</label>
										   <div class="input-group">
											   <input class="form-control" id="dt_Resign" name="dt_Resign" value="<%=dtResign%>" maxlength="50" style="text-transform: uppercase" input-check  >
											   <span class="input-group-btn">
													<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('EMP','txtEmp_Name','mycontent','#mymodal')">
													   <i class="fa fa-search"></i>
													</a>
											   </span>
										   </div>
										</div>
									</div>
								   <!--/.form group -->
								   <!-- form group -->
								   <div class="form-group">
										<label class="col-sm-3 control-label">Ticket No : </label>
										<div class="col-sm-3">
											<input class="form-control" id="txtTicket_No" name="txtTicket_No" value="<%=sTicket_No%>" maxlength="10" style="text-transform: uppercase" placeholder="EMPTY FOR ALL">
                                        </div>
								   </div>
								   <!--/.form group -->
								   <!-- form group -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Lot Quantity : </label>
										<div class="col-sm-3">
											<input class="form-control" id="txtLot_Qty" name="txtLot_Qty" value="<%=sLQty%>" maxlength="2" style="text-align:right;" placeholder="EMPTY FOR ALL">
                                        </div>
								   </div>
								   <!--/.form group -->
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
                                	
								 <!-- Footer Button -->
                                 <div class="box-footer">
									<button type="button" id="A4" class="btn btn-info pull-left" style="width: 150px;background-color:yellow;color:black;pointer-events: none;border-radius: 0px;">A4 Landscape</button>
									<button type="button" name="sub" value="print" class="btn btn-primary pull-right" style="width: 90px" onclick="printReport();">Print</button>
									<button type="button" name="sub" value="print" class="btn bg-green-active pull-right" style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
									<button type="button" name="sub" value="reset" class="btn bg-purple pull-right" style="width: 94px;margin-right:5px;" onclick="txtReset();">Clear</button>
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
        $('#dtFrDate').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtToDate').datepicker("show");
    }); 
    
	$('#btndt_Joindate').click(function () {
        $('#dtJoinDate').datepicker("show");
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
	
	$(document).ready(function(){
        document.getElementById('txtEmp_Name').focus();
    }); 
    </script>
	<script>
	
    function fOpen(pType,pFldName,pContent,pModal) {
		document.getElementById(pContent).innerHTML = ""
		showDetails('page=1',pFldName,pType,pContent)
		$(pModal).modal('show');
	}
	
	function getValue1(svalue, svalue2, svalue3, pFldName, pFldName2 , pFldName3) {
		document.getElementById(pFldName).value = svalue;
		document.getElementById(pFldName2).value = svalue2;
		document.getElementById(pFldName3).value = svalue3;
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
  	    
		if (pType=="EMP") { 
            var search = document.getElementById("txtSearch_emp");
        }
		
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
			
		if (pType=="EMP") {
	  	    xhttp.open("GET", "ajax/ax_view_empid2.asp?"+str, true);
	  	}
		
  	    xhttp.send();
    }
	 
	</script>
  		
	<!--Reset Button-->
    <script>
	function txtReset()
	{
		document.getElementById("txtEmp_Name").value = "";
		document.getElementById("txtTicket_No").value = "";
		document.getElementById("txtLot_Qty").value = "";
	}
	</script>
	
	<!--open modal-->
	
	<!--Print Button-->
	
	<script>

	function printReport() {
	
	   var sURL = "";
		
		sType = Form1.txtType.value;
		sFrDate = Form1.dtFrDate.value;
		sToDate = Form1.dtToDate.value;
		sReq_Name = Form1.txtEmp_Name.value;
		sTicket_No = Form1.txtTicket_No.value;
		sLQty = Form1.txtLot_Qty.value;
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
	    sURL= sURL + "dtFrDate=" + sFrDate + "&" ;
	    sURL= sURL + "dtToDate=" + sToDate + "&";
		sURL= sURL + "txtEmp_Name=" + sReq_Name + "&";
	    sURL= sURL + "txtTicket_No=" + sTicket_No + "&";
		sURL= sURL + "txtLot_Qty=" + sLQty + "&";
		sURL= sURL + "cboPageBreak=" + sPageBreak;
		
		if (sType == "PR"){
			window.open("cpprint_pr.asp?" + sURL, "mswindow","width=1200,height=500,top=50,left=50,scrollbars=yes,toolbar=no");
		}
	 }
	
	function exportReport() {

	   var sURL = "";
		
		sType = Form1.txtType.value;
		sFrDate = Form1.dtFrDate.value;
		sToDate = Form1.dtToDate.value;
		sReq_Name = Form1.txtEmp_Name.value;
		sTicket_No = Form1.txtTicket_No.value;
		sLQty = Form1.txtLot_Qty.value;
	    
	    if (sFrDate == "") {
	      alert("Invalid From Date");
	      return false;
	    }
		
	    if (sToDate == "") {
	      alert("Invalid To Date");
	      return false;
	    }

		sURL= "txtType=" + sType + "&" ;
	    sURL= sURL + "dtFrDate=" + sFrDate + "&" ;
	    sURL= sURL + "dtToDate=" + sToDate + "&";
		sURL= sURL + "txtEmp_Name=" + sReq_Name + "&";
	    sURL= sURL + "txtTicket_No=" + sTicket_No + "&";
		sURL= sURL + "txtLot_Qty=" + sLQty + "&";

	    window.open("cprpt_export.asp?" + sURL);
 
	 }
	 
	$( "#txtEmp_Name" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEmp_Name").val(ui.item.value);
				var str = document.getElementById("txtEmp_Name").value;
				var res = str.split(" | ");
				document.getElementById("txtEmp_Name").value = res[0];
			},0);
		}
	});	
	</script>


	<!--Script End-->
	

</body>
</html>
