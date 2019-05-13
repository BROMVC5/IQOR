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
    <title>iQOR | Holiday Date Details</title>
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
    sDT_HOL= request("txtdt_hol")
    
    if sDT_HOL <> "" then
       dt_hol = sDt_hol
    else
       dt_hol = reqForm("DT_HOL")
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "tmholiday.asp?"
	sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage & "&txtDT_HOL=" & dt_hol
                
    if sModeSub <> "" Then
        
        sRepla = reqForm("selRepla")
        sPart = reqForm("txtPart")
        
        if sModeSub = "up" Then
            
            sSQL = "UPDATE TMHOL SET "             
            sSQL = sSQL & "REPLA = '" & sRepla & "',"
            sSQL = sSQL & "PART = '" & pRTIN(sPart) & "'"
            sSQL = sSQL & " WHERE DT_HOL = '" & fdate2(dt_hol) & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL)

        elseif sModeSub = "save" Then
            
            sSQL = "insert into TMHOL (DT_HOL,REPLA,PART,USER_ID,DATETIME) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & fdate2(dt_hol) & "',"
            sSQL = sSQL & "'" & sRepla & "',"
            sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
            conn.execute sSQL
            call confirmBox("Save Successful!", sMainURL&sAddURL)    

         End If 
    End If
          
    Set rstTMHOL = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMHOL where DT_HOL = '" & fdate2(dt_hol) & "'" 
    rstTMHOL.Open sSQL, conn, 3, 3
    if not rstTMHOL.eof then
       sRepla = rstTMHOL("REPLA")
       sPart = rstTMHOL("PART")
    end if
    pCloseTables(rstTMHOL)
        
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
                <h1>Holiday Date Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmholiday_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <input type="hidden" name="txtDT_HOL" value='<%=sDt_Hol%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Holiday Date : </label>
                                        <div id="div_dt_hol" class="col-sm-5 col-lg-3">
                                            <%if sdt_hol <> "" then %>
                                            <span class="mod-form-control"><% response.write fdatelong(dt_hol)%> </span>
                                            <%else%>
                                            <div class="input-group">
                                                <input id="dt_hol" name="dt_hol" type="text" class="form-control">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndt_hol" class="btn btn-default" style="margin-left:0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_hol" class="help-block"></span>
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Replacement Holiday : </label>
                                        <div class="col-sm-2">
                                            <select name="selRepla" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="Y" <%if sRepla = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sRepla = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" id="txtPart" name="txtPart" value="<%=sPart%>" maxlength="50">
                                        </div>
                                    </div>
                                </div>

                                <div class="box-footer">
                                    <%if sdt_hol <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sDT_HOL%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkEmpty();">Update</button>
                                        <button type="submit" id="btnUp" name="sub" value="up" class="btnSaveHide"></button>
                                    <%else %>
                                        <button type="button" id="btnCheck" name="btnCheck" class="btn btn-primary pull-right"
                                            style="width: 90px" onclick="check('HOL');">
                                            Save</button>
                                        <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide">
                                            </button>
                                    <%end if %>
                                </div>
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
    <script src="plugins/input-mask/jquery.mask.js"></script>

    <script>
    $(function () {
        //Date picker
        $("#dt_hol").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            }).datepicker("setDate", new Date());

    });

    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });


    $(document).ready(function(){
      $('#dt_hol').mask('00/00/0000');
    });

    $('#btndt_hol').click(function () {
        $('#dt_hol').datepicker("show");
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

  	    xhttp.open("GET", "tmholiday_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    function check(pWhat){
        
        if($('#dt_hol').val() == ''){
            alert('Holiday Date cannot be empty');
            return false;
        }
        
        //Special case here that check for the description if empty
        if($('#txtPart').val() == ''){
            alert('Please key in the Description');
            return false;
        }
        
        var url_to	= 'ajax/ax_exist.asp';  
            
        $.ajax({
            url     :   url_to,
            type    :   'POST',
            data    :   { 
                            "txtWhat" : pWhat,
                            "txtID":$("#dt_hol").val(),
                        }, 
            success :   function(res){
                 
                            if(res.data.status == "exist"){
                                $('#btnSave').click();
                            }else if (res.data.status == "OK") {
                            
                                var input = document.getElementById("dt_hol").value;
                                var pattern =/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/;

                                if (pattern.test(input)==false){
	                                alert("Holiday Date format is incorrect, please key in DD/MM/YYYY");
                                    document.getElementById('div_dt_hol').className += ' has-error'
                                    document.getElementById("errdt_hol").innerHTML = "Please key in DD/MM/YYYY" 
                                    return false;
                                }else{
                                            $('#btnSave').click();    
                                }   
                            }
                        },

            error	:   function(error){
                           console.log(error);
                        }
        });
    }

    function checkEmpty(){
        
        if($('#txtPart').val() == ''){
            alert('Please key in the Description');
            return false;
        }else{
            $('#btnUp').click();    
        }
    }
    </script>

</body>
</html>
