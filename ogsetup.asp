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

	sModeSub = request("sub")
	
	if sModeSub <> "" Then
		sFinMan = reqForm("txtFinMan")
	    sEmpCode = reqForm("txtEmpCode")
	    sSendMail = reqForm("cboSendMail")
	    dtFrDate = reqForm("dtpFrDate")
     	dtToDate = reqForm("dtpToDate")
     	
     	if sFinMan = "" then
            call alertbox("Finance Manager cannot be empty")
        else
			Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tmemply where EMP_CODE ='" & sFinMan & "'" 
            rstTMEmply.Open sSQL, conn, 3, 3
			if rstTMEmply.eof then
                call alertbox("Employee Code : " & sFinMan & " does not exist !")
            end if
            call pCloseTables(rstTMEmply)
        end if    
        
     	if sEmpCode <> "" then
   			Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tmemply where EMP_CODE ='" & sEmpCode & "'" 
            rstTMEmply.Open sSQL, conn, 3, 3
			if rstTMEmply.eof then
                call alertbox("Employee Code : " & sEmpCode & " does not exist !")
            end if
            call pCloseTables(rstTMEmply)
        end if

		dtDiff = DateDiff("d",dtFrDate,dtToDate)
		if dtDiff < 0 then 
			call alertbox("Date must be future")
		end if
 
	    if sModeSub = "save" Then
	    	
	    	Set rstOGPath = server.CreateObject("ADODB.RecordSet")    
	        sSQL = "select * from ogpath "
	        rstOGPath.Open sSQL, conn, 3, 3		            
	        if not rstOGPath.eof then
	            sSQL = "UPDATE ogpath SET "             
	            sSQL = sSQL & "FIN_MAN = '" & pRTIN(sFinMan) & "',"
	            sSQL = sSQL & "SENDMAIL = '" & pRTIN(sSendMail) & "',"         
	           	sSQL = sSQL & "EMP_CODE = '" & pRTIN(sEmpCode) & "',"
	           	if dtFrDate = "" then
	           		sSQL = sSQL & "DT_FROM = NULL," 
	            else
	           		sSQL = sSQL & "DT_FROM = '" & fDate2(dtFrDate) & "'," 
	           	end if
	           	if dtToDate = "" then
	           		sSQL = sSQL & "DT_TO = NULL,"
	           	else
	           		sSQL = sSQL & "DT_TO = '" & fDate2(dtToDate) & "',"
	           	end if	
	            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"       
	            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
	            conn.execute sSQL		
	            
	            call alertbox("Update Successful") 
			else     			
		        sSQL = "insert into ogpath (FIN_MAN, SENDMAIL, EMP_CODE, DT_FROM, DT_TO, USER_ID, DATETIME) "
	            sSQL = sSQL & "values ("
			    sSQL = sSQL & "'" & pRTIN(sFinMan) & "',"
			    sSQL = sSQL & "'" & pRTIN(sSendMail) & "',"
			    sSQL = sSQL & "'" & pRTIN(sEmpCode) & "',"
			    if dtFrDate = "" then
			    	sSQL = sSQL & "NULL,"
			    else
			    	sSQL = sSQL & "'" & fDate2(dtFrDate) & "',"
			    end if
			    if dtToDate = "" then
			    	sSQL = sSQL & "NULL,"
			    else
			    	sSQL = sSQL & "'" & fDate2(dtToDate) & "',"
			    end if
			    sSQL = sSQL & "'" & session("USERNAME") & "'," 
			    sSQL = sSQL & "'" & fDateTime2(Now()) & "'"
	            sSQL = sSQL & ") "
	 	  	    conn.execute sSQL 
	 	  	    
				call alertbox("Save Successful") 	     
	        end if  
	        call pCloseTables(rstOGPath)
		end if   
	end if
	
	Set rstOGPath = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from ogpath "
    rstOGPath.Open sSQL, conn, 3, 3
    if not rstOGPath.eof then
    	sEmpCode = rstOGPath("EMP_CODE")
		sSendMail = rstOGPath("SENDMAIL")
		sFinMan = rstOGPath("FIN_MAN")
		dtFrDate = rstOGPath("DT_FROM")
		dtToDate = rstOGPath("DT_TO")
	end if
	call pCloseTables(rstOGPath)
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_og.asp" -->

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
                        	<form class="form-horizontal" action="ogsetup.asp" method="post">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">

	                        	  <!-- Finance Manager -->
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">Finance Manager : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<input class="form-control" id="txtFinMan" name="txtFinMan" value="<%=sFinMan%>" maxlength="10" style="text-transform: uppercase" input-check />
												<span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('FIN','txtFinMan','mycontent','#mymodal')">
													<i class="fa fa-search"></i>
												</a>
												</span>
											</div>
										</div>
									</div> 
									
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">Send Mail : </label>
										</div>
										<div class="col-sm-3">
				                             	<select id="cboSendMail" name="cboSendMail" class="form-control">
	                                                <option value="Y" <%if sSendMail = "Y" then%>Selected<%end if%>>Yes</option>
                                                	<option value="N" <%if sSendMail = "N" then%>Selected<%end if%>>No</option>
                                            	</select>
                  
                                            </div>
									</div>
								<div class="box-header with-border"></div>
								<div class="box-header"></div>
								<h3>Acting Manager</h3>	
								
								<!-- Employee Code -->
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">Employee Code : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<input class="form-control" id="txtEmpCode" name="txtEmpCode" value="<%=sEmpCode%>" maxlength="10" style="text-transform: uppercase" input-check />
												<span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('EMP','txtEmpCode','mycontent','#mymodal')">
													<i class="fa fa-search"></i>
												</a>
												</span>
											</div>
										</div>
									</div>
          						 <!--From Date-->
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">From Date : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<input id="dtpFrDate" name="dtpFrDate" value="<%=dtFrDate%>" type="text" class="form-control" date-picker >
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
												<input id="dtpToDate" name="dtpToDate" value="<%=dtToDate%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>  
									</div>
									<!--/.form group -->
									
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


    <!--check numeric-->
    <script>
	 function isNumberKey(evt) {
     var charCode = (evt.which) ? evt.which : evt.keyCode;
     if (charCode != 46 && charCode > 31 
       && (charCode < 48 || charCode > 57))
        return false;
  
      return true;
 	} 
    </script>
  		
	<script>
    $(function () {

        //Time mask
        $("[data-mask]").inputmask();
    
    });

    
    </script>
	
	<!--open modal-->
	<script>
    function fOpen(pType,pFldName,pContent,pModal) {
		document.getElementById(pContent).innerHTML = ""
		showDetails('txtTicket=<%=sTicket%>',pFldName,pType,pContent)
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
		if(pType=="EMP") {
			var search = document.getElementById("txtSearch1");
		} else if (pType=="FIN") {
			var search = document.getElementById("txtSearch2");
		}
		
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
		
		if (pType=="EMP") {
	  		xhttp.open("GET", "ajax/ax_ogview_empId.asp?"+str, true);
		}if (pType=="FIN"){
		 	xhttp.open("GET", "ajax/ax_ogview_finId.asp?"+str, true);
		}
  	    xhttp.send();
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
	
	$( "#txtFinMan" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=FN",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtFinMan").val(ui.item.value);
				var str = document.getElementById("txtFinMan").value;
				var res = str.split(" | ");
				document.getElementById("txtFinMan").value = res[0];
			},0);
		}
	});
	</script>
	<!--Script End-->
	

</body>
</html>
