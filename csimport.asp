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
    sMainURL = "csimport.asp?"
     
    if sModeSub <> "" Then
        
        sType = reqForm("selType")
        dtDate = reqForm("dtpDate")
        dtToDate = reqForm("dtpToDate")
        sDeptID = reqForm("txtDeptID")
        sGradeID = reqForm("txtGradeID")
        dtJoinDate = reqForm("dtpJoinDate")
        sCostID = reqForm("txtCostID")
        sContID = reqForm("txtContID")
        dCoupon = reqForm("txtCoupon")
        sStatus = "Y"
         
        if sModeSub = "up" Then
        	
            arr = Split(request("ToLB"),",")
               
            if request("ToLB") = "" then   		
	       		call alertbox("No employee assigned")
	   		end if
            
            For i = 0 to Ubound(arr)
            
            	sEmpCode = trim(arr(i))
				dtStart = dtDate
				            
            	if sType = "N" Then
            	
	            	if dCoupon = "" or not isNumeric(dCoupon) then
	            		call alertbox("Subsidy amount cannot be empty")
					end if
					
	                Set rstCSEmply = server.CreateObject("ADODB.RecordSet")    
		            sSQL = "select * from csemply "
		            sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "'"
		            rstCSEmply.Open sSQL, conn, 3, 3		            
		            if not rstCSEmply.eof then
		            
		                sSQL = "UPDATE csemply SET "                      
			            sSQL = sSQL & "COUPON = '" & pFormat(dCoupon,2) & "',"
			            sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"       
			            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
			            sSQL = sSQL & " WHERE EMP_CODE = '" & sEmpCode & "'"
			            conn.execute sSQL
							
	     			else
	     				     			
	     				Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
			            sSQL = "select * from tmemply "
			            sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "'"
			            rstTMEmply.Open sSQL, conn, 3, 3
						if not rstTMEmply.eof then
						
					        sSQL = "insert into csemply (EMP_CODE, NAME, CARDNO, COUPON, STATUS, "
				            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
				            sSQL = sSQL & "values ("
						    sSQL = sSQL & "'" & pRTIN(sEmpCode) & "',"		 
						    sSQL = sSQL & "'" & rstTMEmply("NAME") & "',"
						    sSQL = sSQL & "'" & rstTMEmply("CARDNO") & "',"
						    sSQL = sSQL & "'" & pFormat(dCoupon,2) & "',"
						    sSQL = sSQL & "'" & sStatus & "',"
						    sSQL = sSQL & "'" & session("USERNAME") & "'," 
						    sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
						    sSQL = sSQL & "'" & session("USERNAME") & "'," 
						    sSQL = sSQL & "'" & fDatetime2(Now()) & "'"
				            sSQL = sSQL & ") "
				 	  	    conn.execute sSQL
				 	  	    
			 	  	    end if
			 	  	    call pCloseTables(rstTMEmply)
			        
			        end if  
		            call pCloseTables(rstCSEmply)
		            
	            else
	            	            	
            		if dtDate = "" then   		
			       		call alertbox("From Date cannot be empty")
			   		end if
			    
			        if dtToDate = "" then
			            call alertbox("To Date cannot be empty")
			        end if
			        			        
			        iRange = (DateDiff("d",dtDate,dtToDate))
			        Set rstCSEmply = server.CreateObject("ADODB.RecordSet")    
		            sSQL = "select * from csemply "
		            sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "'"
		            rstCSEmply.Open sSQL, conn, 3, 3		            
		            if rstCSEmply.eof then
		                
		                Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
			            sSQL = "select * from tmemply "
			            sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "'"
			            rstTMEmply.Open sSQL, conn, 3, 3
						if not rstTMEmply.eof then
							
							Set rstCSPath = server.CreateObject("ADODB.RecordSet")    
				            sSQL = "select * from cspath "
				            rstCSPath.Open sSQL, conn, 3, 3
							if not rstCSPath.eof then
							
						        sSQL = "insert into csemply (EMP_CODE, NAME, CARDNO, COUPON, STATUS "
					            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
					            sSQL = sSQL & "values ("
							    sSQL = sSQL & "'" & pRTIN(sEmpCode) & "',"		 
							    sSQL = sSQL & "'" & rstTMEmply("NAME") & "',"
							    sSQL = sSQL & "'" & rstTMEmply("CARDNO") & "',"
							    sSQL = sSQL & "'" & rstCSPath("COUPON") & "',"
							    sSQL = sSQL & "'" & sStatus & "',"
							    sSQL = sSQL & "'" & session("USERNAME") & "'," 
							    sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
							    sSQL = sSQL & "'" & session("USERNAME") & "'," 
							    sSQL = sSQL & "'" & fDatetime2(Now()) & "'"
					            sSQL = sSQL & ") "
					 	  	    conn.execute sSQL
				 	  	    
				 	  	    end if
				 	  	    call pCloseTables(rstCSPath)

			 	  	    end if
			 	  	    call pCloseTables(rstTMEmply)
			 	  	    
			 	  	end if
						
					For intID = 0 to iRange
						
					    Set rstCSEmply1 = server.CreateObject("ADODB.RecordSet")    
			            sSQL = "select * from csemply1 "
			            sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "'"
			            sSQL = sSQL & "and TYPE = '" & sType & "'"
			            sSQL = sSQL & "and DT_SUB = '" & fDate2(dtStart) & "'" 
			            rstCSEmply1.Open sSQL, conn, 3, 3
			            if not rstCSEmply1.eof then
         		
		            		set rstCSType = server.CreateObject("ADODB.RecordSet")    
				            sSQL = "select * from cstype where SUBTYPE = '" & sType & "' " 
				            rstCSType.Open sSQL, conn, 3, 3
				            if not rstCSType.eof then
	
				                sSQL = "UPDATE csemply1 SET "                      
					            sSQL = sSQL & "EMP_CODE ='" & pRTIN(sEmpCode) & "',"		 
							    sSQL = sSQL & "TYPE ='" & pRTIN(sType) & "',"
							    sSQL = sSQL & "DT_SUB ='" & fdate2(dtStart) & "',"
							    sSQL = sSQL & "AMOUNT ='" & pFormat(rstCSType("AMOUNT"),2) & "',"
							    sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "'," 
							    sSQL = sSQL & "DATETIME ='" & fdatetime2(Now()) & "'"
					            sSQL = sSQL & "WHERE EMP_CODE = '" & sEmpCode & "'"
					            sSQL = sSQL & "and DT_SUB = '" & fdate2(dtStart) & "'"
					            sSQL = sSQL & "and TYPE = '" & sType & "'"
								conn.execute sSQL
								
							end if
							pCloseTables(rstCSType)	
								
		     			else
		     				
	     					set rstCSType = server.CreateObject("ADODB.RecordSet")    
				            sSQL = "select * from cstype where SUBTYPE = '" & sType & "' " 
				            rstCSType.Open sSQL, conn, 3, 3
				            if not rstCSType.eof then
				            
						        sSQL = "insert into csemply1 (EMP_CODE, TYPE, DT_SUB, AMOUNT, "
					            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
					            sSQL = sSQL & "values ("
							    sSQL = sSQL & "'" & pRTIN(sEmpCode) & "',"		 
							    sSQL = sSQL & "'" & pRTIN(sType) & "',"
							    sSQL = sSQL & "'" & fdate2(dtStart) & "',"
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
		
		           		dtStart = (DateAdd("d",1,dtStart))	
						
		            Next
		        End If
            
            Next
            
            call confirmBox("Update Successful!", sMainURL&sAddURL)
            
        elseif sModeSub = "del" Then
        	 
        	if dtDate = "" then   		
	       		call alertbox("From Date cannot be empty")
	   		end if
	    
	        if dtToDate = "" then
	            call alertbox("To Date cannot be empty")
	        end if
	        
	        arr = Split(request("ToLB"),",")
               
            if request("ToLB") = "" then   		
	       		call alertbox("No employee assigned")
	   		end if
            
            For i = 0 to Ubound(arr)
            
            	sEmpCode = trim(arr(i))
				dtStart = dtDate
	                       
				iRange = (DateDiff("d",dtDate,dtToDate))
				For intID = 0 to iRange

					set rstCSEmply1 = server.CreateObject("ADODB.RecordSet")    
					sSQL = "select * from csemply1 "
					sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "'"
					sSQL = sSQL & "and TYPE = '" & sType & "'"
					sSQL = sSQL & "and DT_SUB = '" & fDate2(dtStart) & "'" 
					rstCSEmply1.Open sSQL, conn, 3, 3
					if not rstCSEmply1.eof then
					
						sSQL = "delete from csemply1 "
						sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "' "
						sSQL = sSQL & "and TYPE = '" & sType & "' "
						sSQL = sSQL & "and DT_SUB= '" & fDate2(dtStart) & "'" 
						conn.execute sSQL
						
					end if
					pCloseTables(rstCSEmply1)
					dtStart = (DateAdd("d",1,dtStart))	
				Next

			Next
			
            call confirmBox("Delete Successful!", sMainURL&sAddURL)
			
        End If 
    End If
