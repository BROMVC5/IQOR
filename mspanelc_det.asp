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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" />
    
    <%
    sPanelCode = UCase(request("txtPanelCode"))
    
    if sPanelCode <> "" then
       sPanelCode = sPanelCode
    else
       sPanelCode = UCase(reqForm("txtPanelCode"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "mspanelc.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage & "&Type=" & "PC"
	
	if sModeSub <> "" Then
        
		sPanelCode = reqForm("txtPanelCode")
		sPanelName = reqForm("txtPanelName")
		sAdd = reqForm("txtAdd")
		sAdd2 = reqForm("txtAdd2")
		sAdd3 = reqForm("txtAdd3")
		sAdd4 = reqForm("txtAdd4")
		sTel = reqForm("txtTel")
		sStatus = reqForm("sStatus")
		
		if sPanelCode = "" then
		    call alertbox("Panel Clinic Code cannot be empty")
		end if
		
		if sPanelName = "" then
		    call alertbox("Panel Clinic Name cannot be empty")
		end if
				
        if sModeSub = "up" Then
            
            sSQL = "UPDATE mspanelc SET "      
			sSQL = sSQL & "PANELNAME = '" & pRTIN(sPanelName) & "',"
			sSQL = sSQL & "ADD1 = '" & pRTIN(sAdd) & "',"
			sSQL = sSQL & "ADD2 = '" & pRTIN(sAdd2) & "',"
			sSQL = sSQL & "ADD3 = '" & pRTIN(sAdd3) & "',"
			sSQL = sSQL & "ADD4 = '" & pRTIN(sAdd4) & "',"
			sSQL = sSQL & "TEL = '" & pRTIN(sTel) & "',"
			sSQL = sSQL & "STATUS = '" & pRTIN(sStatus) & "',"
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
            sSQL = sSQL & "WHERE PANELCODE = '" & sPanelCode & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtPanelC=" & sPanelCode & "")

        elseif sModeSub = "save" Then
            
			Set rstEnType = server.CreateObject("ADODB.RecordSet")    
			sSQL = "select * from mspanelc where PANELCODE ='" & sPanelCode & "'" 
			rstEnType.Open sSQL, conn, 3, 3
				if not rstEnType.eof then
					call confirmBox("Panel Clinic Existed!", sMainURL&sAddURL&"&txtEn_Name=" & sEn_Name & "")  
				else
					sSQL = "insert into mspanelc (PANELCODE, PANELNAME, ADD1 ,ADD2, ADD3, ADD4, TEL, STATUS, DT_CREATE, CREATE_ID) "
					sSQL = sSQL & "values ("
					sSQL = sSQL & "'" & pRTIN(sPanelCode) & "',"	
					sSQL = sSQL & "'" & pRTIN(sPanelName) & "',"	
					sSQL = sSQL & "'" & pRTIN(sAdd) & "'," 
					sSQL = sSQL & "'" & pRTIN(sAdd2) & "'," 			
					sSQL = sSQL & "'" & pRTIN(sAdd3) & "'," 
					sSQL = sSQL & "'" & pRTIN(sAdd4) & "'," 
					sSQL = sSQL & "'" & pRTIN(sTel) & "'," 
					sSQL = sSQL & "'" & pRTIN(sStatus) & "',"
					sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
					sSQL = sSQL & "'" & session("USERNAME") & "'" 
					sSQL = sSQL & ") "
					conn.execute sSQL
				end if
			
			call confirmBox("Save Successful", sMainURL&sAddURL&"&txtPanelC=" & sPanelCode & "")
         End If 
    End If
          
    Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from mspanelc where PANELCODE ='" & sPanelCode & "'" 
    rstVRVend.Open sSQL, conn, 3, 3
        if not rstVRVend.eof then
            sPanelCode = rstVRVend("PANELCODE")
			sPanelName = rstVRVend("PANELNAME")
			sAdd = rstVRVend("ADD1")
			sAdd2 = rstVRVend("ADD2")
			sAdd3 = rstVRVend("ADD3")
			sAdd4 = rstVRVend("ADD4")
			sTel = rstVRVend("TEL")
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
                <h1>Panel Clinic Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="mspanelc_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
									<div class="form-group">
										<label class="col-sm-3 control-label">Panel Clinic Code : </label>
										<div class="col-sm-3">
											<%if sPanelCode <> "" then%>
												<span class="mod-form-control"><% response.write sPanelCode %> </span>
												<input type="hidden" id="txtPanelCode" name="txtPanelCode" value='<%=sPanelCode%>' />
											<%else%>
												<input class="form-control" id="txtPanelCode" name="txtPanelCode" value="<%=sPanelCode%>" maxlength="10"/>
											<%end if%>
										</div>
									</div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Panel Clinic Name : </label>
                                        <div class="col-sm-5">
											<input class="form-control" id="txtPanelName" name="txtPanelName" value="<%=sPanelName%>" maxlength="50"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Address : </label>
                                        <div class="col-sm-5">
											<input class="form-control" id="txtAdd" name="txtAdd" value="<%=sAdd%>" maxlength="40"/>
                                        </div>
                                    </div>
									<div class="form-group">
										<label class="col-sm-3 control-label"></label>
										<div class="col-sm-5">
											<input class="form-control" id="txtAdd2" name="txtAdd2" value="<%=sAdd2%>" maxlength="40"/>
										</div>
                                    </div>
									<div class="form-group">
										<label class="col-sm-3 control-label"></label>
										<div class="col-sm-5">
											<input class="form-control" id="txtAdd3" name="txtAdd3" value="<%=sAdd3%>" maxlength="40"/>
										</div>
                                    </div>
									<div class="form-group">
										<label class="col-sm-3 control-label"></label>
										<div class="col-sm-5">
											<input class="form-control" id="txtAdd4" name="txtAdd4" value="<%=sAdd4%>" maxlength="40"/>
										</div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Contact No : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtTel" name="txtTel" value="<%=sTel%>" maxlength="15"/>
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
                                </div>
                                <div class="box-footer">
                                    <%if sPanelCode<> "" then %>
                                        <a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=server.htmlencode(sPanelCode)%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
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

  	    xhttp.open("GET", "mspanelc_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtPanelCode').focus();
        }); 
    </script>

</body>
</html>
