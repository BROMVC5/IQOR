
	<!-- #include file="include/connection.asp" -->
	<!-- #include file="include/proc.asp" -->
	<!-- #include file="include/option.asp" -->
<%
	Response.ContentType = "application/json"
	
		sEmp_ID = request("empcode")
		sEn_Name = request("entitlement")
		iAutoInc = request("autoinc")
		
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
			sCurrentYear = DatePart("yyyy", now())
			
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
				if iAutoInc <> "" then
					sSQL = sSQL & " and  autoinc <> '" & iAutoInc & "' "
				end if
				sSQL = sSQL & " and  year(dt_Attend) = '" & year(now) & "' "
				rstStaff.Open sSQL, conn, 3, 3
				if not rstStaff.eof then
					dTempClaimAmt = pFormat(rstStaff("CLAIMA"),2)
				end if
				
				dBal = dMaxClaim - dTempClaimAmt
			End if
			
			str = "{""amount"": """ & pFormatDec(dBal,2) & """}"
			response.write str
%>  
