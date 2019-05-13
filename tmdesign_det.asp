﻿<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Designation Details</title>
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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css">
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
    <%
    sDesign_ID = request("txtDESIGN_ID")
    
    if sDesign_ID <> "" then
       sID = sDesign_ID
    else
       sID = reqFormU("txtID")
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "TMDESIGN.asp?"
	
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage &"&txtDESIGN_ID=" & sID
                
    if sModeSub <> "" Then
        
        sPart = reqForm("txtPart")
        
        if sModeSub = "up" Then
            
            sSQL = "UPDATE TMDESIGN SET "             
            sSQL = sSQL & "PART = '" & pRTIN(sPart) & "',"
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
            sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "'"
            sSQL = sSQL & " WHERE DESIGN_ID = '" & sID & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL)

        elseif sModeSub = "save" Then
            
            if sID = "" then
		        call alertbox("Position ID cannot be empty")
		    end if
	
            Set rstTMDESIGN = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMDESIGN where DESIGN_ID ='" & sID & "'" 
            rstTMDESIGN.Open sSQL, conn, 3, 3
            if not rstTMDESIGN.eof then
                call alertbox("Position ID  " & sID & " already exist !")
			End if  
            pCloseTables(rstTMDESIGN)
            
            sSQL = "insert into TMDESIGN (DESIGN_ID,PART,USER_ID,DATETIME) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
		    conn.execute sSQL
            
		    call confirmBox("Save Successful!", sMainURL&sAddURL)    

         End If 
    End If
          
    Set rstTMDESIGN = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMDESIGN where DESIGN_ID ='" & sID & "'" 
    rstTMDESIGN.Open sSQL, conn, 3, 3
        if not rstTMDESIGN.eof then
            sPart = rstTMDESIGN("PART")
        end if
    pCloseTables(rstTMDESIGN)
        
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_tm.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Designation Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmdesign_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Designation ID : </label>
                                        <div class="col-sm-7">
                                            <%if sDesign_ID <> "" then %>
                                                <span class="mod-form-control"><% response.write sDesign_ID%> </span>
                                                <input type="hidden" id="txtID" name="txtID" value='<%=sDesign_ID%>' />
                                            <%else%>  
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="30" style="text-transform: uppercase"/>
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" name="txtPart" value="<%=sPart%>" maxlength="30">
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sDesign_ID <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sDesign_ID%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                    <%else %>
                                        <button type="button" id="btnCheck" name="btnCheck" class="btn btn-primary pull-right"
                                            style="width: 90px" onclick="check('DESIGN');">Save</button>
                                        <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide"></button>
                                    <%end if %>
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
                        </form>
                    </div>
                </div>
                <div class="modal fade " id="mymodal-del" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <div id="mycontent-del">
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
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
   
    <script>
    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    $(document).ready(function(){
        document.getElementById('txtID').focus();
     }); 
        
    function fDel(str, pContent,pModal) {
        showDelmodal(str, pContent)
		$(pModal).modal('show');
	}
    
    function showDelmodal(str,pContent){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "tmdesign_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }
    
    function check(pWhat){
        
        if($('#txtID').val() == ''){
            alert('Designation ID cannot be empty');
            }else{
                
                var url_to	= 'ajax/ax_exist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    data    : { "txtWhat" : pWhat,
                                "txtID":$("#txtID").val(),
                              }, 
             
                    success : function(res){
                 
                        if(res.data.status == "exist"){
                            return alert(res.data.value);
                        }else if (res.data.status == "OK") {
                            $('#btnSave').click();    
                        }
                    },
                    error	: function(error){
                        console.log(error);
                    }
                });
            }
    }
    
    $('#txtID').keyup(function (e) {
    var allowedChars = /^[a-z\d -]+$/i;
    var str = String.fromCharCode(e.charCode || e.which);

    var forbiddenChars = /[^a-z\d -]/gi;
    
    if (forbiddenChars.test(this.value)) {
        this.value = this.value.replace(forbiddenChars, '');
    }

    if (allowedChars.test(str)) {
        return true;
    }

    e.preventDefault();
    return false;
    })
    </script>



</body>
</html>
