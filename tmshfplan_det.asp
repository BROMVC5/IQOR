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
    <title>iQOR | Shift Plan Details</title>
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

    <style>
        .block {
            float: left;
            width: 10px;
            height: 30px;
            margin: 2px;
            border: 1px solid rgba(0, 0, 0, .2);
        }
    </style>
    <%  
        sSearch = request("txtSearch")
        iPage = request("Page")
        sSHFPLAN_ID = request("txtSHFPLAN_ID")
        sPart = request("txtPart")
        sSHFPAT_ID = request("txtSHFPAT_ID")
        sRow = request("txtRow")
        sCol = request("txtCol")
        bEdit = request("Edit")
    
        sMainURL = "tmshfplan.asp?"
	
        sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage
        
    if sSHFPLAN_ID <> "" or bEdit <> "" then

        Set rstTMShfPlan = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select DISTINCT * from TMSHFPLAN where SHFPLAN_ID ='" & sSHFPLAN_ID & "'" 
        rstTMShfPlan.Open sSQL, conn, 3, 3
            if not rstTMShfPlan.eof then
                sPart = rstTMShfPlan("PART")
                sShfPat_ID = rstTMShfPlan("ShfPat_ID")
                sRow = rstTMShfPlan("ROW")
                sCol = rstTMShfPlan("COL")
            end if
        pCloseTables(rstTMShfPlan)      
        
    %>
        <script>
            $(function () {
                showContent()
        });
        </script>
    
    <%End if %>

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
                <h1>Shift Plan</h1>
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
                                <form name="form1" class="form-horizontal" action="tmshfplan_det.asp" method="POST">
                                    <input type="hidden" name="Page" value='<%=iPage%>' />
                                    <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                                    <input type="hidden" id="bEdit" value='<%=bEdit%>' />
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Shift Plan : </label>
                                        <div class="col-sm-7">
                                            <%if bEdit <> "" then%>
                                                <span class="mod-form-control"><% response.write sSHFPLAN_ID%> </span>
                                                <input type="hidden" id="txtID" value="<%=sSHFPLAN_ID%>" />
                                            <%else%>
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sSHFPLAN_ID%>" maxlength="30" style="text-transform: uppercase" />
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <%if bEdit <> "" then%>
                                            <span class="mod-form-control"><% response.write sPart%> </span>
                                            <input type="hidden" id="txtPart" value="<%=sPart%>" />
                                            <%else%>
                                            <input class="form-control" id="txtPart" name="txtPart" value="<%=sPart%>" maxlength="30">
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Shift Pattern : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <%if bEdit <> "" then %>
                                                <span class="mod-form-control"><% response.write sShfPat_ID %></span>
                                                <input type="hidden" id="txtShfPat_ID" value="<%=sShfPat_ID%>" />
                                                <%else%>
                                                <input class="form-control" id="txtShfPat_ID" name="txtShfPat_ID" value="<%=sShfPat_ID%>" maxlength="30">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('SHFPAT','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                                <%end if%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Row : </label>
                                        <div class="col-sm-2">
                                            <%if bEdit <> "" then%>
                                            <span class="mod-form-control"><% response.write sRow%> </span>
                                            <input type="hidden" id="txtRow" value="<%=sRow%>" />
                                            <%else%>
                                                <input class="form-control" type="text"  style="text-align:right;" id="txtRow" name="txtRow" maxlength="2" value="<%=sRow%>" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" onblur="checkRow();return false;"/>
                                            <%end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Column : </label>
                                        <div class="col-sm-2">
                                            <%if bEdit <> "" then%>
                                            <span class="mod-form-control"><% response.write sCol%> </span>
                                            <input type="hidden" id="selCol" value="<%=sCol%>" />
                                            <%else%>
                                            <select id="selCol" name="selCol" class="form-control" onchange="checkRow();return false;">
                                                <option value="" selected>-- Select --</option>
                                                <option value="1" <%if sCol = "1" then%>Selected<%end if%>>1</option>
                                                <option value="2" <%if sCol = "2" then%>Selected<%end if%>>2</option>
                                                <option value="3" <%if sCol = "3" then%>Selected<%end if%>>3</option>
                                                <option value="4" <%if sCol = "4" then%>Selected<%end if%>>4</option>
                                                <option value="5" <%if sCol = "5" then%>Selected<%end if%>>5</option>
                                                <option value="6" <%if sCol = "6" then%>Selected<%end if%>>6</option>
                                            </select>
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Days per column : </label>
                                        <div class="col-sm-2">
                                            <span class="mod-form-control">7</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Repeat Cycle : </label>
                                        <div class="col-sm-2">
                                            <div id="repeatcyc" class="mod-form-control"></div>
                                        </div>
                                    </div>
                                </form>
                                <div id="content2">
                                    <!-- CONTENT HERE -->
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
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
                <div class="modal fade in" id="modal-delshfplan" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
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

    function checkRow() {

        if ($('#txtID').val() == ''){
            alert("Please enter Shift Plan name.")
        }else if($('#txtShfPat_ID').val() == ''){
            alert("Please select Shift Pattern.")
        }else if($('#txtRow').val() == ''){
            alert("Please enter number of Row.")
        }else if($('#selCol').val() == '') {
            return false;
        }else{
            showContent();
        }
    }

    function showContent() {
  	    var xhttp;

  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("content2").innerHTML = xhttp.responseText;
    	    
            }
  	    };
  	
        str = "txtSHFPLAN_ID=" + document.getElementById("txtID").value;
  	    str = str + "&txtPart=" + document.getElementById("txtPart").value;
  	    str = str + "&txtRow=" +  document.getElementById("txtRow").value;
        str = str + "&txtCol=" +  document.getElementById("selCol").value;
        str = str + "&txtSHFPAT_ID=" + document.getElementById("txtShfPat_ID").value;
  	    str = str + "&Edit=" + document.getElementById("bEdit").value;
  	    xhttp.open("GET", "ajax/ax_tmshfplan_det.asp?"+str, true);
  	    xhttp.send();

        var text1 = parseInt(document.getElementById("selCol").value);
        document.getElementById("repeatcyc").innerHTML = text1 * 7 + " Days" ;
    }

    </script>
    <script>
        $('#modal-delshfplan').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var shfplan_id = button.data('shfplan_id')
        var modal = $(this)
        modal.find('.modal-body input').val(shfplan_id)
        showDelmodal(shfplan_id)
    })

    function showDelmodal(str){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("del-content").innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "tmshfplan_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }
    </script>
    <script>

    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }
    
    function showDetails(str,pType,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

        if (pType=="SHFPAT") { 
            var search = document.getElementById("txtSearch_shfpat");
        } 
	  	        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="SHFPAT") {
	  	    xhttp.open("GET", "ajax/ax_view_tmshfpatid.asp?"+str, true);
	  	} 
	  	
  	    xhttp.send();
    }
    
    function calrepeatcyc() {
      var text1 = document.getElementById("selcol").value;
      document.getElementById("repeatcyc").innerHTML = text1 + " " + text2;
    }

    $(document).ready(function(){
        document.getElementById('txtID').focus();
     });
        
    function calTotHours(dropdown,sRow,sCol) {
       
        var pattern = dropdown.options[dropdown.selectedIndex].value;
        var shfpattern = document.getElementById("txtShfPat_ID").value;
        
        var colvalue1 = $("#selShfPat" + sRow + "_3").val();
        var colvalue2 = $("#selShfPat" + sRow + "_4").val();
        var colvalue3 = $("#selShfPat" + sRow + "_5").val();
        var colvalue4 = $("#selShfPat" + sRow + "_6").val();
        var colvalue5 = $("#selShfPat" + sRow + "_7").val();
        var colvalue6 = $("#selShfPat" + sRow + "_8").val();

        var url_to  = 'ajax/ax_tmshfplan_caltothrs.asp';

        $.ajax({
                 url		: url_to,
                 type	    : 'POST',
                 data       :  
                            {   "txtShfPat_ID": shfpattern,
                                "txtColValue1": colvalue1,
                                "txtColValue2": colvalue2,
                                "txtColValue3": colvalue3,
                                "txtColValue4": colvalue4,
                                "txtColValue5": colvalue5,
                                "txtColValue6": colvalue6,
                            },

                 success	:   function(res){
                                console.log(res);
                                if(res.data.status == "ok"){
                                document.getElementById("txtTotHours"+sRow).innerHTML = res.data.value;
                                document.getElementById("txtTotHours"+sRow).value = res.data.value;
                                }
                 
                            },
                 error	    :   function(error){
                                console.log(error);
                            }
             });

    }
	
	$( "#txtShfPat_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=SP",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtShfPat_ID").val(ui.item.value);
				var str = document.getElementById("txtShfPat_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtShfPat_ID").value = res[0];
			},0);
		}
	});
    </script>

</body>
</html>
