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
    <title>IQOR</title>
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
	Private Function IsAlphaNumeric(byVal string)
		dim regExp, match, i, spec
		For i = 1 to Len( string )
			spec = Mid(string, i, 1)
			Set regExp = New RegExp
			regExp.Global = True
			regExp.IgnoreCase = True
			regExp.Pattern = "[A-Z]|[a-z]|\s|[_]|[0-9]|[.]"
			set match = regExp.Execute(spec)
			If match.count = 0 then
				IsAlphaNumeric = False
				Exit Function
			End If
			Set regExp = Nothing
		Next
		IsAlphaNumeric = True
	End Function

    sNRIC = UCase(request("txtNRIC"))
    
    if sNRIC <> "" or sNRIC2 <> "" then
       sIC = sNRIC
	   sIC2 = sNRIC2
    else
       sIC = UCase(reqForm("txtNRIC"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    sNat = request("sNat")
    sMainURL = "vrvend.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage 
	
	if sModeSub = "check" then	
	
		if sNat = "Y" then
			if IsNumeric(sIC) = false then
				Call alertbox("Please key in NRIC with number only.")
			end if
		elseif sNat = "N" then
			if IsAlphaNumeric(sIC) = false then
				Call alertbox("Please key in Passport with alphabet and number only.")
			end if
		end if
		
		Set rstVRVend = server.CreateObject("ADODB.RecordSet")
		sSQL = "select * from vrvend where NRIC = '" & sIC & "'"
		rstVRVend.Open sSQL, conn, 3, 3
		if rstVRVend.eof then
				call alertbox("NRIC : " & sIC & " does not exist!")
			temp = 0
		else
			sIC = rstVRVend("NRIC")
			sName = rstVRVend("VNAME")
			sComp_Name = rstVRVend("COMPNAME")
			sDesign = rstVRVend("DESIG")
			sHP = rstVRVend("HP")
			sCar_No = rstVRVend("CAR_NO")
			sBl_List = rstVRVend("BLIST")
			sNat = rstVRVend("NAT")
			sReason = rstVRVend("BLREASON")
			temp = 1
		end if
		if sBl_List = "Y" then
			temp = 1
			Call alertbox("NRIC : " & sIC & " is black-listed !")
		end if
        
		pCloseTables(rstVRVend)
		
    elseif sModeSub <> "" Then
        
		sName = reqForm("txtName")
		sComp_Name = reqForm("txtComp_Name")
		sDesign = reqForm("txtDesign")
		sHP = reqForm("txtHP")
		sCar_No = reqForm("txtCar_No")
		sBl_List = reqForm("sBl_List")
		sNat = reqForm("sNat")
		sReason = reqForm("txtReason")
		
		if sNat = "Y" then
			if IsNumeric(sIC) = false then
				Call alertbox("Please key in number")
			end if
		end if
		
		if sIC = "" then
		    call alertbox("NRIC cannot be empty")
		end if
		
		if sIC <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from vrvend where NRIC ='" & sIC & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if BLIST = "Y" then
                call alertbox("NRIC : " & sIC & " is black-listed !")
				black_listed = rstVRVend(BLIST)
		    End if  
            pCloseTables(rstVRVend)
        end if
		
		if sName = "" then
		    call alertbox("Name cannot be empty")
		end if
		
		if sComp_Name = "" then
		    call alertbox("Company Name cannot be empty")
		end if
		
		if sHP = "" then
		    call alertbox("HandPhone cannot be empty")
		end if
		
		if sCar_No = "" then
		    call alertbox("Vehicle No cannot be empty")
		end if

		if sComp_Name <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from vrcomp where COMPNAME ='" & sComp_Name & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Company Name : " & sComp_Name & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
        end if
		
				
        if sModeSub = "up" Then
            
            sSQL = "UPDATE vrvend SET "             
			sSQL = sSQL & "VNAME = '" & pRTIN(sName) & "',"
			sSQL = sSQL & "COMPNAME = '" & pRTIN(sComp_Name) & "',"
			sSQL = sSQL & "DESIG = '" & pRTIN(sDesign) & "',"
			sSQL = sSQL & "HP = '" & pRTIN(sHP) & "',"
			sSQL = sSQL & "CAR_NO = '" & pRTIN(sCar_No) & "',"
			sSQL = sSQL & "BLIST = '" & sBl_List & "',"
			sSQL = sSQL & "NAT = '" & sNat & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
			sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "',"
			sSQL = sSQL & "BLREASON = '" & pRTIN(sReason) & "'"
            sSQL = sSQL & "WHERE NRIC = '" & sIC & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtNRIC=" & sIC & "")

        elseif sModeSub = "save" Then
		
			Set rstVRVend = server.CreateObject("ADODB.RecordSet")
			sSQL = "select * from vrvend where NRIC = '" & sIC & "'"
			rstVRVend.Open sSQL, conn, 3, 3
			if rstVRVend.eof then
				sSQL = "insert into vrvend (NRIC,VNAME,COMPNAME,DESIG,HP,CAR_NO,BLIST,NAT,GD_IN,DT_IN,CREATE_ID,DT_CREATE,BLREASON) "
				sSQL = sSQL & "values ("
				sSQL = sSQL & "'" & pRTIN(sIC) & "',"		
				sSQL = sSQL & "'" & pRTIN(sName) & "',"
				sSQL = sSQL & "'" & pRTIN(sComp_Name) & "',"
				sSQL = sSQL & "'" & pRTIN(sDesign) & "',"
				sSQL = sSQL & "'" & pRTIN(sHP) & "',"
				sSQL = sSQL & "'" & pRTIN(sCar_No) & "',"
				sSQL = sSQL & "'" & pRTIN(sBl_List) & "',"
				sSQL = sSQL & "'" & pRTIN(sNat) & "',"
				sSQL = sSQL & "'" & session("USERNAME") & "',"
				sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
				sSQL = sSQL & "'" & session("USERNAME") & "',"
				sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
				sSQL = sSQL & "'" & pRTIN(sReason) & "'"
				sSQL = sSQL & ") "
		    conn.execute sSQL
			call confirmBox("Save Successful!", sMainURL&sAddURL&"&txtNRIC=" & sIC & "")  
			else
				call confirmBox("NRIC Already Existed!", sMainURL&sAddURL&"&txtNRIC=" & sIC & "") 
		    end if   

         End If 
    End If
          
    Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from vrvend where NRIC ='" & sIC & "'" 
    rstVRVend.Open sSQL, conn, 3, 3
        if not rstVRVend.eof then
            sIC = rstVRVend("NRIC")
			sName = rstVRVend("VNAME")
			sComp_Name = rstVRVend("COMPNAME")
			sDesign = rstVRVend("DESIG")
			sHP = rstVRVend("HP")
			sCar_No = rstVRVend("CAR_NO")
			sBl_List = rstVRVend("BLIST")
			sNat = rstVRVend("NAT")
			sReason = rstVRVend("BLREASON")
        end if
    pCloseTables(rstVRVend)
        
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
	
        <!-- #include file="include/header.asp" -->
        <!-- Left sICe column. contains the logo and sICebar -->
        <!-- #include file="include/sidebar_vr.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Vendor Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="vrvend_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
									<div class="form-group">
									<label class="col-sm-3 control-label">Nationality : </label>
										<div class="col-sm-4">
											<%if sNat <> "" then%>
												<%if sNat = "Y" then%>
													<span class="mod-form-control"><% response.write("Malaysian") %> </span>
												<%else%>
													<span class="mod-form-control"><% response.write("Non-Malaysian") %> </span>
												<%end if%>
											<%else%>
												<input type="radio" name="sNat" id="sNat_MY" value="Y" onchange="CheckNat(this.value)" > Malaysian
												<input type="radio" name="sNat" id="sNat_NMY" value="N" onchange="CheckNat(this.value)" style="margin-left:10px;" > Non-Malaysian
											<%end if %>
										</div>
											<p id = "test" style = "color:red;"></p>
									</label>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">NRIC/Passport : </label>
                                        <div class="col-sm-3">
                                            <%if sNRIC <> "" then %>
                                                <span class="mod-form-control"><% response.write sNRIC %> </span>
                                                <input type="hidden" id="txtNRIC" name="txtNRIC" value='<%=sIC%>' />
                                            <%else%>  
                                                <input class="form-control" type="text" id="txtNRIC" name="txtNRIC" maxlength="15" style="text-transform: uppercase" />
                                            <% end if %>
                                        </div>
										<div class = "col-sm-3">
										<%if sIC<> "" then %>
											<button style="visibility:hidden"></button>
										<%else%>
											<button type="submit" name="sub" value="check" class="btn btn-info" style="width: 90px">Check</button>
										<%end if%>
										
										</div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Vendor Name : </label>
                                        <div class="col-sm-5">
											<input class="form-control" id="txtName" name="txtName" value="<%=sName%>" maxlength="50"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Company Name : </label>
                                        <div class="col-sm-5">
                                            <div class="input-group">
                                                <input class="form-control" id="txtComp_Name" name="txtComp_Name" value="<%=sComp_Name%>" maxlength="50" style="text-transform: uppercase" input-check>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('COMP','txtComp_Name','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Designation : </label>
                                        <div class="col-sm-5">
                                            <input class="form-control" name="txtDesign" value="<%=server.htmlencode(sDesign)%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">H/P : </label>
                                        <div class="col-sm-5">
                                            <input class="form-control" name="txtHP" value="<%=server.htmlencode(sHP)%>" maxlength="15">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Vehicle No : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" name="txtCar_No" value="<%=server.HTMLEncode(sCar_No)%>" maxlength="10">
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Black Listed : </label>
                                        <div class="col-sm-3">
                                            <select name="sBl_List" class="form-control" onchange="showR(this.value);">
                                                <option value="N" selected="selected" <%if sBl_List = "N" then%>Selected<%end if%>>No</option>
                                                <option value="Y" <%if sBl_List = "Y" then%>Selected<%end if%>>Yes</option>
                                            </select>
                                        </div>
                                    </div>
									<div id="showReason" <%if sReason <> "" then%>style="display:block;"<%else%>style="display:none;"<%end if%> >
										<div class="form-group">
											<label class="col-sm-3 control-label">Reason : </label>
											<div class="col-sm-7">
												<input class="form-control" id="txtReason" name="txtReason" value="<%=server.htmlencode(sReason)%>" maxlength="50">
											</div>
										</div>
									</div>
                                </div>
                                <div class="box-footer">
                                    <%if sIC<> "" then %>
                                        <a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=server.htmlencode(sIC)%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
                                        <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                    <%else %>
                                        <button type="submit" <%if temp = 1 then%> style="visibility:hidden;" <%end if%> name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
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
                <div class="modal fade in" id="modal-delcomp" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="exampleModalLabel"></h4>
                            </div>
                            <div class="modal-body">
                                <div id="del-content">
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
        $('#modal-delcomp').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var work_id = button.data('work_id')
        var modal = $(this)
        modal.find('.modal-body input').val(work_id)
        showDelmodal(work_id)
    })

    function showDelmodal(str){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("del-content").innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "vrvend_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtNRIC').focus();
        }); 
    </script>
	<script>
    function fOpen(pType,pFldName,pContent,pModal) {
		document.getElementById(pContent).innerHTML = ""
        showDetails('page=1',pFldName,pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }
    
    function showDetails(str,pFldName,pType,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

        if (pType=="COMP") { 
            var search = document.getElementById("txtSearch_comp");
        }
	  	
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
			
			str = str + "&fldName=" + pFldName;
			
		if (pType=="COMP") {
	  	    xhttp.open("GET", "ajax/ax_view_compid.asp?"+str, true);
	  	} 
        
	  	
  	    xhttp.send();
    }
	
	function showR(value)
	{
		if (value == "Y")
			document.getElementById("showReason").style.display = "block";
		else
		{
			document.getElementById("txtReason").value = "";	
			document.getElementById("showReason").style.display = "none";
		}
	}
	
	function CheckNat(value)
	{
		if(value == "Y"){
			document.getElementById("test").innerHTML = "Please key in your IC Number.";
		}
		else{
			document.getElementById("test").innerHTML = "Please key in your Passport Number.";
		}
	}
	
	$( "#txtComp_Name" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CI",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtComp_Name").val(ui.item.value);
				var str = document.getElementById("txtComp_Name").value;
				var res = str.split(" | ");
				document.getElementById("txtComp_Name").value = res[0];
			},0);
		}
	});	
    </script>

</body>
</html>
