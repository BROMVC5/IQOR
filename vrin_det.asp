<!DOCTYPE html>
<html>
<head>
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
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
    
    <%
    sNRIC = UCase(request("txtNRIC"))
	iAutoInc = request("txtAutoinc")
	sBadge_No = request("txtBadge_No")
	sPurpose = request("txtPurpose")
	sDept_ID = request("txtDept_ID")
	sEmpName = request("txtEmpName")
    
    if sNRIC <> "" then
       sIC = sNRIC
    else
       sIC = UCase(reqForm("txtNRIC"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "vrin.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage 
	
	if sModeSub = "check" then
		Set rstVRVend = server.CreateObject("ADODB.RecordSet")
		sSQL = "select * from vrvend where NRIC = '" & sIC & "'"
		rstVRVend.Open sSQL, conn, 3, 3
		if rstVRVend.eof then
			call alertbox("NRIC : " & sIC & " does not exist!")
			temp = 0
		else
			sIC = rstVRVend("NRIC")
			sName = rstVRVend("VNAME")
			sComp_Name = rstVRVend("COMPNAME")
			sDesign = rstVRVend("DESIG")
			sHP = rstVRVend("HP")
			sCar_No = rstVRVend("CAR_NO")
			sBl_List = rstVRVend("BLIST")
			sNat = rstVRVend("NAT")
			temp = 1
		end if
		if sBl_List = "Y" then
			temp = 1
			Call alertbox("NRIC : " & sIC & " is black-listed !")
		end if
        
		pCloseTables(rstVRVend)
		
    elseif sModeSub <> "" Then
        
		sName = reqForm("txtName")
		sComp_Name = reqForm("txtComp_Name")
		sDesign = reqForm("txtDesign")
		sHP = reqForm("txtHP")
		sCar_No = reqForm("txtCar_No")
		sBl_List = reqForm("sBl_List")
		sNat = reqForm("sNat")
		sEmpName = reqForm("txtEmpName")
		sDept_ID = reqForm("txtDept_ID")
		sPurpose = reqForm("txtPurpose")
		iAutoInc = request("txtAutoinc")
	
		if sIC = "" then
		    call alertbox("NRIC cannot be empty")
		end if
		
		if sIC <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from vrvend where NRIC ='" & sIC & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if BLIST = "Y" then
                call alertbox("NRIC : " & sIC & " is black-listed !")
				black_listed = rstVRVend(BLIST)
		    End if  
            pCloseTables(rstVRVend)
        end if
		
		if sEmpName = "" then
		    call alertbox("Employee Name cannot be empty")
		end if
		
		if sDept_ID = "" then
		    call alertbox("Department ID cannot be empty")
		end if
		
		if sPurpose = "" then
		    call alertbox("Purpose cannot be empty")
		end if
		
		if sBadge_No = "" then
		    call alertbox("Badge No cannot be empty")
		end if
		
		if sName = "" then
		    call alertbox("Must Check the user NRIC first!")
		end if
		
		if sComp_Name <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from vrcomp where COMPNAME ='" & sComp_Name & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Company Name : " & sComp_Name & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
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
				
        if sModeSub = "up" Then
            
			sSQL = "UPDATE vrtrns SET "             
			sSQL = sSQL & "APP_NAME = '" & pRTIN(sEmpName) & "',"
			sSQL = sSQL & "DEPT = '" & pRTIN(sDept_ID) & "',"
			sSQL = sSQL & "CAR_NO = '" & pRTIN(sCar_No) & "',"
			sSQL = sSQL & "BADGE_NO = '" & pRTIN(sBadge_No) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
			sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "',"
			sSQL = sSQL & "REASON = '" & pRTIN(sPurpose) & "'"
            sSQL = sSQL & "WHERE NRIC = '" & sIC & "'"
			sSQL = sSQL & " AND AUTOINC = '" & iAutoInc & "'"
            conn.execute sSQL
			
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtNRIC=" & sIC & "")

        elseif sModeSub = "save" Then
			
			sSQL = "insert into vrtrns (NRIC,REASON,CAR_NO,GD_IN,DT_IN,APP_NAME,DEPT,BADGE_NO,CREATE_ID,DT_CREATE) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sIC) & "',"		   
			sSQL = sSQL & "'" & pRTIN(sPurpose) & "',"
			sSQL = sSQL & "'" & pRTIN(sCar_No) & "',"
			sSQL = sSQL & "'" & session("USERNAME") & "',"
			sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
			sSQL = sSQL & "'" & pRTIN(sEmpName) & "',"
			sSQL = sSQL & "'" & pRTIN(sDept_ID) & "',"
			sSQL = sSQL & "'" & pRTIN(sBadge_No) & "',"
			sSQL = sSQL & "'" & session("USERNAME") & "',"
			sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
		    conn.execute sSQL
            
		    call confirmBox("Save Successful!", sMainURL&sAddURL&"&txtNRIC=" & sIC & "")    
		
         End If 
    End If
	
	if sModeSub <> "check" then
		Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select * from vrvend where NRIC ='" & sIC & "'" 
		rstVRVend.Open sSQL, conn, 3, 3
			if not rstVRVend.eof then
				sIC = rstVRVend("NRIC")
				sName = rstVRVend("VNAME")
				sComp_Name = rstVRVend("COMPNAME")
				sDesign = rstVRVend("DESIG")
				sCar_No = rstVRVend("CAR_NO")
				sHP = rstVRVend("HP")
				sBl_List = rstVRVend("BLIST")
				sNat = rstVRVend("NAT")
				
			end if
		pCloseTables(rstVRVend)
		
		Set rstVRTrns = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select * from vrtrns where NRIC ='" & sIC & "' and BADGE_NO = '" &sBadge_No& "'"
		rstVRTrns.Open sSQL, conn, 3, 3
			if not rstVRTrns.eof then
				sEmpName = rstVRTrns("APP_NAME")
				sDept_ID = rstVRTrns("DEPT")
				sPurpose = rstVRTrns("REASON")
				sBadge_No = rstVRTrns("BADGE_NO")
			end if
	end if
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left sICe column. contains the logo and sICebar -->
        <!-- #include file="include/sidebar_vr.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Vendor Check In Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="vrin_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
								<div class = "box-body">
									<h3 style="color:#3c8dbc;">Vendor/Visitor Profile</h3>
								</div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">NRIC : </label>
                                        <div class="col-sm-3">
                                            <%if sNRIC <> "" then %>
                                                <span class="mod-form-control"><% response.write sNRIC %> </span>
                                                <input type="hidden" id="txtNRIC" name="txtNRIC" value='<%=sIC%>' />
                                            <%else%>  
                                                <input class="form-control" id="txtNRIC" name="txtNRIC" value="<%=sIC%>" maxlength="15" style="text-transform: uppercase" />
                                            <% end if %>
                                        </div>
										<div class = "col-sm-3">
										<%if sIC<> "" then %>
											<button style="visibility:hidden"></button>
										<%else%>
											<button type="submit" name="sub" value="check" class="btn btn-info" style="width: 90px">Check</button>
										<%end if%>
										
										</div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Vendor Name : </label>
                                        <div class="col-sm-7">
											<span class="mod-form-control"><% response.write sName %> </span>
											<input type=hidden id="txtName" name="txtName" value='<%=sName%>' />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Company Name: </label>
                                        <div class="col-sm-4">
                                            <div class="input-group">
                                                <span class="mod-form-control"><% response.write sComp_Name %> </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Designation : </label>
                                        <div class="col-sm-7">
											<span class="mod-form-control"><% response.write sDesign %> </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Handphone : </label>
                                        <div class="col-sm-7">
											<span class="mod-form-control"><% response.write sHP %> </span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Vehicle No : </label>
                                        <div class="col-sm-3">
											<span class="mod-form-control"><% response.write sCar_No %> </span>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Nationality : </label>
                                        <div class="col-sm-3">
										<%if sNRIC <> "" then%>
											<%if sNat = "Y" then%>
												<span class="mod-form-control"><%response.write "Malaysian"%></span>
											<%else%>
												<span class="mod-form-control"><%response.write "Non-Malaysian"%></span>
											<%end if%>
										<%end if%>
                                        </div>
                                    </div>
									
									<hr style="border-top: dotted 1px #cecece;" />
									<div class = "box-body">
										<h3 style="color:#3c8dbc;">Appointment With</h3>
									</div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Name : </label>
                                        <div class="col-sm-7">
											<input class="form-control" id="txtEmpName" name="txtEmpName" value="<%=sEmpName%>" maxlength="50" />
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Department ID : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtDept_ID" name="txtDept_ID" value="<%=sDept_ID%>" maxlength="30" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('DEPT','txtDept_ID','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Purpose : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" name="txtPurpose" value="<%=sPurpose%>" maxlength="50">
                                        </div>
                                    </div>
									
									<hr style="border-top: dotted 1px #cecece;" />
									<div class = "box-body">
										<h3 style="color:#3c8dbc;">Vendor/Visitor Transaction</h3>
									</div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Badge No : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" name="txtBadge_No" value="<%=sBadge_No%>" maxlength="10">
                                        </div>
                                    </div>
									<div class="form-group" visibility: hidden>
                                        <label class="col-sm-3 control-label" style="">AutoInc : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" name="txtAutoinc" value="<%=server.htmlencode(iAutoInc)%>" maxlength="10">
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sBadge_No<> "" then %>
                                        <a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=server.htmlencode(iAutoInc)%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
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
		
  	    xhttp.open("GET", "vrin_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtNRIC').focus();
        }); 
    </script>
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

        if (pType=="COMP") { 
            var search = document.getElementById("txtSearch_comp");
        }else if (pType=="DEPT") {
			var search = document.getElementById("txtSearch_dept");
		}
	  	
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
		
		if (pType=="COMP") {
	  	    xhttp.open("GET", "ajax/ax_view_compid.asp?"+str, true);
	  	}else if (pType=="DEPT") {
			xhttp.open("GET", "ajax/ax_vrview_deptid.asp?"+str, true);
        }
  	    xhttp.send();
    }
	
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
