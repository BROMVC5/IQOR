<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

    <%  
        Server.ScriptTimeout = 1000000

        sPath = "\database\Resign\"

        sDir = Server.MapPath(".") & sPath

        Set fso = Server.CreateObject("Scripting.FileSystemObject") 
        Set obj_FolderBase = fso.GetFolder(sDir)
        
        if obj_FolderBase.Files.Count = 0 then '=== Check if Attendance record data is in
            response.write " No Resign Data Found!"
            response.End 
        end if

     '===========================================================================================================  
        For Each obj_File In obj_FolderBase.Files  '=== For loop starts here and process every file in the folder
     '===========================================================================================================

                strFileName = "database\Resign\" & obj_File.Name
               
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
                            sAType = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                        
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sDtJoin = Trim(Mid(strRow, 1, iPos - 1))
                            sDtJoin =  fDate2(CDate(sDtJoin))
                            'sDtJoin = Mid(sDtJoin, 1, 2) & "/" & Mid(sDtJoin, 4, 2) & "/" & Mid(sDtJoin, 7, 4)
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
             
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sDtResign = Trim(Mid(strRow, 1, iPos - 1))
                            if sDtResign <> "" then
                                sDtResign =  fDate2(CDate(sDtResign))
                                'sDtResign = Mid(sDtResign, 1, 2) & "/" & Mid(sDtResign, 4, 2) & "/" & Mid(sDtResign, 7, 4)
                            else
                               
                            end if
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
   
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sDept = Trim(Mid(strRow, 1, iPos - 1))
 
                            Set rstTMDept = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                            sSQL = "select * from TMDEPT where DEPT_ID ='" & sDept & "'" 
                            rstTMDept.Open sSQL, conn, 3, 3
                            if rstTMDept.eof then
                                
                                sSQL = "insert into TMDEPT (DEPT_ID,PART,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
                                sSQL = sSQL & "values ("
                                sSQL = sSQL & "'" & UCase(sDept) & "',"
                                sSQL = sSQL & "'" & sDept & "',"
                                sSQL = sSQL & "'SERVER',"
                                sSQL = sSQL & "'" & fDateTime() & "',"
                                sSQL = sSQL & "'SERVER',"
                                sSQL = sSQL & "'" & fDateTime() & "'"
                                sSQL = sSQL & ") "
                                conn.execute sSQL

                            end if
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
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sCost_ID = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sCont_ID = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                     
                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            
                            sDesign = Trim(Mid(strRow, 1, iPos - 1))

                            Set rstTMDesign = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                            sSQL = "select * from TMDESIGN where DESIGN_ID ='" & sDesign & "'" 
                            rstTMDesign.Open sSQL, conn, 3, 3
                            if not rstTMDesign.eof then 
                            
                            else
                                sDesign = "No Such Designation"
                                'response.write sDEsign & " No such Design "
                                'response.end
                            end if

                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sAreaCode = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sGenShf = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sOwnTrans = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

'response.write " ----@@---- : " & sEmp_Code & "," & sCardNo & "," & sName & "," &  sAType & "," & sDtJoin & "," & sDtResign & "," & sDept & "," & sGrade & "," & sSuper & "," & sCost_ID & "," & sCont_ID & "," & sDesign & "," & sAreaCode & "," & sGenShf & "," & sOwnTrans & "<br>"    
                        
                        'if a = 1 then '@@@@@@
                        
                        Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                        sSQL = "select * from TMEMPLY where EMP_CODE ='" & sEmp_Code & "'" 
                        rstTMEmply.Open sSQL, conn, 3, 3
                        if not rstTMEmply.eof then  

                            sSQL = "UPDATE TMEMPLY SET "
                            sSQL = sSQL & "EMP_CODE= '" & pRTIN(sEmp_Code) & "',"
                            sSQL = sSQL & "CARDNO= '" & pRTIN(sCardNo) & "',"
                            sSQL = sSQL & "NAME= '" & pRTIN(sName) & "',"
                            sSQL = sSQL & "ATYPE= '" & pRTIN(sAtype) & "',"
                            sSQL = sSQL & "DT_JOIN= '" & pRTIN(sDtJoin) & "',"
                            sSQL = sSQL & "DT_RESIGN= '" & pRTIN(sDtResign) & "',"
                            sSQL = sSQL & "DEPT_ID='" & pRTIN(sDept) & "',"
                            sSQL = sSQL & "GRADE_ID='" & pRTIN(sGrade) & "',"
                            sSQL = sSQL & "SUP_CODE='" & sSuper & "',"
                            sSQL = sSQL & "COST_ID='" & sCost_ID & "',"
                            sSQL = sSQL & "CONT_ID='" & sCont_ID & "',"
                            sSQL = sSQL & "DESIGN_ID='" & sDesign & "',"
                            sSQL = sSQL & "AREACODE='" & sAreaCode & "',"
                            sSQL = sSQL & "GENSHF='" & sGenShf & "',"
                            sSQL = sSQL & "OWNTRANS= '" & sOwnTrans & "',"
                            sSQL = sSQL & "USER_ID= 'SERVER',"
                            sSQL = sSQL & "DATETIME= '" & fDateTime() & "',"
                            sSQL = sSQL & "CREATE_ID= 'SERVER',"
                            sSQL = sSQL & "DT_CREATE= '" & fDateTime() & "'"
                            sSQL = sSQL & " WHERE EMP_CODE = '" & sEmp_Code & "'"
                            conn.execute sSQL
                             
            response.write sSQL & "<br>"                          
        
                        end if '@@@@if a = 1 
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
