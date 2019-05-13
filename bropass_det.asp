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
    <title>IQOR</title>
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
    <link href="font_awesome/fontawesome-free-5.8.1-web/css/all.css" rel="stylesheet" />

    <%
    
    Set rstBROPass = server.CreateObject("ADODB.RecordSet")
	sql = "select * from BROPASS where ID = '" & session("USERNAME") & "' "
	sql = sql & " and PWDMNT = 'Y'" 
    rstBROPass.Open sql, conn, 3, 3
	if rstBROPass.eof then
        response.redirect("login.asp")
	end if

    bFromEmp = request("bFromEmp")
    sUser_ID = UCase(request("txtUser_ID"))
    TMCount = 13
    sName = request("txtName")

	Dim sTMFM(16)
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
	
	sub DisplayText(sName, sText, sSub)
		
		sStr = "<input style=""margin-left: 0px"" type=""checkbox"" id="& sName &" name=" & sName &" "
		
		if sSub = "Y" then
			sStr = sStr & " checked"
		end if 
		sStr = sStr & " /><p style=""padding-left: 20px"">"& sText &"</p>"                                                                                                                                      
		response.write(sStr)
		
	end sub

    if sUser_ID <> "" then
        sID = sUser_ID
    else
        sID = reqFormU("txtID")
    end if
        
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "bropass.asp?"
	
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage &"&txtUser_ID=" & sID 

    if bFromEmp <> "" then
        sMainURL = "tmemply_det.asp?"
        sAddURL = "bFromEmp=Y" & "&txtEmp_CODE="& sID 
    end if
    
     
    if request("btnCopy_ID") <> "" then
        
        sStatus = reqForm("selStatus")
        sChkGEN = reqForm("chkGEN")
        sCopy_ID = reqForm("txtCopy_ID")

        if sChkGEN <> "" then
            sChkGEN = "Y"
        else    
            sChkGEN = "N"
        end if

        '====BRO PASS===================
        Set rstBROCOPY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from BROPASS where ID='" & sCopy_ID & "'" 
        rstBROCOPY.Open sSQL, conn, 3, 3   
        if not rstBROCOPY.eof then
            Set rstBROPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from BROPASS where ID='" & sID & "'" 
            rstBROPASS.Open sSQL, conn, 3, 3   
            if not rstBROPASS.eof then
                sSQL = "UPDATE BROPASS SET " 
                sSQL = sSQL & "NAME ='" & sName & "',"
                sSQL = sSQL & "STATUS = '" & sStatus & "',"
                sSQL = sSQL & "PWDMNT ='" & sChkGen & "',"
                sSQL = sSQL & "TSACCESS = '" & rstBROCOPY("TSACCESS") & "',"
		        sSQL = sSQL & "MSACCESS = '" & rstBROCOPY("MSACCESS") & "',"
		        sSQL = sSQL & "CSACCESS = '" & rstBROCOPY("CSACCESS") & "',"
                sSQL = sSQL & "TMACCESS = '" & rstBROCOPY("TMACCESS") & "',"
			    sSQL = sSQL & "OGACCESS = '" & rstBROCOPY("OGACCESS") & "',"
			    sSQL = sSQL & "VRACCESS = '" & rstBROCOPY("VRACCESS") & "',"
	            sSQL = sSQL & "CPACCESS = '" & rstBROCOPY("CPACCESS") & "',"
			    sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "' "
	            sSQL = sSQL & "WHERE ID = '" & sUser_ID & "'"
        'response.write sSQL
        'response.End
                conn.execute sSQL          
            else
                sSQL = "insert into BROPASS (ID,NAME,STATUS,PWDMNT,TSACCESS,MSACCESS,CSACCESS,TMACCESS,OGACCESS,VRACCESS,CPACCESS, USER_ID,DATETIME) "
		        sSQL = sSQL & "values ("
		        sSQL = sSQL & "'" & sID & "',"
                sSQL = sSQL & "'" & sName & "',"
                sSQL = sSQL & "'" & sStatus & "',"
                sSQL = sSQL & "'" & sChkGen & "',"
		        sSQL = sSQL & "'" & rstBROCOPY("TSACCESS") & "',"
                sSQL = sSQL & "'" & rstBROCOPY("MSACCESS") & "',"
		        sSQL = sSQL & "'" & rstBROCOPY("CSACCESS") & "',"
                sSQL = sSQL & "'" & rstBROCOPY("TMACCESS") & "',"
			    sSQL = sSQL & "'" & rstBROCOPY("OGACCESS") & "',"
			    sSQL = sSQL & "'" & rstBROCOPY("VRACCESS") & "',"
	            sSQL = sSQL & "'" & rstBROCOPY("CPACCESS") & "',"
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		        sSQL = sSQL & ") "
        'response.write sSQL
        'response.End
		        conn.execute sSQL
            end if
            pCloseTables(rstBROPASS)
        end if
        pCloseTables(rstBROCOPY)

        '====== Transport System ===========
        Set rstTSCOPY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TSPASS where ID='" & sCopy_ID & "'" 
        rstTSCOPY.Open sSQL, conn, 3, 3   
        if not rstTSCOPY.eof then
            Set rstTSPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TSPASS where ID='" & sID & "'" 
            rstTSPASS.Open sSQL, conn, 3, 3   
            if not rstTSPASS.eof then
                sSQL = "UPDATE TSPASS SET " 
	            sSQL = sSQL & "TSACCESS ='" & rstTSCOPY("TSAccess") & "',"
	            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "' "
	            sSQL = sSQL & "WHERE ID = '" & sUser_ID & "'"
	            conn.execute sSQL
                conn.execute sSQL          
            else
                sSQL = "insert into TSPASS (ID,TSACCESS,USER_ID,DATETIME) "
		        sSQL = sSQL & "values ("
		        sSQL = sSQL & "'" & sID & "',"		
		        sSQL = sSQL & "'" & rstTSCOPY("TSAccess") & "',"
		        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		        sSQL = sSQL & ") "
		        conn.execute sSQL
            end if
            pCloseTables(rstTSPASS)
        end if
        pCloseTables(rstTSCOPY)

        '====== Medical System ===========
        Set rstMSCOPY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from MSPASS where ID='" & sCopy_ID & "'" 
        rstMSCOPY.Open sSQL, conn, 3, 3   
        if not rstMSCOPY.eof then
            inputData =Array("FM","FM1","FM2","FM3","FM4", _
                             "TE","TE1", _
                             "PR","PR1","PR2","PR3", _
							 "PC","PC1","PC2")
							 
            for i = 0 to Ubound(inputData) 
                key = inputData(i)
        
                sFieldNm = "MS" & key
            
                sValue = rstMSCOPY("" & sFieldNm & "") 

                sSQLFieldMS = sSQLFieldMS & sFieldNm & " , "
                sSQLValueMS = sSQLValueMS & "'" & sValue & "', "
                sSQLUpMS = sSQLUpMS & sFieldNm & " = " & "'" & sValue & "', "
			
            next

            Set rstMSPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from MSPASS where ID='" & sID & "'" 
            rstMSPASS.Open sSQL, conn, 3, 3
            if not rstMSPASS.eof then
                sSQL = "UPDATE MSPASS SET " 
			    sSQL = sSQL & sSQLUpMS
			    sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"
			    sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
			    sSQL = sSQL & " WHERE ID = '" & sUser_ID & "'"
			    conn.execute sSQL
            else
	          	sSQL = "insert into MSPASS (ID, "
                sSQL = sSQL & sSQLFieldMS
                sSQL = sSQL & " USER_ID, DATETIME, CREATE_ID, DT_CREATE) "
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & sSQLValueMS
				sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if
			pCloseTables(rstMSPASS)
        end if
		pCloseTables(rstMSCOPY)
        
        '==== Canteen System =====
        Set rstCSCOPY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from CSPASS where ID='" & sCopy_ID & "'" 
        rstCSCOPY.Open sSQL, conn, 3, 3   
        if not rstCSCOPY.eof then

            Set rstCSPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from cspass where ID='" & sID & "'" 
            rstCSPASS.Open sSQL, conn, 3, 3
            if not rstCSPASS.eof then
                sSQL = "UPDATE CSPASS SET " 
	            sSQL = sSQL & "CSACCESS ='" & rstCSCOPY("CSACCESS") & "',"
	            sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"
                sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
	            sSQL = sSQL & " WHERE ID = '" & sID & "'"
	            conn.execute sSQL
            else
	          	sSQL = "insert into CSPASS (ID, CSACCESS, USER_ID, DATETIME)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & "'" & rstCSCOPY("CSACCESS") & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "

	            conn.execute sSQL
		    end if
        end if 

        '==== Time Management =====
        Set rstTMCOPY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMPASS where ID='" & sCopy_ID & "'" 
        rstTMCOPY.Open sSQL, conn, 3, 3   
        if not rstTMCOPY.eof then
			
            inputData =Array("FM", "FM1","FM2", "FM3", "FM4", "FM5", "FM6", "FM7", "FM8", _
            "FM9","FM10","FM11", "FM12","FM13","FM14","FM15","FM16" ,"SH","SH1","SH2", "SH3","SH4","TE", _
			"TE1","TE2","TE3","TE4","PC","PC1","PC2","PC3", "PC4","PC5","PC6","PC7","PR", _
			"PR1","PR2","PR3","PR4","PR5","PR6","PR7","PR8","PR9", "PR10", "UTL")
            
            for i = 0 to Ubound(inputData) 
                
                key = inputData(i)

                sFieldNm = "TM" & key
              
                sValue = rstTMCOPY("" & sFieldNm & "")
                
                sSQLField = sSQLField & sFieldNm & ", "
                sSQLValue = sSQLValue & "'" & sValue & "', " 
                sSQLUp = sSQLUp & sFieldNm & " = " & "'" & sValue & "', "
        
            next
     
            Set rstTMPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMPASS where ID='" & sID & "'" 
            rstTMPASS.Open sSQL, conn, 3, 3   
            if not rstTMPASS.eof then
                sSQL = "UPDATE TMPASS SET "
                sSQL = sSQL & sSQLUp
                sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
                sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
                sSQL = sSQL & " WHERE ID = '" & sID & "'"
                conn.execute sSQL          
            else
                sSQL = "insert into TMPASS (ID,"
                sSQL = sSQL & sSQLField 
                sSQL = sSQL & " USER_ID, DATETIME, CREATE_ID, DT_CREATE) "
		        sSQL = sSQL & "values ("
		        sSQL = sSQL & "'" & sID & "',"		
		        sSQL = sSQL & sSQLValue
		        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		        sSQL = sSQL & ") "
    	        conn.execute sSQL
            end if
            pCloseTables(rstTMPASS)
        end if
        pCloseTables(rstTMCOPY)

        '==== Vendor Registration =====
        Set rstVRCOPY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from VRPASS where ID='" & sCopy_ID & "'" 
        rstVRCOPY.Open sSQL, conn, 3, 3   
        if not rstVRCOPY.eof then
			
            inputData =Array("FM", "FM1","FM2", _
                             "TE","TE1", "TE2", _
                             "PR","PR1","PR2", _
							 "PC","PC1")

            for i = 0 to Ubound(inputData) 
                key = inputData(i)
                
                sFieldNm = "VR" & key
            
                sValue = rstVRCOPY("" & sFieldNm & "")
                
                sSQLFieldVR = sSQLFieldVR & sFieldNm & " , "
                sSQLValueVR = sSQLValueVR & "'" & sValue & "', "
                sSQLUpVR = sSQLUpVR & sFieldNm & " = " & "'" & sValue & "', "
			
            next
       
            Set rstVRPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from VRPASS where ID='" & sID & "'" 
            rstVRPASS.Open sSQL, conn, 3, 3
            if not rstVRPASS.eof then
                sSQL = "UPDATE VRPASS SET " 
			    sSQL = sSQL & sSQLUpVR
			    sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"
			    sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
			    sSQL = sSQL & " WHERE ID = '" & sUser_ID & "'"
			    conn.execute sSQL

            else
	          	sSQL = "insert into VRPASS (ID, "
                sSQL = sSQL & sSQLFieldVR
                sSQL = sSQL & " USER_ID, DATETIME, CREATE_ID, DT_CREATE) "
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & sSQLValueVR
				sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if
			pCloseTables(rstVRPASS)
        end if
		pCloseTables(rstVRCOPY)

        '==== Out Going Good Pass =====
        Set rstOGCOPY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from OGPASS where ID='" & sCopy_ID & "'" 
        rstOGCOPY.Open sSQL, conn, 3, 3   
        if not rstOGCOPY.eof then

            Set rstOGPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from ogpass where ID='" & sID & "'" 
            rstOGPASS.Open sSQL, conn, 3, 3
            if not rstOGPASS.eof then
                sSQL = "UPDATE OGPASS SET " 
	            sSQL = sSQL & "OGACCESS ='" & rstOGCOPY("OGACCESS") & "',"
	            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "' "
	            sSQL = sSQL & "WHERE ID = '" & sUser_ID & "'"
	            conn.execute sSQL
            else
	          	sSQL = "insert into OGPASS (ID, OGACCESS, USER_ID, DATETIME)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & "'" & rstOGCOPY("OGACCESS") & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if
        end if

        '==== Car Park Reservation =====
        Set rstCPCOPY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from CPPASS where ID='" & sCopy_ID & "'" 
        rstCPCOPY.Open sSQL, conn, 3, 3   
        if not rstCPCOPY.eof then
            Set rstCPPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from cppass where ID='" & sID & "'" 
            rstCPPASS.Open sSQL, conn, 3, 3
            if not rstCPPASS.eof then
	          	sSQL = "UPDATE CPPASS SET " 
	            sSQL = sSQL & "CPACCESS ='" & rstCPCOPY("CPACCESS") & "',"
	            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			    sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
	            sSQL = sSQL & "WHERE ID = '" & sUser_ID & "'"
	            conn.execute sSQL
            else
                sSQL = "insert into cppass (ID, CPACCESS, CREATE_ID, DT_CREATE)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & "'" & rstCPCOPY("CPACCESS") & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if
        end if
    end if
                
    if sModeSub <> "" Then
        
        sName = reqForm("txtName")
        sPassword = reqForm("txtPassword")
        sConfirm = reqForm("txtConfirm")
        sStatus = reqForm("selStatus")
        sChkGEN = reqForm("chkGEN")

        '==== BRO==========================
		sBROTSAccess = reqForm("chkTSAccess")
        sBROMSAccess = reqForm("chkMSAccess")
        sBROCSAccess = reqForm("chkCSAccess")
        sBROTMAccess = reqForm("chkTMAccess")
		sBROVRAccess = reqForm("chkVRAccess")
		sBROOGAccess = reqForm("chkOGAccess")
        sBROCPAccess = reqForm("chkCPAccess")
		
		if sBROCPAccess <> "" then
			sBROCPAccess = "Y"
		else
			sBROCPAccess = "N"
		end if
		
		if sBROCSAccess <> "" then
			sBROCSAccess = "Y"
		else
			sBROCSAccess = "N"
		end if
		
		if sBROMSAccess <> "" then
			sBROMSAccess = "Y"
		else
			sBROMSAccess = "N"
		end if
		
		if sBROOGAccess <> "" then
			sBROOGAccess = "Y"
		else
			sBROOGAccess = "N"
		end if
		
		if sBROTMAccess <> "" then
			sBROTMAccess = "Y"
		else
			sBROTMAccess = "N"
		end if
		
		if sBROTSAccess <> "" then
			sBROTSAccess = "Y"
		else
			sBROTSAccess = "N"
		end if
		
		if sBROVRAccess <> "" then
			sBROVRAccess = "Y"
		else
			sBROVRAccess = "N"
		end if
		
        if sChkGEN <> "" then
            sChkGEN = "Y"
        else    
            sChkGEN = "N"
        end if

        '=====TS, OG, CS, CP, System=====
        sTSAccess = reqForm("cboTSAccess")
        sOGAccess = reqForm("cboOGAccess")
        sCSAccess = reqForm("cboCSAccess")
        sCPAccess = reqForm("selCPAccess")


        '====== Medical System ===========
		
        inputData =Array("FM","FM1","FM2","FM3","FM4", _
                             "TE","TE1", _
                             "PR","PR1","PR2","PR3",_
							 "PC","PC1","PC2")
							 
        for i = 0 to Ubound(inputData) 
            key = inputData(i)
            var = "chkMS" & key
            
            sFieldNm = "MS" & key
            
            sValue = reqForm("" & var & "")
            
            if sValue <> "" then    
                sValue = "Y"
            else
                sValue = "N"
            end if 

            sSQLFieldMS = sSQLFieldMS & sFieldNm & " , "
            sSQLValueMS = sSQLValueMS & "'" & sValue & "', "
            sSQLUpMS = sSQLUpMS & sFieldNm & " = " & "'" & sValue & "', "
        next
		
        '=============================================================================

        '====== Time Managemnet ===========
		
		inputData =Array("FM", "FM1","FM2", "FM3", "FM4", "FM5", "FM6", "FM7", "FM8", _
            "FM9","FM10","FM11", "FM12","FM13","FM14","FM15","FM16","SH","SH1","SH2", "SH3","SH4","TE", _
			"TE1","TE2","TE3","TE4","PC","PC1","PC2","PC3", "PC4","PC5","PC6","PC7","PR", _
			"PR1","PR2","PR3","PR4","PR5","PR6","PR7","PR8", "PR9", "UTL")
		
        for i = 0 to Ubound(inputData) 
            key = inputData(i)
            var = "chkTM" & key
            
            sFieldNm = "TM" & key
            
            sValue = reqForm("" & var & "")
            
            if sValue <> "" then    
                sValue = "Y"
            else
                sValue = "N"
            end if 

            sSQLField = sSQLField & sFieldNm & " , "
            sSQLValue = sSQLValue & "'" & sValue & "', "
            sSQLUp = sSQLUp & sFieldNm & " = " & "'" & sValue & "', "
        next

        '=============================================================================

		'====== Vendor Registration ===========
		
        inputData =Array("FM", "FM1","FM2", _
                             "TE","TE1", "TE2", _
                             "PR","PR1","PR2", _
							 "PC","PC1")
							 
        for i = 0 to Ubound(inputData) 
            key = inputData(i)
            var = "chkVR" & key
            
            sFieldNm = "VR" & key
            
            sValue = reqForm("" & var & "")
            
            if sValue <> "" then    
                sValue = "Y"
            else
                sValue = "N"
            end if 

            sSQLFieldVR = sSQLFieldVR & sFieldNm & " , "
            sSQLValueVR = sSQLValueVR & "'" & sValue & "', "
            sSQLUpVR = sSQLUpVR & sFieldNm & " = " & "'" & sValue & "', "
			
        next
        '=============================================================================

        if sModeSub = "up" Then
                
            '=== BRO PASS
            sSQL = "UPDATE BROPASS SET "             
            
            if sPassword <>"" then
                sSQL = sSQL & "PASSWORD = '" & (pPassConv(sPassword)+CLng(Now - CDate("01/01/1980"))) & "',"
                sSQL = sSQL & "DATELASTUSE ='" & fDatetime2(Now()) & "',"
            end if
            
            sSQL = sSQL & "NAME = '" & pRTIN(sName) & "',"
            sSQL = sSQL & "STATUS = '" & sStatus & "',"
            sSQL = sSQL & "PWDMNT = '" & sChkGEN & "',"
            sSQL = sSQL & "DATEUPDT = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "CPACCESS = '" & sBROCPAccess & "',"
			sSQL = sSQL & "CSACCESS = '" & sBROCSAccess & "',"
			sSQL = sSQL & "MSACCESS = '" & sBROMSAccess & "',"
			sSQL = sSQL & "OGACCESS = '" & sBROOGAccess & "',"
			sSQL = sSQL & "TMACCESS = '" & sBROTMAccess & "',"
			sSQL = sSQL & "TSACCESS = '" & sBROTSAccess & "',"
			sSQL = sSQL & "VRACCESS = '" & sBROVRAccess & "',"
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "',"
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
            sSQL = sSQL & " WHERE ID = '" & sUser_ID & "'"
            conn.execute sSQL

            '=== Transport System
            sSQL = "UPDATE TSPASS SET " 
	        sSQL = sSQL & "TSACCESS ='" & sTSAccess & "',"
	        sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "' "
	        sSQL = sSQL & "WHERE ID = '" & sUser_ID & "'"
	        conn.execute sSQL
            
            '-- Medical System			
			sSQL = "UPDATE MSPASS SET " 
			sSQL = sSQL & sSQLUpMS
			sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
			sSQL = sSQL & " WHERE ID = '" & sUser_ID & "'"
			conn.execute sSQL

            '-- Canteen System
            sSQL = "UPDATE CSPASS SET " 
	        sSQL = sSQL & "CSACCESS ='" & sCSAccess & "',"
	        sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
	        sSQL = sSQL & " WHERE ID = '" & sUser_ID & "'"
	        conn.execute sSQL
            
            '-- Time Mangement System
            sSQL = "UPDATE TMPASS SET " 
	        sSQL = sSQL & sSQLUp
	        sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"
            sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
	        sSQL = sSQL & " WHERE ID = '" & sUser_ID & "'"
	        conn.execute sSQL

            '-- Vendor Registration
			sSQL = "UPDATE VRPASS SET " 
			sSQL = sSQL & sSQLUpVR
			sSQL = sSQL & "USER_ID ='" & session("USERNAME") & "',"
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "'"
			sSQL = sSQL & " WHERE ID = '" & sUser_ID & "'"
			conn.execute sSQL
		
            '-- Outgoing Goods Pass System
            sSQL = "UPDATE OGPASS SET " 
	        sSQL = sSQL & "OGACCESS ='" & sOGAccess & "',"
	        sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "' "
	        sSQL = sSQL & "WHERE ID = '" & sUser_ID & "'"
	        conn.execute sSQL
            
			'-- Carpark Reservation
            sSQL = "UPDATE CPPASS SET " 
	        sSQL = sSQL & "CPACCESS ='" & sCPAccess & "',"
	        sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
	        sSQL = sSQL & "WHERE ID = '" & sUser_ID & "'"
	        conn.execute sSQL
	                
            call confirmBox("Update Successful!", sMainURL&sAddURL)

        elseif sModeSub = "save" Then
        
            sSQL = "insert into BROPASS (ID,NAME,PASSWORD,STATUS,PWDMNT,FSLOGIN,CREATE_ID,DATECREATE,DATELASTUSE, "
			sSQL = sSQL & " CPACCESS, CSACCESS, MSACCESS, OGACCESS, TMACCESS, TSACCESS,VRACCESS, USER_ID, DATETIME) "
		    sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sName) & "',"
		    sSQL = sSQL & "'" & (pPassConv(sPassword)+CLng(Now - CDate("01/01/1980"))) & "',"
		    sSQL = sSQL & "'" & sStatus & "',"
            sSQL = sSQL & "'" & sChkGEN & "',"
            sSQL = sSQL & "'Y',"
            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
			sSQL = sSQL & "'" & sBROCPAccess & "',"
			sSQL = sSQL & "'" & sBROCSAccess & "',"
			sSQL = sSQL & "'" & sBROMSAccess & "',"
			sSQL = sSQL & "'" & sBROOGAccess & "',"
			sSQL = sSQL & "'" & sBROTMAccess & "',"
			sSQL = sSQL & "'" & sBROTSAccess & "',"
			sSQL = sSQL & "'" & sBROVRAccess & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
		    conn.execute sSQL

            '-- Transport System
            Set rstTSPass = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TSPASS where ID='" & sID & "'" 
            rstTSPass.Open sSQL, conn, 3, 3
            if rstTSPass.eof then
	          	sSQL = "insert into TSPASS (ID, TSACCESS, USER_ID, DATETIME)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & "'" & sTSAccess & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if

            '=== Medical System =====
            Set rstMSPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from MSPASS where ID='" & sID & "'" 
            rstMSPASS.Open sSQL, conn, 3, 3
            if rstMSPASS.eof then
	          	sSQL = "insert into MSPASS (ID, "
                sSQL = sSQL & sSQLFieldMS
                sSQL = sSQL & " USER_ID, DATETIME, CREATE_ID, DT_CREATE)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & sSQLValueMS
				sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if
            
            '-- Canteen System
            Set rstCSPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from cspass where ID='" & sID & "'" 
            rstCSPASS.Open sSQL, conn, 3, 3
            if rstCSPASS.eof then
	          	sSQL = "insert into CSPASS (ID, CSACCESS, USER_ID, DATETIME)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & "'" & sCSAccess & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if

            '=== Time Management System =====
            Set rstTMPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMPASS where ID='" & sID & "'" 
            rstTMPASS.Open sSQL, conn, 3, 3
            if rstTMPASS.eof then
	          	sSQL = "insert into TMPASS (ID, "
                sSQL = sSQL & sSQLField
                sSQL = sSQL & " USER_ID, DATETIME, CREATE_ID, DT_CREATE)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & sSQLValue
                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if

			'=== Vendor Registration =====
            Set rstVRPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from VRPASS where ID='" & sID & "'" 
            rstVRPASS.Open sSQL, conn, 3, 3
            if rstVRPASS.eof then
	          	sSQL = "insert into VRPASS (ID, "
                sSQL = sSQL & sSQLFieldVR
                sSQL = sSQL & " USER_ID, DATETIME, CREATE_ID, DT_CREATE)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & sSQLValueVR
				sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if
			
            '-- Outgoing Good Pass System
            Set rstOGPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from ogpass where ID='" & sID & "'" 
            rstOGPASS.Open sSQL, conn, 3, 3
            if rstOGPASS.eof then
	          	sSQL = "insert into OGPASS (ID, OGACCESS, USER_ID, DATETIME)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & "'" & sOGAccess & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if
            
			'-- Carpark Reservation
            Set rstCPPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from cppass where ID='" & sID & "'" 
            rstCPPASS.Open sSQL, conn, 3, 3
            if rstCPPASS.eof then
	          	sSQL = "insert into cppass (ID, CPACCESS, CREATE_ID, DT_CREATE)"
	        	sSQL = sSQL & "values ("
            	sSQL = sSQL & "'" & sID & "',"
            	sSQL = sSQL & "'" & sCPAccess & "',"
	            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	            sSQL = sSQL & ") "
	            conn.execute sSQL
		    end if

            call confirmBox("Save successful!",sMainURL&sAddURL)
		
        End If 
    End If
          
    Set rstBROPASS = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from BROPASS where ID='" & sID & "'" 
    rstBROPASS.Open sSQL, conn, 3, 3
    if not rstBROPASS.eof then
        sName = rstBROPASS("NAME")
        sStatus = rstBROPASS("STATUS")
        sChkGen = rstBROPASS("PWDMNT")
		sBROCPAccess = rstBROPASS("CPACCESS")
		sBROCSAccess = rstBROPASS("CSACCESS")
		sBROMSAccess = rstBROPASS("MSACCESS")
		sBROOGAccess = rstBROPASS("OGACCESS")
		sBROTMAccess = rstBROPASS("TMACCESS")
		sBROTSAccess = rstBROPASS("TSACCESS")
		sBROVRAccess = rstBROPASS("VRACCESS")
    end if
    pCloseTables(rstBROPASS)
    
    '-- Transport System
    Set rstTSPass = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from tspass where ID='" & sID & "'" 
    rstTSPass.Open sSQL, conn, 3, 3   
        if not rstTSPass.eof then
            sTSAccess = rstTSPass("TSACCESS")
        else
            sAccess = 9
        end if
    pCloseTables(rstTSPass)

    '-- Medical System
	Set rstMSPASS = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from MSPASS where ID='" & sID & "'" 
    rstMSPASS.Open sSQL, conn, 3, 3   
    if not rstMSPASS.eof then
		for i = 0 to Ubound(sMSFM) 
			if i = 0 then
				sMSFM(0) = rstMSPASS("MSFM")
			else
				sMSFM(i) = rstMSPASS("MSFM" & i)
			end if
		next 
		for i = 0 to Ubound(sMSTE) 
			if i = 0 then 
				sMSTE(0) = rstMSPASS("MSTE")
			else
				sMSTE(i) = rstMSPASS("MSTE" & i)
			end if
		next 
		for i = 0 to Ubound(sMSPR)
			if i = 0 then
				sMSPR(0) = rstMSPASS("MSPR")
			else
				sMSPR(i) = rstMSPASS("MSPR" & i)
			end if
		next
		for i = 0 to Ubound(sMSPC)
			if i = 0 then
				sMSPC(0) = rstMSPASS("MSPC")
			else
				sMSPC(i) = rstMSPASS("MSPC" & i)
			end if
		next 
    end if
    pCloseTables(rstMSPASS)
            
     '-- Canteen System
    Set rstCSPass = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from cspass where ID='" & sID & "'" 
    rstCSPass.Open sSQL, conn, 3, 3   
        if not rstCSPass.eof then
            sCSAccess = rstCSPass("CSACCESS")
        else
            sAccess = 9
        end if
    pCloseTables(rstCSPass)
    
    '--- Time Management    
    Set rstTMPASS = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMPASS where ID='" & sID & "'" 
    rstTMPASS.Open sSQL, conn, 3, 3   
    if not rstTMPASS.eof then
		for i = 0 to Ubound(sTMFM)
			if i = 0 then
				sTMFM(0) = rstTMPASS("TMFM")
			else
				sTMFM(i) = rstTMPASS("TMFM" & i)
			end if 
		next 
		for i = 0 to Ubound(sTMSH) 
			if i = 0 then
				sTMSH(0) = rstTMPASS("TMSH")
			else
				sTMSH(i) = rstTMPASS("TMSH" & i)
			end if
		next
		for i = 0 to Ubound(sTMTE)
			if i = 0 then
				sTMTE(0) = rstTMPASS("TMTE")
			else
				sTMTE(i) = rstTMPASS("TMTE" & i)
			end if
		next

        for i = 0 to Ubound(sTMPC)
			if i = 0 then
				sTMPC(0) = rstTMPASS("TMPC")
			else
				sTMPC(i) = rstTMPASS("TMPC" & i)
			end if
		next

		for i = 0 to Ubound(sTMPR)
			if i = 0 then
				sTMPR(0) = rstTMPASS("TMPR")
			else
				sTMPR(i) = rstTMPASS("TMPR" & i)
			end if
		next
		for i = 0 to Ubound(sTMUTL)
			if i = 0 then
				sTMUTL(0) = rstTMPASS("TMUTL")
			else
				sTMUTL(i) = rstTMPASS("TMUTL" & i)
			end if
		next
        
    end if
    pCloseTables(rstTMPASS)

	'-- Vendor Registration
	Set rstVRPASS = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from VRPASS where ID='" & sID & "'" 
    rstVRPASS.Open sSQL, conn, 3, 3   
    if not rstVRPASS.eof then
		for i = 0 to Ubound(sVRFM)
			if i = 0 then
				sVRFM(0) = rstVRPASS("VRFM")
				sVRTE(0) = rstVRPASS("VRTE")
				sVRPR(0) = rstVRPASS("VRPR")
			else
				sVRFM(i) = rstVRPASS("VRFM" & i)
				sVRTE(i) = rstVRPASS("VRTE" & i)
				sVRPR(i) = rstVRPASS("VRPR" & i)
			end if
		next
		for i = 0 to Ubound(sVRPC)
			if i = 0 then
				sVRPC(0) = rstVRPASS("VRPC")
			else
				sVRPC(i) = rstVRPASS("VRPC" & i)
			end if
		next

    end if
    pCloseTables(rstVRPASS)

     '-- Outgoing Goods Pass System
    Set rstOGPass = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from ogpass where ID='" & sID & "'" 
    rstOGPass.Open sSQL, conn, 3, 3   
        if not rstOGPass.eof then
            sOGAccess = rstOGPass("OGACCESS")
        else
            sAccess = 9
        end if
    pCloseTables(rstOGPass)

    '-- Carpark Reservation
    Set rstCPPass = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from cppass where ID='" & sID & "'" 
    rstCPPass.Open sSQL, conn, 3, 3   
        if not rstCPPass.eof then
            sCPAccess = rstCPPass("CPACCESS")
        else
            sAccess = 9
        end if
    pCloseTables(rstCPPass)
        
    %>
