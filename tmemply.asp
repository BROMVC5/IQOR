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
    <title>iQOR | Employee Information</title>
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
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
	<!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />

<%
    sSearch = request("txtSearch")
    iPage = request("page") 
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
                <h1>Employee Information </h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="box">
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <form name="form1" action="tmemply.asp" method="POST">
                                    <div class="row">
                                         <div class="col-sm-5">
                                            <input type="button" class="btn btn-new" value="New" onclick="go('tmemply_det.asp');" />
                                            <button type="button" name="sub" value="print" class="btn bg-green-active " style="width: 100px" onclick="exportReport()">Export Excel</button>
                                        </div>
                                        <div class="col-sm-3 pull-right">
                                            <div class="input-group">
                                                <input class="form-control" id="txtSearch" name="txtSearch" value="<%=sSearch%>" placeholder="Search" maxlength="100" type="text" />
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default" type="submit" name="search" value="Search" onclick="showContent('page=1');return false;"><i class="fa fa-search"></i>
                                                    </button>
                                                </span>
                                            </div>
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
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
    
<script>

    $(document).ready(function(){
        document.getElementById('txtSearch').focus();
        showContent('page=<%=iPage%>', 'EMP_CODE','Asc');
    });

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
  	
  	    str = str + "&sOrderBy=" + orderBy
        str = str + "&sAscDesc=" + ascDesc
        str = str + "&txtSearch=" + document.getElementById("txtSearch").value;
  	
  	    xhttp.open("GET", "ajax/ax_tmemply.asp?"+str, true);
  	    xhttp.send();
    }

    function goTo(str) {
	    var sURL;
	
	    sURL = "page=" + document.getElementById("txtPage").value;
	    sURL = sURL + "&txtSearch=" + document.getElementById("txtSearch").value
	
  	    window.location=(str + sURL);
    }

    function go(str) {
          window.location=(str);
    }

    function exportReport() {
        
            sURL = "txtSearch=" + document.getElementById("txtSearch").value;
        
            window.open("tmexcel_emply.asp?" + sURL);
	}

    $( "#txtSearch" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtSearch").val(ui.item.value);
				var str = document.getElementById("txtSearch").value;
				var res = str.split(" | ");
				document.getElementById("txtSearch").value = res[0];
                //document.getElementById("txtSUP_NAME").value= res[1];
            },0);
		}
	});

</script>

</body>
</html>
