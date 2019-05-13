<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

    <%  
        Server.ScriptTimeout = 1000000

        sPath = "\database\workgroup\"

        sDir = Server.MapPath(".") & sPath

        Set fso = Server.CreateObject("Scripting.FileSystemObject") 
        Set obj_FolderBase = fso.GetFolder(sDir)
        
        if obj_FolderBase.Files.Count = 0 then '=== Check if Attendance record data is in
            response.write " No Attendance Data Found!"
            response.End 
        end if

     '===========================================================================================================  
        For Each obj_File In obj_FolderBase.Files  '=== For loop starts here and process every file in the folder
     '===========================================================================================================

                strFileName = "database\workgroup\" & obj_File.Name
               
                set fs = fso.OpenTextFile (Server.MapPath(strFileName), 1, False)
                if not fs.AtEndOfStream then

                Do while not fs.AtEndOfStream 
        
                    strRow = fs.ReadLine

                    if strRow <> "" then

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sEmp_Code = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sName = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        
                        sWorkGrp = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                     
response.write " ----@@---- : " & sEmp_Code & "," & sName & "," & sWorkGrp & "<br>"    

                        Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                        sSQL = "select * from TMSHFPLAN where WORKGRP_ID ='" & trim(sWorkGrp) & "'" 
                        rstTMWorkGrp.Open sSQL, conn, 3, 3
        if sEmp_Code = "102572" then
            response.write sSQL 
        '    response.End
        end if
                        if not rstTMWorkGrp.eof then
        
                            Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    
                            sSQL = "select * from TMEMPLY where EMP_CODE ='" & trim(sEmp_Code) & "'" 
                            rstTMEmply.Open sSQL, conn, 3, 3
                            if not rstTMEmply.eof then 
                                
                                'Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                                'sSQL = "select * from TMWORKGRP where WORKGRP_ID ='" & trim(sWorkGrp) & "'" 
                                'sSQL = sSQL & " and EMP_CODE ='" & trim(sEmp_Code) & "'" 
                                'rstTMWorkGrp.Open sSQL, conn, 3, 3
                                'if rstTMWorkGrp.eof then
        
                                    sPart = rstTMWorkGrp("PART")

                                    sSQL = "insert into TMWORKGRP (WORKGRP_ID, PART,EMP_CODE,NAME,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                            sSQL = sSQL & "values ("
		                            sSQL = sSQL & "'" & UCase(sWorkGrp) & "',"		
		                            sSQL = sSQL & "'" & sPart & "',"
		                            sSQL = sSQL & "'" & sEmp_Code & "',"
		                            sSQL = sSQL & "'" & pRTIN(sName) & "',"
	                                sSQL = sSQL & "'SERVER'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                    sSQL = sSQL & "'SERVER'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                            sSQL = sSQL & ") "
                                    conn.execute sSQL
                                'else
                                 '   response.write "EMP_CODE : " & sEmp_Code & " Already has a " & sWorkGrp & "<br>"
                                'end if
                            else
                                response.write "The EmpCode does not exist : " & sEmp_code & "<br>"
                            end if
                        
                        else
                            response.write "The WorkGroup does not exist : " & sWorkGrp & "<br>"
                            'response.End
                        end if
            
                    end if '==== End if strRow and isDate(sDate)
                Loop
            end if '=== End if not fs.AtEndOfStream
            pCloseTables(fs)
        Next
     %>
</head>

<body>


</body>

</html>
