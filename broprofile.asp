<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta charset="utf-8">
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
    <!-- Jquery 1.12.0 UI CSS -->

    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" />
<%
  	sEmpCode = session("USERNAME")
  
  	Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from tmemply where EMP_CODE = '" & sEmpCode & "'" 
    rstTMEmply.Open sSQL, conn, 3, 3
    if not rstTMEmply.eof then
       	sEmpName = rstTMEmply("NAME") 
       	sCardNo = rstTMEmply("CARDNO") 
       	if rstTMEmply("EMAIL") = "" then
       		sEmail = " - "
       	else
       		sEmail = rstTMEmply("EMAIL")
       	end if
    end if
    call pCloseTables(rstTMEmply) 
    
    Set rstTMDept = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select tmemply.DEPT_ID, tmdept.PART from tmemply "
    sSQL = sSQL & "left join tmdept on tmemply.DEPT_ID = tmdept.DEPT_ID "
    sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "' " 
    rstTMDept.Open sSQL, conn, 3, 3
    if not rstTMDept.eof then
       	sDeptID = rstTMDept("DEPT_ID") 
       	sDeptName = rstTMDept("PART") 
    end if
    call pCloseTables(rstTMDept) 

    Set rstBRODown = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select brodown.SUP_CODE, TMEMPLY.NAME  from brodown " 
    sSQL = sSQL & "left join tmemply on brodown.SUP_CODE = tmemply.EMP_CODE "
    sSQL = sSQL & "where brodown.EMP_CODE = '" & sEmpCode & "' and brodown.LEVEL = '0' "
    rstBRODown.Open sSQL, conn, 3, 3
    if not rstBRODown.eof then
       	sSupID = rstBRODown("SUP_CODE") 
       	sSupName = rstBRODown("NAME")
    end if
    call pCloseTables(rstBRODown) 
    
    Set rstTSArea = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select tsemply.AREACODE, AREA, ROUTE from tsemply " 
    sSQL = sSQL & "left join tsarea on tsemply.AREACODE = tsarea.AREACODE "
    sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "' "
    rstTSArea.Open sSQL, conn, 3, 3
    if not rstTSArea.eof then
       	sAreaCode = rstTSArea("AREACODE")
       	sArea =  rstTSArea("AREA")
       	sRoute = rstTSArea("ROUTE")
    end if
    call pCloseTables(rstTSArea)
    
    Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select count(TICKET_NO) AS PENDING from ogprop " 
    sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "' and STATUS = 'P'"
    rstOGProp.Open sSQL, conn, 3, 3
    if not rstOGProp.eof then
       	sPendOGP = rstOGProp("PENDING")
    end if
    call pCloseTables(rstOGProp)
    
    Set rstOGProp1 = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select count(ogprop1.TICKET_NO) AS UNRETURN from ogprop1 " 
    sSQL = sSQL & "left join ogprop on ogprop1.TICKET_NO = ogprop.TICKET_NO "
    sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "' and BAL <> '0' "
    rstOGProp1.Open sSQL, conn, 3, 3
    if not rstOGProp1.eof then
       	sUnreturn = rstOGProp1("UNRETURN")
    end if
    call pCloseTables(rstOGProp1)
    
    Set rstCSEmply = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select csemply.EMP_CODE, csemply.CARDNO, COUPON, TYPE, DT_SUB, AMOUNT from csemply " 
    sSQL = sSQL & "left join csemply1 on csemply.EMP_CODE = csemply1.EMP_CODE "
    sSQL = sSQL & "where csemply.EMP_CODE = '" & sEmpCode & "' and DT_SUB LIKE '%" & fDate2(now()) & "%' "
    rstCSEmply.Open sSQL, conn, 3, 3
    if not rstCSEmply.eof then
       	dNormalSub = rstCSEmply("COUPON")
       	dExtraSubType = rstCSEmply("TYPE")
       	dExtraSubAmt = rstCSEmply("AMOUNT")
    end if


    
