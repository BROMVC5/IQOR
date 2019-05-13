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
    sMainURL = "ogprop.asp?"
    sMainURL2 = "ogprop_det.asp?"
    sAddURL = "txtSearch=" & server.HTMLEncode(sSearch) & "&Page=" & iPage 
            
    if sModeSub <> "" Then
       	
       	
       	sEmpCode = reqForm("txtEmpCode")
       	sCostId = reqForm("txtCostId")
       	sDest = reqForm("txtDest")
       	sRStatus = reqForm("cboRStatus")
       	sSerial = reqForm("txtSerial")
       	sPart = reqForm("txtPart")
       	dQty = reqForm("txtQty")
       	sPurpose = reqForm("txtPurpose")
        dtDate = reqForm("dtpDate") 
        dBal = dQty                  
	             
     	if sModeSub = "up" Then
     	
     		if sEmpCode = "" then
	            call alertbox("Requestor cannot be empty") 
	        else
	        	Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmemply where EMP_CODE ='" & sEmpCode & "'" 
	            rstTMEmply.Open sSQL, conn, 3, 3
				if rstTMEmply.eof then
	                call alertbox("Employee Code : " & sEmpCode & " does not exist !")
				end if
	            pCloseTables(rstTMEmply)
	        end if
	        
	        if sCostId = "" then
	            call alertbox("Cost Center cannot be empty")
	        else
	        	Set rstTMCost = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmcost where COST_ID ='" & sCostId & "'" 
	            rstTMCost.Open sSQL, conn, 3, 3
				if rstTMCost.eof then
	                call alertbox("Cost Center : " & sCostId & " does not exist !")
				end if
	            pCloseTables(rstTMCost)
	        end if
	
			if sDest = "" then
	            call alertbox("Destination cannot be empty")
	        end if 
     		            
            sSQL = "UPDATE ogprop SET "             
            sSQL = sSQL & "EMP_CODE = '" & pRTIN(sEmpCode) & "',"            
            sSQL = sSQL & "COST_ID = '" & pRTIN(sCostId) & "',"   
            sSQL = sSQL & "DEST = '" & pRTIN(sDest) & "',"  
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & "WHERE TICKET_NO = '" & pRTIN(sTicket) & "'"
            conn.execute sSQL
			            
          	response.redirect sMainURL2 & sAddURL & "&txtTicket=" & sTicket & ""
          	
        elseif sModeSub = "save" Then
        
        	set rstOGPath = server.CreateObject("ADODB.Recordset")
			sSQL = "select * from ogpath "
			rstOGPath.open sSQL, conn, 3, 3
			if not rstOGPath.eof then
				sSendMail = rstOGPath("SENDMAIL")
			end if
			call pCloseTables(rstOGPath)
        
        	if sEmpCode = "" then
	            call alertbox("Requestor cannot be empty") 
	        else
	        	Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmemply where EMP_CODE ='" & sEmpCode & "'" 
	            rstTMEmply.Open sSQL, conn, 3, 3
				if rstTMEmply.eof then
	                call alertbox("Employee Code : " & sEmpCode & " does not exist !")
				end if
	            pCloseTables(rstTMEmply)
	        end if
	        
	        if sCostId = "" then
	            call alertbox("Cost Center cannot be empty")
	        else
	        	Set rstTMCost = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmcost where COST_ID ='" & sCostId & "'" 
	            rstTMCost.Open sSQL, conn, 3, 3
				if rstTMCost.eof then
	                call alertbox("Cost Center : " & sCostId & " does not exist !")
				end if
	            pCloseTables(rstTMCost)
	        end if
	
			if sDest = "" then
	            call alertbox("Destination cannot be empty")
	        end if

            sSQL = "insert into ogprop (EMP_CODE, COST_ID, DEST, "
            sSQL = sSQL & "RSTATUS,SSTATUS, STATUS, "
            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
            sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sEmpCode) & "',"		 
		    sSQL = sSQL & "'" & pRTIN(sCostId) & "',"
		    sSQL = sSQL & "'" & pRTIN(sDest) & "',"
		    sSQL = sSQL & "'" & sRStatus & "',"
		    sSQL = sSQL & "'P',"
		    sSQL = sSQL & "'P',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
            sSQL = sSQL & ") "
		    conn.execute sSQL
		    
		    sSQL = "insert into ogpropz () values ()"
			conn.execute sSQL
			
			Set rstOGPropAuto = server.CreateObject("ADODB.RecordSet")    
        	sSQL = "select * from ogprop "
        	sSQL = sSQL & "order by AUTOINC desc limit 1"
        	rstOGPropAuto.Open sSQL, conn, 3, 3
        	if not rstOGPropAuto.eof then
        		dRecordAutoInc = rstOGPropAuto("AUTOINC")
        	end if

		    Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
		    sSQL = "select * from ogpropz " 
		    sSQL = sSQL & "order by AUTOINC desc limit 1"
		    rstOGProp.Open sSQL, conn, 3, 3
		    if not rstOGProp.eof then
		    	sInitial = "OG"
		    	dAutoInc = rstOGProp("AUTOINC")
		    	sTicket = sInitial & dAutoInc
		    	
			    sSQL = "UPDATE ogprop SET "			    
				sSQL = sSQL & "TICKET_NO = '" & pRTIN(sTicket) & "'"
				sSQL = sSQL & "WHERE AUTOINC = '" & dRecordAutoInc & "'"
				conn.execute sSQL
		    end if
		    call pCloseTables(rstOGProp)

		    if sSendMail = "Y" then
				
				if sRStatus = "Y" then
	            	set rstTMCost = server.CreateObject("ADODB.Recordset")
					sSQL = "SELECT tmcost.COST_ID, tmcost.COSTMAN_CODE,(select tmemply.EMAIL from tmemply where tmemply.EMP_CODE = tmcost.COSTMAN_CODE) as EMAIL FROM tmcost "
					sSQL = sSQL & "left join tmemply on tmcost.COST_ID =  tmemply.COST_ID "
					sSQL = sSQL & "where tmemply.EMP_CODE = '" & sEmpCode & "'"
					rstTMCost.open sSQL, conn, 3, 3
					if not rstTMCost.eof then
						sSuperior = rstTMCost("COSTMAN_CODE")
						sReceiver = rstTMCost("EMAIL")
					end if
					call pCloseTables(rstTMCost)
	            else
	            	set rstOGPath = server.CreateObject("ADODB.Recordset")
					sSQL = "select ogpath.FIN_MAN,ogpath.SENDMAIL, tmemply.EMAIL from ogpath "
					sSQL = sSQL & "left join tmemply on ogpath.FIN_MAN = tmemply.EMP_CODE "
					rstOGPath.open sSQL, conn, 3, 3
					if not rstOGPath.eof then
						sSuperior = rstOGPath("FIN_MAN")
						sReceiver = rstOGPath("EMAIL")
					end if
					call pCloseTables(rstOGPath)
	            end if
	            Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
			    sSQL = "select NAME from tmemply " 
			    sSQL = sSQL & "where tmemply.EMP_CODE = '" & sEmpCode & "'"
			    rstTMEmply.Open sSQL, conn, 3, 3
			    if not rstTMEmply.eof then
			        sEmpName = rstTMEmply("NAME")   
			    end if
			    call pCloseTables(rstTMEmply)
			    
			    set rstOGPath = server.CreateObject("ADODB.Recordset")
				sSQL = "select ogpath.EMP_CODE,DT_FROM,DT_TO, tmemply.EMAIL from ogpath "
				sSQL = sSQL & "left join tmemply on ogpath.EMP_CODE = tmemply.EMP_CODE "				
				rstOGPath.open sSQL, conn, 3, 3
				if not rstOGPath.eof then
					sActSuperior = rstOGPath("EMP_CODE")
					sActReceiver = rstOGPath("EMAIL")
					dtActFrom = rstOGPath("DT_FROM")
					dtActTo = rstOGPath("DT_TO")
				end if
				call pCloseTables(rstOGPath)
	             				
				if sReceiver <> "" then
					sSubject = "Outgoing Goods Pass Request by " & sEmpCode & ""

					sMess = "COMPANY : " & session("CONAME") & "<br>"
					sMess = sMess & "TICKET NO : " & sTicket & "<br>"
					sMess = sMess & "EMPLOYEE CODE : " & sEmpCode & "<br>"
					sMess = sMess & "EMPLOYEE NAME : " & sEmpName & "<br>"
					sMess = sMess & "COST CENTER : " & sCostId & "<br>"
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

				if fDate2(now()) >= fDate2(dtActFrom) and fDate2(now()) <= fDate2(dtActTo) Then
					if sActReceiver <> "" then
						sSubject = "Outgoing Goods Pass Request by " & sEmpCode & ""
	
						sMess = "COMPANY : " & session("CONAME") & "<br>"
						sMess = sMess & "TICKET NO : " & sTicket & "<br>"
						sMess = sMess & "EMPLOYEE CODE : " & sEmpCode & "<br>"
						sMess = sMess & "EMPLOYEE NAME : " & sEmpName & "<br>"
						sMess = sMess & "COST CENTER : " & sCostId & "<br>"
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
				end if
				
			end if
			
            response.redirect sMainURL2 & sAddURL & "&txtTicket=" & sTicket & ""
            
        elseif sModeSub = "add" Then
        	
        	if sEmpCode = "" then
	            call alertbox("Requestor cannot be empty") 
	        else
	        	Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmemply where EMP_CODE ='" & sEmpCode & "'" 
	            rstTMEmply.Open sSQL, conn, 3, 3
				if rstTMEmply.eof then
	                call alertbox("Employee Code : " & sEmpCode & " does not exist !")
				end if
	            pCloseTables(rstTMEmply)
	        end if
	        
	        if sCostId = "" then
	            call alertbox("Cost Center cannot be empty")
	        else
	        	Set rstTMCost = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmcost where COST_ID ='" & sCostId & "'" 
	            rstTMCost.Open sSQL, conn, 3, 3
				if rstTMCost.eof then
	                call alertbox("Cost Center : " & sCostId & " does not exist !")
				end if
	            pCloseTables(rstTMCost)
	        end if
	
			if sDest = "" then
	            call alertbox("Destination cannot be empty")
	        end if
	        
           	if sSerial = "" then
	            call alertbox("Serial/Part No cannot be empty")
	        end if
	        
	        if sPart = "" then
	            call alertbox("Property Description cannot be empty")
	        end if
	
			if dQty = "" or Not IsNumeric(dQty) then
	            call alertbox("Quantity cannot be empty")
	        end if
	        	        
	        dtSel = dtDate
            dtSel = fDateTime2(dtSel)   
            dtNow = fDateTime2(now())
	        if dtNow > dtSel then
             call alertbox("Date must be future")
            end if

            if sPurpose = "" then
	            call alertbox("Property Purpose cannot be empty")
	        end if
        
			sSQL = "insert into ogprop1 (TICKET_NO, SERIAL, PART, QTY, BAL, PURPOSE, ORI_DUE, DT_DUE, "
            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
            sSQL = sSQL & "values ("
			sSQL = sSQL & "'" & pRTIN(sTicket) & "',"
			sSQL = sSQL & "'" & pRTIN(sSerial) & "',"
		    sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		    sSQL = sSQL & "'" & pFormat(dQty,2) & "',"
		    sSQL = sSQL & "'" & pFormat(dBal,2) & "',"
		    sSQL = sSQL & "'" & pRTIN(sPurpose) & "',"
		    if dtDate = "" then
		    	sSQL = sSQL & "NULL,"
		    	sSQL = sSQL & "NULL,"
		    else
		    	sSQL = sSQL & "'" & fdate2(dtDate) & "',"
		    	sSQL = sSQL & "'" & fdate2(dtDate) & "',"
		    end if
    		sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
            sSQL = sSQL & ") "
            response.write sSQL
		    conn.execute sSQL
			    			    
		    sSQL = "UPDATE ogprop SET "             
            sSQL = sSQL & "EMP_CODE = '" & pRTIN(sEmpCode) & "',"            
            sSQL = sSQL & "COST_ID = '" & pRTIN(sCostId) & "',"   
            sSQL = sSQL & "DEST = '" & pRTIN(sDest) & "',"     
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"      
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & "WHERE TICKET_NO = '" & pRTIN(sTicket) & "'"
            conn.execute sSQL
		    		    
		    response.redirect sMainURL2 & sAddURL & "&txtTicket=" & sTicket & ""
		
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
        
    End If
          
    Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from ogprop where TICKET_NO ='" & sTicket & "'" 
    rstOGProp.Open sSQL, conn, 3, 3
    if not rstOGProp.eof then
        sEmpCode = rstOGProp("EMP_CODE")
       	sCostId = rstOGProp("COST_ID")
       	sDest = rstOGProp("DEST")
       	sAttach = rstOGProp("ATTACH")
       	sRStatus = rstOGProp("RSTATUS")
        sStatus = rstOGProp("STATUS")
        
    end if
    call pCloseTables(rstOGProp)
    
       
    %>
 
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_og.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>New Out Going Goods Pass</h1>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="ogprop_det.asp" method="post">
                            <input type="hidden" id="txtSearch" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
  							
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                               <div class="box-body">
                               		
                               		<%if sTicket <> "" then %>
                               		<!-- Ticket No -->
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">Ticket No : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<span class="mod-form-control"><% response.write sTicket %></span>
                                            	<input type="hidden" id="txtTicket" name="txtTicket" value="<%=sTicket%>" />					
											</div>
										</div>
									</div>
									<%end if%>
                               		  
                                	<!-- Employee Code -->
									<div class="form-group">
										<div class="col-sm-3" >
											<label class="control-label">Requestor : </label>
										</div>
										<div class="col-sm-3">
											<div class="input-group">
												<% if sTicket = "" or sStatus = "P" then %>
												<input class="form-control" id="txtEmpCode" name="txtEmpCode" value="<%=sEmpCode%>" maxlength="10" style="text-transform: uppercase" input-check />
												<span class="input-group-btn">
													<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('EMP','txtEmpCode','mycontent','#mymodal')">
													<i class="fa fa-search"></i>
												</a>
												</span>
												<%else%>
													<span class="mod-form-control"><% response.write sEmpCode%></span>
												<%end if%>
											</div>
										</div>
									</div>

									<!--Cost Center-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Cost Center : </label>
					                    </div>
				                        <div class="col-sm-3">  
				                               <% if sTicket = "" or sStatus = "P" then %>
				                               		<input class="form-control" id="txtCostId" name="txtCostId" value="<%=sCostId%>" maxlength="30" style="text-transform: uppercase" READONLY  >
		                                       <%else%>
													<span class="mod-form-control"><% response.write sCostId%></span>
												<%end if%>
                                        </div>
                                	</div>

                                	<!--Destination-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Destination : </label>
					                    </div>
				                        <div class="col-sm-5">
				                        	   <% if sTicket = "" or sStatus = "P" then %>
				                               <input class="form-control" id="txtDest" name="txtDest" value="<%=server.htmlencode(sDest)%>" maxlength="50" input-check  >
				                               <%else%>
													<span class="mod-form-control"><% response.write sDest%></span>
											   <%end if%>
                                        </div>
                                  
                                	</div>
                                	
                                	<!--Property Return-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">Property Return : </label>
					                    </div>
				                        <div class="col-sm-3">
				                        	<% if sTicket = "" then %>
				                            <select id="cboRStatus" name="cboRStatus" class="form-control">
                                                <option value="Y" <%if sRStatus = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sRStatus = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                            <%else%>
                                            	<%if sRStatus = "Y" then%>
													<span class="mod-form-control">Yes</span>
												<%else%>
													<span class="mod-form-control">No</span>
												<%end if%>
											<%end if%>
				
                                        </div>
                                	</div>
                                	
                                	<%if sTicket <> "" Then%>
                                	<!--File Attachment-->
                                    <div class="form-group">
                               		    <div class="col-sm-3" >
					                        	<label class="control-label">File Attachment : </label>
					                    </div> 
				                        <div class="col-sm-5">  
				                        
											<div class="input-group">	
												<span class="input-group-btn">
													<%if sTicket <> ""  and (sAccess = "A" or sAccess = "F" or sAccess = "D") and sStatus = "P" then %>
														<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default" onclick="fOpen('UPL','txtAttach','mycontent','#mymodal')">
														<i class="fa fa-upload" style="width: 80px;"> Upload</i>
														</a>
													<%else%>
														<a href="#" name="btnSearchId" id="btnSearchId" class="btn btn-default disabled" onclick="fOpen('UPL','txtAttach','mycontent','#mymodal')">	
														<i class="fa fa-upload" style="width: 80px"> Upload</i>
														</a>
													<%end if%>
												</span>
												<%if sTicket <> "" and sAttach = "" then%>
													<label class="control-label" style="margin-left: 10px;">No attachment</label>
												<%elseif sAttach <> "" then%>
													<button type="submit" name="sub" value="download" class="btn btn-default" style="margin-left: 5px;"><i class="fa fa-download" style="width: 80px"> Download</i></button>		
												<%end if%>
											</div>
                                        </div>
                                	</div>
                                	<%end if%>
	
                              </div>

									<!-- Footer Button -->
	                                <div class="box-footer">
	                                    <%if sTicket <> "" and sStatus = "P" then %>
	                                    <a href="#" onclick="fOpen('DEL','','mycontent','#mymodal')" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
	                                    <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
	                                    <%elseif sTicket = "" then%>
	                                    <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
	                                    <%end if %>
	                                </div>
                                <!-- /.box-footer -->
									 
                                <!-- /.box -->
		                    </div>
		            
						    <!--Extra coupon content start -->
					        <% if sTicket <> "" then %>
							
				            	<div class="box">
				            	
				                    <!-- /.box-header -->
				                    <div class="box-body">
				                    <% if sStatus = "P" then %>
				                    	<!--Add Button-->
				                    	<div>
				 						<button type="submit" name="sub" value="add" class="btn btn-block btn-success pull-right" style="width: 94px">Add Item</button>
				 						</div>
				                        
                                    <div class="form-group">
                                    	<!--Serial-->
				                        <div class="col-sm-5">
											<label class="control-label">Serial/Part No : </label>
											<input class="form-control" id="txtSerial" name="txtSerial" value="<%=server.htmlencode(sSerial)%>" maxlength="50" input-check  >
                                        </div>
                                        
                                  		<!--Property Description-->
                                  		<div class="col-sm-5">
											<label class="control-label">Property Description : </label>
											<input class="form-control" id="txtPart" name="txtPart" value="<%=server.htmlencode(sPart)%>" maxlength="50" input-check  >
                                        </div>
                                        
                                	</div>
                                	                                	
                                    <div class="form-group">                               		    
					                    <!--Quantity-->
				                        <div class="col-sm-2">
											<label class="control-label">Quantity : </label>
											<input class="form-control" id="txtQty" name="txtQty" value="<%=server.htmlencode(dQty)%>" maxlength="10" onkeypress='return isNumberKey(event)' style="text-align:right;">
                                        </div>
                                        
                                        <!--Due Date-->
				                        <div class="col-sm-3">
											<label class="control-label">Due Date : </label>
											 <div class="input-group">
											<input id="dtpDate" name="dtpDate" value="<%=fdatelong(dtDate)%>" type="text" class="form-control" date-picker >
			                                <span class="input-group-btn">
			                                    <a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
			                                        <i class="fa fa-calendar"></i>
			                                    </a>
			                                </span>
			                                </div>
                                        </div>
                                        
                                        <!--Purpose-->
				                        <div class="col-sm-5">
											<label class="control-label">Purpose : </label>
											<input class="form-control" id="txtPurpose" name="txtPurpose" value="<%=sPurpose%>" maxlength="50" input-check  >
                                        </div>
                                  
                                	</div>	
                                  	<%end if%>		
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
		document.getElementById(pContent).innerHTML = ""
		showDetails('txtTicket=<%=sTicket%>',pFldName,pType,pContent)
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
        
        if (pType=="COST") { 
            var search = document.getElementById("txtSearch2");
        } 
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			str = str + "&fldName=" + pFldName;
		
		if (pType=="DEL") {
	  	    xhttp.open("GET", "ogprop_del.asp?"+str, true);
	  	} else if (pType=="EMP") {
	  		xhttp.open("GET", "ajax/ax_ogview_empId2.asp?"+str, true);
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
	  	str = str + "&txtTicket=" + document.getElementById("txtTicket").value;
	  	
	  	xhttp.open("GET", "ajax/ax_ogprop_det.asp?"+str, true);
	  	xhttp.send();
	}
	
	$( "#txtEmpCode" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC3",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEmpCode").val(ui.item.value);
				$("#txtCostId").val(ui.item.data);
				var str = document.getElementById("txtEmpCode").value;
				var res = str.split(" | ");
				document.getElementById("txtEmpCode").value = res[0];

			},0);
		}
	});
	</script>	
	<!--Script End-->
	

</body>
</html>
