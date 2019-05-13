<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->
    <!--#include file="include/clsUpload.asp"-->
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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css">

</head> 
<%	
	sTicket = request("txtTicket")
	sSearch = request("txtSearch")
    sMode = request("mode")
	set o = new clsUpload
	
	
	if o.Exists("btnSubmit") then
	
		sFileName = o.FileNameOf("txtFile")
		
		if sFileName = "" then
			
			call alertbox("No file selected, please re-upload")
				
		else 
			
			sFileExt = Mid(sFileName, InstrRev(sFileName, ".") + 1)
			sFile = sTicket & "." & sFileExt
			o.FileInputName = "txtFile"
			o.FileFullPath = server.mappath("attachment\" & sFile )
			o.save
		 	if o.Error = "" then
				sFL = replace(sFile,".zip","")
				
				sMainURL = "ogprop_det.asp?"
		        sAddURL = "txtTicket=" & sTicket & "&txtSearch=" & sSearch 
				
				Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
			    sSQL = "select * from ogprop " 
			    sSQL = sSQL & "where TICKET_NO = '" & pRTIN(sTicket) & "' "
			    rstOGProp.Open sSQL, conn, 3, 3
				if not rstOGProp.eof then
					sSQL = "UPDATE ogprop SET "             
		            sSQL = sSQL & "ATTACH = '" & pRTIN(sFile) & "' "            
		            sSQL = sSQL & "WHERE TICKET_NO = '" & pRTIN(sTicket) & "'"
		            conn.execute sSQL
				end if
				call pCloseTables(rstOGProp)
				
		        response.redirect sMainURL & sAddURL			
			else
				response.write "Failed due to the following error: " & o.Error
			end if
		
		end if
	end if
	set o = nothing
	
	MyNewRandomNum5 = 0
	Randomize
	MyNewRandomNum5 = Int(Rnd * 100000) '--range from 0 to 99999
	MyNewRandomNum5 = Right(CStr(MyNewRandomNum5),5)
	MyNewRandomNum5 = String(5 - Len(MyNewRandomNum5), "0") & MyNewRandomNum5
	
	Set rstOGPass = server.CreateObject("ADODB.RecordSet")
	sql = "select * from ogpass where ID = '" & session("USERNAME") & "' "
	rstOGPass.Open sql, conn, 3, 3
	if not rstOGPass.eof then
		if rstOGPass("OGACCESS") = "N" then
			sAccess = "N"
		elseif rstOGPass("OGACCESS") = "A" then
			sAccess = "A"
		elseif rstOGPass("OGACCESS") = "F" then
			sAccess = "F"
		elseif rstOGPass("OGACCESS") = "D" then
			sAccess = "D"
		elseif rstOGPass("OGACCESS") = "S" then
			sAccess = "S"
		end if
	end if
	call pCloseTables(rstOGPass)
%>
<body>
    <form name="form1" class="form-horizontal" action="ogupload.asp?txtTicket=<%=sTicket%>&txtSearch=<%=sSearch%>" enctype="multipart/form-data" method="post">
        <input type="hidden" name="txtTicket" value='<%=sTicket%>' />
        <div class="box-body" >
            <div class="form-group">
            	<!-- Ticket No -->                                   
                <div class="form-group">
                    <label class="col-sm-5 control-label">Ticket No : </label>
                    <div class="col-sm-6">
                       <span class="mod-form-control"><% response.write sTicket %></span>
                    </div>
                </div>
                
                <!-- File Name -->
                <div class="form-group">
                    <label class="col-sm-5 control-label">Select File :</label>
                    <div class="col-sm-2" >
                        <input type ="file" name="txtFile">
                    </div>
                </div>
                                               
           </div>
        </div>
        <!-- /.box-body -->
        <div class="box-footer">
            <button type="button" class="btn btn-default pull-left" data-dismiss="modal" aria-label="Close" style="width: 90px;">Close</button>
            <input type="submit" name="btnSubmit" value="Upload" class="btn btn-success pull-right" style="width: 90px">
        </div>
        <!-- /.box-footer --> 
    </form>                  
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>

</body>
</html>