﻿<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

    <%  
        Server.ScriptTimeout = 1000000

        sPath = "\database\"

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

                strFileName = "database\" & obj_File.Name
               
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
                            sGender = Trim(Mid(strRow, 1, iPos - 1))
                            if sGender = "Male" then
                                sGender = "M"
                            else
                                sGender = "F"
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
                            
                            sDesign = Trim(Mid(strRow, 1, iPos - 1))
                            Set rstTMDesign = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                            sSQL = "select * from TMDESIGN where DESIGN_ID ='" & sDesign & "'" 
                            rstTMDesign.Open sSQL, conn, 3, 3
                            if not rstTMDesign.eof then 
                            
                            else
                                response.write sDEsign & " No such Design "
                                response.end
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
                            Set rstTMSup = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                            sSQL = "select * from TMEMPLY where NAME ='" & pRTIN(sSuper) & "'" 
                            rstTMSup.Open sSQL, conn, 3, 3
                            if not rstTMSup.eof then 
                            
                                sSuper = rstTMSup("EMP_CODE")
                            
                            else
                                response.write " No such Supervisor "
                                response.end
                            end if
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sDtJoin = Trim(Mid(strRow, 1, iPos - 1))
                            sDtJoin = Mid(sDtJoin, 1, 2) & "/" & Mid(sDtJoin, 4, 2) & "/" & Mid(sDtJoin, 7, 4) 
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sNation = Trim(Mid(strRow, 1, iPos - 1))
                        End If
                        strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                        iPos = InStr(1, strRow, ",")
                        If iPos > 0 Then
                            sSupplier = Trim(Mid(strRow, 1, iPos - 1))
                        End If

                        sWorkGrp_ID = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                     
response.write " ----@@---- : " & sEmp_Code & "," & sCardNo & "," & sName &  "," & sGender & "," & sDept & "," & sDesign & "," & sGrade & "," & sSuper & "," & sDtJoin & "," & sNation & "," & sSupplier & "," & sWorkGrp_ID & "<br>"    
'response.end                        
                        'if a = 1 then '@@@@@@
                                     
                        Set rstTMEmply = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                        sSQL = "select * from TMEMPLY where EMP_CODE ='" & sEmp_Code & "'" 
                        rstTMEmply.Open sSQL, conn, 3, 3
                        if rstTMEmply.eof then  
                            sSQL = "insert into TMEMPLY (EMP_CODE,CARDNO,NAME,GEN,DEPT_ID,DESIGN_ID,"
                            sSQL = sSQL & "GRADE_ID,SUP_CODE,DT_JOIN,NATION,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
                            sSQL = sSQL & "values ("
                            sSQL = sSQL & "'" & pRTIN(sEmp_Code) & "',"
                            sSQL = sSQL & "'" & pRTIN(sCardNo) & "',"
                            sSQL = sSQL & "'" & pRTIN(sName) & "',"
                            sSQL = sSQL & "'" & pRTIN(sGender) & "',"
                            sSQL = sSQL & "'" & pRTIN(sDept) & "',"
                            sSQL = sSQL & "'" & pRTIN(sDesign) & "',"
                            sSQL = sSQL & "'" & pRTIN(sGrade) & "',"
                            sSQL = sSQL & "'" & pRTIN(sSuper) & "',"
                            sSQL = sSQL & "'" & fDate2(CDate(sDtJoin)) & "',"
                            sSQL = sSQL & "'" & pRTIN(sNation) & "',"

                            sSQL1 = "select PART,HOL_ID from TMWORKGRP where WORKGRP_ID ='" & pRTIN(sWorkGrp_ID) & "'"
                            Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet") 
                            rstTMWorkGrp.Open sSQL1, conn, 3, 3
                            If Not rstTMWorkGrp.EOF Then
                                sHol_ID = rstTMWorkGrp("HOL_ID")
                                sPart = rstTMWorkGrp("PART")
                            else
                                response.write "No such work group"
                                response.end
                            End If
                            pCloseTables(rstTMWorkGrp)
                        
                            sSQL2 = "select * from TMWORKGRP where EMP_CODE ='" & pRTIN(sEmp_Code) & "'"
                            Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet") 
                            rstTMWorkGrp.Open sSQL2, conn, 3, 3
                            If rstTMWorkGrp.BOF Then
                                sSQL3 = "insert into TMWORKGRP (WORKGRP_ID,PART,EMP_CODE,HOL_ID,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
                                sSQL3 = sSQL3 & "values ("
                                sSQL3 = sSQL3 & "'" & pRTIN(sWorkGrp_ID) & "',"
                                sSQL3 = sSQL3 & "'" & pRTIN(sPart) & "',"
                                sSQL3 = sSQL3 & "'" & pRTIN(sEmp_Code) & "',"
                                sSQL3 = sSQL3 & "'" & pRTIN(sHol_ID) & "',"
                                sSQL3 = sSQL3 & "'SERVER',"
                                sSQL3 = sSQL3 & "'" & fDateTime() & "',"
                                sSQL3 = sSQL3 & "'SERVER',"
                                sSQL3 = sSQL3 & "'" & fDateTime() & "'"
                                sSQL3 = sSQL3 & ") "
                                conn.execute sSQL3
                            
                            response.write " @@@@@@@========== Insert Into WorkGroup " & sSQL3 & "<br>"
                            End If
                            
                            sSQL = sSQL & "'SERVER',"
                            sSQL = sSQL & "'" & fDateTime() & "',"
                            sSQL = sSQL & "'SERVER',"
                            sSQL = sSQL & "'" & fDateTime() & "'"
                            sSQL = sSQL & ") "
                            
                            conn.execute sSQL
                            
                            response.write " ***********========== Insert Into TMEMPLY " & sSQL & "<br>"
                            sSQL = "select COUPON from cspath"
                            Set rstCSCoupon = server.CreateObject("ADODB.RecordSet") 
                            rstCSCoupon.Open sSQL, conn, 3, 3
                            If Not rstCSCoupon.EOF Then
                                dCoupon = rstCSCoupon("COUPON")
                            End If
                            pCloseTables(rstCSCoupon)
                      
                            sSQL = "insert into CSEMPLY(EMP_CODE, NAME, COUPON, STATUS, CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
                            sSQL = sSQL & "values ("
                            sSQL = sSQL & "'" & pRTIN(sEmp_Code) & "',"
                            sSQL = sSQL & "'" & pRTIN(sName) & "',"
                            sSQL = sSQL & "'" & pFormatDec(dCoupon,2) & "',"
                            sSQL = sSQL & "'Y',"
                            sSQL = sSQL & "'SERVER',"
                            sSQL = sSQL & "'" & fDateTime() & "',"
                            sSQL = sSQL & "'SERVER',"
                            sSQL = sSQL & "'" & fDateTime() & "'"
                            sSQL = sSQL & ") "
                            conn.execute sSQL
                            response.write " %%%%%%%%========== Insert Into CSEmply " & sSQL & "<br>"
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
