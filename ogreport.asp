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

    
<%#@~^ZQEAAA==@#@&dd:Xa+P{PMn;!+dYvJOza+J*@#@&,PP,[OfmYPxP.n$sGDscJ9Y29mY+Eb,P@#@&,~,P@#@&P,PP9Yw.fmYnP{P.n$sWMh`rNYao.fmYJb@#@&~,P~NDPWGlOn,'P.n$sGDscrNOaKKflD+rb@#@&P~P,/3haZW9nP{PD5oWM:vJO6O3sw/W9nJ*@#@&~,PPd9wOq9~{P.;wWDs`rO6DfnwDq[E*@#@&,~P,/MMC[+&N,'~Dn5wW.:vEYXY!.mN+([r#@#@&,~,Pd;WkYq9P{~D;oWM:cED6Y;G/DqNrb@#@&,P,PdZGUDq[P{~D;oGM:`EOXY/W	O&NE*@#@&@#@&@#@&m2AAAA==^#~@%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_og.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
            <%#@~^FQAAAA==r6Pd:Xa+P{Pr)MrPOtx~PAYAAA==^#~@%>
                <h1>Print Aging Report</h1>
            <%#@~^GQAAAA==n^/nb0,/KHw~',J6frPO4xP8AcAAA==^#~@%>
            	<h1>Print Overdue Outgoing Goods Report</h1>
            <%#@~^GQAAAA==n^/nb0,/KHw~',J6MrPO4xP8wcAAA==^#~@%>
            	<h1>Print Outgoing Goods Report</h1>
            <%#@~^GQAAAA==n^/nb0,/KHw~',JJsrPO4xP7wcAAA==^#~@%>
            	<h1>Print Log File</h1>
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
									<%#@~^JQAAAA==r6Pd:Xa+P{Pr)MrPGD,/Pza+P{~J}fJ,O4+	PxgoAAA==^#~@%>
										<!-- form group -->
										<div class="form-group">
										<!--Today Date-->
										<label class="col-sm-3 control-label">Date : </label>
										
										<div class="col-sm-3">
											<div class="input-group">
												<input id="dtpDate" name="dtpDate" value="<%=#@~^EAAAAA==W9lOVKxovxKA`*#qgUAAA==^#~@%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>
										
										</div>
										<!--/.form group -->
								  		<%#@~^FQAAAA==r6Pd:Xa+P{Pr)MrPOtx~PAYAAA==^#~@%>
											<!-- form group -->
											<div class="form-group">
												<!--Quantity-->
												
													<label class="col-sm-3 control-label">Aging Day : </label>
												
												<div class="col-sm-3">
													<input class="form-control" id="txtDay" name="txtDay" value="60" maxlength="10" onkeypress='return isNumberKey(event)' style="text-align:right;">
												</div>
											</div>
											<!--/.form group -->
										<%#@~^BwAAAA==n	N~b0,RgIAAA==^#~@%>
									
								  	<%#@~^GQAAAA==n^/nb0,/KHw~',J6MrPO4xP8wcAAA==^#~@%>
									<!--From Date-->
									<div class="form-group">
										
											<label class="col-sm-3 control-label">From Date : </label>
										
										<div class="col-sm-3">
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
										<div class="col-sm-3">
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
									
									<%#@~^GQAAAA==n^/nb0,/KHw~',JJsrPO4xP7wcAAA==^#~@%>
									<!--From Date-->
									<div class="form-group">
										
											<label class="col-sm-3 control-label">From Date : </label>
										
										<div class="col-sm-3">
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
										<div class="col-sm-3">
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

                                <%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                                <div class="form-group">
									<!--Page Break-->
									
										<label class="col-sm-3 control-label">Page Break : </label>
									
									<div class="col-sm-3">
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
  	    
  	    else if (pType == "DEPT") {
  	    var search = document.getElementById("txtSearch2");
  	    }
		else {
  	    var search = document.getElementById("txtSearch");
  	    }
  	    
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
 			
		if (pType=="DEPT") {
	  	    xhttp.open("GET", "ajax/ax_ogview_deptId.asp?"+str, true);
	  	} else if(pType=="GRADE") {
	  		xhttp.open("GET", "ajax/ax_ogview_gradeId.asp?"+str, true);
  		} else if(pType=="COST") {
  			xhttp.open("GET", "ajax/ax_ogview_costId.asp?"+str, true);
		} else if(pType=="CONT") {  		
			xhttp.open("GET", "ajax/ax_ogview_contId.asp?"+str, true);
		} else if(pType=="EMP") {  		
			xhttp.open("GET", "ajax/ax_ogview_empId.asp?"+str, true);
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
		
		if (sType == "AG") {
			
			sDate = Form1.dtpDate.value;
			sDay = Form1.txtDay.value;
	
		    if (sDate == "") {
		      alert("Invalid Date");
		      return false;
		    }
		    	    
		    if (sDay == "") {
		      alert("Invalid Aging Day");
		      return false;
		    }
	
			
		    sURL= "dtDate=" + sDate + "&" ;
		    sURL= sURL + "sDay=" + sDay + "&";
			sURL= sURL + "cboPageBreak=" + sPageBreak;
			
			window.open("ogprint_ag.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
		} 
		
		if (sType == "OD") {
			sDate = Form1.dtpDate.value;
			
			if (sDate == "") {
		      alert("Invalid Date");
		      return false;
		    }
		    
			sURL= "dtDate=" + sDate + "&";
			sURL= sURL + "cboPageBreak=" + sPageBreak;
			
			window.open("ogprint_od.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
		}
		
		if (sType == "OG") {
			sFrDate = Form1.dtpFrDate.value;
			sToDate = Form1.dtpToDate.value;
		    
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
		    sURL= sURL + "dtToDate=" + sToDate + "&" ;
		    sURL= sURL + "cboPageBreak=" + sPageBreak ;
			
			window.open("ogprint_og.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
		}
		
		if (sType == "LF") {
			sFrDate = Form1.dtpFrDate.value;
			sToDate = Form1.dtpToDate.value;
		    
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
		    sURL= sURL + "dtToDate=" + sToDate + "&" ;
		    sURL= sURL + "cboPageBreak=" + sPageBreak ;
			
			window.open("ogprint_lf.asp?" + sURL, "mswindow","width=850,height=800,top=0,left=100,scrollbars=yes,toolbar=no");
		}
		
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
 	
 	$(document).ready(function() {
		$("#txtDay").keydown(function (e) {
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
	
	$('#txtDay').keyup(function () {
		if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
       this.value = this.value.replace(/[^0-9\.]/g, '');
		}
	});


    </script>
    
    <!-- Export Excel -->
	<script>

 	 function exportReport() {

	   var sURL = "";
	   
		sType = Form1.txtType.value;
		if (sType == "AG"){
			sDate = Form1.dtpDate.value;
			sDay = Form1.txtDay.value;
	
		    if (sDate == "") {
		      alert("Invalid Date");
		      return false;
		    }
		    	    
		    if (sDay == "") {
		      alert("Invalid Aging Day");
		      return false;
		    }
	
			sURL= "txtType=" + sType + "&" ;
		    sURL= sURL + "dtDate=" + sDate + "&" ;
		    sURL= sURL + "sDay=" + sDay ;    
		}
		
		if (sType == "OG"){
			sFrDate = Form1.dtpFrDate.value;
			sToDate = Form1.dtpToDate.value;
		    
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
			sURL= "txtType=" + sType + "&" ;
		    sURL= sURL + "dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate ;
		}
		
		if (sType == "OD"){
			sDate = Form1.dtpDate.value;
			
			if (sDate == "") {
		      alert("Invalid Date");
		      return false;
		    }
		    
			
			sURL= "txtType=" + sType + "&" ;
		    sURL= sURL + "dtDate=" + sDate ;		
		}
		
		if (sType == "LF"){
			sFrDate = Form1.dtpFrDate.value;
			sToDate = Form1.dtpToDate.value;
		    
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
		    
			sURL= "txtType=" + sType + "&" ;
		    sURL= sURL + "dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate ;
		}

	    window.open("ogrpt_export.asp?" + sURL);
 
	 }
	 
	</script>

    
	<!--Script End-->
	

</body>
</html>
