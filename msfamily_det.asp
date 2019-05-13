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
	<!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
    <%
    sEmp_ID = UCase(request("txtEmp_ID"))
	iAutoInc = request("txtAutoInc")
    
    if sEmp_ID <> "" then
       sEmp_ID = sEmp_ID
    else
       sEmp_ID = UCase(reqForm("txtEmp_ID"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "msfamily.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage & "&Type=" & "FM"
	
	if sModeSub <> "" Then
		iAutoInc = reqForm("txtAutoInc")
		sEmp_No = reqForm("txtEmp_ID")
		sEmpName = reqForm("txtEmp_Name")
		sName = reqForm("txtName")
		sRelation = reqForm("sRelation")
		sStatus = reqForm("sStatus")
		dtResign = reqForm("dt_Resign")
		
		if sEmp_ID = "" then
		    call alertbox("Employee No cannot be empty")
		end if
		
		if sEmpName = "" then
		    call alertbox("Employee No cannot be empty")
		end if
		
		if sName = "" then
		    call alertbox("Name cannot be empty")
		end if
		
		if sEmp_ID <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tmemply where EMP_CODE ='" & sEmp_ID & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Employee No : " & sEmp_ID & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
        end if	
				
        if sModeSub = "up" Then
            
            sSQL = "UPDATE msfamily SET "             
			sSQL = sSQL & "NAME = '" & pRTIN(sName) & "',"
			sSQL = sSQL & "RELATION = '" & pRTIN(sRelation) & "',"
			sSQL = sSQL & "STATUS = '" & pRTIN(sStatus) & "',"
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
            sSQL = sSQL & "WHERE AUTOINC = '" & iAutoInc & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtEmp_ID=" & sEmp_ID & "")

        elseif sModeSub = "save" Then
            
			sSQL = "insert into msfamily (EMP_CODE, EMP_NAME, NAME, RELATION, DT_RESIGN ,STATUS, DT_CREATE, CREATE_ID) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sEmp_ID) & "',"		
			sSQL = sSQL & "'" & pRTIN(sEmpName)& "',"	
			sSQL = sSQL & "'" & pRTIN(sName) & "'," 			
			sSQL = sSQL & "'" & pRTIN(sRelation) & "'," 
			if dtResign <> "" then
                sSQL = sSQL & "'" & fdate2(dtResign) & "',"
            else
               sSQL = sSQL & " null,"
            end if
			sSQL = sSQL & "'" & pRTIN(sStatus) & "',"
			sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "'" & session("USERNAME") & "'" 
		    sSQL = sSQL & ") "
		    conn.execute sSQL
			
			call confirmBox("Save Successful", sMainURL&sAddURL&"&txtEmp_ID=" & sEmp_ID & "")
         End If 
    End If
          
    Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from msfamily where AUTOINC ='" & iAutoInc & "'" 
    rstVRVend.Open sSQL, conn, 3, 3
        if not rstVRVend.eof then
            sEmp_ID = rstVRVend("EMP_CODE")
			sEmpName = rstVRVend("EMP_NAME")
			sName = rstVRVend("NAME")
			sRelation = rstVRVend("RELATION")
			dtResign = rstVRVend("DT_RESIGN")
			sStatus = rstVRVend("STATUS")
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
                <h1>Family Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="msfamily_det.asp" method="post">
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
												<span class="mod-form-control" ><% response.write sEmpName %> </span>
												<input type="hidden" id="txtEmp_Name" name="txtEmp_Name" value='<%=sEmpName%>' />
											<%else%>
												<input class="form-control" id="txtEmp_Name" name="txtEmp_Name" value="<%=sEmpName%>" maxlength="50"/ READONLY>
											<%end if%>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Resignation Date : </label>
                                        <div class="col-sm-3">
												<%if sEmp_ID <> "" then%>
													<span class="mod-form-control"><% response.write dtResign %> </span>
													<input type="hidden" id="dt_Resign" name="dt_Resign" value='<%=dtResign%>' />
												<%else%>
                                                <input class="form-control" id="dt_Resign" name="dt_Resign" value="<%=dtResign%>" type="text" READONLY>
												<%end if%>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Name : </label>
                                        <div class="col-sm-5">
											<input class="form-control" id="txtName" name="txtName" value="<%=sName%>" maxlength="50"/>
                                        </div>
                                    </div>
									<div class="form-group">
										<label class="col-sm-3 control-label">Relationship : </label>
										<div class="col-sm-3">
											<select name="sRelation" class="form-control">
												<option value="S" selected="selected" <%if sRelation = "S" then%>Selected<%end if%>>Spouse</option>
												<option value="C" <%if sRelation = "C" then%>Selected<%end if%>>Child</option>
											</select>
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
									<div class="form-group" hidden>
                                        <label class="col-sm-3 control-label">Autoinc : </label>
                                        <div class="col-sm-5">
											<input class="form-control" id="txtAutoInc" name="txtAutoInc" value="<%=iAutoInc%>" maxlength="10"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sEmp_ID<> "" then %>
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
	<!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
	
	<!--date picker-->
    <script>
    
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

  	    xhttp.open("GET", "msfamily_del.asp?txtstring="+str, true);
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
        }
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
			
			str = str + "&fldName=" + pFldName;
			
		if (pType=="EMP") {
	  	    xhttp.open("GET", "ajax/ax_view_empid2.asp?"+str, true);
	  	}
	  	
  	    xhttp.send();
    }
	
	$( "#txtEmp_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC2",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEmp_ID").val(ui.item.value);
				$("#dt_Resign").val(ui.item.data);
				var str = document.getElementById("txtEmp_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtEmp_ID").value = res[0];
				document.getElementById("txtEmp_Name").value = res[1];
			},0);
		}
	});	
    </script>

</body>
</html>
