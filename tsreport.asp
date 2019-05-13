<%@ LANGUAGE = VBScript.Encode %>
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

    
<%#@~^FwEAAA==@#@&dd:Xa+P{PMn;!+dYvJOza+J*@#@&,PP,[OfmYPxP.n$sGDscJ9Y29mY+Eb,P@#@&,~,P@#@&P,PP9Yw.fmYnP{P.n$sWMh`rNYao.fmYJb@#@&~,P~NDPWGlOn,'P.n$sGDscrNOaKKflD+rb@#@&P~P,/3haZW9nP{PD5oWM:vJO6O3sw/W9nJ*@#@&~,PPd/K/Oq9~{P.;wWDs`rO6DZG/Dq[E*@#@&,~P,/bMnCZKNPxP.n$sGDscJD6O)M+l/G9+E#@#@&@#@&pksAAA==^#~@%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ts.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
            <%#@~^FQAAAA==r6Pd:Xa+P{PrPSrPOtx~VAYAAA==^#~@%>
                <h1>Print Transport Listing Report</h1>
            <%#@~^GQAAAA==n^/nb0,/KHw~',J3SrPO4xP7gcAAA==^#~@%>
            	<h1>Print Employee Listing Report</h1>
            <%#@~^GQAAAA==n^/nb0,/KHw~',J]SrPO4xP+wcAAA==^#~@%>
            	<h1>Print Route Listing Report</h1>
        	<%#@~^GQAAAA==n^/nb0,/KHw~',J3(rPO4xP+gcAAA==^#~@%>
        	<h1>Print Exceptional Report</h1>
            <%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form name="Form1" class="form-horizontal" action="ogreport.asp" method="post">
                        	<input type="hidden" name="txtType" id="txtType" value="<%=#@~^BQAAAA==d:X2FQIAAA==^#~@%>">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">
                               
									<%#@~^EwAAAA==r6Pd:Xa+P{JAJJ,Y4+	BQYAAA==^#~@%>
									<!-- form group -->
									<div class="form-group">
									   <!--Employee-->
									   <div class="col-sm-2" >
											<label class="control-label">Employee Code : </label>
									   </div>
									    <div class="col-sm-4">
									        <div class="input-group">
									            <input class="form-control" id="txtEmpCode" name="txtEmpCode" value="<%=#@~^CAAAAA==dA:2;W9+EAMAAA==^#~@%>" maxlength="10" style="text-transform: uppercase" placeholder ="Empty For All" input-check  >
									            <span class="input-group-btn">
									                <a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('EMP','txtEmpCode','mycontent','#mymodal')">
									                    <i class="fa fa-search"></i>
									                </a>
									            </span>
									        </div>
									    </div>           
									</div>
									
									 <!-- form group -->
									<div class="form-group">
                                   	    <!--Cost Center-->
										<div class="col-sm-2" >
												<label class="control-label">Cost Center : </label>
										</div>
										<div class="col-sm-4">
											<div class="input-group">
											   <input class="form-control" id="txtCostId" name="txtCostId" value="<%=#@~^BwAAAA==d;WdDq9uQIAAA==^#~@%>" maxlength="6" style="text-transform: uppercase" placeholder="Empty For All" input-check  >
											   <span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('COST','txtCostId','mycontent','#mymodal')">
													   <i class="fa fa-search"></i>
													</a>
											   </span>
										   </div>
										</div>
									</div>
	                              <!--/.form group -->
									
									
									<!-- form group -->
									  <div class="form-group">
										   <!--Cost Center-->
										<div class="col-sm-2" >
											<label class="control-label">Superior : </label>
										</div>
											<div class="col-sm-4">
												<div class="input-group">
												   <input class="form-control" id="txtSup_CODE" name="txtSup_CODE" value="<%=#@~^CQAAAA==dUE2|ZKN+hQMAAA==^#~@%>" maxlength="10" style="text-transform: uppercase" placeholder="Empty For All">
												   <span class="input-group-btn">
														<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('SUP','','mycontent','#mymodal')">
														   <i class="fa fa-search"></i>
														</a>
												   </span>
											   </div>
										   </div>
									</div>
									<!--/.form group -->
									
									<!--/.form group -->
									
									<%#@~^FwAAAA==n^/nb0,/KHw~'rKJJ,Y4n	vQcAAA==^#~@%>
									
									<!--From Date-->
									<div class="form-group">
										<div class="col-sm-2" >
											<label class="control-label">From Date : </label>
										</div>
										<div class="col-sm-4">
											<div class="input-group">
												<input id="dtpFrDate" name="dtpFrDate" value="<%=#@~^IwAAAA==W9lOVKxovfmO+v#~_,F~R,flHcfmY+vbb#GwoAAA==^#~@%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_Frdate" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>
										
										<!--To Date-->
										<div class="col-sm-1" >
											<label class="col-sm-1 control-label">To </label>
										</div>
										<div class="col-sm-4">
											<div class="input-group">
												<input id="dtpToDate" name="dtpToDate" value="<%=#@~^EQAAAA==W9lOVKxovfzP2v#bdAUAAA==^#~@%>" type="text" class="form-control" date-picker >
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
									   <!--Employee-->
									   <div class="col-sm-2" >
									        	<label class="control-label">Requestor : </label>
									   </div>
									    <div class="col-sm-4">
									        <div class="input-group">
									            <input class="form-control" id="txtEmpCode" name="txtEmpCode" value="<%=#@~^CAAAAA==dA:2;W9+EAMAAA==^#~@%>" maxlength="10" style="text-transform: uppercase" placeholder="Empty For All" input-check  >
									            <span class="input-group-btn">
									                <a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('EMP','txtEmpCode','mycontent','#mymodal')">
									                    <i class="fa fa-search"></i>
									                </a>
									            </span>
									        </div>
									    </div>           
									</div>
									<!--/.form group -->
																	   
								   <!-- form group -->
                                   <div class="form-group">
                                   
                                   	    <!--Cost Center-->
                               		    <div class="col-sm-2" >
					                        	<label class="control-label">Cost Center : </label>
					                    </div>
				                        <div class="col-sm-4">
				                            <div class="input-group">
				                               <input class="form-control" id="txtCostId" name="txtCostId" value="<%=#@~^BwAAAA==d;WdDq9uQIAAA==^#~@%>" maxlength="6" style="text-transform: uppercase" placeholder="Empty For All" input-check  >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('COST','txtCostId','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>

                                        </div>
                                  
                                  </div>
	                              <!--/.form group -->
								  
									<!-- form group -->
									<div class="form-group">
										   <!--Cost Center-->
										<div class="col-sm-2" >
											<label class="control-label">Superior : </label>
										</div>
										<div class="col-sm-4">
											<div class="input-group">
											   <input class="form-control" id="txtSup_CODE" name="txtSup_CODE" value="<%=#@~^CQAAAA==dUE2|ZKN+hQMAAA==^#~@%>" maxlength="10" style="text-transform: uppercase" placeholder="Empty For All">
											   <span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('SUP','','mycontent','#mymodal')">
													   <i class="fa fa-search"></i>
													</a>
											   </span>
										   </div>
									   </div>
									</div>
									<!--/.form group -->
	                              
									<!-- Area Code -->
									<div class="form-group">
										<div class="col-sm-2" >
											<label class="control-label">Area Code : </label>
										</div>  
										<div class="col-sm-4">
											<div class="input-group">
												<input class="form-control" id="txtAreaCode" name="txtAreaCode"  maxlength="10" style="text-transform: uppercase" placeholder="Empty For All" input-check />
												<span class="input-group-btn">
												<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('AREA','txtAreaCode','mycontent','#mymodal')">
												<i class="fa fa-search"></i>
												</a>
												</span>
												
											</div>
										</div>
									</div>
									
	                             <%#@~^GAAAAA==n^/nb0,/KHw~',J]SrPO4x2wcAAA==^#~@%>   
	                                <!-- Area Code -->
									<div class="form-group">
										<div class="col-sm-2" >
											<label class="control-label">Area Code : </label>
										</div>  
										<div class="col-sm-4">
											<div class="input-group">
												<input class="form-control" id="txtAreaCode" name="txtAreaCode"  maxlength="10" style="text-transform: uppercase" placeholder="Empty For All" input-check />
												<span class="input-group-btn">
												<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('AREA','txtAreaCode','mycontent','#mymodal')">
												<i class="fa fa-search"></i>
												</a>
												</span>
											</div>
											
										</div>
									</div>
								
								<%#@~^GAAAAA==n^/nb0,/KHw~',J3(rPO4x2gcAAA==^#~@%>
									<div class="form-group">
										<div class="col-sm-2" >
											<label class="control-label">From Date : </label>
										</div>
										<div class="col-sm-4">
											<div class="input-group">
												<input id="dtpFrDate2" name="dtpFrDate2" value="<%=#@~^IwAAAA==W9lOVKxovfmO+v#~_,F~R,flHcfmY+vbb#GwoAAA==^#~@%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_Frdate2" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>
										
										<!--To Date-->
										<div class="col-sm-1" >
											<label class="col-sm-1 control-label">To </label>
										</div>
										<div class="col-sm-4">
											<div class="input-group">
												<input id="dtpToDate2" name="dtpToDate2" value="<%=#@~^EQAAAA==W9lOVKxovfzP2v#bdAUAAA==^#~@%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_Todate2" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>  
									</div>
									<!--/.form group -->									
	                            <%#@~^BwAAAA==n	N~b0,RgIAAA==^#~@%>
	                            <!-- Page Break -->
								<div class="form-group">
									<div class="col-sm-2" >
										<label class="control-label">Page Break : </label>
									</div>  
									<div class="col-sm-4">
										<select id="cboPageBreak" name="cboPageBreak" class="form-control">
											<option value="N" <%#@~^EwAAAA==r6Pd:Xa+P{PrHJ,Y4+	4gUAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>No</option>
											<option value="Y" <%#@~^EwAAAA==r6Pd:Xa+P{PreJ,Y4+	7QUAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Yes</option>
										</select>										
									</div>
								</div>    
								
								<!-- Footer Button -->
								<div class="box-footer">
									<div class="form-group">
										<div class="col-sm-12" >
											
											<button type="button" id="A4" class="btn btn-info pull-left" style="width: 150px;background-color:yellow;color:black;pointer-events: none;border-radius: 0px;">A4 Portrait</button>
											<button type="button" name="sub" value="print" class="btn btn-primary pull-right" style="width: 90px" onclick="printReport();">Print</button>
											<button type="button" name="sub" value="print" class="btn bg-green-active pull-right" style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
											<button type="button" name="sub" value="reset" class="btn bg-purple pull-right" style="width: 94px;margin-right:5px;" onclick="txtReset();">Clear</button>
											
										</div>
									</div> 
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
    

    <!--date picker-->
    <script>
    $('#btndt_Frdate').click(function () {
        $('#dtpFrDate').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtpToDate').datepicker("show");
    });
	$('#btndt_date').click(function () {
        $('#dtpDate').datepicker("show");
    });
    
	$('#btndt_Frdate2').click(function () {
        $('#dtpFrDate2').datepicker("show");
    });

	$('#btndt_Todate2').click(function () {
        $('#dtpToDate2').datepicker("show");
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
		document.getElementById("txtEmpCode").value = "";
	    document.getElementById("txtCostId").value = "";
		document.getElementById("txtSup_CODE").value = "";
		document.getElementById("txtAreaCode").value = "";

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
		if (pType == "EMP") {
  	    var search = document.getElementById("txtSearch1");
  	    }
  	    else if (pType == "COST") {
  	    var search = document.getElementById("txtSearch2");
  	    }
  	    else if (pType == "AREA") {
  	    var search = document.getElementById("txtSearch3");
  	    }
		else {
  	    var search = document.getElementById("txtSearch");
  	    }
  	    
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
 			
		if (pType=="COST") {
	  	    xhttp.open("GET", "ajax/ax_tsview_costId.asp?"+str, true);
	  	} else if(pType=="EMP") {  		
			xhttp.open("GET", "ajax/ax_tsview_empId2.asp?"+str, true);
	  	} else if(pType=="AREA") {  		
			xhttp.open("GET", "ajax/ax_tsview_areaId.asp?"+str, true);
		} else if (pType=="SUP") {
            xhttp.open("GET", "ajax/ax_csview_tmsupid.asp?"+str, true);
        }
	  	
  	    xhttp.send();
    }
	</script>
  			
	<!--Print Button-->
	
	<script>

	function printReport() {

		var sURL = "";
		sType = Form1.txtType.value;		
		sPageBreak = Form1.cboPageBreak.value;

		if (sType == "EL") {
			
			sEmpCode = Form1.txtEmpCode.value;
			sSup_Code =Form1.txtSup_CODE.value;
			sCostId = Form1.txtCostId.value;
			
		    sURL= "txtEmpCode=" + sEmpCode + "&";
			sURL= sURL + "txtSup_CODE=" + sSup_Code + "&";
			sURL= sURL + "txtCostId=" + sCostId + "&";
		    sURL= sURL + "cboPageBreak=" + sPageBreak;
		    
			window.open("tsprint_el.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
		} 
		
		if (sType == "RL") {
			sAreaCode = Form1.txtAreaCode.value;

			sURL= "txtAreaCode=" + sAreaCode + "&";
		    sURL= sURL + "cboPageBreak=" + sPageBreak;
		    
			window.open("tsprint_rl.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
		}
		
		if (sType == "TL") {
			sFrDate = Form1.dtpFrDate.value;
			sToDate = Form1.dtpToDate.value;
			sEmpCode = Form1.txtEmpCode.value;
			sCostId = Form1.txtCostId.value;
			sSup_Code =Form1.txtSup_CODE.value;
			sAreaCode = Form1.txtAreaCode.value;
			    
		    if (sFrDate == "") {
		      alert("Invalid From Date");
		      return false;
		    }
		    if (sToDate == "") {
		      alert("Invalid To Date");
		      return false;
		    }
		    
		    if (sFrDate > sToDate) {
		      alert("Invalid Date Range");
		      return false;
		    }
		
		    sURL= "dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate + "&";
		    sURL= sURL + "txtEmpCode=" + sEmpCode + "&";
			sURL= sURL + "txtCostId=" + sCostId + "&";
			sURL= sURL + "txtSup_CODE=" + sSup_Code + "&";
			sURL= sURL + "txtAreaCode=" + sAreaCode + "&";
		    sURL= sURL + "cboPageBreak=" + sPageBreak;

			window.open("tsprint_tl.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
		}

		if (sType == "EX") {
			sFrDate = Form1.dtpFrDate2.value;
			sToDate = Form1.dtpToDate2.value;
			    
		    if (sFrDate == "") {
		      alert("Invalid From Date");
		      return false;
		    }
		    if (sToDate == "") {
		      alert("Invalid To Date");
		      return false;
		    }
		    
		    if (sFrDate > sToDate) {
		      alert("Invalid Date Range");
		      return false;
		    }
		
		    sURL= "dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate + "&";
		    sURL= sURL + "cboPageBreak=" + sPageBreak;
		    
			window.open("tsprint_ex.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
		}

		}
	 
	
	</script>
	<!-- Export Excel -->
	<script>

 	 function exportReport() {

	   var sURL = "";
		
		sType = Form1.txtType.value;
		if (sType == "TL"){
		
			sFrDate = Form1.dtpFrDate.value;
		    sToDate = Form1.dtpToDate.value;	
			sCostId = Form1.txtCostId.value;
			sSup_Code =Form1.txtSup_CODE.value;	
			sAreaCode = Form1.txtAreaCode.value;			
   	 	
		   	 	
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
			sURL= sURL + "txtCostId=" + sCostId + "&";
			sURL= sURL + "txtSup_CODE=" + sSup_Code + "&";
			sURL= sURL + "txtAreaCode=" + sAreaCode + "&";
		    sURL= sURL + "dtToDate=" + sToDate ;
	    
		}
		
		if (sType == "EL"){
			sEmpCode = Form1.txtEmpCode.value;
			sSup_Code =Form1.txtSup_CODE.value;
			sCostId = Form1.txtCostId.value;
			
			sURL= "txtType=" + sType + "&" ;
			sURL= sURL + "txtSup_CODE=" + sSup_Code + "&";
			sURL= sURL + "txtCostId=" + sCostId + "&";
			sURL= sURL + "txtEmpCode=" + sEmpCode ;
		}
		
		if (sType == "RL"){
			sAreaCode = Form1.txtAreaCode.value;
			
			sURL= "txtType=" + sType + "&" ;
			sURL= sURL + "txtAreaCode=" + sAreaCode ;
		}
		
		if (sType == "EX"){
			sFrDate = Form1.dtpFrDate2.value;
			sToDate = Form1.dtpToDate2.value;
			    
		    if (sFrDate == "") {
		      alert("Invalid From Date");
		      return false;
		    }
		    if (sToDate == "") {
		      alert("Invalid To Date");
		      return false;
		    }
		
			sURL= "txtType=" + sType + "&" ;
		    sURL= sURL +"dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate;
		}
		
	    window.open("tsrpt_export.asp?" + sURL);
 
	 }
	 
	</script>
    
    <!--check numeric-->
    <script>
	 function isNumberKey(evt) {
     var charCode = (evt.which) ? evt.which : evt.keyCode;
     if (charCode != 46 && charCode > 31 
       && (charCode < 48 || charCode > 57))
        return false;
  
      return true;
 	} 
	
	$( "#txtEmpCode" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEmpCode").val(ui.item.value);
				var str = document.getElementById("txtEmpCode").value;
				var res = str.split(" | ");
				document.getElementById("txtEmpCode").value = res[0];
			},0);
		}
	});
	
	$( "#txtCostId" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtCostId").val(ui.item.value);
				var str = document.getElementById("txtCostId").value;
				var res = str.split(" | ");
				document.getElementById("txtCostId").value = res[0];
			},0);
		}
	});	
	
	$( "#txtAreaCode" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=AC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtAreaCode").val(ui.item.value);
				var str = document.getElementById("txtAreaCode").value;
				var res = str.split(" | ");
				document.getElementById("txtAreaCode").value = res[0];
			},0);
		}
	});	
	
	$( "#txtSup_CODE" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtSup_CODE").val(ui.item.value);
				var str = document.getElementById("txtSup_CODE").value;
				var res = str.split(" | ");
				document.getElementById("txtSup_CODE").value = res[0];
			},0);
		}
	});
    </script>
	<!--Script End-->
	

</body>
</html>
