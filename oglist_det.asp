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
    sMainURL = "oglist.asp?"
    sMainURL2 = "oglist_det.asp?"
    sAddURL = "txtSearch=" & server.HTMLEncode(sSearch) & "&Page=" & iPage 
            
    if sModeSub <> "" Then
     
        sEmpCode = request("txtEmpCode")
        sEmpName = request("txtEmpName")
        sEmpCost = request("txtEmpCost")
        sDest = request("txtDest")
        dtDate = reqForm("dtpDate")
		if sModeSub = "update" then   
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
		    	
		    	dAutoInc = trim(request("cboFullList"&i))
		    	dQty = trim(request("dQtyList"&i))
		    	dRQty = trim(request("txtRQty"&i))
		    	dTRQty = trim(request("txtTotRQty"&i))
		    	dBal = trim(request("dBal"&i))
		    	dtPrevDue = trim(request("txtPrevDue"&i))
		    	dtDueDate = trim(request("txtDueDate"&i))
		    	dAbleRQty = dQty - dTRQty 

		    	if pFormat(dRQty,2) > pFormat(dAbleRQty,2) then
		    		call alertbox("Return quantity cannot more than balance")
		    	end if
	
				if dRQty > 0 then
					sSQL = "insert into ogprop2(ITEMINC, RQTY,"
					sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
		            sSQL = sSQL & "values ("
				    sSQL = sSQL & "'" & dAutoInc & "',"		 
				    sSQL = sSQL & "'" & pFormat(dRQty,2) & "',"
				    sSQL = sSQL & "'" & session("USERNAME") & "'," 
				    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
				    sSQL = sSQL & "'" & session("USERNAME") & "'," 
				    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "	
				    conn.execute sSQL
				    
				    sSQL = "UPDATE ogprop1 SET "
					sSQL = sSQL & "BAL = '" & pFormat(dBal,2) & "',"                                 
		            sSQL = sSQL & "DT_RETURN = '" & fDate2(Now()) & "',"
		            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
	    			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
		            sSQL = sSQL & "where AUTOINC = '" & dAutoInc & "' "
					conn.execute sSQL 
				    
				end if
				
				if dtPrevDue <> dtDueDate then
				
					sSQL = "UPDATE ogprop1 SET "
		            sSQL = sSQL & "DT_DUE = '" &  fDate2(dtDueDate) & "',"
		            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
	    			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
		            sSQL = sSQL & "where AUTOINC = '" & dAutoInc & "' "
		            conn.execute sSQL 
		            
		            sSQL = "insert into oglog(USER_ID, DATETIME,TYPE,REMARK) "
		            sSQL = sSQL & "values ("
				    sSQL = sSQL & "'" & session("USERNAME") & "'," 
				    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
				    sSQL = sSQL & "'EDIT',"
				    sSQL = sSQL & "'Ticket : " & sTicket & " ItemINC : " & dAutoInc & " Due Date :" & dtPrevDue & " > " & dtDueDate & "'"
		            sSQL = sSQL & ") "	
				    conn.execute sSQL
				    
		        end if  
			    
			Next

			set rstOGBal = server.CreateObject("ADODB.Recordset")
            sSQL = "SELECT SUM(bal) as sBal from ogprop1 "
            ssQL = sSQL & "where TICKET_NO = '" & sTicket & "' "
            rstOGBal.open sSQL, conn, 3, 3
            if not rstOGBal.eof then
                sBal = rstOGBal("sBal")
            end if
            call pCloseTables(rstOGBal)
             if sBal = "0" then
	            	set rstOGPass = server.CreateObject("ADODB.Recordset")
					sSQL = "select ogprop.TICKET_NO, ogprop.COST_ID,ogprop.DEST,ogprop.ATTACH,ogprop.RSTATUS,ogprop.SSTATUS,ogprop.STATUS,ogprop.DT_CREATE,ogprop.ASTATUS,tmemply.NAME, "
                    sSQL = sSQL & "tmemply.COST_ID AS EMPCOST,ogprop.EMP_CODE,tmemply.EMP_CODE,tmemply.DESIGN_ID,(select tmemply.EMAIL from tmemply where tmemply.EMP_CODE = ogprop.EMP_CODE) as EMAIL from ogprop " 
                    sSQL = sSQL & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
					sSQL = sSQL & "where tmemply.EMP_CODE = '" & sEmpCode & "'"
					rstOGPass.open sSQL, conn, 3, 3
					if not rstOGPass.eof then
						sSuperior = rstOGPass("EMP_CODE")
						sReceiver = rstOGPass("EMAIL")
					end if
					call pCloseTables(rstOGPass)
                    sSubject = "ACKNOWLEDGE TICKET NUMBER " & sTicket & ""
        
					sMess = "COMPANY : " & session("CONAME") & "<br>"
					sMess = sMess & "TICKET NO : " & sTicket & "<br>"
					sMess = sMess & "EMPLOYEE CODE : " & sEmpCode & "<br>"
					sMess = sMess & "EMPLOYEE NAME : " & sEmpName & "<br>"
					sMess = sMess & "COST CENTER : " & sEmpCost & "<br>"
					sMess = sMess & "DESTINATION : " & sDest & "<br><br>"
										
					sSQL = "insert into bromail (SUP_CODE,RECEIVER,SUBJECT,CONTENT,TYPE, "
		            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
		            sSQL = sSQL & "values ("		 
				    sSQL = sSQL & "'" & pRTIN(sSuperior) & "',"
				    sSQL = sSQL & "'" & pRTIN(sReceiver) & "',"
				    sSQL = sSQL & "'" & pRTIN(sSubject) & "',"
				    sSQL = sSQL & "'" & pRTIN(sMess) & "',"
				    sSQL = sSQL & "'OG',"
				    sSQL = sSQL & "'" & session("USERNAME") & "'," 
				    sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
				    sSQL = sSQL & "'" & session("USERNAME") & "'," 
				    sSQL = sSQL & "'" & fDatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
		 	  	    conn.execute sSQL
            end if
			response.redirect sMainURL & sAddURL
		
		elseif sModeSub = "approve" then
			sSQL = "UPDATE ogprop SET "                           
            sSQL = sSQL & "SSTATUS = 'A',"
            sSQL = sSQL & "DT_OUT = '" & fDate2(now()) & "',"
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & "where TICKET_NO = '" & sTicket & "' "
            conn.execute sSQL
            
            response.redirect sMainURL & sAddURL 
            
		elseif sModeSub = "reject" then
			sSQL = "UPDATE ogprop SET "                           
            sSQL = sSQL & "SSTATUS = 'R',"
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & "where TICKET_NO = '" & sTicket & "' "
            conn.execute sSQL
            
            response.redirect sMainURL & sAddURL 

        elseif sModeSub = "acknowledge" then
            sSubject = "Acknowledge Return OGP " & sEmpCode & ""

			        sSQL = "UPDATE ogprop SET "                           
                    sSQL = sSQL & "ASTATUS = 'Y',"
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
    sSQL = "select ogprop.TICKET_NO, ogprop.COST_ID,ogprop.DEST,ogprop.ATTACH,ogprop.RSTATUS,ogprop.SSTATUS,ogprop.STATUS,ogprop.DT_CREATE,ogprop.ASTATUS,tmemply.NAME, "
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
        sAStatus = rstOGProp("ASTATUS")
    end if
    call pCloseTables(rstOGProp)
    
    Set rstOGProp1 = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from ogprop1 "
    sSQL = sSQL & "where TICKET_NO ='" & sTicket & "' "
    sSQL = sSQL & "order by autoinc asc "
    rstOGProp1.Open sSQL, conn, 3, 3
    
    Set rstOGProp2A= server.CreateObject("ADODB.RecordSet")    
    sSQL = "select ogprop1.SERIAL, ogprop1.PART, ogprop1.PURPOSE, ogprop1.ORI_DUE, ogprop1.DT_DUE, ogprop2.RQTY, ogprop2.DT_CREATE from ogprop2 "
    sSQL = sSQL & "left join ogprop1 on ogprop2.ITEMINC = ogprop1.AUTOINC " 
    sSQL = sSQL & "where ogprop1.TICKET_NO ='" & sTicket & "' "
    sSQL = sSQL & "order by ogprop2.autoinc asc "
    rstOGProp2A.Open sSQL, conn, 3, 3
	
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
        set rstOGBal = server.CreateObject("ADODB.Recordset")
        sSQL = "SELECT SUM(bal) as sBal from ogprop1 "
        ssQL = sSQL & "where TICKET_NO = '" & sTicket & "' "
        rstOGBal.open sSQL, conn, 3, 3
        if not rstOGBal.eof then
            sBal = rstOGBal("sBal")
        end if
        call pCloseTables(rstOGBal)
		
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
                        	<form class="form-horizontal" action="oglist_det.asp" method="post">
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
                                                <input type="hidden" id="txtEmpCode" name="txtEmpCode" value='<%=sEmpCode%>' />
											</div>
										</div>
										<div class="col-sm-3" >
											<label class="control-label">Employee Name : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<span class="mod-form-control"><% response.write sEmpName %></span>
                                                <input type="hidden" id="txtEmpName" name="txtEmpName" value='<%=sEmpName%>' />
											</div>
										</div>

									</div>
									
									<!--Cost Center-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Cost Center : </label>
					                    </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                               <span class="mod-form-control"><% response.write sEmpCost %></span>
                                                <input type="hidden" id="txtEmpCost" name="txtEmpCost" value='<%=sEmpCost%>' />
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
									
									<div style="border-bottom-color:gray" class="box-header with-border"></div>
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
					                        	<label class="control-label">Date Created : </label>
					                    </div>
				                        <div class="col-sm-3">
				                            <div class="input-group">
				                               <span class="mod-form-control"><% response.write dtCDate %></span>		                                      
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
                                              <input type="hidden" id="txtDest" name="txtDest" value='<%=sDest%>' />
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
									
                                	<%if sStatus = "A" and sSStatus = "A" and sRStatus = "Y"  then%>
									<div style="overflow:auto;">
                                	<div style="padding:0px;margin:0px;table-layout:fixed;width:1125px;">
	                                	<div class="nav-tabs-custom">
											<ul class="nav nav-tabs">
												<li class="active"><a href="#tab1" data-toggle="tab">Return Item</a></li>
												<li><a href="#tab2" data-toggle="tab">View Returned Item</a></li>
											</ul>
											<div class="tab-content">
			             						<div class="tab-pane active" id="tab1" >
			             							<table id="example1" class="table table-bordered table-striped fixed"  >
														<thead>
															<tr>
																
												            	<!--th style="width:5%">No</th-->
												                <th style="width:100px">Serial/Part No</th>
												                <th style="width:150px">Property Description</th>
												                <th style="width:50px;text-align:right">Qty</th>
												                <th style="width:50px;text-align:right">Returned Qty</th>
												                <th style="width:50px;text-align:right">Return Qty</th>
												                <th style="width:50px;text-align:right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bal.</th>
												                <th style="width:150px">Purpose</th>
												                <th style="width:100px">Original Due</th>
												                <th style="width:100px">Due Date</th>
												                <th style="width:100px">Last Return Date</th>
												            </tr>
														</thead>
													
														<tbody>
														<%
														if not rstOGProp1.eof then
														    i = 0                  
															do while not rstOGProp1.eof
																Set rstOGProp2 = server.CreateObject("ADODB.RecordSet")    
															    sSQL = "select sum(RQTY) as RQTY from ogprop2 "
															    sSQL = sSQL & "where ITEMINC ='" & rstOGProp1("autoinc") & "' "
															    rstOGProp2.Open sSQL, conn, 3, 3
															    if not rstOGProp2.eof then
															    	dReturnedQty = rstOGProp2("RQTY")
															    	if isNULL(dReturnedQty)  then
															    		dReturnedQty = "0.00"
															    	end if
															    	dBalanceQty = rstOGProp1("QTY") - dReturnedQty
															    end if
															    call pCloseTables(rstOGProp2)
															i = i + 1                          
															response.write "<tr>"
															%>
															<input type="hidden" name="cboFullList<%=i%>" value="<%=rstOGProp1("autoinc")%>" />
															<input type="hidden" name="dQtyList<%=i%>" value="<%=rstOGProp1("QTY")%>" />
															<input type="hidden" name="txtPrevDue<%=i%>" value="<%=rstOGProp1("DT_DUE")%>" />
															<%
															response.write "<td style='vertical-align:middle'>" & rstOGProp1("SERIAL") & "</td>"
															response.write "<td style='vertical-align:middle'>" & rstOGProp1("PART") & "</td>"  
															response.write "<td id='dQty" & i & "' style=""text-align:right;vertical-align:middle"">" & pFormat(rstOGProp1("QTY"),2) & "</td>"
															response.write "<td ><input id='txtTotRQty" & i & "' name='txtTotRQty" & i & "' class='form-control' value='" & pFormat(dReturnedQty,2) & "' style='text-align:right;'/ READONLY></td>"
															response.write "<td ><input id='txtRQty" & i & "' name='txtRQty" & i & "' value='0.00' class='form-control' maxlength='10' onkeyup='fUpdateBal("& i &")' onkeypress='return isNumberKey(event)' style='text-align:right;'/></td>"
															response.write "<td ><input id='dBal" & i & "' name='dBal" & i & "' class='form-control' value='" & pFormat(dBalanceQty,2) & "' style='text-align:right;'/ READONLY></td>"
															response.write "<td style='vertical-align:middle'>" & rstOGProp1("PURPOSE") & "</td>"
															response.write "<td style='vertical-align:middle'>" & rstOGProp1("ORI_DUE") & "</td>"
															response.write "<td ><input id='dtpDate' name='txtDueDate" & i & "' value='" & rstOGProp1("DT_DUE")  & "' type='text' class='form-control' date-picker ></td>"
															response.write "<td style='vertical-align:middle'>" & rstOGProp1("DT_RETURN") & "</td>"
															response.write "</tr>"
															rstOGProp1.movenext
															loop
															
														end if
														call pCloseTables(rstOGProp1)
														
														%>                     
														</tbody>
														
													</table>
													
												</div>
												<!-- /.tab-pane -->
								              	<div class="tab-pane" id="tab2">
									                <table id="example2" class="table table-bordered table-striped">
														<thead>
															<tr>
																
												            	<!--th style="width:5%">No</th-->
												                <th style="width:10%">Serial/Part No</th>
												                <th style="width:20%">Property Description</th>
												                <th style="width:15%">Purpose</th>
												                <th style="width:7%">Original Due</th>
												                <th style="width:7%">Due Date</th>
												                <th style="width:7%;text-align:right">Returned Qty</th>
												                <th style="width:7%">Returned Date</th>
												            </tr>
														</thead>
													
														<tbody>
														<%
														if not rstOGProp2A.eof then
														    i = 0    
														    do while not rstOGProp2A.eof
              												
															i = i + 1                          
															response.write "<tr>"
															response.write "<td style='vertical-align:middle'>" & rstOGProp2A("SERIAL") & "</td>"
															response.write "<td style='vertical-align:middle'>" & rstOGProp2A("PART") & "</td>"  
															response.write "<td style='vertical-align:middle'>" & rstOGProp2A("PURPOSE") & "</td>" 
															response.write "<td style='vertical-align:middle'>" & rstOGProp2A("ORI_DUE") & "</td>"
															response.write "<td style='vertical-align:middle'>" & rstOGProp2A("DT_DUE") & "</td>" 
															response.write "<td style='vertical-align:middle;text-align:right'>" & rstOGProp2A("RQTY") & "</td>"
															response.write "<td style='vertical-align:middle'>" & fDateLong(rstOGProp2A("DT_CREATE")) & "</td>"
															response.write "</tr>"
															rstOGProp2A.movenext
															loop
															
														end if
														call pCloseTables(rstOGProp2A)
														%>                     
														</tbody>
														
													</table>
								             	</div>
								             	<!-- /.tab-pane -->
								              	
							            	</div>
							           		<!-- /.tab-content -->
						          		</div>
						          		<!-- nav-tabs-custom -->
										
									</div>
									</div>
									<%else%>
									<div style="overflow:auto;padding:0px;margin:0px">
										<table id="example3" class="table table-bordered table-striped">
											<thead>
												<tr>
													<th style="width:5%">No</th>
									                <th style="width:15%">Serial/Part No</th>
									                <th style="width:25%">Property Description</th>
									                <th style="width:5%;text-align:right">Qty</th>
									                <th style="width:25%">Purpose</th>
									                <th style="width:10%">Due Date</th>
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
												response.write "<td style=""text-align:right"">" & pFormat(rstOGProp1("QTY"),2) & "</td>"
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
									<%end if%>
									
          
									<div style="border-bottom-color:gray" class="box-header with-border"></div>
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
	                               	<%if sSStatus = "R" then%>
	                               		<div class="col-sm-12" align=right>
	                               			<font style="color:red"> Request rejected by security.</font>
	                               		</div>
	                               	<%elseif sStatus = "R" then%>
	                               		<div class="col-sm-12" align=right>
											<font style="color:red"> Request has rejected.</font>
										</div>
                                    <%elseif sAStatus = "N" and sStatus = "A" and sSStatus = "A" and sBal <> "0" and (sAccess = "S" or sAccess = "A")then%>
                                        <div class="col-sm-12" align=right>
											<button type="submit" name="sub" value="reject" class="btn btn-danger pull-left" style="width: 90px;">Reject</button>
                                            <button type="submit" name="sub" value="update" class="btn btn-info pull-right" style="width: 90px;margin-right:10px">Update</button>
                                        </div>
                                    <%elseif sAStatus = "N" and sStatus = "A" and sSStatus = "A" and sBal = "0" then%>
                                        <div class="col-sm-12" align=right>
                                            <button type="submit" name="sub" value="acknowledge" class="btn btn-info" style="width: 100px;">Acknowledge</button>
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

	<!--Update Bal-->
    <script>
	 function fUpdateBal(i) {
	 	var i = i
	 	var qty = document.getElementById("dQty"+i).innerText;
	 	var TRqty = document.getElementById("txtTotRQty"+i).value;
	 	var Rqty = document.getElementById("txtRQty"+i).value;
	 	var bal = qty - Rqty - TRqty;
	 	bal = parseFloat(bal).toFixed(2);
	 	document.getElementById("dBal"+i).value = bal ;
    	
     } 
    </script>

    
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
	
	<!--Script End-->
	

</body>
</html>
