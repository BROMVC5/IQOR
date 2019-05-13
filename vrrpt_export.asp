<!-- #include file="include/connection.asp" -->
<!-- #include file="include/validate.asp" -->
<!-- #include file="include/proc.asp" -->
<html>
<head>
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>
</head>
<body style="background-color: white">
<%

sType = request("txtType")
dtFrDate = request("dtFrDate1")
dtToDate = request("dtToDate1")
sIC = request("txtNRIC1")
sVend_Name = request("txtVend_Name1")
sCompID = request("txtComp_Name")
sStatus = request("sStatus1")

dtFrDate2 = request("dtFrDate2")
dtToDate2 = request("dtToDate2")
sIC2 = request("txtNRIC")
sVend_Name2 = request("txtVend_Name2")
sDept2 = request("txtDept_ID")
	    
sPage = 1

%>
<!-- AM/PM Time -->
<%
function ampmTime(InTime)
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
        ampmTime = FormatDateTime(OutHour & ":" & minute(Intime),4) & " " & ampm
	end function
%>

<!-- Column Function -->
<%
sep = chr(9)

Function fCol(dTemp)

	fCol = dTemp
	
End Function

%>

<!-- DateTime -->
<%
tsYear = Year(date())
tsMonth = month(date())
tsDay = day(date())
If len(tsMonth)=1 then tsMonth = "0" & tsMonth
If len(tsDay)=1 then tsDay = "0" & tsDay

tsHour = Hour(formatdatetime(now(),4))
tsMinute = Minute(formatdatetime(now(),4))
tsSecond = Second(formatdatetime(now(),3))
If len(tsHour) = 1 then tsHour = "0" & tsHour
If len(tsMinute) = 1 then tsMinute = "0" & tsMinute
If len(tsSecond) = 1 then tsSecond = "0" & tsSecond
sDtTime = tsYear & tsMonth & tsDay & tsHour & tsMinute & tsSecond

%>

<%
if sType = "BL" then	
	sFileName = "BlackL_" & sDtTime & ".xls"
elseif sType = "VR" then
	sFileName = "VendCI_" & sDtTime & ".xls"
end if
	
sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
				
if sType = "BL" then
	
	Set rstVRBlackL = server.CreateObject("ADODB.RecordSet")    
	sSQL = "select NRIC, VNAME, COMPNAME, HP, CAR_NO, BLREASON,BLIST "
	sSQL = sSQL & "FROM VRVEND "
	'sSQL = sSQL & "WHERE MID(DT_CREATE,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate),1,10) & "' AND '" & Mid(fdatetime2(dtToDate),1,10) & "' "
	sSQL = sSQL & " where 1=1 "
	
	if sIC <> "" then
		sSQL = sSQL & " AND NRIC like '" & pRTIN(sIC) & "%'"
	end if
	
	if sCompID <> "" then
		sSQL = sSQL & " AND COMPNAME ='" & pRTIN(sCompID) & "'"
	end if
	
	if sVend_Name <> "" then
		sSQL = sSQL & " AND VNAME like '%" & pRTIN(sVend_Name) & "%'"
	end if
	
	if sStatus <> "" then
		sSQL = sSQL & " AND BLIST ='" & pRTIN(sStatus) & "'"
	end if
	
	sSQL = sSQL & "ORDER BY NRIC ASC "
	rstVRBlackL.Open sSQL, conn, 3, 3
	response.write(sSQL)
		if not rstVRBlackL.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("NRIC") & sep & fCol("Vendor Name") & sep & fCol("Company Name") & sep & fCol("H/P") & sep & fCol("Vehicle No") & sep & fCol("Blacklist Reason") & sep & fCol("Blacklist")
			objOpenFile.WriteLine sStr
								  
			do while not rstVRBlackL.eof
				
				i = i + 1
				sNRIC = "'" & rstVRBlackL("NRIC")
				sVend_Name = rstVRBlackL("VNAME")
				sCompID = rstVRBlackL("COMPNAME")
				sHP = rstVRBlackL("HP")
				sCar = rstVRBlackL("CAR_NO")
				sBLReason = rstVRBlackL("BLREASON")	
				sBList = rstVRBlackL("BLIST")					
					
				sStr = i & sep & sNRIC & sep & sVend_Name & sep & sCompID & sep & sHP & sep & sCar & sep & sBLReason & sep & sBList
				objOpenFile.WriteLine sStr
				
			rstVRBlackL.movenext
			loop
		end if
		call pCloseTables(rstVRBlackL)
		
elseif sType = "VR" then
	
		Set rstVRVendCI = server.CreateObject("ADODB.RecordSet")    
		sSQL = "select VRVEND.NRIC, VRVEND.VNAME, VRVEND.COMPNAME, VRTRNS.APP_NAME, VRTRNS.DEPT, VRTRNS.DT_IN, VRTRNS.DT_OT,VRTRNS.BADGE_NO "
		sSQL = sSQL & "FROM VRVEND "
		sSQL = sSQL & "LEFT JOIN VRTRNS ON VRVEND.NRIC = VRTRNS.NRIC "
		sSQL = sSQL & "WHERE VRTRNS.BADGE_NO IS NOT NULL "
		sSQL = sSQL & "AND MID(vrtrns.DT_CREATE,1,10) BETWEEN '" & Mid(fdatetime2(dtFrDate2),1,10) & "' AND '" & Mid(fdatetime2(dtToDate2),1,10) & "' "
		
		if sIC2 <> "" then
		sSQL = sSQL & "AND VRVEND.NRIC like '" & pRTIN(sIC2) & "%'"
		end if
		
		if sCompID <> "" then
			sSQL = sSQL & "AND COMPNAME ='" & pRTIN(sCompID) & "'"
		end if
		
		if sDept2 <> "" then
			sSQL = sSQL & "AND DEPT ='" & pRTIN(sDept2) & "'"
		end if
		
		if sVend_Name2 <> "" then
			sSQL = sSQL & "AND VNAME like'%" & pRTIN(sVend_Name2) & "%'"
		end if
		
		sSQL = sSQL & "ORDER BY VRTRNS.NRIC ASC "
		rstVRVendCI.Open sSQL, conn, 3, 3
		
	   if not rstVRVendCI.EOF then
			i = 0
			
			sStr = fCol("No") & sep & fCol("NRIC") & sep & fCol("Vendor Name") & sep & fCol("Company Name") & sep & fCol("Appointment With") & sep & fCol("Department") & sep & fCol("Date/Time In") & sep & fCol("Date/Time Out") & sep & fCol("Badge No")
			objOpenFile.WriteLine sStr
								  
			do while not rstVRVendCI.eof
				
				i = i + 1				
				sNRIC = "'" & rstVRVendCI("NRIC")
				sVend_Name = rstVRVendCI("VNAME")
				sCompID = rstVRVendCI("COMPNAME")
				sApp_Name = rstVRVendCI("APP_NAME")
				sDept_ID = rstVRVendCI("DEPT")
				dtIn = rstVRVendCI("DT_IN")	
				dtOut = rstVRVendCI("DT_OT")
				sBadge = rstVRVendCI("BADGE_NO")				
					
				sStr = i & sep & sNRIC & sep & sVend_Name & sep & sCompID & sep & sApp_Name & sep & sDept_ID & sep & dtIn & sep & dtOut & sep & sBadge
				objOpenFile.WriteLine sStr
				
			rstVRVendCI.movenext
			loop
		end if
		call pCloseTables(rstVRVendCI)
		
end if


objOpenFile.Close
Set objOpenFile = nothing
Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>