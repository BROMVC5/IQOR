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
    sMainURL = "msmaster_export.asp?"      	
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ms.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
            <%if sType = "ET" then %>
                <h1>Export Entitlment Type</h1>
			<%elseif sType = "EN" then %>
				<h1>Export Entitlment</h1>
			<%elseif sType = "FM" then %>
				<h1>Export Family</h1>
			<%elseif sType = "PC" then %>
				<h1>Export Panel Clinic</h1>
            <%end if%>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form name="Form1" class="form-horizontal" action="cpmaster_export.asp" method="post">
                        	<input type="hidden" name="txtType" id="txtType" value="<%=sType%>">
                            <div class="box box-info">   
								<%if sType = "ET" then %>
     						   <!--body start-->
                               <div class="box-body">
								   <div class="form-group">
										<label class="col-sm-3 control-label">Entitlement Type : </label>
										<div class="col-sm-5">
											<div class="input-group">
											   <input class="form-control" id="txtEn_Name" name="txtEn_Name" value="<%=sEnType%>" maxlength="50" style="text-transform: uppercase" placeholder="EMPTY FOR ALL" input-check  >
											   <span class="input-group-btn">
													<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('EN','txtEn_Name','mycontent','#mymodal')">
													   <i class="fa fa-search"></i>
													</a>
											   </span>
										   </div>
										</div>
									</div>
								   <!--/.form group -->
								<%elseif sType = "EN" then%>
									<div class="form-group" style = "margin-top:10px;">
										<label class="col-sm-3 control-label">Entitlement Type : </label>
										<div class="col-sm-5">
											<div class="input-group">
											   <input class="form-control" id="txtEn_Name" name="txtEn_Name" value="<%=sEnType%>" maxlength="50" style="text-transform: uppercase" placeholder="EMPTY FOR ALL" input-check  >
											   <span class="input-group-btn">
													<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('EN','txtEn_Name','mycontent','#mymodal')">
													   <i class="fa fa-search"></i>
													</a>
											   </span>
										   </div>
										</div>
									</div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Grade Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtGrade_ID" name="txtGrade_ID" value="<%=sGrade_ID%>" maxlength="6" style="text-transform: uppercase" placeholder="EMPTY FOR ALL" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('GRADE','txtGrade_ID','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Designation : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtDesig" name="txtDesig" value="<%=sDesign%>" maxlength="30" style="text-transform: uppercase" placeholder="EMPTY FOR ALL" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('DES','txtDesig','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
								<%elseif sType = "FM" then %>
									<div class="form-group" style = "margin-top:10px;">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
												<%if sEmp_ID <> "" then%>
													<span class="mod-form-control"><% response.write sEmp_ID %> </span>
													<input type="hidden" id="txtEmp_ID" name="txtEmp_ID" value='<%=sEmp_ID%>' />
												<%else%>
                                                <input class="form-control" id="txtEmp_ID" name="txtEmp_ID" value="<%=sEmp_ID%>" maxlength="10" style="text-transform: uppercase" placeholder="EMPTY FOR ALL" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('EMP','txtEmp_ID','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
												<%end if%>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Name : </label>
                                        <div class="col-sm-5">
											<%if sEmp_ID <> "" then%>
												<span class="mod-form-control" ><% response.write sEmpName %> </span>
												<input type="hidden" id="txtEmp_Name" name="txtEmp_Name" value='<%=sEmpName%>' />
											<%else%>
												<input class="form-control" id="txtEmp_Name" name="txtEmp_Name" value="<%=sEmpName%>" maxlength="50" placeholder="EMPTY FOR ALL">
											<%end if%>
                                        </div>
                                    </div>
									<div class="form-group" hidden>
                                        <label class="col-sm-3 control-label">Resignation Date : </label>
                                        <div class="col-sm-3">
												<%if sEmp_ID <> "" then%>
													<span class="mod-form-control"><% response.write dtResign %> </span>
													<input type="hidden" id="dt_Resign" name="dt_Resign" value='<%=dtResign%>' />
												<%else%>
                                                <input class="form-control" id="dt_Resign" name="dt_Resign" value="<%=dtResign%>" type="text" READONLY>
												<%end if%>
                                        </div>
                                    </div>
								<%elseif sType = "PC" then %>
									<div class="form-group" style = "margin-top:10px;">
                                        <label class="col-sm-3 control-label">Panel Clinic Code: </label>
                                        <div class="col-sm-5">
                                            <div class="input-group">
                                                <input class="form-control" id="txtPanelCode" name="txtPanelCode" value="<%=sPanelCode%>" maxlength="50" style="text-transform: uppercase" placeholder="EMPTY FOR ALL" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('PC','txtPanelCode','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
								<%end if%>
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
								 <!-- Footer Button -->
                                 <div class="box-footer">
                                 	 <button type="button" name="sub" value="reset" class="btn bg-purple" style="width: 94px" onclick="txtReset();">Clear</button>
									 <button type="button" name="sub" value="print" class="btn bg-green-active pull-right" style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
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
	
	$(document).ready(function(){
		<%if sType = "ET" OR sType = "EN" then%>
			document.getElementById('txtEn_Name').focus();
		<%elseif sType = "FM" then%>
			document.getElementById('txtEmp_ID').focus();
		<%elseif sType = "PC" then%>
			document.getElementById('txtPanelCode').focus();
		<%end if%>
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
  	    
		if (pType=="EN") {
			var search = document.getElementById("txtSearch_en");
		}else if (pType=="EMP") { 
            var search = document.getElementById("txtSearch_emp");
		}else if (pType=="PC") { 
            var search = document.getElementById("txtSearch_pc");
        }else if (pType=="DES") { 
            var search = document.getElementById("txtSearch_desig");
		}else if (pType=="GRADE") { 
            var search = document.getElementById("txtSearch_grade");
		}
		
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
			
		if (pType=="EN") {
			xhttp.open("GET", "ajax/ax_msview_enid.asp?"+str, true);
        }else if (pType=="PC") {
			xhttp.open("GET", "ajax/ax_msview_pc.asp?"+str, true);
		}else if (pType=="EMP") {
	  	    xhttp.open("GET", "ajax/ax_view_empid2.asp?"+str, true);
	  	}else if (pType=="DES") {
	  	    xhttp.open("GET", "ajax/ax_msview_tmdesign.asp?"+str, true);
		}else if (pType=="GRADE") {
	  	    xhttp.open("GET", "ajax/ax_msview_gradeid.asp?"+str, true);
		}
		
  	    xhttp.send();
    }
	 
	</script>
  		
	<!--Reset Button-->
    <script>
	function txtReset()
	{	
		<%if sType = "FM" then %>
			document.getElementById("txtEmp_ID").value = "";
			document.getElementById("txtEmp_Name").value = "";
		<%elseif sType = "ET" or sType = "EN" then %>
			document.getElementById("txtEn_Name").value = "";
			document.getElementById("txtGrade_ID").value = "";
			document.getElementById("txtDesig").value = "";
		<%elseif sType = "PC" then %>
			document.getElementById("txtPanelCode").value = "";
		<%end if%>
	}
	</script>
	
	<!--open modal-->
	
	<!--Print Button-->
	
	<script>
	
	function exportReport() {
		<%if sType = "ET" then %>
		   var sURL = "";
			
			sType = Form1.txtType.value;
			sEnType = Form1.txtEn_Name.value;
			sStatus = Form1.sStatus.value; 

			sURL= "txtType=" + sType + "&" ;
			sURL= sURL + "txtEn_Name=" + sEnType + "&" ;
			sURL= sURL + "sStatus=" + sStatus + "&";

			window.open("msmain_export.asp?" + sURL);
			
		<%elseif sType = "EN" then%>
			var sURL = "";
			
			sType = Form1.txtType.value;
			sEnType = Form1.txtEn_Name.value;
			sGrade_ID = Form1.txtGrade_ID.value;
			sDesign = Form1.txtDesig.value;
			sStatus = Form1.sStatus.value; 

			sURL= "txtType=" + sType + "&" ;
			sURL= sURL + "txtEn_Name=" + sEnType + "&" ;
			sURL= sURL + "txtGrade_ID=" + sGrade_ID + "&" ;
			sURL= sURL + "txtDesig=" + sDesign + "&" ;
			sURL= sURL + "sStatus=" + sStatus + "&";

			window.open("msmain_export.asp?" + sURL);
		
		<%elseif sType = "FM" then%>
			var sURL = "";
			
			sType = Form1.txtType.value;
			sEmp_ID = Form1.txtEmp_ID.value;
			sEmpName = Form1.txtEmp_Name.value;
			sStatus = Form1.sStatus.value; 

			sURL= "txtType=" + sType + "&" ;
			sURL= sURL + "txtEmp_ID=" + sEmp_ID + "&" ;
			sURL= sURL + "txtEmp_Name=" + sEmpName + "&" ;
			sURL= sURL + "sStatus=" + sStatus + "&";

			window.open("msmain_export.asp?" + sURL);
		
		<%elseif sType = "PC" then%>
			var sURL = "";
			
			sType = Form1.txtType.value;
			sPanelCode = Form1.txtPanelCode.value;
			sStatus = Form1.sStatus.value; 

			sURL= "txtType=" + sType + "&" ;
			sURL= sURL + "txtPanelCode=" + sPanelCode + "&" ;
			sURL= sURL + "sStatus=" + sStatus + "&";

			window.open("msmain_export.asp?" + sURL);
		<%end if%>
	 }
	 
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
	
	$( "#txtGrade_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=GC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtGrade_ID").val(ui.item.value);
				var str = document.getElementById("txtGrade_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtGrade_ID").value = res[0];
			},0);
		}
	});	
	
	$( "#txtDesig" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DS",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDesig").val(ui.item.value);
				var str = document.getElementById("txtDesig").value;
				var res = str.split(" | ");
				document.getElementById("txtDesig").value = res[0];
			},0);
		}
	});	
	
	$( "#txtEmp_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEmp_ID").val(ui.item.value);
				var str = document.getElementById("txtEmp_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtEmp_ID").value = res[0];
				document.getElementById("txtEmp_Name").value = res[1];
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
