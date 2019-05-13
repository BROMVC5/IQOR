<!DOCTYPE html>
<% Session.Timeout = 1440 %>

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
	<%
	
	Function pDateTime(dTemp)	
		pDateTime = Year(dTemp) & _
				"" & String(2 - Len(Month(dTemp)),"0") & Month(dTemp) & _
				"" & String(2 - Len(Day(dTemp)), "0") & Day(dTemp) & ""
		pDateTime = pDateTime & String(2 - Len(Hour(dTemp)),"0") & Hour(dTemp) & _
				"" & String(2 - Len(Minute(dTemp)),"0") & Minute(dTemp) & _
				"" & String(2 - Len(Second(dTemp)),"0") & Second(dTemp)
	end function
	
	function fAmPmTime(InTime)
    dim OutHour, ampm
    if hour(InTime) < 12 then
        OutHour = hour(InTime)
        ampm = "AM"
    end if
    if hour(InTime) = 12 then
        OutHour = hour(InTime)
        ampm = "PM"
    end if
    if hour(InTime) > 12 then
        OutHour = hour(InTime) - 12
        ampm = "PM"
    end if
    
    fAmPmTime = FormatDateTime(OutHour & ":" & minute(Intime),4) & " " & ampm
	end function
	
	function fTime2(dTemp)	
		fTime2 = String(2 - Len(Hour(dTemp)),"0") & Hour(dTemp) & _
				":" & String(2 - Len(Minute(dTemp)),"0") & Minute(dTemp)
	end Function

	%>
	
	<!-- Time Clock -->
	<script type="text/javascript">
	
	var bGetClock = true;
	var iClockDiff = 0;
	function toSeconds(t) {
	var bits = t.split(':');
	return bits[0]*3600 + bits[1]*60 + bits[2]*1;
	}
	
	function updateClock() {
	var clientTime = new Date ();
	var clientHours = clientTime.getHours ( );
	var clientMinutes = clientTime.getMinutes ( );
	var clientSeconds = clientTime.getSeconds ( );
	
	clientTime = clientHours + ":" + clientMinutes + ":" + clientSeconds;
	var secClient = toSeconds(clientTime);
	
	if (bGetClock) {
	<%	
		tsHour = Hour(formatdatetime(now(),4))
		tsMinute = Minute(formatdatetime(now(),4))
		tsSecond = Second(formatdatetime(now(),3))
		If len(tsHour) = 1 then tsHour = "0" & tsHour
		If len(tsMinute) = 1 then tsMinute = "0" & tsMinute
		If len(tsSecond) = 1 then tsSecond = "0" & tsSecond
		sServerTime = tsHour & ":" & tsMinute & ":" & tsSecond
	%>
	  	var serverTime = "<%=sServerTime%>";
	  	var secServer = toSeconds(serverTime);
	  	iClockDiff = secServer - secClient
	  	bGetClock = false;
	}
	
	secClient = secClient + iClockDiff;
	
	clientHours = parseInt( secClient / 3600 ) % 24;
	clientMinutes = parseInt( secClient / 60 ) % 60;
	clientSeconds = secClient % 60;
	
	clientHours = ( clientHours < 10 ? "0" : "" ) + clientHours;
	clientMinutes = ( clientMinutes < 10 ? "0" : "" ) + clientMinutes;
	clientSeconds = ( clientSeconds < 10 ? "0" : "" ) + clientSeconds;
	
	clientTimeString = clientHours + ":" + clientMinutes + ":" + clientSeconds;

	document.getElementById("clock").firstChild.nodeValue = clientTimeString;
	}
		
	</script>
		
	<script type="text/javascript">
	function init() {
		updateClock();
		setInterval('updateClock()', 1000 );
	}
	</script>


