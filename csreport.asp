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

    
<%
	sType = request("type")
    sMainURL = "csreport.asp?"
         
    dtFrDate = reqForm("dtpFrDate")
    dtToDate = reqForm("dtpToDate")
    sEmpCode = reqForm("txtEmpCode")
    sDeptId = reqForm("txtDeptId")
    sGradeId = reqForm("txtGradeId")
    sCostId = reqForm("txtCostId")
    sContId = reqForm("txtContId")
    
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
            <%if sType = "SD" then %>
                <h1>Summary By Date</h1>
            <%elseif sType="ES" then%>
            	<h1>Employee Summary </h1>
        	<%elseif sType="ED" then%>
        		<h1>Employee Details </h1>
			<%elseif sType="ET" then%>
        		<h1>Subsidy Entitlement Details </h1>
			<%elseif sType="SS" then%>
        		<h1>Subsidy Entitlement Summary </h1>
			<%elseif sType="EMT" then%>
        		<h1>Employee Transaction </h1>
			<%%>
            <%end if%>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form name="Form1" class="form-horizontal" action="csprint.asp" method="post">
                        	<input type="hidden" name="txtType" id="txtType" value="<%=sType%>">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">
							   
									<%if sType <> "ET" and sType <> "SS" and sType <> "EMT" then%>
										<!-- form group -->
										<div class="form-group">
											<!--Page Break-->
											<label class="col-sm-3 control-label">Type : </label>
											<div class="col-sm-3">
												<select id="cboDisType" name="cboDisType" class="form-control" onchange = "DisExtra()">
													<option value="N" <%if sDisType = "N" then%>Selected<%end if%>>Normal</option>
													<option value="E" <%if sDisType = "E" then%>Selected<%end if%>>Extra</option>
													<option value="B" <%if sDisType = "B" then%>Selected<%end if%>>Both</option>
												</select>
											</div>
										</div>
										<!--/.form group -->
									<%end if%>
									
									<%if sType <> "ET" and sType <> "SS" then%>
									<div id = "DisSubType" style="display: none">
									<%end if%>
										<!-- form group -->
									   <div class="form-group">
											<!--Type-->
											<label class="col-sm-3 control-label">Subsidy Type : </label>
											<div class="col-sm-3">
												<select id="selType" name="selType" class="form-control" onchange="hideDiv()">
													<%
														Set rstCSType = server.CreateObject("ADODB.RecordSet")    
														sSQL = "select * from cstype where STATUS = 'A' " 
														rstCSType.Open sSQL, conn, 3, 3
														if not rstCSType.eof then
															Do while not rstCSType.eof
																response.write "<option value='" & rstCSType("SUBTYPE") & "'" 
																if sType = rstCSType("SUBTYPE") then
																	response.write " selected"
																end if
																response.write ">" & rstCSType("SUBTYPE") & "</option>"
																
															rstCSType.movenext
															Loop
														end if
														pCloseTables(rstCSType)
													%>
												</select>
											</div>
									   </div>
									   <!--/.form group -->
									<%if sType <> "ET" and sType <> "SS" then%>
									</div>
									<%end if%>
	                        	   <!-- form group -->
		                           <div class="form-group">
		                           
		                           		<!--From Date-->
				                        <label class="col-sm-3 control-label">From Date : </label>
				                      
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                                <input id="dtpFrDate" name="dtpFrDate" value="<%=fdatelong(Date() + 1 - Day(Date()))%>" type="text" class="form-control" date-picker >
				                                <span class="input-group-btn">
				                                    <a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
				                                        <i class="fa fa-calendar"></i>
				                                    </a>
				                                </span>
				                            </div>
				                        </div>
				                        
										<!--To Date-->
				                        <div class="col-sm-1" >
				                        	<label class="col-sm-1 control-label">To </label>
				                        </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                                <input id="dtpToDate" name="dtpToDate" value="<%=fdatelong(DATE())%>" type="text" class="form-control" date-picker >
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
											<label class="col-sm-3 control-label">Employee Code : </label>
											<div class="col-sm-3">
												<div class="input-group">
													<input class="form-control" id="txtEmpCode" name="txtEmpCode" value="<%=sEmpCode%>" maxlength="10" style="text-transform: uppercase" placeholder="Empty For All" >
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
									   
											<!--Department-->
											<label class="col-sm-3 control-label">Department : </label>
											<div class="col-sm-3">
												<div class="input-group">
												   <input class="form-control" id="txtDeptId" name="txtDeptId" value="<%=sDeptId%>" maxlength="15" style="text-transform: uppercase" placeholder="Empty For All">
												   <span class="input-group-btn">
														<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('DEPT','txtDeptId','mycontent','#mymodal')">
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
											<label class="col-sm-3 control-label">Cost Center : </label>
											<div class="col-sm-3">
												<div class="input-group">
												   <input class="form-control" id="txtCostId" name="txtCostId" value="<%=sCostId%>" maxlength="10" style="text-transform: uppercase" placeholder="Empty For All">
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
											<label class="col-sm-3 control-label">Superior : </label>
											<div class="col-sm-3">
												<div class="input-group">
												   <input class="form-control" id="txtSup_CODE" name="txtSup_CODE" value="<%=sSup_Code%>" maxlength="10" style="text-transform: uppercase" placeholder="Empty For All">
												   <span class="input-group-btn">
														<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('SUP','','mycontent','#mymodal')">
														   <i class="fa fa-search"></i>
														</a>
												   </span>
											   </div>
										   </div>
										   
									</div>
									<!--/.form group -->
									
									<%if sType <> "ET" and sType <> "SS" then%>
										<%if sType <> "EMT" then%>

									  <!-- form group -->
										<div class="form-group">
										
											   <!--Employee Contract-->
												<label class="col-sm-3 control-label">Contract : </label>
												<div class="col-sm-3">
													<div class="input-group">
													   <input class="form-control" id="txtContId" name="txtContId" value="<%=sContId%>" maxlength="10" style="text-transform: uppercase" placeholder="Empty For All">
													   <span class="input-group-btn">
															<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('CONT','txtContId','mycontent','#mymodal')">
															   <i class="fa fa-search"></i>
															</a>
													   </span>
												   </div>  
											   </div>
											   
									   </div>
									   <!--/.form group -->
										
									  <!-- form group -->
									  <div class="form-group">
									   
										   <!--Grade-->
											<label class="col-sm-3 control-label">Grade : </label>
											<div class="col-sm-3">
												<div class="input-group">
												   <input class="form-control" id="txtGradeId" name="txtGradeId" value="<%=sGradeId%>" maxlength="10" style="text-transform: uppercase" placeholder="Empty For All">
												   <span class="input-group-btn">
														<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('GRADE','txtGradeId','mycontent','#mymodal')">
														   <i class="fa fa-search"></i>
														</a>
												   </span>
											   </div>
										   </div>

									  </div>
									  <!--/.form group -->

										<%end if%>

									<%end if%>
                               
								<!-- form group -->
								<div class="form-group">
									<!--Page Break-->
									<label class="col-sm-3 control-label">Page Break : </label>
									<div class="col-sm-3">
										<select id="cboPageBreak" name="cboPageBreak" class="form-control">
											<option value="N" <%if sPageBreak = "N" then%>Selected<%end if%>>No</option>
											<option value="Y" <%if sPageBreak = "Y" then%>Selected<%end if%>>Yes</option>
										</select>
									</div>
								</div>
								<!--/.form group -->



                                	
								<!-- Footer Button -->
								<div class="box-footer">
									<div class="form-group">
										<div class="col-sm-12" >
											<button type="button" id="A4" class="btn btn-info pull-left" style="width: 150px;background-color:yellow;color:black;pointer-events: none;border-radius: 0px;">A4 Landscape</button>
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
    $('#btndt_date').click(function () {
        $('#dtpFrDate').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtpToDate').datepicker("show");
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
	
	<script>
    function DisExtra(){
	var s = document.getElementById("cboDisType").value;
	if ( s == "N"){
		$("#DisSubType").hide();
		document.getElementById("cboDisType").value;
		}
	else if (s == "B"){
		$("#DisSubType").hide();
	}
	else
	{
		$("#DisSubType").show();
	}
	};
    </script>
  		
	<!--Reset Button-->
    <script>
	function txtReset()
	{
		document.getElementById("txtEmpCode").value = "";
		document.getElementById("txtDeptId").value = "";
		document.getElementById("txtCostId").value = "";
		document.getElementById("txtSup_CODE").value = "";
		document.getElementById("txtContId").value = "";
	    document.getElementById("txtGradeId").value = "";
		document.getElementById("dtJoinDate").value = "";
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

  	    var search = document.getElementById("txtSearch");
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
 			
		if (pType=="DEPT") {
	  	    xhttp.open("GET", "ajax/ax_csview_deptId.asp?"+str, true);
	  	} else if(pType=="GRADE") {
	  		xhttp.open("GET", "ajax/ax_csview_gradeId.asp?"+str, true);
  		} else if(pType=="COST") {
  			xhttp.open("GET", "ajax/ax_csview_costId.asp?"+str, true);
		} else if(pType=="CONT") {  		
			xhttp.open("GET", "ajax/ax_csview_contId.asp?"+str, true);
		} else if(pType=="EMP") {  		
			xhttp.open("GET", "ajax/ax_csview_empId.asp?"+str, true);
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
	   
		<%if sType <> "ET" and sType <> "SS" and sType <> "EMT" then%>
			sDisType = Form1.cboDisType.value;
			sGradeId = Form1.txtGradeId.value;
			sContId = Form1.txtContId.value;
		<%end if%>
		
		sEmpCode = Form1.txtEmpCode.value;
		sDeptId = Form1.txtDeptId.value;
		sCostId = Form1.txtCostId.value;
		sSup_Code = Form1.txtSup_CODE.value;
		
		<%if sType = "EMT" then%>
			sEmpCode = Form1.txtEmpCode.value;
		<%else%>
			sSubType = Form1.selType.value;
		<%end if%>
		
		sType = Form1.txtType.value;
		sFrDate = Form1.dtpFrDate.value;
		sToDate = Form1.dtpToDate.value;
	    sPageBreak = Form1.cboPageBreak.value;
	    
	    if (sFrDate == "") {
	      alert("Invalid From Date");
	      return false;
	    }
	    if (sToDate == "") {
	      alert("Invalid To Date");
	      return false;
	    }
		
		sURL= "dtFrDate=" + sFrDate + "&" ;
	    sURL= sURL + "dtToDate=" + sToDate + "&";
		
		<%if sType <> "EMT" then%>
			sURL= sURL + "txtSubType=" + sSubType + "&";
		<%end if%>
		
		<%if sType <> "ET" and sType <> "SS" and sType <> "EMT" then%>
			sURL= sURL + "cboDisType=" + sDisType + "&";
			sURL= sURL + "txtGradeId=" + sGradeId + "&";
			sURL= sURL + "txtContId=" + sContId + "&";
		<%end if%>
		
		sURL= sURL + "txtSup_CODE=" + sSup_Code + "&";
		sURL= sURL + "txtEmpCode=" + sEmpCode + "&";
		sURL= sURL + "txtDeptId=" + sDeptId + "&";
		sURL= sURL + "txtCostId=" + sCostId + "&";
		
		sURL= sURL + "cboPageBreak=" + sPageBreak;
		
		if (sType == "SD") {
			window.open("csprint_sd.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
	 	} else if (sType == "ES") {
	 		window.open("csprint_es.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
	 	} else if (sType == "ED") {
	 		window.open("csprint_ed.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
	 	} else if (sType == "ET") {
	 		window.open("csprint_et.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
	 	} else if (sType == "SS") {
	 		window.open("csprint_ss.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
	 	} else if (sType == "EMT") {
	 		window.open("csprint_emt.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
	 	}
	 }
	 
	 function exportReport() {

	   var sURL = "";
	   
		<%if sType <> "ET" and sType <> "SS" and sType <> "EMT" then%>
			sDisType = Form1.cboDisType.value;
			sGradeId = Form1.txtGradeId.value;
			sContId = Form1.txtContId.value;
		<%end if%>
		
		sEmpCode = Form1.txtEmpCode.value;
		sDeptId = Form1.txtDeptId.value;
		sCostId = Form1.txtCostId.value;
		sSup_Code = Form1.txtSup_CODE.value;
		
		<%if sType = "EMT" then%>
			sEmpCode = Form1.txtEmpCode.value;
		<%else%>
			sSubType = Form1.selType.value;
		<%end if%>
		
		sType = Form1.txtType.value;
		sFrDate = Form1.dtpFrDate.value;
		sToDate = Form1.dtpToDate.value;
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
		
		<%if sType <> "EMT" then%>
			sURL= sURL + "txtSubType=" + sSubType + "&";
		<%end if%>
		
		<%if sType <> "ET" and sType <> "SS" and sType <> "EMT" then%>
			sURL= sURL + "cboDisType=" + sDisType + "&";
			sURL= sURL + "txtGradeId=" + sGradeId + "&";
			sURL= sURL + "txtContId=" + sContId + "&";
		<%end if%>
		
		sURL= sURL + "txtSup_CODE=" + sSup_Code + "&";
		sURL= sURL + "txtEmpCode=" + sEmpCode + "&";
		sURL= sURL + "txtDeptId=" + sDeptId + "&";
		sURL= sURL + "txtCostId=" + sCostId + "&";

	    window.open("csrpt_export.asp?" + sURL);
 
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
	
	$( "#txtDeptId" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DP",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDeptId").val(ui.item.value);
				var str = document.getElementById("txtDeptId").value;
				var res = str.split(" | ");
				document.getElementById("txtDeptId").value = res[0];
			},0);
		}
	});	
	
	$( "#txtGradeId" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=GC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtGradeId").val(ui.item.value);
				var str = document.getElementById("txtGradeId").value;
				var res = str.split(" | ");
				document.getElementById("txtGradeId").value = res[0];
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
	
	$( "#txtContId" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CT",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtContId").val(ui.item.value);
				var str = document.getElementById("txtContId").value;
				var res = str.split(" | ");
				document.getElementById("txtContId").value = res[0];
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
