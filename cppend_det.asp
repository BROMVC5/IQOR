<!DOCTYPE html>
<html>
<head>
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
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" />
	<!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
    <%
    sRF = UCase(request("txtReserveF"))
	sTicket_No = request("txtTicket_No")

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "cppend.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage 
		
    if sModeSub <> "" Then
        
		sReserveF = reqForm("txtReserveF")
		sLot_Qty = reqForm("txtLot_ID")
		sEmp_ID = reqForm("txtEmp_ID")
		sCar_No = reqForm("txtCar_No")
		sDtFrDate = reqForm("dtFrDate")
		sDtToDate = reqForm("dtToDate")
		sTimeIn = reqForm("txtTimeIn")
		sTimeOut = reqForm("txtTimeOut")
		sRemark = reqForm("txtRemark")
		sApp = reqForm("sApp")
		
        if sModeSub = "app" Then
            sAPP = "Y"
			
            sSQL = "UPDATE CPRESV SET "             
			sSQL = sSQL & "APPROVE = '" & sApp & "',"
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
            sSQL = sSQL & "WHERE TICKET_NO = '" & sTicket_No & "'"
            conn.execute sSQL
			
		elseif sModeSub = "rej" Then
			sAPP = "N"
			
            sSQL = "UPDATE CPRESV SET "             
			sSQL = sSQL & "APPROVE = '" & sApp & "',"
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
            sSQL = sSQL & "WHERE TICKET_NO = '" & sTicket_No & "'"
            conn.execute sSQL
           
        End If 
		
		'------------------------------------
		'---------SEND EMAIL START-----------
		'------------------------------------
		set rstCPPath = server.CreateObject("ADODB.Recordset")
		sSQL = "SELECT CPRESV.TICKET_NO,CPRESV.EMP_CODE, TMEMPLY.EMAIL FROM CPRESV "
		sSQL = sSQL & "LEFT JOIN TMEMPLY ON CPRESV.EMP_CODE = TMEMPLY.EMP_CODE "
		sSQL = sSQL & "WHERE TICKET_NO = '" & sTicket_No & "'"
		rstCPPath.open sSQL, conn, 3, 3
		if not rstCPPath.eof then
			sReceiver = rstCPPath("EMAIL")
		end if
		call pCloseTables(rstCPPath)
		
		Set rstRCReserve= server.CreateObject("ADODB.RecordSet")    
		sSQL = "SELECT CPRESV.TICKET_NO, CPRESV.R_NAME, CPRESV.EMP_CODE, TMEMPLY.NAME, TMEMPLY.DEPT_ID, CPRESV.CAR_NO, CPRESV.LOT_QTY, CPRESV.D_IN, "
		sSQL = sSQL + "CPRESV.D_OUT, CPRESV.T_IN, CPRESV.T_OUT, CPRESV.REMARK, CPRESV.APPROVE , TMEMPLY.NAME FROM CPRESV "
		sSQL = sSQL + "LEFT JOIN TMEMPLY ON CPRESV.EMP_CODE = TMEMPLY.EMP_CODE " 
		sSQL = sSQL + "where CPRESV.TICKET_NO ='" & sTicket_No & "'" 
		rstRCReserve.Open sSQL, conn, 3, 3
			if not rstRCReserve.eof then
				sTicket_No = rstRCReserve("TICKET_NO")
				sReserveF = rstRCReserve("R_NAME")
				sEmp_ID = rstRCReserve("EMP_CODE")
				sEmpName = rstRCReserve("NAME")
				sDeptId = rstRCReserve("DEPT_ID")
				sCar_No = rstRCReserve("CAR_NO")
				sLot_Qty = rstRCReserve("LOT_QTY")
			end if
		pCloseTables(rstRCReserve)

		if sReceiver <> "" then
			
			If sModeSub = "app" then
				sSubject = "Carpark Reservation Approved by " & session("USERNAME") & ""
			Elseif sModeSub = "rej" then
				sSubject = "Carpark Reservation Rejected by " & session("USERNAME") & ""
			End if
			
			EType = "CP"
			
			sMess = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD " & "<br>"
			sMess = sMess & " TICKET NO : " & sTicket_No & "<br>"
			sMess = sMess & " RESERVE FOR : " & sReserveF & "<br>"
			sMess = sMess & " EMPLOYEE CODE : " & sEmp_ID & "<br>"
			sMess = sMess & " EMPLOYEE NAME : " & sEmpName & "<br>"
			sMess = sMess & " DEPARTMENT : " & sDeptId & "<br>"
			sMess = sMess & " VEHICLE NO : " & sCar_No & "<br>"
			sMess = sMess & " LOT Quantity : " & sLot_Qty & "<br><br>"
			If sModeSub = "app" then
				sMess = sMess & " The Reservation had been APPROVED.</html>"
			Elseif sModeSub = "rej" then
				sMess = sMess & " The Reservation had been REJECTED.</html>"
			End if
			
			sSQL = "insert into BROMAIL (EMP_CODE,RECEIVER,SUBJECT,CONTENT,TYPE,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
			sSQL = sSQL & "values ("
			sSQL = sSQL & "'" & sEmp_ID & "',"		
			sSQL = sSQL & "'" & sReceiver & "',"
			sSQL = sSQL & "'" & sSubject & "',"
			sSQL = sSQL & "'" & sMess & "',"
			sSQL = sSQL & "'" & EType & "',"
			sSQL = sSQL & "'" & session("USERNAME") & "'," 
			sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
			sSQL = sSQL & "'" & session("USERNAME") & "'," 
			sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
			sSQL = sSQL & ") "
			conn.execute sSQL 
			
		end if
		
		if sModeSub ="app" then
			call confirmBox("Approved Successful!", sMainURL&sAddURL&"&txtTicket_No=" & sTicket_No & "")
		elseif sModeSub = "rej" then
			call confirmBox("Application Rejected!", sMainURL&sAddURL&"&txtTicket_No=" & sTicket_No & "")
		end if
		'------------------------------------
		'---------SEND EMAIL END-----------
		'------------------------------------
    End If
          
    Set rstRCReserve= server.CreateObject("ADODB.RecordSet")    
    sSQL = "SELECT CPRESV.TICKET_NO, CPRESV.R_NAME, CPRESV.EMP_CODE, CPRESV.CAR_NO, CPRESV.LOT_QTY, CPRESV.D_IN, "
	sSQL = sSQL + "CPRESV.D_OUT, CPRESV.T_IN, CPRESV.T_OUT, CPRESV.REMARK, CPRESV.APPROVE , TMEMPLY.NAME FROM CPRESV "
	sSQL = sSQL + "LEFT JOIN TMEMPLY ON CPRESV.EMP_CODE = TMEMPLY.EMP_CODE " 
	sSQL = sSQL + "where CPRESV.TICKET_NO ='" & sTicket_No & "'" 
    rstRCReserve.Open sSQL, conn, 3, 3
        if not rstRCReserve.eof then
			sTicket_No = rstRCReserve("TICKET_NO")
            sReserveF = rstRCReserve("R_NAME")
			sEmp_ID = rstRCReserve("EMP_CODE")
			sCar_No = rstRCReserve("CAR_NO")
			sLot_Qty = rstRCReserve("LOT_QTY")
			sDtFrDate = rstRCReserve("D_IN")
			sDtToDate = rstRCReserve("D_OUT")
			sTimeIn = rstRCReserve("T_IN")
			sTimeOut = rstRCReserve("T_OUT")
			sRemark = rstRCReserve("REMARK")
			sApp = rstRCReserve("APPROVE")
			sName = rstRCReserve("NAME")
        end if
    pCloseTables(rstRCReserve)
	
	
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left sICe column. contains the logo and sICebar -->
        <!-- #include file="include/sidebar_cp.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Reservation Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="cppend_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
									<%if sTicket_No<> "" then %>
									<div class="form-group">
                                        <label class="col-sm-3 control-label" style="">Ticket No : </label>
                                        <div class="col-sm-3">
                                            <span class="mod-form-control"><% response.write sTicket_No %> </span>
                                        </div>
                                    </div>
									<%else%>
										<div class="form-group" visibility: hidden></div>
									<%end if%>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Reserve For : </label>
                                        <div class="col-sm-7">
											<span class="mod-form-control"><% response.write sReserveF %> </span>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Lot Quantity : </label>
                                        <div class="col-sm-7">
											<span class="mod-form-control"><% response.write sLot_Qty %> </span>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Vehicle No : </label>
                                        <div class="col-sm-3">
											<span class="mod-form-control"><% response.write sCar_No %> </span>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Employee No : </label>
                                        <div class="col-sm-6">
                                            <div class="input-group">
                                               <span class="mod-form-control"><% response.write sEmp_ID %> ( <% response.write sName %> )</span>
                                                <span class="input-group-btn">
                                                </span>
                                            </div>
                                        </div>
                                    </div>
									<!--From Date-->
									<div class="form-group">
                                        <label class="col-sm-3 control-label">From Date : </label>
                                        <div id="div_dt_join" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <span class="mod-form-control"><% response.write sDtFrDate %> | <% response.write sTimeIn %></span>
                                            </div>
                                        </div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label">To Date : </label>
                                        <div id="div_dt_join" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <span class="mod-form-control"><% response.write sDtToDate %> | <% response.write sTimeOut %></span>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Remark : </label>
                                        <div class="col-sm-7">
											<span class="mod-form-control"><% response.write sRemark %> </span>
                                        </div>
                                    </div>
									<div class="form-group">
										<% if sAPP <> "" then %>
											<label class="col-sm-3 control-label">Status : </label>
											<div class="col-sm-7">
												<span class="mod-form-control">Pending</span>
											</div>
										<% end if%>
                                    </div>
									<div class="form-group" visibility: hidden>
                                        <label class="col-sm-3 control-label" style="">Ticket No : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" name="txtTicket_No" value="<%=server.htmlencode(sTicket_No)%>" maxlength="10">
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
									<button type="submit" name="sub" value="rej" class="btn btn-danger pull-left" style="width: 90px">Reject</button>
									<button type="submit" name="sub" value="app" class="btn btn-success pull-right" style="width: 90px">Approve</button>
                                </div>
                                <!-- /.box-footer -->
							</div>
                                <!-- /.box -->
                        </form>
                    </div>
                </div>
				<div class="modal fade bd-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                            </div>
                            <div id="mycontent">
                                <!--- Content ---->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade in" id="modal-delcomp" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="exampleModalLabel"></h4>
                            </div>
                            <div class="modal-body">
                                <div id="del-content">
                                    <!--- Content ---->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->

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
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
	<!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
	<!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="plugins/colorpicker/bootstrap-colorpicker.min.js"></script>

	<script>
    $('#btndt_date').click(function () {
        $('#dtFrDate').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtToDate').datepicker("show");
    }); 
    
	$('#btndt_Joindate').click(function () {
        $('#dtJoinDate').datepicker("show");
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
	
	<script>
    $(function () {

        //Time mask
        $("[data-mask]").inputmask();
    
    });
    </script>

</body>
</html>
