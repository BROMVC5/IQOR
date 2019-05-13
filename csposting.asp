<!DOCTYPE html>
<% Server.ScriptTimeout = 1000000 %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>IQOR</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css" />
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css" />
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI CSS -->
    <link href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <!--<script src="dist/js/pages/dashboard.js"></script>-->
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap 3.3.6 CSS-->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
    <!-- Date Picker -->
	<link rel="stylesheet" href="plugins/datepicker/datepicker3.css">


	
</head>

<%
Set rstCSPath = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from cspath " 
rstCSPath.Open sSQL, conn, 3, 3
if not rstCSPath.eof then
	sServerDIR = Split(rstCSPath("SERVERDIR"),";")
	sServerIP = trim(sServerDIR(0)) 
	sServerDB = trim(sServerDIR(1)) 
end if
pCloseTables(rstCSPath)

Set conn2 = Server.CreateObject("ADODB.Connection")
DSNtemp2 ="Driver={MySQL ODBC 5.3 Unicode Driver};"
DSNtemp2 = DSNtemp & "Server=" & ""& sServerIP  &"" & ";Port=3307;UID=root;Password=Pass;Database="& sServerDB &";OPTION=3;"
conn2.Open DSNtemp2

%>

<body>
<%
	sModeSub = request("sub")
	
	if sModeSub <> "" Then
		
		if sModeSub = "import" Then
			
			Set rstSVRCSEmply = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from csemply " 
            rstSVRCSEmply.Open sSQL, conn2, 3, 3
			if not rstSVRCSEmply.eof then
				
				sSQL = "delete from csemply "
				conn.execute sSQL

				Do while not rstSVRCSEmply.eof
				
					sSQL = "insert into csemply (EMP_CODE, NAME, CARDNO, COUPON, STATUS, "
		            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
		            sSQL = sSQL & "values ("
				    sSQL = sSQL & "'" & pRTIN(rstSVRCSEmply("EMP_CODE")) & "',"		 
				    sSQL = sSQL & "'" & pRTIN(rstSVRCSEmply("NAME")) & "',"
				    sSQL = sSQL & "'" & pRTIN(rstSVRCSEmply("CARDNO")) & "',"
				    sSQL = sSQL & "'" & rstSVRCSEmply("COUPON") & "',"
				    sSQL = sSQL & "'" & rstSVRCSEmply("STATUS") & "',"
				    sSQL = sSQL & "'" & session("USERNAME") & "'," 
				    sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
				    sSQL = sSQL & "'" & session("USERNAME") & "'," 
				    sSQL = sSQL & "'" & fDatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
		 	  	    conn.execute sSQL
		 	  	    
				rstSVRCSEmply.movenext
				Loop
			end if
			pCloseTables(rstSVRCSEmply)

			Set rstSVRCSEmply1 = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from csemply1 " 
            rstSVRCSEmply1.Open sSQL, conn2, 3, 3
			if not rstSVRCSEmply1.eof then
				sSQL = "delete from csemply1 "
				conn.execute sSQL
				
				Do while not rstSVRCSEmply1.eof
				
					sSQL = "insert into csemply1 (EMP_CODE, TYPE, DT_SUB, AMOUNT, "
		            sSQL = sSQL & "CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
		            sSQL = sSQL & "values ("
				    sSQL = sSQL & "'" & pRTIN(rstSVRCSEmply1("EMP_CODE")) & "',"		 
				    sSQL = sSQL & "'" & pRTIN(rstSVRCSEmply1("TYPE")) & "',"
				    sSQL = sSQL & "'" & fDate2(rstSVRCSEmply1("DT_SUB")) & "',"
				    sSQL = sSQL & "'" & rstSVRCSEmply1("AMOUNT") & "',"
				    sSQL = sSQL & "'" & session("USERNAME") & "',"
				    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
				    sSQL = sSQL & "'" & session("USERNAME") & "',"
				    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
		            conn.execute sSQL
		 	  	    
				rstSVRCSEmply1.movenext
				Loop
			end if
			pCloseTables(rstSVRCSEmply1)
    
            sSQL = "UPDATE cspath SET "
            sSQL = sSQL & "DT_IMP = '" & fdatetime2(Now()) & "'"
            conn.execute sSQL
			
			call alertbox("Import Succesful!")
			
		elseif sModeSub = "export" Then
			dtFrDate = reqform("dtpFrDate")
			dtToDate = reqform("dtpToDate")
			
			if reqform("cbkExport") = "on" Then
				if dtFrDate = "" then   		
		       		call alertbox("From Date cannot be empty")
		   		end if
		    
		        if dtToDate = "" then
		            call alertbox("To Date cannot be empty")
		        end if
				
				Set rstCSTrns = server.CreateObject("ADODB.RecordSet")
				sSQL = "select * from cstrns "
				sSQL = sSQL & "where DATETIME BETWEEN '" & fDate2(dtFrDate) & " 00:00:00' AND '" & fDate2(dtToDate) & " 23:59:59' "
				
			else
			
				Set rstCSTrns = server.CreateObject("ADODB.RecordSet")
				sSQL = "select * from cstrns "
				sSQL = sSQL & "where POST = 'N' "
				
			end if
			
			rstCSTrns.Open sSQL, conn, 3, 3	
			if not rstCSTrns.eof then
				Do while not rstCSTrns.eof
				On Error Resume Next
					
					sSQL = "insert into cstrns (REFNO, CARDNO, COUPON, TYPE, DT_TRNS, STATUS, "
					sSQL = sSQL & "USER_ID, DATETIME) "
					sSQL = sSQL & "values ("
					sSQL = sSQL & "'" & pRTIN(rstCSTrns("REFNO")) & "',"
					sSQL = sSQL & "'" & pRTIN(rstCSTrns("CARDNO")) & "',"
					sSQL = sSQL & "'" & pRTIN(rstCSTrns("COUPON")) & "',"		 
					sSQL = sSQL & "'" & pRTIN(rstCSTrns("TYPE")) & "',"
					sSQL = sSQL & "'" & fDatetime2(rstCSTrns("DT_TRNS")) & "',"
					sSQL = sSQL & "'" & rstCSTrns("STATUS") & "',"
					sSQL = sSQL & "'" & session("USERNAME") & "',"
					sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
					sSQL = sSQL & ") "
					conn2.execute sSQL
					
					sSQL = "UPDATE cstrns SET "                      
					sSQL = sSQL & "POST = 'Y',"		 
					sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "'," 
					sSQL = sSQL & "DATETIME ='" & fdatetime2(Now()) & "'"
					sSQL = sSQL & "WHERE REFNO = '" & rstCSTrns("REFNO") & "'"
					conn.execute sSQL
  	    
				rstCSTrns.movenext
				Loop

			end if
			pCloseTables(rstCSTrns)
			
			call alertbox("Export Succesful!")
		
		end if
	end if
	
