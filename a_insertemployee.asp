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
                            sName = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                        
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sCostCenter = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                        
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sDesign = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                        
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sGrade = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sSuper = Trim(Mid(strRow, 1, iPos - 1))
                        End If

                        sDate = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                     
response.write " ----@@---- : " & sEmp_Code & "," & sName & "," & sCostCenter & "," &  sDesign & "," & sGrade & "," & sSuper &"<br>"    
                        
                        'if a = 1 then '@@@@@@
                        Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                        sSQL = "select * from TMEMPLY where EMP_CODE ='" & sEmp_Code & "'" 
                        rstTMEmply.Open sSQL, conn, 3, 3
                        if rstTMEmply.eof then             
                            
                            Set rstTMCost = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                            sSQL = "select * from TMCOST where PART ='" & trim(sCostCenter) & "'" 
                            rstTMCost.Open sSQL, conn, 3, 3
                            if not rstTMCost.eof then

                                sCost_ID = rstTMCost("COST_ID")

                                Set rstTMDesign = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                                sSQL = "select * from TMDESIGN where DESIGN_ID ='" & trim(sDesign) & "'" 
                                rstTMDesign.Open sSQL, conn, 3, 3
                                if not rstTMDesign.eof then
                                        
                                        sSQL = "insert into TMEMPLY (EMP_CODE,NAME,COST_ID,DESIGN_ID,GRADE_ID,SUP_CODE,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                sSQL = sSQL & "values ("
		                                sSQL = sSQL & "'" & sEmp_Code & "',"		
		                                sSQL = sSQL & "'" & pRTIN(sName) & "',"
		                                sSQL = sSQL & "'" & sCost_ID & "',"
		                                sSQL = sSQL & "'" & sDesign & "',"
                                        sSQL = sSQL & "'" & sGrade & "',"
                                        sSQL = sSQL & "'" & sSup_Code & "',"
                                        sSQL = sSQL & "'SERVER'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                        sSQL = sSQL & "'SERVER'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                sSQL = sSQL & ") "
                                        conn.execute sSQL
                                        
                                else
                                    response.write "No Such Design ID" & sDesign & "<br>"
                                'response.End

                                    sSQL = "insert into TMDESIGN (DESIGN_ID,PART,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                            sSQL = sSQL & "values ("
		                            sSQL = sSQL & "'" & UCASE(sDesign) & "',"		
		                            sSQL = sSQL & "'" & sDesign & "',"
		                            sSQL = sSQL & "'SERVER'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                    sSQL = sSQL & "'SERVER'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                            sSQL = sSQL & ") "
                                    conn.execute sSQL

                                        sSQL = "insert into TMEMPLY (EMP_CODE,NAME,COST_ID,DESIGN_ID,GRADE_ID,SUP_CODE,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                sSQL = sSQL & "values ("
		                                sSQL = sSQL & "'" & sEmp_Code & "',"		
		                                sSQL = sSQL & "'" & pRTIN(sName) & "',"
		                                sSQL = sSQL & "'" & sCost_ID & "',"
		                                sSQL = sSQL & "'" & sDesign & "',"
                                        sSQL = sSQL & "'" & sGrade & "',"
                                        sSQL = sSQL & "'" & sSup_Code & "',"
                                        sSQL = sSQL & "'SERVER'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                        sSQL = sSQL & "'SERVER'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                sSQL = sSQL & ") "
                                        conn.execute sSQL
                                end if
                            else
                                response.write "No Such Cost Center" & sCostCenter & "<br>"
                                'response.End

                                        sSQL = "insert into TMEMPLY (EMP_CODE,NAME,COST_ID,DESIGN_ID,GRADE_ID,SUP_CODE,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                sSQL = sSQL & "values ("
		                                sSQL = sSQL & "'" & sEmp_Code & "',"		
		                                sSQL = sSQL & "'" & pRTIN(sName) & "',"
		                                sSQL = sSQL & "'" & sCost_ID & "',"
		                                sSQL = sSQL & "'" & sDesign & "',"
                                        sSQL = sSQL & "'" & sGrade & "',"
                                        sSQL = sSQL & "'" & sSup_Code & "',"
                                        sSQL = sSQL & "'SERVER'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                        sSQL = sSQL & "'SERVER'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                sSQL = sSQL & ") "
                                        conn.execute sSQL
                            end if
                        else
                            response.write "The EmpCode is dulplicate" & sEmp_code & "<br>"
                            response.End
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
