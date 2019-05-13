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
    sAreaCode = UCase(request("txtAreaCode"))
    
	if sAreaCode <> "" then
        sID = sAreaCode 
    else
        sID = UCase(reqForm("txtID"))
    end if
        
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
        
    sMainURL = "tsarea.asp?"
    sAddURL = "txtSearch=" & server.HTMLEncode(sSearch) & "&Page=" & iPage 
            
    if sModeSub <> "" Then
       	
       	sArea = reqForm("txtArea")
       	sRoute = reqForm("txtRoute")
       	sStatus = reqForm("cboStatus")

     	if sModeSub = "up" Then
   	        if sArea = "" then
	            call alertbox("Area cannot be empty")
	        end if
	        
	        if sRoute = "" then
	            call alertbox("Route cannot be empty")
	        end if
            
            sSQL = "UPDATE tsarea SET "                        
            sSQL = sSQL & "AREA = '" & pRTIN(sArea) & "',"
            sSQL = sSQL & "ROUTE = '" & pRTIN(sRoute) & "',"    
            sSQL = sSQL & "STATUS = '" & pRTIN(sStatus) & "',"          
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "' "
            sSQL = sSQL & "WHERE AREACODE = '" & sId & "'"
            conn.execute sSQL
            
			call confirmBox("Update Successful!", sMainURL & sAddURL)
          	          	
        elseif sModeSub = "save" Then
        
            Set rstTSarea = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tsarea where AREACODE='" & sId & "'" 
            rstTSarea.Open sSQL, conn, 3, 3
            if not rstTSarea.eof then
                call alertbox("Area Code : " & sId & " already exist !")
			end if  
            pCloseTables(rstTSarea)

			if sId = "" then
	            call alertbox("Area Code cannot be empty")
	        end if

	        if sArea = "" then
	            call alertbox("Area cannot be empty")
	        end if	       
	        
	        if sRoute = "" then
	            call alertbox("Route cannot be empty")
	        end if    

            sSQL = "insert into tsarea (AREACODE, AREA, ROUTE, STATUS, "
            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
            sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sId) & "',"		 
		    sSQL = sSQL & "'" & pRTIN(sArea) & "',"
		    sSQL = sSQL & "'" & pRTIN(sRoute) & "',"
		    sSQL = sSQL & "'" & pRTIN(sStatus) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
            sSQL = sSQL & ") "
		    conn.execute sSQL
			
			call confirmBox("Save Successful!", sMainURL & sAddURL)
                 
		 end if
    End If
          
    Set rstTSArea = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from tsarea where AREACODE='" & sId & "'" 
    rstTSArea.Open sSQL, conn, 3, 3
    if not rstTSArea.eof then
        sArea = rstTSArea("AREA")
        sRoute = rstTSArea("ROUTE")            
        sStatus = rstTSArea("STATUS")
        
    end if
    call pCloseTables(rstTSArea)
    
     
    %>
 
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ts.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Area Details</h1>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="tsarea_det.asp" method="post">
                            <input type="hidden" id="txtSearch" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                               <div class="box-body">
                                
									<!-- Area Code -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Area Code : </label>
										<div class="col-sm-6">
											<%if sAreaCode <> "" then %>
												<span class="mod-form-control"><% response.write sAreaCode %></span>
												<input type="hidden" id="txtID" name="txtID" value="<%=sID%>" />
                                            <%else%>
                                           		<input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform: uppercase" input-check />
                                            <%end if%>
										</div>
									</div>
                                
                                	<!-- Area -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Area : </label>
										<div class="col-sm-6">
											<input class="form-control" id="txtArea" name="txtArea" value="<%=server.htmlencode(sArea)%>" maxlength="30" input-check />
										</div>
									</div>
                                    
                                    <!-- Route -->                                   
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Route : </label>
                                        <div class="col-sm-6">
                                            <textarea rows="4"class="form-control" id="txtRoute" name="txtRoute" maxlength="200" style="resize: none;"><%=server.htmlencode(sRoute)%></textarea>
                                        </div>
                                    </div>
                                                       
                                    <!-- Status -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Status : </label>
                                        <div class="col-sm-2" >
                                            <select id="cboStatus" name="cboStatus" class="form-control">
                                                <option value="A" <%if sStatus = "A" then%>Selected<%end if%>>Active</option>
                                                <option value="I" <%if sStatus = "I" then%>Selected<%end if%>>Inactive</option>
                                            </select>
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
    function fOpen(pType,pfldName,pContent,pModal) {

		showDetails('txtAreaCode=<%=sAreaCode%>',pfldName,pType,pContent)
		$(pModal).modal('show');
	}
	    
    function showDetails(str,pfldName,pType,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };
		
		xhttp.open("GET", "tsarea_del.asp?"+str, true);
	  		  	
  	    xhttp.send();
    }
	</script>
		
	<!--Script End-->
	

</body>
</html>
