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
    <title>iQOR | Shift Schedule Details</title>
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
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />

    <%
    iPage = request("Page")
    sEMP_CODE = request("txtEMP_CODE")
    dt_Shift = request("txtdt_Shift")
    bUpdate = request("bUpdate")
    sBegMonth = request("txtMonth")
    sBegYear = request("txtYear")
    
    if sEMP_CODE <> "" then
        sID = sEMP_CODE
    else
        sID = reqFormU("txtID")
    end if

    if dt_Shift <> "" then
        dtShift = dt_Shift
    else
        dtShift = reqForm("dt_Shift")
    end if
    
    sModeSub = request("sub")
    
    sMainURL = "tmshiftot.asp?"
	sAddURL  = "Page=" & iPage & "&txtdt_Shift=" & dtShift & "&txtMonth=" & sBegMonth & "&txtYear=" & sBegYear 
    sIDURL   ="&txtEMP_CODE=" & sID
    sIDURL2  ="&txtEMP_CODE=" & sID
    if sModeSub <> "" Then
        
        sSHF_CODE = reqFormU("txtSHF_CODE")
        sHol_ID = reqFormU("txtHol_ID")
 
        if sModeSub = "up" Then
            
            sSQL = "UPDATE TMSHIFTOT SET "             
            sSQL = sSQL & "SHF_CODE = '" & UCase(sSHF_CODE) & "',"
            sSQL = sSQL & "HOL_ID = '" & UCase(sHol_ID) & "'"
            sSQL = sSQL & " WHERE EMP_CODE = '" & UCase(sID) & "' AND DT_SHIFT ='" & fdate2(dtShift) & "'"
            conn.execute sSQL
            
            call confirmBox("Update Successful!", sMainURL&sAddURL&sIDURL2)

        elseif sModeSub = "save" Then
        
            sSQL = "insert into TMSHIFTOT (EMP_CODE,DT_SHIFT,SHF_CODE,HOL_ID,USER_ID,DATETIME) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & fdate2(dtShift) & "',"
		    sSQL = sSQL & "'" & UCase(sSHF_CODE) & "',"
            sSQL = sSQL & "'" & UCase(sHol_ID) & "',"		
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
		    conn.execute sSQL
            
            call confirmBox("Save Successful!", sMainURL&sAddURL&sIDURL2)
         End If 
    End If
          
    Set rstTMSHIFTOT = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select tmshiftot.*, tmworkgrp.workgrp_id, tmworkgrp.part as WORKGRP_PART, "
    sSQL = sSQL & " tmshfplan.SHFPLAN_ID, tmshfplan.PART as SHIFTPLAN_PART from TMSHIFTOT "
    sSQL = sSQL & " left join tmworkgrp on tmshiftot.EMP_CODE = tmworkgrp.EMP_CODE "
    sSQL = sSQL & " left join tmshfplan on tmworkgrp.WORKGRP_ID = tmshfplan.WORKGRP_ID "
    sSQL = sSQL & " where tmshiftot.EMP_CODE='" & sID & "'" 
    sSQL = sSQL & " and DT_SHIFT='" & fdate2(dtShift) & "'"
    rstTMSHIFTOT.Open sSQL, conn, 3, 3
        if not rstTMSHIFTOT.eof then
            sSHF_CODE = rstTMSHIFTOT("SHF_CODE")
            sHol_ID = rstTMSHIFTOT("HOL_ID")
            sWorkGroup = rstTMSHIFTOT("WORKGRP_ID") & " - " & rstTMSHIFTOT("WORKGRP_PART")
            sShiftPlan = rstTMSHIFTOT("SHIFTPLAN_PART")
        end if
    pCloseTables(rstTMSHIFTOT)
       
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
                <h1>Shift Schedule Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="tmshiftot_det.asp" method="post">
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <input type="hidden" name="txtEMP_CODE" value='<%=sEMP_CODE%>' />
                            <input type="hidden" name="txtDt_Work" value='<%=dt_Work%>' />
                            <input type="hidden" name="txtMonth" value='<%=sBegMonth%>' />
                            <input type="hidden" name="txtYear" value='<%=sBegYear%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%><%=sIDURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-7">
                                            <div class="input-group">
                                                <span class="mod-form-control"><% response.write UCase(sEMP_CODE) %></span>
                                                <input type="hidden" id="txtID" name="txtID" value="<%=sEMP_CODE%>">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Shift Date : </label>
                                        <div id="div_dt_Shift" class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_Shift" name="dt_Shift" value="<%=fdatelong(dt_Shift)%>" 
                                                    type="text" class="form-control" date-picker onblur="validatedt();">
                                                <span class="input-group-btn">
                                                    <a href="#" id="btndt_Shift" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_Shift" class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Shift Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtSHF_CODE" name="txtSHF_CODE" value="<%=sSHF_CODE%>" maxlength="6" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('SHFCODE','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Holiday Group : </label>
                                        <div class="col-sm-4">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtHol_ID" name="txtHol_ID" value="<%=sHol_ID%>" maxlength="30" style="text-transform: uppercase" input-check required>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default" 
                                                       onclick ="fOpen('HOL','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Work Group : </label>
                                        <div class="col-sm-7">
                                            <div class="input-group">
                                                <span class="mod-form-control"><% response.write UCase(sWorkGroup) %></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Shift Plan : </label>
                                        <div class="col-sm-7">
                                            <div class="input-group">
                                                <span class="mod-form-control"><% response.write UCase(sShiftPlan) %></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="box-footer">
                                        <%if bUpdate <> "" then %>
                                            <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sEmp_Code & "-" & fdatelong(dt_Shift)%>','mycontent-del','#mymodal-del')">Delete</a>
                                            <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="check('up');">Update</button>
                                            <button type="submit" id="btnUp" name="sub" value="up" class="btnSaveHide"></button>
                                        <%else %>
                                            <button type="button" id="btnCheck" name="btnCheck" class="btn btn-primary pull-right"
                                            style="width: 90px" onclick="check('save');">Save</button>
                                            <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide"></button>
                                        <%end if %>
                                    </div>
                                    <!-- /.box-footer -->
                                </div>
                                <!-- /.box -->
                            </div>
                        </form>
                    </div>
                </div>
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
                <div class="modal fade " id="mymodal-del" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                            </div>
                            <div class="modal-body">
                                <div id="mycontent-del">
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

    <script>
    $(function () {

        //Date picker
        $("#dt_Shift").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            })
    });

    $('#btndt_Shift').click(function () {
        $('#dt_Shift').datepicker("show");
        });

    function validatedt(){
        
        var input = document.getElementById("dt_Shift").value;
        var pattern =/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/;

        if (pattern.test(input)==false){
	        alert("Shift Date format is incorrect, please key in DD/MM/YYYY");
            document.getElementById('div_dt_Shift').className += ' has-error'
            document.getElementById("errdt_Shift").innerHTML = "Please key in DD/MM/YYYY" 
            return false;
            }
    }   
    </script>

    <script>
     function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue1(svalue1,pFldName1) {
        document.getElementById(pFldName1).value = svalue1;
        $('#mymodal').modal('hide');
    }

    function getValue3(svalue1, svalue2, svalue3,pFldName1,pFldName2,pFldName3) {
        document.getElementById(pFldName1).value = svalue1;
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

        if (pType=="SHFCODE") { 
            var search = document.getElementById("txtSearch_shfcode");
	  	}else if (pType=="HOL") {
            var search = document.getElementById("txtSearch_hol");
        }
                
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="SHFCODE") {
	  	    xhttp.open("GET", "ajax/ax_view_tmshfcode.asp?"+str, true);
	  	}else if (pType=="HOL") {
            xhttp.open("GET", "ajax/ax_view_tmholid.asp?"+str, true);
        } 
	  	
  	    xhttp.send();
    }

     function fDel(str, pContent,pModal) {
        showDelmodal(str, pContent)
		$(pModal).modal('show');
	}

    function showDelmodal(str,pContent){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "tmshiftot_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    function check(pWhat){
      
        var sSubmit = "Y"

        if (pWhat == "save"){
            var inputData = ['dt_Shift','SHF_CODE','Hol_ID'];
        }else{
            var inputData = ['SHF_CODE','Hol_ID'];
        }
        
        for (var i = 0; ((i < inputData.length) && sSubmit == "Y" ); i++) {
               var key = inputData[i];
               var url_to	= 'ajax/ax_notexist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtWhat" : key,
                                "txtID":$("#txt"+key).val(),
                                "txtEmpCode":$("#txtID").val(),
                                "dtShift":$("#dt_Shift").val(),
                              }, 
             
                    success : function(res){
                        
                        if(res.data.status == "notexist"){
                            sSubmit = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "exist"){
                            sSubmit = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "empty"){
                            sSubmit = "N";
                            return alert(res.data.value);
                        }else if (res.data.status == "OK") {
                        }
                   },
                    error	: function(error){
                        console.log(error);
                    }
               });
            }
    
        if (sSubmit == "Y" && pWhat == "save" ){
            $('#btnSave').click();
        }else if (sSubmit == "Y" && pWhat == "up" ){
            $('#btnUp').click();
        }
    }
	
    $( "#txtSHF_CODE" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=TC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtSHF_CODE").val(ui.item.value);
                var str = document.getElementById("txtSHF_CODE").value;
				var res = str.split(" | ");
                document.getElementById("txtSHF_CODE").value = res[0];
                compute();
                
			},0);
		}
	});

    $( "#txtHol_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=HC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtHol_ID").val(ui.item.value);
				var str = document.getElementById("txtHol_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtHol_ID").value = res[0];
			},0);
		}
	});

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
			},0);
		}
	});
    </script>
</body>
</html>
