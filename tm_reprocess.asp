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
    <title>iQOR | Reprocess</title>
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

    <script>
    
    function dimOn() {
        document.getElementById("darkLayer").style.display = "";
    }

    function turnoff(){
        document.getElementById("loader-wrapper").style.display = "none";
    }
    </script>

    <%
        Server.ScriptTimeout = 10000000

        '===== From Program setup =====
        Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMPATH" 
        rstTMPATH.Open sSQL, conn, 3, 3
        if not rstTMPATH.eof then
            sPayFrom = rstTMPATH("PAYFROM") 
            sPayTo = rstTMPATH("PAYTO")
        end if
        pCloseTables(rstTMPATH)
        
        if request("btnProcess") <> "" then

            sEmpCode= reqFormU("txtID")
            dtReprocFrDate = reqForm("dtReprocFrDate")
            dtProcess = dtReprocFrDate
            dtAbsent = dateadd("d", -1, dtProcess)
            dtReprocToDate = reqForm("dtReprocToDate")
        
            do while datevalue(dtProcess) <= datevalue(dtReprocToDate)
        
                '===== 1. Check Shift Schedule and Insert into TMCLK2======================================================
                sSQL = " delete from TMCLK2 where DT_WORK = '" & fdate2(dtProcess) & "'"
                if sEmpCode <> "" then
                    sSQL = sSQL & " and EMP_CODE = '" & sEmpCode & "'" 
                end if    
                conn.execute sSQL

                call fInsertTMCLK2(dtProcess, sEmpCode)

                '===== 2. Process OTs, Abnormal, Late, Early, Half Day, Total and TotalOT=================================
                dtCheckFr = dateadd("d", -1, dtProcess)
                if sEmpCode <> "" then 
                   call fProcAbOT(dtCheckFr, sEmpCode, "N") '===Individual employee even it has approved somewhere, will overwrite
                else '=== For All employee
                   call fProcAbOT(dtCheckFr, sEmpCode, "Y") '=== Will avoid those approved records.
                end if

                '===============3.  Insert into TMOUTBOX ==================================================================
                dtSentMail = dateadd("d", -1, dtProcess)
                call fEmail(dtSentMail,sEmpCode,"N") 
                '=========================================================================================================

                dtProcess = DateAdd("d",1,datevalue(dtProcess))
            loop

            do while datevalue(dtAbsent) < datevalue(dtReprocToDate)
                
                sSQL = " delete from TMABSENT where DT_ABSENT = '" & fdate2(dtAbsent) & "'"
                if sEmp_Code <> "" then
                    sSQL = sSQL & " and EMP_CODE = '" & sEmp_Code & "'" 
                end if    
                conn.execute sSQL

                call fAbsent(dtAbsent,sEmpCode)
                dtAbsent = DateAdd("d",1,datevalue(dtAbsent))
            loop
   
            dtFr1DayBefore = DateAdd("d",-1,datevalue(dtReprocFrDate))
            dtTo1DayBefore = DateAdd("d",-1,datevalue(dtReprocToDate))

            call fAbsent3(dtReprocFrDate, dtTo1DayBefore, sEmpCode, "N")
        
            response.write "<script language='javascript'>"
		    response.write "turnoff();"
		    response.write "</script>"

            sChangesM = "Reprocess completed on " & Now() & "\n"
            sChangesM = sChangesM & "Inserted Attendance Records matching their Shift Schedule\nFrom " & dtReprocFrDate & " To "  & dtReprocToDate & "\n"
            sChangesM = sChangesM & "Processed Abnormals, OTs and Insert Absences \nFrom " & dtFr1DayBefore & " To "  & dtTo1DayBefore & "\n" 
            sChangesM = sChangesM & "Sent out Email Notification to their respective Superior or Managers\n"
            sChangesM = sChangesM & "Re-calculated 3 Days Consecutive Absences\n"

            if Cint(day(dtReprocFrDate)) >= Cint(sPayFrom) then 
                dtReprocFrDate = CDate(sPayFrom & "-" & Month(dtReprocFrDate) & "-" & Year(dtReprocFrDate))
            else
                dtReprocFrDate = CDate(sPayFrom & "-" & GetLastMonth(Month(dtReprocFrDate), Year(dtReprocFrDate)) & "-" & GetLastMonthYear(Month(dtReprocFrDate), Year(dtReprocFrDate)))
            end if

            if Cint(day(dtReprocToDate)) > Cint(sPayTo) then 
                dtReprocToDate = CDate(sPayTo & "-" & GetNextMonth(Month(dtReprocToDate), Year(dtReprocToDate)) & "-" & GetNextMonthYear(Month(dtReprocToDate), Year(dtReprocToDate)))
            else
                dtReprocToDate = CDate(sPayTo & "-" & Month(dtReprocToDate) & "-" & Year(dtReprocToDate))
            end if

            do while datevalue(dtReprocFrDate) < datevalue(dtReprocToDate)
                dtReprocLoopTo = CDate(sPayTo & "-" & GetNextMonth(Month(dtReprocFrDate), Year(dtReprocFrDate)) & "-" & GetNextMonthYear(Month(dtReprocFrDate), Year(dtReprocFrDate)))
                sAb3Dates = sAb3Dates & "From " & dtReprocFrDate  & " To " & dtReprocToDate & "\n"
                dtReprocFrDate = DateAdd("m",1,datevalue(dtReprocFrDate))
            loop 
        
            sChangesM = sChangesM + sAb3Dates

            if sEmpCode <> "" then
                sChangesM = sChangesM & "For Employee " & sEmpCode  
            else
                sChangesM = sChangesM & "For All Employees "
            end if

            sChangesMLog = Replace(sChangesM, "\n", " ")

            '=============Insert into TMLOG =====================
            sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
	        sSQL = sSQL & "values ("
            sSQL = sSQL & "'Reprocess',"
            sSQL = sSQL & "'Success',"
            sSQL = sSQL & "'" & sChangesMLog & "',"
            sSQL = sSQL & "'SERVER'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	        sSQL = sSQL & ") "
            conn.execute sSQL
        
            call confirmBox(sChangesM , "tm_reprocess.asp")
      
        END IF '==== if btnProcess <> "" then
        
        if Cint( day(date()) ) >= Cint(sPayFrom) then 
            dtReprocFrDate = CDate(sPayFrom & "-" & Month(date()) & "-" & Year(date()) )
        else
            dtReprocFrDate = CDate(sPayFrom & "-" & GetLastMonth(Month(Date()), Year(Date())) & "-" & GetLastMonthYear(Month(Date()), Year(Date())))
        end if
        
        dtReprocToDate = date()

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
                <h1>Reprocess attendance record</h1>
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
                                <form class="form-horizontal" action="tm_reprocess.asp" method="post" name="form1" id="form1">
                                    <input type="hidden" id="txtPayFrom" value="<%=sPayFrom%>">
                                    <input type="hidden" id="txtPayTo" value="<%=sPayTo%>">
                                    <div class="form-group">
                                        <div class="col-sm-9">
                                            <h4><b><i>Select processing date</i></b></h4>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">From Date : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtReprocFrDate" name="dtReprocFrDate" type="text" value='<%=fdatelong(dtReprocFrDate)%>' class="form-control" date-picker data-date-format="dd/mm/yyyy">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtReprocFrDate" class="btn btn-default">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <label class="col-sm-1 col-lg-1 control-label">To Date : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtReprocToDate" name="dtReprocToDate" type="text" value='<%=fdatelong(dtReprocToDate)%>' class="form-control" date-picker data-date-format="dd/mm/yyyy">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtReprocToDate" class="btn btn-default">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" 
                                                    style="text-transform:uppercase" placeholder="ALL">
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
                                            <input type="SUBMIT" class="btn bg-blue-gradient" name="btnProcess" value="Process" style="width: 120px; margin-right: 10px" onclick="turnon();">
                                            
                                        <span id="errEmail" class="help-block">*&nbsp;Note: All previous approval will be deleted.<br /> 
                                            &ensp;All OTs, Abnormals and Absences will be re-calculated from <span id="dtJavaFrom"></span> until <span id="dtJavaTo"></span><br />
                                            &ensp;Absent 3 days consecutively will be re-calcualted from <span id="dtJavaPayFrom"></span> until <span id="dtJavaPayTo"></span>
                                        </span>
                                        </div>
                                    </div>
                                </form>
                            </div><!-- box body-->
                        </div><!-- box info -->
                    </div> <!--col-sm-12-->
                </div><!--row-->
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
        </div><!-- /.content-wrapper -->
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

    //====Date picker without today's date==========================
    $(document).ready(function(){ //====== When Page finish loading
      
        $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            orientation: "bottom",
            })

        $('[date-picker]').mask('00/00/0000');

        calUntil();

    });

    $('#dtReprocFrDate').datepicker().on('changeDate', function(e) {
        calUntil();
        $('#dtReprocFrDate').datepicker("hide");
    });

    $('#dtReprocToDate').datepicker().on('changeDate', function(e) {
        calUntil();
        $('#dtReprocToDate').datepicker("hide");
    });

    $('#btndtReprocFrDate').click(function () {
        $('#dtReprocFrDate').datepicker("show");
    });

    $('#btndtReprocToDate').click(function () {
        $('#dtReprocToDate').datepicker("show");
    });

    //==============================================================

    function parseDate(str) {
        var mdy = str.split('/');
        return new Date(mdy[2], mdy[1]-1, mdy[0]);
    }

    function addDays (date, daysToAdd) {
        var _24HoursInMilliseconds = 86400000;
        return new Date(date.getTime() + daysToAdd * _24HoursInMilliseconds);
    };
    
    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;

        return [day, month, year].join('/');
    }

    function calUntil(){

        var dtReprocFrDate = parseDate($('#dtReprocFrDate').val());
        var dtReprocToDate = parseDate($('#dtReprocToDate').val());
        var sPayFrom = $('#txtPayFrom').val();
        var sPayTo = $('#txtPayTo').val();
        
        if (parseInt(dtReprocFrDate.getDate()) < parseInt(sPayTo) + 1){
            
            day = parseInt(sPayFrom)
            if (day < 10) day = '0' + day;
        
            month = dtReprocFrDate.getMonth()
            if (month.length < 2) month = '0' + month;
            
            
            year = dtReprocFrDate.getFullYear()
            if (month == 0) 
            {
                month = 12;
                year = year - 1;
            }
            
            dtReprocFrDate = [day,month,year].join('/');

        
        }else{
        
            day = parseInt(sPayFrom)
            if (day < 10) day = '0' + day;
        
            month = dtReprocFrDate.getMonth() + 1
            if (month.length < 2) month = '0' + month;
                    
            year = dtReprocFrDate.getFullYear()
            dtReprocFrDate = [day,month,year].join('/');
        }

        var yesterday = addDays(dtReprocToDate, -1);

        if (isNaN(yesterday) ){
        
        }else{

            console.log(dtReprocFrDate);

            document.getElementById('dtJavaFrom').innerHTML =dtReprocFrDate;
            document.getElementById('dtJavaPayFrom').innerHTML = dtReprocFrDate;
            
            document.getElementById('dtJavaTo').innerHTML =formatDate(yesterday);
            document.getElementById('dtJavaPayTo').innerHTML = formatDate(yesterday);
            
        }
    }


    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
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
