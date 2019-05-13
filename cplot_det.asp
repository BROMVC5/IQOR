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
    sLot_ID = UCase(request("txtLot_ID"))
    
    if sLot_ID <> "" then
       sLID = sLot_ID
    else
       sLID = UCase(reqForm("txtLot_ID"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "rclot.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage 
                
    if sModeSub <> "" Then
        
		sPart = reqForm("txtPart")
        
		if sLID = "" then
		    call alertbox("Lot ID cannot be empty")
		end if
				
        if sModeSub = "up" Then
            
            sSQL = "UPDATE rclot SET "
			sSQL = sSQL & "PART = '" & pRTIN(sPart) & "',"			
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
            sSQL = sSQL & "WHERE LOT_ID = '" & sLID & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtLot_ID=" & sLID & "")

        elseif sModeSub = "save" Then
            
            sSQL = "insert into rclot (LOT_ID,PART,DT_CREATE,CREATE_ID) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sLID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sPart) & "',"
			sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "'" & session("USERNAME") & "'" 
		    sSQL = sSQL & ") "
		    conn.execute sSQL
            
		    call confirmBox("Save Successful!", sMainURL&sAddURL&"&txtLot_ID=" & sLID & "")    

         End If 
    End If
          
    Set rstRCLot = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from rclot where LOT_ID ='" & sLID & "'" 
    rstRCLot.Open sSQL, conn, 3, 3
        if not rstRCLot.eof then
            sLID = rstRCLot("LOT_ID")
			sPart = rstRCLot("PART")
        end if
    pCloseTables(rstRCLot)
        
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_rc.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Company Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="rclot_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Lot No : </label>
                                        <div class="col-sm-3">
                                            <%if sLot_ID <> "" then %>
                                                <span class="mod-form-control"><% response.write sLot_ID %> </span>
                                                <input type="hidden" id="txtLot_ID" name="txtLot_ID" value='<%=sLID%>' />
                                            <%else%>  
                                                <input class="form-control" id="txtLot_ID" name="txtLot_ID" value="<%=sLID%>" maxlength="8" style="text-transform: uppercase" />
                                            <% end if %>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <%if sPart <> "" then %>
                                                <input class="form-control" id="txtPart" name="txtPart" value='<%=sPart%>' maxlength="50"/>
                                            <%else%>  
												<input class="form-control" id="txtPart" name="txtPart" value="<%=sPart%>" maxlength="50"/>
                                            <% end if %>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sLID <> "" then %>
                                        <a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=server.htmlencode(sLID)%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
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

  	    xhttp.open("GET", "rclot_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtLot_ID').focus();
        }); 
    </script>

</body>
</html>