%>	

<!-- form group -->
<div class="col-sm-12" style="top:25vh" align="center">
	<form class="form-horizontal" action="csposting.asp" method="post">
		<div class="form-group">
			<button type="submit" name="sub" value="import" class="btn btn-success" style="width: 600px;height: 100px"><font size="20">Import</font></button>
			<br/>*Import master file from server to workstation. <br/><br/>
			

			<button type="submit" name="sub" value="export" class="btn btn-success" style="width: 600px;height: 100px"><font size="20">Export</font></button>
			<br/>*Export new transaction file from workstation to server. <br/>
			<input type="checkbox" id="cbkExport" name="cbkExport" onclick="hideDiv()"/> Mark to export from date to date.<br/><br/>
			
           <div id="divType" >							
               <!-- form group -->
               <div class="form-group" >
               
               		<!--From Date-->
               		<div class="col-sm-3" >
                    	<label class="control-label"></label>
                    </div>

                    <div class="col-sm-3" >
                        <div class="input-group">
                            <input id="dtpFrDate" name="dtpFrDate"  type="text" class="form-control" date-picker >
                            <span class="input-group-btn">
                                <a href="#" id="btndt_Frdate" class="btn btn-default" style="margin-left: 0px">
                                    <i class="fa fa-calendar"></i>
                                </a>
                            </span>
                        </div>
                    </div>
                    
					<!--To Date-->
                    <div class="col-sm-1" >
                    	<label class="control-label">To </label>
                    </div>
                    <div class="col-sm-3">
                        <div class="input-group">
                            <input id="dtpToDate" name="dtpToDate"  type="text" class="form-control" date-picker >
                            <span class="input-group-btn">
                                <a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
                                    <i class="fa fa-calendar"></i>
                                </a>
                            </span>
                            <br/>
                        </div>
                    </div>  

			   </div>
			   <!--/.form group -->
		   </div>
			
			<input type="button" class="btn btn-info" name="btnReturn" value="Back" style="width: 600px;height: 100px;font-size: 50px" onclick="window.location = ('<%="cspos.asp"%>');" />
			
		</div>
	</form>
</div>    
<!--/.form group -->


<!-- datepicker -->
<script src="plugins/datepicker/bootstrap-datepicker.js"></script>


<!--Script Start-->
<!--Document Ready-->
<script>
$( document ).ready(function() {
var x = document.getElementById("cbkExport").checked;
if (x == false){
	$("#divType").hide();
}else{
	$("#divType").show();
}
});
</script>

<!--Onclick Hide Div-->
<script>
function hideDiv(){
var x = document.getElementById("cbkExport").checked;
if ( x == false ){
	$("#divType").hide();
	}
else{
	$("#divType").show();
}
};
</script>

<!--date picker-->
<script>
$('#btndt_Frdate').click(function () {
    $('#dtpFrDate').datepicker("show");
});

$('#btndt_Todate').click(function () {
    $('#dtpToDate').datepicker("show");
}); 


$(function () {        
   $("[date-picker]").datepicker({
        format: "dd/mm/yyyy",
        autoclose: true,
        })
});
$(function () {
    //Date picker
    $("[date-picker]").datepicker({
        format: "dd/mm/yyyy",
        autoclose: true,
        })
});

</script>
    
		  
</body>
</html>
