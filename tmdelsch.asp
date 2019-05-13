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
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <title>iQOR | Delete Schedule</title>

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

    <%
        if request("btnSave") <> "" then   
            sEmp_CODE = reqForm("txtID")
            dt_DateFr = reqForm("dtpDelFr")
            dt_DateTo = reqForm("dtpDelTo") 
        
            do while datevalue(dt_DateFr) <= datevalue(dt_DateTo)
            
                sSQL = "delete from TMSHIFTOT where EMP_CODE='" & sEmp_CODE & "'"
                sSQL = sSQL & " and DT_SHIFT = '" & fdate2(dt_DateFr) & "'"
                conn.execute sSQL     

                dt_DateFr = DateAdd("d",1,datevalue(dt_DateFr)) '=== For loop here add back one day for 1st day and continue
                
            loop '=== loop for the dt_dateloop <= dt_dateTo
            
            call confirmbox("Delete Successfully", "tmshiftot.asp")
        end if '=== End if btnSubmit
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
                <h1>Delete Schedule</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmdelsch.asp" method="post">
                            <div class="box box-info">
                                <div class="box-body">
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
                                        <label class="col-sm-3 control-label">Delete From Date : </label>
                                        <div id="divdtpDelFr" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpDelFr" name="dtpDelFr" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpDelFr" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdtpDelFr" class="help-block"></span>
                                        </div>
                                        <label class="col-sm-3 col-lg-1 control-label" style="text-align: left;">To Date : </label>
                                        <div id="divdtpDelTo" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpDelTo" name="dtpDelTo" type="text" class="form-control" datewotoday>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpDelTo" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdtpDelTo" class="help-block"></span>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.box body -->
                                <div class="box-footer">
                                    <div class="pull-right" >
                                        <button type="button" id="btnCheck" name="btnCheck" value="Check" class="btn btn-default"
                                        style="width: 90px" onclick="checkempty();">
                                            Delete</button>
                                        <button type="submit" id="btnSave" name="btnSave" value="save" class="btnSaveHide"></button>
                                    </div>
                                </div>
                                <!-- /.box footer -->
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

    $(function () {
        //Date picker
        $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            orientation: "bottom",
            }).datepicker("setDate", new Date());
        document.getElementById('txtID').focus();
    });
    $(function () {
        //Date picker
        $("[datewotoday]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            orientation: "bottom",
            })
    });
    
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

    $('#btndtpDelFr').click(function () {
        $('#dtpDelFr').datepicker("show");
        });

    $('#btndtpDelTo').click(function () {
        $('#dtpDelTo').datepicker("show");
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
    
    //========Check if Employee Code, Date is empty, check Date Format and range, if OK then call btnSave Click ==========
    function checkempty() {
            
            var inputData = ['Delete From', 'To'];
            var success = true;
            var dtDelFr = document.getElementById("dtpDelFr").value;
            var dtDelTo= document.getElementById("dtpDelTo").value;

            var dtOriDelFr = dtDelFr;
            var dtOriDelTo = dtDelTo;

            //======= Convert dd/MM/YYYY to MM/dd/YYYY so can ba compared         
            var dtDelFrArray = dtDelFr.split("/");
            var dtDelFr = dtDelFrArray[1] + '/' + dtDelFrArray[0] + '/' + dtDelFrArray[2];

            var dtDelToArray = dtDelTo.split("/");
            var dtDelTo = dtDelToArray[1] + '/' + dtDelToArray[0] + '/' + dtDelToArray[2];

            //======= Check if employee code is empty
            if($('#txtID').val() == ''){
                alert('Employee Code cannot be empty');
                success = false;
                return false;
            }else{
                
                var url_to	= 'ajax/ax_chkvalidempcode.asp';  
               
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtEmp_Code":$("#txtID").val(),
                                "dtpFr": dtOriDelFr,
                                "dtpTo": dtOriDelTo,
                                "txtWhat": 'TMCLK2',
                                }, 
             
                    success : function(res){
                 
                        if(res.data.status == "invalid"){
                            success = false;
                            return alert(res.data.value);
                        }if(res.data.status == "dtexist"){
                            success = false;
                            return alert(res.data.value);
                        }
                    },
                    error	: function(error){
                        console.log(error);
                    }
                });
            }
    
            //====== Loop through every date input box and see if date is in the DD/MM/YYYY format =====
            for (var i = 0; i < inputData.length; i++) {
            var msg = "Date " + inputData[i];

            //Deal with edge cases where naming doesn't follow convention
            if (inputData[i] === 'Delete From') {
                key = 'DelFr';
            }
            else if (inputData[i] === 'To') {
                key = 'DelTo';
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
        if ((dtDelTo < dtDelFr) && success == true){
            alert("To Date is smaller than Delete From Date");
            document.getElementById('divdtpDelTo').className += ' has-error'
            document.getElementById("errdtpDelTo").innerHTML = "Please key in a date smaller than Delete From Date" 
            success = false;
        }

        //====== if All success then will trigger Post Back ===== 
        if (success == true) {
            $('#btnSave').click();
        }     
            
    }
   //===========AutoComplete ===================================
   
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
