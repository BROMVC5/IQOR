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
    <title>iQOR | Shift Schedule</title>
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
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css" />
    
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


</head>
<%
    sMonth = Month(Date)
    sYear = Year(Date)

    sID = request("txtEMP_CODE")
    sdt_Shift = request("txtdt_Shift")
    sBegMonth = request("txtMonth")
    sBegYear = request("txtYear")
     
    if sID <> "" then
        sMonth = Cint(sBegMonth)
        sYear = Cint(sBegYear)
        
        Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMEMPLY where EMP_CODE='" & sID & "'" 
        rstTMEMPLY.Open sSQL, conn, 3, 3
        if not rstTMEMPLY.eof then
            sNAME = rstTMEMPLY("NAME")
        end if
        pCloseTables(rstTMEMPLY)
    %>
    <script>
        $(document).ready(function(){
            document.getElementById('txtID').focus();
            $("#searchresult").show();
            showContent();
        });

    </script>
    <%end if%>
<body class="hold-transition skin-blue sidebar-collapse sidebar-mini">
    <div class="wrapper">

        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_tm.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Shift Schedule </h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="box">
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <form name="form1" class="form-horizontal" action="tmshiftot.asp" method="POST">
                                   <div class="form-group">
                                        <label class="col-sm-2 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform:uppercase" placeholder='PLEASE SELECT'>
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
                                        <label class="col-sm-2 control-label">Start From : </label>
                                        <div class="col-sm-1" style="width:120px">
                                            <div class="input-group">
                                                <select name="selMonth" id="selMonth" class="form-control">
                                                    <%For j = 1 to 12 %>                                                         
                                                        <option value="<%=j%>" <%if sMonth = j then%>Selected<%end if%>><%=MonthName(j,true)%></option>
                                                    <%Next%>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                <select name="selYear" id="selYear" class="form-control">
                                                    <%For i = 1 to 34 
                                                        selyear = Cint(2016) + Cint(i)
                                                    %>
                                                        <option value="<%=selyear%>" <%if sYear = selyear then%>Selected<%end if%>><%=selyear%></option>
                                                    <%Next%>
                                                    
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-sm-2">
                                            <button type="submit" id="btnShow" name="btnShow" class="btn btn-default"
                                                onclick="showContent();return false;" style="width: 90px">
                                                Show</button>
                                        </div>
                                    </div>
                                </form>
                                <div id="searchresult">
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
                <div class="modal fade" id="modal-shiftotentry">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">Shift Maintenance Entry</h4>
                            </div>
                            <div class="modal-body">
                                <div id="shiftotentry"></div>
                            </div>
                        </div>
                    <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
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
    $(document).ready(function(){
        document.getElementById('txtID').focus();
        });
   
    $(function () {
        $("#btnShow").click(function () {
            $("#searchresult").show();
        });
    });

    </script>
    
    <script>

    function showContent() {

        var xhttp;

  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("searchresult").innerHTML = xhttp.responseText;
    	    }
  	    };
  	
  	    str = "txtEMP_CODE=" + document.getElementById("txtID").value;
  	    str = str + "&txtMonth=" + document.getElementById("selMonth").value 
  	    str = str + "&txtYear=" + document.getElementById("selYear").value 
  	    xhttp.open("GET", "ajax/ax_tmshiftot.asp?"+str, true);
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
    </script>
</body>
</html>
