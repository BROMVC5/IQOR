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
    sMainURL = "msreport.asp?"
      
	sEmp_ID = reqForm("txtEmp_ID")
	sEnType = reqForm("txtEn_Name")
    dtFrCDate = reqForm("dtFrCDate")
    dtToCDate = reqForm("dtToCDate")
	dtFrADate = reqForm("dtFrADate")
    dtToADate = reqForm("dtToADate")
	cboType = reqForm("cboType")
	sDtType = reqForm("txtDtType")
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ms.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
            <%if sType = "CR" then %>
                <h1>Print Medical Claim Report</h1>
			<%elseif sType = "BE" then %>
				<h1>Print Balance Entitlement Report</h1>
			<%elseif sType = "EX" then %>
				<h1>Print Exception Report</h1>
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
							
								<div class="box-body">
								<%if sType = "EX" then%>
									<div class="form-group">
										<label class="col-sm-3 control-label">Import Type : </label>
										<div class="col-sm-3">
											<select id="cboImpType" name="cboImpType" class="form-control">
												<option value="CH" <%if sImpType = "CH" then%>Selected<%end if%>>Claim History</option>
												<option value="IC" <%if sImpType = "IC" then%>Selected<%end if%>>Internal Clinic</option>
											</select>
										</div>
									</div>
								<%end if%>
								
								<%if sType <> "EX" then %>
								<div class="form-group">
									<label class="col-sm-3 control-label">Date Type : </label>
									<div class="col-sm-3 col-lg-3">
										<select id="txtDtType" name="txtDtType" onchange="DateType()" class="form-control">
                                            <option value="AT" <%if sDtType = "AT" then %>selected<%end if %>>Attend Date</option>
											<option value="CL" <%if sDtType = "CL" then %>selected<%end if %>>Claim Date</option>
										</select>
									</div>      
								</div>
								<%end if %>
	                            
     						   <!--body start-->
									<div id="DisType" class="form-group">
										<%if sType <> "EX" then%>
											<label class="col-sm-3 control-label">From Attend Date : </label>
										<%else%>
											<label class="col-sm-3 control-label">From Date : </label>
										<%end if%>
										<div class="col-sm-3 col-lg-3">
											<div class="input-group">
				                                <input id="dtFrADate" name="dtFrADate" value="<%=fdatelong(DateSerial(Year(now()), Month(now()), 1))%>" type="text" class="form-control" date-picker >
				                                <span class="input-group-btn">
				                                    <a href="#" id="btndt_FrAdate" class="btn btn-default" style="margin-left: 0px">
				                                        <i class="fa fa-calendar"></i>
				                                    </a>
				                                </span>
				                            </div>
				                        </div>
				                        
										<!--To Date-->
										<%if sType <> "EX" then%>
											<label class="col-sm-3 col-lg-2 control-label">To Attend Date : </label>
										<%else%>
											<label class="col-sm-3 col-lg-2 control-label">From Date : </label>
										<%end if%>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
				                                <input id="dtToADate" name="dtToADate" value="<%=fdatelong(now())%>" type="text" class="form-control" date-picker >
				                                <span class="input-group-btn">
				                                    <a href="#" id="btndt_ToAdate" class="btn btn-default" style="margin-left: 0px">
				                                        <i class="fa fa-calendar"></i>
				                                    </a>
				                                </span>
				                            </div>
				                        </div>  
								   </div>
								   <!--/.form group -->
								   <!--From Date-->
									<%if sType <> "EX" then%>
										<div id="DisType2" style="display:none;" class="form-group">
											<label class="col-sm-3 control-label">From Claim Date : </label>
											<div class="col-sm-3 col-lg-3">
												<div class="input-group">
													<input id="dtFrCDate" name="dtFrCDate" value="<%=fdatelong(DateSerial(Year(now()), Month(now()), 1))%>" type="text" class="form-control" date-picker >
													<span class="input-group-btn">
														<a href="#" id="btndt_FrCdate" class="btn btn-default" style="margin-left: 0px">
															<i class="fa fa-calendar"></i>
														</a>
													</span>
												</div>
											</div>	                        
											<!--To Date-->
											<label class="col-sm-3 col-lg-2 control-label">To Claim Date : </label>
											<div class="col-sm-3 col-lg-3">
												<div class="input-group">
													<input id="dtToCDate" name="dtToCDate" value="<%=fdatelong(now())%>" type="text" class="form-control" date-picker >
													<span class="input-group-btn">
														<a href="#" id="btndt_ToCdate" class="btn btn-default" style="margin-left: 0px">
															<i class="fa fa-calendar"></i>
														</a>
													</span>
												</div>
											</div>
										</div>
										<!-- form group -->
										<div class="form-group">
											<label class="col-sm-3 control-label">Employee Code : </label>
											<div class="col-sm-5">
												<div class="input-group">
												   <input class="form-control" id="txtEmp_ID" name="txtEmp_ID" value="<%=sEmp_ID%>" maxlength="8" style="text-transform: uppercase" placeholder="EMPTY FOR ALL" >
												   <span class="input-group-btn">
														<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('EMP','txtEmp_ID','mycontent','#mymodal')">
														   <i class="fa fa-search"></i>
														</a>
												   </span>
											   </div>
											</div>
										</div>
										<!-- form group -->
										<div class="form-group">
											<label class="col-sm-3 control-label">Entitlement Type : </label>
											<div class="col-sm-5">
												<div class="input-group">
												   <input class="form-control" id="txtEn_Name" name="txtEn_Name" value="<%=sEnType%>" maxlength="50" style="text-transform: uppercase" placeholder="EMPTY FOR ALL">
												   <span class="input-group-btn">
														<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('EN','txtEn_Name','mycontent','#mymodal')">
														   <i class="fa fa-search"></i>
														</a>
												   </span>
											   </div>
											</div>
										</div>
										<!-- form group -->
										<div class="form-group">
											<label class="col-sm-3 control-label">Panel Clinic : </label>
											<div class="col-sm-5">
												<div class="input-group">
													<input class="form-control" id="txtPanelCode" name="txtPanelCode" value="<%=sPanelC%>" maxlength="50" style="text-transform: uppercase" placeholder="EMPTY FOR ALL">
													<span class="input-group-btn">
														<a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
															onclick ="fOpen('PC','txtPanelCode','mycontent','#mymodal')">
															<i class="fa fa-search"></i>
														</a>
													</span>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label">Type : </label>
											<div class="col-sm-3">
												<select id="cboType" name="cboType" class="form-control">
													<option value="" Selected>All</option>
													<option value="M" <%if cboType = "M" then%>Selected<%end if%>>Manual</option>
													<option value="A" <%if cboType = "A" then%>Selected<%end if%>>Auto</option>
												</select>
											</div>
										</div>
									<%end if%>
									<div class="form-group">
											<!--Page Break-->
											<label class="col-sm-3 control-label">Page Break : </label>
											<div class="col-sm-3">
												<select id="cboPageBreak" name="cboPageBreak" class="form-control">
													<option value="N" >No</option>
													<option value="Y" >Yes</option>
												</select>
											</div>
										</div>
								</div> 
								 <!-- Footer Button -->
                                 <div class="box-footer">
									<button type="button" id="A4" class="btn btn-info pull-left" style="width: 150px;background-color:yellow;color:black;pointer-events: none;border-radius: 0px;">A4 Landscape</button>
                                	<button type="button" name="sub" value="print" class="btn btn-primary pull-right" style="width: 90px" onclick="printReport();">Print</button>
									<button type="button" name="sub" value="print" class="btn bg-green-active pull-right" style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
									<%if sType <> "EX" then%>
										<button type="button" name="sub" value="reset" class="btn bg-purple pull-right" style="width: 94px;margin-right:5px;" onclick="txtReset();">Clear</button>
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
	$('#btndt_FrCdate').click(function () {
        $('#dtFrCDate').datepicker("show");
    }); 
	
	$('#btndt_ToCdate').click(function () {
        $('#dtToCDate').datepicker("show");
    }); 

	$('#btndt_FrAdate').click(function () {
        $('#dtFrADate').datepicker("show");
    }); 
    
	$('#btndt_ToAdate').click(function () {
        $('#dtToADate').datepicker("show");
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
		document.getElementById("txtEmp_ID").value = "";
		document.getElementById("txtEn_Name").value = "";
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
  	    
		if (pType=="EMP") { 
            var search = document.getElementById("txtSearch_emp");
        }else if (pType=="EN") {
			var search = document.getElementById("txtSearch_en");
		}else if (pType=="PC") { 
            var search = document.getElementById("txtSearch_pc");
        }
		
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
			
		if (pType=="EMP") {
	  	    xhttp.open("GET", "ajax/ax_view_empid.asp?"+str, true);
	  	}else if (pType=="EN") {
			xhttp.open("GET", "ajax/ax_msview_enid.asp?"+str, true);
        }else if (pType=="PC") {
			xhttp.open("GET", "ajax/ax_msview_pc.asp?"+str, true);
		}
		
  	    xhttp.send();
    }
	
	$(document).ready(function(){
        document.getElementById('txtEmp_ID').focus();
        }); 
		
	function DateType(){
        var x = document.getElementById("txtDtType").value;

        if ( x == "AT"){
            document.getElementById('DisType').style.display = 'block'
			document.getElementById('DisType2').style.display = 'none'
		}else
		{   
            document.getElementById('DisType').style.display = 'none'
			document.getElementById('DisType2').style.display = 'block'
		}
	}
	</script>
	
	<!--Print Button-->
	
	<script>

	function printReport() {

	   var sURL = "";
		
		sType = Form1.txtType.value;
		sFrADate = Form1.dtFrADate.value;
		sToADate = Form1.dtToADate.value;
		sPageBreak = Form1.cboPageBreak.value;
		
		<%if sType = "EX" then%>
			sImpType = Form1.cboImpType.value;
		<%end if%>
		
		<%if sType <> "EX" then%>
			<%if sDtType = "AT" then %>
                sFrADate = Form1.dtFrADate.value;
		        sToADate = Form1.dtToADate.value;
            <%else %>
			    sFrCDate = Form1.dtFrCDate.value;
			    sToCDate = Form1.dtToCDate.value;
            <%end if %>
			sPanelCode = Form1.txtPanelCode.value;
			sEmp_ID = Form1.txtEmp_ID.value;
			sEnType = Form1.txtEn_Name.value;
			cboType = Form1.cboType.value;
			sDtType = Form1.txtDtType.value;
		<%end if%>

		if (sFrADate == "") {
	      alert("Invalid From Attend Date");
	      return false;
	    }
	    if (sToADate == "") {
	      alert("Invalid To Attend Date");
	      return false;
	    }
		
		<%if sType <> "EX" then%>
			if (dtFrCDate == "") {
			  alert("Invalid From Claim Date");
			  return false;
			}
			
			if (dtToCDate == "") {
			  alert("Invalid To Claim Date");
			  return false;
			}
		<%end if%>
		
		sURL= "txtType=" + sType + "&" ;
	    sURL= sURL + "dtFrADate=" + sFrADate + "&" ;
	    sURL= sURL + "dtToADate=" + sToADate + "&";
		sURL= sURL + "cboPageBreak=" + sPageBreak + "&";
		
		<%if sType = "EX" then%>
			sURL= sURL + "cboImpType=" + sImpType + "&";
		<%end if%>
		
		<%if sType <> "EX" then%>
			 <%if sDtType = "AT" then %>
                sURL= sURL + "dtFrADate=" + sFrADate + "&" ;
	            sURL= sURL + "dtToADate=" + sToADate + "&";
            <%else %>
			    sURL= sURL + "dtFrCDate=" + sFrCDate + "&" ;
			    sURL= sURL + "dtToCDate=" + sToCDate + "&";
            <%end if %>
			sURL= sURL + "txtPanelCode=" + sPanelCode + "&";
			sURL= sURL + "txtEmp_ID=" + sEmp_ID + "&";
			sURL= sURL + "txtEn_Name=" + sEnType + "&";
			sURL= sURL + "cboType=" + cboType + "&"; 
            sURL= sURL + "txtDtType=" + sDtType ;
		<%end if%>

		if (sType == "CR"){
			window.open("msprint_cr.asp?" + sURL, "mswindow","width=1200,height=500,top=50,left=50,toolbar=no");
		}else if (sType == "BE"){
			window.open("msprint_be.asp?" + sURL, "mswindow","width=1200,height=500,top=50,left=100,toolbar=no");
		}else if (sType == "EX"){
			window.open("msprint_ex.asp?" + sURL, "mswindow","width=1200,height=500,top=50,left=100,toolbar=no");
		}
	}
	
	function exportReport() {

	   var sURL = "";
		
		sType = Form1.txtType.value;
		sFrADate = Form1.dtFrADate.value;
		sToADate = Form1.dtToADate.value;
		
		<%if sType = "EX" then%>
			sImpType = Form1.cboImpType.value;
		<%end if%>
		
		<%if sType <> "EX" then%>
			<%if sDtType = "AT" then %>
                sFrADate = Form1.dtFrADate.value;
		        sToADate = Form1.dtToADate.value;
            <%else %>
			    sFrCDate = Form1.dtFrCDate.value;
			    sToCDate = Form1.dtToCDate.value;
            <%end if %>
			sPanelCode = Form1.txtPanelCode.value;
			sEmp_ID = Form1.txtEmp_ID.value;
			sEnType = Form1.txtEn_Name.value;
			cboType = Form1.cboType.value;
			sDtType = Form1.txtDtType.value;
		<%end if%>
		
	    
	    if (sFrADate == "") {
	      alert("Invalid From Attend Date");
	      return false;
	    }
	    if (sToADate == "") {
	      alert("Invalid To Attend Date");
	      return false;
	    }
		
		<%if sType <> "EX" then%>
			if (dtFrCDate == "") {
			  alert("Invalid From Claim Date");
			  return false;
			}
			
			if (dtToCDate == "") {
			  alert("Invalid To Claim Date");
			  return false;
			}
		<%end if%>

		sURL= "txtType=" + sType + "&" ;
	    sURL= sURL + "dtFrADate=" + sFrADate + "&" ;
	    sURL= sURL + "dtToADate=" + sToADate + "&";
		
		<%if sType = "EX" then%>
			sURL= sURL + "cboImpType=" + sImpType + "&";
		<%end if%>
		
		<%if sType <> "EX" then%>
			<%if sDtType = "AT" then %>
                sURL= sURL + "dtFrADate=" + sFrADate + "&" ;
	            sURL= sURL + "dtToADate=" + sToADate + "&";
            <%else %>
			    sURL= sURL + "dtFrCDate=" + sFrCDate + "&" ;
			    sURL= sURL + "dtToCDate=" + sToCDate + "&";
            <%end if %>
			sURL= sURL + "txtPanelCode=" + sPanelCode + "&";
			sURL= sURL + "txtEmp_ID=" + sEmp_ID + "&";
			sURL= sURL + "txtEn_Name=" + sEnType + "&";
			sURL= sURL + "cboType=" + cboType + "&"; 
            sURL= sURL + "txtDtType=" + sDtType;
		<%end if%>

	    window.open("msrpt_export.asp?" + sURL);
 
	}
	 
	$( "#txtEmp_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEmp_ID").val(ui.item.value);
				$("#dt_Resign").val(ui.item.data);
				var str = document.getElementById("txtEmp_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtEmp_ID").value = res[0];
				document.getElementById("txtEmp_Name").value = res[1];
			},0);
		}
	});
	
	$( "#txtEn_Name" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=ET",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEn_Name").val(ui.item.value);
				var str = document.getElementById("txtEn_Name").value;
				var res = str.split(" | ");
				document.getElementById("txtEn_Name").value = res[0];
			},0);
		}
	});
	
	$( "#txtPanelCode" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=PC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtPanelCode").val(ui.item.value);
				var str = document.getElementById("txtPanelCode").value;
				var res = str.split(" | ");
				document.getElementById("txtPanelCode").value = res[0];
			},0);
		}
	});
	
	</script>


	<!--Script End-->
	

</body>
</html>