%>


	</head>


<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Generate Subsidy</h1>
            </section>
            <!-- Main content -->
            <section class="content">
            	  <!--/row -->
                <div class="row">
                	   <!-- col-md-12 -->
                    <div class="col-md-12">
                        <!-- form start -->
                        <form class="form-horizontal" action="csimport.asp" method="post">
                        	<!-- box box-info -->
                            <div class="box box-info">
                                <!-- box body -->
                                <div class="box-body">
                                   <!-- form group -->
                                   <div class="form-group">
                                   		<!--Type-->
                                        
                                        <div class="col-sm-3" >
                                        	<label >Type : </label>
                                            <select id="selType" name="selType" class="form-control" onchange="hideDiv()">
                                                <option value="N" <%if sType = "N" then%>Selected<%end if%>>Normal</option>
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
                                   <div id="divType" style="display: none"> 
                                   <%else%>
                                   <div id="divType">	
                                   <%end if%>							
	                                   <!-- form group -->
			                           <div class="form-group">
			                           
			                           		<!--Extra Coupon From Date-->
					                        <div class="col-sm-3" >
					                        <label>From Date :</label>
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
					                        <div class="col-sm-3" >
					                        	<label>To Date :</label>
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
								   
								   <!-- form group -->
                                   <div class="form-group">
                                   
                                   	    <!--Department-->
                               		    <div class="col-sm-3" >
                               		   	   <label>Department :</label>
										   <div class="input-group">
				                               <input class="form-control" id="txtDeptID" name="txtDeptID" value="<%=sDeptID%>" maxlength="15" style="text-transform: uppercase" input-check  >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('DEPT','txtDeptID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>

                                        </div>
                                   
                                       <!--Grade-->
                               		   <div class="col-sm-3" >
                               		   	   <label>Grade :</label>
 										   <div class="input-group">
				                               <input class="form-control" id="txtGradeID" name="txtGradeID" value="<%=sGradeID%>" maxlength="15" style="text-transform: uppercase" input-check >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('GRADE','txtGradeID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>
                                       </div>
                                       
                                       <!--Join Date-->
                               		   <div class="col-sm-3" >
                               		       <label>Join Date :</label>
 										   <div class="input-group">
				                               <input id="dtpJoinDate" name="dtpJoinDate" value="<%=fDatelong(dtJoinDate)%>" type="text" class="form-control" date-picker >
												<span class="input-group-btn">
													<a href="#" id="btndt_Joindate" class="btn btn-default" style="margin-left: 0px">
														<i class="fa fa-calendar"></i>
													</a>
												</span>
	                                       </div>
                                       </div>


                                  </div>
                                  <!--/.form group -->
                                  
							      <!-- form group -->
								  <div class="form-group">
  
                                       <!--Cost Center-->
                               		   <div class="col-sm-3" >
                               		   	   <label>Cost Center :</label>
 										   <div class="input-group">
				                               <input class="form-control" id="txtCostID" name="txtCostID" value="<%=sCostID%>" maxlength="15" style="text-transform: uppercase" input-check >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('COST','txtCostID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>
                                       </div>
                                       
                                       <!--Employee Contract-->
                               		   <div class="col-sm-3" >
                               		       <label>Contract :</label>
 										   <div class="input-group">
				                               <input class="form-control" id="txtContID" name="txtContID" value="<%=sContID%>" maxlength="15" style="text-transform: uppercase" input-check >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('CONT','txtContID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>  
                                       </div>
                                       
                                 	   <!--Add Button-->
				                       <div class="col-sm-4" align="LEFT">
				                        	<label></label>
				                      		<div class="input-group" >
				                      			 
					                       		<button type="button" name="sub" value="reset" class="btn btn-info" style="width: 94px" onclick="txtReset();">Clear</button>
					                       		&nbsp;
					 							<button type="submit" name="sub" value="filter" class="btn btn-info" style="width: 94px">Filter</button>
					 						</div>
				 					   </div>

								   </div>
	                               <!--/.form group -->
  
								   <!-- form group -->
                                   <div id="selList" class="form-group" style="overflow:auto;padding:0px;margin:0px">
                                    	<table id="example1">
                                        <tbody>
                                            <tr>
                                                <td width="2%"></td>
                                                <td width="5%" style="padding: 7px"><b>Unassigned Employee(s) :</b>
                                                    <select multiple size="15" style="width: 405px;" name="FromLB" id="FromLB" ondblclick="move(this.form.FromLB,this.form.ToLB)">
                                                        <%  
                                                        Set rstSelect = server.CreateObject("ADODB.RecordSet")        
														sSQL = "select * from tmemply where 1=1 "

                                                        if sDeptID <> "" then
															sSQL = sSQL & "AND DEPT_ID ='" & pRTIN(sDeptID) & "'"
														end if
														
														if sGradeID <> "" then
															sSQL = sSQL & "AND GRADE_ID ='" & pRTIN(sGradeID) & "'"
														end if	
														
														if sCostID <> "" then
															sSQL = sSQL & "AND COST_ID ='" & pRTIN(sCostID) & "'"
														end if
														
														if sContID <> "" then
															sSQL = sSQL & "AND CONT_ID ='" & pRTIN(sContID) & "'"
														end if
														
														if dtJoinDate <> "" then
															sSQL = sSQL & "AND DT_JOIN >='" & fdate2(dtJoinDate) & "'"
														end if
														
														sSQL = sSQL & " order by EMP_CODE asc"
                                                        rstSelect.Open sSQL, conn, 3, 3
                                                        if not rstSelect.eof then
	                                                        do while not rstSelect.eof 
	                                                            
	                                                            Set rstName = server.CreateObject("ADODB.RecordSet")    
	                                                            sSQL = "select Name from TMEMPLY where EMP_CODE ='" & rstSelect("EMP_CODE") & "'" 
	                                                            rstName.Open sSQL, conn, 3, 3
	                                                            if not rstName.eof then
	                                                                sName = rstName("Name")
	                                                            end if        
	                                                            pCloseTables(rstName)
	
	                                                            response.write "<option value='" & rstSelect("EMP_CODE") & "'>" & rstSelect("EMP_CODE") & " - " & sName & "</option>"  
	                                                            rstSelect.movenext
	                                                        loop
                                                        end if     
                                                        %>
                                                    </select>
                                                </td>
                                                
                                                <td width="3%" >
                                                	<input type="button" class="btn btn-primary" style="width: 50px" onclick="moveAll(this.form.FromLB, this.form.ToLB)" value="   >>   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="move(this.form.FromLB, this.form.ToLB)" value="   >   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="move(this.form.ToLB, this.form.FromLB)" value="   <   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="moveAll(this.form.ToLB, this.form.FromLB)" value="   <<   ">

                                                </td>
                                                
                                                <td width="5%" style="padding: 7px"><b>Assigned Employee(s) : </b>
                                                    <select multiple size="15" style="width: 405px;" name="ToLB" id="ToLB" ondblclick="move(this.form.ToLB,this.form.FromLB)">    
                                                    </select>
                                                </td>
                                               
                                            </tr>
                                        </tbody>
                                    	</table>
                                   </div>
                                   <!--/.form group -->
									<!-- box-footer -->
									<div class="box-footer">
										<button type="submit" id="btnUp" name="sub" value="up" class="btn btn-success pull-right" style="width: 90px">Update</button>
										<!-- Coupon -->
												                                    	
										<div id="divType2" class="form-group">
											<label class="col-sm-7 control-label">Subsidy Amount (RM) : &nbsp;<font style="color:red">*</font> </label>
										
											<div class="col-sm-3 " >
												<input  class="form-control" id="txtCoupon" name="txtCoupon" value="" maxlength="10" placeholder="RM" onkeypress='return isNumberKey(event)' style="text-align:right;" >    	
											</div>
										</div>
										
										<div id="divType3" class="form-group">
											<button type="submit" id="btnDel" name="sub" value="del" class="btn btn-danger pull-left" style="width: 90px">Delete</button>
										</div>

										
	                                </div>
	                                <!-- /.box-footer -->
	                                
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
    
    $( document ).ready(function() {
	var type = document.getElementById("selType").value;
	if (type == "N"){
		$("#divType").hide();
		$("#divType2").show();
		$("#divType3").hide();
	}else{
		$("#divType").show();
		$("#divType2").hide();
		$("#divType3").show();
	}
	});
 	</script>
	
	<!--Onclick Hide Div-->
    <script>
    function hideDiv(){
	var s = document.getElementById("selType").value;
	if ( s == "N"){
		$("#divType").hide();
		$("#divType2").show();
		$("#divType3").hide();
		document.getElementById("selType").value;
		}
	else{
		$("#divType").show();
		$("#divType2").hide();
		$("#divType3").show();
	}
	};
    </script>
        
    <!--Reset Button-->
    <script>
	function txtReset()
	{
		document.getElementById("txtContID").value = "";
	    document.getElementById("txtGradeID").value = "";
	    document.getElementById("txtDeptID").value = "";
		document.getElementById("txtCostID").value = "";
		document.getElementById("dtpJoinDate").value = "";
		document.getElementById("dtpDate").value = "";
		document.getElementById("dtpToDate").value = "";
	}
	</script>
    
	<!--date picker-->
    <script>
    $('#btndt_date').click(function () {
        $('#dtpDate').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtpToDate').datepicker("show");
    }); 
    
	$('#btndt_Joindate').click(function () {
        $('#dtpJoinDate').datepicker("show");
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
  	    
  	    var search = document.getElementById("txtSearch");
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			
 			str = str + "&fldName=" + pFldName;
 			
		if (pType=="DEPT") {
	  	    xhttp.open("GET", "ajax/ax_csview_deptID.asp?"+str, true);
	  	} else if(pType=="GRADE") {
	  		xhttp.open("GET", "ajax/ax_csview_gradeID.asp?"+str, true);
  		} else if(pType=="COST") {
  			xhttp.open("GET", "ajax/ax_csview_costID.asp?"+str, true);
		} else if(pType=="CONT") {  		
			xhttp.open("GET", "ajax/ax_csview_contID.asp?"+str, true);
	  	}
	  	
  	    xhttp.send();
    }
	</script>

	<!--move selected-->
    <script>
    function move(tbFrom, tbTo) {
	 	var arrFrom = new Array(); var arrTo = new Array(); 
	 	var arrLU = new Array();
	 	var i;
	 	for (i = 0; i < tbTo.options.length; i++) {
	  		arrLU[tbTo.options[i].text] = tbTo.options[i].value;
	  		arrTo[i] = tbTo.options[i].text;
	 	}
	 	var fLength = 0;
	 	var tLength = arrTo.length;
	 	for(i = 0; i < tbFrom.options.length; i++) {
	  		arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;
	  		if (tbFrom.options[i].selected && tbFrom.options[i].value != "") {
	   			arrTo[tLength] = tbFrom.options[i].text;
	   			tLength++;
	  		} else {
				arrFrom[fLength] = tbFrom.options[i].text;
	   			fLength++;
	  		}
		}
	
		tbFrom.length = 0;
		tbTo.length = 0;
		var ii;
	
		for(ii = 0; ii < arrFrom.length; ii++) {
	  		var no = new Option();
	  		no.value = arrLU[arrFrom[ii]];
	  		no.text = arrFrom[ii];
	        tbFrom[ii] = no;
	
		}
	
		for(ii = 0; ii < arrTo.length; ii++) {
	 		var no = new Option();
	 		no.value = arrLU[arrTo[ii]];
	 		no.text = arrTo[ii];
	 		tbTo[ii] = no;
		}
	}
	</script>
	
	<!--move all-->
	<script>
    function moveAll(tbFrom, tbTo) {
	 	var arrFrom = new Array(); var arrTo = new Array(); 
	 	var arrLU = new Array();
	 	var i;
	 	for (i = 0; i < tbTo.options.length; i++) {
	  		arrLU[tbTo.options[i].text] = tbTo.options[i].value;
	  		arrTo[i] = tbTo.options[i].text;
	 	}
	 	var fLength = 0;
	 	var tLength = arrTo.length;
	 	for(i = 0; i < tbFrom.options.length; i++) {
	  		arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;
	  		arrTo[tLength] = tbFrom.options[i].text;
	   		tLength++;
	  	}
	
	
		tbFrom.length = 0;
		tbTo.length = 0;
		var ii;
	
		for(ii = 0; ii < arrFrom.length; ii++) {
	  		var no = new Option();
	  		no.value = arrLU[arrFrom[ii]];
	  		no.text = arrFrom[ii];
	        tbFrom[ii] = no;
	
		}
	
		for(ii = 0; ii < arrTo.length; ii++) {
	 		var no = new Option();
	 		no.value = arrLU[arrTo[ii]];
	 		no.text = arrTo[ii];
	 		tbTo[ii] = no;
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
	
	$( "#txtDeptID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DP",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDeptID").val(ui.item.value);
				var str = document.getElementById("txtDeptID").value;
				var res = str.split(" | ");
				document.getElementById("txtDeptID").value = res[0];
			},0);
		}
	});	
	
	$( "#txtGradeID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=GC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtGradeID").val(ui.item.value);
				var str = document.getElementById("txtGradeID").value;
				var res = str.split(" | ");
				document.getElementById("txtGradeID").value = res[0];
			},0);
		}
	});	
	
	$( "#txtCostID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtCostID").val(ui.item.value);
				var str = document.getElementById("txtCostID").value;
				var res = str.split(" | ");
				document.getElementById("txtCostID").value = res[0];
			},0);
		}
	});	
	
	$( "#txtContID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CT",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtContID").val(ui.item.value);
				var str = document.getElementById("txtContID").value;
				var res = str.split(" | ");
				document.getElementById("txtContID").value = res[0];
			},0);
		}
	});	
    </script>
    
	<!--Script End-->
</body>
</html>
