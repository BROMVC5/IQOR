<!DOCTYPE html>
<html>
<head>
     <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>IQOR</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link href="AdminLTE-2.4.8/bower_components/bootstrap/dist/css/bootstrap.css" rel="stylesheet" />
    <link href="AdminLTE-2.4.8/bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <link href="AdminLTE-2.4.8/bower_components/Ionicons/css/ionicons.min.css" rel="stylesheet" />
    <link href="AdminLTE-2.4.8/dist/css/AdminLTE.min.css" rel="stylesheet" />
    <link href="AdminLTE-2.4.8/dist/css/skins/_all-skins.css" rel="stylesheet" />
    <link href="AdminLTE-2.4.8/dist/css/Validation.css" rel="stylesheet" />
    <link href="font_awesome/fontawesome-free-5.8.1-web/css/all.css" rel="stylesheet" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

<%
	Dim sTMFM(15)
	Dim sTMSH(4)
	Dim sTMTE(4)
	Dim sTMPC(7)
	Dim sTMPR(10)
	Dim sTMUTL(0)
	Dim sMSFM(4)
	Dim sMSTE(1)
	Dim sMSPR(3)
	Dim sVRFM(2)
	Dim sVRTE(2)
	Dim sVRPR(2)
	Dim sVRPC(1)
	Dim sMSPC(2)
	'----Check downline start
	function pCheckDown()
	
	    sSQL = "delete from brodown where user_id = '" & Session("USERNAME") & "'"
		conn.execute sSQL 
			
		sSQL = "select * from tmemply where emp_code = '" & Session("USERNAME") & "'"
		Set rstCheckDown = server.CreateObject("ADODB.RecordSet")
		rstCheckDown.Open sSQL , conn, 3 ,3 
		if not rstCheckDown.bof then
			
			sDt = fdatetime2(now)
		
			sSQL = "insert into brodown (emp_code,level,sup_code,create_id,dt_create,user_id,datetime"
			sSQL = sSQL & " ) values ("
			sSQL = sSQL & " '" &  Session("USERNAME")& "',"
			sSQL = sSQL & "'0',"
			sSQL = sSQL & "'" & rstCheckDown("sup_code") & "',"
			sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
			sSQL = sSQL & ")"
			conn.execute sSQL 
		
		end if 
			
		i = 0
		bStop  = false
		do while bStop = false
		
			sSQL = "select * from brodown where user_id  = '" & Session("USERNAME") &" '"
			sSQL = sSQL & " and datetime = '" & sDt & "'"
			sSQL = sSQL & " and level = '" & i & "'"
			Set rstTemp2 = server.CreateObject("ADODB.RecordSet")
			rstTemp2.Open sSQL, conn, 3 ,3 
			if not rstTemp2.bof then
		
				do while not rstTemp2.eof 
		
					sSQL = "select * from tmemply where sup_code = '"  & rstTemp2("emp_code")  & "'"
					Set rstTemp3 = server.CreateObject("ADODB.RecordSet")
					rstTemp3.Open sSQL , conn, 3 ,3 
					if not rstTemp3.bof then
						do while not rstTemp3.eof 
						
							sSQL = "insert into brodown (emp_code,level,sup_code,create_id,dt_create,user_id,datetime"
							sSQL = sSQL & " ) values ("
							sSQL = sSQL & " '" & rstTemp3("emp_code") & "',"
							sSQL = sSQL & "'" & i + 1 & "',"
							sSQL = sSQL & "'" & rstTemp3("sup_code") & "',"
							sSQL = sSQL & "'" & session("USERNAME") & "'," 
						    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
						    sSQL = sSQL & "'" & session("USERNAME") & "'," 
		    				sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    				sSQL = sSQL & ")"
							conn.execute sSQL 
		
					
							rstTemp3.movenext
						loop
					
					end if 
				
				
					rstTemp2.movenext
				loop
				
			
			else
				bStop =  true 	
			end if 
			
			i = i + 1
			
		loop
		
	End function
    '----Check downline end

	function takeSession()
		'--CANTEEN SYSTEM start
		Set rstCSPass = Server.CreateObject("ADODB.Recordset")
		sSQL = "select * from cspass where ID = '"& rstBROPASS("ID") &"'"
		rstCSPass.Open sSQL, conn, 3, 3
		If Not rstCSPass.BOF Then
			
			if rstCSPass("CSACCESS") = "C" then
				Response.redirect("cspos.asp")	
			end if
			
		end if	 
		call pCloseTables(rstCSPass)
		'--CANTEEN SYSTEM end
		
		'--OUTGOING GOOD PASS SYSTEM start
		Set rstOGPass = Server.CreateObject("ADODB.Recordset")
		sSQL = "select * from ogpass where ID = '"& rstBROPASS("ID") &"'"
		rstOGPass.Open sSQL, conn, 3, 3
		If Not rstOGPass.BOF Then
			
			if rstOGPass("OGACCESS") = "S" then
				Response.redirect("oglist.asp")	
			end if
			
		end if
		call pCloseTables(rstOGPass)	 
		'--OUTGOING GOOD PASS SYSTEM end	    
	
		Set rstTMPASS = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select * from TMPASS where ID='" & rstBROPASS("ID") & "'" 
		rstTMPASS.Open sSQL, conn, 3, 3   
		if not rstTMPASS.eof then
				for i = 0 to Ubound(sTMFM)
					if i = 0 then
						Session("TMFM") = rstTMPASS("TMFM")
					else
						Session("TMFM" & i) = rstTMPASS("TMFM" & i)
					end if 
				next
				for i = 0 to Ubound(sTMSH) 
					if i = 0 then
						Session("TMSH") = rstTMPASS("TMSH")
					else
						Session("TMSH" & i) = rstTMPASS("TMSH" & i)
					end if
				next
				for i = 0 to Ubound(sTMTE)
					if i = 0 then
						Session("TMTE") = rstTMPASS("TMTE")
					else
						Session("TMTE" & i) = rstTMPASS("TMTE" & i)
					end if
				next
                for i = 0 to Ubound(sTMPC)
					if i = 0 then
						Session("TMPC") = rstTMPASS("TMPC")
					else
						Session("TMPC" & i) = rstTMPASS("TMPC" & i)
					end if
				next
				for i = 0 to Ubound(sTMPR)
					if i = 0 then
						Session("TMPR") = rstTMPASS("TMPR")
					else
						Session("TMPR" & i) = rstTMPASS("TMPR" & i)
					end if
				next
				for i = 0 to Ubound(sTMUTL)
					if i = 0 then
						Session("TMUTL") = rstTMPASS("TMUTL")
					else
						Session("TMUTL" & i) = rstTMPASS("TMUTL" & i)
					end if
				next
		end if
		pCloseTables(rstTMPASS)

		Set rstMSPASS = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select * from MSPASS where ID='" & rstBROPASS("ID") & "'" 
		rstMSPASS.Open sSQL, conn, 3, 3   
		if not rstMSPASS.eof then
			for i = 0 to Ubound(sMSFM) 
				if i = 0 then
					Session("MSFM") = rstMSPASS("MSFM")
				else
					Session("MSFM" & i) = rstMSPASS("MSFM" & i)
				end if
			next 
			for i = 0 to Ubound(sMSTE) 
				if i = 0 then 
					Session("MSTE") = rstMSPASS("MSTE")
				else
					Session("MSTE" & i) = rstMSPASS("MSTE" & i)
				end if
			next 
			for i = 0 to Ubound(sMSPR)
				if i = 0 then
					Session("MSPR") = rstMSPASS("MSPR")
				else
					Session("MSPR" & i) = rstMSPASS("MSPR" & i)
				end if
			next
			for i = 0 to Ubound(sMSPC)
				if i = 0 then
					Session("MSPC") = rstMSPASS("MSPC")
				else
					Session("MSPC" & i) = rstMSPASS("MSPC" & i)
				end if
			next 
		end if
		pCloseTables(rstMSPASS)
	
		Set rstVRPASS = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select * from VRPASS where ID='" & rstBROPASS("ID") & "'" 
		rstVRPASS.Open sSQL, conn, 3, 3   
		if not rstVRPASS.eof then
			for i = 0 to Ubound(sVRFM)
				if i = 0 then
					Session("VRFM") = rstVRPASS("VRFM")
					Session("VRTE") = rstVRPASS("VRTE")
					Session("VRPR") = rstVRPASS("VRPR")
				else
					Session("VRFM" & i) = rstVRPASS("VRFM" & i)
					Session("VRTE" & i) = rstVRPASS("VRTE" & i)
					Session("VRPR" & i) = rstVRPASS("VRPR" & i)
				end if
			next 
			for i = 0 to Ubound(sVRPC)
				if i = 0 then
					Session("VRPC") = rstVRPASS("VRPC")
				else
					Session("VRPC" & i) = rstVRPASS("VRPC" & i)
				end if
			next 
		end if
		pCloseTables(rstVRPASS)
	end function
