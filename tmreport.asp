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
    <title>iQOR | Report</title>
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

    <%
        sType = request("Type")
        sLogin = session("USERNAME")
       
        '==== From Program setup =====
        Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMPATH" 
        rstTMPATH.Open sSQL, conn, 3, 3
        if not rstTMPATH.eof then
            sPayFrom = rstTMPATH("PAYFROM") 
            sPayTo = rstTMPATH("PAYTO")
        end if
        pCloseTables(rstTMPATH)

        '==== Get the date from and to for ABSENT for 3 days=============================================================
            if Cint(day(now)) > Cint(sPayTo) then
                sPayFrom = sPayFrom & "-" & Month(Now) & "-" & Year(Now)
            else
                sPayFrom = sPayFrom & "-" & GetLastMonth(Month(Now), Year(Now)) & "-" & GetLastMonthYear(Month(Now), Year(Now))
            end if

            dtPayFrom = cDate(sPayFrom) '=== From 22nd of everymonth
            dtPayTo = Date()  '==== Till THE DATE OF PROCESS

         '================================================================================================================
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
                <%if sType = "DA" then %>
                    <h1>Daily Attendance</h1>
                <%elseif sType = "DAS" then %>
                    <h1>Daily Attendance by Superior</h1>
                <%elseif sType = "DAE" then %>
                	<h1>Daily Attendance by Employee</h1>
                <%elseif sType = "OT" then %>
                	<h1>Overtime Transaction</h1>
                <%elseif sType = "ABNORM" then %>
            	    <h1>Abnormal Attendence</h1>
                <%elseif sType = "LED" then %>
            	    <h1>Employee Late and Early Dismiss</h1>
                <%elseif sType = "AWL" then %>
            	    <h1>Absense Without Leave</h1>
			    <%elseif sType = "ACD" then %>
                    <h1>Absense for 3 Consecutive Days </h1>
                <%elseif sType = "OUT" then %>
            	    <h1>Outsource Worker List</h1>
                <%elseif sType = "WPX" then %>
            	    <h1>Work Permit Expirty for Outsource Worker</h1>
			    <%elseif sType = "DL" then %>
                    <h1>DL Mid Month Advance</h1>
                <%elseif sType = "OTX" then %>
            	    <h1>Overtime Hour Exceeded Limit</h1>
                <%elseif sType = "PLA" then %>
            	    <h1>Planned Overtime vs Actual</h1>
                <%elseif sType = "LWA" then %>
            	    <h1>Leave With Attendance</h1>
                <%elseif sType = "ALLOW" then %>
            	    <h1>Allowance</h1>
			    <%end if%>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="box">
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <form id="Form1" name="form1" class="form-horizontal" action="tmreport.asp" method="POST">
                                    <input type="hidden" name="txtType" id="txtType" value="<%=sType%>">
                                    <input type="hidden" id="txtlogin" value='<%=sLogin%>' />
                                    <%if sType <> "ACD" and sType <> "DL" then%>
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
                                            <label class="col-sm-2 col-lg-2 control-label">To Date : </label>
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

                                    <%elseif sType = "DL" then %>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Date Range : </label>
                                            <div class="col-sm-3 ">
                                                <select class='form-control' id='selDtPeriod' name='selDtPeriod'>
                                                    <option value=''>Select</option>
                                                <%  Set rstTMMIDMTH = server.CreateObject("ADODB.RecordSet")    
                                                    sSQL = "select * from TMMIDMTH group by FILEDIR order by DTFR desc, DTTO desc "
                                                    rstTMMIDMTH.Open sSQL, conn, 3, 3
                                                    if not rstTMMIDMTH.eof then
                                                        do while not rstTMMIDMTH.eof
                                                            response.write "<option value='" & rstTMMIDMTH("DTFR") & "-" & rstTMMIDMTH("DTTO") & "'>" & rstTMMIDMTH("DTFR") & " - " & rstTMMIDMTH("DTTO") & "</option>" 
                                                        rstTMMIDMTH.movenext
                                                        loop
                                                    end if
                                                %>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Superior : </label>
                                            <div class="col-sm-3">
                                                <div class="input-group">
                                                    <input class="form-control" id="txtSUP_CODE" name="txtSUP_CODE" maxlength="10" style="text-transform: uppercase" >
                                                    <span class="input-group-btn">
                                                        <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default" 
                                                            onclick ="fOpen('SUP','mycontent','#mymodal')">
                                                            <i class="fa fa-search"></i>
                                                        </a>
                                                    </span>
                                                </div>
                                            </div>
                                        
                                            <div class="col-sm-5">
                                                <input class="form-control" id="txtSUP_NAME" name="txtSUP_NAME" READONLY>
                                            </div>
                                        </div>
                                    <%end if %>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employment Contract : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtCont_ID" name="txtCont_ID" maxlength="6" style="text-transform: uppercase" placeholder="All">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('CONT','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>

                                        <label class="col-sm-2 col-lg-2 control-label">Cost Center : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtCost_ID" name="txtCost_ID" maxlength="6" style="text-transform: uppercase"  placeholder="All">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default" 
                                                        onclick ="fOpen('COST','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtID" name="txtID" maxlength="10" style="text-transform: uppercase" placeholder="All">
                                                <span class="input-group-btn">
                                                    <a href="#" name="btnSearchID" class="btn btn-default"
                                                        onclick = "fOpen('SUBORD','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <input class="form-control" id="txtNAME" name="txtNAME" READONLY>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <!--Page Break-->
								    	<label class="col-sm-3 control-label">Page Break : </label>
									    <div class="col-sm-3">
										    <select id="cboPageBreak" name="cboPageBreak" class="form-control">
											    <option value="Y" >Yes</option>
                                                <option value="N" >No</option>
											</select>
									    </div>
                                        
                                        <!--OT select Pending or Approval-->
                                        <%if sType= "OT" then %>
                                            <label class="col-sm-2 control-label">Pending or Approved : </label>
									        <div class="col-sm-3">
										        <select id="selApprvOrPend" name="selApprvOrPend" class="form-control">
											        <option value="P" >Pending</option>
                                                    <option value="A" >Approved</option>
											    </select>
									        </div>
                                        <%elseif sType ="ACD" or sType = "DL" or sType = "LWA" then %>
                                            <label class="col-sm-2 control-label">Work Group : </label>
                                            <div class="col-sm-3">
                                                <div class="input-group">
                                                    <input class="form-control pull-left" id="txtWorkGrp_ID" name="txtWorkGrp_ID" style="text-transform: uppercase" placeholder="All">
                                                    <span class="input-group-btn">
                                                        <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                            onclick ="fOpen('WORKGRP','mycontent','#mymodal')">
                                                            <i class="fa fa-search"></i>
                                                        </a>
                                                    </span>
                                                </div>
                                            </div>
                                        <%end if %>
                                    </div>
                                </form>
                                <div class="box-footer">
									<div class="form-group">
										<div class="col-sm-12" >
                                            <%if sType = "OTX" or sType = "DL" then %>
                                                <button type="button" id="A4" class="btn btn-info pull-left" style="width: 150px;background-color:yellow;color:black;pointer-events: none;border-radius: 0px;">A4 Potrait</button>
										    <%else %>
                                                <button type="button" id="A4" class="btn btn-info pull-left" style="width: 150px;background-color:yellow;color:black;pointer-events: none;border-radius: 0px;">A4 Landscape</button>
										    <%end if%>
                                            <button type="button" name="sub" value="print" class="btn btn-primary pull-right" style="width: 90px" onclick="printReport();">Print</button>
                                            <button type="button" name="sub" value="print" class="btn bg-green-active pull-right" style="width: 100px;margin-right: 5px;" onclick="exportReport()">Export Excel</button>
										</div>
									</div> 
								</div>                             
                            	<!-- /.box-footer -->
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
    });

    $('#btndtpFrDate').click(function () {
        $('#dtpFrDate').datepicker("show");
    });

    $('#btndtpToDate').click(function () {
        $('#dtpToDate').datepicker("show");
    });
        
    //==============================================================

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

    function getValue1or2(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
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
        } else if (pType=="SUP") {
           var search = document.getElementById("txtSearch_sup");
        } else if (pType=="COST") {
           var search = document.getElementById("txtSearch_cost");
        } else if (pType=="CONT") {
           var search = document.getElementById("txtSearch_cont");
        } else if (pType=="WORK") {
            var search = document.getElementById("txtSearch_work");
        } else if (pType=="WORKGRP") {
            var search = document.getElementById("txtSearch_workgrp");
        }
        	  	
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="SUBORD") {
	  	    xhttp.open("GET", "ajax/ax_view_tmsubord.asp?"+str, true);
        } else if (pType=="SUP") {
            xhttp.open("GET", "ajax/ax_view_tmsupid.asp?"+str, true);
        } else if (pType=="COST") {
            xhttp.open("GET", "ajax/ax_view_tmcostid.asp?"+str, true);
        } else if (pType=="CONT") {
            xhttp.open("GET", "ajax/ax_view_tmcontid.asp?"+str, true);
        } else if (pType=="WORK") {
            xhttp.open("GET", "ajax/ax_view_tmworkid.asp?"+str, true);
        } else if (pType=="WORKGRP") {
            xhttp.open("GET", "ajax/ax_view_tmworkgrpid.asp?"+str, true);
        }
	  	
  	    xhttp.send();
    }

    function printReport() {

        var sURL = "";
		sType = Form1.txtType.value;

		sCont_ID = Form1.txtCont_ID.value;
		sCost_ID = Form1.txtCost_ID.value;
		sEmpCode = Form1.txtID.value;	
        sPageBreak = Form1.cboPageBreak.value;
        
        sURL= sURL + "txtContID=" + sCont_ID + "&";
		sURL= sURL + "txtCostID=" + sCost_ID + "&";
		sURL= sURL + "txtEmpCode=" + sEmpCode + "&";
		sURL= sURL + "cboPageBreak=" + sPageBreak + "&"

        if (sType == "ACD"){

            sWorkGrpID = Form1.txtWorkGrp_ID.value;

            sURL= sURL + "txtWorkGrpID=" + sWorkGrpID;

        }else if (sType == "DL") {
            
            sString = Form1.selDtPeriod.value;

            sFrDate = sString.substr(0, sString.indexOf('-'));
    		sToDate = sString.substr(sString.indexOf('-') +1 ); 

            if (sFrDate == "") {
		        alert("Please select Date Range");
		        return false;
		    }

            sURL= sURL + "dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate + "&";
        
        }else{

            sFrDate = Form1.dtpFrDate.value;
		    sToDate = Form1.dtpToDate.value;
            
            sURL= sURL + "dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate + "&";

            if (sFrDate == "") {
		        alert("Please select From Date");
		        return false;
		    }
		    if (sToDate == "") {
		        alert("Please select To Date");
		        return false;
		    }

        }

        if (sType == "DA") {
			
            window.open("tmprint_da.asp?" + sURL, "mswindow","width=1200,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		}

        if (sType == "ABNORM") {
       
            window.open("tmprint_abnorm.asp?" + sURL, "mswindow","width=1200,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		}
		
        if (sType == "OT") {
            
            sApprvOrPend = Form1.selApprvOrPend.value;

            sURL= sURL + "ApprvOrPend=" + sApprvOrPend;
            
			window.open("tmprint_ot.asp?" + sURL, "mswindow","width=1200,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		}

        if (sType == "LED") {
        
			window.open("tmprint_led.asp?" + sURL, "mswindow","width=1200,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		}

        if (sType == "AWL") {

			window.open("tmprint_awl.asp?" + sURL, "mswindow","width=1200,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		}

        if (sType == "ACD") {
        
			window.open("tmprint_acd.asp?" + sURL, "mswindow","width=1200,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		} 

        if (sType == "DL") {
	    
	        sSupCode = Form1.txtSUP_CODE.value;
            sWorkGrpID = Form1.txtWorkGrp_ID.value;

            sURL= sURL + "txtSupCode=" + sSupCode + "&"
            sURL= sURL + "txtWorkGrpID=" + sWorkGrpID;
        
	        window.open("tmprint_dl.asp?" + sURL, "mswindow","width=900,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
	    }

        if (sType == "OTX") {
         	
			window.open("tmprint_otx.asp?" + sURL, "mswindow","width=900,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		}

        if (sType == "LWA") {
	        
            sWorkGrpID = Form1.txtWorkGrp_ID.value;
			
            sURL= sURL + "txtWorkGrpID=" + sWorkGrpID;
    
			window.open("tmprint_lwa.asp?" + sURL, "mswindow","width=1200,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		}

        if (sType == "ALLOW") {
	       
			window.open("tmprint_allow.asp?" + sURL, "mswindow","width=1200,height=900,top=50,left=100,scrollbars=yes,toolbar=no");
		}
    }

    //==== Excel Report ===============================================
    function exportReport() {
 
        var sURL = "";
		sType = Form1.txtType.value;

		sCont_ID = Form1.txtCont_ID.value;
		sCost_ID = Form1.txtCost_ID.value;
		sEmpCode = Form1.txtID.value;	
        
        sURL= sURL + "txtContID=" + sCont_ID + "&";
		sURL= sURL + "txtCostID=" + sCost_ID + "&";
		sURL= sURL + "txtEmpCode=" + sEmpCode + "&";
		
        if (sType == "ACD"){

            sWorkGrpID = Form1.txtWorkGrp_ID.value;

            sURL= sURL + "txtWorkGrpID=" + sWorkGrpID;

        }else if (sType == "DL") {
            
            sString = Form1.selDtPeriod.value;

            sFrDate = sString.substr(0, sString.indexOf('-'));
    		sToDate = sString.substr(sString.indexOf('-') +1 ); 

            if (sFrDate == "") {
		        alert("Please select Date Range");
		        return false;
		    }

            sURL= sURL + "dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate + "&";
        
        }else{

            sFrDate = Form1.dtpFrDate.value;
		    sToDate = Form1.dtpToDate.value;
            
            sURL= sURL + "dtFrDate=" + sFrDate + "&" ;
		    sURL= sURL + "dtToDate=" + sToDate + "&";

            if (sFrDate == "") {
		        alert("Please select From Date");
		        return false;
		    }
		    if (sToDate == "") {
		        alert("Please select To Date");
		        return false;
		    }

        }

        if (sType == "DA") {

			window.open("tmexcel_da.asp?" + sURL);
		}

        if (sType == "ABNORM") {

			window.open("tmexcel_abnorm.asp?" + sURL);
		}

        if (sType == "OT") {

            sApprvOrPend = Form1.selApprvOrPend.value;

            sURL= sURL + "ApprvOrPend=" + sApprvOrPend;

			window.open("tmexcel_ot.asp?" + sURL);
		}

        if (sType == "LED") {

			window.open("tmexcel_led.asp?" + sURL);
		}

        if (sType == "AWL") {
			
			window.open("tmexcel_awl.asp?" + sURL);
		}

        if (sType == "ACD") {
			
			window.open("tmexcel_acd.asp?" + sURL);
		}

		if (sType == "DL") {

	        sSupCode = Form1.txtSUP_CODE.value;
            sWorkGrpID = Form1.txtWorkGrp_ID.value;

            sURL= sURL + "txtSupCode=" + sSupCode + "&"
            sURL= sURL + "txtWorkGrpID=" + sWorkGrpID;

	        window.open("tmexcel_dl.asp?" + sURL);

        }

        if (sType == "OTX") {
           
		    window.open("tmexcel_otx.asp?" + sURL);
        }

        if (sType == "LWA") {

            sWorkGrpID = Form1.txtWorkGrp_ID.value;

		    sURL= sURL + "txtWorkGrpID=" + sWorkGrpID;
			
			window.open("tmexcel_lwa.asp?" + sURL);
		}

        if (sType == "ALLOW") {

            window.open("tmexcel_allow.asp?" + sURL);
        }
	 }  
		
	$( "#txtCost_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtCost_ID").val(ui.item.value);
				var str = document.getElementById("txtCost_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtCost_ID").value = res[0];
			},0);
		}
	});
	
	$( "#txtCont_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CT",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtCont_ID").val(ui.item.value);
				var str = document.getElementById("txtCont_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtCont_ID").value = res[0];
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
	
	$( "#txtSUP_CODE" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=SUPERIOR",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtSUP_CODE").val(ui.item.value);
				var str = document.getElementById("txtSUP_CODE").value;
				var res = str.split(" | ");
				document.getElementById("txtSUP_CODE").value = res[0];
                document.getElementById("txtSUP_NAME").value= res[1];
            },0);
		}
	});

    //=== Any changes except ENTER will clear the NAME field====
    $('#txtSUP_CODE').on('keyup',  function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode != 13 ) {
            $('#txtSUP_NAME').val('');
        }
    });
    </script>

</body>
</html>
