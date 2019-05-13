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
    <title>iQOR | Overtime Code Details</title>
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
    sOTCode = UCase(request("txtOTCode"))
    sSearch = request("txtSearch")
    iPage = request("Page")
    
    if sOTCode <> "" then
       sID = sOTCode
    else
       sID = UCase(reqForm("txtID"))
    end if

    sModeSub = request("sub")
    
    sMainURL = "tmotcode.asp?"
	
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage & "&txtOTCode=" & sID
                
    if sModeSub <> "" Then
        
        sPart = reqForm("txtPart")
        sNormalCode = reqForm("txtNormalCode")
        sRestCode = reqForm("txtRestCode")
        sOffCode = reqForm("txtOffCode")
        sPublicCode = reqForm("txtPublicCode")
        sNormal = reqForm("txtNormal")
        sRest = reqForm("txtRest")
        sOff = reqForm("txtOff")
        sPublic = reqForm("txtPublic")

        if sModeSub = "up" Then
            
            sSQL = "delete from TMOTCODE where OTCODE = '" & sID & "'"
            conn.execute sSQL 
            
            arr=Split(request("ToLB"),",")    
            
            For i = 0 to Ubound(arr)
                sGrade_ID = trim(arr(i))
                
                Set rstTMOTCODE = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMOTCODE where GRADE_ID ='" & sGrade_ID & "'" 
                rstTMOTCODE.Open sSQL, conn, 3, 3
                if not rstTMOTCODE.eof then
                    call alertbox("Grade " & sGrade_ID & " already exist in another OT Code !")
			    Else
                    sSQL = "insert into TMOTCODE (OTCODE,PART,NORMALCODE,RESTCODE,OFFCODE,PUBLICCODE,NORMAL,REST,OFF,PUBLIC,GRADE_ID,USER_ID,DATETIME,CREATE_ID, DT_CREATE) "
		            sSQL = sSQL & "values ("
		            sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		            sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		            sSQL = sSQL & "'" & sNormalCode & "',"		
		            sSQL = sSQL & "'" & sRestCode & "',"		
		            sSQL = sSQL & "'" & sOffCode & "',"		
		            sSQL = sSQL & "'" & sPublicCode & "',"	
                    sSQL = sSQL & "'" & sNormal & "',"		
		            sSQL = sSQL & "'" & sRest & "',"		
		            sSQL = sSQL & "'" & sOff & "',"		
		            sSQL = sSQL & "'" & sPublic & "',"		
		            sSQL = sSQL & "'" & pRTIN(sGrade_ID) & "',"		
		            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
                    conn.execute sSQL
                end if
            Next
                
            call confirmBox("Update Successful!", sMainURL&sAddURL)

        elseif sModeSub = "save" Then
            
            arr=Split(request("ToLB"),",")
            
             For i = 0 to Ubound(arr)

                sGrade_ID = arr(i)
                
                Set rstTMOTCODE = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMOTCODE where GRADE_ID ='" & sGrade_ID & "'" 
                rstTMOTCODE.Open sSQL, conn, 3, 3
                if not rstTMOTCODE.eof then
                    call alertbox("Grade " & sGrade_ID & " already exist in another OT Code !")
			    Else
                    sSQL = "insert into TMOTCODE (OTCODE,PART,NORMALCODE,RESTCODE,OFFCODE,PUBLICCODE,NORMAL,REST,OFF,PUBLIC,GRADE_ID,USER_ID,DATETIME,CREATE_ID, DT_CREATE) "
		            sSQL = sSQL & "values ("
		            sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		            sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		            sSQL = sSQL & "'" & sNormalCode & "',"		
		            sSQL = sSQL & "'" & sRestCode & "',"		
		            sSQL = sSQL & "'" & sOffCode & "',"		
		            sSQL = sSQL & "'" & sPublicCode & "',"		
		            sSQL = sSQL & "'" & sNormal & "',"		
		            sSQL = sSQL & "'" & sRest & "',"		
		            sSQL = sSQL & "'" & sOff & "',"		
		            sSQL = sSQL & "'" & sPublic & "',"		
		            sSQL = sSQL & "'" & trim(pRTIN(sGrade_ID)) & "',"		
		            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
                    conn.execute sSQL
                end if
        
            Next
            call confirmBox("Save Successful!", sMainURL&sAddURL)    

         End If 
    End If
    
    function ShowUnassign(sParam)
 	Set rs=server.CreateObject("ADODB.Recordset")
 	sql="Select * from TMGRADE "
 	sql=sql & "order by GRADE_ID"
 	rs.open sql, conn
    if not rs.eof then 'To check is it is New or Edit mode

        do while not rs.eof  'if Edit mode, only the non-selected unassign will display
                
                bflag=true
                
                Set rsSelected=server.CreateObject("ADODB.Recordset") 'This record will pull all the selected 
 	            sql="Select * from tmotcode "
 	            sql = sql & " order by otcode"
                rsSelected.open sql, conn
                    do while not rsSelected.eof 
                    
                        if rs("GRADE_ID") = rsSelected("GRADE_ID") then
                            bflag= false  
                            exit do
                        end if
                        rsSelected.movenext
                    loop
                
                if bflag = true then

                    Set rstGrade = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select PART from TMGRADE where GRADE_ID ='" & rs("GRADE_ID") & "'" 
                    rstGrade.Open sSQL, conn, 3, 3
                    if not rstGrade.eof then
                        sPart = rstGrade("PART")
                    end if
                    pCloseTables(rstGrade) 

                    response.write "<option value='" & rs("GRADE_ID") & "'>" & rs("GRADE_ID") & " - " & sPart & "</option>"
                end if    
                         
           rs.movenext 
       loop
       
    end if
    pCloseTables(rs)
    end function      
    
    Set rstTMOTCODE = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMOTCODE where OTCODE ='" & sID & "'" 
    rstTMOTCODE.Open sSQL, conn, 3, 3
    if not rstTMOTCODE.eof then
        sPart = rstTMOTCODE("PART")
        sNormalCode = rstTMOTCODE("NORMALCODE")
        sRestCode = rstTMOTCODE("RESTCODE")
        sOffCode = rstTMOTCODE("OFFCODE")
        sPublicCode = rstTMOTCODE("PUBLICCODE")
        sNormal = rstTMOTCODE("NORMAL")
        sRest = rstTMOTCODE("REST")
        sOff = rstTMOTCODE("OFF")
        sPublic = rstTMOTCODE("PUBLIC")

    else
        sNormalCode = "1110"
        sRestCode = "1130"
        sOffCode = "1120"
        sPublicCode = "1140"
    end if
    pCloseTables(rstTMOTCODE)

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
                <h1>Overtime Code Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmotcode_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">OT Code : </label>
                                        <div class="col-sm-6">
                                            <%if sOTCode <> "" then %>
                                                <span class="mod-form-control"><% response.write sOTCode %> </span>
                                                <input type="hidden" id="txtID" name="txtID" value='<%=sOTCode%>' />
                                            <%else%>
                                                <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="6" style="text-transform: uppercase"/>
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Description : </label>
                                        <div class="col-sm-6">
                                            <input class="form-control" name="txtPart" value="<%=sPart%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Normal Day Code : </label>
                                        <div class="col-sm-6">
                                            <label class="col-sm-1 control-label"><%=sNormalCode %></label>
                                            <input type="hidden" class="form-control" name="txtNormalCode" value="<%=sNormalCode%>" maxlength="10">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Off Day Code : </label>
                                        <div class="col-sm-6">
                                            <label class="col-sm-1 control-label"><%=sOffCode %></label>
                                            <input type="hidden" class="form-control" name="txtOffCode" value="<%=sOffCode%>" maxlength="10">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Rest Day Code : </label>
                                        <div class="col-sm-6">
                                            <label class="col-sm-1 control-label"><%=sRestCode %></label>
                                            <input type="hidden" class="form-control" name="txtRestCode" value="<%=sRestCode%>" maxlength="10">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Public Holiday Code : </label>
                                        <div class="col-sm-6">
                                            <label class="col-sm-1 control-label"><%=sPublicCode %></label>
                                            <input type="hidden" class="form-control" name="txtPublicCode" value="<%=sPublicCode%>" maxlength=10">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Normal Working Day Overtime : </label>
                                        <div class="col-sm-6">
                                            <input class="form-control" id ="txtNormal" name="txtNormal" value="<%=sNormal%>" maxlength="5">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Off Day Overtime : </label>
                                        <div class="col-sm-6">
                                            <input class="form-control" id="txtOff" name="txtOff" value="<%=sOff%>" maxlength="5">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Rest Day Overtime : </label>
                                        <div class="col-sm-6">
                                            <input class="form-control" id="txtRest" name="txtRest" value="<%=sRest%>" maxlength="5">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Public Holiday Overtime : </label>
                                        <div class="col-sm-6">
                                            <input class="form-control" id="txtPublic" name="txtPublic" value="<%=sPublic%>" maxlength="5">
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <table id="example1">
                                        <tbody>
                                            <tr>
                                                <td width="8%"></td>
                                                <td width="5%"><b>Unassigned Grade ID :</b></td>
                                                <td width="4%" align="center">
                                                <td width="30%"><b>Assigned Grade ID : </b></td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp</td>
                                                <td>
                                                    <select multiple size="15" style="width: 405px;" name="FromLB" id="FromLB" ondblclick="move(this.form.FromLB,this.form.ToLB)">
                                                        <%  
                                                                ShowUnassign(sID)
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
                                                        <%  
                                                            Set rstSelect = server.CreateObject("ADODB.RecordSet")    
                                                            sSQL = "select * from TMOTCODE where OTCODE ='" & sID & "'" 
                                                            rstSelect.Open sSQL, conn, 3, 3
                                                            
                                                            do while not rstSelect.eof 
                                                                    
                                                                Set rstGrade = server.CreateObject("ADODB.RecordSet")    
                                                                sSQL = "select PART from TMGRADE where GRADE_ID ='" & rstSelect("GRADE_ID") & "'" 
                                                                rstGrade.Open sSQL, conn, 3, 3
                                                                if not rstGrade.eof then
                                                                    sPart = rstGrade("Part")
                                                                end if        
                                                                pCloseTables(rstGrade)

                                                                response.write "<option value='" & rstSelect("GRADE_ID") & "'>" & rstSelect("GRADE_ID") & " - " & sPart & "</option>"  
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
                                    <%if sOTCode <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sOTCode%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkEmpty();">Update</button>
                                        <button type="submit" id="btnUp" name="sub" value="up" class="btnSaveHide"></button>
                                    <%else %>
                                        <button type="button" id="btnCheck" name="btnCheck" class="btn btn-primary pull-right"
                                            style="width: 90px" onclick="check('OTCODE');">Save</button>
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

  	    xhttp.open("GET", "tmotcode_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }
    </script>
    <script>

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
            alert('OT Code cannot be empty');
            }else{

                if($('#ToLB').val() == null){
                   alert('Selected Box cannot be Empty');
                    return false;
                }
                
                var url_to	= 'ajax/ax_exist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    data    : { "txtWhat" : pWhat,
                                "txtID":$("#txtID").val(),
                              }, 
             
                    success : function(res){
                 
                        if(res.data.status == "exist"){
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

   // $(document).ready(function () {
   //   $('#btnSave').click(function () {
   //      });
   // });

    $(document).ready(function(){
        document.getElementById('txtID').focus();
        });

    function checkEmpty(){
        
        $('#ToLB').each(function () {
            $('#ToLB option').attr("selected", "selected");
            });

        if($('#ToLB').val() == null){
            if (confirm("Selected box is empty. This will delete the OT Code : <%=sID %> " )){
                $('#btnUp').click();
            }else{
                return false;
            }
        }else{
            $('#btnUp').click();    
        }
    }

    var input1 = document.getElementById('txtNormal');
    var input2 = document.getElementById('txtOff');
    var input3 = document.getElementById('txtRest');
    var input4 = document.getElementById('txtPublic');

    input1.onkeyup = input1.onchange = enforceFloat;
    input2.onkeyup = input2.onchange = enforceFloat;
    input3.onkeyup = input3.onchange = enforceFloat;
    input4.onkeyup = input4.onchange = enforceFloat;

    //enforce that only a float can be inputed
    function enforceFloat() {
        var valid = /^\-?\d+\.\d*$|^\-?[\d]*$/;
        var number = /\-\d+\.\d*|\-[\d]*|[\d]+\.[\d]*|[\d]+/;
        if (!valid.test(this.value)) {
        var n = this.value.match(number);
        this.value = n ? n[0] : '';
        }
    }

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
