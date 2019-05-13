<% Server.ScriptTimeout = 1000000 %>
<!DOCTYPE html>
<html>

    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <head>

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
    sMainURL = "csafterupload.asp?"
	sMainURL2 = "csupload.asp?"
	
	sFileName = request("txtFileName")
	sType = request("selType")
	dtDisplay = request("dtpDisplay")
%>

<%  
	if sModeSub <> "" then
		sType = reqForm("selType")
		sSubType = reqForm("selType")
		dtDateTemp = reqForm("dtpDate")
		dtToDate = reqForm("dtpToDate")
		sFileName = reqForm("txtFileName")
		
		if dtDateTemp = "" then   		
			call alertbox("From Date cannot be empty")
		end if

		if dtToDate = "" then
			call alertbox("To Date cannot be empty")
		end if

		if fDate2(now()) > fDate2(dtDateTemp) then
			 call alertbox("Date must be future")
		end if
		
		dtDiff = DateDiff("d",dtDateTemp,dtToDate)
		
		if dtDiff < 0 then 
			call alertbox("Invalid Date")
		end if
			
		Server.ScriptTimeout = 1000000

		sPath = "\EXCEL\CS\"

		sDir = Server.MapPath(".") & sPath

		Set fso = Server.CreateObject("Scripting.FileSystemObject") 
		Set obj_FolderBase = fso.GetFolder(sDir)
		
		if obj_FolderBase.Files.Count = 0 then '=== Check if Employee ID record data is in
			response.write " No Employee ID Found!"
			response.End 
		end if

	 '===========================================================================================================  
		For Each obj_File In obj_FolderBase.Files  '=== For loop starts here and process every file in the folder
	 '===========================================================================================================

				strFileName = "EXCEL\CS\" & obj_File.Name
			   
				set fs = fso.OpenTextFile (Server.MapPath(strFileName), 1, False)
				if not fs.AtEndOfStream then

				Do while not fs.AtEndOfStream 
		
					strRow = fs.ReadLine

					if strRow <> "EMPLOYEE ID" then

						iPos = InStr(1, strRow, ";")
                        If iPos > 0 Then
                            sEmp_Code = Trim(Mid(strRow, 1, iPos - 1))
						else
							sEmp_Code = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                        End If
						
						'response.write " ----@@---- : " & sEmp_Code & "<br>"  
						
						dtDate = dtDateTemp
						iRange = (DateDiff("d",dtDate,dtToDate))
						
						For intID = 0 to iRange
							Set rstCSEmply1 = server.CreateObject("ADODB.RecordSet")    
							sSQL = "select * from csemply1 "
							sSQL = sSQL & "where EMP_CODE = '" & sEmp_Code & "'"
							sSQL = sSQL & "and TYPE = '" & sSubType & "'"
							sSQL = sSQL & "and DT_SUB = '" & fDate2(dtDate) & "'" 
							rstCSEmply1.Open sSQL, conn, 3, 3
							if not rstCSEmply1.eof then
									
								set rstCSType = server.CreateObject("ADODB.RecordSet")    
								sSQL = "select * from cstype where SUBTYPE = '" & sSubType & "' " 
								rstCSType.Open sSQL, conn, 3, 3
								if not rstCSType.eof then	            	
									sSQL = "UPDATE csemply1 SET "                      
									sSQL = sSQL & "EMP_CODE = '" & pRTIN(sEmp_Code) & "',"		 
									sSQL = sSQL & "TYPE = '" & pRTIN(sSubType) & "',"
									sSQL = sSQL & "DT_SUB = '" & fdate2(dtDate) & "',"
									sSQL = sSQL & "AMOUNT = '" & pFormat(rstCSType("AMOUNT"),2) & "',"
									sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
									sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "'"
									sSQL = sSQL & "WHERE EMP_CODE = '" & sEmp_Code & "'"
									sSQL = sSQL & "and DT_SUB = '" & fdate2(dtDate) & "'"
									sSQL = sSQL & "and TYPE = '" & sSubType & "'"
									conn.execute sSQL
								end if
								pCloseTables(rstCSType)
											
							else
								set rstCSEmply = server.CreateObject("ADODB.RecordSet")    
								sSQL = "select * from csemply where EMP_CODE = '" & sEmp_Code & "' "								
								rstCSEmply.Open sSQL, conn, 3, 3
								if not rstCSEmply.eof then
									set rstCSType = server.CreateObject("ADODB.RecordSet")    
									sSQL = "select * from cstype where SUBTYPE = '" & sSubType & "' " 
									rstCSType.Open sSQL, conn, 3, 3
									if not rstCSType.eof then
										sSQL = "insert into csemply1 (EMP_CODE, TYPE, DT_SUB, AMOUNT, "
										sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
										sSQL = sSQL & "values ("
										sSQL = sSQL & "'" & pRTIN(sEmp_Code) & "',"
										sSQL = sSQL & "'" & pRTIN(sSubType) & "',"	
										sSQL = sSQL & "'" & fdate2(dtDate) & "',"	 
										sSQL = sSQL & "'" & pFormat(rstCSType("AMOUNT"),2) & "',"
										sSQL = sSQL & "'" & session("USERNAME") & "',"
										sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
										sSQL = sSQL & "'" & session("USERNAME") & "',"
										sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
										sSQL = sSQL & ") "
										conn.execute sSQL
									end if
									pCloseTables(rstCSType)
								end if
								pCloseTables(rstCSEmply)
								
							end if  
							call pCloseTables(rstCSEmply1)

							dtDate = (DateAdd("d",1,dtDate))
						Next
						
					end if '==== End if strRow and isDate(sDate)
				Loop
			end if '=== End if not fs.AtEndOfStream
			pCloseTables(fs)
		Next
		'===== After inserting into move to LOG
		sFileFrom = Server.MapPath(strFileName)

		sFileTo = Server.MapPath(".") & "\EXCEL\CS\LOG\"
	
		set fsm=Server.CreateObject("Scripting.FileSystemObject")
		fsm.MoveFile sFileFrom , sFileTo
		set fsm=nothing
		call confirmBox("Update Successful!", sMainURL&"txtFileName=" & sFileName &"&selType=" & sType &"&dtpDisplay=" & fdatetime2(Now()) &"") 
	end if
 %>

	</head>


