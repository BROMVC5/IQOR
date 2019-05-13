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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
	<!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
    <%
    sEmp_ID = UCase(request("txtEmp_ID"))
    
    if sEmp_ID <> "" then
       sEmp_ID = sEmp_ID
    else
       sEmp_ID = UCase(reqForm("txtEmp_ID"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "cpentry.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage & "&Type=" & "CE"
	
	if sModeSub <> "" Then
        
		sEmp_ID = reqForm("txtEmp_ID")
		sEmpName = reqForm("txtEmp_Name")
		sDept_ID = reqForm("txtDept_ID")
		iExt = reqForm("txtExt")
		sTel = reqForm("txtTel")
		sCar_No = reqForm("txtCar_No")
		sCar_No2 = reqForm("txtCar_No2")
		sCar_No3 = reqForm("txtCar_No3")
		sModel = reqForm("txtModel")
		sColor = reqForm("txtColor")
        sLtsRef = reqForm("sLtsRef")
		
		
		if sEmp_ID = "" then
		    call alertbox("Employee Code cannot be empty")
		end if
		
		if sEmp_ID <> "" then
            Set rstCPVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tmemply where EMP_CODE ='" & pRTIN(sEmp_ID) & "'" 
            rstCPVend.Open sSQL, conn, 3, 3
            if rstCPVend.eof then
                call alertbox("Employee Code : " & sEmp_ID & " does not exist !")
		    End if  
            pCloseTables(rstCPVend)
        end if
		
		if sDept_ID = "" then
		    call alertbox("Department ID cannot be empty")
		end if
		
		if sDept_ID <> "" then
            Set rstTMDEPT = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMDEPT where DEPT_ID='" & sDept_ID & "'" 
            rstTMDEPT.Open sSQL, conn, 3, 3
            if rstTMDEPT.eof then
                call alertbox("Department ID : " & sDept_ID & " does not exist !")
		    End if  
            pCloseTables(rstTMDEPT)
        end if
		
		if sCar_No = "" then
		    call alertbox("Vehicle No cannot be empty")
		end if
		
				
        if sModeSub = "up" Then  
	
			sSQL = "UPDATE cpreg SET "             
			sSQL = sSQL & "EXT_NO = '" & pRTIN(iExt) & "',"
			sSQL = sSQL & "TEL = '" & pRTIN(sTel) & "',"
			sSQL = sSQL & "CAR_NO = '" & pRTIN(sCar_No) & "',"
			sSQL = sSQL & "CAR_NO2 = '" & pRTIN(sCar_No2) & "',"
			sSQL = sSQL & "CAR_NO3 = '" & pRTIN(sCar_No3) & "',"
			sSQL = sSQL & "MODEL = '" & pRTIN(sModel) & "',"
			sSQL = sSQL & "COLOR = '" & pRTIN(sColor) & "',"
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
            sSQL = sSQL & "WHERE SREF_NO = '" & pRTIN(sLtsRef) & "'"
			sSQL = sSQL & "AND EMP_CODE = '" & sEmp_ID & "'"
			call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtEmp_ID=" & sEmp_ID & "")
			conn.execute sSQL            

        elseif sModeSub = "save" Then
			Set rstRCReserve= server.CreateObject("ADODB.RecordSet")    
			sSQL = "select * from cpreg where EMP_CODE ='" & sEmp_ID & "'" 
			rstRCReserve.Open sSQL, conn, 3, 3
				if not rstRCReserve.eof then
					call confirmBox("Employee Code Existed!", sMainURL&sAddURL&"&txtEmp_ID=" & sEmp_ID & "")
				else
					sSQL = "insert into cpreg (EMP_CODE, DEPT_ID, EXT_NO, TEL, CAR_NO, CAR_NO2, CAR_NO3, MODEL, COLOR, DT_CREATE, CREATE_ID, SREF_NO) "
					sSQL = sSQL & "values ("
					sSQL = sSQL & "'" & pRTIN(sEmp_ID) & "',"			
					sSQL = sSQL & "'" & pRTIN(sDept_ID) & "'," 			
					sSQL = sSQL & "'" & pRTIN(iExt) & "',"
					sSQL = sSQL & "'" & pRTIN(sTel) & "',"
					sSQL = sSQL & "'" & pRTIN(sCar_No) & "',"
					sSQL = sSQL & "'" & pRTIN(sCar_No2) & "',"
					sSQL = sSQL & "'" & pRTIN(sCar_No3) & "',"
					sSQL = sSQL & "'" & pRTIN(sModel) & "',"
					sSQL = sSQL & "'" & pRTIN(sColor) & "',"
					sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
					sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & pRTIN(sLtsRef) & "'"
					sSQL = sSQL & ") "
					conn.execute sSQL

                    sSQL = "UPDATE cppath "
					sSQL = sSQL & "SET LTSREF="
                    sSQL = sSQL & "'" & pRTIN(sLtsRef) & "'"
					conn.execute sSQL
					call confirmBox("Save Successful", sMainURL&sAddURL&"&txtEmp_ID=" & sEmp_ID & "")
				end if
					pCloseTables(rstRCReserve) 
         End If 
    End If
          
    Set rstCPVend = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select CPREG.EMP_CODE, TMEMPLY.NAME, CPREG.DEPT_ID, CPREG.EXT_NO, CPREG.TEL, CPREG.CAR_NO, CPREG.CAR_NO2, CPREG.CAR_NO3, CPREG.MODEL, CPREG.COLOR, CPREG.SREF_No " 
	sSQL = sSQL & "from cpreg left join tmemply on cpreg.emp_code = tmemply.emp_code " 
	sSQL = sSQL & "where cpreg.EMP_CODE ='" & sEmp_ID & "'" 
    rstCPVend.Open sSQL, conn, 3, 3
        if not rstCPVend.eof then
            sEmp_ID = rstCPVend("EMP_CODE")
			sEmpName = rstCPVend("NAME")
			sDept_ID = rstCPVend("DEPT_ID")		
			iExt = rstCPVend("EXT_NO")
			sTel = rstCPVend("TEL")
			sCar_No = rstCPVend("CAR_NO")
			sCar_No2 = rstCPVend("CAR_NO2")
			sCar_No3 = rstCPVend("CAR_NO3")
			sModel = rstCPVend("MODEL")
			sColor = rstCPVend("COLOR")
            sLtsRef = rstCPVend("SREF_NO")
        else
       set rstCLDT = server.CreateObject("ADODB.RecordSet")
            sSQL = "select * "
            sSQL = sSQL & "from cppath"
        rstCLDT.Open sSQL,conn, 3, 3
            if not rstCLDT.eof then
                sLtsRef = pLastNumber(rstCLDT("LTSREF"), rstCLDT("SREFST"), rstCLDT("SREFRUN"))
            end if
        end if
    pCloseTables(rstCPVend)
        
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
                <h1>Car Registration Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="cpentry_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
												<%if sEmp_ID <> "" then%>
													<span class="mod-form-control"><% response.write sEmp_ID %> </span>
													<input type="hidden" id="txtEmp_ID" name="txtEmp_ID" value='<%=sEmp_ID%>' />
												<%else%>
                                                <input class="form-control" id="txtEmp_ID" name="txtEmp_ID" value="<%=sEmp_ID%>" maxlength="50" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('EMP','txtEmp_ID','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
												<%end if%>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Name : </label>
                                        <div class="col-sm-5">
											<%if sEmp_ID <> "" then%>
												<span class="mod-form-control"><% response.write sEmpName %> </span>
												<input type="hidden" id="txtEmp_Name" name="txtEmp_Name" value='<%=sEmpName%>' />
											<%else%>
												<input class="form-control" id="txtEmp_Name" name="txtEmp_Name" value="<%=sEmpName%>" maxlength="50"/ READONLY>
											<%end if%>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Department ID : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
												<%if sDept_ID <> "" then%>
													<span class="mod-form-control"><% response.write sDept_ID %> </span>
													<input type="hidden" id="txtDept_ID" name="txtDept_ID" value='<%=sDept_ID%>' />
												<%else%>
                                                <input class="form-control" id="txtDept_ID" name="txtDept_ID" value="<%=sDept_ID%>" maxlength="30" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('DEPT','txtDept_ID','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
												<%end if%>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Ext No : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtExt" name="txtExt" value="<%=iExt%>" maxlength="3"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">HP No : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtTel" name="txtTel" value="<%=sTel%>" maxlength="15"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Vehicle No1 : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtCar_No" name="txtCar_No" value="<%=sCar_No%>" maxlength="10"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Vehicle No2 : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtCar_No2" name="txtCar_No2" value="<%=sCar_No2%>" maxlength="10"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Vehicle No3 : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtCar_No3" name="txtCar_No3" value="<%=sCar_No3%>" maxlength="10"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Model : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtModel" name="txtModel" value="<%=sModel%>" maxlength="30"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Color : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtColor" name="txtColor" value="<%=sColor%>" maxlength="15"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Sticker Number : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" id="sLtsRef" name="sLtsRef" value="<%=sLtsRef%>" READONLY/>
                                        </div>
                                    </div>
                                </div>
								<div class="form-group" hidden>
                                        <label class="col-sm-3 control-label">Resignation Date : </label>
                                        <div id="div_dt_confirm" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_Resign" name="dt_Resign" value="<%=dtResign%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                <div class="box-footer">
                                    <%if sEmp_ID<> "" then %>
                                        <a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=server.htmlencode(sEmp_ID)%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
                                        <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                    <%else %>
                                        <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
                                    <%end if %>
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
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
	<!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>

	
	<!--date picker-->
    <script>
    $('#btndt_date').click(function () {
        $('#dt_Resign').datepicker("show");
    });
	
	$('#btndt_Cdate').click(function () {
        $('#dt_Claim').datepicker("show");
    });
	
	$('#btndt_Adate').click(function () {
        $('#dt_Attend').datepicker("show");
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
        $('#modal-delcomp').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var work_id = button.data('work_id')
        var modal = $(this)
        modal.find('.modal-body input').val(work_id)
        showDelmodal(work_id)
    })

    function showDelmodal(str){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("del-content").innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "cpentry_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtEmp_ID').focus();
        }); 
    </script>
	<script>
    function fOpen(pType,pFldName,pContent,pModal) {
		document.getElementById(pContent).innerHTML = ""
        showDetails('page=1',pFldName,pType,pContent)
		$(pModal).modal('show');
	}
	

	function getValue1(svalue, svalue2, svalue3, pFldName, pFldName2 , pFldName3) {
		document.getElementById(pFldName).value = svalue;
		document.getElementById(pFldName2).value = svalue2;
		document.getElementById(pFldName3).value = svalue3;
		$('#mymodal').modal('hide');
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

        if (pType=="EMP") { 
            var search = document.getElementById("txtSearch_emp");
        }else if (pType=="DEPT") {
			var search = document.getElementById("txtSearch_dept");
		}
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
			
			str = str + "&fldName=" + pFldName;
			
		if (pType=="EMP") {
	  	    xhttp.open("GET", "ajax/ax_view_empid2.asp?"+str, true);
	  	}else if (pType=="DEPT") {
			xhttp.open("GET", "ajax/ax_vrview_deptid.asp?"+str, true);
        }
	  	
  	    xhttp.send();
    }

    </script>
	<script>
	$(document).ready(function() {
		$("#txtExt").keydown(function (e) {
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
	
	$( "#txtEmp_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEmp_ID").val(ui.item.value);
				var str = document.getElementById("txtEmp_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtEmp_ID").value = res[0];
				document.getElementById("txtEmp_Name").value = res[1];
			},0);
		}
	});	
	
	$( "#txtDept_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DP",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDept_ID").val(ui.item.value);
				var str = document.getElementById("txtDept_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtDept_ID").value = res[0];
			},0);
		}
	});	
	</script>
	

</body>
</html>
