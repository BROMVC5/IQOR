<!DOCTYPE html>
<html>
<head>
    <!--#include file="include/clsUpload.asp"-->
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Generate Schedule</title>
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
    <style>
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
		 
        sShfPlan_ID = reqU("txtShfPlan_ID")
        
        if request("btnSave") <> "" then
            
            sEMP_CODE= reqU("txtEMP_CODE")
            dtpFrDate = request("dtpFrDate")
            dtpToDate = request("dtpToDate")
            
            sStart = reqForm("selStart") '=== Week_1 or Week_2 or Week_3
   
            if sEMP_CODE = "" then
				sEMP_CODE = reqFormU("txtID")
            end if
            
            d = 1 '== Day starts from DAY_1, DAY_2, DAY_3...
			
            do while datevalue(dtpFrDate) <= datevalue(dtpToDate)
        
       ' response.write Cint(sStart) & "<br>"

                dtDate =dtpFrDate
					
				Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")
				sSQL = "select TMSHFPLAN.*, TMSHFPLAN.WORKGRP_ID as SHFPLAN_WORKGRP_ID, TMWORKGRP.WORKGRP_ID, TMWORKGRP.HOL_ID,TMWORKGRP.EMP_CODE, TMEMPLY.NAME, TMEMPLY.DT_RESIGN, TMEMPLY.GENSHF "
				sSQL = sSQL & " from TMSHFPLAN left join TMWORKGRP on TMSHFPLAN.WORKGRP_ID = TMWORKGRP.WORKGRP_ID"
				sSQL = sSQL & " left join TMEMPLY on TMWORKGRP.EMP_CODE = TMEMPLY.EMP_CODE"
				sSQL = sSQL & " where TMSHFPLAN.SHFPLAN_ID = '" & sShfPlan_ID & "' "
				if sEMP_CODE <> "" then
					sSQL = sSQL & " and TMWORKGRP.EMP_CODE='" & sEMP_CODE & "'"
				end if
				sSQL = sSQL & " and isnull(DT_RESIGN) "
				sSQL = sSQL & " and GENSHF='Y' "
				sSQL = sSQL & " order by TMWORKGRP.EMP_CODE" 
				rstTMWorkGrp.Open sSQL, conn, 3, 3
				if not rstTMWorkGrp.eof then
					'response.write "Date : " & dtDate & "<br>"
					do while not rstTMWORKGRP.eof	
						
						sWorkGrp_ID = rstTMWorkGrp("WORKGRP_ID")
						sHol_ID = rstTMWorkGrp("HOL_ID")
						sID = rstTMWorkGrp("EMP_CODE")
			
			'response.write sID & "," & sWOrkGrp_ID & "," & sHol_ID & "<br>"
			
						Set rstTMShiftOT = server.CreateObject("ADODB.RecordSet")    
						sSQL = "select * from TMSHIFTOT"
						sSQL = sSQL & " where EMP_CODE='" & sID & "'"
						sSQL = sSQL & " and DT_SHIFT ='" &  fdate2(dtDate) & "'" 
						rstTMShiftOT.Open sSQL, conn, 3, 3
						if rstTMShiftOT.eof then
				   
							Week = "WEEK_" & CInt(sStart) 
						   
							Set rstTMShfPlan = server.CreateObject("ADODB.RecordSet")    
							sSQL = "select * from TMSHFPLAN " 
							sSQL = sSQL & " where SHFPLAN_ID='" & sShfPlan_ID & "'"
							sSQL = sSQL & " and WORKGRP_ID = '" & sWorkGrp_ID & "'"
							rstTMShfPlan.Open sSQL, conn, 3, 3
							if not rstTMShfPlan.eof then
				
								sPattern = rstTMShfPlan("" & Week & "") '=== To get the pattern number like 3, 4, 7... from WEEK_1, WEEK_2, ....
				
								if sPattern = "" then '=== No more records, then start back to Week_1
									sStart = 1
									Week = "WEEK_" & CInt(sStart)
									sPattern = rstTMShfPlan("" & Week & "")
								end if
							  
								Set rstTMShfPat = server.CreateObject("ADODB.RecordSet")    
								sSQL = "select * from TMSHFPAT"
								sSQL = sSQL & " where SHFPAT_ID='" & rstTMShfPlan("SHFPAT_ID") & "'" '=== The PAT_ID attached to ShiftPlan
								sSQL = sSQL & " and PATTERN ='" &  sPattern & "'"  '=== if pattern starts at 3, then take day 1
								rstTMShfPat.Open sSQL, conn, 3, 3
								if not rstTMShfPat.eof then
									sDay = "DAY_" & d
									sShf_Code = rstTMShfPat("" & sDay & "" )
				
									sSQL = "insert into TMSHIFTOT (EMP_CODE,DT_SHIFT,SHF_CODE,HOL_ID,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
									sSQL = sSQL & "values ("
									sSQL = sSQL & "'" & sID & "',"		
									sSQL = sSQL & "'" & fdate2(dtDate) & "',"
									sSQL = sSQL & "'" & sShf_Code & "',"
									sSQL = sSQL & "'" & sHol_ID & "',"
									sSQL = sSQL & "'" & session("USERNAME") & "'," 
									sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
									sSQL = sSQL & "'" & session("USERNAME") & "'," 
									sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
									sSQL = sSQL & ") "
			   'response.write "Insert  " & sSQL & "<br>"
									conn.execute sSQL
								else
					 
									'alertBox("Work Group ID : " & sWorkGrp_ID & " with Shift Plan ID : " & sShfPlan_ID & " does have a Work Group! ")     
										
								end if
								
							else
				
								alertBox("Work Group ID : " & sWorkGrp_ID & " with Shift Plan ID : " & sShfPlan_ID & " does have a Work Group! ")     
									
							end if
							

						else
				
							Week = "WEEK_" & CInt(sStart) 

						  'response.write " Update what is the week" & Week & "<br>"
							  
							Set rstTMShfPlan = server.CreateObject("ADODB.RecordSet")    
							sSQL = "select * from TMSHFPLAN " 
							sSQL = sSQL & " where SHFPLAN_ID='" & sShfPlan_ID & "'"
							sSQL = sSQL & " and WORKGRP_ID = '" & sWorkGrp_ID & "'"
							rstTMShfPlan.Open sSQL, conn, 3, 3
							if not rstTMShfPlan.eof then
									
								sPattern = rstTMShfPlan("" & Week & "") '=== To get the pattern number like 3, 4, 7... from WEEK_1, WEEK_2, ....
								
								if sPattern = "" then '=== No more records, then start back to Week_1
									sStart = 1
									Week = "WEEK_" & CInt(sStart)
									sPattern = rstTMShfPlan("" & Week & "")
								end if
								
								Set rstTMShfPat = server.CreateObject("ADODB.RecordSet")    
								sSQL = "select * from TMSHFPAT"
								sSQL = sSQL & " where SHFPAT_ID='" & rstTMShfPlan("SHFPAT_ID") & "'" '=== The PAT_ID attached to ShiftPlan
								sSQL = sSQL & " and PATTERN ='" &  sPattern & "'"  '=== if pattern starts at 3, then take day 1
								rstTMShfPat.Open sSQL, conn, 3, 3
								if not rstTMShfPat.eof then
											
									sDay = "DAY_" & d
									sShf_Code = rstTMShfPat("" & sDay & "" )

									sSQL = "UPDATE TMSHIFTOT set "
									sSQL = sSQL & " SHF_CODE='" & sShf_Code & "',"
									sSQL = sSQL & " HOL_ID='" & sHol_ID & "',"
									sSQL = sSQL & " USER_ID='" & session("USERNAME") & "'," 
									sSQL = sSQL & " DATETIME='" & fdatetime2(Now()) & "'"
									sSQL = sSQL & " where EMP_CODE ='" & sID & "'" 
									sSQL = sSQL & " and DT_SHIFT='" & fdate2(dtDate) & "'"

			   ' response.write "Update : " & sSQL & "<br>"
									conn.execute sSQL

								else
									'alertBox("Work Group ID : " & sWorkGrp_ID & " with Shift Plan ID : " & sShfPlan_ID & " does have a Work Group! ")     
										
								end if
								
							end if

						end if
					
					rstTMWORKGRP.movenext
					loop
				
				end if
					
				if Cint(sStart) mod 6 = 0 then '=== Week 1 - 6, after Week 6 goes back to 1
					sStart = 1 
				end if 

				if Cint(d) mod 7 = 0 then '=== After days = 7, 1 week
					d= 1  '=== days start back at 1
					sStart = Cint(sStart) + 1 '=== After 7 days, Week will add 1
				else  '==== Not one week yet
					d = d + 1  '=== Days + 1
				end if

				dtpFrDate = DateAdd("d",1,datevalue(dtpFrDate))

            loop
		
		'response.End
			if sEMP_CODE <> "" then
				call confirmbox("Employee : " & sID & " in Work Group : " & sWorkGrp_ID & " Generated Shift Schedule : " & sShfPlan_ID & " Successfully ", "tmgenshf.asp")
			else
				call confirmbox("All Employee in Work Group : " & sWorkGrp_ID & " Generated Shift Schedule : " & sShfPlan_ID & " Successfully ", "tmgenshf.asp")
			end if
	
        end if '=== End if btnSubmit
    %>
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <% if sShdPlan_ID <> "" then %>
    <script>   
         $(document).ready(function(){
            showContent('<%=sShdPlan_ID%>');
        });
    </script>
    <%end if %>
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
                <h1>Generate Schedule<h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmgenshf.asp" method="post">
                            <div class="box box-info">
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform:uppercase" placeholder='ALL'>
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
                                        <label class="col-sm-3 control-label">Shift Plan : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtShfPlan_ID" name="txtShfPlan_ID" value="<%=sShdPlan_ID%>" maxlength="30" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('SHFPLAN','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
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
                                        <label class="col-sm-3 col-lg-3 control-label" style="width:100px">To Date : </label>
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
                                    
                                    <div id ="content2">
                                        <!-- Display Content here -->
                                    </div>
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
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->
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

    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    function turnon(){
        document.getElementById("loader-wrapper").style.display = "";
    }

    $(document).ready(function(){
      $('[date-picker]').mask('00/00/0000');
    });

    $('#btndtpFrDate').click(function () {
        $('#dtpFrDate').datepicker("show");
        });

    $('#btndtpToDate').click(function () {
        $('#dtpToDate').datepicker("show");
        }); 
           
    $(function () {
        //Date picker
        $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            }).datepicker("setDate", new Date());
    });
    
     function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValueShfPlanID(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
        
        $(function () {showContent(svalue)}); //***===== On get value call showContent function ===****
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

        if (pType=="SHFPLAN") { 
            var search = document.getElementById("txtSearch_shfplan");
        }else if (pType=="SUBORD") { 
            var search = document.getElementById("txtSearch_subord");
        } 
	  	
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="SHFPLAN") {
	  	    xhttp.open("GET", "ajax/ax_view_tmshfplanid.asp?"+str, true);
	  	}else if (pType=="SUBORD") {
	  	    xhttp.open("GET", "ajax/ax_view_tmsubord.asp?"+str, true);
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
  	
        str1 = "txtSHFPLAN_ID=" + str;
  	    xhttp.open("GET", "ajax/ax_tmshfplangen.asp?"+str1, true);
  	    xhttp.send();
    }

    function check(){

        var sGenerate = "Y";
        
        //======= Employee ID is empty means all but check if it is valid.======
        if ($('#dtpFrDate').val() == '' ){
            alert('Date From cannot be empty');
            return false;

        }else if ($('#dtpToDate').val() == '' ){
            alert('Date To cannot be empty');
            return false;
        
        }else if($('#selStart').val() == null){
            
            alert('Please select Pattern Start From');
            return false;
        }else if ($('#txtID').val() != ''){
            
            var url_to	= 'ajax/ax_notexist.asp';  
            
            $.ajax({

            url     :   url_to,
            type    :   'POST',
            async   : false,
            data    :   { 
                        "txtWhat" : "EMP",
                        "txtID":$("#txtID").val(),
                        }, 
             
            success :   function(res){
                 
                            if(res.data.status == "notexist"){
                                sGenerate = "N"
                                return alert(res.data.value);
                            }else if (res.data.status == "OK") {
                                sGenerate = "Y"    
                            }
                        },

            error	:   function(error){
                            console.log(error);
                        }
            });
        
        }

        
            if (sGenerate == "Y"){
                turnon();
                $('#btnSave').click();
            }
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

	$( "#txtShfPlan_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=SHP",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtShfPlan_ID").val(ui.item.value);
				var str = document.getElementById("txtShfPlan_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtShfPlan_ID").value = res[0];
                $(function () {showContent(res[0])}); //***===== On get value call showContent function ===****
			},0);
		}
	});
	
    </script>
</body>
</html>
