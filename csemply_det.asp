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


	
    <%
    sEMP_CODE = UCase(request("txtEMP_CODE"))
    
    if sEMP_CODE <> "" then
        sID = sEMP_CODE
    else
        sID = UCase(reqForm("txtID"))
    end if
        
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
        
    sMainURL = "csemply.asp?"
	sMainURL2 = "csemply_det.asp?"
    sAddURL = "txtSearch=" & server.HTMLEncode(sSearch) & "&Page=" & iPage 
            
    if sModeSub <> "" Then
       	
       	sName = reqForm("txtName")
        sCardNo = reqForm("txtCardNo")
        dCoupon = reqForm("txtCoupon")
        sStatus = reqForm("selStatus")
        dtDate = reqForm("dtpDate")
        dtToDate = reqForm("dtpToDate")
        sSubType = reqForm("cboSubType")

     	if sModeSub = "up" Then
     		
     		if sName = "" then
	            call alertbox("Employee Name cannot be empty")
	        end if
	        
            if dCoupon = "" or Not IsNumeric(dCoupon) then
	            call alertbox("Coupon amount cannot be empty")
	        end if 
	        
            sSQL = "UPDATE csemply SET "             
            sSQL = sSQL & "NAME = '" & pRTIN(sName) & "',"            
            sSQL = sSQL & "COUPON = '" & pFormat(dCoupon,2) & "',"   
            sSQL = sSQL & "STATUS = '" & pRTIN(sStatus) & "',"          
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & " WHERE EMP_CODE = '" & sID & "'"
            conn.execute sSQL
			
            sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 
            
          	response.redirect sMainURL2 & sAddURL & "&txtEMP_CODE=" & sID & ""
          	
        elseif sModeSub = "save" Then
        
            Set rstCSEmply = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from csemply where EMP_CODE='" & sID & "'" 
            rstCSEmply.Open sSQL, conn, 3, 3
            if not rstCSEmply.eof then
                call alertbox("Employee Code: " & sID & " already exist !")
			end if  
            pCloseTables(rstCSEmply)

			if sID = "" then
	            call alertbox("Employee Code cannot be empty")
	        end if

	        if sCardNo = "" then
	            call alertbox("Card No cannot be empty")
	        end if
	        
	        if sName = "" then
	            call alertbox("Employee Name cannot be empty")
	        end if  
	        
			if dCoupon = "" or Not IsNumeric(dCoupon) then
	            call alertbox("Coupon amount cannot be empty")
	        end if     

            sSQL = "insert into csemply (EMP_CODE, NAME, CardNo, COUPON, STATUS, "
            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
            sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		 
		    sSQL = sSQL & "'" & pRTIN(sName) & "',"
		    sSQL = sSQL & "'" & pRTIN(sCardNo) & "',"
		    sSQL = sSQL & "'" & pFormat(dCoupon,2) & "',"
		    sSQL = sSQL & "'" & pRTIN(sStatus) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
            sSQL = sSQL & ") "
		    conn.execute sSQL
            
            response.redirect sMainURL2 & sAddURL & "&txtEMP_CODE=" & sID & ""
                 
		 elseif sModeSub = "add" Then
		 	            
            if dtDate = "" then
	            call alertbox("From Date cannot be empty")
	        end if
	        
	        if dtToDate = "" then
	            call alertbox("To Date cannot be empty")
	        end if
            dtSel = dtDate
            dtSel = fDate2(dtSel)
            dtNow = fDate2(now())

            if dtNow > dtSel then
                 call alertbox("Date must be future")
            end if
            
            dtDiff = DateDiff("d",dtDate,dtToDate)
            if dtDiff < 0 then 
                call alertbox("Invalid Date")
            end if
            
	        if sSubType = "0"  then
	            call alertbox("Subsidy Type cannot be empty")
	        end if
     
	        iRange = (DateDiff("d",dtDate,dtToDate))
	        
			For intID = 0 to iRange
			    Set rstCSEmply1 = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from csemply1 "
	            sSQL = sSQL & "where EMP_CODE = '" & sID & "'"
	            sSQL = sSQL & "and TYPE = '" & sSubType & "'"
	            sSQL = sSQL & "and DT_SUB = '" & fDate2(dtDate) & "'" 
	            rstCSEmply1.Open sSQL, conn, 3, 3
	            if not rstCSEmply1.eof then
	            		
	            		set rstCSType = server.CreateObject("ADODB.RecordSet")    
			            sSQL = "select * from cstype where SUBTYPE = '" & sSubType & "' " 
			            rstCSType.Open sSQL, conn, 3, 3
			            if not rstCSType.eof then	            	
			                sSQL = "UPDATE csemply1 SET "                      
				            sSQL = sSQL & "EMP_CODE = '" & pRTIN(sID) & "',"		 
						    sSQL = sSQL & "TYPE = '" & pRTIN(sSubType) & "',"
						    sSQL = sSQL & "DT_SUB = '" & fdate2(dtDate) & "',"
						    sSQL = sSQL & "AMOUNT = '" & pFormat(rstCSType("AMOUNT"),2) & "',"
						    sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
						    sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "'"
				            sSQL = sSQL & "WHERE EMP_CODE = '" & sID & "'"
				            sSQL = sSQL & "and DT_SUB = '" & fdate2(dtDate) & "'"
				            sSQL = sSQL & "and TYPE = '" & sSubType & "'"
				            conn.execute sSQL
			            end if
			            pCloseTables(rstCSType)
								
     			else
     					
     					set rstCSType = server.CreateObject("ADODB.RecordSet")    
			            sSQL = "select * from cstype where SUBTYPE = '" & sSubType & "' " 
			            rstCSType.Open sSQL, conn, 3, 3
			            if not rstCSType.eof then
					        sSQL = "insert into csemply1 (EMP_CODE, TYPE, DT_SUB, AMOUNT, "
				            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
				            sSQL = sSQL & "values ("
						    sSQL = sSQL & "'" & pRTIN(sID) & "',"
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
	            call pCloseTables(rstCSEmply1)

           		dtDate = (DateAdd("d",1,dtDate))
           		
            Next
            
		    sSQL = "UPDATE csemply SET "             
            sSQL = sSQL & "NAME = '" & pRTIN(sName) & "',"            
            sSQL = sSQL & "COUPON = '" & pFormat(dCoupon,2) & "',"   
            sSQL = sSQL & "STATUS = '" & pRTIN(sStatus) & "',"          
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & " WHERE EMP_CODE = '" & sID & "'"
            conn.execute sSQL
		    
		    response.redirect sMainURL2 & sAddURL & "&txtEMP_CODE=" & sID & ""
		    		    		             
		 End If
    End If
          
    Set rstCSEmply = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from csemply where EMP_CODE='" & sID & "'" 
    rstCSEmply.Open sSQL, conn, 3, 3
    if not rstCSEmply.eof then
        sName = rstCSEmply("NAME")
        sCardNo = rstCSEmply("CardNo")            
        dCoupon = rstCSEmply("COUPON")
        sStatus = rstCSEmply("STATUS")
        
    end if
    call pCloseTables(rstCSEmply)
    
    Set rstCSCoupon = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from csemply1 where EMP_CODE='" & sID & "'" 
    rstCSCoupon.Open sSQL, conn, 3, 3
    if not rstCSCoupon.eof then          
        dtDate = ""         
    end if
    call pCloseTables(rstCSCoupon)
     
    %>
 
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Employee Details</h1>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="csemply_det.asp" method="post">
                            <input type="hidden" id="txtSearch" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <input type="hidden" id="txtEMP_CODE" name="txtEMP_CODE" value='<%=sEMP_CODE%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                               <div class="box-body">
                                
                                	  <!-- Employee Code -->
		                              <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-6">
                                            <%if sEMP_CODE <> "" then %>
                                            <span class="mod-form-control"><% response.write sEMP_CODE %></span>
                                            <input type="hidden" id="txtID" name="txtID" value="<%=sID%>" />
                                            <%else%>
                                            <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform: uppercase" input-check />
                                            <%end if%>
                                        </div>
                                     </div>
                                
                                	 <!-- Card No -->
                               		 <div class="form-group">
                                        <label class="col-sm-3 control-label">Card No : </label>
                                        <div class="col-sm-6">
                                         <%if sEMP_CODE <> "" then %>
                                            <span class="mod-form-control"><% response.write sCardNo %></span>
                                            <input type="hidden" id="txtCardNo" name="txtCardNo" value="<%=sCardNo%>" />
                                            <%else%>
                                            <input class="form-control" id="txtCardNo" name="txtCardNo" value="<%=server.htmlencode(sCardNo)%>" maxlength="10" style="text-transform: uppercase" input-check>
                                       		<%end if%>

										</div>
                                     </div>
                                    
                                    <!-- Name -->                                   
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Name : </label>
                                        <div class="col-sm-6">
                                            <input class="form-control" id="txtName" name="txtName" value="<%=server.htmlencode(sName)%>" maxlength="60">
                                        </div>
                                    </div>
                                    
                                    
                                    <!-- Coupon -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Subsidy Amount (RM) : </label>
                                        <div class="col-sm-2" >
                                            <input  class="form-control" id="txtCoupon" name="txtCoupon" value="<%=server.htmlencode(pFormatDec(dCoupon,2))%>" maxlength="10" placeholder="RM" onkeypress='return isNumberKey(event)' style="text-align:right;" >    	
                                        </div>
                                    </div>
                                                                       
                                    <!-- Status -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Status : </label>
                                        <div class="col-sm-2" >
                                            <select id="selStatus" name="selStatus" class="form-control">
                                                <option value="Y" <%if sStatus = "Y" then%>Selected<%end if%>>Active</option>
                                                <option value="N" <%if sStatus = "N" then%>Selected<%end if%>>Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                              </div>

									<!-- Footer Button -->
	                                <div class="box-footer">
	                                    <%if sEMP_CODE <> "" then %>
	                                    <a href="#" onclick="fOpen('DEL','','','mycontent','#mymodal')" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
	                                    <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
	                                    <%else %>
	                                    <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
	                                    <%end if %>
	                                </div>
                                <!-- /.box-footer -->
									 
                                <!-- /.box -->
		                    </div>
		            
						    <!--Extra coupon content start -->
					        <% if sEMP_CODE <> "" then %>
							
				            	<div class="box">
				                    <!-- /.box-header -->
				                    <div class="box-body">
				                    
				                    	<!--Add Button-->
				                    	<div>
				 						<button type="submit" name="sub" value="add" class="btn btn-block btn-success pull-right" style="width: 94px">Add Coupon</button>
				 						</div>
				 						
				                        <!--Extra Coupon From Date-->
				                        <div class="col-sm-3" >
				                            <div class="input-group">
				                                <input id="dtpDate" name="dtpDate" value="<%=fdatelong(dtDate)%>" type="text" class="form-control" date-picker placeholder="From Date">
				                                <span class="input-group-btn">
				                                    <a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
				                                        <i class="fa fa-calendar"></i>
				                                    </a>
				                                </span>
				                            </div>
				                        </div>
						                        
										<!--Extra Coupon To Date-->
				                        <div class="col-sm-3" >
				                            <div class="input-group">
				                                <input id="dtpToDate" name="dtpToDate" value="<%=fdatelong(dtToDate)%>" type="text" class="form-control" date-picker placeholder="To Date">
				                                <span class="input-group-btn">
				                                    <a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
				                                        <i class="fa fa-calendar"></i>
				                                    </a>
				                                </span>
				                            </div>
				                        </div>
				                        
				                         <!--Type-->
				                         <div class="form-group">
					                         <div class="col-sm-3">
					                            <select id="cboSubType" name="cboSubType" class="form-control" >
					                            	<option value="0" selected>Please Select One</option>
					                            	<%
					                            	Set rstCSType = server.CreateObject("ADODB.RecordSet")    
										            sSQL = "select * from cstype where STATUS = 'A' " 
										            rstCSType.Open sSQL, conn, 3, 3
										            if not rstCSType.eof then
														Do while not rstCSType.eof
					                                		response.write "<option value='" & rstCSType("SUBTYPE") & "'>" & rstCSType("SUBTYPE") & "</option>"
					                                	rstCSType.movenext
					                                	Loop
					                                end if
					                                pCloseTables(rstCSType)
					                                %>
					                            </select>
					                         </div>
											
											 
										 </div>			                                
				
				                         <div id="content2">
				                            <!-- CONTENT HERE -->
				                         </div>
				                    </div>
				                    <!-- /.box-body -->
				                </div>
				                <!-- /.box --> 			
							 <%end if %>		 
							 <!--Extra coupon content end -->
					 		 </form>
						 	 <!-- form end -->
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

    </script>
     
    <!--open modal-->
	<script>
    function fOpen(pType,pValue1,pValue2,pContent,pModal) {

		showDetails('txtEMP_CODE=<%=sEMP_CODE%>',pValue1,pValue2,pType,pContent)
		$(pModal).modal('show');
	}
	
	function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }
    
    function showDetails(str,pValue1,pValue2,pType,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

		str = str + "&pValue1=" + pValue1;
		str = str + "&pValue2=" + pValue2;
		
		if (pType=="DEL") {
	  	    xhttp.open("GET", "csemply_del.asp?"+str, true);
	  	} else {
	  		xhttp.open("GET", "cscoupon_del.asp?"+str, true);
	  	}
	  	
  	    xhttp.send();
    }
	</script>
	
	<script>
	    $(document).ready(function(){
	        document.getElementById('txtSearch').focus();
	        showContent('page=1');       
	    });
	
	</script>
	
	<!--show content-->
	<script>
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
	  	
	  	str = str + "&txtSearch=" + document.getElementById("txtSearch").value;
	  	str = str + "&txtEmp_Code=" + document.getElementById("txtEMP_CODE").value;
	  	
	  	xhttp.open("GET", "ajax/ax_cscoupon_ext.asp?"+str, true);
	  	xhttp.send();
	}
	
	function goTo(str) {
		var sURL;
		
		sURL = "page=" + document.getElementById("txtPage").value;
		sURL = sURL + "&txtSearch=" + document.getElementById("txtSearch").value;
	
	  	window.location=(str + sURL);
	}
	
	function go(str) {
	      window.location=(str);
	    }
	
	</script>
	<!--Script End-->
	

</body>
</html>
