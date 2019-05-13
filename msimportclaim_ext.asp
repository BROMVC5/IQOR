<% Server.ScriptTimeout = 1000000 %>
<!DOCTYPE html>
<html>

    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <head>

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
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
<%
  	sModeSub = request("sub")
    sMainURL = "msimportclaim_ext.asp?"
	sMainURL2 = "msimportclaim.asp?"
	
	sType = request("selType")
	sFileName = request("txtFileName")
	sTemp = request("sTemp")
%>

<% 
if sTemp = "" then
	Server.ScriptTimeout = 1000000

	dim sSplit

	sImFile = request("txtFileName")

		sPath = "\EXCEL\MS\"

		sDir = Server.MapPath(".") & sPath

		Set fso = Server.CreateObject("Scripting.FileSystemObject") 
		Set obj_FolderBase = fso.GetFolder(sDir)
		
		if obj_FolderBase.Files.Count = 0 then '=== Check if it contain any data
			response.write " No Data Found!"
			response.End 
		end if

	 '===========================================================================================================  
		For Each obj_File In obj_FolderBase.Files  '=== For loop starts here and process every file in the folder
	 '===========================================================================================================

				strFileName = "EXCEL\MS\" & obj_File.Name
			   
				set fs = fso.OpenTextFile (Server.MapPath(strFileName), 1, False)
				if not fs.AtEndOfStream then
				
				For i = 1 to 2
					fs.ReadLine
				Next

				Do while not fs.AtEndOfStream 

					strRow = fs.ReadLine
					
					sTemp = ""
					
					iPos = InStr(1, strRow, ",")
					If iPos > 0 Then
						sTemp = Trim(Mid(strRow, 1, iPos - 1))
					End If

					if sTemp <> "DEPENDENT" and sTemp <> "" and sTemp <> "Grand Total :" and sTemp <> "PRINCIPLE" and sTemp <> "1" then
					
						sRefno = ""
						sEntitleType = ""
						sPatient = ""
						sEmpCode = ""
						sEmpName = ""
						dt_Attend = ""
						dClaim = "0"
						sPanelClinic = ""
						sPanelCode = ""
						sType = ""

						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sRefno = Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
							sEntitleType = Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						' Skip this coloumn
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						' Check patient name have comma or not
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sTest1 = Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						sApo = """"
						
						sCheck1 = InStr( sTest1, sApo )
						
						if sCheck1 <> "0" then
							iPos = InStr(1, strRow, ",")
							If iPos > 0 Then
								sTest2 = Trim(Mid(strRow, 1, iPos - 1))
							End If
							strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						end if
						
						sCheck2 = InStr( sTest2, sApo )
						
						if sCheck1 <> "0" and sCheck2 <> "0" then
							sPatient = Right(sTest1,Len(sTest1)-sCheck1) & " " & Left(sTest2,sCheck2-1)
						else
							sPatient = sTest1
						end if
						
						' Skip this coloumn
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sEmpCode = Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						' Check The Employee Name have comma or not
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sTestName1 = Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						sApo = """"
						
						sCheckName1 = InStr( sTestName1, sApo )
						
						if sCheckName1 <> "0" then
							iPos = InStr(1, strRow, ",")
							If iPos > 0 Then
								sTestName2 = Trim(Mid(strRow, 1, iPos - 1))
							End If
							strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						end if
						
						sCheckName2 = InStr( sTestName2, sApo )
						
						if sCheckName1 <> "0" and sCheckName2 <> "0" then
							sEmpName = Right(sTestName1,Len(sTestName1)-sCheckName1) & " " & Left(sTest2,sCheckName2-1)
						else
							sEmpName = sTestName1
						end if
						
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            dt_Attend = Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						' Skip this coloumn
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            Trim(Mid(strRow, 1, iPos - 1))
                        End If
						strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
						
						iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            dClaim = Trim(Mid(strRow, 1, iPos - 1))
                        End If
						
						sPanelClinic = Trim(Mid(strRow, iPos + 1, Len(strRow)))

						tempStr = sEmpCode
						
						Do While Left(tempStr, 1) = "0" And tempStr <> ""
							tempStr = Right(tempStr, Len(tempStr) - 1)
						Loop
						
						sEmpCode = tempStr
						
						' iNo = iNo + 1
						' response.write iNo & " ----@@---- : " & sRefno & "," & sEntitleType & "," & sPatient & "," & sEmpCode & "," & sEmpName & "," & dt_Attend & "," & dClaim & "," & sPanelClinic &"<br>" 
						
						if sEmpName <> "" then
							sPatient = sEmpName
						else
							sPatient = sPatient
						end if
						
						if sPanelClinic = "NPC" then
							sPanelCode = "NPC"
							sType = "A"
						else
							sPanelCode = sPanelClinic
							sType = "M"
						end if
						
						if sEmpName <> "" and sEntitleType = "MEDICAL" then
							sEntitleType = "DEPENDENT VISITATION"
						elseif sEntitleType = "MEDICAL" then
							sEntitleType = "PANEL CLINIC VISITATION"
						elseif sEntitleType = "SPECIALIST" then
							sEntitleType = "SPECIALIST VISITATION"
						end if

						Set rstTMEmply = server.CreateObject("ADODB.RecordSet")  
						sSQL = "select * from tmemply where EMP_CODE ='" & sEmpCode & "'"
						rstTMEmply.Open sSQL, conn, 3, 3
						If not rstTMEmply.EOF Then
						
							Set rstMSStaff = server.CreateObject("ADODB.RecordSet")  
							sSQL = "select * from msstaffc where REFNO ='" & sRefno & "'"
							sSQL = sSQL & " and EMP_CODE = '" & sEmpCode & "'"
							rstMSStaff.Open sSQL, conn, 3, 3
							If rstMSStaff.EOF Then
						
								sSQL = "insert into msstaffcz () values ()"
								conn.Execute sSQL
								
								Set rstMSStaffc = server.CreateObject("ADODB.RecordSet")  
								sSQL = "select * from msstaffcz "
								sSQL = sSQL & "order by AUTOINC desc limit 1"
								rstMSStaffc.Open sSQL, conn, 3, 3
								If Not rstMSStaffc.EOF Then
									sInitial = "MS"
									dAutoInc = rstMSStaffc("AUTOINC")
									sTicket = sInitial & dAutoInc
								End If
								
								Set rstMSEN = server.CreateObject("ADODB.RecordSet")  
								sSQL = "select * from msen where ENTITLEMENT ='" & sEntitleType & "'"
								sSQL = sSQL & " and GRADE_ID = '" & rstTMEmply("GRADE_ID") & "'"
								if rstTMEmply("MGTYPE") <> "" then
									sSQL = sSQL & " and DESIG = '" & rstTMEmply("MGTYPE") & "'"
								end if
								rstMSEN.Open sSQL, conn, 3, 3
								If Not rstMSEN.EOF Then
									dMaxC = rstMSEN("MAXC")
								End If
								pCloseTables(rstMSEN)
							
								sSQL = "INSERT INTO MSSTAFFC (TICKET_NO,EMP_CODE,EMP_NAME,STATUS,PAY_TYPE,TYPE,ENTITLEMENT,DT_RESIGN,MAXC,DT_CLAIM,DT_ATTEND,CLAIMA,REFNO,PANELC,GRADE_ID,DT_CREATE,CREATE_ID)"
								sSQL = sSQL & " VALUES ("
								sSQL = sSQL & "'" & pRTIN(sTicket) & "',"
								sSQL = sSQL & "'" & pRTIN(sEmpCode) & "',"
								sSQL = sSQL & "'" & Ucase(pRTIN(sPatient)) & "',"
								sSQL = sSQL & "'Y',"
								sSQL = sSQL & "'M',"
								sSQL = sSQL & "'" & pRTIN(sType) & "',"
								sSQL = sSQL & "'" & Ucase(pRTIN(sEntitleType)) & "',"
								if rstTMEmply("DT_RESIGN") <> "" then
									sSQL = sSQL & "'" & fDate2(rstTMEmply("DT_RESIGN")) & "',"
								else
									sSQL = sSQL & "NULL,"
								end if
								sSQL = sSQL & "'" & pFormat(dMaxC, 2) & "',"
								sSQL = sSQL & "'" & fDate2(now) & " 00:00:00',"
								sSQL = sSQL & "'" & fDate2(dt_Attend) & " 00:00:00',"
								sSQL = sSQL & "'" & pFormat(dClaim, 2) & "',"
								sSQL = sSQL & "'" & pRTIN(sRefNo) & "',"
								sSQL = sSQL & "'" & Ucase(pRTIN(sPanelCode)) & "',"
								sSQL = sSQL & "'" & rstTMEmply("GRADE_ID") & "',"
								sSQL = sSQL & "'" & fDateTime2(now) & "',"
								sSQL = sSQL & "'AUTO'"
								sSQL = sSQL & " )"
								conn.Execute sSQL
							else
							
								Set rstMSEN = server.CreateObject("ADODB.RecordSet")  
								sSQL = "select * from msen where ENTITLEMENT ='" & sEntitleType & "'"
								sSQL = sSQL & " and GRADE_ID = '" & rstTMEmply("GRADE_ID") & "'"
								if rstTMEmply("MGTYPE") <> "" then
									sSQL = sSQL & " and DESIG = '" & rstTMEmply("MGTYPE") & "'"
								end if
								rstMSEN.Open sSQL, conn, 3, 3
								If Not rstMSEN.EOF Then
									dMaxC = rstMSEN("MAXC")
								End If
								pCloseTables(rstMSEN)
								
								sSQL = "UPDATE MSSTAFFC SET "             
								sSQL = sSQL & "EMP_CODE = '" & pRTIN(sEmpCode) & "',"
								sSQL = sSQL & "EMP_NAME = '" & Ucase(pRTIN(sPatient)) & "',"
								sSQL = sSQL & "ENTITLEMENT = '" & Ucase(pRTIN(sEntitleType)) & "',"
								if rstTMEmply("DT_RESIGN") <> "" then
									sSQL = sSQL & "DT_RESIGN = '" & fDate2(rstTMEmply("DT_RESIGN")) & "',"
								else
									sSQL = sSQL & "DT_RESIGN = NULL ,"
								end if
								sSQL = sSQL & "MAXC = '" & pFormat(dMaxC, 2) & "',"
								sSQL = sSQL & "DT_CLAIM = '" & fDate2(now) & " 00:00:00',"
								sSQL = sSQL & "DT_ATTEND = '" & fDate2(dt_Attend) & " 00:00:00',"
								sSQL = sSQL & "CLAIMA = '" & pFormat(dClaim, 2) & "',"
								sSQL = sSQL & "REFNO = '" & pRTIN(sRefNo) & "',"
								sSQL = sSQL & "PANELC = '" & Ucase(pRTIN(sPanelCode)) & "',"
								sSQL = sSQL & "GRADE_ID = '" & rstTMEmply("GRADE_ID") & "',"
								sSQL = sSQL & "DATETIME = '" & fDatetime2(Now()) & "',"
								sSQL = sSQL & "USER_ID = '" & session("USERNAME") & "'"
								sSQL = sSQL & "WHERE REFNO = '" & pRTIN(sRefNo) & "'"
								sSQL = sSQL & "AND EMP_CODE = '" & sEmpCode & "'"
								conn.Execute sSQL
							end if
							pCloseTables(rstMSStaff)
						else
						
							Set rstMSStaff = server.CreateObject("ADODB.RecordSet")  
							sSQL = "select * from msexcept where REFNO ='" & sRefno & "'"
							sSQL = sSQL & " and EMP_CODE = '" & sEmpCode & "'"
							sSQL = sSQL & " and DT_CREATE between '" & fDate2(now) & " 00:00:00'"
							sSQL = sSQL & " and '" & fDate2(now) & " 23:59:59'"
							rstMSStaff.Open sSQL, conn, 3, 3
							If rstMSStaff.EOF Then
								sSQL = "INSERT INTO MSEXCEPT (EMP_CODE,EMP_NAME,STATUS,PAY_TYPE,TYPE,ENTITLEMENT,DT_CLAIM,DT_ATTEND,CLAIMA,REFNO,PANELC,IMP_TYPE,DT_CREATE,CREATE_ID)"
								sSQL = sSQL & " VALUES ("
								sSQL = sSQL & "'" & pRTIN(sEmpCode) & "',"
								sSQL = sSQL & "'" & Ucase(pRTIN(sPatient)) & "',"
								sSQL = sSQL & "'Y',"
								sSQL = sSQL & "'A',"
								sSQL = sSQL & "'" & pRTIN(sType) & "',"
								sSQL = sSQL & "'" & Ucase(pRTIN(sEntitleType)) & "',"
								sSQL = sSQL & "'" & fDate2(Now) & " 00:00:00',"
								sSQL = sSQL & "'" & fDate2(dt_Attend) & " 00:00:00',"
								sSQL = sSQL & "'" & pFormat(dClaim, 2) & "',"
								sSQL = sSQL & "'" & pRTIN(sRefNo) & "',"
								sSQL = sSQL & "'" & Ucase(pRTIN(sPanelCode)) & "',"
								sSQL = sSQL & "'CH',"
								sSQL = sSQL & "'" & fDatetime2(now) & "',"
								sSQL = sSQL & "'AUTO'"
								sSQL = sSQL & " )"
								conn.Execute sSQL
							end if
							pCloseTables(rstMSStaff)
							
						End If
						pCloseTables(rstTMEmply)
						
					end if
				Loop
			end if '=== End if not fs.AtEndOfStream
			pCloseTables(fs)
		Next
		'===== After inserting into move to LOG
		sFileFrom = Server.MapPath(strFileName)

		sFileTo = Server.MapPath(".") & "\EXCEL\MS\LOG\"

		set fsm=Server.CreateObject("Scripting.FileSystemObject")
		fsm.MoveFile sFileFrom , sFileTo
		set fsm=nothing
		call confirmBox("Update Successful!", sMainURL&"txtFileName=" & sFileName &"&sTemp=Y") 
