<!-- #include file="include/connection.asp" -->
<!-- #include file="include/validate.asp" -->
<!-- #include file="include/proc.asp" -->
<html>
<head>
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>
</head>
<body style="background-color: white">

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

sFileName = "LOG_" & sDtTime & ".xls"

sFilePath = server.mappath("EXCEL\" & sFileName)

Set fso = Server.CreateObject("Scripting.FileSystemObject")
Set objCreatedFile = fso.CreateTextFile(sFilePath)
objCreatedFile.close
Set objOpenFile = fso.OpenTextFile(sFilePath,8,True)
	
    sOrderBy = trim(request("txtOrderBy"))
    sAscDesc = trim(request("txtAscDesc"))     
    'sEMP_CODE = UCase(request("txtEMP_CODE"))
    dtpFrDate = request("dtpFrDate")
    dtpToDate = request("dtpToDate")

    if dtpFrDate = "" then
        dtpFrDate = "01-01-1000"
    end if

    if dtpToDate = "" then
        dtpToDate = "31-12-9999"
    end if

    sStatus = trim(request("selStatus"))

    if dtpFrDate <> "" then 
        sSQL_1 = sSQL_1 & " and DATE(tmlog.DATETIME) between '" & fdate2(dtpFrDate) & "' and '" & fdate2(dtpToDate) & "'"
    end if

    if sStatus <> "" then 
        sSQL_1 = sSQL_1 & " and STATUS = '" & sStatus & "'"
    end if

    sSQL = "select tmlog.EMP_CODE as EMPCODE, tmemply.NAME, tmlog.*"
    sSQL = sSQL & " from TMlog left join tmemply"
    sSQL = sSQL & " on tmemply.EMP_CODE = tmlog.EMP_CODE"
    sSQL = sSQL & " where 1=1 " 

    if sSQL_1 <> "" then
	    sSQL = sSQL & sSQL_1
    end if 

    if sOrderBy = ""  then
        sSQL = sSQL & " order by tmlog.DATETIME  desc"
    else
        if sAscDesc = "Asc" then
            sSQL = sSQL & " order by " & sOrderBy & " asc "
        elseif sAscDesc = "Desc" then
            sSQL = sSQL & " order by " & sOrderBy & " desc"
        end if
    end if

    set rstTMLOG = server.createobject("adodb.recordset")
    rstTMLOG.Open sSQL, conn, 3, 3
	if not rstTMLOG.eof then
    
	    sStr = fCol("No") & sep & fCol("Date and Time") & sep & fCol("Type") & sep & fCol("Status") & sep & fCol("Remark") & sep
        sStr = sStr & fCol("Date Work") & sep & fCol("Emp Code") & sep & fCol("Name")& sep & fCol("User ID")
        objOpenFile.WriteLine sStr
		
		do while not rstTMLOG.eof
            sRecord = sRecord + 1
		    sStr = sRecord & sep & rstTMLOG("DATETIME") & sep & rstTMLOG("TYPE") & sep & rstTMLOG("STATUS") & sep & rstTMLOG("REMARK") & sep
		    sDT_WORK = rstTMLOG("DT_WORK")
            if sDT_WORK = "" then
                sDT_WORK = "Not Applicable"
            end if
            
            sEmpCode = rstTMLOG("EMPCODE")
            sName = rstTMLOG("NAME")
            
            if sEmpCode = "" then
                sEmpCode = "Not Applicable"
            end if

            sStr = sStr & sDT_WORK & sep 
            sStr = sStr & sEmpCode & sep & sName & sep 
        	sStr = sStr & rstTMLOG("USER_ID") 
            objOpenFile.WriteLine sStr
				
		rstTMLOG.movenext
    	loop
			
	end if
	call pCloseTables(rstTMLOG)

    objOpenFile.Close
    Set objOpenFile = nothing
    Set fso = nothing

response.redirect "EXCEL/" & sFileName
	
%>

</body>
</html>