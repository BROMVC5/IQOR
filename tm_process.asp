<%
    Server.ScriptTimeout = 10000000

    if session("USERNAME") =  "" then
       sUserName = "SERVER"
    else
       sUserName = session("USERNAME")
    end if 

	'=== Function that get the file and insert into TMCLK1
	Function fInsertTMCLK1(sFile, sCode)

        set fso = fs.OpenTextFile(Server.MapPath(".") & "\database\attendanceData\" & sFile, 1, true)  '==== Read the file
        if not fso.AtEndOfStream then
            Do while not fso.AtEndOfStream 
                                                        
                strRow = fso.ReadLine
                sDate = Mid(Trim(strRow), 1, 10)

                if strRow <> "" and isDate(sDate) then

                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sDate = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        iColonPos = InStr(1,strRow, ":")
                        if iColonPos > 0 then
                            iHour = Mid(strRow, 1, iColonPos -1)
                                
                            iMin = Mid(strRow, iColonPos + 1, 2)
                        end if
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                    iPos = InStr(1, strRow, ",")
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
            
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sValid = Trim(Mid(strRow, 1, 5))
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
            
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                         sEmp_Code  = Trim(Mid(strRow, 1, iPos - 1))
                    End If
                        
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    iPos = InStr(1, strRow, ",")
                        
                    If iPos > 0 Then
                        sName = Trim(Mid(strRow, 1, iPos - 1))
                    End If                               
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))

                    iPos = InStr(1, strRow, ",")
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                        
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sInOut = Trim(Mid(strRow, 1, iPos - 1))
                        sInOut = Trim(Mid(sInOut,6))
                    End If
					
                    if sCode <> "" then
                        if sCode = sEmp_Code then
                            Set rstTMEmply = server.CreateObject("ADODB.RecordSet")  
					        sSQL = "select * from TMEMPLY where EMP_CODE ='" &  sEmp_Code  & "'" 
					        rstTMEmply.Open sSQL, conn, 3, 3
					        if not rstTMEmply.eof then '=== Got such employee

                               Set rstTMClk1 = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                                sSQL = "select * from TMCLK1 where CODE ='" &  sEmp_Code  & "'" 
                                sSQL = sSQL & " and DT_WORK = '" & fdate2(sDate) & "'"
                                sSQL = sSQL & " and HOUR = '" & iHour & "'"
                                sSQL = sSQL & " and MIN = '" & iMin & "'" 
                                rstTMClk1.Open sSQL, conn, 3, 3
                                if rstTMClk1.eof then '=== To avoid duplicates
                                    sSQL = "insert into TMCLK1 (DT_WORK,HOUR,MIN,CODE,NAME,IN_OUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                            sSQL = sSQL & "values ("
		                            sSQL = sSQL & "'" & fdate2(sDate) & "',"		
		                            sSQL = sSQL & "'" & iHour & "',"
		                            sSQL = sSQL & "'" & iMin & "',"
		                            sSQL = sSQL & "'" &  sEmp_Code  & "',"
	                                sSQL = sSQL & "'" & pRTIN(sName) & "',"
                                    sSQL = sSQL & "'" & sInOut & "',"
                                    sSQL = sSQL & "'" & sUserName & "'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                    sSQL = sSQL & "'" & sUserName & "'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                            sSQL = sSQL & ") "
                                    conn.execute sSQL
                                end if
                                pCloseTables(rstTMClk1)
					
					        else '=== No such employee
					
						        sLog = " Employee Code: " &  sEmp_Code  & " does not exist in TMS. Date Work: " & sDate & " ,  Time : " & iHour & ":" & iMin & " " & sInOut  & " is not inserted! "
						        sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
						        sSQL = sSQL & "values ("
						        sSQL = sSQL & "'Insert into TMCLK1',"
						        sSQL = sSQL & "'Error',"
						        sSQL = sSQL & "'" & sLog & "',"
						        sSQL = sSQL & "'" & sUserName & "'," 
						        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
						        sSQL = sSQL & ") "
						        conn.execute sSQL
					
                            end if '=== End if sValid = "Valid"
					        pCloseTables(rstTMEmply)

                        end if
                    else
					    Set rstTMEmply = server.CreateObject("ADODB.RecordSet")  
					    sSQL = "select * from TMEMPLY where EMP_CODE ='" &  sEmp_Code  & "'" 
					    rstTMEmply.Open sSQL, conn, 3, 3
					    if not rstTMEmply.eof then '=== Got such employee

                           Set rstTMClk1 = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                            sSQL = "select * from TMCLK1 where CODE ='" &  sEmp_Code  & "'" 
                            sSQL = sSQL & " and DT_WORK = '" & fdate2(sDate) & "'"
                            sSQL = sSQL & " and HOUR = '" & iHour & "'"
                            sSQL = sSQL & " and MIN = '" & iMin & "'" 
                            rstTMClk1.Open sSQL, conn, 3, 3
                            if rstTMClk1.eof then '=== To avoid duplicates
                                sSQL = "insert into TMCLK1 (DT_WORK,HOUR,MIN,CODE,NAME,IN_OUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                        sSQL = sSQL & "values ("
		                        sSQL = sSQL & "'" & fdate2(sDate) & "',"		
		                        sSQL = sSQL & "'" & iHour & "',"
		                        sSQL = sSQL & "'" & iMin & "',"
		                        sSQL = sSQL & "'" &  sEmp_Code  & "',"
	                            sSQL = sSQL & "'" & pRTIN(sName) & "',"
                                sSQL = sSQL & "'" & sInOut & "',"
                                sSQL = sSQL & "'" & sUserName & "'," 
                                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                sSQL = sSQL & "'" & sUserName & "'," 
                                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                        sSQL = sSQL & ") "
                                conn.execute sSQL
                            end if
                            pCloseTables(rstTMClk1)
					
					    else '=== No such employee
					
						    sLog = " Employee Code: " &  sEmp_Code  & " does not exist in TMS. Date Work: " & sDate & " ,  Time : " & iHour & ":" & iMin & " " & sInOut  & " is not inserted! "
						    sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
						    sSQL = sSQL & "values ("
						    sSQL = sSQL & "'Insert into TMCLK1',"
						    sSQL = sSQL & "'Error',"
						    sSQL = sSQL & "'" & sLog & "',"
						    sSQL = sSQL & "'" & sUserName & "'," 
						    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
						    sSQL = sSQL & ") "
						    conn.execute sSQL
					
                        end if '=== End if sValid = "Valid"
					    pCloseTables(rstTMEmply)
                    end if
                end if '==== End if strRow and isDate(sDate)
            Loop
        end if '=== End if not fso.AtEndOfStream
        pCloseTables(fso)
        
        '===== After inserting into TMCLK1 MOVE the Attenance Data to LOG
        sFileFrom = Server.MapPath(".") & "\database\attendanceData\" & sFile

        sFileTo = Server.MapPath(".") & "\DATABASE\ATTENDANCEDATA\LOG\"
        
        set fsm=Server.CreateObject("Scripting.FileSystemObject")
        fsm.CopyFile sFileFrom , sFileTo
        fsm.DeleteFile(sFileFrom)
        set fsm=nothing

    End Function

    Function fSQLInsert(sEmp_Code, dtTheDate, sSHF_CODE, sALLCODE, sSTIME,sETIME, sTime)
   
        sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,ALLCODE,OSTIME,OETIME,STIME,ETIME,OTIN,TIN,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		sSQL = sSQL & "values ("
        sSQL = sSQL & "'" & sEmp_Code  & "',"		
		sSQL = sSQL & "'" & fdate2(dtTheDate) & "',"		
        sSQL = sSQL & "'" & sSHF_CODE & "',"
        sSQL = sSQL & "'" & sSHF_CODE & "',"
        sSQL = sSQL & "'" & sALLCODE & "',"
        sSQL = sSQL & "'" & sSTIME & "',"
        sSQL = sSQL & "'" & sETIME & "',"
        sSQL = sSQL & "'" & sSTIME & "',"
        sSQL = sSQL & "'" & sETIME & "',"
        sSQL = sSQL & "'" & sTime & "'," 
        sSQL = sSQL & "'" & sTime & "'," 
        sSQL = sSQL & "'" & sUserName & "'," 
        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"        
        sSQL = sSQL & "'" & sUserName & "'," 
        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		sSQL = sSQL & ") "
        conn.execute sSQL
    end Function

    Function fSQLInsertOut(sEmp_Code, dtTheDate, sSHF_CODE, sALLCODE, sSTIME,sETIME, sTime)
   
        sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,ALLCODE,OSTIME,OETIME,STIME,ETIME,OTOUT,TOUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		sSQL = sSQL & "values ("
        sSQL = sSQL & "'" & sEmp_Code  & "',"		
		sSQL = sSQL & "'" & fdate2(dtTheDate) & "',"		
        sSQL = sSQL & "'" & sSHF_CODE & "',"
        sSQL = sSQL & "'" & sSHF_CODE & "',"
        sSQL = sSQL & "'" & sALLCODE & "',"
        sSQL = sSQL & "'" & sSTIME & "',"
        sSQL = sSQL & "'" & sETIME & "',"
        sSQL = sSQL & "'" & sSTIME & "',"
        sSQL = sSQL & "'" & sETIME & "',"
        sSQL = sSQL & "'" & sTime & "'," 
        sSQL = sSQL & "'" & sTime & "'," 
        sSQL = sSQL & "'" & sUserName & "'," 
        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"        
        sSQL = sSQL & "'" & sUserName & "'," 
        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		sSQL = sSQL & ") "
        conn.execute sSQL
    end Function

    Function fSQLUpdate(sTime, sEmp_Code, dtTheDate) '=== For TOUT only

        sSQL = "UPDATE TMCLK2 SET "             
        sSQL = sSQL & "OTOUT = '" & sTime & "',"
        sSQL = sSQL & "TOUT = '" & sTime & "',"
        sSQL = sSQL & " USER_ID ='" & sUserName & "'," 
        sSQL = sSQL & " DATETIME ='" & fdatetime2(Now()) & "'" 
        sSQL = sSQL & " WHERE EMP_CODE = '" &  sEmp_Code  & "'"
        sSQL = sSQL & " AND DT_WORK = '" & fdate2(dtTheDate) & "'" 
        conn.execute sSQL

    end Function 
	
	Function fInsertTMCLK2(dt_Process,sCode)

        Set rstTMClk1 = server.CreateObject("ADODB.RecordSet")  '=== Call TMCLK1 again and insert into TMCLK2
        sSQL = "select * from TMCLK1 "
        sSQL = sSQL & " where DT_WORK = '" & fdate2(dt_Process) & "'"

        if sCode <> "" then
            sSQL = sSQL & " and CODE = '" & sCode & "'" 
        end if

        sSQL = sSQL & " order by DT_WORK, CODE, HOUR, MIN"

        rstTMClk1.Open sSQL, conn, 3, 3
        if not rstTMClk1.eof then   
       
            Do while not rstTMClk1.eof '==== Loop through TMCLK1 and start inserting into TMCLK2
                sEmp_Code = rstTMClk1("CODE")
                dt_Work = CDate(rstTMClk1("DT_WORK"))
                iHour = Cint(rstTMCLK1("HOUR"))
                iMin = Cint(rstTMCLK1("MIN"))
                sInOut = rstTMCLK1("IN_OUT")

                dt_PreviousDay = DateAdd("d",-1, dt_Work) '=== Del

                sTime = pAddZero(iHour) & ":" & pAddZero(iMin)
                
                '==== Loop to get the SHift schedule, if REST and OFF will loop backwards until get the STIME, ETIME
                dtLoop = dt_Work
                sSTIME = ""
                iBackHowManyDay = 0
                'response.write "<br>*Debug Before Emp_Code : " & sEmp_COde & " Date : " & dt_Work & " Time : " & sTime & " InOut : " & sInOut & " sSTIME: " & sSTIME &"<br>" 
                'Do While DateDiff("d", dtLoop, dt_Work) < 3
                Do While sSTIME = ""
                    sSQL = "select tmshiftot.SHF_CODE, tmshiftot.*, tmshfcode.* from TMSHIFTOT " 
                    sSQL = sSQL & " left join TMSHFCODE on tmshiftot.SHF_CODE = tmshfcode.SHF_CODE " 
                    sSQL = sSQL & " WHERE EMP_CODE = '" & sEmp_Code & "'"
                    sSQL = sSQL & " AND DT_SHIFT = '" & fdate2(dtLoop) & "'"
                    Set rstTMSHIFTOT = server.CreateObject("ADODB.RecordSet")  
                    'response.write " * Debug : " & sSQL & "<br>"
                    rstTMSHIFTOT.Open sSQL, conn, 3, 3
                    if not rstTMSHIFTOT.eof then
                        bGotShf = "Y"
                        if dtLoop = dt_Work then                             
                            sSHF_CODE = rstTMSHIFTOT("SHF_CODE") '=== Shift Code will remain
                        end if

                        if rstTMSHIFTOT("STIME") <> "" and rstTMSHIFTOT("ETIME") <> "" then
                            sSTIME = rstTMSHIFTOT("STIME")
                            sETIME = rstTMSHIFTOT("ETIME")  
                            iSTIME_H = Cint(Mid(rstTMSHIFTOT("STIME"),1,2))  '===Get the Shift Start time and convert to Integer
                            iETIME_H = Cint(Mid(rstTMSHIFTOT("ETIME"),1,2))  '===Get the Shift End time and convert to Integer
                            'response.write "*Debug got sSTIME back how many day : " & sSTIME & " , "  & iBackHowManyDay & "<br>"
                            'exit do
                            'response.write "Exit Do Shouldn't Show :" & sSTIME & "<br>"
                        end if
                    end if

                    iBackHowManyDay = iBackHowManyDay -1
                    
                    dtLoop = DateAdd("d",iBackHowManyDay, dt_Work) '=== Del
                Loop

                '===============================================================================================================
                'response.write "*Debug After Emp_Code : " & sEMp_COde & " Date : " & dt_Work & " Time : " & sTime & " InOut : " & sInOut & " sSHF_CODE : " & sSHF_CODE & " sSTIME : " & sSTIME &"<br>" 
                
                if bGotShf = "Y" then '==== Only Process those with shift schedule
                
                    sALLCODE = ""
                    '===AllCode, Check the employee Grade to see if Shift Allowance is yes
                    Set rstTMGRADE = server.CreateObject("ADODB.RecordSet")
                    sSQLTMGRADE = "select tmemply.GRADE_ID, tmGRADE.* from tmemply "
                    sSQLTMGRADE = sSQLTMGRADE & " left join tmgrade on TMEMPLY.GRADE_ID = TMGRADE.GRADE_ID " 
                    sSQLTMGRADE = sSQLTMGRADE & " where tmemply.EMP_CODE ='" &  sEmp_Code  & "'" 
                    sSQLTMGRADE = sSQLTMGRADE & " and tmgrade.SHFALL ='Y'" 
                    rstTMGRADE.Open sSQLTMGRADE, conn, 3, 3
                    if not rstTMGRADE.eof then
                        '=== Check Allowance if exist, Allowance COde is similar to SHF_CODE
                        Set rstTMALLOW = server.CreateObject("ADODB.RecordSet")
                        sSQLTMALLOW = "SELECT * FROM  tmallow "
                        sSQLTMALLOW = sSQLTMALLOW & " where tmallow.ALLCODE ='" & sSHF_CODE & "'" 
                        rstTMALLOW.Open sSQLTMALLOW, conn, 3, 3
                        if not rstTMALLOW.eof then
                            sALLCODE = rstTMALLOW("ALLCODE")
                        end if
                    end if
                    '================================================================

                    if sInOut = "IN" then '=== TIN no matter what will need to insert first 

                        Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMCLK2 where EMP_CODE = '" & sEmp_Code & "'"
                        sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_Work) & "'"  
                        rstTMClk2.Open sSQL, conn, 3, 3 
                        if rstTMClk2.eof then '===I will only insert the 1st TIN, subsequent TIN will be ignored
                            Call fSQLInsert(sEmp_Code, dt_Work, sSHF_CODE, sALLCODE, sSTIME,sETIME,sTIME)
                        end if '==== <!-- end if rstTMClk2.eof-->

                    elseif sInOut = "OUT" then

                        if iSTIME_H > iETIME_H then   '=== START with Night Shift Start Time > Shift End Time, 19 > 7
                
                            iHalfOfShift_H = Cint(((iETIME_H +24)-iSTIME_H)/2)

                            '===== For 1900-0700 shift, TOUT is within 0100 <= sTime <= 1300
                            if (iETIME_H - iHalfOfShift_H <= iHour) and (iHour <= (iETIME_H + iHalfOfShift_H )) then
                                bIsTOUTWithinRange = "Y"
                            else 
                                bIsTOUTWithinRange = "N"
                            end if

                            if  bIsTOUTWithinRange = "Y" then

                                Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMCLK2 where EMP_CODE = '" &  sEmp_Code  & "'"
                                sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_PreviousDay) & "'" 
                                rstTMClk2.Open sSQL, conn, 3, 3
                                if rstTMClk2.eof then '=== Incomplete already, No TIN PreviousDay
                                    Call fSQLInsertOut(sEmp_Code, dt_PreviousDay, sSHF_CODE, sALLCODE,sSTIME,sETIME,sTime)
                                else
                                    Call fSQLUpdate(sTime, sEmp_Code, dt_PreviousDay)
                                end if

                            else '=== Out of scheduled Range
                        
                                Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMCLK2 where EMP_CODE = '" &  sEmp_Code  & "'"
                                sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_Work) & "'" 
                                rstTMClk2.Open sSQL, conn, 3, 3
                                if rstTMClk2.eof then '=== Incomplete already, No TIN
                                    Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMCLK2 where EMP_CODE = '" &  sEmp_Code  & "'"
                                    sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_PreviousDay) & "'" 
                                    rstTMClk2.Open sSQL, conn, 3, 3
                                    if rstTMClk2.eof then '=== Incomplete already, No TIN PreviousDay
                                        Call fSQLInsertOut(sEmp_Code, dt_PreviousDay, sSHF_CODE, sALLCODE,sSTIME,sETIME,sTime)
                                    else
                                        Call fSQLUpdate(sTime, sEmp_Code, dt_PreviousDay)
                                    end if
                                else 
                                    Call fSQLUpdate(sTime, sEmp_Code, dt_Work)
                                end if

                            end if
                        
                        else '=== Morning shift 0700-1900, 0800-1630 <!-- Else iETIME_H > iSTIME_H then !-->
                            
                            iHalfOfShift_H = Cint((iETIME_H-iSTIME_H)/2)

                            if iHour < 12 then
                                iHour = iHour +24
                            end if 

                            '===== For 0700-1900 shift, TOUT is within 1300 <= sTime <= 0100
                            '===== For 0800-1630 shift, TOUT is within 0800 <= sTime <= 0000
                            if (iETIME_H - iHalfOfShift_H <= iHour) and (iHour <= (iETIME_H + iHalfOfShift_H )) then
                                bIsTOUTWithinRange = "Y"
                            else 
                                bIsTOUTWithinRange = "N"
                            end if
                            
                            if bIsTOUTWithinRange = "Y" then

                                Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMCLK2 where EMP_CODE = '" &  sEmp_Code  & "'"
                                sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_Work) & "'" 
                                rstTMClk2.Open sSQL, conn, 3, 3
                                if rstTMClk2.eof then '=== Incomplete already, No TIN
                                    Call fSQLInsertOut(sEmp_Code, dt_Work, sSHF_CODE, sALLCODE,sSTIME,sETIME,sTime)
                                else
                                    Call fSQLUpdate(sTime, sEmp_Code, dt_Work)
                                end if

                            else '=== Out of Shift Schedule Range
                                
                                Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMCLK2 where EMP_CODE = '" &  sEmp_Code  & "'"
                                sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_Work) & "'" 
                                rstTMClk2.Open sSQL, conn, 3, 3
                                if rstTMClk2.eof then '=== Incomplete already, No TIN
                                    '=== Check if insert previous day, Abnormal or Incomplete
                                    Set rstTMCLK2Prev = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMCLK2 where EMP_CODE = '" &  sEmp_Code  & "'"
                                    sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_PreviousDay) & "'"
                                    rstTMCLK2Prev.Open sSQL, conn, 3, 3
                                    if not rstTMCLK2Prev.eof then  '=== Previous Got TIN, Irregular!
                                        Call fSQLUpdate(sTime, sEmp_Code, dt_PreviousDay)
                                        'response.write " 2Up PreviousDay : " & sSQL & "<br>"
                                    else '=== No record or TOUT is not empty
                                        Call fSQLInsertOut(sEmp_Code, dt_Work, sSHF_CODE, sALLCODE,sSTIME,sETIME,sTime)
                                        'response.write " 4Insert PreviousDay : " & sSQL & "<br>"
                                    end if
                                else 
                                    
                                    if bIsTOUTWithinRange = "Y" then
                                        Call fSQLUpdate(sTime, sEmp_Code, dt_Work)
                                    else
                                        Call fSQLUpdate(sTime, sEmp_Code, dt_PreviousDay)
                                    end if
                                end if

                            end if
                 
                        end if '=== <!-- end if iSTIME_H > iETIME_H then !-->
       
                    end if '=== <!-- end if sInOut = "IN" then /  elseif sInOut = "OUT" then !-->

                end if ' === <!-- end if if bGotShf = "Y" then !-->

                rstTMClk1.movenext
            Loop

        end if '===  if not TMClk1.eof
    
	End Function

	Function fProcAbOT(dtProcess, sEmpCode, sAutoManReprocess)

        '==== From Program setup =====
        Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMPATH" 
        rstTMPATH.Open sSQL, conn, 3, 3
        if not rstTMPATH.eof then
            iLateGR = Cint((mid(rstTMPATH("LATEGR"),1,2))*60) + Cint((mid(rstTMPATH("LATEGR"),4,2)))
            iEarlyGR = Cint((mid(rstTMPATH("EARLYGR"),1,2))*60) + Cint((mid(rstTMPATH("EARLYGR"),4,2)))
            iMinOT = Cint((mid(rstTMPATH("MINOT"),1,2))*60) + Cint((mid(rstTMPATH("MINOT"),4,2)))
            sHalfDayGr = rstTMPATH("HALFDAYGR")
        end if
        pCloseTables(rstTMPATH)

        '======= Check for abnormal, OT, Total and TotalOT, One day before because Night shit just inserted==================
        Set rstTMClk2 = server.CreateObject("ADODB.RecordSet") 
        sSQL = "select * from TMCLK2 " 
        sSQL = sSQL & " where DT_WORK = '" & fdate2(dtProcess) & "'" 

        if sAutoManReprocess = "Y" then
            '=== During Auto Process, Manual Process, only Reprocess ALL, process only the people that has not been approve at any level
            sSQL = sSQL & " and isnull(1DTAPV) and isnull(1OTDTAPV) " 
        else
            '=== After Abnormal approval, recalculate the Total, TotalOTs... 
            '=== Will ignore any approvals.
        end if 
    
        if sEmpCode <> "" then
            sSQL = sSQL & " and EMP_CODE = '" & sEmpCode & "'" 
        end if

        sSQL = sSQL & " order by EMP_CODE, DT_WORK"
        rstTMClk2.Open sSQL, conn, 3, 3
        if not rstTMClk2.eof then
         
            Do while not rstTMClk2.eof
                sHoliday = ""
                sOffRest = ""
                iTotal = ""
                iTotalOT = ""
                sLate = ""
                sOT = ""
                sEarly = ""
                sIncom = ""
                sIrreg = ""
                sHalfDay = ""
            
                sSTIME = rstTMClk2("STIME")  '==== This is inserted earlier and follow earlier shift if it is OFF or REST day
                sETIME = rstTMClk2("ETIME")
                   
                sTIN = rstTMClk2("TIN")
                sTOUT = rstTMClk2("TOUT")
                    
                Set rstHOL_ID = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select HOL_ID from TMWORKGRP where EMP_CODE = '" & rstTMClk2("EMP_CODE") & "'"
                rstHOL_ID.Open sSQL, conn, 3, 3
                if not rstHOL_ID.eof then
                    Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMHOL1 where HOL_ID = '" & rstHOL_ID("HOL_ID") & "'"
                    sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMClk2("DT_WORK")) & "'" 
                    rstDT_HOL.Open sSQL, conn, 3, 3
                    if not rstDT_HOL.eof then '==== Check if that day is a Holiday, if yes, OT
                        sHoliday = "Y"
                    else '=== if not a holiday
                        '=== but Rest or OFF day
                        if rstTMClk2("SHF_CODE") = "REST" or rstTMCLK2("SHF_CODE") ="OFF" then 
                            sOffRest = "Y"
                        end if
                    end if
                end if
                pCloseTables(rstHOL_ID)

                'response.write "<br>" & rstTMClk2("EMP_CODE") & " , " & rstTMClk2("SHF_CODE") & " , " &  sOffRest & "<br>"

                Set rstGRADE_ID = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select tmemply.GRADE_ID, tmgrade.OT from TMEMPLY "
                sSQL = sSQL & " left join TMGRADE"
                sSQL = sSQL & " on tmemply.GRADE_ID = tmgrade.GRADE_ID"
                sSQL = sSQL & " where EMP_CODE = '" & rstTMClk2("EMP_CODE") & "'"
                rstGRADE_ID.Open sSQL, conn, 3, 3
                if not rstGRADE_ID.eof then
                    sGrade_ID = rstGRADE_ID("GRADE_ID")    
                    sProcessOT = rstGRADE_ID("OT")
                end if
                pCloseTables(rstGRADE_ID)

                if sSTIME <> "" then 
                    iSTIME_H = Cint(Mid(sSTIME,1,2))
                    iSTimeMins = Cint(TimeToMin(sSTime))
                end if

                if sETIME <> "" then
                    iETIME_H = Cint(Mid(sETIME,1,2))
                    iETimeMins = Cint(TimeToMin(sETime))
                end if 
            
                '===== Check if incomplete 
                if sTIN <> "" then
                    sTIN_H = Cint(Mid(sTIN,1,2))  
                    iTINMins = Cint(TimeToMin(sTIN))
                else
                    iTINMins = 0
                    sIncom = "Y"
                end if 

                if sTOUT <> "" then
                    sTOUT_H = Cint(Mid(sTOUT,1,2))
                    iTOUTMins = Cint(TimeToMin(sTOUT))
                else
                    iTOUTMins = 0
                    sIncom = "Y"
                end if

                if sIncom <> "Y" then '=== If Incomplete no need to process
      
                '======================= Calculate OT and Early dismiss =================================
                    if iSTIME_H > iETIME_H then ' === this is 1900 to 0700 Shift

                        '===== Check if it is Holiday or OffRest Code
                        if sHoliday = "Y" or sOffRest = "Y" then
                            if sTIN_H > 12 and sTOUT_H <= 12 then
                                iTOUTMins = iTOUTMins + 1440
                            end if
        
                            iTotal = iTOUTMins - iTINMins
                            if sProcessOT = "Y" then '=== This has to do with Grade
                                sOT = "Y"
                                iTotalOT = iTotal  '==== Holiday work is all OT
                            else 
                                sOT = "N"
                                iTotalOT = 0
                            end if
                        end if
                            
                        '==== For Night Shift calculation tweak
                        iETimeMins = iETimeMins + 1440
                        iHalfOfShift_H = Cint(((iETIME_H +24)-iSTIME_H)/2)
                        iHalfOfShiftMins = Cint((iETimeMins - iSTimeMins)/2)
                                
                        if sTIN_H < 12 and sTOUT_H < 12 then '=== 2nd Half Day For punch in at 00:00 onwards till 11:59 and out is also 00:00 till 11:59
                            sTIN_H = sTIN_H + 24
                            iTINMins = iTINMins + 1440
                        end if
                            
                        if sTOUT_H <= 16 then '=== Punch out from 00:00am till 16:59pm, ADD 24Hours for calculation
                            iTOUTMins = iTOUTMins + 1440
                        End if

                        if (sTIN_H <= (iSTIME_H + iHalfOfShift_H ) and sTIN_H >= (iSTIME_H - iHalfOfShift_H )) or sHoliday = "Y" or sOffRest = "Y" then
                            sIrreg = ""
                        else
                            sIrreg = "Y"
                        end if
       
                        'response.write rstTMClk2("EMP_CODE") & " : sTIN : " & sTIN & " , sTOUT : " & sTOUT & " , IRREG :  " & sIrreg & "  <BR>"

                        if sIrreg <> "Y" and sHoliday <> "Y" and sOffRest <> "Y"  then '== Only with OTShf allowance and not Holiday or OffRest 
                            '=== Early In
                            if iTINMins < iSTimeMins then
                                                
                                '====Early In More then MinOT
                                if (iSTimeMins-iTINMins) >= Cint(iMinOT) then
                                                    
                                    '=== Late Out or Normal
                                    if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(iMinOT)) then 
                                        'response.write "EarlyInOT and LateOutOT"
                                        
                                        iTotal = iTOUTMins - iTINMins
                                        
                                        if sProcessOT = "Y" then '=== This has to do with Grade
                                            sOT = "Y"
                                        
                                            iOTIn = iSTimeMins-iTINMins
                                            iOTOut = iTOUTMins - iETimeMins
                                        
                                            iTotalOT = iOTIn + iOTOut
                                        end if
                                    else
                                        ' response.write "EarlyInOT and NormalOut"
                                        iTotal = iTOUTMins - iTINMins
                                        
                                        if sProcessOT = "Y" then '=== This has to do with Grade
                                            sOT = "Y"
                                            iOTIn = iSTimeMins - iTinMins

                                            iTotalOT = iOTIn
                                        end if
                                    end if
                                else '=== Not more than MinOT In
                                    '=== Late Out or Normal
                                    if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(iMinOT)) then 
                                        'response.write "Not more than minOT and LateOutOT"
                                        iTotal = iTOUTMins - iTINMins

                                        if sProcessOT = "Y" then '=== This has to do with Grade
                                            sOT = "Y"
                                            iOTOut = iTOUTMins - iETimeMins
      
                                            iTotalOT = iOTOut
                                        end if
                                    else

                                        'response.write "Not more than minOT and NormalOut"
                                        sOT="N"
                                                
                                        iTotal = iTOUTMins - iTINMins
                                        
                                        iTotalOT = 0
                                    end if
                                end if
                            else '=== Punch in after STIME
                                if (iTINMins - iSTimeMins) > Cint(iLateGR) then
                                    'response.write "late"
                                    sLate = "Y"
                                end if
                                '==== Late out or Normal
                                    if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(iMinOT)) then 
                                        'response.write " Normal IN and LateOutOT "
                                        iTotal = iTOUTMins - iTINMins
                                        
                                        if sProcessOT = "Y" then '=== This has to do with Grade
                                            sOT = "Y"
                                            iOTOut = iTOUTMins - iETimeMins
                                        
                                            iTotalOT = iOTOut
                                        end if
                                    else
                                        'response.write " Normal IN and Normal Out"                          
                                        sOT="N"
                                        iTotal = iTOUTMins - iTINMins
                                        iTotalOT = 0
                                    end if
                            end if '=== iTINMins < iSTimeMins then

                            if iTOUTMins < iETimeMins Then
                                if (iETimeMins - iTOUTMins) > Cint(iEarlyGR) then
                                    sEarly = "Y"
                                end if
                            end if
                                
                            '==== For Half Day 
                            if iTotal <> "" then
                                if iTotal <= (iHalfOfShiftMins + Cint(TimeToMin(sHalfDayGr)))  then
                                    sHalfDay = "Y"
                                end if 
                            end if
                                                       
                        end if '=== sIrreg <> "Y" and sOT = "Y" then 
                    
                    '==============================================================================================================
                    elseif iSTIME_H < iETIME_H then '==== for Morning 0700-1900 Shift or 0800-1630

                        if sHoliday = "Y" or sOffRest = "Y" then          
                            if iTOUTMins < iTINMins then        
                                iTOUTMins = iTOUTMins + 1440  '=== This is when his previous week is normal shift, but weekend is overnight shift. Need to take care of the tOUT
                                iETimeMins = iETimeMins + 1440
                            end if
                            
                            iTotal = iTOUTMins - iTINMins

                            if sProcessOT = "Y" then '=== This has to do with Grade
                                sOT = "Y"
                                iTotalOT = iTotal  '==== Holiday work is all OT
                            else 
                                sOT = "N"
                                iTotalOT = 0
                            end if
                        end if
           
                        '==== Half shift duration in hours, so 0700-1900 is 6 hours, 0800-1630 is 4 hours 15 mins
                        iHalfOfShift_H = Cint((iETIME_H-iSTIME_H)/2)
                        iHalfOfShiftMins = Cint((iETimeMins - iSTimeMins)/2)
                        
                        '==== Full shift duration in hours, so 0700-1900 is 12 hours, 0800-1630 is 8 hours 30 mins
                        iFullShift_H = Cint(iETIME_H-iSTIME_H)

                        '=== Check TIN first if it is irregular             
                        '===== For 0700-1900 shift, TIN is within 0100 till 1300. TIN is within (Shift IN in hours +- half of shift in hours (6 hours) )
                        '===== For 0800-1630 shift, TIN is within 0400 till 1200. TIN is within (Shift IN in hours +- half of shift in hours (4 hours) )
                        if (sTIN_H <= (iSTIME_H + iHalfOfShift_H ) and sTIN_H >= (iSTIME_H - iHalfOfShift_H )) or sHoliday = "Y" or sOffRest = "Y"  then
                            '=== TIN OK now check for TOUT
                            '===== if TOUT is 0000-1159 then add 24 hours or 1440 mins 
                            if sTOUT_H < 12 then
                                sTOUT_H = sTOUT_H +24
                                iTOUTMins = iTOUTMins +1440
                            end if 
                        
                            '===== For 0700-1900 shift, TOUT is within 1300 till the next day 0700
                            '===== For 0800-1630 shift, TOUT is within 0800 till 0000
                            if (sTOUT_H <= (iETIME_H + iFullShift_H ) and sTOUT_H >= (iSTIME_H - iHalfOfShift_H )) or sHoliday = "Y" or sOffRest = "Y"  then
                                sIrreg = ""
                            else
                                sIrreg = "Y"
                            end if
                        else
                            sIrreg = "Y"
                        end if

                    if sIrreg <> "Y" and sHoliday <> "Y" and sOffRest <> "Y" then '== Only with OTShf allowance will calculate OT. 
                            '=== Early In
                            if iTINMins < iSTimeMins then
                                                
                                '====Early In More then MinOT
                                if (iSTimeMins-iTINMins) >= Cint(iMinOT) then
                                                    
                                    '=== Late Out or Normal
                                    if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(iMinOT)) then 
                                        ' response.write "EarlyInOT and LateOutOT"
                                        iTotal = iTOUTMins - iTINMins
                                                
                                        if sProcessOT = "Y" then '=== This has to do with Grade
                                            sOT = "Y"
                                            iOTIn = iSTimeMins-iTINMins
                                            iOTOut = iTOUTMins - iETimeMins
                                        
                                            iTotalOT = iOTIn + iOTOut
                                        end if
                                    else
                                        'response.write "EarlyInOT and NormalOut"
                                        iTotal = iTOUTMins - iTINMins
                                        
                                        if sProcessOT = "Y" then '=== This has to do with Grade
                                            sOT = "Y"
                                            iOTIn = iSTimeMins - iTinMins
                                        
                                            iTotalOT = iOTIn
                                        end if
                                    end if
                                else '=== Not more than MinOT In
                                    '=== Late Out or Normal
                                    if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(iMinOT)) then 
                                        'response.write "Not more than minOT and LateOutOT"
                                        iTotal = iTOUTMins - iTINMins
                                        
                                        if sProcessOT = "Y" then '=== This has to do with Grade
                                            sOT = "Y"
                                            iOTOut = iTOUTMins - iETimeMins
      
                                            iTotalOT = iOTOut                       
                                        end if
                                    else
                                       'response.write "Not more than minOT and NormalOut"
                                        iTotal = iTOUTMins - iTINMins

                                        sOT="N"
                                        iTotalOT = 0
                                    end if
                                end if
                            else '=== Punch in after STIME
                                if (iTINMins - iSTimeMins) > Cint(iLateGR)  then
                                    'response.write "late"
                                    sLate = "Y"
                                end if
                                '==== Late out or Normal
                                    if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(iMinOT)) then 
                                        'response.write " Normal IN and LateOutOT "
                                        iTotal = iTOUTMins - iTINMins
                                        if sProcessOT = "Y" then '=== This has to do with Grade
                                            sOT = "Y"
                                            iOTOut = iTOUTMins - iETimeMins
                                            
                                            iTotalOT = iOTOut
                                        end if
                                    else
                                        'response.write " Normal IN and Normal Out"                          
                                        sOT="N"
                                        iTotal = iTOUTMins - iTINMins
                                        iTotalOT = 0
                                    end if
                            end if '=== iTINMins < iSTimeMins then

                            if iTOUTMins < iETimeMins Then
                                if (iETimeMins - iTOUTMins) > Cint(iEarlyGR) then
                                    sEarly = "Y"
                                end if
                            end if
                                
                            if iTotal <> "" then
                                if iTotal <= (iHalfOfShiftMins + Cint(TimeToMin(sHalfDayGr)))  then
                                    sHalfDay = "Y"
                                end if 
                            end if  
        
                        end if '=== sIrreg <> "Y" and sOT = "Y" then 
                    
                    end if  '===if iSTIME_H > iETIME_H
        
                    sSQL = "UPDATE TMCLK2 SET "
                    sSQL = sSQL & " LATE = '" & sLate & "',"
                    sSQL = sSQL & " IRREG = '" & sIrreg & "',"
                        if sGrade_ID = "M4" then
                            if iTotalOT >= Cint(sMinM4OT) then
                                sSQL = sSQL & " OT = '" & sOT & "'," 
                                sSQL = sSQL & " TOTALOT = '" & MinToTime(iTotalOT) & "'," 
                            else
                                sSQL = sSQL & " OT = 'N',"
                                sSQL = sSQL & " TOTALOT = '00:00'," 
                            end if
                        else
                            sSQL = sSQL & " OT = '" & sOT & "'," 
                            sSQL = sSQL & " TOTALOT = '" & MinToTime(iTotalOT) & "'," 
                        end if 
                    sSQL = sSQL & " TOTAL = '" & MinToTime(iTotal) & "',"
                    sSQL = sSQL & " HALFDAY = '" & sHalfDay & "',"
                    sSQL = sSQL & " EARLY = '" & sEarly & "'"
                    sSQL = sSQL & " WHERE EMP_CODE = '" & rstTMClk2("EMP_CODE") & "'"
                    sSQL = sSQL & " AND DT_WORK = '" & fdate2(rstTMClk2("DT_WORK")) & "'"
                    'response.write " =====UPDATE " & sSQL &  "<br>"
					conn.execute sSQL
                end if '===if sIncom
            rstTMClk2.movenext
            loop
        end if '=== End if not rstTMClk2.eof
        
    '============================================================================================
    '======= END Check ==========================================================================
	End Function
	
    '===== Notify them after night shift has properly inserted, will read the records one day before
    Function fEmail(dtSentMail,sEmp_Code,sfromAuto)
    
        '==== This will be 9:00am everymorning, it will wait for 7am end shift.
        '==== Then it will have 9am process for previous day. 
        '==== And send out the emails

        '=============== Insert into TMOUTBOX ==============================================
        '===== Notify them after yesterday records has been process. 
        
        Set rstTMClk2 = server.CreateObject("ADODB.RecordSet") 
        sSQL = "select tmemply.EMP_CODE, tmemply.NAME, tmemply.SUP_CODE, tmclk2.dt_work, " 
        sSQL = sSQL & " tmclk2.shf_code, tmclk2.TIN, tmclk2.TOUT, tmclk2.IRREG, tmclk2.OT from TMEMPLY "
        sSQL = sSQL & " left join TMCLK2 on tmemply.EMP_CODE = tmclk2.EMP_CODE "
        sSQL = sSQL & " where ((TIN = '' or TOUT = '') or OT ='Y' or IRREG='Y' ) and SUP_CODE <> '' "
        sSQL = sSQL & " and isnull(1DTAPV) and isnull(1OTDTAPV) " '=== Filter out all those that has been approved
        sSQL = sSQL & " and DT_WORK = '" & fdate2(dtSentMail) & "'"
        sSQL = sSQL & " and AB_OT_COUNT <> 'Y' " 

        if sEmp_Code <> "" then
            sSQL = sSQL & " and tmemply.EMP_CODE = '" & sEmp_Code & "'" 
        end if

        sSQL = sSQL & " order by SUP_CODE, OT, DT_WORK"
        rstTMClk2.Open sSQL, conn, 3, 3
        if not rstTMClk2.eof then
        
            Do while not rstTMClk2.eof
                
                Set rstTMEmply = server.CreateObject("ADODB.RecordSet") 
                sSQL = "select EMAIL, NAME from TMEMPLY where EMP_CODE = '" & sPreSUP_CODE & "'" 
                rstTMEmply.Open sSQL, conn, 3, 3
                if not rstTMEmply.eof then
                    sSName = rstTMEmply("NAME")
                    sSEmail = rstTMEmply("EMAIL")
                end if

                '====== When coming out from the 2nd loop, insert into BROMAIL
                if Cint(iAbnormal) > 0  then
         
                    if Cint(iAbnormal) = 1 then
                        sSubject = "There is " & iAbnormal & " Abnormal Entry"
                        sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
                        sContent = sContent & "There is <a href=""http://10.122.16.69/iqor/login.asp"">" &iAbnormal & " Abnormal Entry.</a></html>"
                    else
                        sSubject = "There are " & iAbnormal & " Abnormal Entries"
                        sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
                        sContent = sContent & "There are <a href=""http://10.122.16.69/iqor/login.asp"">" &iAbnormal & " Abnormal Entries.</a></html>"
                    end if  
                        
                    sSQL = "insert into BROMAIL (SUP_CODE,RECEIVER,SUBJECT,CONTENT,TYPE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		            sSQL = sSQL & "values ("
                    sSQL = sSQL & "'" & sPreSup_Code & "',"		
		            sSQL = sSQL & "'" & sSEmail & "',"
                    sSQL = sSQL & "'" & sSubject & "',"
                    sSQL = sSQL & "'" & sContent & "',"
                    sSQL = sSQL & "'ABNORM',"
                    sSQL = sSQL & "'" & fdate2(dtSentMail) & "'," 
                    sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	                sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
                    conn.execute sSQL  
                    iAbnormal = 0 
                            
                end if

                if Cint(iOTCount) > 0  then
        
                    if Cint(iOTCount) = 1 then
                        sSubject = "There is " & iOTCount & " OT Entry"
                        sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
                        sContent = sContent & "There is <a href=""http://10.122.16.69/iqor/login.asp"">" & iOTCount  & " OT Entry.</a></html>"
                    else
                        sSubject = "There are " & iOTCount & " OT Entries"
                        sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
                        sContent = sContent & "There are <a href=""http://10.122.16.69/iqor/login.asp"">" & iOTCount  & " OT Entries.</a></html>"
                    end if
  
                    sSQL = "insert into BROMAIL (SUP_CODE,RECEIVER,SUBJECT,CONTENT,TYPE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		            sSQL = sSQL & "values ("
                    sSQL = sSQL & "'" & sPreSup_Code & "',"		
		            sSQL = sSQL & "'" & sSEmail & "',"
                    sSQL = sSQL & "'" & sSubject & "',"
                    sSQL = sSQL & "'" & sContent & "',"
                    sSQL = sSQL & "'OT',"
                    sSQL = sSQL & "'" & fdate2(dtSentMail) & "'," 
                    sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	                sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
                    conn.execute sSQL 
                    iOTCount = 0
           
                end if
        
                if sPreSup_Code <> rstTMClk2("SUP_CODE") then '==== When Previous Sup Code is different from new recordset SUP_CODE
                    
                    sPreSup_Code = rstTMClk2("SUP_CODE") '==== Retain the last recordset SUP_CODE as Previous Sup_Code

                    Set rstTMClk2_2 = server.CreateObject("ADODB.RecordSet") 
                    sSQL = "select  tmemply.EMP_CODE, tmemply.NAME, tmemply.SUP_CODE, tmclk2.dt_work, " 
                    sSQL = sSQL & " tmclk2.shf_code, tmclk2.TIN, tmclk2.TOUT, tmclk2.IRREG, tmclk2.OT from TMEMPLY "
                    sSQL = sSQL & "left join TMCLK2 on tmemply.EMP_CODE = tmclk2.EMP_CODE "
                    sSQL = sSQL & " where ((TIN = '' or TOUT = '') or OT ='Y' or IRREG='Y' ) and SUP_CODE ='" & sPreSup_Code & "' " '=== Loop just that preSUP_CODE
                    sSQL = sSQL & " and isnull(1DTAPV) and isnull(1OTDTAPV) " 
                    sSQL = sSQL & " and DT_WORK = '" & fdate2(dtSentMail) & "'"
                    sSQL = sSQL & " and AB_OT_COUNT <> 'Y' " 
                    sSQL = sSQL & " order by OT, DT_WORK"
                    rstTMClk2_2.Open sSQL, conn, 3, 3
                    if not rstTMClk2_2.eof then
                        Do while not rstTMClk2_2.eof
                        
                            sTIN = rstTMClk2_2("TIN")  
                            sTOUT = rstTMClk2_2("TOUT") 
                            sOT = rstTMClk2_2("OT")
                            sIRREG = rstTMClk2_2("IRREG")
        
                            if (sTIN = "" or sTOUT = "") or sIRREG = "Y" then
                                
                                iAbnormal = Cint(iAbnormal) + 1
                                
                                sSQL = "UPDATE TMCLK2 SET "
                                sSQL = sSQL & "AB_OT_COUNT = 'Y'"
                                sSQL = sSQL & " WHERE EMP_CODE = '" & rstTMClk2_2("EMP_CODE") & "'"
                                sSQL = sSQL & " AND DT_WORK = '" & fdate2(dtSentMail) & "'"
                                conn.execute sSQL
                            end if
          
                            if (sOT = "Y")  then
                                
                                iOTCount = Cint(iOTCount) + 1

                                sSQL = "UPDATE TMCLK2 SET "
                                sSQL = sSQL & " AB_OT_COUNT = 'Y'"
                                sSQL = sSQL & " WHERE EMP_CODE = '" & rstTMClk2_2("EMP_CODE") & "'"
                                sSQL = sSQL & " AND DT_WORK = '" & fdate2(dtSentMail) & "'"
                                conn.execute sSQL
                            end if
                            rstTMClk2_2.movenext
                        loop
                    end if '=== End if not rstTMClk2_2.eof 
        
                end if '====  End if sPreSup_Code <> rstTMClk2("SUP_CODE") 
     
                rstTMClk2.movenext
            loop
                
            '===== After coming out from the loop, we still have the las iOTCount and IAbnormal. Hence will insert the last record.
            Set rstTMEmply = server.CreateObject("ADODB.RecordSet") 
            sSQL = "select EMAIL, NAME from TMEMPLY where EMP_CODE = '" & sPreSUP_CODE & "'" 
            rstTMEmply.Open sSQL, conn, 3, 3
            if not rstTMEmply.eof then
                sSName = rstTMEmply("NAME")
                sSEmail = rstTMEmply("EMAIL")
            end if

            if Cint(iAbnormal) > 0  then
                 
                if Cint(iAbnormal) = 1 then
                    sSubject = "There is " & iAbnormal & " Abnormal Entry"
                    sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
                    sContent = sContent & "There is <a href=""http://10.122.16.69/iqor/login.asp"">" &iAbnormal & " Abnormal Entry.</a></html>"
                else
                    sSubject = "There are " & iAbnormal & " Abnormal Entries"
                    sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
                    sContent = sContent & "There are <a href=""http://10.122.16.69/iqor/login.asp"">" &iAbnormal & " Abnormal Entries.</a></html>"
                end if                     

                sSQL = "insert into BROMAIL (SUP_CODE,RECEIVER,SUBJECT,CONTENT,TYPE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		        sSQL = sSQL & "values ("
                sSQL = sSQL & "'" & sPreSup_Code & "',"		
		        sSQL = sSQL & "'" & sSEmail & "',"
                sSQL = sSQL & "'" & sSubject & "',"
                sSQL = sSQL & "'" & sContent & "',"
                sSQL = sSQL & "'ABNORM',"
                sSQL = sSQL & "'" & fdate2(dtSentMail) & "'," 
                sSQL = sSQL & "'" & sUserName & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	            sSQL = sSQL & "'" & sUserName & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		        sSQL = sSQL & ") "
                conn.execute sSQL  
                iAbnormal = 0 
                            
            end if

            if Cint(iOTCount) > 0  then
        
                if Cint(iOTCount) = 1 then
                    sSubject = "There is " & iOTCount & " OT Entry"
                    sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
                    sContent = sContent & "There is <a href=""http://10.122.16.69/iqor/login.asp"">" & iOTCount  & " OT Entry.</a></html>"
                else
                    sSubject = "There are " & iOTCount & " OT Entries"
                    sContent = "<html>COMPANY : IQOR GLOBAL SERVICES MALAYSIA SDN BHD <br>" 
                    sContent = sContent & "There are <a href=""http://10.122.16.69/iqor/login.asp"">" & iOTCount  & " OT Entries.</a></html>"
                end if
                
                sSQL = "insert into BROMAIL (SUP_CODE,RECEIVER,SUBJECT,CONTENT,TYPE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		        sSQL = sSQL & "values ("
                sSQL = sSQL & "'" & sPreSup_Code & "',"		
		        sSQL = sSQL & "'" & sSEmail & "',"
                sSQL = sSQL & "'" & sSubject & "',"
                sSQL = sSQL & "'" & sContent & "',"
                sSQL = sSQL & "'OT',"
                sSQL = sSQL & "'" & fdate2(dtSentMail) & "'," 
                sSQL = sSQL & "'" & sUserName & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
	            sSQL = sSQL & "'" & sUserName & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		        sSQL = sSQL & ") "
                conn.execute sSQL 
                iOTCount = 0
           
            end if
          
            '=============Insert into TMLOG =====================
        
            sChangesM = " Send mail completed on " & Now() & " for Abnormals and OTs "
            sChangesM = sChangesM & " for Records Date " & dtSentMail 
            sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
	        sSQL = sSQL & "values ("
            sSQL = sSQL & "'Send Mail Complete',"
            sSQL = sSQL & "'Success',"
            sSQL = sSQL & "'" & sChangesM & "',"
            sSQL = sSQL & "'" & sUserName & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	        sSQL = sSQL & ") "
            conn.execute sSQL
            
            if sFromAuto = "Y" then
                '====== Message to User=========
                response.write "Send out email to supervisor for Abnormals and OTs for Work Date : " & dtSentMail & "<br>"
            end if
        ELSE
            '=============Insert into TMLOG =====================
            sChangesM = " No Email sent on " & Now() & " for Abnormals and OTs "
            sChangesM = sChangesM & " for Records Date " & dtSentMail 
            sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
	        sSQL = sSQL & "values ("
            sSQL = sSQL & "'Send Mail Complete',"
            sSQL = sSQL & "'Success',"
            sSQL = sSQL & "'" & sChangesM & "',"
            sSQL = sSQL & "'" & sUserName & "'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	        sSQL = sSQL & ") "
            conn.execute sSQL
            
            if sFromAuto = "Y" then
                '====== Message No mail send =======
                response.write "No email send out to supervisor for Abnormals and OTs for Work Date : " & dtSentMail & "<br>"
            end if
        END IF '==== end if not rstTMClk2.eof
    
	End Function
	
	Function fAbsent(dtAbsent,sEmp_Code)	
		
        '==== AUTO PROCESS, MANUAL PROCESS Process one day before because night shift data finish inserted ======
        '==== REPROCESS will process on that date. 
        '==== Latest Leave Information need to be uploaded into TMEOFF and then only =============================
		'==== ONLY CHECK UNTIL THE DAY BEDORE, because of night shift

        set rstTMABSENT = server.createobject("adodb.recordset")
	    sSQL = "select tmemply.EMP_CODE as EMPCODE, tmemply.NAME, SUP_CODE, tmemply.GRADE_ID, tmemply.GENSHF, WORKGRP_ID, tmworkgrp.HOL_ID, "
        sSQL = sSQL & " tmshiftot.SHF_CODE as SHIFT_CODE, tmshiftot.DT_SHIFT, tmclk2.* from tmshiftot" 
        sSQL = sSQL & " left join tmemply on tmemply.EMP_CODE = tmshiftot.EMP_CODE "
        sSQL = sSQL & " left join tmworkgrp on tmworkgrp.EMP_CODE = tmshiftot.EMP_CODE  "
        sSQL = sSQL & " left join tmclk2 on tmclk2.EMP_CODE = tmshiftot.EMP_CODE and DT_WORK = DT_SHIFT"
        sSQL = sSQL & " where (DT_SHIFT = '" & fdate2(dtAbsent) & "') "
        sSQL = sSQL & " and ( isnull(DT_RESIGN) or DT_RESIGN ='" & fdate2(dtAbsent) & "')"
        sSQL = sSQL & " and ( tmshiftot.SHF_CODE <> 'OFF' and tmshiftot.SHF_CODE <> 'REST' ) " 
        sSQL = sSQL & " and GENSHF = 'Y' "
        
        if sEmp_Code <> "" then
            sSQL = sSQL & " and tmshiftOT.EMP_CODE = '" & sEmp_Code & "'" 
        end if

        sSQL = sSQL & " order by tmemply.EMP_CODE, DT_SHIFT desc"

    	rstTMABSENT.Open sSQL, conn, 3, 3
        if not rstTMABSENT.eof then

            Do while not rstTMABSENT.eof
                sHoliday = ""
                sDura = ""
    
                Set rstDT_HOL = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMHOL1 where HOL_ID = '" & rstTMABSENT("HOL_ID") & "'"
                sSQL = sSQL & " and DT_HOL = '" & fdate2(rstTMABSENT("DT_SHIFT")) & "'" 
                rstDT_HOL.Open sSQL, conn, 3, 3
                if not rstDT_HOL.eof then 
                    sHoliday = "Y"
                end if
       
                sSQL = "select * from TMEOFF where EMP_CODE = '" & rstTMABSENT("EMPCODE") & "'"
		        sSQL =  sSQL & " and '" & fdate2(rstTMABSENT("DT_SHIFT")) & "'"  
		        sSQL =  sSQL & " between DTFR and DTTO "  
		        set rstTMEOFF = server.CreateObject("ADODB.Recordset")
		        rstTMEOFF.open sSQL, conn, 3, 3
		        if not rstTMEOFF.eof then
                    sDura = rstTMEOFF("DURA")
                end if
      
                '=== No attendance and not a holiday and no leave applied, insert as Full Day
                if isnull(rstTMABSENT("DT_WORK")) and sHoliday <> "Y" and sDura = "" then
           
                    sSQL = "INSERT into TMABSENT (EMP_CODE,NAME,GRADE_ID,WORKGRP_ID,SHF_CODE,DT_ABSENT,"
                    sSQl = sSQL & " ATTENDANCE,TYPE,SUP_CODE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                    sSQL = sSQL & " values ("
                    sSQL = sSQL & "'" & rstTMABSENT("EMPCODE") & "',"
                    sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("GRADE_ID") & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("WORKGRP_ID") & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("SHIFT_CODE") & "',"
                    sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                    sSQL = sSQL & "'Absent',"
                    sSQL = sSQL & "'F'," '=== Full Day
                    sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                    sSQL = sSQL & "'" & fdate2(dtAbsent) & "',"
                    sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                    sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                    conn.execute sSQL
                
                '=== Got attendance record and not a holiday
                '=== No leave applied but ProcAbOT pick up his/her attendance record as half day.
                '=== So without half day leave insert as 0.5 day absent
                elseif not isnull(rstTMABSENT("DT_WORK")) and sHoliday <> "Y" and sDura= "" and rstTMABSENT("HALFDAY") = "Y" then
            
                    sSQL = "INSERT into TMABSENT (EMP_CODE,NAME,GRADE_ID,WORKGRP_ID,SHF_CODE,DT_ABSENT,"
                    sSQl = sSQL & " ATTENDANCE,TYPE,SUP_CODE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                    sSQL = sSQL & " values ("
                    sSQL = sSQL & "'" & rstTMABSENT("EMPCODE") & "',"
                    sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("GRADE_ID") & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("WORKGRP_ID") & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("SHIFT_CODE") & "',"
                    sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                    sSQL = sSQL & "'Absent',"
                    sSQL = sSQL & "'H',"
                    sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                    sSQL = sSQL & "'" & fdate2(dtAbsent) & "',"
                    sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                    sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                    conn.execute sSQL

                '=== No attendance and not a holiday but leave applied for half day
                elseif isnull(rstTMABSENT("DT_WORK")) and sHoliday <> "Y" and sDura = "0.5" then
            
                    sSQL = "INSERT into TMABSENT (EMP_CODE,NAME,GRADE_ID,WORKGRP_ID,SHF_CODE,DT_ABSENT,"
                    sSQl = sSQL & " ATTENDANCE,TYPE,SUP_CODE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                    sSQL = sSQL & " values ("
                    sSQL = sSQL & "'" & rstTMABSENT("EMPCODE") & "',"
                    sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("GRADE_ID") & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("WORKGRP_ID") & "',"
                    sSQL = sSQL & "'" & rstTMABSENT("SHIFT_CODE") & "',"
                    sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                    sSQL = sSQL & "'Absent',"
                    sSQL = sSQL & "'H',"
                    sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                    sSQL = sSQL & "'" & fdate2(dtAbsent) & "',"
                    sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                    sSQL = sSQL & "'" & sUserName & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                    conn.execute sSQL

                end if '=== end if isnull (rstTMABSENT("DT_WORK"))
        'response.write " Insert Absent: " & sSQL & "<br>"
                rstTMABSENT.movenext
            loop
        end if '=== end if sSQL
	End Function

    Function fAbsent3(dtDateFrom, dtDateTo, sEmp_Code, sCalTheWholePayPeriod)
'        response.write " * dtFr : " & dtDateFrom & "<br>"
 '       response.write " * dtTo : " & dtDateTo & "<br>"

        '===== From Program setup =====
        Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMPATH" 
        rstTMPATH.Open sSQL, conn, 3, 3
        if not rstTMPATH.eof then
            sPayFrom = rstTMPATH("PAYFROM") 
            sPayTo = rstTMPATH("PAYTO")
        end if
        pCloseTables(rstTMPATH)

        if Cint(day(dtDateFrom)) >= Cint(sPayFrom) then 
            dtAbsent3Fr = CDate(sPayFrom & "-" & Month(dtDateFrom) & "-" & Year(dtDateFrom))
        else
            dtAbsent3Fr = CDate(sPayFrom & "-" & GetLastMonth(Month(dtDateFrom), Year(dtDateFrom)) & "-" & GetLastMonthYear(Month(dtDateFrom), Year(dtDateFrom)))
        end if
  
        if sCalTheWholePayPeriod = "Y" then
            if Cint(day(dtDateTo)) > Cint(sPayTo) then 
                dtAbsent3To = CDate(sPayTo & "-" & GetNextMonth(Month(dtDateTo), Year(dtDateTo)) & "-" & GetNextMonthYear(Month(dtDateTo), Year(dtDateTo)))
            else
                dtAbsent3To = CDate(sPayTo & "-" & Month(dtDateTo) & "-" & Year(dtDateTo))
            end if
        else
            dtAbsent3To = dtDateTo
        end if

        do while datevalue(dtAbsent3Fr) < datevalue(dtAbsent3To)

            dtAbsent3To = CDate(sPayTo & "-" & GetNextMonth(Month(dtAbsent3Fr), Year(dtAbsent3Fr)) & "-" & GetNextMonthYear(Month(dtAbsent3Fr), Year(dtAbsent3Fr)))
            'response.write "* dtAbsent3Fr : " & dtAbsent3Fr & "<br>"
            'response.write "* dtAbsent3To : " & dtAbsent3To & "<br>"
            
            sSQL = " delete from TMABSENT3 where DTFR >= '" & fdate2(dtAbsent3Fr) & "' and DTTO <= '" & fdate2(dtAbsent3To) & "'"
    
            if sEmp_Code <> "" then '=== Individual Employee otherwise All
                sSQL = sSQL & " and EMP_CODE = '" & sEmp_Code & "'" 
            end if    
            conn.execute sSQL

            iAbsent = 0
            sSQL = " select tmshiftot.emp_code as EMPCODE,dt_shift, tmhol1.dt_hol, tmclk2.dt_work, tmabsent.dt_absent, "
            sSQL = sSQL & " tmshiftot.shf_code, tmworkgrp.hol_id, tmemply.NAME, tmemply.SUP_CODE, tmworkgrp.WORKGRP_ID "
            sSQL = sSQL & " from tmshiftot "
            sSQL = sSQL & " left join tmhol1 on dt_shift = dt_hol and tmshiftot.hol_id = tmhol1.hol_id "
            sSQL = sSQL & " left join tmclk2 on dt_shift = dt_work and tmshiftot.EMP_CODE = tmclk2.EMP_CODE"
            sSQL = sSQL & " left join tmabsent on dt_shift = dt_absent and tmshiftot.EMP_CODE = tmabsent.EMP_CODE "
            sSQL = sSQL & " left join tmemply on tmshiftot.EMP_CODE =tmemply.EMP_CODE "
            sSQL = sSQL & " left join tmworkgrp on tmshiftot.EMP_CODE = tmworkgrp.EMP_CODE "
            sSQL = sSQL & " where GENSHF = 'Y' "
            sSQL = sSQL & " and isnull(dt_hol) "
            sSQL = sSQL & " and ( tmshiftot.SHF_CODE <> 'OFF' and tmshiftot.SHF_CODE <> 'REST' ) "  
            sSQL = sSQL & " and DT_SHIFT between '" & fdate2(dtAbsent3Fr) & "' and '" & fdate2(dtAbsent3To) & "'" 
        
            if sEmp_Code <> "" then
                sSQL = sSQL & " and tmshiftot.EMP_CODE = '" & sEmp_Code & "'" 
            end if

            sSQL = sSQL & " order by tmemply.EMP_CODE, DT_SHIFT asc"
            set rstTMABSENT3 = server.CreateObject("ADODB.Recordset")
            rstTMABSENT3.open sSQL, conn, 3, 3
            if not rstTMABSENT3.eof then

                Do while not rstTMABSENT3.eof

                    if sEmpCodeLoop <> rstTMABSENT3("EMPCODE") then '=== Begin record compare with last record, if change set iAbsent back to zero
                        iAbsent = 0
                    end if

                    'response.write "<br>Debug: ********* " & sEmpCodeLoop & "<>"  & rstTMABSENT3("EMPCODE") & " ********* " & rstTMABSENT3("DT_SHIFT") & "=====iAbsent=== " & iAbsent & "<br>"        
                    
                    '===== Check if the Date is it an Absent date, if yes then increase the count by 1, else need to check
                    if not isNULL(rstTMABSENT3("DT_ABSENT")) then
                        '=== Check if that day got MC or not    
                        sSQL = "select * from TMEOFF where EMP_CODE = '" & rstTMABSENT3("EMPCODE") & "'"
		                sSQL =  sSQL & " and '" & fdate2(rstTMABSENT3("DT_SHIFT")) & "' between DTFR and DTTO "  
                        sSQL =  sSQL & " and  LTYPE = 'F' "
		                set rstTMEOFF = server.CreateObject("ADODB.Recordset")
		                rstTMEOFF.open sSQL, conn, 3, 3
                        if not rstTMEOFF.eof then
                            iAbsent = 0
                        else 
        
                            iAbsent = iAbsent + 1

                            'response.write  "=====iAbsent=== " & iAbsent & "<br>"

                            if iAbsent = 1 then '=== When the 1st Absent mark the dtFr date.
                                dtFr = rstTMABSENT3("DT_ABSENT")
                            end if 

                            if Cint(iAbsent) >= 3 then
       
                                dtTo = rstTMABSENT3("DT_ABSENT")

                                sSQL = "select * from TMABSENT3 where EMP_CODE = '" & rstTMABSENT3("EMPCODE") & "'"
                                sSQL = sSQL & " and DTFR = '" & fdate2(dtFr) & "'"
                                set rstTMAB3 = server.CreateObject("ADODB.Recordset")
		                        rstTMAB3.open sSQL, conn, 3, 3
                                if not rstTMAB3.eof then '=== Got same DT FR so only update the Duration or iAbsent
                                    sSQL = "UPDATE TMABSENT3 set " 
                                    sSQL = sSQL & "EMP_CODE = '" & sEmpCodeLoop & "',"
                                    sSQL = sSQL & "NAME = '" & pRTIN(rstTMABSENT3("NAME")) & "',"
                                    sSQL = sSQL & "WORKGRP_ID = '" & rstTMABSENT3("WORKGRP_ID") & "',"
                                    sSQL = sSQL & "SUP_CODE = '" & rstTMABSENT3("SUP_CODE") & "',"
                                    sSQL = sSQL & "DTTO = '" & fdate2(dtTo) & "',"
                                    sSQL = sSQL & "DURA = '" & iAbsent & "',"
                                    sSQL = sSQL & "USER_ID = '" & sUserName & "'," 
                                    sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "'"
                                    sSQL = sSQL & " where EMP_CODE ='" & sEmpCodeLoop & "'"
                                    sSQL = sSQL & " and DTFR = '" & fdate2(dtFr) & "'"
                                    'response.write "Debug Update : " & sSQL & "<br>"
                                    'conn.execute sSQL
        
                                else '=== No record of new
                                    sSQL = "INSERT into TMABSENT3 (EMP_CODE,NAME,WORKGRP_ID,SUP_CODE,DTFR,DTTO,DURA,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                                    sSQL = sSQL & " values ("
                                    sSQL = sSQL & "'" & sEmpCodeLoop & "',"
                                    sSQL = sSQL & "'" & pRTIN(rstTMABSENT3("NAME")) & "',"
                                    sSQL = sSQL & "'" & rstTMABSENT3("WORKGRP_ID") & "',"
                                    sSQL = sSQL & "'" & rstTMABSENT3("SUP_CODE") & "',"
                                    sSQL = sSQL & "'" & fdate2(dtFr) & "',"
                                    sSQL = sSQL & "'" & fdate2(dtTo) & "',"
                                    sSQL = sSQL & "'" & iAbsent & "',"
                                    sSQL = sSQL & "'" & sUserName & "'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                    sSQL = sSQL & "'" & sUserName & "'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                                    'response.write "Debug Insert : " & sSQL & "<br>"
                                    'conn.execute sSQL
                                end if
                            end if '=== if Cint(iAbsent) >= 3
                        end if '=== if not rstTMEOFF.eof then
                    else '=== Not Absent means working
                    
                        iAbsent = 0
                        
                    end if '=== if not rstTMABST.eof then
        
                    sEmpCodeLoop = rstTMABSENT3("EMPCODE") '==== Retain last record
                    
                    rstTMABSENT3.movenext
                loop 

            end if

            dtAbsent3Fr = DateAdd("m",1,datevalue(dtAbsent3Fr))
        loop 

    End Function


    %>
 
