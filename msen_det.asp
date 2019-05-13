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
    
	<style>
	textarea {
		resize: none;
	}
	</style>
	
    <%
    sEn_Name = UCase(request("txtEn_Name"))
	iAutoInc = request("txtAutoInc")
    
    if sEn_Name <> "" then
       sEn_Name = sEn_Name
    else
       sEn_Name = UCase(reqForm("txtEn_Name"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "msen.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage & "&Type=" & "EN"
	
	if sModeSub <> "" Then
        
		sEn_Name = reqForm("txtEn_Name")
		sGrade_ID = reqForm("txtGrade_ID")
		sMaxC = reqForm("txtMaxC")
		sStatus = reqForm("sStatus")
		sRemark = reqForm("txtRemark")
		'sDesign = reqForm("txtDesig")
		sMType = reqForm("txtMType")
		
		if sEn_Name = "" then
		    call alertbox("Entitlement Type cannot be empty")
		end if
		
		if sEn_Name <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from msentype where ENTITLEMENT ='" & sEn_Name & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Entitlement Type : " & sEn_Name & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
        end if
		
		if sGrade_ID = "" then
		    call alertbox("Grade Code cannot be empty")
		end if
		
		if sMaxC = "" then
		    call alertbox("Max Claim cannot be empty")
		end if
				
		if sGrade_ID <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tmgrade where GRADE_ID ='" & sGrade_ID & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Grade Code : " & sGrade_ID & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
        end if
		
		if sDesign <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tmdesign where DESIGN_ID ='" & sDesign & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Designation : " & sDesign & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
        end if
				
        if sModeSub = "up" Then
            
			Set rstMSEn = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from msen where ENTITLEMENT ='" & sEn_Name & "'" 
			sSQL = sSQL & " and GRADE_ID = '" & sGrade_ID & "' "
			sSQL = sSQL & " and DESIG = '" & sMType & "'"
			sSQL = sSQL & " and AUTOINC <> '" & iAutoInc & "'"
            rstMSEn.Open sSQL, conn, 3, 3
            if rstMSEn.eof then
				sSQL = "UPDATE msen SET "             
				sSQL = sSQL & "MAXC = '" & pFormat(sMaxC,2) & "',"
				sSQL = sSQL & "GRADE_ID = '" & pRTIN(sGrade_ID) & "',"
				sSQL = sSQL & "STATUS = '" & pRTIN(sStatus) & "',"
				sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
				'sSQL = sSQL & "DESIG = '" & pRTIN(sDesign) & "',"
				sSQL = sSQL & "DESIG = '" & pRTIN(sMType) & "',"
				sSQL = sSQL & "REMARK = '" & pRTIN(sRemark) & "',"
				sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
				sSQL = sSQL & "WHERE AUTOINC = '" & iAutoInc & "'"
				conn.execute sSQL
			else
				call alertbox("Entitlement Type : " & sEn_Name & " with Grade Code : " & sGrade_ID & " exist !")
			end if
        
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtEn_Name=" & sEn_Name & "")

        elseif sModeSub = "save" Then
            
			Set rstMSEn = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from msen where ENTITLEMENT ='" & sEn_Name & "'" 
			sSQL = sSQL & " and GRADE_ID = '" & sGrade_ID & "' "
			' if sMType = "" then
			sSQL = sSQL & " and DESIG = '" & sMType & "'"
			' end if
            rstMSEn.Open sSQL, conn, 3, 3
            if rstMSEn.eof then
				sSQL = "insert into msen (ENTITLEMENT, MAXC, GRADE_ID ,DESIG ,STATUS, REMARK, DT_CREATE,CREATE_ID) "
				sSQL = sSQL & "values ("
				sSQL = sSQL & "'" & UCASE(pRTIN(sEn_Name)) & "',"		
				sSQL = sSQL & "'" & pFormat(sMaxC,2) & "',"	
				sSQL = sSQL & "'" & sGrade_ID & "'," 
				'sSQL = sSQL & "'" & sDesign & "'," 
				sSQL = sSQL & "'" & sMType & "'," 
				sSQL = sSQL & "'" & sStatus & "'," 
				sSQL = sSQL & "'" & sRemark & "'," 
				sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
				sSQL = sSQL & "'" & session("USERNAME") & "'" 
				sSQL = sSQL & ") "
				conn.execute sSQL
			else
				call alertbox("Entitlement Type : " & sEn_Name & " with Grade Code : " & sGrade_ID & " exist !")
			end if
			pCloseTables(rstMSEn)
			
			call confirmBox("Save Successful", sMainURL&sAddURL&"&txtEn_Name=" & sEn_Name & "")
         End If 
    End If
          
    Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from msen where AUTOINC ='" & iAutoInc & "'" 
    rstVRVend.Open sSQL, conn, 3, 3
        if not rstVRVend.eof then
            sEn_Name = rstVRVend("ENTITLEMENT")
			sMaxC = rstVRVend("MAXC")
			sGrade_ID = rstVRVend("GRADE_ID")
			'sDesign = rstVRVend("DESIG")
			sMType = rstVRVend("DESIG")
			sStatus = rstVRVend("STATUS")
			sRemark = rstVRVend("REMARK")
        end if
    pCloseTables(rstVRVend)
        
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
	
        <!-- #include file="include/header.asp" -->
        <!-- Left sICe column. contains the logo and sICebar -->
        <!-- #include file="include/sidebar_ms.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Entitlement Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="msen_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Entitlement Type : </label>
                                        <div class="col-sm-5">
                                            <div class="input-group">
												<%if sEn_Name <> "" then%>
													<span class="mod-form-control"><% response.write Ucase(sEn_Name) %> </span>
													<input type="hidden" id="txtEn_Name" name="txtEn_Name" value='<%=sEn_Name%>' />
												<%else%>
                                                <input class="form-control" id="txtEn_Name" name="txtEn_Name" value="<%=sEn_Name%>" maxlength="50" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('EN','txtEn_Name','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
												<%end if%>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Grade Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtGrade_ID" name="txtGrade_ID" value="<%=sGrade_ID%>" maxlength="50" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('GRADE','txtGrade_ID','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
									<!--<div class="form-group">
                                        <label class="col-sm-3 control-label">Manager Type : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtMType" name="txtMType" value="<%=sMType%>" maxlength="50" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('DES','txtDesig','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>-->
									<div class="form-group">
										<label class="col-sm-3 control-label">Manager Type : </label>
										<div class="col-sm-3">
											<select id="txtMType" name="txtMType" class="form-control">
												<option value="" selected="selected" <%if sMType = "" then%>Selected<%end if%>>Empty</option>
												<option value="M" <%if sMType = "M" then%>Selected<%end if%>>Manager</option>
												<option value="FM" <%if sMType = "FM" then%>Selected<%end if%>>Functional Manager</option>
											</select>
										</div>
									</div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Max Claim : </label>
                                        <div class="col-sm-3">
											<input class="form-control" style="text-align:right;" id="txtMaxC" name="txtMaxC" value="<%=pFormatDec(sMaxC,2)%>" maxlength="15"/>
                                        </div>
                                    </div>
                                
									<div class="form-group">
										<label class="col-sm-3 control-label">Status : </label>
										<div class="col-sm-3">
											<select name="sStatus" class="form-control">
												<option value="Y" selected="selected" <%if sStatus = "Y" then%>Selected<%end if%>>Active</option>
												<option value="N" <%if sStatus = "N" then%>Selected<%end if%>>Inactive</option>

											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label">Remark : </label>
										<div class="col-sm-5">
											<textarea rows="4" cols="60" id="txtRemark" name="txtRemark" maxlength="50"><%=sRemark%></textarea>
										</div>
									</div>
									<div class="form-group" visibility: hidden>
											<label class="col-sm-3 control-label" style="">Autoinc : </label>
											<div class="col-sm-3">
												<input class="form-control" name="txtAutoInc" value="<%=server.htmlencode(iAutoInc)%>" maxlength="10">
											</div>
										</div>
									<div class="box-footer">
										<%if sEn_Name<> "" then %>
											<a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=server.htmlencode(iAutoInc)%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
											<button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
										<%else %>
											<button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
										<%end if %>
									</div>
                                <!-- /.box-footer -->
								</div>
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

  	    xhttp.open("GET", "msen_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtEn_Name').focus();
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

        if (pType=="EN") { 
            var search = document.getElementById("txtSearch_en");
        }else if (pType=="DES") { 
            var search = document.getElementById("txtSearch_desig");
		}else if (pType=="GRADE") { 
            var search = document.getElementById("txtSearch_grade");
		}
	  	
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
			
			str = str + "&fldName=" + pFldName;
			
		if (pType=="EN") {
	  	    xhttp.open("GET", "ajax/ax_msview_enid.asp?"+str, true);
	  	}else if (pType=="DES") {
	  	    xhttp.open("GET", "ajax/ax_msview_tmdesign.asp?"+str, true);
		}else if (pType=="GRADE") {
	  	    xhttp.open("GET", "ajax/ax_msview_gradeid.asp?"+str, true);
		}
        
	  	
  	    xhttp.send();
    }

    </script>
	<script>
	$(document).ready(function() {
		$("#txtMaxC").keydown(function (e) {
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
	
	$('#txtMaxC').keyup(function () {
		if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
       this.value = this.value.replace(/[^0-9\.]/g, '');
		}
	});
	
	$( "#txtEn_Name" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=ET",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEn_Name").val(ui.item.value);
				var str = document.getElementById("txtEn_Name").value;
				var res = str.split(" | ");
				document.getElementById("txtEn_Name").value = res[0];
			},0);
		}
	});	
	
	$( "#txtGrade_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=GC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtGrade_ID").val(ui.item.value);
				var str = document.getElementById("txtGrade_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtGrade_ID").value = res[0];
			},0);
		}
	});	
	
	$( "#txtDesig" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DS",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDesig").val(ui.item.value);
				var str = document.getElementById("txtDesig").value;
				var res = str.split(" | ");
				document.getElementById("txtDesig").value = res[0];
			},0);
		}
	});	
	</script>

</body>
</html>
