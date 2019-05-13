<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <link rel="icon" type="image/png" href="../assets/img/favicon.ico">
	<link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>iQOR</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />

	<!-- Bootstrap core CSS     -->
	<link href="assets/css/bootstrap.min.css" rel="stylesheet" />
	<link href="assets/css/paper-kit.css?v=2.1.0" rel="stylesheet"/>

    <!--     Fonts and icons     -->
	<link href='http://fonts.googleapis.com/css?family=Montserrat:400,300,700' rel='stylesheet' type='text/css'>
	<link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
	<link href="assets/css/nucleo-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.min.css">
    
<%
	Dim sTMFM(13)
	Dim sTMSH(4)
	Dim sTMTE(4)
	Dim sTMPC(6)
	Dim sTMPR(10)
	Dim sTMUTL(0)
	Dim sMSFM(4)
	Dim sMSTE(1)
	Dim sMSPR(2)
	Dim sVRFM(2)
	Dim sVRTE(2)
	Dim sVRPR(2)
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

%>
<%
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
		rstBROPASS.Open sSQL, conn, 3, 3
		If rstBROPASS.EOF = False And rstBROPASS.BOF = False Then
			
            sFSLogin = rstBROPASS("FSLOGIN")
			sPassCode = pPassConv(request("txtPass"))
			
			If IsNull(rstBROPASS("DATELASTUSE")) Then
				dtLastUse = 0 - CDate("01/01/1980")
			Else
				dtLastUse = rstBROPASS("DATELASTUSE") - CDate("01/01/1980")
			End If 
			
            sCheckPass = sPassCode + CLng(dtLastUse)
    					
       		If cint(rstBROPASS("PASSWORD"))= cint(sCheckPass) Then
		        
                Session("USERNAME") = rstBROPASS("ID") 

				Set rstTMEMPLY = Server.CreateObject("ADODB.Recordset")
				sSQL = "SELECT * FROM TMEMPLY WHERE EMP_CODE = '" & rstBROPASS("ID") & "'"
				rstTMEMPLY.Open sSQL, conn, 3, 3
				If rstTMEMPLY.EOF = False Then          
					Session("NAME") = rstTMEMPLY("NAME")
					Session("ATYPE") = rstTMEMPLY("ATYPE")
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
<body>
     <div class="wrapper">
        <div class="page-header">
        <!--<div class="page-header" style="background-image: url('assets/img/antoine-barres.jpg');">
        <div class="moving-clouds" style="background-image: url('assets/img/clouds.png'); ">
        </div>-->
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 ml-auto mr-auto">
                        <div style="display: flex; justify-content: center;">
                            <img src="dist/img/iqor-logo-white-218x70.png"/>
                        </div>
                        <div class="card card-register" style="margin-top:30px">
                            <h4 class="title" style="margin-bottom:0px;margin-top:15px">Welcome</h4>
                            <form class="register-form" action="login.asp" method="post" name="Form1">
                                <label>Login</label>
                                <input class="form-control" name="txtLogin" placeholder="User">
                                <label>Password</label>
                                <input type="password" name="txtPass" class="form-control" placeholder="Password">
                                    
                                <% 
                                    If noID = "N" Then
                                        Response.Write("<" & "script language=JavaScript>")
			                            Response.Write("document.Form1.txtLogin.focus();")
			                            Response.Write("<" & "/script>")
		                            End If
		                            If noID = "Y" Then
                                %>
                                        <label style="color:white;margin-left:28px">Invalid ID!</label><br>
                                        <script language=JavaScript>
                                            document.Form1.txtLogin.focus();
                                        </script>
                                        
                                <% End If %>
                                <% If noPass = "Y" Then %>
                                        <label style="color:white margin-left:28px">Password Incorrect!</label><br>
                                        <script language=JavaScript>
                                            document.Form1.txtLogin.focus();
                                        </script>
                                        
                                <% End If %>
                                <% If errorLogin = "Y" Then %>
                                        <label style="color:white;margin-left:28px">Invalid Characters for ID!</label><br>
                                        <script language=JavaScript>
                                            document.Form1.txtLogin.focus();
                                        </script>
                                        
                                <% End If %>
                                <% If errorPass = "Y" Then %>
                                        <label style="color:white;margin-left:28px">Invalid Characters for Password</label><br>
                                        <script language=JavaScript>
                                            document.Form1.txtLogin.focus();
                                        </script>
                                        
                                <% End If %>
                                <button type="submit" class="btn btn-danger btn-block btn-round">Sign In</button>
                            </form>
                            <div class="forgot">
                                <a href="broforgot.asp" class="btn btn-link" style="color:white">Forgot password?</a>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
        </div>
      <!--<div class="footer register-footer text-center">
			    <h6>&copy; <script>document.write(new Date().getFullYear())</script>, made with <i class="fa fa-heart heart"></i> by Creative Tim</h6>
		</div>-->
    </div>
</body>

<!-- Core JS Files -->
<script src="assets/js/jquery-3.2.1.js" type="text/javascript"></script>
<script src="assets/js/jquery-ui-1.12.1.custom.min.js" type="text/javascript"></script>
<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Paper Kit Initialization snd functons -->
<script src="../assets/js/paper-kit.js?v=2.0.1"></script>

</html>
