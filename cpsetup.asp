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
		sSC = reqForm("txtSC_ID")
	    sEmpCode = reqForm("txtEmp_ID")
		dtFrADate = reqForm("dtFrADate")
		dtToADate = reqForm("dtToADate")
		sSendMail = reqForm("sSendMail")
        dRefStrt = reqForm("dRefStrt")
        dRefRun = reqForm("dRefRun")
        sCutOff = reqForm("dtCutOff")
        sLtsRef = reqForm("sLtsRef")
            
        dtDiff = DateDiff("d",dtFrADate,dtToADate)
        if dtDiff < 0 then 
            call alertbox("Date must be future")
        end if
		
		sCheckdtCutOff = InStr( sCutOff, "_" )
		
		if sCheckdtCutOff <> "0" then
			call alertbox("Cut off time Invalid Format")
		end if

	    if sModeSub = "save" Then      
	    	if sSC = "" then
	            call alertbox("Security Manager cannot be empty") 
			else
	        	Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmemply where EMP_CODE ='" & sSC & "'" 
	            rstTMEmply.Open sSQL, conn, 3, 3
				if rstTMEmply.eof then
	                call alertbox("Employee Code Security Manager : " & sSC & " does not exist !")
	            else
	            	Set rstOGPath = server.CreateObject("ADODB.RecordSet")    
		            sSQL = "select * from cppath "
		            rstOGPath.Open sSQL, conn, 3, 3		            
		            if not rstOGPath.eof then
		            
						Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
						sSQL = "select * from tmemply where EMP_CODE ='" & sEmpCode & "'" 
						rstTMEmply.Open sSQL, conn, 3, 3
						if rstTMEmply.eof then
							call alertbox("Employee Code : " & sEmpCode & " does not exist !")
						else
							sSQL = "UPDATE cppath SET "                      
							sSQL = sSQL & "HR_MAN = '" & pRTIN(sSC) & "',"
							sSQL = sSQL & "EMP_CODE = '" & pRTIN(sEmpCode) & "',"
                            sSQL = sSQL & "LTSREF = '" & pRTIN(sLtsRef) & "',"
                            sSQL = sSQL & "SREFST = '" & dRefStrt & "',"
                            sSQL = sSQL & "SREFRUN = '" & dRefRun & "',"
							if dtFrADate = "" then
								sSQL = sSQL & "DT_FROM = NULL," 
							else
								sSQL = sSQL & "DT_FROM = '" & fDate2(dtFrADate) & "'," 
							end if
							if dtToADate = "" then
								sSQL = sSQL & "DT_TO = NULL,"
							else
								sSQL = sSQL & "DT_TO = '" & fDate2(dtToADate) & "',"
							end if
                            sSQL = sSQL & "DT_CUT = '" & sCutOff & "',"
							sSQL = sSQL & "SENDMAIL = '" & sSendMail & "',"
							sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"       
							sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
							conn.execute sSQL
							call alertbox("Update Successful") 
						end if
							
		 			else
		 				     			
				        sSQL = "insert into cppath (DT_CUT,HR_MAN ,EMP_CODE, DT_FROM, DT_TO, SENDMAIL,CREATE_ID, DT_CREATE, LTSREF, SREFST, SREFRUN) "
			            sSQL = sSQL & "values ("
						sSQL = sSQL & "'" & pRTIN(sSC) & "',"
					    sSQL = sSQL & "'" & pRTIN(sEmpCode) & "',"
                        sSQL = sSQL & "'" & pRTIN(sLtsRef) & "',"
					    if dtFrADate = "" then
							sSQL = sSQL & "NULL,"
						else
							sSQL = sSQL & "'" & fDate2(dtFrADate) & "',"
						end if
						if dtToADate = "" then
							sSQL = sSQL & "NULL,"
						else
							sSQL = sSQL & "'" & fDate2(dtToADate) & "',"
						end if
                        sSQL = sSQL & "'" & sCutOff & "',"
						sSQL = sSQL & "'" & sSendMail & "',"
                        sSQL = sSQL & "'" & dRefStrt & "',"
                        sSQL = sSQL & "'" & dRefRun & "',"
					    sSQL = sSQL & "'" & session("USERNAME") & "'," 
					    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
			            sSQL = sSQL & ") "
			 	  	    conn.execute sSQL
				 	  	call alertbox("Save Successful")      
			        end if  
		            call pCloseTables(rstOGPath)
					   
				end if
	            pCloseTables(rstTMEmply)
	        end if
			
		elseif sModeSub = "optimize" then
			
			sSQL = "OPTIMIZE TABLE cpreg, cpresv"
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
	
	Set rstCPPath = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from cppath "
    rstCPPath.Open sSQL, conn, 3, 3
    if not rstCPPath.eof then

        sCutOff = rstCPPath("DT_CUT")
    	sSC = rstCPPath("HR_MAN")
		sEmpCode = rstCPPath("EMP_CODE")
        sLtsRef = rstCPPath("LTSREF")
		dtFrADate = rstCPPath("DT_FROM")
		dtToADate = rstCPPath("DT_TO")
		sSendMail = rstCPPath("SENDMAIL")
        dRefStrt = rstCPPath("SREFST")
        dRefRun = rstCPPath("SREFRUN")
	end if
	call pCloseTables(rstCPPath)
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cp.asp" -->

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
                        	<form class="form-horizontal" action="cpsetup.asp" method="post">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">

	                        	  <!-- HR Manager -->
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">Security Manager : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<input class="form-control" id="txtSC_ID" name="txtSC_ID" value="<%=sSC%>" maxlength="8" style="text-transform: uppercase" input-check />
												<span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('SC','txtSC_ID','mycontent','#mymodal')">
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
				                             	<select id="sSendMail" name="sSendMail" class="form-control">
	                                                <option value="Y" <%if sSendMail = "Y" then%>Selected<%end if%>>Yes</option>
                                                	<option value="N" <%if sSendMail = "N" then%>Selected<%end if%>>No</option>
                                            	</select>
                                        </div>
									</div>
                                   <!-- Cut-Off Time -->
                              	   <div class="form-group">
                                        <div class="col-sm-3">
                                            <label class="control-label">Cut Off Time : </label>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                 <input id="dtCutOff" name="dtCutOff" value='<%=fTime(sCutOff)%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask >
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                </div>

								<hr style="border-top: dotted 1px #cecece;">
								<div class="box-body">
									<div class="form-group">
										<h3 style="margin-left:10px;">Acting Security Manager
										</h3>
									</div> 
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">Employee Code : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<input class="form-control" id="txtEmp_ID" name="txtEmp_ID" value="<%=sEmpCode%>" maxlength="8" style="text-transform: uppercase" input-check />
												<span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('EMP','txtEmp_ID','mycontent','#mymodal')">
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
												<input id="dtFrADate" name="dtFrADate" value="<%=dtFrADate%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_FrAdate" class="btn btn-default" style="margin-left: 0px">
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
												<input id="dtToADate" name="dtToADate" value="<%=dtToADate%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_ToAdate" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>  
									</div> 

									<div class="form-group">
										<div class="col-sm-3">
											<label class="control-label">Last Sticker Number : </label>
										</div>
										<div class="col-sm-3">
											<div>
												<input class="form-control" id="sLtsRef" name="sLtsRef" value="<%=sLtsRef%>" maxlength="12"/>
											</div>
										</div>
                                        <!--Decimal Start-->
                                        <div class="col-sm-1">
				                             	<select id="dRefStrt" name="dRefStrt" class="form-control">
	                                                <option value="0" <%if dRefStrt = "0" then%>Selected<%end if%>>0</option>
                                                	<option value="1" <%if dRefStrt = "1" then%>Selected<%end if%>>1</option>
                                                    <option value="2" <%if dRefStrt = "2" then%>Selected<%end if%>>2</option>
                                                	<option value="3" <%if dRefStrt = "3" then%>Selected<%end if%>>3</option>
                                                    <option value="4" <%if dRefStrt = "4" then%>Selected<%end if%>>4</option>
                                                	<option value="5" <%if dRefStrt = "5" then%>Selected<%end if%>>5</option>
                                                    <option value="6" <%if dRefStrt = "6" then%>Selected<%end if%>>6</option>
                                                	<option value="7" <%if dRefStrt = "7" then%>Selected<%end if%>>7</option>
                                                    <option value="8" <%if dRefStrt = "8" then%>Selected<%end if%>>8</option>
                                                	<option value="9" <%if dRefStrt = "9" then%>Selected<%end if%>>9</option>
                                            	</select>
                                        </div>
                                        <!--Decimal Run-->
										<div class="col-sm-1">
				                             	<select id="dRefRun" name="dRefRun" class="form-control">
	                                                <option value="0" <%if dRefRun = "0" then%>Selected<%end if%>>0</option>
                                                	<option value="1" <%if dRefRun = "1" then%>Selected<%end if%>>1</option>
                                                    <option value="2" <%if dRefRun = "2" then%>Selected<%end if%>>2</option>
                                                	<option value="3" <%if dRefRun = "3" then%>Selected<%end if%>>3</option>
                                                    <option value="4" <%if dRefRun = "4" then%>Selected<%end if%>>4</option>
                                                	<option value="5" <%if dRefRun = "5" then%>Selected<%end if%>>5</option>
                                                    <option value="6" <%if dRefRun = "6" then%>Selected<%end if%>>6</option>
                                                    <option value="7" <%if dRefRun = "7" then%>Selected<%end if%>>7</option>
                                                	<option value="8" <%if dRefRun = "8" then%>Selected<%end if%>>8</option>
                                                    <option value="9" <%if dRefRun = "9" then%>Selected<%end if%>>9</option>
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
    <script>
    $(function () {

	//Time mask
	$("[data-mask]").inputmask();
		
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

		if (pType=="EMP") { 
            var search = document.getElementById("txtSearch_emp");
        }else if (pType=="SC") {
			var search = document.getElementById("txtSearch_sc");
		}
		
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
		
		if (pType=="SC") {
	  		xhttp.open("GET", "ajax/ax_cpview_hrid.asp?"+str, true);
		}else if (pType=="EMP") {
			xhttp.open("GET", "ajax/ax_cpview_empid.asp?"+str, true);
		}
  	    xhttp.send();
    }
	</script>
	
	<script>
	$(document).ready(function(){
		document.getElementById('txtSC_ID').focus();   
	});
	
	$( "#txtSC_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=HR",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtSC_ID").val(ui.item.value);
				var str = document.getElementById("txtSC_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtSC_ID").value = res[0];
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
			},0);
		}
	});	
	
	</script>

	<!--Script End-->
	

</body>
</html>