</head>
	
	<%	
	sModeSub = request("sub")
	sStatus = ""
	sStatusAmt = ""
	
	Set rstCSPath = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from cspath " 
    rstCSPath.Open sSQL, conn, 3, 3
    if not rstCSPath.eof then
    	sInitial = rstCSPath("COUNTER")
	end if
	call pCloseTables(rstCSPath)
	
	if sModeSub <> "" Then
	
 		sCardNo = reqForm("txtcardNo")
		sCardNo = (Right(sCardNo,6))
        
		if sModeSub = "scan" then

			Set rstCSEmply = server.CreateObject("ADODB.RecordSet")   
            sSQL = "select *  from csemply "
            sSQL = sSQL & "left join tmemply on csemply.emp_code = tmemply.emp_code "
            sSQL = sSQL & "where csemply.cardNO = '" & scardNo & "' and csemply.cardNO <> '' and csemply.STATUS = 'Y' and (tmemply.DT_RESIGN > '" & fDate2(Now()) & "' or DT_RESIGN IS NULL) "
            rstCSEmply.Open sSQL, conn, 3, 3
			if not rstCSEmply.eof then
			
				Set rstCSEmply1 = server.CreateObject("ADODB.RecordSet")    
				sSQL = "select csemply1.EMP_CODE, csemply1.TYPE, csemply1.DT_SUB, csemply1.AMOUNT, cstype.STIME,cstype.ETIME,cstype.PRIORITY,cstype.SHOWAMT, csemply.CARDNO from csemply1 "
				sSQL = sSQL & "left join cstype on csemply1.TYPE = cstype.SUBTYPE "
				sSQL = sSQL & "left join csemply on csemply1.EMP_CODE = csemply.EMP_CODE "
				sSQL = sSQL & "where CARDNO = '" & sCardNo & "' "
				sSQL = sSQL & "and DT_SUB = '" & fDate2(Now()) & "' "
				sSQL = sSQL & "and ('" & fTime2(now()) & "' BETWEEN STIME and ETIME or '" & fTime2(now()) & "' BETWEEN STIME2 and ETIME2) "
				sSQL = sSQL & "and TYPE NOT IN (select TYPE from cstrns where CARDNO = '" & sCardNo & "' and DT_TRNS LIKE '%" & fDate2(Now()) & "%' and STATUS = 'Y') "
				sSQL = sSQL & "order by priority asc "
				'RESPONSE.WRITE SSQL & "<br/>"
				rstCSEmply1.Open sSQL, conn, 3, 3
				if not rstCSEmply1.eof then
					
					Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
		            sSQL = "select * from cstrns "
		            sSQL = sSQL & "where CARDNO = '" & sCardNo & "' and TYPE = '" & rstCSEmply1("TYPE") & "'"
		            sSQL = sSQL & "and DT_TRNS LIKE '%" & fDate2(Now()) & "%' "
		            rstCSTrns.Open sSQL, conn, 3, 3
					if rstCSTrns.eof then
					
						sSQL = "insert into cstrnsz (USER_ID) values ('" & session("USERNAME") & "')"
						conn.execute sSQL
						
						Set rstCSTrns2 = server.CreateObject("ADODB.RecordSet")    
						sSQL = "select * from cstrnsz "
						sSQL = sSQL & " where USER_ID = '" & session("USERNAME") & "'"
						sSQL = sSQL & "order by autoinc desc limit 1"
						rstCSTrns2.Open sSQL, conn, 3, 3
						if not rstCSTrns2.eof then
							dAutoInc = rstCSTrns2("AUTOINC")
							sRefNo = sInitial & dAutoInc
							
							sSQL = "insert into cstrns(REFNO, CARDNO, COUPON, TYPE, DT_TRNS, STATUS, USER_ID, DATETIME)"
							sSQL = sSQL & "values ("
							sSQL = sSQl & "'" & pRTIN(sRefNo) & "',"
							sSQL = sSQL & "'" & pRTIN(sCardNo) & "',"
							sSQL = sSQL & "'" & pFormat(rstCSEmply1("AMOUNT"),2) & "',"	
							sSQL = sSQL & "'" & rstCSEmply1("TYPE") & "',"
							sSQL = sSQL & "'" & fDatetime2(Now()) & "',"							
							sSQL = sSQL & "'Y'," 	 
							sSQL = sSQL & "'" & session("USERNAME") & "'," 
							sSQL = sSQL & "'" & fDatetime2(Now()) & "'"         
							sSQL = sSQL & ") "	
							conn.execute sSQL
						end if
						call pCloseTables(rstCSTrns2)	
						
						if rstCSEmply1("SHOWAMT") = "Y" then							
							sStatus = "Y"
						else
							sStatus = "Y2"
						end if
						sStatusAmt = pFormat(rstCSEmply1("AMOUNT"),2)
						
					else
					
						sSQL = "insert into cstrnsz (USER_ID) values ('" & session("USERNAME") & "')"
						conn.execute sSQL
						
						Set rstCSTrns2 = server.CreateObject("ADODB.RecordSet")    
						sSQL = "select * from cstrnsz " 
						sSQL = sSQL & " where USER_ID = '" & session("USERNAME") & "'"
						sSQL = sSQL & "order by autoinc desc limit 1"
						rstCSTrns2.Open sSQL, conn, 3, 3
						if not rstCSTrns2.eof then
							dAutoInc = rstCSTrns2("AUTOINC")
							sRefNo = sInitial & dAutoInc
							
							sSQL = "insert into cstrns (REFNO, CARDNO, COUPON, DT_TRNS, STATUS, USER_ID, DATETIME)"
							sSQL = sSQL & "values ("
							sSQL = sSQl & "'" & pRTIN(sRefNo) & "',"
							sSQL = sSQL & "'" & pRTIN(sCardNo) & "',"
							sSQL = sSQL & "'0.00',"	
							sSQL = sSQL & "'" & fDatetime2(Now()) & "',"							
							sSQL = sSQL & "'N'," 	 
							sSQL = sSQL & "'" & session("USERNAME") & "'," 
							sSQL = sSQL & "'" & fDatetime2(Now()) & "'"         
							sSQL = sSQL & ") "
							conn.execute sSQL
						end if
						call pCloseTables(rstCSTrns2)

						sStatus = "N"
					end if
					call pCloseTables(rstCSTrns)
			
				Else

					Set rstCSPath = server.CreateObject("ADODB.RecordSet")    
					sSQL = "select * from cspath " 
					sSQL = sSQL & "where '" & fTime2(now()) & "' BETWEEN N_STIME and N_ETIME "
					rstCSPath.Open sSQL, conn, 3, 3
					if not rstCSPath.eof then
				
						Set rstCSTrns = server.CreateObject("ADODB.RecordSet")    
						sSQL = "select * from cstrns "
						sSQL = sSQL & "where CARDNO = '" & sCardNo & "' and TYPE = 'N'"
						sSQL = sSQL & "and DT_TRNS LIKE '%" & fDate2(Now()) & "%' "
						rstCSTrns.Open sSQL, conn, 3, 3
						if rstCSTrns.eof then
						
							sSQL = "insert into cstrnsz (USER_ID) values ('" & session("USERNAME") & "')"
							conn.execute sSQL
							
							Set rstCSTrns2 = server.CreateObject("ADODB.RecordSet")    
							sSQL = "select * from cstrnsz " 
							sSQL = sSQL & " where USER_ID = '" & session("USERNAME") & "'"
							sSQL = sSQL & "order by autoinc desc limit 1"
							rstCSTrns2.Open sSQL, conn, 3, 3
							if not rstCSTrns2.eof then
								dAutoInc = rstCSTrns2("AUTOINC")
								sRefNo = sInitial & dAutoInc
								
								sSQL = "insert into cstrns (REFNO, CARDNO, COUPON, TYPE, DT_TRNS, STATUS, USER_ID, DATETIME)"
								sSQL = sSQL & "values ("
								sSQL = sSQl & "'" & pRTIN(sRefNo) & "',"
								sSQL = sSQL & "'" & pRTIN(scardNo) & "',"
								sSQL = sSQL & "'" & pFormat(rstCSEmply("COUPON"),2) & "',"	
								sSQL = sSQL & "'N',"
								sSQL = sSQL & "'" & fDatetime2(Now()) & "',"						
								sSQL = sSQL & "'Y'," 	 
								sSQL = sSQL & "'" & session("USERNAME") & "'," 
								sSQL = sSQL & "'" & fDatetime2(Now()) & "'"         
								sSQL = sSQL & ") "
								conn.execute sSQL
							end if
							call pCloseTables(rstCSTrns2)
										
							sStatus = "Y"  
							sStatusAmt = pFormat(rstCSEmply("COUPON"),2)
	  	
						else
						
							sSQL = "insert into cstrnsz (USER_ID) values ('" & session("USERNAME") & "')"
							conn.execute sSQL
							
							Set rstCSTrns2 = server.CreateObject("ADODB.RecordSet")    
						    sSQL = "select * from cstrnsz " 
							sSQL = sSQL & " where USER_ID = '" & session("USERNAME") & "'"
						    sSQL = sSQL & "order by autoinc desc limit 1"
						    rstCSTrns2.Open sSQL, conn, 3, 3
						    if not rstCSTrns2.eof then
						    	dAutoInc = rstCSTrns2("AUTOINC")
						    	sRefNo = sInitial & dAutoInc
						    	
							    sSQL = "insert into cstrns (REFNO, CARDNO, COUPON, DT_TRNS, STATUS, USER_ID, DATETIME)"
								sSQL = sSQL & "values ("
								sSQL = sSQl & "'" & pRTIN(sRefNo) & "',"
								sSQL = sSQL & "'" & pRTIN(sCardNo) & "',"
								sSQL = sSQL & "'0.00',"	
								sSQL = sSQL & "'" & fDatetime2(Now()) & "',"							
								sSQL = sSQL & "'N'," 	 
								sSQL = sSQL & "'" & session("USERNAME") & "'," 
								sSQL = sSQL & "'" & fDatetime2(Now()) & "'"         
								sSQL = sSQL & ") "
								conn.execute sSQL
						    end if
						    call pCloseTables(rstCSTrns2)
							
				 	  	    sStatus = "N"
								 	  	    
						end if
						call pCloseTables(rstCSTrns)
					
					else
						sStatus = "E"
					end if
					call pCloseTables(rstCSPath)
				
				End If
				call pCloseTables(rstCSEmply1)
					
 	  		else
 	  			sStatus = "I"
 	  		end if
 	  		call pCloseTables(rstCSEmply)	
			
		end if
	end if

    Set rstLstImp = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select DT_IMP from cspath"
    rstLstImp.Open sSQL, conn, 3, 3
    if not rstLstImp.eof then          
        dtDt_Imp = rstLstImp("DT_IMP") 
    end if
    call pCloseTables(rstLstImp)
	
    set rstOffMode = server.CreateObject("ADODB.RecordSet")
    sSQL = "select OFF_MODE from cspath"
    rstOffMode.Open sSQL, conn, 3, 3
    if not rstOffMode.eof then
        sOffMode = rstOffMode("OFF_MODE")
    end if
    call pCloseTables(rstOffMode)
	
	%>

