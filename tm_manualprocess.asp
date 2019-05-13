<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <!-- #include file="tm_process.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Import and Process</title>
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
    <link href="plugins/Custom/css/component.css" rel="stylesheet" />
    
    <style>
    .darkClass{
        background-color: white;
        filter:alpha(opacity=50); /* IE */
        opacity: 0.5; /* Safari, Opera */
        -moz-opacity:0.50; /* FireFox */
        z-index: 20;
        height: 100%;
        width: 100%;
        background-repeat:no-repeat;
        background-position:center;
        position:absolute;
        top: 0px;
        left: 0px;
    }

    #loader-wrapper {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 1000;
    }

    #loader {
        display: block;
        position: relative;
        left: 50%;
        top: 50%;
        width: 150px;
        height: 150px;
        margin: -75px 0 0 -75px;
        border: 3px solid transparent;
        border-top-color: #3498db;
        z-index: 1500;
        border-radius: 50%;
  
        -webkit-animation: spin 2s linear infinite;
        animation: spin 2s linear infinite;
    }

    #loader:before {
        content: "";
        position: absolute;
        top: 5px;
        left: 5px;
        right: 5px;
        bottom: 5px;
        border: 3px solid transparent;
        border-top-color: #e74c3c;
        border-radius: 50%;
        -webkit-animation: spin 3s linear infinite;
        animation: spin 3s linear infinite;
    }

    #loader:after {
        content: "";
        position: absolute;
        top: 15px;
        left: 15px;
        right: 15px;
        bottom: 15px;
        border: 3px solid transparent;
        border-top-color: #f9c922;
        border-radius: 50%;
     
        -webkit-animation: spin 1.5s linear infinite;
        animation: spin 1.5s linear infinite;
    }

    /* include this only once */
    @-webkit-keyframes spin {
        0%   {
            -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(0deg);  /* IE 9 */
            transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
        }
        100% {
            -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(360deg);  /* IE 9 */
            transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
        }
    }

    @keyframes spin {
        0%   {
            -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(0deg);  /* IE 9 */
            transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
        }
        100% {
            -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(360deg);  /* IE 9 */
            transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
        }
    }
    </style>


    <%
        Server.ScriptTimeout = 10000000
        
        if request("btnProcess") <> "" then

        set fs=Server.CreateObject("Scripting.FileSystemObject")
        set fo=fs.GetFolder(Server.MapPath(".") & "\database\attendanceData\")

        for each x in fo.files
          
            sFile = x.Name
            
            a = Split(sFile,".") '=== a = [Data20180224, txt]
            
            sFileInitName = Trim(Mid(a(0),1,4))
            
            if sFileInitName = "Data" Then '==== Only process those files initial is Data

                sDtProcess = Trim(Mid(a(0),5,8)) '==== Get the date out of the file
                sDtProcess = Mid(sDtProcess,7,2) & "/" & Mid(sDtProcess,5,2) & "/" & Mid(sDtProcess,1,4) 
                dtProcess = CDate(sDTProcess)

                sEmpCode = request("txtID")

                '===== 1. We will read the DataYYYYMMDD.txt file that was generated by EntryPass and insert into TMCLK1
                sSQL = " delete from tmclk1 where DT_WORK ='" & fdate2(sDtProcess) & "'"
                conn.execute sSQL
                
                call fInsertTMCLK1(sFile, sEmpCode)
        
                sReInsert = sReInsert & " Reinsert FileName: " & sFile & " Records Date: " & dtProcess & "\n" 

            End if '=== if sFileInitName = "Data" Then
        next 
        set fo=nothing
        set fs=nothing

        sTitle = " Reinsert attendance data from Entry Pass completed on " & Now() & "\n" 
        
        if sEmpCode <> "" then
            call confirmBox(sTitle & sReInsert & " Completed for Employee Code: " & sEmpCode , "tm_manualprocess.asp")
        else
            call confirmBox(sTitle & sReInsert & " Completed for ALL Employee! " , "tm_manualprocess.asp")    
        end if

        sLog = sTitle & sReInsert
        sLog = Replace(sLog, "\n", " ")
        
        '=============Insert into TMLOG =====================
        sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
	    sSQL = sSQL & "values ("
        sSQL = sSQL & "'Manual Process',"
        sSQL = sSQL & "'Success',"
        sSQL = sSQL & "'" & sChangesMLog & "',"
        sSQL = sSQL & "'SERVER'," 
        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	    sSQL = sSQL & ") "
        conn.execute sSQL
        

    END IF '==== if btnProcess <> "" then

    %>
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <div id="loader-wrapper" style="display:none">
         <div id="loader"></div>
    </div>
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_tm.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Re-insert attendance records from server</h1>
            </section>
            <!-- Main content -->
            <section class="content" style="min-height:210px;padding-bottom:0px;">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <div class="box box-info">
                            <div class="box-body">
                                <div id="darkLayer" class="darkClass" style="display:none">                     
                                </div>
                                <form class="form-horizontal" action="tm_manualprocess.asp" method="post" name="form1" id="form1">
                                    <div class="form-group">
                                        <div class="col-sm-7">
                                            <h4><b><i>Step 1: Check Unprocessed Attendance Records on the Server</i></b></h4>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-7" style="padding-top: 7px">
                                            <input type="SUBMIT" class="btn bg-green-gradient"name="cmdSubmit" value="Check" style="width: 90px; margin-right: 10px" >
                                            <input type="button" class="btn bg-red-gradient" value="Cancel" style="width: 90px" onclick="window.location = ('tm_manualprocess.asp')">
                                        </div>
                                    </div>
                                </form>
                                <div class="form-group">
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-7" style="padding-left: 7px">
                                        <% 
                                            if request("cmdSubmit") <> "" then
                                                set fs=Server.CreateObject("Scripting.FileSystemObject")
                                                set fo=fs.GetFolder(Server.MapPath(".") & "\database\attendanceData\")

                                                for each x in fo.files
          
                                                    sFile = x.Name
            
                                                    a = Split(sFile,".") '=== a = [Data20180224, txt]
            
                                                    sFileInitName = Trim(Mid(a(0),1,4))
            
                                                    if sFileInitName = "Data" Then '==== Only process those files initial is Data
                                                        sDtProcess = Trim(Mid(a(0),5,8)) '==== Get the date out of the file
                                                        sDtProcess = Mid(sDtProcess,7,2) & "/" & Mid(sDtProcess,5,2) & "/" & Mid(sDtProcess,1,4) 
                                                        dtProcOTAbn = dateadd("d", -1, CDate(sDtProcess))
                                                        response.write "Filename : " & sFile & ", Date of Records : " & sDtProcess & "<br>"
                                                    end if
                                                next 
                                                set fo=nothing
                                                set fs=nothing
                                            end if
                                        %>
                                    </div>
                                    <!-- class col-sm-7-->
                                </div>
                                <!--form-group-->
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <div class="box box-info">
                            <div class="box-body">
                                <!--<div id="darkLayerproc" class="darkClass" style="display:none">                     
                                </div>-->
                                <form class="form-horizontal" action="tm_manualprocess.asp" method="post" name="form2" id="form2">
                                    <div class="form-group">
                                        <div class="col-sm-9">
                                            <h4><b><i>Step 2 : Reinsert All or by Individual Employee</i></b></h4>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform:uppercase" placeholder="ALL">
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
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-7">
                                            <input type="SUBMIT" class="btn bg-blue-gradient" name="btnProcess" value="Insert" style="width: 120px; margin-right: 10px" onclick="turnon();">
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!-- box body-->
                        </div>
                        <!-- box info -->
                    </div>
                    <!--col-sm-12-->
                </div>
                <!-- row -->
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
    <!-- JQuery for the Choose a file label -->
    <script src="plugins/Custom/custom-file-input.js"></script>

    <script>
    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    //=== This is diasble enter key to post back
    $('#form2').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
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
	
    function turnon(){
         document.getElementById("loader-wrapper").style.display = "";
    }

    </script>
</body>
</html>
