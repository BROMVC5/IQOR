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

	sModeSub = request("sub")
	
	if sModeSub <> "" Then
	    dtDate = reqForm("dtpDate")
	    sStatus = reqForm("cboStatus")
	    
	    if dtDate = "" then
	    	call alertbox("Date cannot be empty")
	    end if
     	        
	    if sModeSub = "add" Then
	    	
	    	Set rstTSExcept = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tsexcept "
            sSQL = sSQL & "where DT_EXCEPT = '" & fDate2(dtDate) & "' "
            rstTSExcept.Open sSQL, conn, 3, 3		            
            if not rstTSExcept.eof then
            
            	call alertbox("Date : " & dtDate & " already exist")
            	
            else
            
                sSQL = "insert into tsexcept (DT_EXCEPT, STATUS, "
	            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
	            sSQL = sSQL & "values ("
			    sSQL = sSQL & "'" & fDate2(dtDate) & "',"		 
			    sSQL = sSQL & "'" & pRTIN(sStatus) & "',"
			    sSQL = sSQL & "'" & session("USERNAME") & "'," 
			    sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
			    sSQL = sSQL & "'" & session("USERNAME") & "'," 
			    sSQL = sSQL & "'" & fDatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	 	  	    conn.execute sSQL  			
		 		 	  	     
	        end if  
            call pCloseTables(rstTSExcept)	    
				
	    end if
	end if
	
	Set rstTSExcept = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from tsexcept "
    sSQL = sSQL & "order by DT_EXCEPT desc " 
    rstTSExcept.Open sSQL, conn, 3, 3	
%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ts.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Exception</h1>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="tsexcept.asp" method="post">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">

		                        	<!-- form group -->
									<div class="form-group">
										<!--Date-->
										<label class="col-sm-1  control-label">Date : </label>
										<div class="col-sm-4">
											<div class="input-group">
												<input id="dtpDate" name="dtpDate" value="<%=fDatelong(dtDate)%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
												<a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
												<i class="fa fa-calendar"></i>
												</a>
												</span>
											</div>
										</div>
										
										<!-- Status -->
											<label class="col-sm-1  control-label" >Status : </label>
											<div class="col-sm-4" >
												<select id="cboStatus" name="cboStatus" class="form-control">
													<option value="U" >Unblock</option>
													<option value="B" >Block</option>
												</select>
											</div>
											
										<div class="col-sm-2" >	
										<button type="submit" id="btnSave" name="sub" value="add" class="btn btn-success pull-right" style="width: 90px">Add</button>
										</div>
									</div>
									<!--/.form group --> 
								
									<div style="overflow:auto;padding:0px;margin:0px">
										<table id="example1" class="table table-bordered table-striped">
											<thead>
												<tr>
									            	<th style="width:1%">No</th>
									                <th style="width:10%">Date</th>
									                <th style="width:10%">Status</th>
									                <th style="width:10%">By User</th>
									                <th style="width:5%;text-align:center">Delete</th>
									            </tr>
											</thead>
										
											<tbody>
											<%
											if not rstTSExcept.eof then
											    i = 0                  
												do while not rstTSExcept.eof
												
												i = i + 1                          
												response.write "<tr>"
												response.write "<td>" & i & "</td>"
												response.write "<td>" & rstTSExcept("DT_EXCEPT") & "</td>"
												if rstTSExcept("STATUS") = "U" then
													response.write "<td>Unblocked</td>"  
												else
													response.write "<td>Blocked</td>"
												end if
												response.write "<td>" & rstTSExcept("CREATE_ID") & "</td>"
												response.write "<td style=""text-align:center"">"
												%>
												<a href="#" onclick="fOpen('DEL','<%=rstTSExcept("AUTOINC")%>','mycontent','#mymodal')"><img src="dist/img/x-mark-24.png" /></a>
												<%
												response.write "</td>"
												response.write "</tr>"
												rstTSExcept.movenext
												loop
												
											end if
											call pCloseTables(rstTSExcept)
											%>                     
											</tbody>
											
										</table>
									</div>
									                                	
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
        $('#dtpDate').datepicker("show");
    });

    $(function () {        
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
		
		if (pType=="DEL") {
	  		xhttp.open("GET", "tsexcept_del.asp?"+str, true);
		}
  	    xhttp.send();
    }
	</script>
	

	<!--Script End-->
	

</body>
</html>
