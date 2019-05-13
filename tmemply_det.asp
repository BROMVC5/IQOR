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
    <title>iQOR | Employee Details</title>
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
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
	<!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />

  
    <%
    bFromEmp = request("bFromEmp")
    sEMP_CODE = UCase(request("txtEMP_CODE"))

    Dim sOrigValue(47)
    Dim sNewValue(47)

    
    if sEMP_CODE <> "" then
        sID = sEMP_CODE
    else
        sID = UCase(reqForm("txtID"))
    end if
        
    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "tmemply.asp?"
	
    sAddURL = "txtSearch=" & sSearch & "&Page=" & iPage & "&txtEMP_CODE=" & sID & ""
            
    if sModeSub <> "" Then
        sCardNo = reqFormU("txtCardNo")
        sFName = reqForm("txtFName")
        sLName = reqForm("txtLName")
        sName = reqForm("txtName")
        sAtype = reqForm("selAtype")
        sEmail = reqForm("txtEmail")
        dt_join = reqForm("dt_join")
        dt_confirm = reqForm("dt_confirm")
        dt_resign = reqForm("dt_resign")
        sDept_ID = reqForm("txtDept_ID")
        sGrade_ID = reqForm("txtGrade_ID")
        sSup_Code = reqForm("txtSup_Code")
        sCost_ID = reqForm("txtCost_ID")
        sJob = reqForm("txtJob")
        sCont_ID = reqForm("txtCont_ID")
        sDesign_ID = reqForm("txtDesign_ID")
        
        sAdd1 = reqForm("txtAdd1")
        sAdd2 = reqForm("txtAdd2")
        sCity = reqForm("txtCity")
        sState = reqForm("txtState")
        sCountry = reqForm("txtCountry")
        sPost = reqForm("txtPost")

        if reqForm("chkCorres") <> "" or sModeSub = "up" then
            sCAdd1 = reqForm("txtCAdd1")
            sCAdd2 = reqForm("txtCAdd2")
            sCCity = reqForm("txtCCity")
            sCState = reqForm("txtCState")
            sCCountry = reqForm("txtCCountry")
            sCPost = reqForm("txtCPost")
        end if
        
        sTel = reqForm("txtTel")
        sHP = reqForm("txtHP")         
        dt_DOB = reqForm("dt_DOB")
        sGEN = reqForm("selGen")
        sNat_ID = reqForm("txtNat_ID")
        sRace = reqForm("selRace")
        sPassport = reqForm("txtPassport")
        dt_PassExp = reqForm("dt_PassExp")
        sMarital = reqForm("selMarital")
        sNation = reqForm("txtNation")
        sRelig = reqForm("txtRELIG")
        sWP_NUM = reqForm("txtWP_NUM")
        dt_WorkPSt = reqForm("dt_WorkPSt")
        dt_WorkPEx = reqForm("dt_WorkPEx")
        sWork_ID = reqForm("txtWork_ID")
        sAreaCode = reqForm("txtAreaCode")
        sGenShf = reqForm("selGenShf")
		sMgType = reqForm("txtMgType")
        sOwnTrans = reqForm("selOwnTrans")
        dCoupon = reqForm("dCoupon")
        
     
        if sModeSub = "up" Then

            
            '==================== Insert into LOG ================================================

            fieldNames =Array("CARDNO","FNAME","LNAME","NAME","ATYPE","EMAIL","DT_JOIN","DT_CONFIRM","DT_RESIGN", _
                            "DEPT_ID","GRADE_ID", "SUP_CODE", "COST_ID", "CONT_ID", "DESIGN_ID", "ADD1", "ADD2", "CITY", _
                            "STATE", "COUNTRY", "POST", "CADD1","CADD2","CCITY","CSTATE","CCOUNTRY","CPOST","TEL","HP",_ 
                            "DT_DOB","GEN","RACE","NAT_ID","PASSPORT","PASSEXP","MARITAL","NATION","RELIG","WP_NUM","DT_WORKPST","DT_WORKPEX",_   
                            "WORK_ID","AREACODE","GENSHF","MGTYPE","OWNTRANS")
           
            for i = 0 to Ubound(fieldNames) 
                
                Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMEMPLY where EMP_CODE='" & sID & "'" 
                rstTMEMPLY.Open sSQL, conn, 3, 3
                if not rstTMEMPLY.eof then

                    value = rstTMEMPLY("" & fieldNames(i) & "")

                    if isDate(value) then
                        value = fdate2(value)
                    end if
        
                    sOrigValue(i) = value
                end if
            next
            
            variableNames =Array("txtCARDNO","txtFNAME","txtLNAME","txtNAME","selATYPE","txtEMAIL","DT_JOIN","DT_CONFIRM","DT_RESIGN", _
                            "txtDEPT_ID","txtGRADE_ID", "txtSUP_CODE", "txtCOST_ID", "txtCONT_ID", "txtDESIGN_ID", "txtADD1", "txtADD2", "txtCITY", _
                            "txtSTATE", "txtCOUNTRY", "txtPOST", "txtCADD1","txtCADD2","txtCCITY","txtCSTATE","txtCCOUNTRY","txtCPOST","txtTEL","txtHP",_ 
                            "DT_DOB","selGEN","selRACE","txtNAT_ID","txtPASSPORT","dt_PASSEXP","selMARITAL","selNATION","selRELIG","txtWP_NUM","DT_WORKPST","DT_WORKPEX",_   
                            "txtWORK_ID","txtAREACODE","selGENSHF","txtMgType","selOWNTRANS")

            for i = 0 to Ubound(variableNames) 
                
                value = reqForm("" & variableNames(i) & "")

                if isDate(value) then
                    value = fdate2(value)
                end if

                sNewValue(i) = value
            next
        
            '====== Check is Original Value is different from Field Values insert into LOG ===========
            For i = 0 To UBound(fieldNames)
                if sOrigValue(i) <> sNewValue(i) then
                    sChangesM = sChangesM & fieldNames(i) & " change from " & sOrigValue(i) & " to " & sNewValue(i) & " "  
                    
                end if
            Next            
          
            if sChangesM <> "" then
                sSQLLog = "insert into TMLOG (EMP_CODE,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
		        sSQLLog = sSQLLog & "values ("
                sSQLLog = sSQLLog & "'" & sID & "',"		
		        sSQLLog = sSQLLog & "'Employee Maintenance',"
                sSQLLog = sSQLLog & "'Success',"
                sSQLLog = sSQLLog & "'" & pRTIN(sChangesM) & "',"
                sSQLLog = sSQLLog & "'" & session("USERNAME") & "'," 
                sSQLLog = sSQLLog & "'" & fdatetime2(Now()) & "'"
		        sSQLLog = sSQLLog & ") "
                conn.execute sSQLLog
            end if
            
            '===== End insert into LOG ==============================================================

            sSQL = "UPDATE TMEMPLY SET "             
            sSQL = sSQL & "CardNo = '" & pRTIN(sCardNo) & "',"
            sSQL = sSQL & "FNAME = '" & pRTIN(sFName) & "',"
            sSQL = sSQL & "LNAME = '" & pRTIN(sLName) & "',"
            sSQL = sSQL & "NAME = '" & pRTIN(sName) & "',"
            sSQL = sSQL & "ATYPE = '" & sAType & "',"
            sSQL = sSQL & "EMAIL = '" & sEmail & "',"
            sSQL = sSQL & "DT_JOIN = '" & fdate2(dt_join) & "',"
            if isDate(dt_confirm) then
                sSQL = sSQL & "DT_CONFIRM = '" & fdate2(dt_confirm) & "',"
            else
                sSQL = sSQL & "DT_CONFIRM = null,"
            end if 
            if isDate(dt_resign) then
                
                sSQL = sSQL & "DT_RESIGN = '" & fdate2(dt_resign) & "',"
                
                sSQLCS = "UPDATE CSEMPLY SET "             
                sSQLCS = sSQLCS & "STATUS = 'N',"
                sSQLCS = sSQLCS & "CREATE_ID = '" & session("USERNAME") & "'," 
                sSQLCS = sSQLCS & "DT_CREATE = '" & fdatetime2(Now()) & "',"
                sSQLCS = sSQLCS & "USER_ID = '" & session("USERNAME") & "'," 
                sSQLCS = sSQLCS & "DATETIME = '" & fdatetime2(Now()) & "'"
                sSQLCS = sSQLCS & " WHERE EMP_CODE = '" & sID & "'"
                conn.execute sSQLCS
                
            else
                sSQL = sSQL & "DT_RESIGN = null,"

                sSQLCS = "UPDATE CSEMPLY SET "             
                sSQLCS = sSQLCS & "STATUS = 'Y',"
                sSQLCS = sSQLCS & "CREATE_ID = '" & session("USERNAME") & "'," 
                sSQLCS = sSQLCS & "DT_CREATE = '" & fdatetime2(Now()) & "',"
                sSQLCS = sSQLCS & "USER_ID = '" & session("USERNAME") & "'," 
                sSQLCS = sSQLCS & "DATETIME = '" & fdatetime2(Now()) & "'"
                sSQLCS = sSQLCS & " WHERE EMP_CODE = '" & sID & "'"
                conn.execute sSQLCS

            end if 
            sSQL = sSQL & "DEPT_ID = '" & pRTIN(sDept_ID) & "',"
            sSQL = sSQL & "GRADE_ID = '" & pRTIN(sGrade_ID) & "',"
            sSQL = sSQL & "SUP_CODE = '" & pRTIN(sSUP_CODE) & "',"
            sSQL = sSQL & "COST_ID = '" & pRTIN(sCOST_ID) & "',"
            sSQL = sSQL & "CONT_ID = '" & pRTIN(sCONT_ID) & "',"
            sSQL = sSQL & "DESIGN_ID = '" & pRTIN(sDesign_ID) & "',"
            sSQL = sSQL & "ADD1 = '" & pRTIN(sAdd1) & "',"
            sSQL = sSQL & "ADD2 = '" & pRTIN(sAdd2) & "',"
            sSQL = sSQL & "CITY = '" & pRTIN(sCity) & "',"
            sSQL = sSQL & "STATE = '" & pRTIN(sState) & "',"
            sSQL = sSQL & "COUNTRY = '" & pRTIN(sCountry) & "',"
            sSQL = sSQL & "POST = '" & pRTIN(sPost) & "',"
            sSQL = sSQL & "CADD1 = '" & pRTIN(sCAdd1) & "',"
            sSQL = sSQL & "CADD2 = '" & pRTIN(sCAdd2) & "',"
            sSQL = sSQL & "CCITY = '" & pRTIN(sCCity) & "',"
            sSQL = sSQL & "CSTATE = '" & pRTIN(sCState) & "',"
            sSQL = sSQL & "CCOUNTRY = '" & pRTIN(sCCountry) & "',"
            sSQL = sSQL & "CPOST = '" & pRTIN(sCPost) & "',"
        
            sSQL = sSQL & "TEL = '" & pRTIN(sTel) & "',"
            sSQL = sSQL & "HP = '" & pRTIN(sHP) & "',"
            sSQL = sSQL & "DT_DOB = '" & fdate2(dt_DOB) & "',"
            sSQL = sSQL & "GEN = '" & sGen & "',"
            sSQL = sSQL & "NAT_ID = '" & pRTIN(sNat_ID) & "',"
            sSQL = sSQL & "RACE = '" & sRace & "',"
            sSQL = sSQL & "PASSPORT = '" & pRTIN(sPassport) & "',"
            
            if isDate(dt_PassExp) then
                sSQL = sSQL & "PASSEXP = '" & fdate2(dt_PassExp) & "',"
            else
                sSQL = sSQL & "PASSEXP = null,"
            end if

            sSQL = sSQL & "MARITAL = '" & sMarital & "',"
            sSQL = sSQL & "NATION = '" & pRTIN(sNation) & "',"
            sSQL = sSQL & "RELIG = '" & sRelig & "',"
            sSQL = sSQL & "WP_NUM = '" & pRTIN(sWP_NUM) & "',"
            
            if isDate(dt_WorkPSt) then
                sSQL = sSQL & "DT_WORKPST = '" & fdate2(dt_WorkPSt) & "',"
            else
                sSQL = sSQL & "DT_WORKPST = null,"
            end if

            if isDate(dt_WorkPEx) then
                sSQL = sSQL & "DT_WORKPEX = '" & fdate2(dt_WorkPEx) & "',"
            else
                sSQL = sSQL & "DT_WORKPEX = null,"
            end if
 
            sSQL = sSQL & "WORK_ID = '" & pRTIN(sWork_ID) & "',"
            sSQL = sSQL & "AREACODE = '" & pRTIN(sAreaCode) & "',"
            sSQL = sSQL & "GENSHF = '" & sGenShf & "',"
			sSQL = sSQL & "MGTYPE = '" & sMgType & "',"
            sSQL = sSQL & "OWNTRANS = '" & sOwnTrans & "',"
            
            sSQL = sSQL & "DATEUPDT = '" & fDatetime2(Now()) & "',"
            sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'," 
            sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "'"
            sSQL = sSQL & " WHERE EMP_CODE = '" & sID & "'"
            conn.execute sSQL
           
            Set rstBROPASS = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from BROPASS where ID='" & sID & "'" 
            rstBROPASS.Open sSQL, conn, 3, 3 
            if rstBROPASS.eof then
                if sAtype = "V" or sAtype = "M" or sAtype = "S" then
                    response.write "<script language='javascript'>"
        		    response.write "if (confirm('Do you want to create Web Access?')) {"
                    response.write "    window.location=('bropass_det.asp?bFromEmp=Y&txtUser_ID=" & sID & "&txtName=" & sName & "'); "
                    response.write "} else {"
                    response.write "    window.alert ('Update Succesful!');"
                    response.write "    window.location=('" & sMainURL & sAddURL & "');"
                    response.write "}"
                    response.write "</script>"
                else
                    call confirmBox("Update Successful!", sMainURL&sAddURL)
                end if
            else
                call confirmBox("Update Successful!", sMainURL&sAddURL)
            end if 

        elseif sModeSub = "save" Then
    
            sSQL = "insert into TMEMPLY (EMP_CODE,CardNo, FNAME,LNAME,NAME,ATYPE,EMAIL,DT_JOIN,DT_CONFIRM,DT_RESIGN,DEPT_ID,GRADE_ID,SUP_CODE,"
            sSQL = sSQL & " COST_ID,CONT_ID,DESIGN_ID,ADD1,ADD2,CITY,STATE,COUNTRY,POST,CADD1,CADD2,CCITY,CSTATE,CCOUNTRY,CPOST,"
            sSQL = sSQL & " TEL,HP,DT_DOB,GEN,NAT_ID,RACE,PASSPORT,PASSEXP,MARITAL,NATION,RELIG,WP_NUM,DT_WORKPST,DT_WORKPEX,WORK_ID,AREACODE,"
            sSQL = sSQL & " GENSHF,MGTYPE,OWNTRANS,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		    
            sSQL = sSQL & "values ("
		    sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sCardNo) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sFName) & "',"
		    sSQL = sSQL & "'" & pRTIN(sLName) & "',"
		    sSQL = sSQL & "'" & pRTIN(sName) & "',"
		    sSQL = sSQL & "'" & sAType & "',"
            sSQL = sSQL & "'" & sEmail & "',"
            sSQL = sSQL & "'" & fdate2(dt_join) & "',"
        
            if isdate(dt_confirm) then
                sSQL = sSQL & "'" & fdate2(dt_confirm) & "',"
            else
                sSQL = sSQL & " null,"
            end if
            
            if isdate(dt_confirm) then
                sSQL = sSQL & "'" & fdate2(dt_resign) & "',"
            else
                sSQL = sSQL & " null,"
            end if
            
		    sSQL = sSQL & "'" & pRTIN(sDept_ID) & "',"
		    sSQL = sSQL & "'" & pRTIN(sGrade_ID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sSup_CODE) & "',"
            sSQL = sSQL & "'" & pRTIN(sCost_ID) & "',"
            sSQL = sSQL & "'" & pRTIN(sCont_ID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sDesign_ID) & "',"
        
        		
		    sSQL = sSQL & "'" & pRTIN(sAdd1) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sAdd2) & "',"
		    sSQL = sSQL & "'" & pRTIN(sCity) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sState) & "',"
		    sSQL = sSQL & "'" & pRTIN(sCountry) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sPost) & "',"		
		    if reqForm("chkCorres") <> "" then
                sSQL = sSQL & "'" & pRTIN(sCAdd1) & "',"
		        sSQL = sSQL & "'" & pRTIN(sCAdd2) & "',"		
		        sSQL = sSQL & "'" & pRTIN(sCCity) & "',"
		        sSQL = sSQL & "'" & pRTIN(sCState) & "',"
                sSQL = sSQL & "'" & pRTIN(sCCountry) & "',"
                sSQL = sSQL & "'" & pRTIN(sCPost) & "',"
            else
                sSQL = sSQL & "'" & pRTIN(sAdd1) & "',"
		        sSQL = sSQL & "'" & pRTIN(sAdd2) & "',"		
		        sSQL = sSQL & "'" & pRTIN(sCity) & "',"
		        sSQL = sSQL & "'" & pRTIN(sState) & "',"
                sSQL = sSQL & "'" & pRTIN(sCountry) & "',"
                sSQL = sSQL & "'" & pRTIN(sPost) & "',"
            end if        
            
            sSQL = sSQL & "'" & pRTIN(sTel) & "',"
		    sSQL = sSQL & "'" & pRTIN(sHP) & "',"
            sSQL = sSQL & "'" & fdate2(dt_DOB) & "',"
            sSQL = sSQL & "'" & sGEN & "',"
		    sSQL = sSQL & "'" & pRTIN(sNat_ID) & "',"
            sSQL = sSQL & "'" & pRTIN(sRace) & "',"
            sSQL = sSQL & "'" & pRTIN(sPassport) & "',"
            
            if isdate(dt_PassExp) then
                sSQL = sSQL & "'" & fdate2(dt_PassExp) & "',"
            else
                sSQL = sSQL & " null,"
            end if

		    sSQL = sSQL & "'" & sMarital & "',"
		    sSQL = sSQL & "'" & pRTIN(sNation) & "',"
		    sSQL = sSQL & "'" & sRelig & "',"
		    
            sSQL = sSQL & "'" & pRTIN(sWP_NUM) & "',"

		    if isdate(dt_WORKPST) then
                sSQL = sSQL & "'" & fdate2(dt_WORKPST) & "',"
            else
                sSQL = sSQL & " null,"
            end if

            if isdate(dt_WORKPEX) then
                sSQL = sSQL & "'" & fdate2(dt_WORKPEX) & "',"
            else
                sSQL = sSQL & " null,"
            end if
            
            sSQL = sSQL & "'" & pRTIN(sWork_ID) & "',"
            sSQL = sSQL & "'" & pRTIN(sAreaCode) & "',"
            sSQL = sSQL & "'" & pRTIN(sGenShf) & "',"
			sSQL = sSQL & "'" & pRTIN(sMgType) & "',"
            sSQL = sSQL & "'" & sOwnTrans & "',"
    
        	sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
            conn.execute sSQL
            
            sSQL = "insert into CSEMPLY(EMP_CODE, CARDNO, NAME, COUPON, STATUS, CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
            sSQL = ssQL & "values ("
            sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		    sSQL = sSQL & "'" & pRTIN(sCardNo) & "',"
            sSQL = sSQL & "'" & pRTIN(sName) & "',"
            sSQL = sSQL & "'" & pFormat(dCoupon,2) & "',"  
            sSQL = sSQL & "'Y',"
            sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
		    sSQL = sSQL & "'" & session("USERNAME") & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		    sSQL = sSQL & ") "
            conn.execute sSQL

            if sAtype = "V" or sAtype = "M" or sAtype = "S" then
                response.write "<script language='javascript'>"
        		response.write "if (confirm('Do you want to create Web Access?')) {"
                response.write "    window.location=('bropass_det.asp?bFromEmp=Y&txtUser_ID=" & sID & "&txtName=" & sName & "'); "
                response.write "} else {"
                response.write "    window.alert ('Save Succesful!');"
                response.write "    window.location=('tmemply.asp');"
                response.write "}"
                response.write "</script>"
            else
                call confirmBox("Save Successful!", sMainURL&sAddURL)
            end if

         End If 
    End If
    
    Set rstCSCoupon = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select COUPON from cspath"
    rstCSCoupon.Open sSQL, conn, 3, 3
    if not rstCSCoupon.eof then          
        dCoupon = rstCSCoupon("COUPON") 
    end if
    call pCloseTables(rstCSCoupon)

    Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select tmemply.*, tmcost.PART as COST_PART from TMEMPLY "
    sSQL = sSQL & " left join tmcost on tmemply.COST_ID = tmcost.COST_ID "
    sSQL = sSQL & " where EMP_CODE='" & sID & "'" 
    rstTMEMPLY.Open sSQL, conn, 3, 3
    if not rstTMEMPLY.eof then
        sCardNo = rstTMEMPLY("CARDNO")
        sFName = rstTMEMPLY("FNAME")
        sLName = rstTMEMPLY("LNAME")
        sName = rstTMEMPLY("NAME")
        sAtype = rstTMEMPLY("ATYPE")
        sEmail = rstTMEMPLY("EMAIL")
        dt_join = rstTMEMPLY("DT_JOIN")
        dt_confirm = rstTMEMPLY("DT_CONFIRM")
        dt_resign = rstTMEMPLY("DT_RESIGN")
        sDept_ID = rstTMEMPLY("DEPT_ID")
        sGrade_ID = rstTMEMPLY("GRADE_ID")
        sSUP_CODE = rstTMEMPLY("SUP_CODE")
        
        Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMEMPLY where EMP_CODE='" & sSUP_CODE & "'" 
        rstTMSUPNAME.Open sSQL, conn, 3, 3
        if not rstTMSUPNAME.eof then
            sSup_Name = rstTMSUPNAME("NAME")
        end if
        
        sCost_ID = rstTMEMPLY("COST_ID")
        sCOST_PART = rstTMEMPLY("COST_PART")
        sCont_ID = rstTMEMPLY("CONT_ID")
        sDesign_ID = rstTMEMPLY("DESIGN_ID")
            
        sAdd1 = rstTMEMPLY("ADD1")
        sAdd2 = rstTMEMPLY("ADD2")
        sCity = rstTMEMPLY("CITY")
        sState = rstTMEMPLY("STATE")
        sCountry = rstTMEMPLY("COUNTRY")
        sPost = rstTMEMPLY("POST")
        sCAdd1 = rstTMEMPLY("CADD1")
        sCAdd2 = rstTMEMPLY("CADD2")
        sCCity = rstTMEMPLY("CCITY")
        sCState = rstTMEMPLY("CSTATE")
        sCCountry = rstTMEMPLY("CCOUNTRY")
        sCPost = rstTMEMPLY("CPOST")
        sTel = rstTMEMPLY("TEL")
        sHP = rstTMEMPLY("HP")
        
        dt_DOB = rstTMEMPLY("DT_DOB")
        sGEN = rstTMEMPLY("GEN")
        sNat_ID = rstTMEMPLY("NAT_ID")
        sRace = rstTMEMPLY("RACE")
        sPassport = rstTMEMPLY("Passport")
        dt_PassExp = rstTMEMPLY("PASSEXP")
        sMarital = rstTMEMPLY("MARITAL")
        sNation = rstTMEMPLY("NATION")    
        sRelig = rstTMEMPLY("RELIG")
            
        sWP_NUM = rstTMEMPLY("WP_NUM")
        dt_WorkPSt = fdatelong(rstTMEMPLY("DT_WORKPST"))
        dt_WorkPEx = fdatelong(rstTMEMPLY("DT_WORKPEX"))
            
        sWork_ID = rstTMEMPLY("WORK_ID")
        sAreaCode = rstTMEMPLY("AREACODE")
        sGenShf = rstTMEMPLY("GENSHF")
		sMgType = rstTMEMPLY("MGTYPE")
        sOwnTrans = rstTMEMPLY("OWNTRANS")
         
    end if
    pCloseTables(rstTMEMPLY)

    if sCardNo = "" then
        sCardNo = sID
    end if
    
    if dt_join = "" or isnull(dt_join) then
        dt_join = date()
    end if
    
    if dt_DOB = "" or isnull(dt_DOB) then
        dt_DOB = date()
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
            <section class="content-header">
                <h1>Employee Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form id="form1" class="form-horizontal" action="tmemply_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="dCoupon" value='<%=dCoupon%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <input type="hidden" name="txtEMP_CODE" value='<%=sEMP_CODE%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                            <%if sEMP_CODE <> "" then %>
                                                <div class="col-sm-2">
                                                    <span class="mod-form-control"><% response.write sEMP_CODE %></span>
                                                    <input type="hidden" id="txtID" name="txtID" value="<%=sID%>" />
                                                </div>
                                            <%  Set rstBROPASS = server.CreateObject("ADODB.RecordSet")    
                                                sSQL = "select * from BROPASS where ID='" & sID & "'" 
                                                rstBROPASS.Open sSQL, conn, 3, 3 
                                                if not rstBROPASS.eof then %>
                                                    <div class="col-sm-3">
                                                        <span class ="blinkblink mod-form-control">Web Access already created. </span>
                                                    </div>
                                                <%end if%>
                                            <%else%>
                                                <div class="col-sm-3">
                                                    <input class="form-control" id="txtID" name="txtID" value="<%=sID%>" maxlength="10" style="text-transform: uppercase" input-check required onabort onkeyup="tocardno();"/>
                                                </div>
                                            <%end if%>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><font color="red">* </font>Card No : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" id="txtCardNo" name="txtCardNo" value="<%=sCardNo%>" maxlength="10" style="text-transform: uppercase" />
                                            <input type="hidden" id="txtCardNoIni" name="txtCardNoIni" value="<%=sCardNo%>" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">First Name : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" id="txtFName" name="txtFName" value="<%=sFName%>" maxlength="30" onkeyup="todispname();">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Last Name : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" id="txtLName" name="txtLName" value="<%=sLName%>" maxlength="30" onkeyup="todispname();">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Display Name : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" id="txtName" name="txtName" value="<%=sName%>" maxlength="60">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><font color="red">* </font>Access Type : </label>
                                        <div class="col-sm-3">
                                            <select id="selAType" name="selAType" class="form-control" required>
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="V" <%if sAType = "V" then%>Selected<%end if%>>Verifier</option>
                                                <option value="M" <%if sAType = "M" then%>Selected<%end if%>>Manager</option>
                                                <option value="S" <%if sAType = "S" then%>Selected<%end if%>>Superior</option>
                                                <option value="E" <%if sAType = "E" then%>Selected<%end if%>>Employee</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Email : </label>
                                        <div id="divEmail" class="col-sm-8">
                                            <input class="form-control" id="txtEmail" name="txtEmail" value="<%=sEmail%>" maxlength="50" onblur="validateEmail(this.value);">
                                            <span id="errEmail" class="field-validation-valid text-danger help-block"></span>
                                        </div>
                                    </div>

                                    <hr style="border-top: dotted 1px #cecece;" />

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Date Join : </label>
                                        <div id="div_dt_join" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_join" name="dt_join" value="<%=fdatelong(dt_join)%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndt_join" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_join" class="help-block"></span>
                                        </div>
                                        
                                        <label class="col-sm-3 col-lg-2 control-label">Resignation Date : </label>
                                        <div id="div_dt_resign" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_resign" name="dt_resign" value="<%=fdatelong(dt_resign)%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndt_resign" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_resign" class="help-block"></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Confirmation Date : </label>
                                        <div id="div_dt_confirm" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_confirm" name="dt_confirm" value="<%=fdatelong(dt_confirm)%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndt_confirm" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_confirm" class="help-block"></span>
                                        </div>
                                    </div>
                                    
                                    <hr style="border-top: dotted 1px #cecece;" />

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><font color="red">* </font>Superior : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtSUP_CODE" name="txtSUP_CODE" value="<%=sSup_Code%>" maxlength="10" style="text-transform: uppercase"  required onkeyup="clearSup_Name();">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default" 
                                                        onclick ="fOpen('SUP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="col-sm-5">
                                            <input class="form-control" id="txtSUP_NAME" name="txtSUP_NAME" value="<%=sSup_Name%>" READONLY>
                                        </div>
                                        
                                    </div>
                                    <div class="form-group" >
                                        <label class="col-sm-3 control-label"><font color="red">* </font>Cost Center : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtCost_ID" name="txtCost_ID" value="<%=sCost_ID%>" maxlength="10" style="text-transform: uppercase"  required>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default" 
                                                       onclick ="fOpen('COST','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <div class="col-sm-5">
                                            <input class="form-control" id="txtCOST_PART" name="txtCOST_PART" value="<%=sCOST_PART%>" READONLY>
                                        </div>
                                        
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Designation : </label>
                                            <div class="col-sm-8">
                                                <input class="form-control" id="txtDesign_ID" name="txtDesign_ID" value="<%=sDesign_ID%>" maxlength="40" style="text-transform: uppercase"  >
                                            </div>
                                        <!--div class="col-sm-5">
                                            <div class="input-group">
                                                <input class="form-control" id="txtDesign_ID" name="txtDesign_ID" value="<%=sDesign_ID%>" maxlength="40" style="text-transform: uppercase"  required>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default" 
                                                       onclick ="fOpen('DES','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>-->
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><font color="red">* </font>Grade : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control pull-left" id="txtGrade_ID" name="txtGrade_ID" value="<%=sGrade_ID%>" maxlength="6" style="text-transform: uppercase"  required>
                                                <span class="input-group-btn"> 
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default" 
                                                        onclick ="fOpen('GRADE','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <label class="col-sm-3 col-lg-2 control-label"><font color="red">* </font>Generate Shift : </label>
                                        <div class="col-sm-3">
                                            <select id="selGenShf" name="selGenShf" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="Y" <%if sGenShf = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sGenShf = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                        
                                    </div>
                                    
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label"><font color="red">* </font>Employment Contract : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtCont_ID" name="txtCont_ID" value="<%=sCont_ID%>" maxlength="6" style="text-transform: uppercase"  required>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('CONT','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                        <label class="col-sm-3 col-lg-2 control-label"><font color="red">* </font>Manager Type : </label>
                                        <div class="col-sm-3">
                                            <select id="txtMgType" name="txtMgType" class="form-control">
												<option value="" <%if sMgType = "E" then%>Selected<%end if%>>Empty</option>
                                                <option value="FM" <%if sMgType = "FM" then%>Selected<%end if%>>Functional Manager</option>
                                                <option value="M" <%if sMgType = "M" then%>Selected<%end if%>>Manager</option>
                                            </select>
                                        </div>
                                        
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Work Location : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtWork_ID" name="txtWork_ID" value="<%=sWork_ID%>" maxlength="6" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('WORK','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
										<label class="col-sm-2 control-label">Department : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtDept_ID" name="txtDept_ID" value="<%=sDept_ID%>" maxlength="30" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default" 
                                                        onclick ="fOpen('DEPT','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
										
                                    </div>

                                    <hr style="border-top: dotted 1px #cecece;" />

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Address 1 : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" name="txtAdd1" value="<%=sAdd1%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Address 2 : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" name="txtAdd2" value="<%=sAdd2%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">City : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" name="txtCity" value="<%=sCity%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">State : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" name="txtState" value="<%=sState%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Country : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" name="txtCountry" value="<%=sCountry%>" maxlength="30">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Postal Code : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" name="txtPost" value="<%=sPost%>" maxlength="10">
                                        </div>
                                    </div>
                                    <%if sEMP_CODE = "" then%>
                                    <div class="form-group">
                                        <div class="col-sm-3"></div>
                                        <label class="col-sm-8 checkbox" style="margin-left: 20px">
                                            <input type="checkbox" id="chkCorres" name="chkCorres" />
                                            Check if Correspondent Address is different from Address above
                                        </label>
                                    </div>
                                    <div id="showCorres" style="display: none">
                                        <%end if%>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Correspondent Address 1 : </label>
                                            <div class="col-sm-8" >
                                                <input class="form-control" name="txtCAdd1" value="<%=sCAdd1%>" maxlength="30">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Correspondent Address 2 : </label>
                                            <div class="col-sm-8">
                                                <input class="form-control" name="txtCAdd2" value="<%=sCAdd2%>" maxlength="30">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">City : </label>
                                            <div class="col-sm-8" >
                                                <input class="form-control" name="txtCCity" value="<%=sCCity%>" maxlength="30">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">State : </label>
                                            <div class="col-sm-8" >
                                                <input class="form-control" name="txtCState" value="<%=sCState%>" maxlength="30">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Country : </label>
                                            <div class="col-sm-8" >
                                                <input class="form-control" name="txtCCountry" value="<%=sCCountry%>" maxlength="30">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Postal Code : </label>
                                            <div class="col-sm-8">
                                                <input class="form-control" name="txtCPost" value="<%=sCPost%>" maxlength="10">
                                            </div>
                                        </div>
                                        <%if sEMP_CODE = "" then%>
                                    </div>
                                    <%end if%>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Tel : </label>
                                        <div class="col-sm-4">
                                            <input class="form-control" name="txtTel" value="<%=sTel%>" maxlength="15">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Mobile Phone : </label>
                                        <div class="col-sm-4">
                                            <input class="form-control" name="txtHP" value="<%=sHP%>" maxlength="15">
                                        </div>
                                    </div>

                                    <hr style="border-top: dotted 1px #cecece;" />

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Date of Birth : </label>
                                        <div id="div_dt_DOB" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_DOB" name="dt_DOB" value="<%=fdatelong(dt_DOB)%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndt_DOB" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_DOB" class="help-block"></span>
                                        </div>
                                        <label class="col-sm-2 control-label">Gender : </label>
                                        <div class="col-sm-3">
                                            <select name="selGEN" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="M" <%if sGEN = "M" then%>Selected<%end if%>>Male</option>
                                                <option value="F" <%if sGEN = "F" then%>Selected<%end if%>>Female</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">NRIC : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" name="txtNat_ID" value="<%=sNat_ID%>" maxlength="15">
                                        </div>
                                        <label class="col-sm-2 control-label">Race : </label>
                                        <div class="col-sm-3">
                                            <select name="selRace" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="C" <%if sRace = "C" then%>Selected<%end if%>>Chinese</option>
                                                <option value="I" <%if sRace = "I" then%>Selected<%end if%>>Indian</option>
                                                <option value="M" <%if sRace = "M" then%>Selected<%end if%>>Malay</option>
                                                <option value="O" <%if sRace = "O" then%>Selected<%end if%>>Others</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Passport No : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" name="txtPassport" value="<%=sPassport%>" maxlength="15">
                                        </div>
                                        <label class="col-sm-2 control-label">Marital Status : </label>
                                        <div class="col-sm-3">
                                            <select name="selMarital" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="S" <%if sMarital = "S" then%>Selected<%end if%>>Single</option>
                                                <option value="M" <%if sMarital = "M" then%>Selected<%end if%>>Married</option>
                                                <option value="D" <%if sMarital = "D" then%>Selected<%end if%>>Divorce</option>
                                                <option value="W" <%if sMarital = "W" then%>Selected<%end if%>>Widower</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 col-lg-3 control-label">Passport Expiry Date : </label>
                                        <div id="div_dt_PassEx" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_PassExp" name="dt_PassExp" value="<%=fdatelong(dt_PassExp)%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndt_PassExp" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_PassExp" class="help-block"></span>
                                        </div>

                                        <label class="col-sm-2 control-label">Religion : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtRELIG" name="txtRELIG" value="<%=sRELIG%>" maxlength="15" style="text-transform: uppercase" >
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('RELIG','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Nationality : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtNATION" name="txtNATION" value="<%=sNation%>" maxlength="15" style="text-transform: uppercase" >
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('NATION','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                     </div>

                                    <hr style="border-top: dotted 1px #cecece;" />

                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Work Permit Number : </label>
                                        <div class="col-sm-8">
                                            <input class="form-control" name="txtWP_Num" value="<%=sWP_Num%>" maxlength="15">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Work Permit Start Date : </label>
                                        <div id="div_dt_WorkPSt" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_WorkPSt" name="dt_WorkPSt" value="<%=fdatelong(dt_WorkPSt)%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndt_WorkPSt" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_WorkPSt" class="help-block"></span>
                                        </div>
                                        
                                        <label class="col-sm-2  control-label">Expiry Date : </label>
                                        <div id="div_dt_WorkPEx" class="col-sm-3">
                                            <div class="input-group">
                                                <input id="dt_WorkPEx" name="dt_WorkPEx" value="<%=fdatelong(dt_WorkPEx)%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndt_WorkPEx" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                            <span id="errdt_WorkPEx" class="help-block"></span>
                                        </div>
                                    </div>

                                    <hr style="border-top: dotted 1px #cecece;" />

                                    <div class="form-group">
                                        
                                        <label class="col-sm-3 control-label">Area Code : </label>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtAreaCode" name="txtAreaCode" value="<%=sAreaCode%>" maxlength="10" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default" 
                                                       onclick ="fOpen('AREA','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>

                                        <label class="col-sm-3 col-lg-2 control-label"><font color="red">* </font>Own Transport : </label>
                                        <div class="col-sm-3">
                                            <select id="selOwnTrans" name="selOwnTrans" class="form-control">
                                                <option value="" selected="selected">Please Select</option>
                                                <option value="Y" <%if sOwnTrans = "Y" then%>Selected<%end if%>>Yes</option>
                                                <option value="N" <%if sOwnTrans = "N" then%>Selected<%end if%>>No</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>                                
                                <div class="box-footer">
                                    <%if sEMP_CODE <> "" then %>
                                        <a href="javascript:void(0);" class="btn btn-danger pull-left" style="width: 90px"
                                            onclick ="fDel('<%=sEMP_CODE%>','mycontent-del','#mymodal-del')">Delete</a>
                                        <button type="button" class="btn btn-info pull-right" style="width: 90px" onclick="checkPunch();">Update</button>
                                        <button type="submit" id="btnUpdate"name="sub" value="up" class="btnSaveHide"></button>
                                    <%elseif bFromEmp = "" then%>
                                        <button type="button" class="btn btn-primary pull-right" style="width: 90px" onclick="check();">Save</button>
                                        <button type="submit" id="btnSave" name="sub" value="save" class="btnSaveHide"></button>
                                    <%end if %>
                                </div>
                                <!-- /.box-footer -->
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

    <script>

    //=== This is diasble enter key to post back
    $('#form1').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });

    (function blink() { 
        $('.blinkblink').fadeOut(500).fadeIn(500, blink); 
    })();
       
    $(function () {
        $("#chkCorres").click(function () {
            if ($(this).is(":checked")) {
                $("#showCorres").show();
            } else {
                $("#showCorres").hide();
            }
        });
    });

    $(function () {
        //Date picker
        $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            })
            document.getElementById('txtID').focus();
    });

    $(document).ready(function(){
      $('[date-picker]').mask('00/00/0000');
    });

    $('#btndt_join').click(function () {
        $('#dt_join').datepicker("show");
        });

    $('#btndt_confirm').click(function () {
        $('#dt_confirm').datepicker("show");
        });

    $('#btndt_resign').click(function () {
        $('#dt_resign').datepicker("show");
        });
        
    $('#btndt_PassExp').click(function () {
        $('#dt_PassExp').datepicker("show");
        });
    
    $('#btndt_DOB').click(function () {
        $('#dt_DOB').datepicker("show");
        });
        
    $('#btndt_WorkPSt').click(function () {
        $('#dt_WorkPSt').datepicker("show");
        });

    $('#btndt_WorkPEx').click(function () {
        $('#dt_WorkPEx').datepicker("show");
        });

    function validateEmail(sEmail) {
      var reEmail = /^(?:[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+\.)*[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!\.)){0,61}[a-zA-Z0-9]?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\[(?:(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\]))$/;

      if(!sEmail.match(reEmail)) {
       // alert("Invalid email address");
        document.getElementById("divEmail").className += ' has-error'
        document.getElementById("errEmail").innerHTML = "Please key in valid email address" 
        //document.getElementById("txtEmail").focus();  
        return false;
      }else {
        document.getElementById("divEmail").className -= ' has-error'
        document.getElementById("divEmail").className += ' col-sm-8'
        document.getElementById("errEmail").innerHTML = "" 
        return true;
        }
      
    }

    function checkPunch(){

        var sChkCardNo
        var sUpdate = "Y"

        if ($('#txtCardNoIni').val() != $('#txtCardNo').val()) {
            sChkCardNo = "Y"
        }else{
            sChkCardNo = "N"
        }

        if (sChkCardNo == "Y"){
            var inputData = ['AType','CardNo','Dept_ID', 'Grade_ID', 'SUP_CODE', 'Cost_ID', 'Cont_ID','Work_ID','GenShf','OwnTrans','NATION','RELIG'];
        }else{
            var inputData = ['AType','Dept_ID', 'Grade_ID', 'SUP_CODE', 'Cost_ID', 'Cont_ID', 'Work_ID','GenShf','OwnTrans','NATION','RELIG'];
        }
        
        for (var i = 0; ((i < inputData.length) && sUpdate == "Y" ); i++) {
               var key = inputData[i];
               var url_to	= 'ajax/ax_notexist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtWhat" : key,
                                "txtID":$("#txt"+key).val(),
                                "selID":$("#sel"+key).val(),
                              }, 
             
                    success : function(res){
                        
                        if(res.data.status == "notexist"){
                            sUpdate = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "exist"){
                            sUpdate = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "empty"){
                            sUpdate = "N";
                            return alert(res.data.value);
                        }else if (res.data.status == "OK") {
                        }
                   },
                    error	: function(error){
                        console.log(error);
                    }
               });
            }
    
        if (sUpdate == "Y"){
            $('#btnUpdate').click();
        }
    }
            
    function check(){

        var sSave = "Y"
        
        if ($('#dt_join').val() == '') {
            alert('Date Join cannot be empty');
            document.getElementById("dt_join").focus(); 
            sSave = "N";
           
        }else{

        var inputData = ['ID','AType','CardNo','Dept_ID', 'Grade_ID', 'SUP_CODE', 'Cost_ID', 'Cont_ID','Work_ID','GenShf','OwnTrans','NATION','RELIG'];
        
        for (var i = 0; ((i < inputData.length) && sSave == "Y" ); i++) {
               var key = inputData[i];
               var url_to	= 'ajax/ax_notexist.asp';  
            
                $.ajax({
                    url     : url_to,
                    type    : 'POST',
                    async   : false,
                    data    : { "txtWhat" : key,
                                "txtID":$("#txt"+key).val(),
                                "selID":$("#sel"+key).val(),
                              }, 
             
                    success : function(res){
                        
                        if(res.data.status == "notexist"){
                            sSave = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "exist"){
                            sSave = "N";
                            return alert(res.data.value);
                        }else if(res.data.status == "empty"){
                            sSave = "N";
                            return alert(res.data.value);
                        }else if (res.data.status == "OK") {
                        }
                   },
                    error	: function(error){
                        console.log(error);
                    }
               });
            }
    
        if (sSave == "Y"){
            $('#btnSave').click();
            }
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

  	    xhttp.open("GET", "tmemply_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    function tocardno(){
      document.getElementById("txtCardNo").value = document.getElementById("txtID").value;
    }

     function todispname() {
      var text1 = document.getElementById("txtFName").value;
      var text2 = document.getElementById("txtLName").value;
      document.getElementById("txtName").value = text1 + " " + text2;
    }

    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function clearSup_Name(){
        if (document.getElementById("txtSUP_CODE").value == ""){
            document.getElementById("Sup_Name").innerHTML = ""; 
        }
    }

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }

    function getValue2(svalue, pFldName, svalue2, pFldName2) {
        document.getElementById(pFldName).value = svalue;
        document.getElementById(pFldName2).value = svalue2;
        $('#mymodal').modal('hide');
    }

    function getValue1or2(svalue, pFldName, svalue2, pFldName2) {
        document.getElementById(pFldName).value = svalue;
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

        if (pType=="DEPT") { 
            var search = document.getElementById("txtSearch_dept");
        } else if (pType=="GRADE") {
           var search = document.getElementById("txtSearch_grade");
        } else if (pType=="SUP") {
           var search = document.getElementById("txtSearch_sup");
        } else if (pType=="COST") {
           var search = document.getElementById("txtSearch_cost");
        } else if (pType=="CONT") {
           var search = document.getElementById("txtSearch_cont");
        } else if (pType=="WORK") {
            var search = document.getElementById("txtSearch_work");
        } else if (pType=="HOL") {
            var search = document.getElementById("txtSearch_hol");
        } else if (pType=="DES") {
            var search = document.getElementById("txtSearch_desig");
        } else if (pType=="AREA") {
            var search = document.getElementById("txtSearch3");
        } else if (pType=="NATION") {
            var search = document.getElementById("txtSearch_NATION");
        } else if (pType=="RELIG") {
            var search = document.getElementById("txtSearch_relig");
        }
	  	
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

		if (pType=="DEPT") {
	  	    xhttp.open("GET", "ajax/ax_view_tmdeptID.asp?"+str, true);
	  	} else if (pType=="GRADE") {
	  		xhttp.open("GET", "ajax/ax_view_tmgradeID.asp?"+str, true);
	  	} else if (pType=="SUP") {
            xhttp.open("GET", "ajax/ax_view_tmsupid.asp?"+str, true);
        } else if (pType=="COST") {
            xhttp.open("GET", "ajax/ax_view_tmcostid.asp?"+str, true);
        } else if (pType=="CONT") {
            xhttp.open("GET", "ajax/ax_view_tmcontid.asp?"+str, true);
        } else if (pType=="WORK") {
            xhttp.open("GET", "ajax/ax_view_tmworkid.asp?"+str, true);
        } else if (pType=="HOL") {
            xhttp.open("GET", "ajax/ax_view_tmholid.asp?"+str, true);
        } else if (pType=="DES") {
            xhttp.open("GET", "ajax/ax_view_tmdesign.asp?"+str, true);
        } else if (pType=="AREA") {
            xhttp.open("GET", "ajax/ax_tsview_areaID.asp?"+str, true);
        
            // xhttp.open("GET", "ajax/ax_tsview_areaID.asp?"+str + "&fldName=txtAreaCode", true);
        } else if (pType=="NATION") {
            xhttp.open("GET", "ajax/ax_view_tmnation.asp?"+str, true);
        }else if (pType=="RELIG") {
            xhttp.open("GET", "ajax/ax_view_tmrelig.asp?"+str, true);
        }
	  	
	  	
  	    xhttp.send();
    }
	
	$( "#txtDept_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DP",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDept_ID").val(ui.item.value);
				var str = document.getElementById("txtDept_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtDept_ID").value = res[0];
			},0);
		}
	});
	
	$( "#txtGrade_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=GC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtGrade_ID").val(ui.item.value);
				var str = document.getElementById("txtGrade_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtGrade_ID").value = res[0];
			},0);
		}
	});
	
	$( "#txtSUP_CODE" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=SUPERIOR",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtSUP_CODE").val(ui.item.value);
				var str = document.getElementById("txtSUP_CODE").value;
				var res = str.split(" | ");
				document.getElementById("txtSUP_CODE").value = res[0];
                document.getElementById("txtSUP_NAME").value= res[1];
            },0);
		}
	});

    //=== Any changes except ENTER will clear the NAME field====
    $('#txtSUP_CODE').on('keyup',  function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode != 13 ) {
            $('#txtSUP_NAME').val('');
        }
    });
	
	$( "#txtCost_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtCost_ID").val(ui.item.value);
				var str = document.getElementById("txtCost_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtCost_ID").value = res[0];
                document.getElementById("txtCOST_PART").value = res[1];
            },0);
		}
	});

    //=== Any changes except ENTER will clear the NAME field====
    $('#txtCost_ID').on('keyup',  function(e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode != 13 ) {
            $('#txtCOST_PART').val('');
        }
    });
	
	$( "#txtCont_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CT",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtCont_ID").val(ui.item.value);
				var str = document.getElementById("txtCont_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtCont_ID").value = res[0];
			},0);
		}
	});
	
	$( "#txtDesign_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DS",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDesign_ID").val(ui.item.value);
				var str = document.getElementById("txtDesign_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtDesign_ID").value = res[0];
			},0);
		}
	});
	
	$( "#txtWork_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=WL",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtWork_ID").val(ui.item.value);
				var str = document.getElementById("txtWork_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtWork_ID").value = res[0];
			},0);
		}
	});
	
	$( "#txtAreaCode" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=AC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtAreaCode").val(ui.item.value);
				var str = document.getElementById("txtAreaCode").value;
				var res = str.split(" | ");
				document.getElementById("txtAreaCode").value = res[0];
			},0);
		}
	});

    $( "#txtNATION" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=NAT",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtNATION").val(ui.item.value);
				var str = document.getElementById("txtNATION").value;
				var res = str.split(" | ");
				document.getElementById("txtNATION").value = res[0];
			},0);
		}
	});

    $( "#txtRELIG" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=REL",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtRELIG").val(ui.item.value);
				var str = document.getElementById("txtRELIG").value;
				var res = str.split(" | ");
				document.getElementById("txtRELIG").value = res[0];
			},0);
		}
	});
	
    </script>
</body>
</html>
