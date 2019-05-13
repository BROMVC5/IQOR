<!DOCTYPE html>
<html>

    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

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
    sSubType = UCase(request("txtSubType"))
    
	if sSubType <> "" then
        sID = sSubType 
    else
        sID = UCase(reqForm("txtID"))
    end if
        
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
        
    sMainURL = "cstype.asp?"
    sAddURL = "txtSearch=" & server.HTMLEncode(sSearch) & "&Page=" & iPage 
            
    if sModeSub <> "" Then
       	
       	sSubType = reqForm("txtSubType")
       	sDesc = reqForm("txtDesc")
       	sStart = reqForm("txtStart")
       	sEnd = reqForm("txtEnd")
		sStart2 = reqForm("txtStart2")
       	sEnd2 = reqForm("txtEnd2")
       	dAmount = reqForm("txtAmount")
       	dPriority = reqForm("txtPriority")
       	sStatus = reqForm("cboStatus")
		
		if reqform("cbkShow") = "on" Then
			sShowAmt = "Y"
		Else
			sShowAmt = "N"
		End If
		
		sCheckdtStart = InStr( sStart, "_" )
		sCheckdtEnd = InStr( sEnd, "_" )
		sCheckdtStart2 = InStr( sStart2, "_" )
		sCheckdtEnd2 = InStr( sEnd2, "_" )
		
		if sCheckdtStart <> "0" then
			call alertbox("Start 1 Invalid Format")
		end if
		
		if sCheckdtEnd <> "0" then
			call alertbox("End 1 Invalid Format")
		end if
		
		if sCheckdtStart2 <> "0" then
			call alertbox("Start 2 Invalid Format")
		end if
		
		if sCheckdtEnd2 <> "0" then
			call alertbox("End 2 Invalid Format")
		end if
		
		if sEnd <= sStart then
			call alertbox("End 1 cannot smaller then Start 1")
		end if
		
		if sEnd2 <> "" or sStart2 <> "" then
			if sEnd2 <= sStart2 then
				call alertbox("End 2 cannot smaller then Start 2")
			end if
		end if

     	if sModeSub = "up" Then
   	        if sDesc = "" then
	            call alertbox("Description cannot be empty")
	        end if	       
	        
	        if sStart = "" then
	            call alertbox("Start Time 1 cannot be empty")
	        end if
	        
	        if sEnd = "" then
	            call alertbox("End Time 1 cannot be empty")
	        end if      
	        
	        if dAmount = "" then
	            call alertbox("Amount cannot be empty")
	        end if  
	        	        
	        Set rstCSType = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from cstype where PRIORITY = '" & dPriority & "' and PRIORITY <> '' "
            sSQL = sSQL & "and SUBTYPE <> '" & sId & "' "
            rstCSType.Open sSQL, conn, 3, 3
            if not rstCSType.eof then
                call alertbox("Priority `" & dPriority & "` already assigned to type `" & rstCSType("SUBTYPE") & "`   !")
			end if  
            pCloseTables(rstCSType)
	                    
            sSQL = "UPDATE cstype SET "                        
            sSQL = sSQL & "PART = '" & pRTIN(sDesc) & "',"
            sSQL = sSQL & "STIME = '" & pRTIN(sStart) & "'," 
            sSQL = sSQL & "ETIME = '" & pRTIN(sEnd) & "'," 
			sSQL = sSQL & "STIME2 = '" & pRTIN(sStart2) & "'," 
            sSQL = sSQL & "ETIME2 = '" & pRTIN(sEnd2) & "'," 
            sSQL = sSQL & "AMOUNT = '" & pFormat(dAmount,2) & "',"
			sSQL = sSQL & "SHOWAMT = '" & pRTIN(sShowAmt) & "',"				
            sSQL = sSQL & "PRIORITY = '" & pRTIN(dPriority) & "',"      
            sSQL = sSQL & "STATUS = '" & pRTIN(sStatus) & "',"  
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"        
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "' "
            sSQL = sSQL & "WHERE SUBTYPE = '" & sId & "'"
            conn.execute sSQL
            
			call confirmBox("Update Successful!", sMainURL&sAddURL)
          	          	
        elseif sModeSub = "save" Then
        
            Set rstCSType = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from cstype where SUBTYPE = '" & sId & "'" 
            rstCSType.Open sSQL, conn, 3, 3
            if not rstCSType.eof then
                call alertbox("Subsidy Type : " & sId & " already exist !")
			end if  
            pCloseTables(rstCSType)

			if sId = "" then
	            call alertbox("Subsidy Type cannot be empty")
	        end if

	        if sDesc = "" then
	            call alertbox("Description cannot be empty")
	        end if	       
	        
	        if sStart = "" then
	            call alertbox("Start Time 1 cannot be empty")
	        end if
	        
	        if sEnd = "" then
	            call alertbox("End Time 1 cannot be empty")
	        end if      
	        
	        if dAmount = "" then
	            call alertbox("Amount cannot be empty")
	        end if  
	        
	        Set rstCSType = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from cstype where PRIORITY = '" & dPriority & "' "
            sSQL = sSQL & "and SUBTYPE <> '" & sId & "' "
            rstCSType.Open sSQL, conn, 3, 3
            if not rstCSType.eof then
                	call alertbox("Priority `" & dPriority & "` already assigned to type `" & rstCSType("SUBTYPE") & "`   !")
			end if  
            pCloseTables(rstCSType)  

            sSQL = "insert into cstype (SUBTYPE, PART, STIME, ETIME, STIME2, ETIME2, AMOUNT, SHOWAMT, PRIORITY, STATUS, "
            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
            sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sId) & "',"		 
		    sSQL = sSQL & "'" & pRTIN(sDesc) & "',"
		    sSQL = sSQL & "'" & pRTIN(sStart) & "',"
		    sSQL = sSQL & "'" & pRTIN(sEnd) & "',"
			sSQL = sSQL & "'" & pRTIN(sStart2) & "',"
		    sSQL = sSQL & "'" & pRTIN(sEnd2) & "',"
		    sSQL = sSQL & "'" & pFormat(dAmount,2) & "',"
			sSQL = sSQL & "'" & pRTIN(sShowAmt)& "',"
		    sSQL = sSQL & "'" & pRTIN(dPriority)& "',"
		    sSQL = sSQL & "'" & pRTIN(sStatus)& "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
            sSQL = sSQL & ") "
            'response.write sSQL
		    conn.execute sSQL
            
			call confirmBox("Save Successful!", sMainURL&sAddURL)
                 
		 end if
    End If
          
    Set rstCSType = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from cstype where SUBTYPE='" & sId & "'" 
    rstCSType.Open sSQL, conn, 3, 3
    if not rstCSType.eof then
        sSubType = rstCSType("SUBTYPE")
        sDesc = rstCSType("PART")            
        sStart = rstCSType("STIME")
        sEnd = rstCSType("ETIME")
		sStart2 = rstCSType("STIME2")
        sEnd2 = rstCSType("ETIME2")
        dAmount = rstCSType("AMOUNT")
		sShowAmt = rstCSType("SHOWAMT")
        dPriority = rstCSType("PRIORITY")
        sStatus = rstCSType("STATUS")
		
    end if
    call pCloseTables(rstCSType)
    
     
    %>
 
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Subsidy Type Details</h1>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="cstype_det.asp" method="post">
                            <input type="hidden" id="txtSearch" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                               <div class="box-body">
                                
									<!-- Subsidy Type -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Subsidy Type : </label>
										<div class="col-sm-3">
											<%if sSubType <> "" then %>
												<span class="mod-form-control"><% response.write sSubType %></span>
												<input type="hidden" id="txtID" name="txtID" value="<%=sID%>" />
                                            <%else%>
                                           		<input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform: uppercase" input-check />
                                            <%end if%>
										</div>
									</div>
                                
                                	<!-- Description -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Description : </label>
										<div class="col-sm-6">
											<input class="form-control" id="txtDesc" name="txtDesc" value="<%=server.htmlencode(sDesc)%>" maxlength="30" input-check />
										</div>
									</div>
                                    
                                    <!-- Period 1 -->                                   
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Start 1 : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtStart" name="txtStart" value='<%=sStart%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
										
										<label class="col-sm-1 control-label">End 1 : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtEnd" name="txtEnd" value='<%=sEnd%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Period 2 --> 
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Start 2 : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtStart2" name="txtStart2" value='<%=sStart2%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
										
										<label class="col-sm-1 control-label">End 2 : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtEnd2" name="txtEnd2" value='<%=sEnd2%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
									
									<!-- Amount -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Subsidy Amount (RM) : </label>
                                        <div class="col-sm-2" >
                                            <input  class="form-control" id="txtAmount" name="txtAmount" value="<%=server.htmlencode(pFormatDec(dAmount,2))%>" maxlength="10" placeholder="RM" onkeypress='return isNumberKey(event)' style="text-align:right;" >    	
											
										</div>
										<div class="control-label" >
											<div class="col-sm-2">
												<input type="checkbox" id="cbkShow" name="cbkShow" <%if sShowAmt="Y" then%>checked<%end if%>/>&nbsp;Show Amount
											</div>
										</div>	
                                    </div>
									
									<!-- Priority -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Priority : </label>
                                        <div class="col-sm-2" >
                                            <input  class="form-control" id="txtPriority" name="txtPriority" value="<%=dPriority%>" maxlength="2" onkeypress='return isNumberKey(event)' style="text-align:right;" >    	
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
	                                    <%if sSubType <> "" then %>
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
    <!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
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

		showDetails('txtSubType=<%=sSubType%>',pfldName,pType,pContent)
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
		
		xhttp.open("GET", "cstype_del.asp?"+str, true);
	  		  	
  	    xhttp.send();
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
 	</script>
 	
 	<script>
    $(function () {

        //Time mask
        $("[data-mask]").inputmask();
    
    });
    </script>
	<!--Script End-->
	<!--Script End-->
	

</body>
</html>