<body>
	

		   <!-- form group -->
           <div class="form-group" style="height:6vh">
           		<div class="col-sm-12" style="top:2vh" >
                       <div class="col-sm-4">
		                <form class="form-horizontal" action="cspos.asp?p=<%=pDateTime(now())%>" method="post">
	           		  	<input type="text" id="txtcardNo" name="txtcardNo" maxlength="10" autocomplete="off" 
	           		  	style="height:30px;font-size: 14px;border: 1px solid #ccc;" autofocus > 
	           		  	&nbsp;&nbsp;
			          	<button type="submit" name="sub" value="scan" class="btn btn-info" style="width: 94px;">Scan</button>
                        </div>
                        <div style="text-align:center" class="col-sm-3">
                            <font class="text-center" style="font-size:10px;text-align:center">Last Update: <% response.write dtDt_Imp %></font>  
                        </div>
				        <div style="float:right;text-align:right" class="col-sm-4">
					        <h3><%=Date%>&nbsp;&nbsp;<span id="clock">&nbsp;</span>
					        <span>
                                <%if sOffMode = "Y" then%>
					        	<a href="csposting.asp" id="btndt_date" class="btn btn-default" style="margin-left: 0px" title="Import/Export">
                                    <i class="fa fa-exchange"></i>
                                </a>
                                <%end if%>
                                <a href="login.asp" id="btndt_date" class="btn btn-default" style="margin-left: 0px" title="Logout">
                                    <i class="fa fa-sign-out"></i>
                                </a>
                            </span>
				          	<script type="text/javascript">window.onload = init();</script></h3>
				          	
				        </div>
				        	
				
			       </form>
		        </div>    
		   </div>
		   <!--/.form group -->
		  
		   <!-- form group -->
		   <%if sStatus="Y" then%>
		   <div class="alert-success text-center" style="height:30vh">  		
	          <h1 style="padding-top:10vh;font-size:6em;">RM <%=sStatusAmt%></h1>
		   </div>
		   <%elseif sStatus="Y2" then%>
            <div class="alert-success text-center" style="height:30vh">  		
	          <h1 style="padding-top:10vh;font-size:6em;">RM 0.00</h1>
		   </div>
		   <%elseif sStatus="N" then%>
           <div class="alert-danger text-center" style="height:30vh"> 
           	  <h1 style="padding-top:10vh;font-size:6em;">No Balance</h1>
		   </div>
		   <%elseif sStatus="I" then%>
		   <div class="alert-danger text-center" style="height:30vh">  		
	          <h1 style="padding-top:10vh;font-size:6em;">Invalid Card No</h1>
		   </div>
		   <%elseif sStatus="E" then%>
		   <div class="alert-danger text-center" style="height:30vh">  		
	          <h1 style="padding-top:10vh;font-size:6em;">Time Expired</h1>
		   </div>
		   <%else%>
		   <div class="bg-light-blue color-palette text-center" style="height:30vh">
		    <h1 style="padding-top:10vh;font-size:6em;">Please Scan..</h1>
		   </div>
		   <%end if%>
		   <!--/.form group -->
		   
		   <!-- form group -->
           <div class="form-group" style="height:60vh;overflow:auto" >
		      	<table id="example1" class="table table-bordered table-striped">
			        <thead>
			            <tr>
			            	<th style="width:10%">Employee No</th>
			                <th style="width:20%">Name</th>
			                <th style="width:10%">Time</th>
							 <th style="width:10%">Type</th>
			                <th style="width:10%;text-align:right">Subsidy Amount (RM)</th>
			                <th style="width:10%;text-align:center">Status</th>
			            </tr>
			        </thead>
		        
			        <tbody>
			            <%
			                Set rstCSTrns = server.createobject("adodb.recordset")
							sSQL = "select cstrns.DT_TRNS, cstrns.COUPON, cstrns.TYPE, cstrns.STATUS, cstrns.CARDNO, cstype.PART, cstype.SHOWAMT, cstrns.USER_ID from cstrns "
							sSQL = sSQL & "left join cstype on cstrns.type = cstype.subtype "
							sSQL = sSQL & "where DT_TRNS LIKE '%" & fDate2(Now()) & "%' "
							sSQL = sSQL & "and cstrns.USER_ID = '" & session("USERNAME") & "' "
							sSQL = sSQL & "order by DT_TRNS desc limit 100"
							'response.write ssql
							rstCSTrns.Open sSQL, conn, 3, 3
							
				                do while not rstCSTrns.eof 
				                
				                Set rstcsemply = server.CreateObject("ADODB.RecordSet")    
						        sSQL = "select * from csemply where cardNO = '" & rstCSTrns("cardNO") & "'"
						        rstcsemply.Open sSQL, conn, 3, 3
						        if not rstcsemply.eof then
						        	sEmpCode = rstcsemply("EMP_CODE")
                                    sName = rstcsemply("NAME")
                                end if        
                                call pCloseTables(rstcsemply)

								        response.write "<tr>"
						                response.write "<td>" & sEmpCode & "</td>"
						                response.write "<td>" & sName & "</td>"
						                response.write "<td>" & fAmPmTime(rstCSTrns("DT_TRNS")) & "</td>"
										if rstCSTrns("TYPE") = "N" then
											response.write "<td>NORMAL</td>"
										else
											response.write "<td>" & rstCSTrns("PART") & "</td>"
										end if	
										
										if rstCSTrns("STATUS") = "Y" then
											if rstCSTrns("SHOWAMT") = "N" then
												response.write "<td style='width:10%;text-align:right'>" & "0.00" & "</td>"  
												response.write "<td class='bg-green color-palette' style='width:10%;text-align:center'> OK </td>"
												
											else
												response.write "<td style='width:10%;text-align:right'>" & pFormatDec(rstCSTrns("COUPON"),2) & "</td>"  
												response.write "<td class='bg-green color-palette' style='width:10%;text-align:center'> OK </td>"
											end if
						               	else
						               		response.write "<td style='width:10%;text-align:right'>" & "0.00" & "</td>"  
						               		response.write "<td class='bg-red color-palette' style='width:10%;text-align:center'> No Balance </td>"
						               	end if
						                response.write "</tr>"
						                rstCSTrns.movenext
							 	  	    
					            loop
					            call pCloseTables(rstCSTrns)
					      							
			            %>                     
			        </tbody>
		        
		    	</table>
		   </div>
		   <!--/.form group -->
	
	<!-- Script Start -->
	<script>
	    $(document).ready(function(){
	        document.getElementById('txtcardNo').value = "";  
    
	    });


	</script>
	
	<!-- Script End -->
</body>
</html>
