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
    <title>iQOR | Change Workgroup and Generate Schedule</title>
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
    
    <%

    Set rstTMPASS = server.CreateObject("ADODB.RecordSet")
	sql = "select * from TMPASS where ID = '" & session("USERNAME") & "' "
	sql = sql & " and TMPC = 'Y' and TMPC3 = 'Y'" 
    rstTMPASS.Open sql, conn, 3, 3
	if rstTMPASS.eof then
        response.redirect("login.asp")
	end if

    sEMP_CODE = UCase(request("txtEMP_CODE"))
    sWorkGrp_ID = UCase(request("txtWorkGrp_ID"))
    sSup_CODE = UCase(request("txtSUP_CODE"))
    %>
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
                <h1>Change Work Group and Generate Schedule </h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="box">
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <form name="form1" class="form-horizontal" action="tmchgwrkgrp.asp" method="POST">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Work Group : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtWorkGrp_ID" name="txtWorkGrp_ID" value="<%=sWorkGrp_ID%>" style="text-transform: uppercase" placeholder="All">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('WORKGRP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtID" name="txtID" maxlength="10" style="text-transform: uppercase" placeholder="All">
                                                <span class="input-group-btn">
                                                    <a href="#" name="btnSearchID" class="btn btn-default"
                                                        onclick = "fOpen('EMP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <input class="form-control" id="txtNAME" name="txtNAME" READONLY>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Superior : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtSUP_CODE" name="txtSUP_CODE" maxlength="10" style="text-transform: uppercase" placeholder="ALL" >
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default" 
                                                        onclick ="fOpen('SUP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="col-sm-5">
                                            <input class="form-control" id="txtSUP_NAME" name="txtSUP_NAME" READONLY>
                                        </div>

                                        <div class="col-sm-2">
                                            <button type="button" id="btnShow" name="btnShow" class="btn btn-default"
                                                onclick="showContent('page=1');return false;" style="width: 90px">
                                                Show</button>
                                        </div>

                                    </div>
                                    
                                </form>
                                <div id="content2">
                                    <!-- CONTENT HERE -->
                                </div>
                            </div>
                            <!-- /.box-body -->
                        </div>
                        <!-- /.box-->
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
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->
    <script>
 
    $(document).ready(function(){
        document.getElementById('txtWorkGrp_ID').focus();
        showContent('page=<%=iPage%>', 'EMP_CODE','Asc');
    });
    
    function clearSup_Name(){
        if (document.getElementById("txtSUP_CODE").value == ""){
            document.getElementById("Sup_Name").innerHTML = ""; 
        }
    }

    function showContent(str, orderBy, ascDesc) {
  	    var xhttp;

        if (str.length == 0) { 
    	document.getElementById("content2").innerHTML = "";
    	return;
  	    }

  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("content2").innerHTML = xhttp.responseText;
    	    }
  	    };

        var sWorkGrp_ID =  document.getElementById("txtWorkGrp_ID").value;
        var sSup_CODE = document.getElementById("txtSUP_CODE").value;
        var sEmp_Code = document.getElementById("txtID").value;

  	    str = str + "&sOrderBy=" + orderBy
        str = str + "&sAscDesc=" + ascDesc

        if(sWorkGrp_ID !=""){
            str = str + "&txtWorkGrp_ID=" + sWorkGrp_ID;
  	    }
        if(sSup_CODE != ""){
            str = str + "&txtSUP_CODE=" + sSup_CODE
        }
        if(sEmp_Code != ""){
  	        str = str + "&txtEmp_Code=" + sEmp_Code
        }

        xhttp.open("GET", "ajax/ax_tmchgwrkgrp.asp?"+str, true);
  	    xhttp.send();
        
    }

    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }

    function getValue2(svalue, pFldName, svalue2, pFldName2) {
        document.getElementById(pFldName).value = svalue;
        document.getElementById(pFldName2).innerHTML = svalue2;
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

        if (pType=="WORKGRP") {
            var search = document.getElementById("txtSearch_workgrp");
        } else if (pType=="EMP") { 
            var search = document.getElementById("txtSearch");
        } else if (pType=="SUP") {
            var search = document.getElementById("txtSearch_sup");
        } 	  	
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="WORKGRP") {
            xhttp.open("GET", "ajax/ax_view_tmworkgrpid.asp?"+str, true);

        }else if (pType=="EMP") {

            str2 = "&txtWorkGrp_ID=" + document.getElementById("txtWorkGrp_ID").value;
  	        str2 = str2 + "&txtSUP_CODE=" + document.getElementById("txtSUP_CODE").value;
  	    
            xhttp.open("GET", "ajax/ax_view_tmempidwgc.asp?"+str+str2, true);

	  	} else if (pType=="SUP") {
            str2 = "&txtWorkGrp_ID=" + document.getElementById("txtWorkGrp_ID").value;
  	    
	  	    xhttp.open("GET", "ajax/ax_view_tmsupid.asp?"+str+str2, true);

        }
	  	
  	    xhttp.send();
    }
	
	$( "#txtWorkGrp_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=WG",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtWorkGrp_ID").val(ui.item.value);
				var str = document.getElementById("txtWorkGrp_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtWorkGrp_ID").value = res[0];
			},0);
		}
	});
	
	$( "#txtID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=SUBORD",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtID").val(ui.item.value);
				var str = document.getElementById("txtID").value;
				var res = str.split(" | ");
				document.getElementById("txtID").value = res[0];
                document.getElementById("txtNAME").value = res[1];
			},0);
		}
	})
	

    //=== Any changes except ENTER will clear the NAME field====
    $('#txtID').on('keyup',  function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode != 13 ) {
            $('#txtNAME').val('');
        }
    });
	
	$( "#txtSUP_CODE" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=SUPERIOR",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtSUP_CODE").val(ui.item.value);
				var str = document.getElementById("txtSUP_CODE").value;
				var res = str.split(" | ");
				document.getElementById("txtSUP_CODE").value = res[0];
                document.getElementById("txtSUP_NAME").value= res[1];
            },0);
		}
	});

    //=== Any changes except ENTER will clear the NAME field====
    $('#txtSUP_CODE').on('keyup',  function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode != 13 ) {
            $('#txtSUP_NAME').val('');
        }
    });
    </script>

</body>
</html>
