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
	<!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
	<style>
	textarea {
		resize: none;
	}
	</style>
	
    <%
    sEmp_ID = UCase(request("txtEmp_ID"))
	iAutoInc = request("txtAutoinc")
	sTicket_No = request("txtTicket_No")
    
    if sEmp_ID <> "" then
       sEmp_ID = sEmp_ID
    else
       sEmp_ID = UCase(reqForm("txtEmp_ID"))
    end if

    sModeSub = request("sub")
    sSearch = request("txtSearch")
    iPage = Request("Page")
    
    sMainURL = "msstaffc.asp?"
	
    sAddURL = "txtSearch=" & server.htmlencode(sSearch) & "&Page=" & iPage 
	
	if sModeSub <> "" Then
        
		sEmp_ID = reqForm("txtEmp_ID")
		sEmpName = reqForm("txtEmp_Name")
		sStatus = reqForm("sStatus")
		dtResign = reqForm("dt_Resign")
		sEn_Name = reqForm("txtEn_Name")
		sPayType = reqForm("sPayType")
		dtClaim = reqForm("dt_Claim")
		dtAttend = reqForm("dt_Attend")
		sRemark = reqForm("txtRemark")
		dClaimAmt = reqForm("txtClaimA")
		iAutoInc = request("txtAutoinc")
		sRef = request("txtRef")
		sPanelC = request("txtPanelCode")
		sOtherC = request("txtOtherC")
		dMaxClaim = 0
		dTempClaimAmt = 0		 
		Bal = 0		
	    dtCurrentDate = fdate2(now())
		
		if sEmp_ID = "" then
		    call alertbox("Employee Code cannot be empty")
		end if
		
		if sEmpName = "" then
		    call alertbox("Employee Name cannot be empty")
		end if
		
		if sEn_Name = "" then
		    call alertbox("Entitlement Type cannot be empty")
		end if
		
		if dtClaim = "" then
		    call alertbox("Claim Date cannot be empty")
		end if
		
		if dtAttend = "" then
		    call alertbox("Attend Date cannot be empty")
		end if
		
		if sEmp_ID <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from tmemply where EMP_CODE ='" & sEmp_ID & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Employee Code : " & sEmp_ID & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
        end if	
							
		if sEn_Name <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from msentype where ENTITLEMENT ='" & sEn_Name & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Entitlement Type : " & sEn_Name & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
        end if

		if sPanelC <> "" then
            Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from mspanelc where PANELCODE ='" & sPanelC & "'" 
            rstVRVend.Open sSQL, conn, 3, 3
            if rstVRVend.eof then
                call alertbox("Panel Clinic : " & sPanelC & " does not exist !")
		    End if  
            pCloseTables(rstVRVend)
        end if
								
        if sModeSub = "up" Then	
		    				
			Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
			sSQL = "select * from tmemply where EMP_CODE ='" & sEmp_ID & "'" 
			rstVRVend.Open sSQL, conn, 3, 3
			if not rstVRVend.eof then
				sGrade_ID = rstVRVend("GRADE_ID")
				sMgtype = rstVRVend("MGTYPE")
			end if
			pCloseTables(rstVRVend)
			
			Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
			sSQL = "select * from msen where ENTITLEMENT ='" & sEn_Name & "'" 
			sSQL = sSQL & " and GRADE_ID = '" & sGrade_ID & "'"
			sSQL = sSQL & " and DESIG = '" & sMgtype & "'"
			rstVRVend.Open sSQL, conn, 3, 3
			if not rstVRVend.eof then
				if Ucase(sEn_Name) <> "PANEL CLINIC VISITATION" then
					dMaxClaim = pFormat(rstVRVend("MAXC"),2)
				end if
			else
				call alertbox("Employee Grade ID must same as Entitlement Type Grade ID!")
			end if
			pCloseTables(rstVRVend)
			
			Set rstVRVend = server.CreateObject("ADODB.RecordSet")
			sSQL = "select DT_JOIN from tmemply where EMP_CODE = '" & sEmp_ID & "'"
			rstVRVend.Open sSQL, conn, 3, 3
			if not rstVRVend.eof then
			  dtDateJoin = fdate2(rstVRVend("DT_JOIN"))
			end if
			
			sMyJoinMonth = DatePart("m", dtDateJoin)
			sMyJoinYear = DatePart("yyyy", dtDateJoin)
			sCurrentYear = DatePart("yyyy", dtCurrentDate)
			
			if Ucase(sEn_Name) <> "PANEL CLINIC VISITATION" then
			
				if cint(sMyJoinYear) = cint(sCurrentYear) then
					if cint(sMyJoinMonth) >= 7 then
						'second half of the year
						dMaxClaim = pFormat(dMaxClaim / 2 ,2)
					end if
				end if
				call pCloseTables(rstVRVend)
										
				Set rstStaff = server.CreateObject("ADODB.RecordSet")
				sSQL = "select sum(CLAIMA) as CLAIMA from msstaffc where EMP_CODE='" & sEmp_ID & "'"
				sSQL = sSQL & " and entitlement = '" & sEn_Name & "' "
				sSQL = sSQL & " and  autoinc <> '" & iAutoInc & "' "
				sSQL = sSQL & " and  year(dt_Attend) = '" & year(now) & "' "
				'response.write sSQL
				'response.end
				rstStaff.Open sSQL, conn, 3, 3
				if not rstStaff.eof then
					dTempClaimAmt = pFormat(rstStaff("CLAIMA"),2)
				end if
				pCloseTables(rstStaff)
				
				dBal = dMaxClaim - dTempClaimAmt

				if cdbl(dBal) < cdbl(dClaimAmt) then 
					call alertbox("Total claim amount exceeded, Remaining balance is RM" &dBal)
				end if
				
			end if

            sSQL = "UPDATE msstaffc SET "             
			sSQL = sSQL & "ENTITLEMENT = '" & pRTIN(sEn_Name) & "',"
			sSQL = sSQL & "PAY_TYPE = '" & pRTIN(sPayType) & "',"
			sSQL = sSQL & "DT_CLAIM = '" & fDatetime2(dtClaim) & "',"
			sSQL = sSQL & "DT_ATTEND = '" & fDatetime2(dtAttend) & "',"
			sSQL = sSQL & "MAXC = '" & pFormat(dMaxClaim,2) & "',"
			sSQL = sSQL & "CLAIMA = '" & pFormat(dClaimAmt,2) & "',"
			sSQL = sSQL & "STATUS = 'Y',"
			sSQL = sSQL & "REMARK = '" & pRTIN(sRemark) & "',"
			sSQL = sSQL & "REFNO = '" & pRTIN(sRef) & "',"
			sSQL = sSQL & "PANELC = '" & pRTIN(sPanelC) & "',"
			sSQL = sSQL & "OTHERC = '" & pRTIN(sOtherC) & "',"
			sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
			sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
            sSQL = sSQL & "WHERE TICKET_NO = '" & sTicket_No & "'"
            conn.execute sSQL
        
            call confirmBox("Update Successful!", sMainURL&sAddURL&"&txtTicket_No=" & sTicket_No & "")

        elseif sModeSub = "save" Then
        			
			Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
			sSQL = "select * from tmemply where EMP_CODE ='" & sEmp_ID & "'" 
			rstVRVend.Open sSQL, conn, 3, 3
			if not rstVRVend.eof then
				sGrade_ID = rstVRVend("GRADE_ID")
				sMgtype = rstVRVend("MGTYPE")
			end if
			pCloseTables(rstVRVend)
			
			Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
			sSQL = "select * from msen where ENTITLEMENT ='" & sEn_Name & "'" 
			sSQL = sSQL & " and GRADE_ID = '" & sGrade_ID & "'"
			sSQL = sSQL & " and DESIG = '" & sMgtype & "'"
			rstVRVend.Open sSQL, conn, 3, 3
			if not rstVRVend.eof then
				if Ucase(sEn_Name) <> "PANEL CLINIC VISITATION" then
					dMaxClaim = pFormat(rstVRVend("MAXC"),2)
				end if
			else
				call alertbox("Employee Grade ID must same as Entitlement Type Grade ID!")
			end if
			pCloseTables(rstVRVend)
			
			Set rstVRVend = server.CreateObject("ADODB.RecordSet")
			sSQL = "select DT_JOIN from tmemply where EMP_CODE = '" & sEmp_ID & "'"
			rstVRVend.Open sSQL, conn, 3, 3
			if not rstVRVend.eof then
			  dtDateJoin = fdate2(rstVRVend("DT_JOIN"))
			end if
			
			sMyJoinMonth = DatePart("m", dtDateJoin)
			sMyJoinYear = DatePart("yyyy", dtDateJoin)
			sCurrentYear = DatePart("yyyy", dtCurrentDate)
			
			if Ucase(sEn_Name) <> "PANEL CLINIC VISITATION" then
				if cint(sMyJoinYear) = cint(sCurrentYear) then	
					if cint(sMyJoinMonth) >= 7 then
						'second half of the year
						dMaxClaim = pFormat(dMaxClaim / 2 ,2)
					end if
				end if
				pCloseTables(rstVRVend)
							
				Set rstStaff = server.CreateObject("ADODB.RecordSet")
				sSQL = "select sum(CLAIMA) as CLAIMA from msstaffc where EMP_CODE='" & sEmp_ID & "'"
				sSQL = sSQL & " and entitlement = '" & sEn_Name & "' "
				sSQL = sSQL & " and  year(dt_Attend) = '" & year(now) & "' "
				rstStaff.Open sSQL, conn, 3, 3
				if not rstStaff.eof then
					dTempClaimAmt = pFormat(rstStaff("CLAIMA"),2)
				end if
				
				dBal = dMaxClaim - dTempClaimAmt
			
			
				if cdbl(dBal) < cdbl(dClaimAmt) then 
					call alertbox("Total claim amount exceeded, Remaining balance is RM" &dBal)
				end if
			
			End if
			
			sSQL = "insert into msstaffcz (USER_ID)"
			sSQL = sSql & "values ("
			sSQL = sSQL & "'" & session("USERNAME") & "')" 
			conn.execute sSQL
			
			Set rstCSTrns2 = server.CreateObject("ADODB.RecordSet")    
			sSQL = "select * from msstaffcz " 
			sSQL = sSQL & " where USER_ID = '" & session("USERNAME") & "'"
			sSQL = sSQL & "order by autoinc desc limit 1"
			rstCSTrns2.Open sSQL, conn, 3, 3
			if not rstCSTrns2.eof then
				dAutoInc = rstCSTrns2("AUTOINC")
				sInitial = "MS"
				sRefNo = sInitial & dAutoInc
					
				sSQL = "insert into msstaffc (TICKET_NO, EMP_CODE, EMP_NAME, STATUS, DT_RESIGN, ENTITLEMENT, PAY_TYPE, DT_CLAIM, DT_ATTEND, CLAIMA, REMARK, REFNO, PANELC,OTHERC,GRADE_ID, MAXC, TYPE, DT_CREATE, CREATE_ID) "
				sSQL = sSQL & "values ("
				sSQL = sSQL & "'" & pRTIN(sRefNo) & "',"	
				sSQL = sSQL & "'" & pRTIN(sEmp_ID) & "',"		
				sSQL = sSQL & "'" & pRTIN(sEmpName)& "',"	
				sSQL = sSQL & "'" & pRTIN(sStatus) & "'," 			
				if dtResign <> "" then
					sSQL = sSQL & "'" & fdate2(dtResign) & "',"
				else
				   sSQL = sSQL & " null,"
				end if
				sSQL = sSQL & "'" & pRTIN(sEn_Name) & "',"
				sSQL = sSQL & "'" & pRTIN(sPayType) & "',"
				sSQL = sSQL & "'" & fDatetime2(dtClaim) & "',"
				sSQL = sSQL & "'" & fDatetime2(dtAttend) & "',"
				sSQL = sSQL & "'" & pFormat(dClaimAmt,2) & "',"
				sSQL = sSQL & "'" & pRTIN(sRemark) & "',"
				sSQL = sSQL & "'" & pRTIN(sRef) & "',"
				sSQL = sSQL & "'" & pRTIN(sPanelC) & "',"
				sSQL = sSQL & "'" & pRTIN(sOtherC) & "',"
				sSQL = sSQL & "'" & pRTIN(sGrade_ID) & "',"
				sSQL = sSQL & "'" & pFormat(dMaxClaim,2) & "',"
				sSQL = sSQL & "'M',"
				sSQL = sSQL & "'" & fDatetime2(Now()) & "',"
				sSQL = sSQL & "'" & session("USERNAME") & "'" 
				sSQL = sSQL & ") "
				conn.execute sSQL
				
				call confirmBox("Save Successful", sMainURL&sAddURL&"&txtTicket_No=" & sTicket_No & "")
			end if
			
		End If
	END IF
          
		Set rstVRVend = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select * from msstaffc where TICKET_NO ='" & sTicket_No & "'" 
		rstVRVend.Open sSQL, conn, 3, 3
		if not rstVRVend.eof then
			sTicket_No = rstVRVend("TICKET_NO")
			sEmp_ID = rstVRVend("EMP_CODE")
			sEmpName = rstVRVend("EMP_NAME")
			sStatus = rstVRVend("STATUS")
			
			if sStatus = "Y" then
				sStatus = "Active"
			else
				sStatus = "Inactive"
			end if
			
			dtResign = rstVRVend("DT_RESIGN")
			sEn_Name = rstVRVend("ENTITLEMENT")
			sPayType = rstVRVend("PAY_TYPE")
			dtClaim = rstVRVend("DT_CLAIM")
			dtAttend = rstVRVend("DT_ATTEND")
			sRemark = rstVRVend("REMARK")
			dClaimAmt = rstVRVend("CLAIMA")
			sRef = rstVRVend("REFNO")
			sPanelC = rstVRVend("PANELC")
			sOtherC = rstVRVend("OTHERC")
		end if
		pCloseTables(rstVRVend)

    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
	
        <!-- #include file="include/header.asp" -->
        <!-- Left sICe column. contains the logo and sICebar -->
        <!-- #include file="include/sidebar_ms.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Staff Claim Entry Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="msstaffc_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=sSearch%>' />
                            <input type="hidden" name="Page" value='<%=iPage%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=sMainURL%><%=sAddURL%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
									<%if sTicket_No<> "" then %>
									<div class="form-group">
                                        <label class="col-sm-3 control-label" style="">Ticket No : </label>
                                        <div class="col-sm-3">
                                            <span class="mod-form-control"><% response.write sTicket_No %> </span>
                                        </div>
                                    </div>
									<%else%>
										<div class="form-group" visibility: hidden></div>
									<%end if%>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-4">
                                            <div class="input-group">
												<%if sEmp_ID <> "" then%>
													<span class="mod-form-control"><% response.write sEmp_ID %> ( <%response.write sEmpName%> )</span>
													<input type="hidden" id="txtEmp_ID" name="txtEmp_ID" value='<%=sEmp_ID%>' />
													<input type="hidden" id="txtEmp_Name" name="txtEmp_Name" value='<%=sEmpName%>' />
												<%else%>
                                                <input class="form-control" id="txtEmp_ID" name="txtEmp_ID" onchange="CheckBalance()" value="<%=sEmp_ID%>" maxlength="50" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('EMP','txtEmp_ID','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
												<%end if%>
                                            </div>
                                        </div>
                                    </div>
									<%if sTicket_No = "" then%>
										<div class="form-group">
											<label class="col-sm-3 control-label">Employee Name : </label>
											<div class="col-sm-5">
												<%if sEmp_ID <> "" then%>
													<span class="mod-form-control"><% response.write sEmpName %> </span>
													<input type="hidden" id="txtEmp_Name" name="txtEmp_Name" value='<%=sEmpName%>' />
												<%else%>
													<input class="form-control" id="txtEmp_Name" name="txtEmp_Name" value="<%=sEmpName%>" maxlength="50"/ READONLY>
												<%end if%>
											</div>
										</div>
									<%end if%>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Resignation Date : </label>
                                        <div id="div_dt_confirm" class="col-sm-3 col-lg-3">
											<%if sEmp_ID <> "" then%>
												<span class="mod-form-control"><% response.write dtResign %> </span>
												<input type="hidden" id="dt_Resign" name="dt_Resign" value='<%=dtResign%>' />
											<%else%>
												<input id="dt_Resign" name="dt_Resign" value="<%=dtResign%>" type="text" class="form-control" READONLY>
											<%end if%>
                                        </div>
                                    </div>									
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Entitlement Type : </label>
                                        <div class="col-sm-5">
                                            <div class="input-group">
                                                <input class="form-control" id="txtEn_Name" name="txtEn_Name" onchange="CheckBalance()" value="<%=sEn_Name%>" maxlength="50" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('EN','txtEn_Name','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Panel Clinic : </label>
                                        <div class="col-sm-5">
                                            <div class="input-group">
                                                <input class="form-control" id="txtPanelCode" name="txtPanelCode" value="<%=sPanelC%>" maxlength="50" style="text-transform: uppercase">
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick ="fOpen('PC','txtPanelCode','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Other Clinic : </label>
                                        <div class="col-sm-5">
											<input class="form-control" id="txtOtherC" name="txtOtherC" value="<%=sOtherC%>" maxlength="40"/>
                                        </div>
                                    </div>
									<div class="form-group">
										<label class="col-sm-3 control-label">Pay Type : </label>
										<div class="col-sm-3">
											<select name="sPayType" class="form-control">
												<option value="M" selected="selected" <%if sPayType = "S" then%>Selected<%end if%>>Cash</option>
												<option value="C" <%if sPayType = "C" then%>Selected<%end if%>>Credit Card</option>
											</select>
										</div>
									</div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Serial No : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtRef" name="txtRef" value="<%=sRef%>" maxlength="15"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Claim Date : </label>
                                        <div id="div_dt_confirm" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
											<%if sEmp_ID <> "" then%>
												<input id="dt_Claim" name="dt_Claim" value="<%=dtClaim%>" type="text" class="form-control" date-picker>
												<span class="input-group-btn">
                                                    <a href="#" id="btndt_Cdate" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
											<%else%>
                                                <input id="dt_Claim" name="dt_Claim" value="<%=fdatelong(now())%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="#" id="btndt_Cdate" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
											<%end if%>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Attend Date : </label>
                                        <div id="div_dt_confirm" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dt_Attend" name="dt_Attend" value="<%=dtAttend%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="#" id="btndt_Adate" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Claim Amount : </label>
                                        <div class="col-sm-3">
											<input class="form-control" style="text-align:right;" id="txtClaimA" name="txtClaimA" value="<%=pFormatDec(dClaimAmt,2)%>" maxlength="15"/>
                                        </div>
                                    </div>
									<!--<div class="form-group">
										<label class="col-sm-3 control-label">Status : </label>
										<div class="col-sm-3">
											<%if sEmp_ID <> "" then%>
												<span class="mod-form-control"><% response.write sStatus %> </span>
												<input type="hidden" id="sStatus" name="sStatus" value='<%=sStatus%>' />
											<%else%>
												<select name="sStatus" class="form-control">
													<option value="Y" selected="selected" <%if sStatus = "Y" then%>Selected<%end if%>>Active</option>
													<option value="N" <%if sStatus = "N" then%>Selected<%end if%>>Inactive</option>
												</select>
											<%end if%>
										</div>
									</div>-->
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Remark : </label>
                                        <div class="col-sm-5">
											<textarea rows="4" cols="60" id="txtRemark" name="txtRemark" maxlength="50"><%=sRemark%></textarea>
                                        </div>
                                    </div>
									<div id = "DisAmt">
										<div class="form-group">
											<label class="col-sm-3 control-label">Balance Amount : </label>
											<div class="col-sm-3">
												 <span class="mod-form-control" id="txtBalanceA">0.00</span>
											</div>
										</div>
									</div>
									<div class="form-group" visibility: hidden>
                                        <label class="col-sm-3 control-label" style="">Ticket No : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" name="txtTicket_No" value="<%=server.htmlencode(sTicket_No)%>" maxlength="10">
                                        </div>
                                    </div>
									<div class="form-group" visibility: hidden>
                                        <label class="col-sm-3 control-label" style="">AutoINC : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" id="txtAutoinc" name="txtAutoinc" value="<%=server.htmlencode(iAutoInc)%>" maxlength="10">
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%if sTicket_No<> "" then %>
                                        <a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=server.htmlencode(sTicket_No)%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
                                        <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                    <%else %>
                                        <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
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
	<!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
	
	<!--date picker-->
    <script>
	
	$('#btndt_Cdate').click(function () {
        $('#dt_Claim').datepicker("show");
    });
	
	$('#btndt_Adate').click(function () {
        $('#dt_Attend').datepicker("show");
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

  	    xhttp.open("GET", "msstaffc_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtEmp_ID').focus();
		CheckBalance();
        }); 
    </script>
	<script>
    function fOpen(pType,pFldName,pContent,pModal) {
		document.getElementById(pContent).innerHTML = ""
        showDetails('page=1',pFldName,pType,pContent)
		$(pModal).modal('show');
	}
	

	function getValue1(svalue, svalue2, svalue3, pFldName, pFldName2 , pFldName3) {
		document.getElementById(pFldName).value = svalue;
		document.getElementById(pFldName2).value = svalue2;
		document.getElementById(pFldName3).value = svalue3;
		$('#mymodal').modal('hide');
		CheckBalance();
	}


	function getValue(svalue, pFldName) {
		document.getElementById(pFldName).value = svalue;
		$('#mymodal').modal('hide');
		CheckBalance();
	}	

    
    function showDetails(str,pFldName,pType,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

        if (pType=="EMP") { 
            var search = document.getElementById("txtSearch_emp");
        }else if (pType=="EN") { 
            var search = document.getElementById("txtSearch_en");
        }else if (pType=="PC") { 
            var search = document.getElementById("txtSearch_pc");
        }
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
			
			str = str + "&fldName=" + pFldName;
			
		if (pType=="EMP") {
	  	    xhttp.open("GET", "ajax/ax_view_empid2.asp?"+str, true);
	  	}else if (pType=="EN") {
	  	    xhttp.open("GET", "ajax/ax_msview_enid.asp?"+str, true);
		}else if (pType=="PC") {
			xhttp.open("GET", "ajax/ax_msview_pc.asp?"+str, true);
		}
	  	
  	    xhttp.send();
    }

    </script>
	<script>
	$(document).ready(function() {
		$("#txtClaimA").keydown(function (e) {
			// Allow: backspace, delete, tab, escape, enter and .
			if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
				 // Allow: Ctrl+A, Command+A
				(e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || 
				 // Allow: home, end, left, right, down, up
				(e.keyCode >= 35 && e.keyCode <= 40)) {
					 // let it happen, don't do anything
					 return;
			}
			// Ensure that it is a number and stop the keypress
			if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
				e.preventDefault();
			}
		});
	});
	
	$('#txtClaimA').keyup(function () {
		if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
       this.value = this.value.replace(/[^0-9\.]/g, '');
		}
	});
	
	$( "#txtEmp_ID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC2",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEmp_ID").val(ui.item.value);
				$("#dt_Resign").val(ui.item.data);
				var str = document.getElementById("txtEmp_ID").value;
				var res = str.split(" | ");
				document.getElementById("txtEmp_ID").value = res[0];
				document.getElementById("txtEmp_Name").value = res[1];
			},0);
		}
	});	
	
	$( "#txtEn_Name" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=ET",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtEn_Name").val(ui.item.value);
				var str = document.getElementById("txtEn_Name").value;
				var res = str.split(" | ");
				document.getElementById("txtEn_Name").value = res[0];
			},0);
		}
	});
	
	$( "#txtPanelCode" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=PC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtPanelCode").val(ui.item.value);
				var str = document.getElementById("txtPanelCode").value;
				var res = str.split(" | ");
				document.getElementById("txtPanelCode").value = res[0];
			},0);
		}
	});	
	
	function CheckBalance(){
		var sEmpCode = document.getElementById("txtEmp_ID").value;
		var sEntitlement = document.getElementById("txtEn_Name").value;
		var iAutoInc = document.getElementById("txtAutoinc").value;
		var url_to = 'getbalance.asp?empcode='+ sEmpCode + '&entitlement=' + sEntitlement + '&autoinc=' + iAutoInc ;
		
		$.ajax({
			url: url_to,
			method: 'GET',
			async: true,
			async: false,
			success: function(res) {
				if (res.error) {
					alert("Error!");
				} else {
					var amount = res.amount ;
					
					if (amount == "0.00") {
						if (sEntitlement.toUpperCase() == "PANEL CLINIC VISITATION"){
							document.getElementById("txtBalanceA").innerHTML = "No Limit";
						}
						else{
							document.getElementById("txtBalanceA").innerHTML = "0.00";
						}
					}
					else {
						document.getElementById("txtBalanceA").innerHTML = amount;
					}
				}
			}
		});
	}
	</script>

</body>
</html>