%>

<%

If request("txtLogin") <> "" Then
	'--check for correct characters entered by the user and set variable
	'--value so that it can display appropriate message afterward
	If fValidate(request("txtLogin"), "1") = "N" Then
		errorLogin = "Y"
	End If
	If fValidate(request("txtPass"), "1") = "N" Then
		errorPass = "Y"
	End If
	

	'--check for valid data entered by the user
	If Trim(request("txtLogin")) <> "" And errorLogin <> "Y" and errorPass <> "Y" Then
		Set rstBROPASS = Server.CreateObject("ADODB.Recordset")
		sSQL = "SELECT * FROM BROPASS WHERE ID = '" & Request("txtLogin") & "'"
		sSQL = sSQL & " and STATUS = 'A' "
		rstBROPASS.Open sSQL, conn, 3, 3
		If rstBROPASS.EOF = False And rstBROPASS.BOF = False Then
			
            sFSLogin = rstBROPASS("FSLOGIN")
			sPassCode = pPassConv(request("txtPass"))
			session("CPACCESS") = rstBROPASS("CPACCESS")
			session("CSACCESS") = rstBROPASS("CSACCESS")
			session("MSACCESS") = rstBROPASS("MSACCESS")
			session("OGACCESS") = rstBROPASS("OGACCESS")
			session("TMACCESS") = rstBROPASS("TMACCESS")
			session("TSACCESS") = rstBROPASS("TSACCESS")
			session("VRACCESS") = rstBROPASS("VRACCESS")
			
			sResign = "N"
			
			Set rstTMRESIGN = Server.CreateObject("ADODB.Recordset")
			sSQL = "SELECT * FROM TMEMPLY WHERE EMP_CODE = '" & rstBROPASS("ID") & "'"
			sSQL = sSQL & " and DT_RESIGN IS NOT NULL "
			rstTMRESIGN.Open sSQL, conn, 3, 3
			If not rstTMRESIGN.eof then
				sResign = "Y"
			end if
			
			If IsNull(rstBROPASS("DATELASTUSE")) Then
				dtLastUse = 0 - CDate("01/01/1980")
			Else
				dtLastUse = rstBROPASS("DATELASTUSE") - CDate("01/01/1980")
			End If 
			
            sCheckPass = sPassCode + CLng(dtLastUse)

       		If cint(rstBROPASS("PASSWORD"))= cint(sCheckPass) and sResign = "N" Then
		        
                Session("USERNAME") = rstBROPASS("ID") 

				Set rstTMEMPLY = Server.CreateObject("ADODB.Recordset")
				sSQL = "SELECT * FROM TMEMPLY WHERE EMP_CODE = '" & rstBROPASS("ID") & "'"
				rstTMEMPLY.Open sSQL, conn, 3, 3
				If rstTMEMPLY.EOF = False Then          
					Session("NAME") = rstTMEMPLY("NAME")
					Session("ATYPE") = rstTMEMPLY("ATYPE")
                else 
                    Session("NAME") = rstBROPASS("NAME")
				end if
                
                sSQL = "UPDATE BROPASS SET"
                sSQL = sSQL & " DATELASTUSE = '" & fdatetime2(Now()) & "',"
                sSQL = sSQL & " PASSWORD = '" & sPassCode + CLng(Now - CDate("01/01/1980")) & "'"
                sSQL = sSQL & " WHERE ID = '" & rstBROPASS("ID") & "'"
                conn.execute sSQL
    
                Dim M_SECU
				Dim M_CVT
				Dim M_SERIAL
				Dim M_ADD1, M_ADD2, M_ADDI
				Dim i
				Dim dtInsDate
				Dim bSerialOK
		
				M_SECU=""
				M_CVT=""
				M_SERIAL=""
				M_ADD1=""
				M_ADD2=""
				M_ADDI=""
	
				i=0
				Set rstBROPath= Server.CreateObject("ADODB.Recordset")
				sSQL = "select * from bropath"
				rstBROPath.Open sSQL, conn, 3, 3

				If Not IsNull(rstBROPath("INS_DATE")) Then
				    dtInsDate = rstBROPath("INS_DATE")
				Else
				    dtInsDate = DateSerial(1980, 1, 1)
				End If
				
				M_SECU = " 4632456756715248873891723079374283492872"
				M_CVT = Trim(rstBROPath("CONAME"))
				'If Date >= DateAdd("d", 60, dtInsDate) Then
				 '   M_SERIAL = ""
				  '  For i = 2 To 11 Step 2
				   '     M_ADD1 = CDBL(Mid(M_SECU, i, 2))
				    '    M_ADD2 = CDBL(Mid(M_CVT, i, 2))
				     '   
				      '  if Len(Abs(M_ADD1 - M_ADD2)) = 1 then
				       ' 	M_ADDI = "0" & Len(trim(Abs(M_ADD1 - M_ADD2)))
				       ' else
				        '	M_ADDI = trim(Abs(M_ADD1 - M_ADD2))
				        'end if
				        'M_SERIAL = M_SERIAL + M_ADDI
				    'Next
				    'If rstBROPath("RETSEL") <> M_SERIAL Then
				     '   bSerialOK = "EXPIRED"
				    'Else
				     '   bSerialOK = "OK"
				    'End If

				'ElseIf Date >= DateAdd("d", 46, dtInsDate) Then
				 '   M_SERIAL = ""
				  '  For i = 2 To 11 Step 2
				   '     M_ADD1 = CDBL(Mid(M_SECU, i, 2))				        
				    '    M_ADD2 = CDBL(Mid(M_CVT, i, 2))
				      '  if Len(Abs(M_ADD1 - M_ADD2)) = 1 then
				     '   	M_ADDI = "0" & Len(trim(Abs(M_ADD1 - M_ADD2)))
				       ' else
				        '	M_ADDI = trim(Abs(M_ADD1 - M_ADD2))
				        'end if
				       ' M_SERIAL = M_SERIAL + M_ADDI
				    'Next
				    'If rstBROPath("RETSEL") <> M_SERIAL Then
				'		bSerialOK = "WILL EXPIRE"
				 '   Else
				 '       bSerialOK = "OK"
				  '  End If
				'else
					bSerialOK = "OK"
				'End If
				
				if bSerialOK = "OK" then
					If Not rstBROPath.BOF Then
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
				        response.write gCompanyName
			        Else
			        	gCompanyName = "BRO SOFTWARE HOUSE (M) SDN BHD - DEMO"
			        End If
			        
					SESSION("CONAME") = sCoName	
                	response.write sCoName
                	'response.end
					
					Call takeSession()
                	Call pCheckDown()

                    if sFSLogin = "Y" then
					    Response.Redirect("bropasschg.asp")    
				    else
                        Response.redirect("system.asp")
					end if 
	
                elseif bSerialOK = "WILL EXPIRE" then
                Call pCheckDown()
				Call takeSession()
				Response.Write ("<script language='javascript'>") 
				Response.Write ("window.alert('This Product will expired on " & DateAdd("d", 60, dtInsDate) & _
								" and User have " & DateDiff("d", Date, DateAdd("d", 60, dtInsDate)) & _
								" Day(s) to obtain and enter subsequent Product Activation" & _
								" Key to continue the operation of the BRO Software is ensured. " & _
								" Note : The User should allow at least 2 working days for delivery of " & _
								"a new Product Activation Key by BRO ');")
				Response.Write ("window.location='system.asp'")
				Response.Write ("</script>")
				elseif bSerialOK = "EXPIRED" then
					Response.Write ("<script language='javascript'>") 
					Response.Write ("window.alert('Invalid Serial No.  Please contact your dealer for verification.');")
					Response.Write ("window.location='login.asp'")
					Response.Write ("</script>")     
				end if
	        Else
				noPass = "Y"
			End If
		Else
      
			noID = "Y"
		End If
		
		rstBROPASS.Close
		Set rstBROPASS = Nothing
	End If
	