<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->
		<!-- #include file="include/clsUpload.asp" -->
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Upload Excel Generate Subsidy</h1>
            </section>
            <!-- Main content -->
            <section class="content">
            	  <!--/row -->
                <div class="row">
                	   <!-- col-md-12 -->
                    <div class="col-md-12">
                        <!-- form start -->
                        <form class="form-horizontal" action="csafterupload.asp" method="post">
                        	<!-- box box-info -->
                            <div class="box box-info">
                                <!-- box body -->
                                <div class="box-body">
									<!-- form group -->
                                   <div class="form-group">
										<label class="col-sm-3 control-label">File Name : </label>
										<div class="col-sm-3">
											<span class = "mod-form-control"><%=sFileName%></span>
											<input type="hidden" id="txtFileName" name="txtFileName" value="<%=sFileName%>" />
                                        </div>
                                   </div>
                                   <!--/.form group -->	
								   <%if dtDisplay = "" then%>
									<!-- form group -->
                                   <div class="form-group">
                                   		<!--Type-->
										<label class="col-sm-3 control-label">Type : </label>
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
								   <%if selType <> "N" then%>
                                   <div id="divType"> 
                                   <%else%>
                                   <div id="divType">	
                                   <%end if%>							
	                                   <!-- form group -->
			                           <div class="form-group">
			                           
			                           		<!--Extra Coupon From Date-->
					                        
					                        <label class="col-sm-3 control-label">From Date :</label>
											<div class="col-sm-3" >
					                            <div class="input-group">
					                                <input id="dtpDate" name="dtpDate" value="<%=fDatelong(dtDate)%>" type="text" class="form-control" date-picker >
					                                <span class="input-group-btn">
					                                    <a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
					                                        <i class="fa fa-calendar"></i>
					                                    </a>
					                                </span>
					                            </div>
					                        </div>
					                        
											<!--Extra Coupon To Date-->
					                        
											<label class="col-sm-1 control-label">To Date :</label>
											<div class="col-sm-3" >
					                            <div class="input-group">
					                                <input id="dtpToDate" name="dtpToDate" value="<%=fDatelong(dtToDate)%>" type="text" class="form-control" date-picker >
					                                <span class="input-group-btn">
					                                    <a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
					                                        <i class="fa fa-calendar"></i>
					                                    </a>
					                                </span>
					                            </div>
					                        </div>
											
											
					                 
									   </div>
									   <!--/.form group -->
								   </div>
									<%end if%>
									<input type="hidden" id="dtpDisplay" name="dtpDisplay" value="<%=dtDisplay%>" />
									<!-- box-footer -->
									<%if dtDisplay = "" then%>
									<div class="box-footer"> 
										<button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Update</button>
										<!-- Coupon -->
	                                </div>
									<%else%>
										<label class="col-sm-5 control-label"><font color="red">* The File had been process successfully.</font></label>
										<input type="button" class="btn btn-new pull-right" name="btnReturn" value="Re-Upload" onclick="window.location = ('<%=sMainURL2%><%=sAddURL%>');" />
										<!-- Coupon -->
									<%end if%>
	                                <!-- /.box-footer -->
									<%if dtDisplay <> "" then%>
										<div id="content2">
											<!-- CONTENT HERE -->
										</div>
									<%end if%>
                                </div>
                                <!--/.box body-->
                            </div>
                            
                            <!-- /.box box-info -->
                        </form>
                        <!-- form end -->
                    </div>
                    <!--/.col-md-12 -->
                </div>
                <!--/.row -->
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
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

	<!--Script Start-->
	<!--Document Ready-->
	<script>
    $(document).ready(function () {
        $('#btnUp').click(function () {
         $('#ToLB').each(function () {
            $('#ToLB option').attr("selected", "selected");
            });
         });
         $('#btnDel').click(function () {
         $('#ToLB').each(function () {
            $('#ToLB option').attr("selected", "selected");
            });
         });

    });
    
    //$( document ).ready(function() {
	//var type = document.getElementById("selType").value;
	//if (type == "N"){
	//	$("#divType").hide();
	//	$("#divType2").show();
	//}else{
	//	$("#divType").show();
	//	$("#divType2").hide();
	//}
	//});
 	</script>
	
	<!--Onclick Hide Div-->
    <script>
    //function hideDiv(){
	//var s = document.getElementById("selType").value;
	//if ( s == "N"){
	//	$("#divType").hide();
	//	$("#divType2").show();
	//	document.getElementById("selType").value;
	//	}
	//else{
	//	$("#divType").show();
	//	$("#divType2").hide();
	//}
	//};
    </script>
    
	<!--date picker-->
    <script>
    $('#btndt_date').click(function () {
        $('#dtpDate').datepicker("show");
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
		$("#txtCoupon").keydown(function (e) {
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
	
	$('#txtCoupon').keyup(function () {
		if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
       this.value = this.value.replace(/[^0-9\.]/g, '');
		}
	});

	$(document).ready(function(){
		showContent('page=1');       
	});

	function showContent(str) {
	  	var xhttp;
	  	
	  	if (str.length == 0) { 
	    	document.getElementById("content2").innerHTML = "";
	    	return;
	  	}
	  	xhttp = new XMLHttpRequest();
	  	xhttp.onreadystatechange = function() {
	    	if (xhttp.readyState == 4 && xhttp.status == 200) {
	      	document.getElementById("content2").innerHTML = xhttp.responseText;
	    	}
	  	};
	  	 var x = document.getElementById("dtpDisplay").value;
		 
		str = str + "&dtpDisplay=" + x;
		
	  	xhttp.open("GET", "ajax/ax_cscoupon_ext_csv.asp?"+str, true);
	  	xhttp.send();
	}
    </script>
	<!--Script End-->
	

</body>
</html>