end if
 %>

	</head>


<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ms.asp" -->
		<!-- #include file="include/clsUpload.asp" -->
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Import Claim History</h1>
            </section>
            <!-- Main content -->
            <section class="content">
            	  <!--/row -->
                <div class="row">
                	   <!-- col-md-12 -->
                    <div class="col-md-12">
                        <!-- form start -->
                        <form class="form-horizontal" action="csafterupload.asp" method="post">
                        	<!-- box box-info -->
                            <div class="box box-info">
                                <!-- box body -->
                                <div class="box-body">
									<!-- form group -->
                                   <div class="form-group">
										<label class="col-sm-3 control-label">File Name : </label>
										<div class="col-sm-3">
											<span class = "mod-form-control"><%=sFileName%></span>
											<input type="hidden" id="txtFileName" name="txtFileName" value="<%=sFileName%>" />
                                        </div>
                                   </div>
									<label class="col-sm-5 control-label"><font color="red">* The File had been process successfully.</font></label>
									<input type="button" class="btn btn-new pull-right" name="btnReturn" value="Re-Upload" onclick="window.location = ('<%=sMainURL2%><%=sAddURL%>');" />
	                                <!-- /.box-footer -->
									<%if dtDisplay <> "" then%>
										<div id="content2">
											<!-- CONTENT HERE -->
										</div>
									<%end if%>
                                </div>
                                <!--/.box body-->
                            </div>
                            
                            <!-- /.box box-info -->
                        </form>
                        <!-- form end -->
                    </div>
                    <!--/.col-md-12 -->
                </div>
                <!--/.row -->
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->
    
     <!--mymodal start-->   
    <div class="modal fade bd-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel"></h4>
                </div>
                <div class="modal-body">
                    <div id="mycontent">
                        <!---mymodal content ---->
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!--mymodal end-->

	<!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
	
	<script>


    </script>
	<!--Script End-->
	

</body>
</html>
