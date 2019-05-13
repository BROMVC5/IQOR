<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

    <%  
        Server.ScriptTimeout = 1000000

        sPath = "\database\Employee Listing\"

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

                strFileName = "database\Employee Listing\" & obj_File.Name
               
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
                            sCardNo = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                        
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sName = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                        
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sDepart = Trim(Mid(strRow, 1, iPos - 1))
                        End If

                        sDesign = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                     
response.write " ----@@---- : " & sEmp_Code & "," & sCardNo & "," & sName & "," &  sDepart & "," & sDesign & "<br>"    
                        
                        'if a = 1 then '@@@@@@
                        Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                        sSQL = "select * from TMEMPLY where EMP_CODE ='" & trim(sEmp_Code) & "'" 
                        rstTMEmply.Open sSQL, conn, 3, 3
                        if not rstTMEmply.eof then             
                            
                            Set rstTMDepart = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                            sSQL = "select * from TMDEPT where DEPT_ID ='" & trim(sDepart) & "'" 
                            rstTMDepart.Open sSQL, conn, 3, 3
                            if not rstTMDepart.eof then   
                            
                                sSQL = "UPDATE TMEMPLY SET "             
                                sSQL = sSQL & "DEPT_ID = '" & sDepart & "',"
                                sSQL = sSQL & "CARDNO = '" & sCardNo & "'"
                                sSQL = sSQL & " WHERE EMP_CODE = '" & sEmp_Code & "'"
                                conn.execute sSQL
                            else
                                response.write "The Department ID doesn't exists : " & sDepart & "<br>"

                                sSQL = "insert into TMDEPT (DEPT_ID,PART,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                        sSQL = sSQL & "values ("
		                        sSQL = sSQL & "'" & UCASE(sDepart) & "',"		
		                        sSQL = sSQL & "'" & sDepart & "',"
		                        sSQL = sSQL & "'SERVER'," 
                                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                sSQL = sSQL & "'SERVER'," 
                                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                        sSQL = sSQL & ") "
                                conn.execute sSQL

                                sSQL = "UPDATE TMEMPLY SET "             
                                sSQL = sSQL & "DEPT_ID = '" & sDepart & "',"
                                sSQL = sSQL & "CARDNO = '" & sCardNo & "'"
                                sSQL = sSQL & " WHERE EMP_CODE = '" & sEmp_Code & "'"
                                conn.execute sSQL
                            end if
                        else
                            response.write "The EmpCode doesn't exists : " & sEmp_code & "<br>"
                            'response.End
                        end if
                        'end if '@@@@if a = 1 
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
