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
    <title>iQOR | Holiday Group Details</title>
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
    <!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>


    <%
    sHOL_ID= request("txtHOL_ID")
    iPage = request("Page")
    sSearch = request("txtSearch")
    sModeSub = request("sub")   

    if sHOL_ID <> "" then
        sID = sHOL_ID
    else
        sID = UCase(reqForm("txtID"))
    end if

    sName= reqForm("txtName")
    sYear = reqForm("selYear")

    if sYear = "" then
        sYear = year(date)
    end if

    sMainURL = "tmholcal.asp?"
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 

    if sModeSub = "up" then
       
        sSQL = "delete from TMHOL1 where HOL_ID = '" & sID & "' and year(DT_HOL) = '" & sYear & "'"
        conn.execute sSQL 

        arr=Split(reqform("ToLB"),",")    
        
        for j = 0 to Ubound(arr)
        
            sDt_Hol = arr(j)
            j = j + 1
            'sPart = pRTIN(arr(j))

            sSQL = "select * from TMHOL where DT_HOL ='" & fdate2(sDt_Hol) & "'" 
            Set rstTMHOL = server.CreateObject("ADODB.RecordSet")    
            rstTMHOL.Open sSQL, conn, 3, 3
            if not rstTMHOL.eof then
                sPart = rstTMHOL("PART")
                sReplace = rstTMHOL("REPLA")
            end if
            pCloseTables(rstTMHOL)

            sSQL = "insert into tmhol1 (HOL_ID,NAME,DT_HOL,PART, REPLA, USER_ID,DATETIME) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sName) & "',"		
		    sSQL = sSQL & "'" & fdate2(sDt_Hol) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		    sSQL = sSQL & "'" & pRTIN(sReplace) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
            conn.execute sSQL
        Next
  
            sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage 
        
        call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtHOL_ID=" & sID & "")
        
    elseif sModeSub = "save" then
      
        arr=Split(reqform("ToLB"),",")    
            
        for i = 0 to Ubound(arr)
            sDt_Hol = arr(i)
                i = i + 1
            
            sSQL = "select * from TMHOL where DT_HOL ='" & fdate2(sDt_Hol) & "'" 
            Set rstTMHOL = server.CreateObject("ADODB.RecordSet")    
            rstTMHOL.Open sSQL, conn, 3, 3
            if not rstTMHOL.eof then
                sPart = rstTMHOL("PART")
                sReplace = rstTMHOL("REPLA")
            end if
            pCloseTables(rstTMHOL)

            sSQL = "insert into tmhol1 (HOL_ID,NAME,DT_HOL,PART,REPLA,USER_ID,DATETIME) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sName) & "',"		
		    sSQL = sSQL & "'" & fdate2(sDt_Hol) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		    sSQL = sSQL & "'" & pRTIN(sReplace) & "',"
            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
            conn.execute sSQL

            call confirmBox("Save Successful!", sMainURL&sAddURL&"&txtHOL_ID=" & sID & "")  
        next
    end if

    function ShowAvailDates(sParam)
 	Set rs=server.CreateObject("ADODB.Recordset")
 	sql="Select * from tmhol "
 	sql=sql & "order by dt_hol"
 	rs.open sql, conn
    if len(sParam) > 0  then
        
        do while not rs.eof
                
                bflag=true
                
                Set rs1=server.CreateObject("ADODB.Recordset")
 	            sql="Select * from tmhol1 "
 	            sql = sql & " where hol_id = '" & sParam & "'"
                sql = sql & " order by dt_hol"
                rs1.open sql, conn
                    do while not rs1.eof 
                    
                        if fdate2(rs("DT_HOL")) = fdate2(rs1("DT_HOL")) then
                            bflag= false  
                            exit do
                        end if
                        rs1.movenext
                    loop
                
                if bflag = true then
                    if Cint(year(rs("DT_HOL"))) = Cint(sYear) then
                         response.write "<option value='" & rs("DT_HOL") & "," & pRTIN(rs("PART")) & "'>" & rs("DT_HOL") & " - " & rs("PART") & "</option>"
                    end if
                end if    
                         
           rs.movenext 
       loop 
    else  
        do while not rs.eof
  		
           if Cint(year(rs("DT_HOL"))) = Cint(sYear) then
                response.write "<option value='" & rs("DT_HOL") & "," & pRTIN(rs("PART")) & "'>" & rs("DT_HOL") & " - " & rs("PART") & "</option>"
  		    end if
    
            rs.movenext 
        loop
 	    pCloseTables(rs)
    end if 
    end function

    Set rstTMHOL1 = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMHOL1 where HOL_ID ='" & sID & "'" 
    rstTMHOL1.Open sSQL, conn, 3, 3
        if not rstTMHOL1.eof then
            sName = rstTMHOL1("Name")
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
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>Holiday Group Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <div class="box">
                            <div class="box-header with-border">
                                <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body ">
                                <form id="form1" name="form1" class="form-horizontal" action="tmholcal_det.asp?txtHOL_ID=<%=sID%>" method="POST">
                                    <input type="hidden" name="Page" value='<%=iPage%>' />
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Holiday Calendar Code : </label>
                                        <div class="col-sm-7">
                                            <% if sID <> "" then %>
                                            <span class="mod-form-control"><% response.write sID%> </span>
                                            <input type="hidden" id="txtID" name="txtID" value="<%=sID%>" />
                                            <%else%>
                                            <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="30" style="text-transform: uppercase" />
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Name : </label>
                                        <div class="col-sm-7">
                                            <input class="form-control" id="txtName" name="txtName" value="<%=sName%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Year : </label>
                                        <div class="col-sm-2">
                                            <%if sSHFPAT_ID <> "" then%>
                                            <span class="mod-form-control"><% response.write sYear%> </span>
                                            <input type="hidden" id="selYear" value="<%=sYear%>" />
                                            <%else%>
                                            <select name="selYear" id="selYear" class="form-control" onchange="this.form.submit();">
                                                <%For i = 1 to 34 
                                                        selyear = Cint(2016) + Cint(i)
                                                %>
                                                    <option value="<%=selyear%>" <%if selYear = Cint(sYear) then%>Selected<%end if%>><%=selYear%></option>
                                                <%Next%>
                                            </select>
                                            <% end if %>
                                        </div>
                                    </div>
                                    <div>
                                        <table id="example1">
                                            <tbody>
                                                <tr>
                                                    <td width="8%"></td>
                                                    <td width="5%"><b>Available Dates :</b>
                                                    <td width="4%" align="center">
                                                    <td width="30%"><b>Selected : </b>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp</td>
                                                    <td>
                                                        <select multiple size="15" style="width: 405px;" name="FromLB" id="FromLB" ondblclick="move(this.form.FromLB,this.form.ToLB)">
                                                            <%  
                                                                ShowAvailDates(sID)
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
                                                            <%  Set rstTMHOL1 = server.CreateObject("ADODB.RecordSet")    
                                                                sSQL = "select * from TMHOL1 where HOL_ID ='" & sID & "'" 
                                                                rstTMHOL1.Open sSQL, conn, 3, 3
                                                                
                                                                do while not rstTMHOL1.eof 
                                                                    if Cint(year(rstTMHOL1("DT_HOL"))) = Cint(sYear) then
                                                                        response.write "<option value='" & rstTMHOL1("DT_HOL") & "," & rstTMHOL1("PART") & "'>" & rstTMHOL1("DT_HOL") & " - " & rstTMHOL1("PART") & "</option>"  
                                                                    End if
                                                                    rstTMHOL1.movenext
                                                                loop
                                                             
                                                            %>
                                                        </select>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="box-footer">
                                        <%if sID <> "" then %>
                                            <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sID%>','mycontent-del','#mymodal-del')">Delete</a>
                                            <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkEmpty();">Update</button>
                                            <button type="submit" id="btnUp" name="sub" value="up" class="btnSaveHide"></button>
                                        <%else %>
                                            <button type="button" id="btnCheck" name="btnCheck" class="btn btn-primary pull-right"
                                                style="width: 90px" onclick="check('HOLC');">Save</button>
                                            <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide"></button>
                                        <%end if %>
                                    </div>
                                </form>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
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

  	    xhttp.open("GET", "tmholcal_del.asp?txtstring="+str, true);
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
            alert('Holiday Group Code cannot be empty');
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
            if (confirm("Selected box is empty. This will delete the Holiday Group Code : <%=sID %> " )){
                $('#btnUp').click();
            }else{
                return false;
            }
        }else{
            $('#btnUp').click();    
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
    });
    </script>
</body>
</html>
