<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <!-- #include file="tm_process.asp" -->

    <meta http-equiv="Content-Type" content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Employee Time Off</title>
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

    <%
        sEMP_CODE = UCase(request("txtEMP_CODE"))
        dtFr = request("dtFr")
        dtTo = request("dtTo")
        
        if sEMP_CODE <> "" then
            sID = sEMP_CODE
        else
            sID = UCase(reqForm("txtID"))
        end if

        if dtFr = "" then
            dtFr = reqForm("dtpFrDate")
        end if

        if dtTo = "" then
            dtTo = reqForm("dtpToDate")
        end if

        sModeSub = request("sub")
        sSearch = request("txtSearch")
        iPage = Request("Page")
    
        sMainURL = "tmeoff.asp?"
	
        sAddURL = "Page=" & iPage & "&txtEMP_CODE=" & sID & ""

        if sModeSub <> "" Then
            
            sTOff_ID = reqForm("txtTOff_ID")
            sPart = reqForm("txtTOffPart")
            selDura = reqForm("selDura")
            txtDura = reqForm("txtDura")
        
            if selDura <> "" then 
                sDura = selDura 
            elseif txtDura <> "" then
                sDura = txtDura
            end if
            
            if sDura = "0.5" then
                sLType = "H"
            else
                sLType = "F"
            end if
            
            sRemark = reqForm("txtRemark")

            Set rstTMTimeOff = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMTIMEOFF where TOFF_ID ='" & sTOff_ID & "'" 
            rstTMTimeOff.Open sSQL, conn, 3, 3
            if not rstTMTimeOff.eof then
                sPaid = rstTMTimeOff("PAID")
            end if 

            if sModeSub = "up" Then

                '=== Original Date
                dtOriginalFr = reqForm("dtOriginalFr")
                dtOriginalTo = reqForm("dtOriginalTo")

                '=== Delete the original Time OFf
                sSQL = " DELETE FROM tmeoff "    
                sSQL = sSQL & " WHERE EMP_CODE = '" & sID & "'"
                sSQL = sSQL & " AND DTFR = '" & fdate2(dtOriginalFr) & "'"
                sSQL = sSQL & " AND DTTO = '" & fdate2(dtOriginalTo) & "'"
                conn.execute sSQL

                '=== Loop and delete any Absent records within the original Date Range
                dtLoopDelAb = dtOriginalFr
                do while datevalue( dtLoopDelAb) <= datevalue(dtOriginalTo)
                   
                    sSQL = " DELETE FROM tmabsent "    
                    sSQL = sSQL & " WHERE EMP_CODE = '" & sID & "'"
                    sSQL = sSQL & " AND DT_ABSENT = '" & fdate2( dtLoopDelAb) & "'"
                    conn.execute sSQL

                     dtLoopDelAb = DateAdd("d",1,datevalue( dtLoopDelAb))
                loop

                '=== New Date and insert the new Time Off
                dtFrDate = reqForm("dtpFrDate")
                dtToDate = reqForm("dtpToDate")

                sSQL = "insert into TMEOFF (EMP_CODE, DTFR, DTTO, TOFF_ID, PART, PAID, LTYPE, DURA, REMARK,"
                sSQL = sSQL & " USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		        sSQL = sSQL & "values ("
                sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		        sSQL = sSQL & "'" & fdate2(dtFr) & "',"		
		        sSQL = sSQL & "'" & fdate2(dtTo) & "',"
		        sSQL = sSQL & "'" & pRTIN(sTOff_ID) & "',"
		        sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		        sSQL = sSQL & "'" & pRTIN(sPaid) & "',"
		        sSQL = sSQL & "'" & pRTIN(sLType) & "',"
		        sSQL = sSQL & "'" & sDura & "',"
                sSQL = sSQL & "'" & pRTIN(sRemark) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		        sSQL = sSQL & ") "
                conn.execute sSQL

                '===== Recalculate Absent ===============================================================================
                dtLoopAbsent = dtFr

                do while datevalue(dtLoopAbsent) <= datevalue(dtTo)
                    call fAbsent(dtLoopAbsent,sID)
                    dtLoopAbsent = DateAdd("d",1,datevalue(dtLoopAbsent))
                loop 

                '===== Process and record 3 days absents consecutively=====================================================
                call fAbsent3(dtFr, dtTo, sID, "Y")

                '==== Log ===============================================================================================
                sChangesM = " Employee : "  & sID & " changes the leave From " & dtOriginalFr & " - " & dtOriginalTo 
                sChangesM = sChangesM & " To " & dtFr & " - " & dtTo & " Duration : " & sDura 
                
                if Cint(sDura) = 1 then
                    sChangesM = sChangesM & " and Absent Record on" & dtFr & " is deleted. " 
                elseif Cint(sDura) > 1 then
                    sChangesM = sChangesM & " and Absent Record/s within " & dtFr &  " - " & dtTo & " are deleted. " 
                end if
                
                sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
	            sSQL = sSQL & "values ("
                sSQL = sSQL & "'Leave updated',"
                sSQL = sSQL & "'Success',"
                sSQL = sSQL & "'" & sChangesM & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
                conn.execute sSQL

                call confirmBox("Update Successful!", sMainURL&sAddURL)
        
            elseif sModeSub = "save" Then
                
                dtLoopDelAb = dtFr
                '=== Loop and delete any Absent records within the original Date Range
                do while datevalue( dtLoopDelAb) <= datevalue(dtTo)
                   
                    sSQL = " DELETE FROM tmabsent "    
                    sSQL = sSQL & " WHERE EMP_CODE = '" & sID & "'"
                    sSQL = sSQL & " AND DT_ABSENT = '" & fdate2( dtLoopDelAb) & "'"
                    conn.execute sSQL

                     dtLoopDelAb = DateAdd("d",1,datevalue( dtLoopDelAb))
                loop
            
                sSQL = "insert into TMEOFF (EMP_CODE, DTFR, DTTO, TOFF_ID, PART, PAID, LTYPE, DURA, REMARK,"
                sSQL = sSQL & " USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		        sSQL = sSQL & "values ("
                sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		        sSQL = sSQL & "'" & fdate2(dtFr) & "',"		
		        sSQL = sSQL & "'" & fdate2(dtTo) & "',"
		        sSQL = sSQL & "'" & pRTIN(sTOff_ID) & "',"
		        sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		        sSQL = sSQL & "'" & pRTIN(sPaid) & "',"
		        sSQL = sSQL & "'" & pRTIN(sLType) & "',"
		        sSQL = sSQL & "'" & sDura & "',"
                sSQL = sSQL & "'" & pRTIN(sRemark) & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		        sSQL = sSQL & ") "
                conn.execute sSQL
                
                dtLoopAbsent = dtFr

                do while datevalue(dtLoopAbsent) <= datevalue(dtTo)
                    call fAbsent(dtLoopAbsent,sID)
                    dtLoopAbsent = DateAdd("d",1,datevalue(dtLoopAbsent))
                loop 

                '===== Process and record 3 days absents consecutively=====================================================
                call fAbsent3(dtFr, dtTo, sID, "Y")
                 
                sChangesM = " Employee : "  & sID & " Applied Leave "
                sChangesM = sChangesM & " From : " & dtFr & " To : " & dtTo & " Duration : " & sDura 
                
                if Cint(sDura) = 1 then
                    sChangesM = sChangesM & " Absent Record on" & dtFr & " is deleted. " 
                elseif Cint(sDura) > 1 then
                    sChangesM = sChangesM & " Absent Records within " & dtFr &  " - " & dtTo & " are deleted. " 
                end if
                
                sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
	            sSQL = sSQL & "values ("
                sSQL = sSQL & "'Leave updated',"
                sSQL = sSQL & "'Success',"
                sSQL = sSQL & "'" & sChangesM & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
                conn.execute sSQL

                call confirmBox("Save Successful!", sMainURL&sAddURL)
        
            end if

         End If 
          
    Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select TMEOFF.*, TMEMPLY.NAME from TMEOFF left join TMEMPLY on TMEOFF.EMP_CODE = TMEMPLY.EMP_CODE "
    sSQL = sSQL & " where tmeoff.EMP_CODE='" & sID & "'" 
    sSQL = sSQL & " and DTFR ='" & fdate2(dtFr) & "'"
    sSQL = sSQL & " and DTTO ='" & fdate2(dtTo) & "'"
    rstTMEOFF.Open sSQL, conn, 3, 3
    if not rstTMEOFF.eof then
        sTOff_ID = rstTMEOFF("TOFF_ID")
        sPart = rstTMEOFF("PART")
        sDuraFrDB = rstTMEOFF("DURA")

        if sDuraFrDB = "0.5" or sDuraFrDB = "1" then
            selDura = sDuraFrDB
        else
            sDura = sDuraFrDB
        end if
        sName = rstTMEOFF ("NAME")
        sRemark = rstTMEOFF("REMARK")
    end if
    pCloseTables(rstTMEOFF)

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
                <h1>Employee Time Off</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmeoff_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <input type="hidden" name="txtEMP_CODE" value='<%=sEMP_CODE%>' />
                            <input type="hidden" name="dtFr" value='<%=dtFr%>' />
                            <input type="hidden" name="dtTo" value='<%=dtTo%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <%if sEMP_CODE <> "" then %>
                                            <div class="col-sm-3">
                                                <span class="mod-form-control"><% response.write sEMP_CODE %></span>
                                                <input type="hidden" id="txtID" name="txtID" value="<%=sID%>" />
                                            </div>
                                        <%else%>
                                            <div class="col-sm-3">
                                                <div class="input-group">
                                                    <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform:uppercase">
                                                    <span class="input-group-btn">
                                                        <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                            onclick ="fOpen('SUBORD','mycontent','#mymodal')">
                                                            <i class="fa fa-search"></i>
                                                        </a>
                                                    </span>
                                                </div>
                                            </div>
                                        <%end if%>

                                            <div class="col-sm-4">
                                                <input class="form-control" id="txtNAME" name="txtNAME" value="<%=sName%>" READONLY>
                                            </div>
                                        
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">From Date : </label>
                                        <div id="divdtpFr" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpFrDate" name="dtpFrDate" type="text" class="form-control" value="<%=dtFr%>" date-picker data-date-format="dd/mm/yyyy">
                                                <input type="hidden" name="dtOriginalFr" value="<%=dtFr%>" >
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpFr" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdtpFr" class="help-block"></span>
                                        </div>
                                        <div id="divdtpTo" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpToDate" name="dtpToDate" type="text" class="form-control" value="<%=dtTo%>" date-picker data-date-format="dd/mm/yyyy"  >
                                                <input type="hidden" name="dtOriginalTo" value="<%=dtTo%>" >
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpTo" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdtpTo" class="help-block"></span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Time Off Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtTOff_ID" name="txtTOff_ID" maxlength="10" value="<%=sTOff_ID%>" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('TOFF','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <input class="form-control" id="txtTOffPart" name="txtTOffPart" maxlength="30" value="<%=sPart%>" / READONLY>
                                        </div>
                                    </div>

                                    <div class="form-group" style="display:none" id="oneDay">
                                        <label class="col-sm-3 control-label">Duration : </label>
                                        <div class="col-sm-1" style="width:10.333333%">
                                            <select id="selDura" name="selDura" class="form-control">
                                                <option value="1" <%if selDura = "" or selDura = "1" then%>Selected<%end if%>>1</option>
                                                <option value="0.5" <%if selDura = "0.5" then%>Selected<%end if%>>0.5</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group" style="display:none" id="moreThanOne">
                                        <label class="col-sm-3 control-label">Duration : </label>
                                        <div class="col-sm-1">
                                            <input class="form-control" id="txtDura" name="txtDura" value="<%=sDura%>" readonly>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Remark : </label>
                                        <div class="col-sm-5">
                                            <input class="form-control" id="txtRemark" name="txtRemark" value="<%=sRemark%>" maxlength="30">
                                        </div>
                                    </div>

                                </div>
                                <!-- /.box body -->

                                <div class="box-footer">
                                    <%if sEMP_CODE <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sEMP_CODE%>','<%=dtFr%>', '<%=dtTo%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkUp();">Update</button>
                                        <button type="submit" id="btnUpdate"name="sub" value="up" class="btnSaveHide"></button>
                                    <%else%>
                                        <button type="button" class="btn btn-primary pull-right" style="width: 90px" onclick="check();">Save</button>
                                        <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide"></button>
                                    <%end if %>
                                </div>
                                <!-- /.box footer -->

                            </div>
                            <!-- /.box info -->
                        </form>
                    </div>
                    <!-- /.col-->
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
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <script src="plugins/input-mask/jquery.mask.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
    <!-- JQuery for the Choose a file label -->
    <script src="plugins/Custom/custom-file-input.js"></script>
	<!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
	
    <script>

    //====Date picker without today's date==========================
    $(document).ready(function(){ //====== When Page finish loading
        
        document.getElementById('txtID').focus();

        <%if selDura = "1" or selDura = "0.5" then %>
            $('#moreThanOne').hide();
            $('#oneDay').show();
        <%else%>
            $('#oneDay').hide();
            $('#moreThanOne').show();
        <%end if %>

        $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            orientation: "bottom",
            })

        $('[date-picker]').mask('00/00/0000');
    });

         
    $('#dtpFrDate').datepicker().on('changeDate', function(e) {
        calDura();
        $('#dtpFrDate').datepicker("hide");
    });

    $('#dtpToDate').datepicker().on('changeDate', function(e) {
        calDura();
        $('#dtpToDate').datepicker("hide");
    });
    
    $('#btndtpFr').click(function () {
        $('#dtpFrDate').datepicker("show");
    });

    $('#btndtpTo').click(function () {
        $('#dtpToDate').datepicker("show");
    });

    function parseDate(str) {
        var mdy = str.split('/');
        return new Date(mdy[2], mdy[1]-1, mdy[0]);
    }

    function daydiff(first, second) {
        result = Math.round((second-first)/(1000*60*60*24)+1) ;
        return result
    }

    function calDura(){

        var dtpFrDate = parseDate($('#dtpFrDate').val());
        var dtpToDate = parseDate($('#dtpToDate').val());
        var howManyDays = (daydiff(dtpFrDate, dtpToDate));

        if (isNaN(howManyDays) ){
        
        }else{
            if (howManyDays == 1){
                $('#moreThanOne').hide(); 
                $('#oneDay').show(); 
            }else{
                $('#oneDay').hide();
                $makeZeroValue = $("#selDura");
                $makeZeroValue[0].selectedIndex = -1;
                $('#moreThanOne').show(); 
                document.getElementById('txtDura').value = howManyDays
            }
        }
    }

	
    //========Check if Time off Code is empty or valid, Type is selected , if OK then call btnUp Click ==========
   
    function checkUp() {
        
        var success = true;
        //======= Check if Time Off Code is empty or valid
        if($('#txtTOff_ID').val() == ''){

            alert('Time Off Code cannot be Empty');
            return false;
        
        //}else if ($('#txtDura').val() <= 0){
                
         //   alert('Duration is negative');
         //   return false;
            
        //
        }else{
                
            var url_to	= 'ajax/ax_notexist.asp';  
            
            $.ajax({
                url     : url_to,
                type    : 'POST',
                async   : false,
                data    : { "txtWhat":"TOFF",
                            "txtID":$("#txtTOff_ID").val(),
                            }, 
                success : function(res){
                 
                    if(res.data.status == "notexist"){
                        success = false;
                        return alert(res.data.value);
                    }
                },
                error	: function(error){
                    console.log(error);
                }
            });
        }

        //====== if All success then will trigger Post Back ===== 
        if (success == true) {
            $('#btnUpdate').click();
        }   
    }
    
    //========Check if Employee Code, check Date Format and range, Time off Code, Type, if OK then call btnSave Click ==========
    function check() {
            
            var success = true;
        
            //======= Check if employee code is empty or is valid ======
            if($('#txtID').val() == ''){
                alert('Employee Code cannot be empty');
                return false;
            }else{
                
                var url_to	= 'ajax/ax_chkvalidempcode.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtEmp_Code":$("#txtID").val(),
                                "dtpFrDate":$("#dtpFrDate").val(),
                                "dtpToDate":$("#dtpToDate").val(),
                                }, 
             
                    success : function(res){
                 
                        if(res.data.status == "invalid"){
                            success = false;
                            return alert(res.data.value);
                            
                        }else if (res.data.status =="dtexist"){
                            success = false;
                            return alert(res.data.value);
                        }
                    },
                    error	: function(error){
                        console.log(error);
                    }
                });
            }
    
            //======= Check if Time Off Code is empty or valid
            if($('#txtTOff_ID').val() == ''){
                alert('Time Off Code cannot be Empty');
                return false;

            //}else if ($('#txtDura').val() <= 0){
                
            //    alert('Duration is negative');
            //    return false;
            
            }else{
                
                var url_to	= 'ajax/ax_notexist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtWhat":"TOFF",
                                "txtID":$("#txtTOff_ID").val(),
                                }, 
                    success : function(res){
                 
                        if(res.data.status == "notexist"){
                            success = false;
                            return alert(res.data.value);
                        }
                    },
                    error	: function(error){
                        console.log(error);
                    }
                });
            }

        //====== if All success then will trigger Post Back ===== 
        if (success == true) {
            $('#btnSave').click();
        }     
            
    }
    
    //========== DELETE MODAL ==================================
    function fDel(str,dtFr,dtTo,pContent,pModal) {
        showDelmodal(str,dtFr,dtTo,pContent)
		$(pModal).modal('show');
	}

    function showDelmodal(str, dtFr, dtTo, pContent){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

  	    xhttp.open("GET", "tmeoff_del.asp?txtstring=" + str + "&dtFr=" + dtFr + "&dtTo=" + dtTo, true);
  	    xhttp.send();
        
    }
	      
    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    //=== PICK and CHOOSE MODAL ==================================
    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    
    }

    function getValue2(svalue1, pFldName1,svalue2, pFldName2 ) {
        document.getElementById(pFldName1).value = svalue1;
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

        if (pType=="SUBORD") {
            var search = document.getElementById("txtSearch_subord");
        }else if (pType=="TOFF") {
            var search = document.getElementById("txtSearch_toff");
        }

        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="SUBORD") {
            xhttp.open("GET", "ajax/ax_view_tmsubord.asp?"+str, true);
        } else if (pType=="TOFF") {
            xhttp.open("GET", "ajax/ax_view_tmtimeoff.asp?"+str, true);
        }
	  	
        	  	
  	    xhttp.send();
    }

    //=== Intellisense ==========================================
    $( "#txtID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
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
	
	$( "#txtTOff_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=TO",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtTOff_ID").val(ui.item.value);
				var str = document.getElementById("txtTOff_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtTOff_ID").value = res[0];
				document.getElementById("txtTOffPart").value = res[1];
			},0);
		}
	});

    //=== Any changes except ENTER will clear the NAME field====
    $('#txtTOff_ID').on('keyup',  function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode != 13 ) {
            $('#txtTOffPart').val('');
        }
    });
	//=================================================================

    </script>
</body>
</html>
