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
    <title>iQOR | Shift Code Details</title>
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
    <!-- Bootstrap Color Picker -->
    <link rel="stylesheet" href="plugins/colorpicker/bootstrap-colorpicker.min.css">
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
    
    <%
    sSHF_CODE = request("txtSHF_CODE")
    iPage = request("Page")
    sSearch = request("txtSearch")
           
    if sSHF_CODE <> "" then
        sID = sSHF_CODE
    else
        sID = reqFormU("txtID")
    end if

    sModeSub = request("sub")
    
    sMainURL = "tmshfcode.asp?"
	sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 
    
    if sModeSub <> "" Then
        
        sPart = reqForm("txtPart")
        sWork_ID = reqFormU("txtWork_ID")
        sSTime = reqForm("txtSTime")
        sETime = reqForm("txtETime")
        sShfLen = reqForm("txtShfLen")
        sStatus = reqForm("selStatus")
        sColor = reqForm("txtColor")
 
        if sModeSub = "up" Then
            
            sSQL = "UPDATE TMSHFCODE SET "             
            sSQL = sSQL & "PART = '" & pRTIN(sPart) & "',"
            sSQL = sSQL & "WORK_ID = '" & sWork_ID & "',"
            sSQL = sSQL & "STIME = '" & sSTime & "',"
            sSQL = sSQL & "ETIME = '" & sETime & "',"
            sSQL = sSQL & "SHFLEN = '" & sShfLen & "',"
            sSQL = sSQL & "STATUS = '" & sStatus & "',"
            sSQL = sSQL & "COLOR = '" & sColor & "'"
            sSQL = sSQL & " WHERE SHF_CODE = '" & sID & "'"
            conn.execute sSQL
            
            sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 

            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtSHF_CODE=" & sID & "")

        elseif sModeSub = "save" Then
        
            Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMSHFCODE where SHF_CODE='" & sID & "'" 
            rstTMSHFCODE.Open sSQL, conn, 3, 3
            if not rstTMSHFCODE.eof then
                call alertbox("Shif Code " & sID & " already exist !")
			End if  
            pCloseTables(rstTMSHFCODE)
            
            sSQL = "insert into TMSHFCODE (SHF_CODE,PART,WORK_ID,STIME,ETIME,"
            sSQL = sSQL & " SHFLEN,STATUS,COLOR,USER_ID,DATETIME) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & sID & "',"		
		    sSQL = sSQL & "'" & pRTIN(sPART) & "',"
		    sSQL = sSQL & "'" & sWork_ID & "',"		
		    sSQL = sSQL & "'" & sSTime & "',"
		    sSQL = sSQL & "'" & sETime & "',"		
		    sSQL = sSQL & "'" & sShfLen & "',"
            sSQL = sSQL & "'" & sStatus & "',"
		    sSQL = sSQL & "'" & sColor & "',"		
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
		    conn.execute sSQL
            
            sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 

            call confirmBox("Safe Successful!", sMainURL&sAddURL&"&txtSHF_CODE=" & sID & "")

         End If 
    End If
          
    Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMSHFCODE where SHF_CODE='" & sID & "'"  
    rstTMSHFCODE.Open sSQL, conn, 3, 3
    if not rstTMSHFCODE.eof then
        sPart = rstTMSHFCODE("PART")
        sWork_ID = rstTMSHFCODE("WORK_ID")
        sSTime = rstTMSHFCODE("STIME")
        sETime = rstTMSHFCODE("ETIME")
        sShfLen = rstTMSHFCODE("SHFLEN")
        sStatus = rstTMSHFCODE("STATUS")
        sColor = rstTMSHFCODE("COLOR")
    end if
    pCloseTables(rstTMSHFCODE)

    if sColor = "" then
        sColor = "#000000"
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
                <h1>Shift Code Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmshfcode_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Shift Code : </label>
                                        <div class="col-sm-7">
                                            <div class="input-group">
                                                <%if sSHF_CODE <> "" then %>
                                                    <span class="mod-form-control"><% response.write sSHF_CODE %></span>
                                                    <input type="hidden" id="txtID" name="txtID" value='<%=sSHF_CODE%>' />
                                                <%else%>
                                                    <input class="form-control" id="txtShf_Code" name="txtID" maxlength="6" style="text-transform: uppercase" >
                                                <%end if%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" name="txtPart" value="<%=sPart%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Work Location: </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtWork_ID" name="txtWork_ID" maxlength="6" 
                                                    value="<%=sWork_ID%>" style="text-transform: uppercase">
                                                    <span class="input-group-btn">
                                                        <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                           onclick ="fOpen('WORK','mycontent','#mymodal')">
                                                            <i class="fa fa-search"></i>
                                                        </a>
                                                    </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Start Time : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                 <input id="txtSTime" name="txtSTime" value='<%=sSTime%>' type="text" 
                                                     class="form-control" time-mask onkeyup="sum();">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">End Time : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                 <input id="txtETime" name="txtETime" value='<%=sETime%>' type="text" 
                                                     class="form-control" time-mask onkeyup="sum();">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Shift Length : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group">
                                                 <input id="txtShfLen" name="txtShfLen" value='<%=sShfLen%>' type="text" 
                                                     class="form-control" time-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Status : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <select id="selStatus" name="selStatus" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="A" <%if sStatus = "A" then%>Selected<%end if%>>Active</option>
                                                <option value="S" <%if sStatus = "S" then%>Selected<%end if%>>Suspended</option>
                                                <option value="I" <%if sStatus = "I" then%>Selected<%end if%>>Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Color Code : </label>
                                        <div class="col-sm-5 col-lg-3">
                                            <div class="input-group my-colorpicker2">
                                                 <input id="txtColor" name="txtColor" value='<%=sColor%>' type="text" class="form-control">
                                                    <div class="input-group-addon">
                                                        <i></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
   
                                <div class="box-footer">
                                    <%if sSHF_CODE <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sSHF_CODE%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkWrkLoc();">Update</button>
                                        <button type="submit" id="btnUpdate"name="sub" value="up" class="btnSaveHide"></button>
                                    <%else %>
                                        <button type="button" class="btn btn-primary pull-right" style="width: 90px" onclick="check();">Save</button>
                                        <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide"></button>
                                    <%end if %>
                                </div>
                                <!-- /.box-footer -->
                            </div>
                            <!-- /.box -->
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
    <!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- bootstrap color picker -->
    <script src="plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
    <script src="plugins/input-mask/jquery.mask.js"></script>

    <script>

     //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    $(function () {

        //Time mask
        $("[data-mask]").inputmask();
     
        //color picker with addon
        $(".my-colorpicker2").colorpicker();

    });

    $(document).ready(function(){
        document.getElementById('txtShf_Code').focus();
     }); 

    // Convert a time in hh:mm format to minutes
    function timeToMins(time) {
      var b = time.split(':');
      return b[0]*60 + +b[1];
    }
   //============== This is will take the Shf Length minus the break to get the Work Hours ====
    // Convert minutes to a time in format hh:mm
    // Returned value is in range 00  to 24 hrs
    function timeFromMins(mins) {
      function z(n){return (n<10? '0':'') + n;}
      var h = (mins/60 |0) % 24;
      var m = mins % 60;
      return z(h) + ':' + z(m);
    }

   //  Add two times in hh:mm format
    function addTimes(t0, t1) {
      return timeFromMins(timeToMins(t0) + timeToMins(t1));
    }
    function sum() {
        var txtSTime = document.getElementById('txtSTime').value;
        var txtETime = document.getElementById('txtETime').value;
        
        if (timeToMins(txtETime) >=timeToMins(txtSTime)){
            var TotShfLen = timeFromMins(timeToMins(txtETime)-timeToMins(txtSTime));
        }else{
            var TotShfLen = timeFromMins((1440-timeToMins(txtSTime)) + timeToMins(txtETime)); 
        }
        if (TotShfLen.length==5) {
                document.getElementById('txtShfLen').value = TotShfLen;
            }
        
    }       
   //  ====================================================================================

    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
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

        if (pType=="WORK") { 
            var search = document.getElementById("txtSearch_work");
        } 
	  	        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="WORK") {
	  	    xhttp.open("GET", "ajax/ax_view_tmworkid.asp?"+str, true);
	  	} 
	  	
  	    xhttp.send();
    }
    
    function checkWrkLoc(){

        if ($("#selStatus").val()==''){
            alert(" Please select a Status. ");
            return false;
        }

        if ($("#txtColor").val()==''){
            alert(" Please select a Color Code. ");
            return false;
        }

        var url_to	= 'ajax/ax_notexist.asp';  
        $.ajax({
            url     : url_to,
            type    : 'POST',
            data    : { "txtWhat" : "Work_ID",
                        "txtID":$("#txtWork_ID").val(),
                        }, 
             
            success : function(res){
                 
                if(res.data.status == "notexist"){
                    return alert(res.data.value);
                }else if (res.data.status == "empty"){
                    return alert(res.data.value);
                }else if (res.data.status == "OK") {
                    $('#btnUpdate').click();
                }
            },
            error	: function(error){
                console.log(error);
            }
        });
      
    }
            
    function check(){
        
        if ($("#selStatus").val()==''){
            alert(" Please select a Status. ");
            return false;
        }

        if ($("#txtColor").val()==''){
            alert(" Please select a Color Code. ");
            return false;
        }
        var sSave = "Y"
     
        var inputData = ['Shf_Code', 'Work_ID',];
        
        for (var i = 0; ((i < inputData.length) && sSave == "Y" ); i++) {
               var key = inputData[i];
               var url_to	= 'ajax/ax_exist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtWhat" : key,
                                "txtID":$("#txt"+key).val(),
                              }, 
             
                    success : function(res){
                        
                        if(res.data.status == "notexist"){
                            sSave = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "exist"){
                            sSave = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "empty"){
                            sSave = "N";
                            return alert(res.data.value);
                        }else if (res.data.status == "OK") {
                        }
                   },
                    error	: function(error){
                        console.log(error);
                    }
               });
        }
    
        if (sSave == "Y"){
            $('#btnSave').click();
        }
               
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

  	    xhttp.open("GET", "tmshfcode_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }
	
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
    </script>
</body>
</html>