Else
	'--set an initial value so that when first time visit
	'--this page it won't show error message to user
	If Request("txtLogin") = "" Then
		noID = "N"
	End If
		
	Session("USERNAME") = ""
End If

%>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <img src="dist/img/iqor-logo-white-218x70.png"/>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">Sign in to start your session</p>
        <form action="login.asp" method="post" name="Form1">
            <div class="form-group has-feedback">
                <input class="form-control" name="txtLogin" placeholder="User">
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
                <% 
                    If noID = "N" Then
                        Response.Write("<" & "script language=JavaScript>")
			            Response.Write("document.Form1.txtLogin.focus();")
			            Response.Write("<" & "/script>")
		            End If

		            If noID = "Y" Then
                %>
                    <span><label style="color:red">Invalid ID!</label></span>
                    <script>
                        document.Form1.txtLogin.focus();
                    </script>
                <% End If %>
                <% If errorLogin = "Y" Then %>
                    <!--<div class="col-xs-8 pull-left" >-->
                        <span><label style="color:red">Invalid Characters for ID!</label></span>
                        <script>
                            document.Form1.txtLogin.focus();
                        </script>
                    <!--</div>-->
                <% End If %>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" id="txtPass" name="txtPass"
                        maxlength="10" placeholder="Password">
                <span toggle="#txtPass" class="glyphicon glyphicon-eye-close field-icon toggle-password"></span>
                <% If noPass = "Y" Then %>
                    <span><label style="color:red">Password Incorrect!</label></span>
                    <script>
                        document.Form1.txtLogin.focus();
                    </script>
                <% End If %>
                <% If errorPass = "Y" Then %>
                    <span><label style="color:red;margin-left:28px">Invalid Characters for Password</label></span>
                    <script>
                        document.Form1.txtLogin.focus();
                    </script>
                <% End If %>
            </div>
            <div class="row">
                
            </div>
            <div class="row">
                <div class="col-xs-4 pull-left" >
                    <a href="broforgot.asp" class="btn btn-link">Forgot password?</a>
                </div>
                <div class="col-xs-4 pull-right" >
                    <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                </div>
            </div>
            <!-- /.col -->
        </div>
    </form>
    <!-- /.social-auth-links -->
</div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
</body>
<script src="AdminLTE-2.4.8/bower_components/jquery/dist/jquery.min.js"></script>
<script src="AdminLTE-2.4.8/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

<script>

//=== Show and unshow password
$(".toggle-password").click(function () {
    //=== Proper way of doing toggleClass for glyphicon and font-awesome
    $(this).toggleClass('glyphicon-eye-close', 'remove');
    $(this).toggleClass('glyphicon-eye-open', 'add');
    //=================================================================
    var input = $($(this).attr("toggle"));
    if (input.attr("type") == "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});

</script>
</html>
