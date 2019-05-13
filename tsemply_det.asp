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
    sEmpCode = UCase(request("txtEmpCode"))
   
	if sEmpCode <> "" then
        sID = sEmpCode
    else
        sID = UCase(reqForm("txtId"))
    end if
      
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
        
    sMainURL = "tsemply.asp?"
    sAddURL = "txtSearch=" & server.HTMLEncode(sSearch) & "&Page=" & iPage 
     
    if sModeSub <> "" Then
		sEmpName = reqForm("txtEmpName")
       	sAreaCode = reqForm("txtAreaCode")
     	if sModeSub = "up" Then
      
   	        if sAreaCode = "" then
	            call alertbox("Area Code cannot be empty")
	        else
	        	Set rstTSArea = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tsarea where AREACODE ='" & sAreaCode & "'" 
	            rstTSArea.Open sSQL, conn, 3, 3
				if rstTSArea.eof then
	                call alertbox("Area Code : " & sAreaCode & " does not exist !")
				end if
	            pCloseTables(rstTSArea)
	        end if
            
            sSQL = "UPDATE tsemply SET "                        
            sSQL = sSQL & "AREACODE = '" & pRTIN(sAreaCode) & "',"         
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "' "
            sSQL = sSQL & "WHERE EMP_CODE = '" & sId & "'"
            conn.execute sSQL
			
            sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 
            
          	response.redirect sMainURL & sAddURL 
          	          	
        elseif sModeSub = "save" Then
        
            Set rstTSEmply = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tsemply where EMP_CODE ='" & sEmpCode & "'" 
            rstTSEmply.Open sSQL, conn, 3, 3
            if not rstTSEmply.eof then
                call alertbox("Employee Code : " & sId & " already exist !")
			end if  
            pCloseTables(rstTSEmply)

			if sId = "" then
	            call alertbox("Employee Code cannot be empty")
	        else
	        	Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmemply where EMP_CODE ='" & sEmpCode & "'" 
	            rstTMEmply.Open sSQL, conn, 3, 3
				if rstTMEmply.eof then
	                call alertbox("Employee Code : " & sEmpCode & " does not exist !")
				end if
	            pCloseTables(rstTMEmply)
	        end if
			
	        if sAreaCode = "" then
	            call alertbox("Area Code cannot be empty")
	        else
	        	Set rstTSArea = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tsarea where AREACODE ='" & sAreaCode & "'" 
	            rstTSArea.Open sSQL, conn, 3, 3
				if rstTSArea.eof then
	                call alertbox("Area Code : " & sAreaCode & " does not exist !")
				end if
	            pCloseTables(rstTSArea)
	        end if	       
	        
            sSQL = "insert into tsemply (EMP_CODE, AREACODE, "
            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
            sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sId) & "',"		 
		    sSQL = sSQL & "'" & pRTIN(sAreaCode) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
            sSQL = sSQL & ") "
		    conn.execute sSQL
            
            response.redirect sMainURL & sAddURL 
                 
		 end if
    End If
          
    Set rstTSEmply = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from tsemply where EMP_CODE ='" & sId & "'" 
    rstTSEmply.Open sSQL, conn, 3, 3
    if not rstTSEmply.eof then
        sAreaCode = rstTSEmply("AREACODE")       
    end if
    call pCloseTables(rstTSEmply)  
    
	Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select name from tmemply where EMP_CODE ='" & sId & "'" 
    rstTMEmply.Open sSQL, conn, 3, 3
    if not rstTMEmply.eof then
        sEmpName = rstTMEmply("NAME")       
    end if
    call pCloseTables(rstTMEmply)  
    %>
 
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ts.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Employee Transportation Details</h1>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="tsemply_det.asp" method="post">
                            <input type="hidden" id="txtSearch" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                               <div class="box-body">
                                
									<!-- Employee Code -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Employee Code : </label>
										<div class="col-sm-4">
											<div class="input-group">
												<% if sEmpCode = "" then %>
													<input class="form-control" id="txtEmpCode" name="txtEmpCode" value="<%=sEmpCode%>" maxlength="10" style="text-transform: uppercase" input-check />
													<span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('EMP','txtEmpCode','mycontent','#mymodal')">
													<i class="fa fa-search"></i>
													</a>
													</span>
												<%else%>
													<span class="mod-form-control"><% response.write sEmpCode%></span>
													<input type="hidden" id="txtID" name="txtID" value="<%=sID%>" />

												<%end if%>
											</div>
											
										</div>
									</div>
									<!-- Employee Name -->
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Name : </label>
                                        <div class="col-sm-4">
											<%if sEmpCode  <> "" then%>
												<span class="mod-form-control" ><% response.write sEmpName %> </span>
												<input type="hidden" id="txtEmpName" name="txtEmpName" value='<%=sEmpName%>' />
											<%else%>
												<input class="form-control" id="txtEmpName" name="txtEmpName" value="<%=sEmpName%>" maxlength="50"/ READONLY>
											<%end if%>
                                        </div>
                                    </div>
                                
                                	<!-- Area Code -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Area Code : </label>
										<div class="col-sm-4">
											<div class="input-group">
											
													<input class="form-control" id="txtAreaCode" name="txtAreaCode" value="<%=sAreaCode%>" maxlength="10" style="text-transform: uppercase" input-check />
													<span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('AREA','txtAreaCode','mycontent','#mymodal')">
													<i class="fa fa-search"></i>
													</a>
													</span>
												
											</div>
										</div>
									</div>
                                        
                              </div>

									<!-- Footer Button -->
	                                <div class="box-footer">
	                                    <%if sAreaCode <> "" then %>
	                                    <a href="#" onclick="fOpen('DEL','','mycontent','#mymodal')" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
	                                    <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
	                                    <%else %>
	                                    <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
	                                    <%end if %>
	                                </div>
                                <!-- /.box-footer -->
									 
                                <!-- /.box -->
		                    </div>
		            
						    
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
     
    <!--open modal-->
	<script>
    function fOpen(pType,pFldName,pContent,pModal) {
		document.getElementById(pContent).innerHTML = ""
		showDetails('txtEmpCode=<%=sEmpCode%>',pFldName,pType,pContent)
		$(pModal).modal('show');
	}
	
	function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }
    
    function getValue1(svalue, pFldName, svalue2, pFldName2) {
        document.getElementById(pFldName).value = svalue;
        document.getElementById(pFldName2).value = svalue2;
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
        var search = document.getElementById("txtSearch1");
        } 
        else if (pType=="AREA") { 
        var search = document.getElementById("txtSearch3");
        } else {
  	    var search = document.getElementById("txtSearch");
		}
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
		
		if (pType=="DEL") {
	  	    xhttp.open("GET", "tsemply_del.asp?"+str, true);
	  	} else if (pType=="EMP") {
	  		xhttp.open("GET", "ajax/ax_tsview_empId.asp?"+str, true);
	  	} else if (pType=="AREA") {
	  	    xhttp.open("GET", "ajax/ax_tsview_areaId.asp?"+str, true);
  	    } 

  	    xhttp.send();
    }
	</script>
	
	<script>
	$(document).ready(function(){
		document.getElementById('txtSearch').focus();
	});
	
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
				document.getElementById("txtEmpName").value = res[1];
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
	</script>

	
	<!--Script End-->

	

</body>
</html>
