<!-- #include file="include/connection.asp" -->
<!-- #include file="include/validate.asp" -->
<!-- #include file="include/proc.asp" -->
<html>
<head>
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>
</head>
<body style="background-color: white">
<%

txtSearch = trim(request("txtSearch"))

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

sFileName = "Emply_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "where (EMP_CODE like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (NAME like '%" & ScStr & "%') "
    end if

    sql = "select * from TMEmply "
    if sql_1 <> "" then
	    sql = sql & sql_1
    end if 
    sql = sql & "order by EMP_CODE,NAME "

    set rstTMEmply = server.createobject("adodb.recordset")
    rstTMEmply.Open sql, conn, 3, 3
	if not rstTMEmply.eof then
    
	    sStr = fCol("No") & sep & fCol("Employee Code") & sep & fCol("Card No") & sep & fCol("First Name") & sep & fCol("Last Name") & sep & fCol("Display Name") & sep
        sStr = sStr & fCol("Acces Type") & sep & fCol("Email") & sep & fCol("Date Join") & sep & fCol("Date Confirm") & sep & fCol("Date Resign") & sep 
        sStr = sStr  & fCol("Department") & sep & fCol("Grade") & sep & fCol("Superior") & sep & fCol("Cost Center") & sep & fCol("Employment Contract") & sep & fCol("Designation") & sep
	    sStr = sStr & fCol("Address 1") & sep & fCol("Address 2") & sep & fCol("City") & sep & fCol("State") & sep & fCol("Country") & sep 
        sStr = sStr & fCol("Correspondent Address 1") & sep & fCol("Correspondent Address 2") & sep & fCol("City") & sep & fCol("State") & sep & fCol("Country") & sep  & fCol("Tel") & sep & fCol("Mobile Phone") & sep 
        sStr = sStr & fCol("Date of Birth") & sep & fCol("Gender") & sep & fCol("NRIC") & sep & fCol("Race") & sep & fCol("Passport No") & sep  & fCol("Marital Status") & sep & fCol("Nationality") & sep & fCol("Religion") & sep
        sStr = sStr & fCol("Work Permit Number") & sep & fCol("Work Permit Expiry Date") & sep & fCol("Work Location") & sep & fCol("Area Code") & sep & fCol("Generate Shift") & sep  & fCol("Own Transport") & sep 
        objOpenFile.WriteLine sStr
		
		do while not rstTMEmply.eof
            sRecord = sRecord + 1
		    sStr = sRecord & sep & rstTMEmply("EMP_CODE") & sep & rstTMEmply("CARDNO") & sep & rstTMEmply("FNAME") & sep & rstTMEmply("LNAME") & sep & rstTMEmply("NAME") & sep
		    sStr = sStr & rstTMEmply("ATYPE") & sep & rstTMEmply("EMAIL") & sep & rstTMEmply("DT_JOIN") & sep & rstTMEmply("DT_CONFIRM") & sep & rstTMEmply("DT_RESIGN") & sep 
        	sStr = sStr & rstTMEmply("DEPT_ID") & sep & rstTMEmply("GRADE_ID") & sep & rstTMEmply("SUP_CODE") & sep & rstTMEmply("COST_ID") & sep & rstTMEmply("CONT_ID") & sep & rstTMEmply("DESIGN_ID") & sep
            sStr = sStr & rstTMEmply("ADD1") & sep & rstTMEmply("ADD2") & sep & rstTMEmply("CITY") & sep & rstTMEmply("STATE") & sep & rstTMEmply("COUNTRY") & sep 
            sStr = sStr & rstTMEmply("CADD1") & sep & rstTMEmply("CADD2") & sep & rstTMEmply("CCITY") & sep & rstTMEmply("CSTATE") & sep & rstTMEmply("CCOUNTRY") & sep & rstTMEmply("TEL") & sep & rstTMEmply("HP") & sep 
            sStr = sStr & rstTMEmply("DT_DOB") & sep & rstTMEmply("GEN") & sep & rstTMEmply("NAT_ID") & sep & rstTMEmply("RACE") & sep & rstTMEmply("PASSPORT") & sep & rstTMEmply("MARITAL") & sep & rstTMEmply("NATION") & sep & rstTMEmply("RELIG") & sep
            sStr = sStr & rstTMEmply("WP_NUM") & sep & rstTMEmply("DT_WORKPEX") & sep & rstTMEmply("WORK_ID") & sep & rstTMEmply("AREACODE") & sep & rstTMEmply("GENSHF") & sep & rstTMEmply("OWNTRANS") & sep 
            objOpenFile.WriteLine sStr
				
		rstTMEmply.movenext
    	loop
			
	end if
	call pCloseTables(rstTMEmply)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>