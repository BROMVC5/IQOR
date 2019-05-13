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
    <title>iQOR | Employee Time Off</title>
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
    sEMP_CODE= request("txtEMP_CODE")
    iPage = request("Page")
    dtpFrDate = request("dtpFrDate")
    dtpToDate = request("dtpToDate")
    sTOff_ID = request("txtTOff_ID")
    
    if sEMP_CODE <> "" then
        sID = sEMP_CODE 
    else
        sID = reqForm("txtID")
    end if

    Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select name from TMEMPLY where EMP_CODE='" & sID & "'" 
    rstTMEMPLY.Open sSQL, conn, 3, 3
    if not rstTMEMPLY.eof then
        sName = rstTMEMPLY("NAME")
    end if

    Set rstTMTimeOff = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMTIMEOFF where TOFF_ID ='" & sTOff_ID & "'" 
    rstTMTimeOff.Open sSQL, conn, 3, 3
    if not rstTMTimeOff.eof then
        sPart = rstTMTimeOff("PART")
    end if 
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
                <h1>Employee Time Off</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row"><!-- /.row-->
                    <div class="col-md-12"> <!-- /.col-md-12-->
                        <div class="box"> <!-- /.box -->
                            <div class="box-body "> <!-- /.box-body --> 
                                <form name="form1" class="form-horizontal" action="tmeoff.asp" method="POST">
                                    <input type="hidden" name="Page" value='<%=iPage%>' />
                                    <div class="form-group">
                                        <div class="col-sm-12" >
                                            <div class="pull-left">
                                                <input type="button" class="btn btn-new" value="New" onclick="go('tmeoff_det.asp');" />
                                                <button type="button" name="sub" value="print" class="btn bg-green-active " style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform:uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('SUBORD','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="col-sm-4">
                                            <input class="form-control" id="txtNAME" name="txtNAME" value="<%=sName%>" READONLY>
                                        </div>
                                        
                                    </div>
                                   
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">From Date : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpFrDate" name="dtpFrDate" type="text" value='<%=fdatelong(dtpFrDate)%>' class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpFrDate" class="btn btn-default">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <label class="col-sm-2 col-lg-2 control-label" style="width:100px">To Date : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpToDate" name="dtpToDate" type="text" value='<%=fdatelong(dtpToDate)%>' class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpToDate" class="btn btn-default">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Time Off Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtTOff_ID" name="txtTOff_ID" maxlength="10" value="<%=sTOff_ID%>" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('TOFF','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <input class="form-control" id="txtTOffPart" name="txtTOffPart" maxlength="30" value="<%=sPart%>" / READONLY>
                                        </div>

                                        <div class="col-sm-1">
                                            <button type="submit" id="btnShow" name="btnShow" class="btn btn-default"
                                                style="width: 90px">
                                                Show</button>
                                        </div>
                                    </div>
                                </form>
                                <div id="content2">
                                    <!-- CONTENT HERE -->
                                </div>
                            </div><!-- /.box-body -->
                        </div><!-- /.box-->
                    </div><!-- /.col-xs-12-->
                </div><!-- /.row -->
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
             </section><!-- /.content -->
        </div> <!-- /.content-wrapper -->
        
        <!-- #include file="include/footer.asp" -->

    </div><!-- ./wrapper -->
 
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
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

    
    <script>

    //====Date picker without today's date==========================
    $(document).ready(function(){ //====== When Page finish loading
        $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            orientation: "bottom",
            })

        $('[date-picker]').mask('00/00/0000');

        document.getElementById('txtID').focus();
        showContent('page=<%=iPage%>', 'tmeoff.EMP_CODE','Asc');
        
    });

    $('#btndtpFrDate').click(function () {
        $('#dtpFrDate').datepicker("show");
    });

    $('#btndtpToDate').click(function () {
        $('#dtpToDate').datepicker("show");
    });

    //============================================================
    
    function showContent(str, sOrderBy, sAscDesc) {
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
  	
  	    str = str + "&txtEMP_CODE=" + document.getElementById("txtID").value;
  	    str = str + "&txtOrderBy=" + sOrderBy
        str = str + "&txtAscDesc=" + sAscDesc
        str = str + "&dtpFrDate=" + document.getElementById("dtpFrDate").value;
  	    str = str + "&dtpToDate=" + document.getElementById("dtpToDate").value;
        str = str + "&txtTOff_ID=" + document.getElementById("txtTOff_ID").value;

  	    xhttp.open("GET", "ajax/ax_tmeoff.asp?"+str, true);
  	    xhttp.send();
    }

    function go(str) {
          window.location=(str);
        }

    function exportReport(sOrderBy,sAscDesc) {
        
        
        var str = "txtEMP_CODE=" + document.getElementById("txtID").value;
  	    str = str + "&txtOrderBy=" + sOrderBy
        str = str + "&txtAscDesc=" + sAscDesc
        str = str + "&dtpFrDate=" + document.getElementById("dtpFrDate").value;
  	    str = str + "&dtpToDate=" + document.getElementById("dtpToDate").value;
        str = str + "&txtTOff_ID=" + document.getElementById("txtTOff_ID").value;
        
        window.open("tmexcel_eoff.asp?" + str);
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
		document.getElementById(pFldName2).value = svalue2;
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

        if (pType=="SUBORD") { 
            var search = document.getElementById("txtSearch_subord");
        } else if (pType=="TOFF") {
            var search = document.getElementById("txtSearch_toff");
        }
	  	        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="SUBORD") {
	  	    xhttp.open("GET", "ajax/ax_view_tmsubord.asp?"+str, true);

        } else if (pType=="TOFF") {
            xhttp.open("GET", "ajax/ax_view_tmtimeoff.asp?"+str, true);
        }
	  	
  	    xhttp.send();
    }
       
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
	});

    //=== Any changes except ENTER will clear the NAME field====
    $('#txtID').on('keyup',  function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode != 13 ) {
            $('#txtNAME').val('');
        }
    });

    $( "#txtTOff_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=TO",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtTOff_ID").val(ui.item.value);
				var str = document.getElementById("txtTOff_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtTOff_ID").value = res[0];
				document.getElementById("txtTOffPart").value = res[1];
			},0);
		}
	});

    //=== Any changes except ENTER will clear the NAME field====
    $('#txtTOff_ID').on('keyup',  function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode != 13 ) {
            $('#txtTOffPart').val('');
        }
    });
	
    //===To clear the txtSearch box on MODAL when close
    $('[data-dismiss=mymodal]').on('click', function (e) {
    var $t = $(this),
        target = $t[0].href || $t.data("target") || $t.parents('.modal') || [];
    
    $(target)
    .find("input,textarea,select")
       .val('')
       .end()
    .find("input[type=checkbox], input[type=radio]")
       .prop("checked", "")
       .end();
    })

    </script>

</body>
</html>