%>

        
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">

        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_pass.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>View Profile</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                    	<div class="box box-info" style="padding-top:30px">
                                
                    		<!-- Employee Code -->
							<div class="form-group">
								<div class="col-sm-2" >
									<label class="control-label">My Profile : </label>
								</div>
								<div class="col-sm-2 input-group">
									<% response.write sEmpCode %> - <% response.write sEmpName %>					
								</div>
								
							</div>
									
							<!-- Card No -->
							<div class="form-group">
								<div class="col-sm-2" >
									<label class="control-label">Card No : </label>
								</div>
								<div class="input-group">
									<% response.write sCardNo %>
								</div>
							</div>
							
							<!-- Department -->
							<div class="form-group">
								<div class="col-sm-2" >
									<label class="control-label">Department : </label>
								</div>
								<div class="input-group">
									<% response.write sDeptID %> - <% response.write sDeptName %>
								</div>
							</div>
							
							<!-- Department -->
							<div class="form-group">
								<div class="col-sm-2" >
									<label class="control-label">Superior : </label>
								</div>
								<div class="input-group">
									<% response.write sSupID %> - <% response.write sSupName %>
								</div>
							</div>
							
							<!-- Email -->
							<div class="form-group">
								<div class="col-sm-2" >
									<label class="control-label">Email : </label>
								</div>
								<div class="input-group">
									<% response.write sEmail %>
								</div>
							</div>
					        <br/>                              
				            <div class="nav-tabs-custom col-sm-12">
				                <ul class="nav nav-tabs">
				                    <li class="active"><a data-toggle="tab" href="#TS">TS</a></li>
				                    <li><a data-toggle="tab" href="#MS">MS</a></li>
				                    <li><a data-toggle="tab" href="#CS">CS</a></li>
				                    <li><a data-toggle="tab" href="#TM">TM</a></li>
				                    <li><a data-toggle="tab" href="#VR">VR</a></li>
				                    <li><a data-toggle="tab" href="#OG">OG</a></li>
				                    <li><a data-toggle="tab" href="#CP">CP</a></li>
				                </ul>
				                <div class="tab-content">
				                
				                    <div id="TS" class="tab-pane fade in active">
										<h4>Transport System</h4>    
										<!-- Area Code -->
										<div class="form-group">
											<div class="col-sm-3" >
												<label class="control-label">Area Code : </label>
											</div>
											<div class="input-group">
												<% response.write sAreaCode %>
											</div>
											
										</div>
										
										<!-- Area -->
										<div class="form-group">
											<div class="col-sm-3" >
												<label class="control-label">Area : </label>
											</div>
											<div class="input-group">
												<% response.write sArea %>
											</div>
											
										</div>
										
										<!-- Route -->
										<div class="form-group">
											<div class="col-sm-3" >
												<label class="control-label">Route : </label>
											</div>
											<div class="input-group">
												<% response.write sRoute %>
											</div>
											
										</div>
				                    </div>
				                    
				                    <div id="MS" class="tab-pane fade">
				                        <h4>Medical System</h4>
				                    </div>
				                    
				                    <div id="CS" class="tab-pane fade">
				                        <h4>Canteen System</h4>
				                        <!-- Available Subsidy -->
										<div class="form-group">
											<div class="col-sm-3" >
												<label class="control-label">Today's Subsidy: </label>
											</div>
											<div class="input-group">
												<%
												response.write "Normal - RM " & pFormat(dNormalSub,2) & "<br/>"
												do while not rstCSEmply.eof
												
													response.write rstCSEmply("TYPE") & " - RM " & pFormat(rstCSEmply("AMOUNT"),2) & "<br/>"
												 
												rstCSEmply.movenext
												loop
												call pCloseTables(rstCSEmply)
												%>
	
											</div>

										</div>
				                    </div>
				                    
				                    <div id="TM" class="tab-pane fade">
				                        <h4>Time Management</h4>
				                    </div>
				                    
				                    <div id="VR" class="tab-pane fade">
				                        <h4>Vendor Registration</h4>
				                    </div>
				                    
				                    <div id="OG" class="tab-pane fade">
				                        <h4>Out Going Good Pass</h4>
										
										<!-- Pending OGP List -->
										<div class="form-group">
											<div class="col-sm-3" >
												<label class="control-label">Pending OGP: </label>
											</div>
											<div class="input-group">
												<%
												Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
											    sSQL = "select * from ogprop " 
											    sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "' and STATUS = 'P'"
											    rstOGProp.Open sSQL, conn, 3, 3
											    if not rstOGProp.eof then
											    	i = "0"
											       	Do while not rstOGProp.eof
														i = i + 1
														
											       		response.write i & ". " & rstOGProp("TICKET_NO") & "<br/>"
											       		
											       		'if i = "10" then
										       			'response.write "<br/>"
										       			'i= "0"
											       		'end if
											       		
											       	rstOGProp.movenext
											       	Loop
											    else
											    	response.write "-"
											    end if
											    call pCloseTables(rstOGProp)
												%>
											</div>
											
										</div>
																				
										<!-- Unreturned List -->
										<div class="form-group">
											<div class="col-sm-3" >
												<label class="control-label">Unreturned OGP : </label>
											</div>
											<div class="input-group">
												<%
												Set rstOGProp1 = server.CreateObject("ADODB.RecordSet")    
											    sSQL = "select ogprop1.TICKET_NO AS UNRETURN from ogprop1 " 
											    sSQL = sSQL & "left join ogprop on ogprop1.TICKET_NO = ogprop.TICKET_NO "
											    sSQL = sSQL & "where EMP_CODE = '" & sEmpCode & "' and BAL <> '0' "
											    rstOGProp1.Open sSQL, conn, 3, 3
											    if not rstOGProp1.eof then
											    
											    	i = "0"
											       	Do while not rstOGProp1.eof
														i = i + 1
														
											       		response.write i & ". " & rstOGProp1("UNRETURN") & "<br/>"
											       		
											       		'if i = "10" then
										       			'response.write "<br/>"
										       			'i= "0"
											       		'end if
											       		
											       	rstOGProp1.movenext
											       	Loop
											    else
											    	response.write "-"
											    end if
											    call pCloseTables(rstOGProp1)
												%>
											</div>
											
										</div>
				
				                    </div>
				                    
				                    <div id="CP" class="tab-pane fade">
				                        <h3>Reserve Car Park</h3>
				                    </div>
				                    
				                </div>
				                <!-- /.tab-content-->
				            </div>	
				            <!-- /.tab-custom-->
					    </div>
					    <!-- /.box-info-->		        
                    </div>
                    <!-- /.col-->
                </div>
                <!-- /.row -->
            </section>
            
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->


</body>
<!-- JQuery 2.2.3 Compressed -->
<script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
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
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

</html>
