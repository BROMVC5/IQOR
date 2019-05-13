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
    <title>iQOR | Department Details</title>
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
    
    <%
    sDEPT_ID = UCase(request("txtDEPT_ID"))
    
    if sDEPT_ID <> "" then
       sID = sDEPT_ID
    else
       sID = UCase(reqForm("txtID"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "tmdept.asp?"
	
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage &"&txtDEPT_ID=" & sID 
                
    if sModeSub <> "" Then
        
        sPart = reqForm("txtPart")
        sDepManCode = reqForm("txtDepManCode")
        
        if sModeSub = "up" Then
            
            sSQL = "UPDATE TMDEPT SET "             
            sSQL = sSQL & " PART = '" & pRTIN(sPart) & "',"
            sSQL = sSQL & " DEPMAN_CODE = '" & pRTIN(sDepManCode) & "'"
            sSQL = sSQL & " WHERE DEPT_ID = '" & sID & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL)

        elseif sModeSub = "save" Then
            
            sSQL = "insert into TMDEPT (DEPT_ID,PART,DEPMAN_CODE,USER_ID,DATETIME) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		    sSQL = sSQL & "'" & pRTIN(sDepManCode) & "',"		
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
		    conn.execute sSQL
            
		    call confirmBox("Save Successful!", sMainURL&sAddURL)    

         End If 
    End If
          
    Set rstTMDEPT = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMDEPT where DEPT_ID ='" & sID & "'" 
    rstTMDEPT.Open sSQL, conn, 3, 3
        if not rstTMDEPT.eof then
            sPart = rstTMDEPT("PART")
            sDepManCode=rstTMDEPT("DEPMAN_CODE")
        end if
    pCloseTables(rstTMDEPT)
        
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
                <h1>Department Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmdept_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Department Code : </label>
                                        <div class="col-sm-7">
                                            <%if sDEPT_ID <> "" then %>
                                              <span class="mod-form-control"><% response.write sDEPT_ID%> </span>
                                              <input type="hidden" id="txtDept_ID" name="txtID" value='<%=sDEPT_ID%>' />  
                                            <%else%>  
                                              <input class="form-control" id="txtDept_ID" name="txtID" value="<%=sID%>" maxlength="40" style="text-transform: uppercase"/>
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" name="txtPart" value="<%=sPart%>" maxlength="40">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Department Manager : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtDepManCode" name="txtDepManCode" value="<%=sDepManCode%>" maxlength="10" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('EMP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                     <%if sDEPT_ID <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sDEPT_ID%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="check('Up');">Update</button>
                                        <button type="submit" id="btnUp"name="sub" value="up" class="btnSaveHide"></button>
                                    <%else %>
                                        <button type="button" id="btnCheck" name="btnCheck" class="btn btn-primary pull-right"
                                            style="width: 90px" onclick="check('Save');">
                                            Save</button>
                                        <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide">
                                            </button>
                                    <%end if %>
                                </div>
                                <!-- /.box-footer -->

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
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
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
        document.getElementById('txtDept_ID').focus();
        });

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

        if (pType=="EMP") { 
            var search = document.getElementById("txtSearch");
        } 
	  	        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="EMP") {
	  	    xhttp.open("GET", "ajax/ax_view_tmdepmancode.asp?"+str, true);
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

  	    xhttp.open("GET", "tmdept_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    function check(sParam){

        var sSave = "Y"
        
        if (sParam == "Up"){
            var inputData = ['DepManCode'];
        }else if (sParam == "Save"){
            var inputData = ['Dept_ID', 'DepManCode'];
        }
        
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
                        
                        if(res.data.status == "exist"){
                            sSave = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "notexist"){
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
    
        if (sSave == "Y" && sParam == "Save"){
            $('#btnSave').click();
            }else if(sSave == "Y" && sParam == "Up") {
            $('#btnUp').click();
            }
               
    }
    
	$( "#txtDepManCode" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDepManCode").val(ui.item.value);
				var str = document.getElementById("txtDepManCode").value;
				var res = str.split(" | ");
				document.getElementById("txtDepManCode").value = res[0];
			},0);
		}
	});

    $('#txtDept_ID').keyup(function (e) {
    var allowedChars = /^[a-z\d -]+$/i;
    var str = String.fromCharCode(e.charCode || e.which);

    var forbiddenChars = /[^a-z\d -]/gi;
    
    if (forbiddenChars.test(this.value)) {
        this.value = this.value.replace(forbiddenChars, '');
    }

    if (allowedChars.test(str)) {
        return true;
    }

    e.preventDefault();
    return false;
    })
    </script>
</body>
</html>
