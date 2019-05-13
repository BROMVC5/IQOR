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
    <title>iQOR | Log</title>
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
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
	

<%
    'sEMP_CODE= request("txtEMP_CODE")
    iPage = request("Page")
    dtpFrDate = request("dtpFrDate")
    dtpToDate = request("dtpToDate")
    'sTOff_ID = request("txtTOff_ID")
    
    'if sEMP_CODE <> "" then
    '    sID = sEMP_CODE 
    'else
    '    sID = reqForm("txtID")
    'end if

    'Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
    'sSQL = "select name from TMEMPLY where EMP_CODE='" & sID & "'" 
    'rstTMEMPLY.Open sSQL, conn, 3, 3
    'if not rstTMEMPLY.eof then
    '    sName = rstTMEMPLY("NAME")
    'end if
 
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
                <h1>Log</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row"><!-- /.row-->
                    <div class="col-md-12"> <!-- /.col-md-12-->
                        <div class="box"> <!-- /.box -->
                            <div class="box-body "> <!-- /.box-body --> 
                                <form name="form1" class="form-horizontal" action="tmlog.asp" method="POST">
                                    <input type="hidden" name="Page" value='<%=iPage%>' />
                                    <input type="hidden" id="txtOrderBy" value=""/>
                                    <input type="hidden" id="txtAscDesc" value="" />
                                    <div class="form-group">
                                        <div class="col-sm-3" style="width:21%">
                                            <div class="pull-left">
                                                <button type="button" name="sub" value="print" class="btn bg-green-active " style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
                                            </div>
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
                                        <label class="col-sm-3 control-label">Status : </label>
                                        <div class="col-sm-3">
                                            <select id="selStatus" name="selStatus" class="form-control">
                                                <option value="">All</option>
                                                <option value="Success">Success</option>
                                                <option value="Fail">Fail</option>
                                                <option value="Error">Error</option>
                                            </select>
                                        </div>

                                        <div class="col-sm-1">
                                            <button type="button" id="btnShow" name="btnShow" class="btn btn-default"
                                               onclick="showContent('page=1','DATETIME','Asc');return false;" style="width: 90px">
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
    $(document).ready(function(){
        showContent('page=<%=iPage%>', 'DATETIME','Desc');
    });

    function showContent(str, sOrderBy, sAscDesc) {
  	    var xhttp;
        document.getElementById("txtOrderBy").value = sOrderBy; 
        document.getElementById("txtAscDesc").value = sAscDesc;
  	    
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

        var selStatus = document.getElementById("selStatus").value;
  	
  	    //str = str + "&txtEMP_CODE=" + document.getElementById("txtID").value;
  	    str = str + "&txtOrderBy=" + sOrderBy
        str = str + "&txtAscDesc=" + sAscDesc
        str = str + "&dtpFrDate=" + document.getElementById("dtpFrDate").value;
  	    str = str + "&dtpToDate=" + document.getElementById("dtpToDate").value;
        str = str + "&selStatus=" + document.getElementById("selStatus").value;
        
  	    xhttp.open("GET", "ajax/ax_tmlog.asp?"+str, true);
  	    xhttp.send();
    }

 
    function exportReport() {
        
        var str = "";

        //str = str + "txtEMP_CODE=" + document.getElementById("txtID").value;
        str = str + "dtpFrDate=" + document.getElementById("dtpFrDate").value;
  	    str = str + "&dtpToDate=" + document.getElementById("dtpToDate").value;
        str = str + "&selStatus=" + document.getElementById("selStatus").value;
        str = str + "&txtOrderBy=" + document.getElementById("txtOrderBy").value;
        str = str + "&txtAscDesc=" + document.getElementById("txtAscDesc").value;

        window.open("tmexcel_log.asp?" + str);
	}

    
    $("#dtpFrDate,#dtpToDate").datepicker({changeMonth: true,
        changeYear: true,
        orientation: "auto",
        format: "dd/mm/yyyy",
        });

    $('#btndtpFrDate').click(function () {
        $('#dtpFrDate').datepicker("show");
    });

    $('#btndtpToDate').click(function () {
        $('#dtpToDate').datepicker("show");
    });

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
        } 
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="SUBORD") {
	  	    xhttp.open("GET", "ajax/ax_view_tmsubord.asp?"+str, true);

        } 
	  	
  	    xhttp.send();
    }
        
    $( "#txtID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
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

    </script>

</body>
</html>