</head>
<style>
    .ui-menu-item {
        font-size: 10px;
    }
</style>

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_pass.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>User Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="bropass_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <input type="hidden" name="txtUser_ID" value='<%=sUser_ID%>' />
                            <input type="hidden" name="bFromEmp" value='<%=bFromEmp%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%="txtEmp_CODE="& sID %>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">User ID : </label>
                                        <div class="col-sm-5">
                                            <%if sUser_ID <> "" then %>
                                            <span class="mod-form-control"><% response.write sUser_ID %></span>
                                            <%else%>
                                            <div id="divLoginID">
                                                <input class="form-control" id="txtID" name="txtID" 
                                                    onfocus="clearError('LoginID');" maxlength="10" style="text-transform: uppercase" />
                                                <span id="errorLoginID" class="help-block"></span>
                                            </div>
                                            <%end if%>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Name : </label>
                                        <div class="col-sm-5">
                                            <input class="form-control" name="txtName" value="<%=sName%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">New Password : </label>
                                        <div id="divPassword" class="col-sm-3">
                                            <div class="input-group">
                                                <input id="txtPassword" name="txtPassword" type="password" 
                                                       class="form-control" maxlength="30" onfocus="clearBoth('Password','Confirm');" >
                                                <div class="input-group-addon">
                                                    <span toggle="#txtPassword" class="far fa-eye toggle-password"></span>
                                                </div>
                                            </div>
                                            <span id="errorPassword" class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Confirm Password : </label>
                                        <div id="divConfirm" class="col-sm-3">
                                            <div class="input-group">
                                                <input id="txtConfirm" name="txtConfirm" type="password" 
                                                       class="form-control" maxlength="30" onfocus="clearBoth('Password','Confirm');">
                                                <div class="input-group-addon">
                                                    <span toggle="#txtConfirm" class="far fa-eye toggle-password"></span>
                                                </div>

                                            </div>
                                            <span id="errorConfirm" class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Status : </label>
                                        <div class="col-sm-3">
                                            <select name="selStatus" class="form-control">
                                                <option value="A" <%if sStatus = "A" then%>Selected<%end if%>>Active</option>
                                                <option value="S" <%if sStatus = "S" then%>Selected<%end if%>>Suspended</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">General Settings : </label>
                                        <div class="col-sm-3 ">
                                            <input type="checkbox" id="chkGEN" name="chkGEN" style="margin-top:10px" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Copy Access Permission : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtCopy_ID" name="txtCopy_ID" maxlength="10" value="<%=sCopy_ID%>" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick="fOpen('USER','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <button type="button" class="btn btn-default" style="width: 90px" onclick="checkcopy();">Copy</button>
                                            <button type="submit" id="btnCopy_ID" name="btnCopy_ID" value="copy" class="btnSaveHide"></button>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="col-sm-1"></div>
                                        <div class="nav-tabs-custom col-sm-10">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#TS">TS</a></li>
                                                <li><a data-toggle="tab" href="#MS">MS</a></li>
                                                <li><a data-toggle="tab" href="#CS">CS</a></li>
                                                <li><a data-toggle="tab" href="#TM">TM</a></li>
                                                <li><a data-toggle="tab" href="#VR">VR</a></li>
                                                <li><a data-toggle="tab" href="#OG">OG</a></li>
                                                <li><a data-toggle="tab" href="#CP">CP</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="TS" class="tab-pane fade in active">
													<div class="form-group">
                                                        <div class="col-sm-5">
                                                            <h3><input type="checkbox" id="chkTSAccess" name="chkTSAccess" style="margin-right:20px"  />Transport Sytem</h3>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">Access : </label>
                                                        <div class="col-sm-4">
                                                            <select name="cboTSAccess" class="form-control">
                                                                <option value="N" <%if sTsaccess = "N" then%>Selected<%end if%>>Normal</option>
                                                                <option value="A" <%if sTsaccess = "A" then%>Selected<%end if%>>Admin</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="MS" class="tab-pane fade">
                                                    <!--<h3><%call DisplayText("chkMSAccess", "Medical System",sBROMSAccess)%></h3>-->
                                                    <div class="form-group">
                                                        <div class="col-sm-5">
                                                            <h3><input type="checkbox" id="chkMSAccess" name="chkMSAccess" style="margin-right:20px"  />Medical System</h3>
                                                        </div>
                                                    </div>
                                                     <div class="form-group">
                                                        <div class="col-sm-12">
                                                            <div class="checkbox">
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkMSFM" name="chkMSFM"
                                                                        onclick="if (this.checked) { checkMSMaint() } else { uncheckMSMaint() }"
                                                                        <%if sMSFM(0) = "Y" then%>checked<%end if%> />Maintenance
                                                                <div>
																	<%call DisplayText("chkMSFM1", "Entitlement Type",sMSFM(1))%>
																	<%call DisplayText("chkMSFM2", "Entitlement", sMSFM(2)) %>
																	<%call DisplayText("chkMSFM3", "Family", sMSFM(3))%>
																	<%call DisplayText("chkMSFM4", "Panel Clinic", sMSFM(4))%>
                                                                </div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkMSTE" name="chkMSTE"
                                                                        onclick="if (this.checked) { checkMSTrans() } else { uncheckMSTrans() }"
                                                                        <%if sMSTE(0) = "Y" then%>checked<%end if%> />Transaction
																	<div>
																		<%call DisplayText("chkMSTE1", "Staff Claim Entry", sMSTE(1))%>
																	</div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkMSPR" name="chkMSPR"
                                                                        onclick="if (this.checked) { checkMSReport() } else { uncheckMSReport() }"
                                                                        <%if sMSPR(0) = "Y" then%>checked<%end if%> />Report
																	<div>
																		<%call DisplayText("chkMSPR1", "Medical Claim", sMSPR(1))%>
																		<%call DisplayText("chkMSPR2", "Balance Entitlement", sMSPR(2)) %>
																		<%call DisplayText("chkMSPR3", "Exception", sMSPR(3)) %>
																	</div>
                                                                </div>
																<div class="col-sm-3">
                                                                    <input type="checkbox" id="chkMSPC" name="chkMSPC"
                                                                        onclick="if (this.checked) { checkMSProcess() } else { uncheckMSProcess() }"
                                                                        <%if sMSPC(0) = "Y" then%>checked<%end if%> />Processing
																	<div>
																		<%call DisplayText("chkMSPC1", "Import Claim History", sMSPC(1))%>
																		<%call DisplayText("chkMSPC2", "Import Internal Clinic", sMSPC(2)) %>
																	</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div id="CS" class="tab-pane fade">
                                                    <!--<h3><%call DisplayText("chkCSAccess", "Canteen System",sBROCSAccess)%></h3>-->
                                                    <div class="form-group">
                                                        <div class="col-sm-5">
                                                            <h3><input type="checkbox" id="chkCSAccess" name="chkCSAccess" style="margin-right:20px"  />Canteen System</h3>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">Access : </label>
                                                        <div class="col-sm-2">
                                                            <select name="cboCSAccess" class="form-control">
                                                                <option value="N" <%if sCSAccess = "N" then%>Selected<%end if%>>Normal</option>
                                                                <option value="C" <%if sCSAccess = "C" then%>Selected<%end if%>>Cashier</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div id="TM" class="tab-pane fade">
                                                    <!--<h3><%call DisplayText("chkTMAccess", "Time Management",sBROTMAccess)%></h3>-->
                                                    <div class="form-group">
                                                        <div class="col-sm-5">
                                                            <h3><input type="checkbox" id="chkTMAccess" name="chkTMAccess" style="margin-right:20px"  />Time Management</h3>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">

                                                        <div class="col-sm-12">
                                                            <div class="checkbox">
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkTMFM" name="chkTMFM"
                                                                        onclick="if (this.checked) { checkTMMaint() } else { uncheckTMMaint() }"
                                                                        <%if sTMFM(0) = "Y" then%>checked<%end if%> />Maintenance
																	<div>
                                                                        <%call DisplayText("chkTMFM1", "Employee", sTMFM(1))%>
																		<%call DisplayText("chkTMFM2", "Work Group", sTMFM(2))%>
																		<%call DisplayText("chkTMFM3", "Holiday", sTMFM(3))%>
																		<%call DisplayText("chkTMFM4", "Holiday Group", sTMFM(4))%>
																		<%call DisplayText("chkTMFM5", "Department", sTMFM(5))%>
																		<%call DisplayText("chkTMFM6", "Grade", sTMFM(6))%>
																		<%call DisplayText("chkTMFM7", "Contract", sTMFM(7))%>
																		<%call DisplayText("chkTMFM8", "Work Location", sTMFM(8))%>
																		<%call DisplayText("chkTMFM9", "Cost Center", sTMFM(9))%>
																		<%call DisplayText("chkTMFM10", "Time Off", sTMFM(10))%>
																		<%call DisplayText("chkTMFM11", "OT Code", sTMFM(11))%>
																		<%call DisplayText("chkTMFM12", "Allowance", sTMFM(12))%>
                                                                        <%call DisplayText("chkTMFM13", "Religion", sTMFM(13))%>
                                                                        <%call DisplayText("chkTMFM14", "Nationality", sTMFM(14))%>
                                                                        <%call DisplayText("chkTMFM15", "Log", sTMFM(15))%>
																	</div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkTMSH" name="chkTMSH"
                                                                        onclick="if (this.checked) { checkTMShf() } else { uncheckTMShf() }"
                                                                        <%if sTMSH(0) = "Y" then%>checked<%end if%> />Shift
																	<div>
																		<%call DisplayText("chkTMSH1", "Shift and OT", sTMSH(1))%>
																		<%call DisplayText("chkTMSH2", "Shift Code", sTMSH(2))%>
																		<%call DisplayText("chkTMSH3", "Shift Pattern", sTMSH(3))%>
																		<%call DisplayText("chkTMSH4", "Shift Plan", sTMSH(4))%>
																	</div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkTMTE" name="chkTMTE"
                                                                        onclick="if (this.checked) { checkTMTrans() } else { uncheckTMTrans() }"
                                                                        <%if sTMTE(0) = "Y" then%>checked<%end if%> />Transaction
																	<div>
																		<%call DisplayText("chkTMTE1", "Time Clock", sTMTE(1))%>
																		<%call DisplayText("chkTMTE2", "Abnormal Attendance", sTMTE(2))%>
																		<%call DisplayText("chkTMTE3", "Overtime Pending", sTMTE(3))%>
																		<%call DisplayText("chkTMTE4", "Employee Time Off", sTMTE(4))%>
																	</div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkTMPC" name="chkTMPC"
                                                                        onclick="if (this.checked) { checkTMProc() } else { uncheckTMProc() }"
                                                                        <%if sTMPC(0) = "Y" then%>checked<%end if%> />Processing
																	<div>
																		<%call DisplayText("chkTMPC1", "Generate Shift Plan", sTMPC(1))%>
																		<%call DisplayText("chkTMPC2", "Change Work Group", sTMPC(2))%>
																		<%call DisplayText("chkTMPC3", "Delete Schedule", sTMPC(3))%>
																		<%call DisplayText("chkTMPC4", "Mid Month Process", sTMPC(4))%>
                                                                        <%call DisplayText("chkTMPC5", "Month End Process", sTMPC(5))%>
                                                                        <%call DisplayText("chkTMPC6", "Manual Insert Records", sTMPC(6))%>
                                                                        <%call DisplayText("chkTMPC7", "Reprocess", sTMPC(7))%>
																	</div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkTMPR" name="chkTMPR"
                                                                        onclick="if (this.checked) { checkTMRep() } else { uncheckTMRep() }"
                                                                        <%if sTMPR(0) = "Y" then%>checked<%end if%> />Report
																	<div>
																		<%call DisplayText("chkTMPR1", "Daily Attendance", sTMPR(1))%>
																		<%call DisplayText("chkTMPR2", "OT Transaction", sTMPR(2))%>
																		<%call DisplayText("chkTMPR3", "Abnormal Attendance", sTMPR(3))%>
																		<%call DisplayText("chkTMPR4", "Late and Early Dismiss", sTMPR(4))%>
																		<%call DisplayText("chkTMPR5", "Absence without Leave", sTMPR(5))%>
																		<%call DisplayText("chkTMPR6", "Absence for 3 Consecutive Days", sTMPR(6))%>
																		<%call DisplayText("chkTMPR7", "DL Mid Month Advance", sTMPR(7))%>
																		<%call DisplayText("chkTMPR8", "Overtime Hour Exceeded Limit", sTMPR(8))%>
                                                                        <%call DisplayText("chkTMPR9", "Allowance", sTMPR(9))%>
																	</div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkTMUTL" name="chkTMUTL"
                                                                        <%if sTMUTL(0) = "Y" then%>checked<%end if%> />Program Setup
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="VR" class="tab-pane fade">
                                                    <!--<h3><%call DisplayText("chkVRAccess", "Vendor Registration",sBROVRAccess)%></h3>-->
                                                    <div class="form-group">
                                                        <div class="col-sm-5">
                                                            <h3><input type="checkbox" id="chkVRAccess" name="chkVRAccess" style="margin-right:20px"  />Vendor Registration</h3>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">

                                                        <div class="col-sm-12">
                                                            <div class="checkbox">
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkVRFM" name="chkVRFM"
                                                                        onclick="if (this.checked) { checkVRMaint() } else { uncheckVRMaint() }"
                                                                        <%if sVRFM(0) = "Y" then%>checked<%end if%> />Maintenance
																	<div>
																		<%call DisplayText("chkVRFM1", "Company", sVRFM(1))%>
																		<%call DisplayText("chkVRFM2", "Vendor", sVRFM(2)) %>
																	</div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkVRTE" name="chkVRTE"
                                                                        onclick="if (this.checked) { checkVRTrans() } else { uncheckVRTrans() }"
                                                                        <%if sVRTE(0) = "Y" then%>checked<%end if%> />Transaction
																	<div>
																		<%call DisplayText("chkVRTE1", "Vendor In", sVRTE(1))%>
																		<%call DisplayText("chkVRTE2", "Vendor Out", sVRTE(2)) %>
																	</div>
                                                                </div>
                                                                <div class="col-sm-3">
                                                                    <input type="checkbox" id="chkVRPR" name="chkVRPR"
                                                                        onclick="if (this.checked) { checkVRReport() } else { uncheckVRReport() }"
                                                                        <%if sVRPR(0) = "Y" then%>checked<%end if%> />Report
																	<div>
																		<%call DisplayText("chkVRPR1", "Blacklist", sVRPR(1))%>
																		<%call DisplayText("chkVRPR2", "Vendor Check In", sVRPR(2)) %>
																	</div>
                                                                </div>
																<div class="col-sm-3">
                                                                    <input type="checkbox" id="chkVRPC" name="chkVRPC"
                                                                        onclick="if (this.checked) { checkVRProcess() } else { uncheckVRProcess() }"
                                                                        <%if sVRPC(0) = "Y" then%>checked<%end if%> />Processing
																	<div>
																		<%call DisplayText("chkVRPC1", "Vendor Data Purging", sVRPC(1))%>
																	</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="OG" class="tab-pane fade">
                                                    <!--<h3><%call DisplayText("chkOGAccess", "Out Going Good Pass",sBROOGAccess)%></h3>-->
                                                    <div class="form-group">
                                                        <div class="col-sm-5">
                                                            <h3><input type="checkbox" id="chkOGAccess" name="chkOGAccess" style="margin-right:20px"  />Out Going Good Pass</h3>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">Access : </label>
                                                        <div class="col-sm-4">
                                                            <select name="cboOGAccess" class="form-control">
                                                                <option value="N" <%if sOGAccess = "N" then%>Selected<%end if%>>Normal</option>
                                                                <option value="A" <%if sOGAccess = "A" then%>Selected<%end if%>>Admin</option>
                                                                <option value="F" <%if sOGAccess = "F" then%>Selected<%end if%>>Finance Manager</option>
																<option value="D" <%if sOGAccess = "D" then%>Selected<%end if%>>Department Manager</option>
																<option value="S" <%if sOGAccess = "S" then%>Selected<%end if%>>Security</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="CP" class="tab-pane fade">
													<!--<h3><%call DisplayText("chkCPAccess", "Car Park Reservation",sBROCPAccess)%></h3>-->
                                                    <div class="form-group">
                                                        <div class="col-sm-5">
                                                            <h3><input type="checkbox" id="chkCPAccess" name="chkCPAccess" style="margin-right:20px"  />Car Park Reservation</h3>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-2 control-label">Access : </label>
                                                        <div class="col-sm-4">
                                                            <select name="selCPAccess" class="form-control">
                                                                <option value="N" <%if sCPAccess = "N" then%>Selected<%end if%>>Normal</option>
                                                                <option value="A" <%if sCPAccess = "A" then%>Selected<%end if%>>Admin</option>
                                                                <option value="H" <%if sCPAccess = "H" then%>Selected<%end if%>>HR Manager</option>
																<option value="S" <%if sCPAccess = "S" then%>Selected<%end if%>>Security</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="box-footer">
                                    <%if sUser_ID <> "" and bFromEmp = "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                        onclick="fDel('<%=sID%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkUpdate();">Update</button>
                                        <button type="submit" id="btnSubmit" name="sub" value="up" class="btnSaveHide" ></button>
                                    <%elseif sUser_ID = "" or bFromEmp <> "" then%>
                                        <button type="button" class="btn btn-primary pull-right" style="width: 90px" onclick="checkNew();">Save</button>
                                        <button type="submit" id="btnSubmit" name="sub" value="save" class="btnSaveHide" ></button>
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
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

    <script>

    <%if sChkGen = "Y" then %>
        document.getElementById("chkGEN").checked = true;
    <%end if %>

    <%if sBROTSAccess = "Y" then %>
        document.getElementById("chkTSAccess").checked = true;
    <%end if %>
    
    <%if sBROMSAccess = "Y" then %>
        document.getElementById("chkMSAccess").checked = true;
    <%end if %>

    <%if sBROCSAccess = "Y" then %>
        document.getElementById("chkCSAccess").checked = true;
    <%end if %>

    <%if sBROTMAccess = "Y" then %>
        document.getElementById("chkTMAccess").checked = true;
    <%end if %>

    <%if sBROVRAccess = "Y" then %>
        document.getElementById("chkVRAccess").checked = true;
    <%end if %>

    <%if sBROOGAccess = "Y" then %>
        document.getElementById("chkOGAccess").checked = true;
    <%end if %>

    <%if sBROCPAccess = "Y" then %>
        document.getElementById("chkCPAccess").checked = true;
    <%end if %>

    function checkTMMaint(){
		for ( i = 1; i <= <%=Ubound(sTMFM)%> ; i++)
		{
			inputData = "FM" + i;
			var key = "chkTM" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }
    
    function checkMSMaint(){
		
        for ( i = 1; i <= <%=Ubound(sMSFM)%> ; i++)
		{
			inputData = "FM" + i;
			var key = "chkMS" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }
	
	function checkVRMaint(){
		
        for ( i = 1; i <= <%=Ubound(sVRFM)%> ; i++)
		{
			inputData = "FM" + i;
			var key = "chkVR" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }

    function uncheckTMMaint(){

        for ( i = 1; i <= <%=Ubound(sTMFM)%>  ; i++)
		{
			inputData = "FM" + i;
			var key = "chkTM" + inputData;
			document.getElementById(key).disabled = true;
			document.getElementById(key).checked = false;
		}
    }

    function uncheckMSMaint(){

        for ( i = 1; i <= <%=Ubound(sMSFM)%> ; i++)
		{
			inputData = "FM" + i;
			var key = "chkMS" + inputData;
			document.getElementById(key).disabled = true;
			document.getElementById(key).checked = false;
		}
    }
	
	function uncheckVRMaint(){
		
        for ( i = 1; i <= <%=Ubound(sVRFM)%> ; i++)
		{
			inputData = "FM" + i;
            var key = "chkVR" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }
  
    function checkTMShf(){
        for ( i = 1; i <= <%=Ubound(sTMSH)%> ; i++)
		{
			inputData = "SH" + i;
			var key = "chkTM" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }
      
    function uncheckTMShf(){
        
        for ( i = 1; i <= <%=Ubound(sTMSH)%> ; i++)
		{
			inputData = "SH" + i;
			var key = "chkTM" + inputData;
			document.getElementById(key).disabled = true;
			document.getElementById(key).checked = false;
		}
    }

    function checkTMTrans(){
    
        for ( i = 1; i <= <%=Ubound(sTMTE)%> ; i++)
		{
			inputData = "TE" + i;
			var key = "chkTM" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }

    function checkMSTrans(){
    
        for ( i = 1; i <= <%=Ubound(sMSTE)%> ; i++)
		{
			inputData = "TE" + i;
			var key = "chkMS" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }
	
	function checkVRTrans(){
    
        for ( i = 1; i <= <%=Ubound(sVRTE)%> ; i++)
		{
			inputData = "TE" + i;
			var key = "chkVR" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }

    function uncheckTMTrans(){
    
        for ( i = 1; i <= <%=Ubound(sTMTE)%> ; i++)
		{
			inputData = "TE" + i;
            var key = "chkTM" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }

    function uncheckMSTrans(){
    
        for ( i = 1; i <= <%=Ubound(sMSTE)%> ; i++)
		{
			inputData = "TE" + i;
			var key = "chkMS" + inputData;
			document.getElementById(key).disabled = true;
			document.getElementById(key).checked = false;
		}
    }
	
	function uncheckVRTrans(){
    
        for ( i = 1; i <= <%=Ubound(sVRTE)%> ; i++)
		{
			inputData = "TE" + i;
            var key = "chkVR" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }

    function checkTMProc(){

        for ( i = 1; i <= <%=Ubound(sTMPC)%> ; i++)
		{
			inputData = "PC" + i;
			var key = "chkTM" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
			
		}
    }
    
    function uncheckTMProc(){

        for ( i = 1; i <= <%=Ubound(sTMPC)%>  ; i++)
		{
			inputData = "PC" + i;
            var key = "chkTM" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }

    
    function checkTMRep(){

        for ( i = 1; i <= <%=Ubound(sTMPR)%>  ; i++)
		{
			inputData = "PR" + i;
            var key = "chkTM" + inputData;
            document.getElementById(key).disabled = false;
            document.getElementById(key).checked = true;
        }
    }
    
    function uncheckTMRep(){

        for ( i = 1; i <= <%=Ubound(sTMPR)%>  ; i++)
		{
			inputData = "PR" + i;
            var key = "chkTM" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }

    function checkMSReport(){
    
        for ( i = 1; i <= <%=Ubound(sMSPR)%>  ; i++)
		{
			inputData = "PR" + i;
			var key = "chkMS" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
			
		}
    }
	
	function checkVRReport(){
    
        for ( i = 1; i <= <%=Ubound(sVRPR)%>  ; i++)
		{
			inputData = "PR" + i;
			var key = "chkVR" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }
	
	function checkVRProcess(){
    
        for ( i = 1; i <= <%=Ubound(sVRPC)%>  ; i++)
		{
			inputData = "PC" + i;
			var key = "chkVR" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }
	
	function checkMSProcess(){
    
        for ( i = 1; i <= <%=Ubound(sMSPC)%>  ; i++)
		{
			inputData = "PC" + i;
			var key = "chkMS" + inputData;
			document.getElementById(key).disabled = false;
			document.getElementById(key).checked = true;
		}
    }
	
	function uncheckMSReport(){

        for ( i = 1; i <= <%=Ubound(sMSPR)%>  ; i++)
		{
			inputData = "PR" + i;
            var key = "chkMS" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }
	
	function uncheckVRReport(){

        for ( i = 1; i <= <%=Ubound(sVRPR)%>  ; i++)
		{
			inputData = "PR" + i;
            var key = "chkVR" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }
	
	function uncheckVRProcess(){

        for ( i = 1; i <= <%=Ubound(sVRPC)%>  ; i++)
		{
			inputData = "PC" + i;
            var key = "chkVR" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }
	
	function uncheckMSProcess(){

        for ( i = 1; i <= <%=Ubound(sMSPC)%>  ; i++)
		{
			inputData = "PC" + i;
            var key = "chkMS" + inputData;
            document.getElementById(key).disabled = true;
            document.getElementById(key).checked = false;
        }
    }
    
    $( function() {
        $( "#txtCopy_ID" ).autocomplete({
            maxShowItems: 5,
            source: "source_id.asp"
        
        });
    });

    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
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

        if (pType=="USER") { 
            var search = document.getElementById("txtSearch_user");
        } 
                
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="USER") {
	  	    xhttp.open("GET", "ajax/ax_view_userid.asp?"+str, true);
	  	} 
	  	
  	    xhttp.send();
    }

//    function checkPass(){
//        if ($('#txtPassword').val() != $('#txtConfirm').val() ){
//            alert("The Password you entered does not match!");
//            return false;
//        }else{
//            $('#btnUpdate').click();
//        }
//    }

    function checkcopy(){
        
        if ($("#txtCopy_ID").val()==''){
            alert(" Copy Access Permission ID cannot be empty ");
            return false;
        }

        var url_to	= 'ajax/ax_notexist.asp';  
            $.ajax({
                url     : url_to,
                type    : 'POST',
                data    : { "txtWhat" : "USER",
                            "txtID":$("#txtCopy_ID").val(),
                            }, 
             
                success : function(res){
                 
                    if(res.data.status == "notexist"){
                        return alert(res.data.value);
                    }else if (res.data.status == "OK") {
                        $('#btnCopy_ID').click();
                    }
                },
                error	: function(error){
                    console.log(error);
                }
            });
    }

    //=== Show and unshow password
    $(".toggle-password").click(function () {
        $(this).toggleClass("fa-eye fa-eye-slash");
        var input = $($(this).attr("toggle"));
        if (input.attr("type") == "password") {
            input.attr("type", "text");
        } else {
            input.attr("type", "password");
        }
    });

    function checkNew(){
        
        if ($("#txtID").val() == "") {
        
            document.getElementById("divLoginID").className += ' has-error'
            document.getElementById("errorLoginID").innerHTML = "User ID cannot be empty "
            return false;

        }else if ($("#txtPassword").val() == "") {
        
            document.getElementById("divPassword").className += ' has-error'
            document.getElementById("errorPassword").innerHTML = "Password cannot be empty "
            return false;

        }else if($("#txtConfirm").val() == ""){
        
            document.getElementById("divConfirm").className += ' has-error'
            document.getElementById("errorConfirm").innerHTML = "Confirm Password cannot be empty"
            return false;

        }else if($("#txtPassword").val() != $("#txtConfirm").val()) {
        
            document.getElementById("divPassword").className += ' has-error'
            document.getElementById("errorPassword").innerHTML = "Password does not match"
            document.getElementById("divConfirm").className += ' has-error'
            document.getElementById("errorConfirm").innerHTML = "Password does not match"
            return false;

        } else {

            var url_to	= 'ajax/ax_exist.asp';  

            $.ajax
            ({
                url     : url_to,
                type    : 'POST',
                data    : { 
                            "txtWhat" : "USER",
                            "txtID":$("#txtID").val(),
                            }, 
             
                success : function(res){
                 
                    if(res.data.status == "exist"){
                        $("#divLoginID").toggleClass('has-error', 'add');
                        $("#errorLoginID").html(res.data.value);
                        return false;
                    }else if (res.data.status == "OK") {
                        $('#btnSubmit').click();
                    }
                },
                error	: function(error){
                    console.log(error);
                }
            });
        }
    }

    //=== Remove validation messages when a text-field is onfocus
    function clearError(FieldName) {
        $("#div" + FieldName).removeClass('has-error');
        $("#error" + FieldName).html("");
    };

    function clearBoth(FieldName1, FieldName2) {
        $("#div" + FieldName1).removeClass('has-error');
        $("#error" + FieldName1).html("");
        $("#div" + FieldName2).removeClass('has-error');
        $("#error" + FieldName2).html("");

    };

    function checkUpdate(){
        
        if ($("#txtPassword").val() != "") {
        
            if($("#txtPassword").val() != $("#txtConfirm").val()) {
        
                document.getElementById("divPassword").className += ' has-error'
                document.getElementById("errorPassword").innerHTML = "Password does not match"
                document.getElementById("divConfirm").className += ' has-error'
                document.getElementById("errorConfirm").innerHTML = "Password does not match"
                return false;

            }else{ 

             $('#btnSubmit').click();

            }
        
        }else{ 

            $('#btnSubmit').click();

        }    
    }

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

  	    xhttp.open("GET", "bropass_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }
    </script>

</body>
</html>
