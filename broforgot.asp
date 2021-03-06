<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Forgot Password</title>
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
    sMainURL = "login.asp?"
    sModeSub = reqForm("sub")

    if sModeSub <> "" Then

        sID = reqFormU("txtID")

        Dim max,min
        max=10000
        min=1
        
        sTempPass = (Int((max-min+1)*Rnd+min))

        Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select EMAIL from TMEMPLY where EMP_CODE='" & sID & "'" 
        rstTMEmply.Open sSQL, conn, 3, 3
        if not rstTMEmply.eof then
            sEmail = rstTMEmply("EMAIL")
        end if
        pCloseTables(rstTMEmply)


        '=== BRO PASS
        sSQL = "UPDATE BROPASS SET "             
            
        if sTempPass <>"" then
            sSQL = sSQL & "PASSWORD = '" & (pPassConv(sTempPass)+CLng(Now - CDate("01/01/1980"))) & "',"
            sSQL = sSQL & "DATELASTUSE ='" & fDatetime2(Now()) & "',"
        end if
            
        sSQL = sSQL & "FSLOGIN = 'Y',"

        sSQL = sSQL & "NAME = '" & pRTIN(sName) & "',"
        sSQL = sSQL & "STATUS = '" & sStatus & "',"
        sSQL = sSQL & "PWDMNT = '" & sChkGEN & "',"
        sSQL = sSQL & "DATEUPDT = '" & fDatetime2(Now()) & "',"
        sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
        sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
        sSQL = sSQL & " WHERE ID = '" & sID & "'"
        conn.execute sSQL

        sSQL = "select smtp, sdemail, sdpw, port, usessl, coname from BROPATH "
		set rstBROPATH = server.CreateObject("ADODB.Recordset")
		rstBROPATH.open sSQL, conn, 3, 3
		If rstBROPATH.bof = false and rstBROPATH.eof = false then
			sSMTP = rstBROPATH("SMTP")
			sSDEMAIL =  rstBROPATH("SDEMAIL")
			sSDPW = rstBROPATH("SDPW")
			sPORT = rstBROPATH("PORT")
			sUSESSL = rstBROPATH("USESSL")

            If sUSESSL = "T" Then
                sUSESSL = "True"
            Else
                sUSESSL = "False"
            End If 
        
            sCoName = ""
			sSecu = "3289762759827438927432934872973897486433"
			sCVT = Trim(rstBROPath("CONAME"))
			lStart = 1
			lCount = 2
			Do While True
				lA = CDBL(Mid(sCVT, lCount, 2))
				lB = CDBL(Mid(sSecu, lStart, 1))
				sC = Chr(lA - lB)
				sCoName = sCoName + sC
				If lCount < Len(sCVT) - 2 Then
				    lCount = lCount + 2
				    lStart = lStart + 1
				Else
				    Exit Do
				End If
			Loop
    
		end if
		pCloseTables(rstBROPATH)
		
		if sSDEmail <> "" then
		
			sMess = "COMPANY : " & sCoName & "<br>"
			sMess = sMess & "We have received a request to reset your iQOR system password.<br>"
			sMess = sMess & "Click the link below to choose a new one:<br>"
			sMess = sMess & "<html>"
            sMess = sMess & "<a href='http://localhost/iqor/bropasschg.asp?txtID=" & sID & "'>Reset Your Password </a><br>"
            sMess = sMess & "<br>"
            sMess = sMess & "If you did not make this request, please contact your administrator immediately! "
            sMess = sMess & "</html>"
				
			if sEmail <> "" then
				Set ObjSendMail = CreateObject("CDO.Message")
							
				ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
				ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = sSMTP
				ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = sPORT
				ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = sUSESSL
				ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
				ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
				ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = sSDEMAIL
				ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = sSDPW
				ObjSendMail.Configuration.Fields.Update
		
				ObjSendMail.Subject = "iQOR System Password reset link"
				ObjSendMail.From = "no-reply@iqor.com"
				ObjSendMail.To = sEmail
				ObjSendMail.HTMLBody = sMess
				ObjSendMail.Send
				    
				Set ObjSendMail = Nothing
			end if
        
        end if 
            
        call confirmBox("A temporary password has been sent to your email, please follow the link to change your password.", sMainURL)

    End If
        
    %>
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Forgot Password</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="broforgot.asp" method="post">
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%="txtEmp_CODE="& sID %>');" />
                                </div><!-- /.box-header -->
                                 <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform: uppercase" required onabort/>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <button type="button" class="btn btn-info pull-right" style="width: 180px" onclick="check();">Reset and Generate</button>
                                    <button type="submit" id="btnUpdate" name="sub" value="up" class="btnSaveHide" ></button>
                                </div> <!-- /.box-footer -->

                            </div><!-- /.box -->
                        </form>
                    </div><!-- /.col-md-12 -->
                </div><!-- /.row -->
            </section><!-- /.content -->
        </div><!-- /.content-wrapper -->
        
        <!-- #include file="include/footer.asp" -->

    </div><!-- ./wrapper -->

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
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

    <script>

    function check(){
        
        var sGenerate;
        var key = "EMAIL";
        var url_to	= 'ajax/ax_notexist.asp';  
            
        $.ajax({
            url     : url_to,
            type    : 'POST',
            async   : false,
            data    :   {   
                            "txtWhat" : key,
                            "txtID":$("#txtID").val(),
                        }, 
             
            success : function(res)
            {
                        
                if(res.data.status == "notexist")
                {
                    return alert(res.data.value);

                }else if (res.data.status == "OK") 
                {
                    sGenerate = "Y"
                }
     
            if (sGenerate == "Y"){

                $('#btnUpdate').click();
            }

            },
           

            error	: function(error)
            {
                console.log(error);
            }
        });
        
    }

    </script>

</body>
</html>
