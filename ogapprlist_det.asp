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

	<script>
	    var loadFile = function (event) {
	    var output = document.getElementById('output');
	    output.src = URL.createObjectURL(event.target.files[0]);
	    };
	</script>
	
	
    <%
           
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    sTicket = trim(request("txtTicket"))
    sImg = request("img") 
    sMainURL = "ogapprlist.asp?"
    sMainURL2 = "ogapprlist_det.asp?"
    sAddURL = "txtSearch=" & server.HTMLEncode(sSearch) & "&Page=" & iPage 
            
    if sModeSub <> "" Then
     
        dtDate = reqForm("dtpDate")
        
		if sModeSub = "return" then    
			dCount = 0
		    Set rstOGProp1 = server.CreateObject("ADODB.RecordSet")    
		    sSQL = "select * from ogprop1 "
		    sSQL = sSQL & "where TICKET_NO = '" & sTicket & "' "
		    rstOGProp1.Open sSQL, conn, 3, 3
			if not rstOGProp1.eof then
				
				do while not rstOGProp1.eof 
					dCount = dCount + 1 
					
					rstOGProp1.movenext
				loop
			end if
			call pCloseTables(rstOGProp1)
			
		    For i = 1 to dCount
		    	
		    	dCheck = trim(request("cboList"&i))
		    	dAutoInc = trim(request("cboFullList"&i))
		    	response.write "0:" & dAutoInc & "<br>"
		    	if dCheck <> "" then
					sSQL = "UPDATE ogprop1 SET "                           
		            sSQL = sSQL & "DT_RETURN = '" & fDate2(Now()) & "',"
		            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
        			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
		            sSQL = sSQL & "where AUTOINC = '" & dAutoInc & "' "
		            sSQL = sSQL & "and ISNULL(DT_RETURN) "
		            conn.execute sSQL
		            
				else
			
					sSQL = "UPDATE ogprop1 SET "                           
		            sSQL = sSQL & "DT_RETURN = NULL, "
		            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
	            	sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
		            sSQL = sSQL & "where TICKET_NO = '" & sTicket & "' "
		            sSQL = sSQL & "and AUTOINC = '" & dAutoInc & "' "
		            sSQL = sSQL & "and (DT_RETURN) IS NOT NULL "
		            conn.execute sSQL
		            	            
		        end if    
			    
			Next

			
			response.redirect sMainURL2 & sAddURL & "&txtTicket=" & sTicket & ""
		
		elseif sModeSub = "approve" then
			sSQL = "UPDATE ogprop SET "                           
            sSQL = sSQL & "STATUS = 'A',"
            sSQL = sSQL & "SSTATUS = 'A',"
            sSQL = sSQL & "ASTATUS = 'N',"
            sSQL = sSQL & "DT_OUT = '" & fDate2(now()) & "',"
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & "where TICKET_NO = '" & sTicket & "' "
            conn.execute sSQL
            
            response.redirect sMainURL & sAddURL 
            
		elseif sModeSub = "reject" then
			sSQL = "UPDATE ogprop SET "                           
            sSQL = sSQL & "STATUS = 'R',"
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & "where TICKET_NO = '" & sTicket & "' "
            conn.execute sSQL
            
            response.redirect sMainURL & sAddURL 
            	
		elseif sModeSub = "download" Then
		
			Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
		    sSQL = "select * from ogprop where TICKET_NO ='" & sTicket & "'" 
		    rstOGProp.Open sSQL, conn, 3, 3
		    if not rstOGProp.eof then
  		       	sAttach = rstOGProp("ATTACH")
   		    end if
		    call pCloseTables(rstOGProp)
		    			
			response.redirect "attachment/" & sAttach   
			
		end if
		          
    end if
          
    Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select ogprop.TICKET_NO, ogprop.COST_ID,ogprop.DEST,ogprop.ATTACH,ogprop.RSTATUS,ogprop.SSTATUS,ogprop.STATUS,ogprop.DT_CREATE,tmemply.NAME, "
    sSQL = sSQL & "tmemply.COST_ID AS EMPCOST,ogprop.EMP_CODE,tmemply.EMP_CODE,tmemply.DESIGN_ID from ogprop " 
    sSQL = sSQL & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
    sSQL = sSQL & "where TICKET_NO ='" & sTicket & "' "
    rstOGProp.Open sSQL, conn, 3, 3
    if not rstOGProp.eof then
        sEmpCode = rstOGProp("EMP_CODE")
        sEmpName = rstOGProp("NAME")
        sEmpCost = rstOGProp("EMPCOST")
        sEmpDesig = rstOGProp("DESIGN_ID") 
       	sCostId = rstOGProp("COST_ID")
       	sDest = rstOGProp("DEST")
       	sAttach = rstOGProp("ATTACH")
       	sRStatus = rstOGProp("RSTATUS")
       	sSStatus = rstOGProp("SSTATUS")
       	sStatus = rstOGProp("STATUS")
        dtCDate = rstOGProp("DT_CREATE")
    end if
    call pCloseTables(rstOGProp)
    
    Set rstOGProp1 = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from ogprop1 "
    sSQL = sSQL & "where TICKET_NO ='" & sTicket & "' "
    sSQL = sSQL & "order by autoinc asc "
    rstOGProp1.Open sSQL, conn, 3, 3
    '--if not eof at bottom --
    
    Set rstOGPass = server.CreateObject("ADODB.RecordSet")
	sql = "select * from ogpass where ID = '" & session("USERNAME") & "' "
	rstOGPass.Open sql, conn, 3, 3
	if not rstOGPass.eof then
		if rstOGPass("OGACCESS") = "N" then
			sAccess = "N"
		elseif rstOGPass("OGACCESS") = "A" then
			sAccess = "A"
		elseif rstOGPass("OGACCESS") = "F" then
			sAccess = "F"
		elseif rstOGPass("OGACCESS") = "D" then
			sAccess = "D"
		elseif rstOGPass("OGACCESS") = "S" then
			sAccess = "S"
		end if
	end if
	call pCloseTables(rstOGPass)
	
	if sRStatus = "Y" then
    	set rstTMCost = server.CreateObject("ADODB.Recordset")
		sSQL = "SELECT tmcost.COST_ID, tmcost.COSTMAN_CODE,(select tmemply.NAME from tmemply where tmemply.EMP_CODE = tmcost.COSTMAN_CODE) as NAME FROM tmcost "
		sSQL = sSQL & "left join tmemply on tmcost.COST_ID =  tmemply.COST_ID "
		sSQL = sSQL & "where tmemply.EMP_CODE = '" & sEmpCode & "'"
		rstTMCost.open sSQL, conn, 3, 3
		if not rstTMCost.eof then
			sApprCode = rstTMCost("COSTMAN_CODE")
			sApprName = rstTMCost("NAME")
		end if
		call pCloseTables(rstTMCost)
    else
    	set rstOGPath = server.CreateObject("ADODB.Recordset")
		sSQL = "select ogpath.EMP_CODE,tmemply.NAME from ogpath "
		sSQL = sSQL & "left join tmemply on ogpath.EMP_CODE = tmemply.EMP_CODE "
		rstOGPath.open sSQL, conn, 3, 3
		if not rstOGPath.eof then
			sApprCode = rstOGPath("EMP_CODE")
			sApprName = rstOGPath("NAME")
		end if
		call pCloseTables(rstOGPath)
    end if
	
	Set rstOGPath = server.CreateObject("ADODB.RecordSet")
	sql = "select * from ogpath where EMP_CODE = '" & session("USERNAME") & "' "
	rstOGPath.Open sql, conn, 3, 3
	if not rstOGPath.eof then
		if fDate2(now()) >= rstOGPath("DT_FROM") and fDate2(now()) <= rstOGPath("DT_TO") then
			sActMan = "Y"
		end if
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
            	<%if sStatus = "A" then%>
                <h1>Ticket No : <font style="color:green"> <% response.write sTicket %></font></h1>
                <%else%>
                <h1>Ticket No : <font style="color:red"> <% response.write sTicket %></font></h1>
                <%end if%>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="ogapprlist_det.asp" method="post">
                            <input type="hidden" id="txtSearch" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
  							<input type="hidden" id="txtTicket" name="txtTicket" value="<%=sTicket%>" />
  							
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                               <div class="box-body">
                               										 
                                	<!-- Employee Code -->
                                	<h3>Requestor Profile</h3>
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">Employee Code : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<span class="mod-form-control"><% response.write sEmpCode %></span>
											</div>
										</div>
										<div class="col-sm-3" >
											<label class="control-label">Employee Name : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<span class="mod-form-control"><% response.write sEmpName %></span>
											</div>
										</div>

									</div>
									
									<!--Department-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Department : </label>
					                    </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                               <span class="mod-form-control"><% response.write sEmpCost %></span>		                                      
				                            </div>
                                        </div>
                                        
                                        <div class="col-sm-3" >
					                        	<label class="control-label">Designation : </label>
					                    </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                               <span class="mod-form-control"><% response.write sEmpDesig %></span>		                                      
				                            </div>
                                        </div>
                                  
                                	</div>
									
									<div class="box-header with-border"></div>
									<div class="box-header"></div>
									<h3>Outgoing Good Pass Detail</h3>
									
									<!--Property Return-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Property Return : </label>
					                    </div>
				                        <div class="col-sm-3">
											<%if sRStatus ="Y" then%>
												<span class="mod-form-control">Yes</span>
											<%else%>
												<span class="mod-form-control">No</span>
											<%end if%>
				                        </div>
				                        
				                        <div class="col-sm-3" >
					                        	<label class="control-label">Date Create : </label>
					                    </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                               <span class="mod-form-control"><% response.write dtCDate %></span>		                                      
				                            </div>
                                        </div>
                                        
                                	</div>
                                	
                                	<!--Department-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Department : </label>
					                    </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                               <span class="mod-form-control"><% response.write sCostId %></span>		                                      
				                            </div>
                                        </div>
                                	</div>
                                	
                                	<!--Destination-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Destination : </label>
					                    </div>
				                        <div class="col-sm-3">
				                              <span class="mod-form-control"><% response.write sDest %></span>
                                        </div>        
                                	</div>

                                	
                                	<!--File Attachment-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">File Attachment : </label>
					                    </div>
				                        <div class="col-sm-5">  
											<%if sTicket <> "" and sAttach = "" then%>
												<label class="control-label">No attachment</label>
											<%elseif sAttach <> "" then%>
												<button type="submit" name="sub" value="download" class="btn btn-default"><i class="fa fa-download" style="width: 80px"> Download</i></button>		
											<%end if%>
										</div>
                                	</div>
                                	<br>
                                										<div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
										<table id="example1" class="table table-bordered table-striped">
											<thead>
												<tr>
													<th style="width:5%">No</th>
									                <th style="width:15%">Serial/Part No</th>
									                <th style="width:25%">Property Description</th>
									                <th style="width:5%">Qty</th>
									                <th style="width:25%;">Purpose</th>
									                <th style="width:10%;">Due Date</th>
									            </tr>
											</thead>
										
										<tbody>
											<%
											if not rstOGProp1.eof then
											    i = 0                  
												do while not rstOGProp1.eof
												
												i = i + 1                          
												response.write "<tr>"
												response.write "<td>" & i & "</td>"
												response.write "<td>" & rstOGProp1("SERIAL") & "</td>"
												response.write "<td>" & rstOGProp1("PART") & "</td>"  
												response.write "<td>" & pFormat(rstOGProp1("QTY"),2) & "</td>"
												response.write "<td>" & rstOGProp1("PURPOSE") & "</td>"
												response.write "<td>" & rstOGProp1("DT_DUE") & "</td>"
												response.write "</td>"
												response.write "</tr>"
												rstOGProp1.movenext
												loop
												
											end if
											call pCloseTables(rstOGProp1)
											%>                     
										</tbody>
										
										</table>
									</div>
									
									<div class="box-header with-border"></div>
									<div class="box-header"></div>
									<h3>Approval Details</h3>
									
									<!--Approval-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Approval Code : </label>
					                    </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                               <span class="mod-form-control"><% response.write sApprCode %></span>		                                      
				                            </div>
                                        </div>
                                	</div>
                                	
                                	<!--Approval-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Approval Name : </label>
					                    </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                               <span class="mod-form-control"><% response.write sApprName %></span>		                                      
				                            </div>
                                        </div>
                                	</div>     
									
                              </div>

									<!-- Footer Button -->
	                                <div class="box-footer">
	                                <%if sStatus = "P" and (sAccess = "A" or sAccess = "F" or sAccess = "D") or sActMan = "Y" then%>
	                                	<div class="col-sm-12" >
	                                	<button type="submit" name="sub" value="approve" class="btn btn-success pull-right" style="width: 90px;margin-right:5px;">Approve</button>
	                                	<button type="submit" name="sub" value="reject" class="btn btn-danger pull-left" style="width: 90px;margin-left: 5px;">Reject</button>
	                                	</div>	
	                                <%end if%>
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
    <!--open modal-->
	<script>
    function fOpen(pType,pFldName,pContent,pModal) {

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

		var search = document.getElementById("txtSearch");
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
		
		if (pType=="DEL") {
	  	    xhttp.open("GET", "ogprop_del.asp?"+str, true);
	  	} else if (pType=="EMP") {
	  		xhttp.open("GET", "ajax/ax_ogview_empId.asp?"+str, true);
	  	} else if (pType=="COST") {
	  	    xhttp.open("GET", "ajax/ax_ogview_costId.asp?"+str, true);
  	    } else if (pType=="DELP") {
  	   		xhttp.open("GET", "ogpropitem_del.asp?"+str, true);
  	    } else if (pType=="UPL") {
			xhttp.open("GET", "ogupload.asp?"+str, true);
		}

  	    xhttp.send();
    }
	</script>
	
	<script>
	$('#selectAll').click(function(event) {   
    if(this.checked) {
        // Iterate each checkbox
        $(':checkbox').each(function() {
            this.checked = true;                        
        });
    }else{
    	$(':checkbox').each(function() {
            this.checked = false;                        
        });
    }
	});	</script>
	<!--Script End-->
	

</body>
</html>
