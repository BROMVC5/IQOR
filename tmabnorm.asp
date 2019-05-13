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
    <title>iQOR | Abnormal Attendance</title>
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
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
    <!-- TimeMask -->
    <script src="plugins/input-mask/jquery.mask.js"></script>
    <%

        sLogin = session("USERNAME")
        sAfterApprove = request("AfterApprove")
        sApprov = request("txtApprov")
        sDown = request("txtDown")
        sEMP_CODE = trim(request("txtEMP_CODE"))
        sWorkGrp_ID = request("txtWorkGrp_ID")
        sWork_ID = request("txtWork_ID")

        sOrderBy = request("txtOrderBy")
        sAscDesc = request("txtAscDesc")

        Set rstBROPATH = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from BROPATH" 
        rstBROPATH.Open sSQL, conn, 3, 3
        if not rstBROPATH.eof then
            sNumRows = rstBROPATH("NUMROWS")
        end if
        pCloseTables(rstBROPATH)

        PageLen = Cint(sNumRows)

     %>
</head>
<body class="hold-transition skin-blue sidebar-collapse sidebar-mini">
    <div class="wrapper">

        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_tm.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Abnormal Attendance </h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="box">
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <form name="form1" class="form-horizontal" action="tmabnorm.asp" method="POST">
                                    <input type="hidden" id="txtlogin" value='<%=sLogin%>' />
                                    <input type="hidden" id="AfterApprove" value='<%=sAfterApprove%>' />
                                    <input type="hidden" id="txtApprov" value='<%=sApprov%>' />
                                    <input type="hidden" id="txtDown" value='<%=sDown%>' />
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Approver : </label>
                                        <div class="col-sm-3">
                                            <select id="selApprov" name="selApprov" class="form-control" onchange="showApprover();return false;">
                                                <%  
                                                    Set rstAPPROV = server.CreateObject("ADODB.RecordSet")    
                                                    sSQL = "select * from TMEMPLY where "
                                                    sSQL = sSQL & " EMP_CODE = '" & sLogin & "'"  
                                                    rstAPPROV.Open sSQL, conn, 3, 3
                                                    if not rstAPPROV.eof then
                                                        sApvName = rstAPPROV("NAME")
                                                        sAType = rstAPPROV("ATYPE") 
                                                        
                                                        if sAfterApprove = "Y" then '=== After approve need to maintain the selection

                                                            if sAType = "V" then '=== If Login as Verifier

                                                                if sApprov = "V" then '=== Take the role as verifier
                                                                    response.write "<option value='V' selected='selected'>Verifier</option>"
                                                                    response.write "<option value='M'>Manager</option>"
                                                                    response.write "<option value='S'>Superior</option>"
                                                                elseif sApprov = "M" then '=== Take the role as Manager
                                                                    response.write "<option value='V'>Verifier</option>"
                                                                    response.write "<option value='M' selected='selected'>Manager</option>"
                                                                    response.write "<option value='S'>Superior</option>"
                                                                elseif sApprov = "S" then '===  Take the role as Superior
                                                                    response.write "<option value='V'>Verifier</option>"
                                                                    response.write "<option value='M'>Manager</option>"
                                                                    response.write "<option value='S' selected='selected'>Superior</option>"
                                                                end if

                                                            elseif sAtype = "M" then '=== If Login as Manager
                                                    
                                                                if sApprov = "M" then '=== Take the Role as Manager
                                                                    response.write "<option value='M' selected='selected'>Manager</option>"
                                                                    response.write "<option value='S'>Superior</option>"
                                                                elseif sApprov = "S" then '=== Take the role as Superior
                                                                    response.write "<option value='M'>Manager</option>"
                                                                    response.write "<option value='S' selected='selected'>Superior</option>"
                                                                end if

                                                            elseif sAType = "S" then '=== Log in as Superior, No role can be taken

                                                                response.write "<option value='S' selected>Superior</option>"
                                                    
                                                            end if
                                                        
                                                        else '=== New load and not after Approve button is hit
                                                        
                                                            if sAType = "V" then
                                                            
                                                                response.write "<option value='V' selected='selected'>Verifier</option>"
                                                                response.write "<option value='M'>Manager</option>"
                                                                response.write "<option value='S'>Superior</option>"
                                                            
                                                            elseif sAtype = "M" then
                                                                
                                                                response.write "<option value='M' selected='selected'>Manager</option>"
                                                                response.write "<option value='S'>Superior</option>"
                                                            
                                                            elseif sAType = "S" then

                                                                response.write "<option value='S' selected>Superior</option>"
                                                    
                                                            end if
                                                        end if
                                                        
                                                    end if 
                                                 %>
                                            </select>
                                        </div>
                                        <label class="col-sm-2 col-lg-2 control-label">Work Group : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtWorkGrp_ID" name="txtWorkGrp_ID" style="text-transform: uppercase" placeholder="All" value="<%=sWorkGrp_ID %>">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('WORKGRP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class ="form-group">
                                            <div id="approver">
                                                <%
                                                    if sAType = "V" then
                                                        sApprovlb = "Verifier : "
                                                    elseif sAtype = "M" then
                                                        sApprovlb = "Manager : "
                                                    elseif sAType = "S" then
                                                        sApprovlb = "Superior : "
                                                    end if
                                                %>
                                                <label class="col-sm-2 control-label"><%response.write sApprovlb %> </label>
                                                <div class="col-sm-3">
                                                    <select id="selDown" name="selDown" class="form-control">
                                                        <%  if sAType = "V" then
                                                                response.write "<option value='" & sLogin & "'>" & sApvName & "</option>" 
                                                            elseif sAType = "M" then
                                                                    response.write "<option value='" & sLogin & "'>" & sApvName & "</option>" 
                                                            elseif sAType = "S" then
                                                                    response.write "<option value='" & sLogin & "'>" & sApvName & "</option>" 
                                                            end if
                                                        %>
                                                    </select>
                                                </div>
                                            </div>
                                        <label class="col-sm-2 col-lg-2 control-label">Work Location : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtWork_ID" name="txtWork_ID" style="text-transform: uppercase" placeholder="All"  value="<%=sWork_ID %>">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('WORK','mycontent','#mymodal')">
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
                                                <input class="form-control" id="txtID" name="txtID" maxlength="10" style="text-transform: uppercase" placeholder="All" value="<%=sEmp_Code %>">
                                                <span class="input-group-btn">
                                                    <a href="#" name="btnSearchID" class="btn btn-default"
                                                        onclick = "fOpen('EMP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <input class="form-control" id="txtNAME" name="txtNAME" value="<%=sName%>" READONLY>
                                        </div>
                                        <div class="col-sm-2">
                                            <button type="button" id="btnShow" name="btnShow" class="btn btn-default"
                                                onclick="showContent2('page=1','<%=sOrderBy%>','<%=sAscDesc%>');return false;" style="width: 90px">
                                                Show</button>
                                        </div>
                                    </div>
                                    
                                    
                                </form>
                                <div id="content2" style="display: none">
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
        document.getElementById('selApprov').focus();

        $('#txtSearch_down').keydown(function(event) {
        // enter has keyCode = 13, change it if you want to use another button
            if (event.keyCode == 13) {
                showDetails('page=1','EMP','mycontent');
                return false;
            }
        });

    });
    
    function showApprover() {
  	    var xhttp;
        if (document.getElementById("selApprov").value != "") {
  	        xhttp = new XMLHttpRequest();
  	        xhttp.onreadystatechange = function() {
    	        if (xhttp.readyState == 4 && xhttp.status == 200) {
      	        document.getElementById("approver").innerHTML = xhttp.responseText;
    	        }
  	        };
  	
  	        str = "txtlogin=" + document.getElementById("txtlogin").value;
  	        str = str + "&txtApprov=" + document.getElementById("selApprov").value;
            str = str + "&AfterApprove=" + document.getElementById("AfterApprove").value;
            str = str + "&txtDown=" + document.getElementById("txtDown").value;
  	        xhttp.open("GET", "ajax/ax_tmapprv.asp?"+str, true);
  	        xhttp.send();
                $("#approver").show();
        }else {
                $("#approver").hide();
            }
    }

    
    function  showContent(str, sOrderBy, sAscDesc) {
  	    var xhttp;

  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    
                document.getElementById("content2").innerHTML = xhttp.responseText;
    	        
                    //=== This is for time mask and run compute function on blur
                    $('[time-maskprocess]').mask('00:00', TimeOpts).on('blur', function () {
                        var $this = $(this),
                            v = $this.val();
                        v = v.length == 0 ? '00:00' :
                            (v.length == 1 ? '0' + v + ':00' :
                                (v.length == 2 ? v + ':00' :
                                    (v.length == 3 ? v + '00' :
                                        (v.length == 4 ? v + '0' : v))));
                        $this.val(v);

                    });

                    $('#form2').on('keyup', '.input_TIN', function(e) {
                      var keyCode = e.keyCode || e.which;
                      if (keyCode === 13) { 
                        var next_input_index = $('.input_TIN').index(this) + 1;
                        $('.input_TIN').eq(next_input_index).find('.inputTINBox').focus();
                      }
                    });

                    $('#form2').on('keyup', '.input_TOUT', function(e) {
                      var keyCode = e.keyCode || e.which;
                      if (keyCode === 13) { 
                        var next_input_index = $('.input_TOUT').index(this) + 1;
                        $('.input_TOUT').eq(next_input_index).find('.inputTOUTBox').focus();
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
		    }
  	    };
  	
        if($('#selApprov').val() == ''){
        
            alert('Please select Approver');
        
        }else{

                str = str + "&txtOrderBy=" + sOrderBy
                str = str + "&txtAscDesc=" + sAscDesc

                if ($('#AfterApprove').val() == 'Y'){
                    str = str + "&txtlogin=" + document.getElementById("txtlogin").value;
  	                str = str + "&txtApprov=" + document.getElementById("txtApprov").value;
  	                str = str + "&txtDown=" + document.getElementById("txtDown").value;
                    str = str + "&txtEmp_Code=" + document.getElementById("txtID").value;
                    str = str + "&txtWorkGrp_ID=" + document.getElementById("txtWorkGrp_ID").value;
                    str = str + "&txtWork_ID=" + document.getElementById("txtWork_ID").value;
                }else{
  	                str = str + "&txtlogin=" + document.getElementById("txtlogin").value;
  	                str = str + "&txtApprov=" + document.getElementById("selApprov").value;
  	                str = str + "&txtDown=" + document.getElementById("selDown").value;
                    str = str + "&txtEmp_Code=" + document.getElementById("txtID").value;
                    str = str + "&txtWorkGrp_ID=" + document.getElementById("txtWorkGrp_ID").value;
                    str = str + "&txtWork_ID=" + document.getElementById("txtWork_ID").value;
                }
                xhttp.open("GET", "ajax/ax_tmabnorm.asp?"+str, true);
  	            xhttp.send();
            $("#content2").show();
            }
    }
    
     $(function () {
        showApprover();
        showContent('page=<%=iPage%>', '<%=sOrderBy %>','<%=sAscDesc %>');
    })

    function showContent2(str, sOrderBy, sAscDesc) {
  	    var xhttp;

  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	        document.getElementById("content2").innerHTML = xhttp.responseText;
    	        //=== This is for time mask and run compute function on blur
                $('[time-maskprocess]').mask('00:00', TimeOpts).on('blur', function () {
                    var $this = $(this),
                        v = $this.val();
                    v = v.length == 0 ? '00:00' :
                        (v.length == 1 ? '0' + v + ':00' :
                            (v.length == 2 ? v + ':00' :
                                (v.length == 3 ? v + '00' :
                                    (v.length == 4 ? v + '0' : v))));
                    $this.val(v);

                });

                    $('#form2').on('keyup', '.input_TIN', function(e) {
                      var keyCode = e.keyCode || e.which;
                      if (keyCode === 13) { 
                        var next_input_index = $('.input_TIN').index(this) + 1;
                        $('.input_TIN').eq(next_input_index).find('.inputTINBox').focus();
                      }
                    });

                    $('#form2').on('keyup', '.input_TOUT', function(e) {
                      var keyCode = e.keyCode || e.which;
                      if (keyCode === 13) { 
                        var next_input_index = $('.input_TOUT').index(this) + 1;
                        $('.input_TOUT').eq(next_input_index).find('.inputTOUTBox').focus();
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
		    }
  	    };
  	
        if($('#selApprov').val() == ''){
            alert('Please select Approver');
        }else{
            
            str = str + "&txtOrderBy=" + sOrderBy
            str = str + "&txtAscDesc=" + sAscDesc
  	        str = str + "&txtlogin=" + document.getElementById("txtlogin").value;
  	        str = str + "&txtApprov=" + document.getElementById("selApprov").value;
  	        str = str + "&txtDown=" + document.getElementById("selDown").value;
            str = str + "&txtEmp_Code=" + document.getElementById("txtID").value;
            str = str + "&txtWorkGrp_ID=" + document.getElementById("txtWorkGrp_ID").value;
            str = str + "&txtWork_ID=" + document.getElementById("txtWork_ID").value;
                
            xhttp.open("GET", "ajax/ax_tmabnorm.asp?"+str, true);
  	        xhttp.send();
            $("#content2").show();
        }
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

        if (pType=="EMP") { 
            var search = document.getElementById("txtSearch_down");
        } else if (pType=="WORKGRP") {
            var search = document.getElementById("txtSearch_workgrp");
        } else if (pType=="WORK") {
            var search = document.getElementById("txtSearch_work");
        }
	  	
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="EMP") {

            str2 = "&txtlogin=" + document.getElementById("txtlogin").value;
  	        str2 = str2 + "&txtApprov=" + document.getElementById("selApprov").value;
  	        str2 = str2 + "&txtDown=" + document.getElementById("selDown").value;

	  	    xhttp.open("GET", "ajax/ax_view_tmdownid.asp?"+str+str2, true);

	  	} else if (pType=="WORKGRP") {
            xhttp.open("GET", "ajax/ax_view_tmworkgrpid.asp?"+str, true);
        } else if (pType=="WORK") {
            xhttp.open("GET", "ajax/ax_view_tmworkid.asp?"+str, true);
        }
	  	
  	    xhttp.send();
    }

    function fABShowHis(pEmpCode,pDtWork,pContent,pModal) {
        showOTHis(pEmpCode,pDtWork,pContent)
	    $(pModal).modal('show');
	}

    function showOTHis(pEmpCode,pDtWork,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

	    str = "txtEmpCode=" + pEmpCode;
  	    str = str + "&txtDtWork=" + pDtWork;
  	    
	  	xhttp.open("GET", "ajax/ax_tmabshowhis.asp?"+str, true);

  	    xhttp.send();
    }

    //========Check if Tin or TOut is empty during save, check first then call btnSave Click ==========

    function checkempty() {
        var sEmpCode;
        var dtWork;
        var sTOUT;
        for (i = 1; i <= <%=pageLen%>; i++) { 
            
            if($('#txtchkbox' + i ).is(':checked')){
                    sEmpCode = $('#txtEmpCode' + i ).val();
                    dtWork = $('#dtWork' + i ).val();
                    sTOUT = $('#txtTimeOut'+ i).val();
                if($('#txtTimeIn' + i ).val() == '' ){
                    alert('Employee : ' + sEmpCode + ', Working Date : ' + dtWork + ', Time IN is empty  ');
                    var sBreak = "Y";
                    break;
                }else if($('#txtTimeOut'+ i).val() == '' ){
                    alert('Employee : ' + sEmpCode + ', Working Date : ' + dtWork + ', Time OUT is empty  ');
                    var sBreak = "Y" ;
                    break;
                }
            } 
        }
        
        if (sBreak !="Y" ){
            $('#btnSave').click();
        }
    }
   //===========By Hans 2017092212313414 ===================================   
   
   //========== Delete one record and refresh the page ==========================

    function DelTrans(sPage,pWhat,i,sOrderBy,sAscDesc){
        
        var sEmpCode = $('#txtEmpCode' + i ).val()
        var dtWork = $('#dtWork' + i ).val()
        
        var url_to	= 'ajax/ax_tmdeltrans.asp';  

        if (confirm("This will DELETE Employee : " + sEmpCode + " Working on : " + dtWork + ". Are you sure? ")){
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtWhat" : pWhat,
                                "txtID": sEmpCode,
                                "dtWork": dtWork,
                                "txtComment":$("#txtComment"+i).val(),
                                }, 
             
                    success : function(res){
                        
                    if(res.data.status == "OK") {
                        removeMyRow(i) //=== Remove the row so whatever key in earlier will still remain
                        }
                    },
                    error	: function(error){
                            console.log(error);
                        }
                    });
            }else{
                return false;
            }
    }

    function removeMyRow(docRowCount){
       $('table tr').eq(docRowCount).remove();
    }

    function checkAll(x){

        $('input:checkbox').prop('checked', true);
    };

    function uncheckAll(x){

        $('input:checkbox').prop('checked', false);
    };

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
	
	$( "#txtWork_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=WL",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtWork_ID").val(ui.item.value);
				var str = document.getElementById("txtWork_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtWork_ID").value = res[0];
			},0);
		}
	});
	
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
