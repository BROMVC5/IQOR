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
    <title>iQOR | Program Setup</title>
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


    
    <%

    sMainURL = "tmpath.asp?"
	
    sModeSub = request("sub")

     if sModeSub <> "" Then
        
        sLateGr = reqForm("txtLateGr")
        sEarlyGr = reqForm("txtEarlyGr")
        sMinOT = reqForm("txtMinOT")
        sMinM4OT = reqForm("txtMinM4OT")
        dMMDays = reqForm("txtMMDays")
        dMMAmt = reqForm("txtMMAmt")
        sOTXHour = reqForm("txtOTXHour")
        sPayFrom = reqForm("txtPayFrom")
        sPayTo = reqForm("txtPayTo")
        sHalfDayGr = reqForm("txtHalfDayGr")
        
        if sModeSub = "up" Then
            
            sSQL = "UPDATE TMPATH SET "             
            sSQL = sSQL & "LATEGR = '" & sLateGr & "',"
            sSQL = sSQL & "EARLYGR = '" & sEarlyGr & "',"
            sSQL = sSQL & "MINOT = '" & sMinOT & "',"
            sSQL = sSQL & "MINM4OT = '" & sMinM4OT & "',"
            sSQL = sSQL & "MMDAYS = '" & dMMDays & "',"
            sSQL = sSQL & "MMAMT = '" & dMMAmt & "',"
            sSQL = sSQL & "OTXHOUR = '" & sOTXHour & "',"
            sSQL = sSQL & "PAYFROM = '" & sPayFrom & "',"
            sSQL = sSQL & "PAYTO = '" & sPayTo & "',"
            sSQL = sSQL & "HALFDAYGR = '" & sHalfDayGr & "'"
            
            'response.write sSQL 
            'response.end
            conn.execute sSQL

            call confirmBox("Update Successful!", sMainURL)
        end if

    End If
          
    Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMPATH" 
    rstTMPATH.Open sSQL, conn, 3, 3
    if not rstTMPATH.eof then
        sLateGR = rstTMPATH("LATEGR")
        sEarlyGR = rstTMPATH("EARLYGR")
        sMinOT = rstTMPATH("MINOT")
        sMinM4OT = rstTMPATH("MINM4OT")
        dMMDays = rstTMPATH("MMDAYS")
        dMMAmt = rstTMPATH("MMAMT")
        sOTXHour = rstTMPATH("OTXHOUR")
        sPayFrom = rstTMPATH("PAYFROM")
        sPayTo = rstTMPATH("PAYTO")
        sHalfDayGr = rstTMPATH("HALFDAYGR")
    end if
    pCloseTables(rstTMPATH)
        
        
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
                <h1>Program Setup</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="tmpath.asp" method="post">
                            <div class="box box-info">
                                <div class="box-body" style="padding-top:30px">
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Late in Grace Period : </label>
                                        <div class="col-sm-5 col-lg-2">
                                            <div class="input-group">
                                                 <input id="txtLateGr" name="txtLateGr" value='<%=sLateGr%>' type="text" 
                                                     class="form-control" time-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                        <div id="txtLateGrHelpDiv" class="col-sm-6 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    <label class="col-sm-4 control-label">Early dismiss Grace Period : </label>
                                        <div class="col-sm-5 col-lg-2">
                                            <div class="input-group">
                                                 <input id="txtEarlyGr" name="txtEarlyGr" value='<%=sEarlyGr%>' type="text" 
                                                     class="form-control" time-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                        <div id="txtEarlyGrHelpDiv" class="col-sm-6 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Minum OT Start : </label>
                                        <div class="col-sm-5 col-lg-2">
                                            <div class="input-group">
                                                 <input id="txtMinOT" name="txtMinOT" value='<%=sMinOT%>' type="text" 
                                                     class="form-control" time-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                            <div id="txtMinOTHelpDiv" class="col-sm-6 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Minimun Hour for M4 Employees Start </label>
                                        <div class="col-sm-5 col-lg-2">
                                            <div class="input-group">
                                                 <input id="txtMinM4OT" name="txtMinM4OT" value='<%=sMinM4OT%>' type="text" 
                                                     class="form-control" time-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                        <div id="txtMinM4OTHelpDiv" class="col-sm-6 control-label" style="text-align:left;padding-top:0px;padding-left:0px">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Mid Month Days : </label>
                                        <div class="col-sm-2">
											<input class="form-control" type="text"  style="text-align:right;" id="txtMMDays" name="txtMMDays" value="<%=dMMDays%>"  maxlength="3" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" placeholder="IN DAYS"/>
                                        </div>
                                        <div id="txtMMDaysHelpDiv" class="col-sm-6 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Mid Month Amount : </label>
                                        <div class="col-sm-2">
											<input class="form-control" type="text" style="text-align:right;" id="txtMMAmt" name="txtMMAmt" value="<%=dMMAmt%>" maxlength="5" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" placeholder= "AMOUNT"/>
                                        </div>
                                        <div id="txtMMAmtHelpDiv" class="col-sm-6 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Over time exceed limit : </label>
                                        <div class="col-sm-5 col-lg-2">
                                            <div class="input-group">
                                                <input id="txtOTXHour" name="txtOTXHour" value="<%=sOTXHour%>"  type="text" 
                                                     class="form-control" time-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                            </div>
										</div>
                                        <div id="txtOTXHourHelpDiv" class="col-sm-6 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Pay Period From : </label>
                                        <div class="col-sm-1">
											<input class="form-control" type="text" style="text-align:right;" id="txtPayFrom" name="txtPayFrom" value="<%=sPayFrom%>" maxlength="5" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" placeholder="IN DATES"/>
                                        </div>
                                        <label class="col-sm-1 control-label" style="text-align:center;">To</label>
                                        <div class="col-sm-1">
											<input class="form-control" type="text" style="text-align:right;" id="txtPayTo" name="txtPayTo" value="<%=sPayTo%>" maxlength="5" onkeyup="if (/\D/g.test(this.value)) this.value = this.value.replace(/\D/g,'')" placeholder="IN DATES"/>
                                        </div>
                                        
                                        <div id="txtPayFromHelpDiv" class="col-sm-4 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                        
                                        <div id="txtPayToHelpDiv" class="col-sm-4 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label">Half Day Grace Period </label>
                                        <div class="col-sm-5 col-lg-2">
                                            <div class="input-group">
                                                    <input id="txtHalfDayGr" name="txtHalfDayGr" value="<%=sHalfDayGr%>"  type="text" 
                                                     class="form-control" time-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                        <div id="txtHalfDayGrHelpDiv" class="col-sm-6 control-label" style="text-align:left;padding-top:5px;padding-left:0px">
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button type="submit" id="btnUpdate" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                </div>
                                <!-- /.box-footer -->
                             </div>
                             <!-- /.box -->
                        </form>
                    </div>
                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->

    <!-- ./wrapper -->
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- TimeMask -->
    <script src="plugins/input-mask/jquery.mask.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    
    <script>
    $(document).ready(function() {
	    var textBoxes = $('input [type="text"]');
        $("input").focus (function(){ 
            var helpDiv =  $(this).attr('id') + 'HelpDiv';
            var valueDiv = $('#' + $(this).attr('id')).val(); 
            $('#' + helpDiv).load('tmpathhelp.asp?txtValue=' + valueDiv + '&txthelpDiv=' + helpDiv );
        });
        $("input").blur (function(){ 
            var helpDiv = $(this).attr('id') + 'HelpDiv';
            $('#' + helpDiv).html('');
        });
    });

	</script>

</body>
</html>
