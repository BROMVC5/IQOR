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
    <title>iQOR | Grade Details</title>
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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" />
    
    <%
    sGrade_ID = UCase(request("txtGrade_ID"))
    
    if sGrade_ID <> "" then
       sID = sGrade_ID
    else
       sID = UCase(reqForm("txtID"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "tmgrade.asp?"
	
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 
                
    if sModeSub <> "" Then

        sPart = reqForm("txtPart")
        sShfAll = reqForm("selShfAll")
        sOT = reqForm("selOT")
        sMidMth = reqForm("selMidMth")
        sMthEnd = reqForm("selMthEnd")
        
        if sModeSub = "up" Then
            
            sSQL = "UPDATE TMGRADE SET "             
            sSQL = sSQL & " PART = '" & pRTIN(sPart) & "',"
            sSQL = sSQL & " SHFALL = '" & sShfAll & "',"
            sSQL = sSQL & " OT = '" & sOT & "',"
            sSQL = sSQL & " MIDMTH = '" & sMidMth & "',"
            sSQL = sSQL & " MTHEND = '" & sMthEnd & "',"
            sSQL = sSQL & " USER_ID = '" & session("USERNAME") & "',"
            sSQL = sSQL & " DATETIME = '" & fdatetime2(Now()) & "'"
            sSQL = sSQL & " WHERE GRADE_ID = '" & sID & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtGrade_ID=" & sID & "")

        elseif sModeSub = "save" Then
            
            sSQL = "insert into TMGRADE (GRADE_ID,PART,SHFALL,OT,MIDMTH,MTHEND,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sPart) & "',"
            sSQL = sSQL & "'" & sShfAll & "',"
            sSQL = sSQL & "'" & sOT & "',"
            sSQL = sSQL & "'" & sMidMth & "',"
            sSQL = sSQL & "'" & sMthEnd & "',"
            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
		    conn.execute sSQL
            
		    call confirmBox("Save Successful!", sMainURL&sAddURL&"&txtGrade_ID=" & sID & "")    

         End If 
    End If
          
    Set rstTMGrade = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMGRADE where GRADE_ID ='" & sID & "'" 
    rstTMGrade.Open sSQL, conn, 3, 3
        if not rstTMGrade.eof then
            sShfAll = rstTMGrade("ShfAll")
            sOT = rstTMGrade("OT")
            sMidMth = rstTMGrade("MidMth")
            sMthEnd = rstTMGrade("MthEnd")
            sPart = rstTMGrade("PART")
        end if
    pCloseTables(rstTMGrade)
        
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
                <h1>Grade Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmgrade_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Grade Code : </label>
                                        <div class="col-sm-7">
                                            <%if sGrade_ID <> "" then %>
                                                <span class="mod-form-control"><% response.write sGrade_ID%> </span>
                                                <input type="hidden" id="txtID" name="txtID" value='<%=sGrade_ID%>' />
                                            <%else%>  
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="6" style="text-transform: uppercase"/>
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" name="txtPart" value="<%=sPart%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class ="form-group">
                                        <label class="col-sm-3 col-lg-3 control-label">Process OT : </label>
                                        <div class="col-sm-2">
                                            <select id="selOT" name="selOT" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="Y" <%if sOT = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sOT = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class ="form-group">
                                        <label class="col-sm-3 col-lg-3 control-label">Shift Allowance : </label>
                                        <div class="col-sm-2">
                                            <select id="selShfAll" name="selShfAll" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="Y" <%if sShfAll = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sShfAll = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class ="form-group">
                                        <label class="col-sm-3 col-lg-3 control-label">Mid End Process : </label>
                                        <div class="col-sm-2">
                                            <select id="selMidMth" name="selMidMth" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="Y" <%if sMidMth = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sMidMth = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class ="form-group">
                                        <label class="col-sm-3 col-lg-3 control-label">Month End Process : </label>
                                        <div class="col-sm-2">
                                            <select id="selMthEnd" name="selMthEnd" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="Y" <%if sMthEnd = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sMthEnd = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sGrade_ID <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                        onclick ="fDel('<%=sGrade_ID%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="submit" id="btnUp" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                    <%else %>
                                        <button type="button" class="btn btn-primary pull-right" style="width: 90px" onclick="check('GRADE');">Save</button>
                                        <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide"></button>
                                    <%end if %>
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
                        </form>
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

    function check(pWhat){
        
    if($('#txtID').val() == ''){
        alert('Grade Code cannot be empty');
        return false;
        }else{
                
            var url_to	= 'ajax/ax_exist.asp';  
            
            $.ajax({

            url     :   url_to,
            type    :   'POST',
            data    :   { 
                        "txtWhat" : pWhat,
                        "txtID":$("#txtID").val(),
                        }, 
             
            success :   function(res){
                 
                            if(res.data.status == "exist"){
                                return alert(res.data.value);
                            }else if (res.data.status == "OK") {
                                $('#btnSave').click();    
                            }
                        },

            error	:   function(error){
                            console.log(error);
                        }
            });
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


  	    xhttp.open("GET", "tmgrade_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtID').focus();
        }); 

    $('#txtID').keyup(function (e) {
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
