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
    <title>iQOR | Shift Pattern Details</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <style type="text/css">

        .btnSaveHide {
         display: none;
        }

    </style>
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
    <!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>


    <%
     sSHFPAT_ID= request("txtSHFPAT_ID")
     iPage = request("Page")
     sSearch = request("txtSearch")
     sPAT = request("txtPat")
     sPART = request("txtPart")
     bEorS = request("EorS")
        
     if sSHFPAT_ID <> "" then
        sID = sSHFPAT_ID
     else
        sID = reqFormU("txtID")
     end if       

    sMainURL = "tmshfpat.asp?"
	sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage     
   
    '===== During edit mode and also after Save, when passing the txtSHDPAT_ID over
  
    if sSHFPAT_ID <> "" or bEorS <> "" then 
      Set rstTMSHFPAT = server.CreateObject("ADODB.RecordSet")    
      sSQL = "select * from TMSHFPAT where SHFPAT_ID ='" & sSHFPAT_ID & "'" 
      sSQL = sSQL & " order by PATTERN desc"
      rstTMSHFPAT.Open sSQL, conn, 3, 3
        if not rstTMSHFPAT.eof then
            sPart = rstTMSHFPAT("PART")
            sPat = rstTMSHFPAT("PATTERN")
        end if
      pCloseTables(rstTMSHFPAT)

    %>
    <script>

    $(function () {
            
            $("#content2").show();
            showContent()
    });

    </script>
    <%else%>
    <script>
       $(document).ready(function(){
        document.getElementById('txtID').focus();
        });
      
       $(function () {
        $("#selPat").change(function () {
         if($('#txtID').val() == ''){
            alert('Shift Pattern Code cannot be empty');
            }else{
            $("#content2").show();
        }
        });
    });
    </script>
    <%end if%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">

        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_tm.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Shift Pattern Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <form id="form1" name="form1" class="form-horizontal" action="tmshfpat_det.asp" method="POST">
                                    <input type="hidden" name="Page" value='<%=iPage%>' />
                                    <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                                    <input type="hidden" id="txtEorS" value='<%=bEorS%>' />
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Shift Pattern : </label>
                                        <div class="col-sm-7">
                                            <%if bEorS <> "" then%> 
                                                <span class="mod-form-control"><% response.write sSHFPAT_ID%> </span>
                                                <input type="hidden" id="txtID" value="<%=sSHFPAT_ID%>" />
                                            <%else%>
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="30" style="text-transform: uppercase"/>
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <%if bEorS <> "" then%> 
                                                <span class="mod-form-control"><% response.write sPart%> </span>
                                                <input type="hidden" id="txtPart" value="<%=sPart%>"  />
                                            <%else%>
                                                <input class="form-control" id="txtPart" name="txtPart" value="<%=sPart%>" maxlength="30">
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Pattern (Row) : </label>
                                        <div class="col-sm-2">
                                            <%if bEorS <> "" then%> 
                                                <span class="mod-form-control"><% response.write sPat%> </span>
                                                <input type="hidden" id="selPat" value="<%=sPat%>"  />
                                            <%else%>
                                            <select id="selPat" name="selPat" class="form-control" onchange="showContent();return false;">
                                                <option value="" selected>-- Select --</option>
                                                <option value="1" <%if sPat = "1" then%>Selected<%end if%>>1</option>
                                                <option value="2" <%if sPat = "2" then%>Selected<%end if%>>2</option>
                                                <option value="3" <%if sPat = "3" then%>Selected<%end if%>>3</option>
                                                <option value="4" <%if sPat = "4" then%>Selected<%end if%>>4</option>
                                                <option value="5" <%if sPat = "5" then%>Selected<%end if%>>5</option>
                                                <option value="6" <%if sPat = "6" then%>Selected<%end if%>>6</option>
                                                <option value="7" <%if sPat = "7" then%>Selected<%end if%>>7</option>
                                                <option value="8" <%if sPat = "8" then%>Selected<%end if%>>8</option>
                                                <option value="9" <%if sPat = "9" then%>Selected<%end if%>>9</option>
                                                <option value="10" <%if sPat = "10" then%>Selected<%end if%>>10</option>
                                            </select>
                                            <% end if %>
                                        </div>
                                    </div>
                                    
                                </form>
                                <div id="content2" style="display: none">
                                    <!-- CONTENT HERE -->
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
                <div class="modal fade in" id="modal-delshfpat" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
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

    function showContent() {
  	    var xhttp;

  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("content2").innerHTML = xhttp.responseText;
    	    $("[data-mask]").inputmask();
		    }
  	    };
  	
  	    str = "txtSHFPAT_ID=" + document.getElementById("txtID").value;
  	    str = str + "&txtPat=" + document.getElementById("selPat").value;
  	    str = str + "&txtPart=" + document.getElementById("txtPart").value;
        str = str + "&EorS=" + document.getElementById("txtEorS").value
        xhttp.open("GET", "ajax/ax_tmshfpat_det.asp?"+str, true);
  	    xhttp.send();
    }

    </script>
    <script>
        $('#modal-delshfpat').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var shfpat_id = button.data('shfpat_id')
        var modal = $(this)
        modal.find('.modal-body input').val(shfpat_id)
        showDelmodal(shfpat_id)
    })

    function showDelmodal(str){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("del-content").innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "tmshfpat_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

        
    //========Check if everything is selected, check first then call btnSave Click ==========

    function checkempty(sParam) {
        var sBreak = "N"
        var i = 1
        
        do { 
                for ( m = 1; m <=7; m++) {
                    if($('#selPATCODE' + i + '_' + m).val() == ''){
                        alert('You did not select one of the Shift Code!')
                        var sBreak = "Y" 
                        break;
                    }
                }
            if(sBreak =="Y"){
                break;
            }
            i++;
           }while (i <= sParam)
        
        if (sBreak !="Y" ){
            $('#btnSave').click();
        }
    }
   //===========By Hans 20170925 ===================================
    </script>
</body>
</html>
