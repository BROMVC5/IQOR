<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv="Content-Type" content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Change Workgroup and Generate Schedule</title>
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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">

    <%
        Set rstTMPASS = server.CreateObject("ADODB.RecordSet")
	    sql = "select * from TMPASS where ID = '" & session("USERNAME") & "' "
	    sql = sql & " and TMPC = 'Y' and TMPC3 = 'Y'" 
        rstTMPASS.Open sql, conn, 3, 3
	    if rstTMPASS.eof then
            response.redirect("login.asp")
	    end if

        sWorkGrp_ID = reqU("txtWorkGrp_ID")
        sSup_CODE = reqU("txtSup_CODE")
        sEmp_CODE = reqU("txtEmp_CODE")
        
        if sWorkGrp_ID <> "" then
            sID = sWorkGrp_ID
        else
            sID = UCase(reqForm("txtID"))
        end if
        
        sMainURL = "tmchgwrkgrp.asp?"
        sAddURL = "txtWorkGrp_ID=" & sWorkGrp_ID & "&txtSup_CODE=" & sSup_CODE & "&txtEmp_CODE=" & sEmp_CODE 
        
        if request("btnSave") <> "" then   
            
            sStart = reqForm("selStart")
            dt_DateFr = reqForm("dtpSchStr")
            dt_DateTo = reqForm("dtpSchEnd") 

            Set rstTMShfPlan = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMSHFPLAN where WORKGRP_ID='" & sID & "' order by SHFPLAN_ID" 
            rstTMShfPlan.Open sSQL, conn, 3, 3
            if not rstTMShfPlan.eof then
                Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMWORKGRP where WORKGRP_ID='" & sID & "'" 
                rstTMWorkGrp.Open sSQL, conn, 3, 3
                if not rstTMWorkGrp.eof then
                    sNewHolID = rstTMWorkGrp("HOL_ID")
                end if
                
                do while datevalue(dt_DateFr) <= datevalue(dt_DateTo)
                      
                    For m = CInt(sStart) to 6 '=== Maximum 6 column in shf plan, start from which column sSTart
                            sWeek = "WEEK_" & m
                        if rstTMShfPlan("" & sWeek & "") <> "" then
                        
                            Set rstTMShfPat = server.CreateObject("ADODB.RecordSet")    
                            sSQL = "select * from TMSHFPAT"
                            sSQL = sSQL & " where SHFPAT_ID='" & rstTMShfPlan("SHFPAT_ID") & "'"
                            sSQL = sSQL & " and PATTERN ='" &  rstTMShfPlan("" & sWeek & "") & "'" 
                            rstTMShfPat.Open sSQL, conn, 3, 3
                            if not rstTMShfPat.eof then
                                For d = 1 to 7
                                    variable = "DAY_" & d
                                    sShfCode = rstTMShfPat("" & variable & "" )
                                       
                                    Set rstTMShfCode = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMSHFCODE"
                                    sSQL = sSQL & " where SHF_CODE='" & sShfCode & "'"
                                    rstTMShfCode.Open sSQL, conn, 3, 3
                                    if not rstTMShfCode.eof then

                                        if datevalue(dt_DateFr) <= datevalue(dt_DateTo) then
        
                                            Set rstTMSHIFTOT = server.CreateObject("ADODB.RecordSet")    
                                            sSQL = "select * from TMSHIFTOT"
                                            sSQL = sSQL & " where EMP_CODE='" & sEMP_CODE & "'"
                                            sSQL = sSQL & " and DT_SHIFT ='" &  fdate2(dt_DateFr) & "'" 
                                            rstTMSHIFTOT.Open sSQL, conn, 3, 3
                                            if not rstTMSHIFTOT.eof then                                                    
                                                sSQL = "UPDATE TMSHIFTOT SET "             
                                                sSQL = sSQL & "SHF_CODE = '" & sShfCode & "',"
                                                sSQL = sSQL & "HOL_ID = '" & sNewHolID & "',"
                                                sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
                                                sSQL = sSQL & "DATETIME = '" & fdatetime2(Now())  & "'"
                                                sSQL = sSQL & " WHERE EMP_CODE = '" & sEMP_CODE & "'"
                                                sSQL = sSQL & " and DT_SHIFT = '" & fdate2(dt_DateFr) & "'"
                                                conn.execute sSQL
        
                                            else

                                                sSQL = "insert into TMSHIFTOT (EMP_CODE,DT_SHIFT,SHF_CODE,HOL_ID,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                        sSQL = sSQL & "values ("
		                                        sSQL = sSQL & "'" & sEMP_CODE & "',"		
		                                        sSQL = sSQL & "'" & fdate2(dt_DateFr) & "',"
		                                        sSQL = sSQL & "'" & sShfCode & "',"		
		                                        sSQL = sSQL & "'" & sHol_ID & "',"		
		                                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		                                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                        sSQL = sSQL & ") "
                                                conn.execute sSQL
                                            end if
                                        else '=== if Dateloop is > then dt_Date to, I want to Exit Do
                                            Exit Do
                                        end if
                                        dt_DateFr = DateAdd("d",1,datevalue(dt_DateFr)) 
                                    end if 
                                next
                            end if 
                        elseif sStart = 6 then '==== when the for loop for week hit 6 it will go back to 1
                            sStart = 1
                        else
                            sStart = 1 '=== When the for loop start with anything but 1 and it hit an empty week field, it will restart back to 1
                        end if 
                    next '=== which week it start, most likely 1, if 2 or move, it will loop back to 1
                
                'dt_DateFr = DateAdd("d",1,datevalue(dt_DateFr)) '=== For loop here add back one day for 1st day and continue
                
                loop '=== loop for the dt_DateFr <= dt_dateTo
            end if    

            sSQL = "Update TMWORKGRP set WORKGRP_ID = '" & sWorkGrp_ID & "'"
            sSQL = sSQL & "where EMP_CODE='" & sEMP_CODE & "'"
            conn.execute sSQL
            call confirmbox("Shift Generated Successfully", sMainURL&sAddURL)
        end if '=== End if btnSubmit

        Set rstTMSHIFTOT = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMSHIFTOT"
        sSQL = sSQL & " where EMP_CODE='" & sEMP_CODE & "'"
        sSQL = sSQL & " order by DT_SHIFT desc limit 1" 

        rstTMSHIFTOT.Open sSQL, conn, 3, 3
        if not rstTMSHIFTOT.eof then
            dt_DateTo = fdatelong(rstTMSHIFTOT("DT_SHIFT"))
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
            <section class="content-header">
                <h1>Change Workgroup and Generate Schedule</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmchgwrkgrp_det.asp" method="post">
                            <input type="hidden" name="txtID" value='<%=sWorkGrp_ID%>' />
                            <input type="hidden" name="txtSup_CODE" value='<%=sSup_CODE%>' />
                            <input type="hidden" name="txtEMP_CODE" value='<%=sEMP_CODE%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <span class="mod-form-control"><% response.write sEMP_CODE %></span>
                                        </div>
                                        <label class="col-sm-3 col-lg-1 control-label">Name : </label>
                                        <div class="col-sm-3">
                                            <%
                                                Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                                                sSQL = "select NAME from TMEMPLY where EMP_CODE='" & sEMP_CODE & "'" 
                                                rstTMEMPLY.Open sSQL, conn, 3, 3
                                                if not rstTMEMPLY.eof then    
                                                    sName = rstTMEMPLY("NAME")
                                                end if
                                                
                                            %>
                                            <span class="mod-form-control"><%response.write sName%></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">New Work Group : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtWorkGrp_ID" name="txtWorkGrp_ID" value="<%=sWorkGrp_ID%>" style="text-transform: uppercase" placeholder="All">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick="fOpen('WORKGRP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Scheduled Start Date : </label>
                                        <div id="divdtpSchStr" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpSchStr" name="dtpSchStr" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpSchStr" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdtpSchStr" class="help-block"></span>
                                        </div>
                                        <label class="col-sm-3 col-lg-2 control-label">Schedule End Date : </label>
                                        <div id="divdtpSchEnd" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpSchEnd" name="dtpSchEnd" type="text" value="<%=dt_DateTo %>"class="form-control" datewotoday>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpSchEnd" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdtpSchEnd" class="help-block"></span>
                                        </div>
                                    </div>
                                    <div id="content2">
                                        <!-- Display Content here -->
                                    </div>
                                </div>
                                <!-- /.box body -->
                            </div>
                            <!-- /.box info -->
                        </form>
                    </div>
                    <!-- /.col-->
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

    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    $(document).ready(function(){
      $('[date-picker]').mask('00/00/0000');
    });

    $(document).ready(function(){
      $('[datewotoday]').mask('00/00/0000');
    });

    $(function () {
        //Date picker
        $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            orientation: "bottom",
            }).datepicker("setDate", new Date());
        document.getElementById('txtWorkGrp_ID').focus();
    });

    $(function () {
        //Date picker
        $("[datewotoday]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            orientation: "bottom",
            })
    });
        
    $('#btndtpSchStr').click(function () {
        $('#dtpSchStr').datepicker("show");
        });

    $('#btndtpSchEnd').click(function () {
        $('#dtpSchEnd').datepicker("show");
        });

 
    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');

        $(function () {showContent(svalue)}); //***===== On get value call showContent function ===****
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
        }
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="WORKGRP") {
            xhttp.open("GET", "ajax/ax_view_tmworkgrpid.asp?"+str, true);
        }
        	  	
  	    xhttp.send();
    }
    
    function showContent(str) {
  	    var xhttp;

  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("content2").innerHTML = xhttp.responseText;
    	    
            }
  	    };
  	
        str1 = "txtWORKGRP_ID=" + str;
  	    xhttp.open("GET", "ajax/ax_tmchgwrkgrp_det.asp?"+str1, true);
  	    xhttp.send();

    }

    //========Check if Pattern Start From is empty, check first then call btnSave Click ==========
    function checkempty() {
        var selStart = document.getElementById("selStart").value;

        if(selStart==''){
            alert(' Please Choose Pattern Start From ');
            }else{
                    var inputData = ['Schedule Start', 'Schedule End'];
                    var success = true;
                    var dtSchStr = document.getElementById("dtpSchStr").value;
                    var dtSchEnd = document.getElementById("dtpSchEnd").value;
                    
                    //======= Convert dd/MM/YYYY to MM/dd/YYYY so can ba compared         
                    var dtSchStrArray = dtSchStr.split("/");
                    var dtSchStr = dtSchStrArray[1] + '/' + dtSchStrArray[0] + '/' + dtSchStrArray[2];

                    var dtSchEndArray = dtSchEnd.split("/");
                    var dtSchEnd = dtSchEndArray[1] + '/' + dtSchEndArray[0] + '/' + dtSchEndArray[2];
                    
                    //====== loop through every date input box and see if date is in the DD/MM/YYYY format =====
                    for (var i = 0; i < inputData.length; i++) {
                    var msg = "Date " + inputData[i];

                    //Deal with edge cases where naming doesn't follow convention
                    if (inputData[i] === 'Schedule Start') {
                        key = 'SchStr';
                    }
                    else if (inputData[i] === 'Schedule End') {
                        key = 'SchEnd';
                    }

                    var input = document.getElementById("dtp" + key).value;
                    var pattern =/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/;
                
                    if (input.length == 0) {
                        alert(msg + " is Empty, please key in DD/MM/YYYY");
                        document.getElementById('divdtp' + key).className += ' has-error'
                        document.getElementById("errdtp" + key).innerHTML = "Please key in DD/MM/YYYY" 
                        success = false;
                    }

                    if (input.length != 0 && pattern.test(input)==false){
                        alert(msg + " format is incorrect, please key in DD/MM/YYYY");
                        document.getElementById('divdtp' + key).className += ' has-error'
                        document.getElementById("errdtp" + key).innerHTML = "Please key in DD/MM/YYYY" 
                        success = false;
                    }

                }
                
                //======= Check End Date is smaller than Start Date after success Patern check ========            
               // if ((dtSchEnd < dtSchStr) && success == true){
               //     alert("Schedule End Date is smaller than Scheduled Start Date");
               //     document.getElementById('divdtpSchEnd').className += ' has-error'
               //     document.getElementById("errdtpSchEnd").innerHTML = "Please key in a date smaller than Schedule Start Date" 
               //     success = false;
               // }

                //====== if All success then will trigger Post Back ===== 
                if (success == true) {
                    $('#btnSave').click();
                }     
            } 
        }
   //===========By Hans 20170922 ===================================
   
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
    </script>
</body>
</html>
