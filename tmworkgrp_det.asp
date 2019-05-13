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
    <title>iQOR | Work Group Details</title>
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
    sWorkGrp_ID = UCase(request("txtWorkGrp_ID"))
    sSearch = request("txtSearch")
    iPage = request("Page")
    
    if sWorkGrp_ID <> "" then
       sID = sWorkGrp_ID
    else
       sID = UCase(reqForm("txtID"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "tmworkgrp.asp?"
	
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 
                
    if sModeSub <> "" Then
        
        sPart = reqForm("txtPart")
        sHol_ID = reqForm("txtHol_ID")
        
        if sModeSub = "up" Then
            
            sSQL = "delete from TMWORKGRP where WORKGRP_ID = '" & sID & "'"
            conn.execute sSQL 
            
            arr=Split(request("ToLB"),",")    
            
            For i = 0 to Ubound(arr)
                sEMP_CODE = arr(i)
                
                Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMWORKGRP where EMP_CODE ='" & sEMP_CODE & "'" 
                rstTMWorkGrp.Open sSQL, conn, 3, 3
                if not rstTMWorkGrp.eof then
                    call alertbox("Employee " & sEMP_CODE & " already exist in another Work Group !")
			    Else
                    sSQL = "insert into TMWORKGRP (WORKGRP_ID,PART,HOL_ID,EMP_CODE,USER_ID,DATETIME) "
		            sSQL = sSQL & "values ("
		            sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		            sSQL = sSQL & "'" & pRTIN(sPart) & "',"
                    sSQL = sSQL & "'" & pRTIN(sHol_ID) & "',"
                    sSQL = sSQL & "'" & trim(sEMP_CODE) & "',"		
		            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
                    conn.execute sSQL
                end if
            Next
                
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtWorkGrp_ID=" & sID & "")

        elseif sModeSub = "save" Then
            
            arr=Split(request("ToLB"),",")
            
             For i = 0 to Ubound(arr)
                sEMP_CODE = arr(i)

                Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMWORKGRP where EMP_CODE ='" & sEMP_CODE & "'" 
                rstTMWorkGrp.Open sSQL, conn, 3, 3
                if not rstTMWorkGrp.eof then
                    call alertbox("Employee" & sEMP_CODE & " already exist in another Work Group !")
			    Else
                    sSQL = "insert into TMWORKGRP (WORKGRP_ID,PART,HOL_ID,EMP_CODE,USER_ID,DATETIME) "
		            sSQL = sSQL & "values ("
		            sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		            sSQL = sSQL & "'" & pRTIN(sPart) & "',"
                    sSQL = sSQL & "'" & pRTIN(sHol_ID) & "',"
		            sSQL = sSQL & "'" & Trim(sEMP_CODE) & "',"		
		            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
		            conn.execute sSQL      
                End if  
                pCloseTables(rstTMWorkGrp)
        
            Next
            call confirmBox("Save Successful!", sMainURL&sAddURL&"&txtWorkGrp_ID=" & sID & "")    

         End If 
    End If
    
    function ShowUnassign(sParam)
 	Set rs=server.CreateObject("ADODB.Recordset")
 	sql="Select * from TMEMPLY "
 	sql=sql & "order by EMP_CODE"
 	rs.open sql, conn
    if not rs.eof then 'To check is it is New or Edit mode

        do while not rs.eof  'if Edit mode, only the non-selected unassign will display
                
                bflag=true
                
                Set rsSelected=server.CreateObject("ADODB.Recordset") 'This record will pull all the selected employess
 	            sql="Select * from tmworkgrp "
 	           ' sql = sql & " where workgrp_id = '" & sParam & "'"
                sql = sql & " order by workgrp_id"
                
                rsSelected.open sql, conn
                    do while not rsSelected.eof 
                    
                        if rs("EMP_CODE") = rsSelected("EMP_CODE") then
                            bflag= false  
                            exit do
                        end if
                        rsSelected.movenext
                    loop
                
                if bflag = true then

                    Set rstName = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select Name from TMEMPLY where EMP_CODE ='" & rs("EMP_CODE") & "'" 
                    rstName.Open sSQL, conn, 3, 3
                    if not rstName.eof then
                        sName = rstName("Name")
                    end if
                    pCloseTables(rstName) 

                    response.write "<option value='" & rs("EMP_CODE") & "'>" & rs("EMP_CODE") & " - " & sName & "</option>"
                end if    
                         
           rs.movenext 
       loop
       
    end if
    pCloseTables(rs)
    end function      
    
    Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMWORKGRP where WORKGRP_ID ='" & sID & "'" 
    rstTMWorkGrp.Open sSQL, conn, 3, 3
        if not rstTMWorkGrp.eof then
            sPart = rstTMWorkGrp("PART")
            sHol_ID = rstTMWorkGrp("HOL_ID")
        end if
    pCloseTables(rstTMWorkGrp)
        
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
                <h1>Work Group Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmworkgrp_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Work Group: </label>
                                        <div class="col-sm-7">
                                            <%if sWorkGrp_ID <> "" then %>
                                                <span class="mod-form-control"><% response.write sWorkGrp_ID%> </span>
                                                <input type="hidden" id="txtID" name="txtID" value='<%=sWorkGrp_ID%>' />
                                            <%else%>
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="30" style="text-transform: uppercase" />
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Description : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" name="txtPart" value="<%=sPart%>" maxlength="30">
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
                                </div>
                                <div>
                                    <table id="example1">
                                        <tbody>
                                            <tr>
                                                <td width="8%"></td>
                                                <td width="5%"><b>Unassigned Employee :</b>
                                                <td width="4%" align="center">
                                                <td width="30%"><b>Assigned Employee :</b>
                                            </tr>
                                            <tr>
                                                <td>&nbsp</td>
                                                <td>
                                                    <select multiple size="15" style="width: 405px;" name="FromLB" id="FromLB" ondblclick="move(this.form.FromLB,this.form.ToLB)">
                                                        <%  
                                                                ShowUnassign(sWorkGrp_ID)
                                                        %>
                                                    </select>
                                                </td>
                                                <td>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="moveAll(this.form.FromLB, this.form.ToLB)" value="   >>   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="move(this.form.FromLB, this.form.ToLB)" value="   >   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="move(this.form.ToLB, this.form.FromLB)" value="   <   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="moveAll(this.form.ToLB, this.form.FromLB)" value="   <<   ">
                                                </td>
                                                <td>
                                                    <select multiple size="15" style="width: 405px;" name="ToLB" id="ToLB" ondblclick="move(this.form.ToLB,this.form.FromLB)">
                                                        <%  Set rstSelect = server.CreateObject("ADODB.RecordSet")    
                                                                sSQL = "select * from TMWORKGRP where WORKGRP_ID ='" & sID & "'" 
                                                                rstSelect.Open sSQL, conn, 3, 3
                                                                
                                                                do while not rstSelect.eof 
                                                                    
                                                                    Set rstName = server.CreateObject("ADODB.RecordSet")    
                                                                    sSQL = "select Name from TMEMPLY where EMP_CODE ='" & rstSelect("EMP_CODE") & "'" 
                                                                    rstName.Open sSQL, conn, 3, 3
                                                                    if not rstName.eof then
                                                                        sName = rstName("Name")
                                                                    end if        
                                                                    pCloseTables(rstName)

                                                                    response.write "<option value='" & rstSelect("EMP_CODE") & "'>" & rstSelect("EMP_CODE") & " - " & sName & "</option>"  
                                                                    rstSelect.movenext
                                                                loop
                                                             
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="box-footer">
                                    <%if sWorkGrp_ID <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                        onclick ="fDel('<%=sWorkGrp_ID%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkEmpty();">Update</button>
                                        <button type="submit" id="btnUp" name="sub" value="up" class="btnSaveHide"></button>
                                    <%else %>
                                        <button type="button" id="btnCheck" name="btnCheck" class="btn btn-primary pull-right"
                                            style="width: 90px" onclick="check('WORKGRP');">Save</button>
                                        <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide"></button>
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

  	    xhttp.open("GET", "tmworkgrp_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }
    

    function move(tbFrom, tbTo) {
	 	var arrFrom = new Array(); var arrTo = new Array(); 
	 	var arrLU = new Array();
	 	var i;
	 	for (i = 0; i < tbTo.options.length; i++) {
	  		arrLU[tbTo.options[i].text] = tbTo.options[i].value;
	  		arrTo[i] = tbTo.options[i].text;
	 	}
	 	var fLength = 0;
	 	var tLength = arrTo.length;
	 	for(i = 0; i < tbFrom.options.length; i++) {
	  		arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;
	  		if (tbFrom.options[i].selected && tbFrom.options[i].value != "") {
	   			arrTo[tLength] = tbFrom.options[i].text;
	   			tLength++;
	  		} else {
				arrFrom[fLength] = tbFrom.options[i].text;
	   			fLength++;
	  		}
		}
	
		tbFrom.length = 0;
		tbTo.length = 0;
		var ii;
	
		for(ii = 0; ii < arrFrom.length; ii++) {
	  		var no = new Option();
	  		no.value = arrLU[arrFrom[ii]];
	  		no.text = arrFrom[ii];
	        tbFrom[ii] = no;

		}
	
		for(ii = 0; ii < arrTo.length; ii++) {
	 		var no = new Option();
	 		no.value = arrLU[arrTo[ii]];
	 		no.text = arrTo[ii];
     		tbTo[ii] = no;
		}
	}

    function moveAll(tbFrom, tbTo) {
	    var arrFrom = new Array(); var arrTo = new Array(); 
	    var arrLU = new Array();
	    var i;
	    for (i = 0; i < tbTo.options.length; i++) {
	  	    arrLU[tbTo.options[i].text] = tbTo.options[i].value;
	  	    arrTo[i] = tbTo.options[i].text;
	    }
	    var fLength = 0;
	    var tLength = arrTo.length;
	    for(i = 0; i < tbFrom.options.length; i++) {
	  	    arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;
	  	    arrTo[tLength] = tbFrom.options[i].text;
	   	    tLength++;
	    }
	
	
	    tbFrom.length = 0;
	    tbTo.length = 0;
	    var ii;
	
	    for(ii = 0; ii < arrFrom.length; ii++) {
	  	    var no = new Option();
	  	    no.value = arrLU[arrFrom[ii]];
	  	    no.text = arrFrom[ii];
	        tbFrom[ii] = no;
	
	    }
	
	    for(ii = 0; ii < arrTo.length; ii++) {
	 	    var no = new Option();
	 	    no.value = arrLU[arrTo[ii]];
	 	    no.text = arrTo[ii];
	 	    tbTo[ii] = no;
	    }
    }

    function check(pWhat){
        
        $('#ToLB').each(function () {
            $('#ToLB option').attr("selected", "selected");
            });

        if($('#txtID').val() == ''){
            alert('Work Group cannot be empty');
            }else{

                if($('#txtHol_ID').val() == ''){
                   alert('Holiday Group cannot be Empty');
                    return false;
                }

                if($('#ToLB').val() == null){
                   alert('Assigned Employee cannot be Empty');
                    return false;
                }
                
                var url_to	= 'ajax/ax_exist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    data    : { "txtWhat" : pWhat,
                                "txtID":$("#txtID").val(),
                                "txtHolID":$("#txtHol_ID").val(),
                              }, 
             
                    success : function(res){
                 
                        if(res.data.status == "exist"){
                            return alert(res.data.value);
                        }else if (res.data.status == "notexist") {
                            return alert(res.data.value);
                        }else if (res.data.status == "OK") {
                            $('#btnSave').click();    
                        }
                    },
                    error	: function(error){
                        console.log(error);
                    }
                });
        }
    }

    function checkEmpty(){
        
        $('#ToLB').each(function () {
            $('#ToLB option').attr("selected", "selected");
            });

        if($('#ToLB').val() == null){
            if (confirm("Assigned Employee is empty. This will delete the Work Group : <%=sID %> " )){
                $('#btnUp').click();
            }else{
                return false;
            }
        }else{

            if($('#txtHol_ID').val() == ''){
                   alert('Holiday Group cannot be Empty');
                    return false;
                }

             var url_to	= 'ajax/ax_notexist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtWhat" : "Hol_ID",
                                "txtID":$("#txtHol_ID").val(),
                                }, 
             
                    success : function(res){
                        
                        if(res.data.status == "notexist"){
                            return alert(res.data.value);
                        }else if (res.data.status == "OK") {
                            $('#btnUp').click();    
                        }
                    },
                    error	: function(error){
                        console.log(error);
                    }
                });
           
        }
    }

    $(document).ready(function(){
    document.getElementById('txtID').focus();
        }); 
    
    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue1(svalue, pFldName) {
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

        if (pType=="HOL") {
            var search = document.getElementById("txtSearch_hol");
        }
         	  	
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="HOL") {
            xhttp.open("GET", "ajax/ax_view_tmholid.asp?"+str, true);
        } 
  	    xhttp.send();
    }
	
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

    $('#txtID').keyup(function (e) {
    var allowedChars = /^[a-z\d _ -]+$/i;
    var str = String.fromCharCode(e.charCode || e.which);

    var forbiddenChars = /[^a-z\d _ -]/gi;
    
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
