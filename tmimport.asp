<!DOCTYPE html>
<html>
<head>
    <!--#include file="include/clsUpload.asp"-->
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>iQOR | Import and Process</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Bootstrap 3.3.6 CSS -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="dist/css/dataTables.bootstrap.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
        folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    <link href="plugins/Custom/css/component.css" rel="stylesheet" />
    <!--<style>
        .inputfile {
	                    width: 0.1px;
	                    height: 0.1px;
	                    opacity: 0;
	                    overflow: hidden;
	                    position: absolute;
	                    z-index: -1;
                    }
     </style>-->
    <style>
        .darkClass
        {
            background-color: white;
            filter:alpha(opacity=50); /* IE */
            opacity: 0.5; /* Safari, Opera */
            -moz-opacity:0.50; /* FireFox */
            z-index: 20;
            height: 100%;
            width: 100%;
            background-repeat:no-repeat;
            background-position:center;
            position:absolute;
            top: 0px;
            left: 0px;
        }

    </style>
    <style>
    #loader-wrapper {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1000;
    }
        #loader {
            display: block;
            position: relative;
            left: 50%;
            top: 50%;
            width: 150px;
            height: 150px;
            margin: -75px 0 0 -75px;
     border: 3px solid transparent;
        border-top-color: #3498db;
            z-index: 1500;
            border-radius: 50%;
  
            -webkit-animation: spin 2s linear infinite;
        animation: spin 2s linear infinite;
    
        }
        #loader:before {
        content: "";
        position: absolute;
        top: 5px;
        left: 5px;
        right: 5px;
        bottom: 5px;
        border: 3px solid transparent;
        border-top-color: #e74c3c;
        border-radius: 50%;
        -webkit-animation: spin 3s linear infinite;
        animation: spin 3s linear infinite;

    }
    #loader:after {
        content: "";
        position: absolute;
        top: 15px;
        left: 15px;
        right: 15px;
        bottom: 15px;
        border: 3px solid transparent;
        border-top-color: #f9c922;
         border-radius: 50%;
     
    -webkit-animation: spin 1.5s linear infinite;
    animation: spin 1.5s linear infinite;
    }

 
    /* include this only once */
    @-webkit-keyframes spin {
        0%   {
            -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(0deg);  /* IE 9 */
            transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
        }
        100% {
            -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(360deg);  /* IE 9 */
            transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
        }
    }
    @keyframes spin {
        0%   {
            -webkit-transform: rotate(0deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(0deg);  /* IE 9 */
            transform: rotate(0deg);  /* Firefox 16+, IE 10+, Opera */
        }
        100% {
            -webkit-transform: rotate(360deg);  /* Chrome, Opera 15+, Safari 3.1+ */
            -ms-transform: rotate(360deg);  /* IE 9 */
            transform: rotate(360deg);  /* Firefox 16+, IE 10+, Opera */
        }
    }
    </style>
    <script>
    
    function dimOn() {
        document.getElementById("darkLayer").style.display = "";
    }

    function turnoff(){
        document.getElementById("loader-wrapper").style.display = "none";
    }
    </script>

    <%
        Server.ScriptTimeout = 1000000

        '===== This is manual processing not auto processing. We will assume that data is uploaded manually
        '===== and processing date will be the same as the filename. dtProcess 
        
        '===== We insert dtProcess data into TMCLK2
        '===== Then we process dtProcess records and insert it into TMCKL2. 
        '===== For night shift workers that punch in on one day before dtProcess and punch out on dtProcess.
        
        '===== Their complete In and Out will be on one day before dtProcess
        '===== We then process abnormal, OT Total and Total OT on one day before dtProcess  
        '===== Then, we sent out email about abnormal and OTs on one day before dtProcess
        
        '===== ABSENT: We will process absent same date as the date of data file, dtProcess
        '===== ABSENT 3Days will be processed from 22 PayFrom Date (dtPayFrom) untill the day he press the processing button date (dtPayTo)


        '*******************This is processing IQOR DATA from TMCLK1 ********************************
        '************************************************************************************************
    
        if request("btnProcess") <> "" then

            dtProcess = request("dtpFrDate") '===Date of the file
            
            sEmp_Code = request("txtID")

            '==== From Program setup =====
            Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMPATH" 
            rstTMPATH.Open sSQL, conn, 3, 3
            if not rstTMPATH.eof then
                sLateGR = Cint((mid(rstTMPATH("LATEGR"),1,2))*60) + Cint((mid(rstTMPATH("LATEGR"),4,2)))
                sEarlyGR = Cint((mid(rstTMPATH("EARLYGR"),1,2))*60) + Cint((mid(rstTMPATH("EARLYGR"),4,2)))
                sMinOT = Cint((mid(rstTMPATH("MINOT"),1,2))*60) + Cint((mid(rstTMPATH("MINOT"),4,2)))
                sPayFrom = rstTMPATH("PAYFROM") 
                sPayTo = rstTMPATH("PAYTO")
                sHalfDayGr = rstTMPATH("HALFDAYGR")
            end if
            pCloseTables(rstTMPATH)

            '==== Get the date from and to for ABSENT for 3 days=============================================================
            if Cint(day(now)) > Cint(sPayTo) then
                sPayFrom = sPayFrom & "-" & Month(Now) & "-" & Year(Now)
            else
                sPayFrom = sPayFrom & "-" & GetLastMonth(Month(Now), Year(Now)) & "-" & GetLastMonthYear(Month(Now), Year(Now))
            end if

            dtPayFrom = cDate(sPayFrom) '=== From 22nd of everymonth
            dtPayTo = Date()  '==== Till THE DATE OF PROCESS

            '================================================================================================================
            
            '======Insert into TMCLK2 ==================================
            '====== Insert according to date of file ===================
            dtpDateFr = dtProcess
            dtpDateTo = dtProcess
            
            Set rstTMClk1 = server.CreateObject("ADODB.RecordSet")  '=== Call TMCLK1 again and insert into TMCLK2
            sSQL = "select * from TMCLK1 "
            sSQL = sSQL & " where (DT_WORK between '" & fdate2(dtpDateFr) & "'"
            sSQL = sSQL & " and '" & fdate2(dtpDateTo) & "')" 

            if sEmp_Code <> "" then
                sSQL = sSQL & " and CODE = '" & sEmp_Code & "'" 
            end if

            sSQL = sSQL & " order by DT_WORK, CODE, HOUR, MIN"
            rstTMClk1.Open sSQL, conn, 3, 3
            if not rstTMClk1.eof then   

                Do while not rstTMClk1.eof '==== Begin with each inserted in order records and start inserting into TMCLK2
            
                    sCode = rstTMClk1("CODE")
                    dt_Work = rstTMClk1("DT_WORK")
                    sHour = Cint(rstTMCLK1("HOUR"))
                    sMin = Cint(rstTMCLK1("MIN"))
                    sInOut = rstTMCLK1("IN_OUT")
                
                    dt_ActWork = dt_Work
                    sActhour = sHour
                    sActmin = sMin

                    sActtimetoMins = Cint(sActhour * 60) + Cint(sActmin)

                    sTime = pAddZero(sActhour) & ":" & pAddZero(sActmin) 
                    
                    dt_PreWork = DateAdd("d",-1,dt_ActWork)
        
                    Set rstTMShiftOT = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMSHIFTOT " 
                    sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                    sSQL = sSQL & " AND DT_SHIFT = '" & fdate2(dt_Work) & "'"
                    rstTMShiftOT.Open sSQL, conn, 3, 3
                    IF not rstTMShiftOT.eof then    
        
                        bGotShf = "Y"
                        sSHF_CODE = rstTMShiftOT("SHF_CODE")

                        Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMSHFCODE " 
                        sSQL = sSQL & " WHERE SHF_CODE = '" & rstTMShiftOT("SHF_CODE") & "'"
                        rstTMSHFCODE.Open sSQL, conn, 3, 3
                        if not rstTMSHFCODE.eof then
        
                            sOSTIME = rstTMSHFCODE("STIME")
                            sOETIME = rstTMSHFCODE("ETIME") 
    
                            if rstTMSHFCODE("STIME") <> "" and rstTMSHFCODE("ETIME") <> "" then
                                sSTIME = rstTMSHFCODE("STIME")
                                sETIME = rstTMSHFCODE("ETIME")  
                                sSTIME_H = Cint(Mid(rstTMSHFCODE("STIME"),1,2))  '===Get the Shift Start time and convert to Integer
                                sETIME_H = Cint(Mid(rstTMSHFCODE("ETIME"),1,2))  '===Get the Shift End time and convert to Integer
                                sSTIME_M = Cint(Mid(rstTMSHFCODE("STIME"),4,2))
                                sETIME_M = Cint(Mid(rstTMSHFCODE("ETIME"),4,2))
                                sSTimeMins = Cint((mid(sSTIME,1,2))*60) + Cint((mid(sSTIME,4,2)))
                                sETimeMins = Cint((mid(sETIME,1,2))*60) + Cint((mid(sETIME,4,2)))
                            else 
                                
                                Set rstTMShiftOT = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMSHIFTOT " 
                                sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                sSQL = sSQL & " AND DT_SHIFT = '" & fdate2(dt_Prework) & "'" 'Take the previous day Shift Info
                                rstTMShiftOT.Open sSQL, conn, 3, 3
                                IF not rstTMShiftOT.eof then 
                                    Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMSHFCODE " 
                                    sSQL = sSQL & " WHERE SHF_CODE = '" & rstTMShiftOT("SHF_CODE") & "'"
                                    rstTMSHFCODE.Open sSQL, conn, 3, 3
                                    if not rstTMSHFCODE.eof then
                                        if rstTMSHFCODE("STIME") <> "" and rstTMSHFCODE("ETIME") <> "" then
                                            sSTIME = rstTMSHFCODE("STIME")
                                            sETIME = rstTMSHFCODE("ETIME")  
                                            sSTIME_H = Cint(Mid(rstTMSHFCODE("STIME"),1,2))  '===Get the Shift Start time and convert to Integer
                                            sETIME_H = Cint(Mid(rstTMSHFCODE("ETIME"),1,2))  '===Get the Shift End time and convert to Integer
                                            sSTIME_M = Cint(Mid(rstTMSHFCODE("STIME"),4,2))
                                            sETIME_M = Cint(Mid(rstTMSHFCODE("ETIME"),4,2))
                                            sSTimeMins = Cint((mid(sSTIME,1,2))*60) + Cint((mid(sSTIME,4,2)))
                                            sETimeMins = Cint((mid(sETIME,1,2))*60) + Cint((mid(sETIME,4,2)))
                                        
                                        else ' === if today is OFF, previous day is also OFF day, then take the previous previous day shift
                                            
                                            dt_PreWork2 = DateAdd("d",-2,dt_ActWork)    
                                            
                                            Set rstTMShiftOT = server.CreateObject("ADODB.RecordSet")    
                                            sSQL = "select * from TMSHIFTOT " 
                                            sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                            sSQL = sSQL & " AND DT_SHIFT = '" & fdate2(dt_Prework2) & "'" 'Take the previous day Shift Info
                                            rstTMShiftOT.Open sSQL, conn, 3, 3
                                            IF not rstTMShiftOT.eof then 
                                                Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                                                sSQL = "select * from TMSHFCODE " 
                                                sSQL = sSQL & " WHERE SHF_CODE = '" & rstTMShiftOT("SHF_CODE") & "'"
                                                rstTMSHFCODE.Open sSQL, conn, 3, 3
                                                if not rstTMSHFCODE.eof then
                                                    if rstTMSHFCODE("STIME") <> "" and rstTMSHFCODE("ETIME") <> "" then
                                                        sSTIME = rstTMSHFCODE("STIME")
                                                        sETIME = rstTMSHFCODE("ETIME")  
                                                        sSTIME_H = Cint(Mid(rstTMSHFCODE("STIME"),1,2))  '===Get the Shift Start time and convert to Integer
                                                        sETIME_H = Cint(Mid(rstTMSHFCODE("ETIME"),1,2))  '===Get the Shift End time and convert to Integer
                                                        sSTIME_M = Cint(Mid(rstTMSHFCODE("STIME"),4,2))
                                                        sETIME_M = Cint(Mid(rstTMSHFCODE("ETIME"),4,2))
                                                        sSTimeMins = Cint((mid(sSTIME,1,2))*60) + Cint((mid(sSTIME,4,2)))
                                                        sETimeMins = Cint((mid(sETIME,1,2))*60) + Cint((mid(sETIME,4,2)))
                                                    
                                                    else ' === if the day is REST, previous day is OFF and previous previous day is also OFF, then take 3 days prior shift before 3 days before got shift.
                                                        
                                                        dt_PreWork3 = DateAdd("d",-3,dt_ActWork)   
                                                        
                                                        Set rstTMShiftOT = server.CreateObject("ADODB.RecordSet")    
                                                        sSQL = "select * from TMSHIFTOT " 
                                                        sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                                        sSQL = sSQL & " AND DT_SHIFT = '" & fdate2(dt_Prework3) & "'" 'Take the previous day Shift Info
                                                        rstTMShiftOT.Open sSQL, conn, 3, 3
                                                        IF not rstTMShiftOT.eof then 
                                                            Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                                                            sSQL = "select * from TMSHFCODE " 
                                                            sSQL = sSQL & " WHERE SHF_CODE = '" & rstTMShiftOT("SHF_CODE") & "'"
                                                            rstTMSHFCODE.Open sSQL, conn, 3, 3
                                                            if not rstTMSHFCODE.eof then
                                                                if rstTMSHFCODE("STIME") <> "" and rstTMSHFCODE("ETIME") <> "" then
                                                                    sSTIME = rstTMSHFCODE("STIME")
                                                                    sETIME = rstTMSHFCODE("ETIME")  
                                                                    sSTIME_H = Cint(Mid(rstTMSHFCODE("STIME"),1,2))  '===Get the Shift Start time and convert to Integer
                                                                    sETIME_H = Cint(Mid(rstTMSHFCODE("ETIME"),1,2))  '===Get the Shift End time and convert to Integer
                                                                    sSTIME_M = Cint(Mid(rstTMSHFCODE("STIME"),4,2))
                                                                    sETIME_M = Cint(Mid(rstTMSHFCODE("ETIME"),4,2))
                                                                    sSTimeMins = Cint((mid(sSTIME,1,2))*60) + Cint((mid(sSTIME,4,2)))
                                                                    sETimeMins = Cint((mid(sETIME,1,2))*60) + Cint((mid(sETIME,4,2)))
                                                                end if 
                                                            end if
                                                        END if '===== End if Else =====
                                                    end if 
                                                end if 
                                            END if '=== End if Else =====
                                         end if '=== End If rstTMSHFCODE("STIME") <> "" and rstTMSHFCODE("ETIME") <> ""
                                    end if '=== End if not rstTMSHFCODE.eof 
                                END if '=== End IF not rstTMShiftOT.eof
                            End if ' === End if rstTMSHFCODE("STIME") <> "" and rstTMSHFCODE("ETIME") <> ""
                        end if '=== End if not rstTMSHFCODE.eof then
                    else
                        bGotShf = "N"
                    end if  '===  End if IF not rstTMShiftOT.eof
              
'response.write "<br> === EMP_CODE : " & sCode & "-------DT_WORK-------: " & dt_ActWork & " ----SHIFT IN ---- " & sSTIME_H & " ----SHIFT OUT--- " & sETIME_H & "---Time to Check: " & sTime & "---IN OUT----" & sInOut & "<br>"
  
                    if bGotShf = "Y" then '==== Only Process those with shift

                        if sETIME_H < sSTIME_H then   '=== START with Shift Start Time > Shift End Time, 1900 > 0700
                            
                            if sInOut = "IN" then  '==== Always need to insert in first 
                                
                                Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_ActWork) & "'" '===Check TMCLK2 got record on that day. 
                                rstTMClk2.Open sSQL, conn, 3, 3
                                if rstTMClk2.eof then '=== No record on that day
                                    
                                    '=== When TOUT hour 01 is < 19 and 01 < 07, It is from 00,01,02,03,04,05,06
                                    if Cint(sHour) < Cint(sSTIME_H) and Cint(sHour) < Cint(sETIME_H) then 
                                        Set rstPrev = server.CreateObject("ADODB.RecordSet")    
                                        sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                        sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_PreWork) & "'"
                                        sSQL = sSQL & " and TIN <> '' "   
                                        rstPrev.Open sSQL, conn, 3, 3
                                        if rstPrev.eof then '=== When Punch in twice, only take the 1st Punch in
                                            sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,AllCode,OSTIME,OETIME,STIME,ETIME,OTIN,TIN,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                    sSQL = sSQL & "values ("
                                            sSQL = sSQL & "'" & sCode & "',"		
		                                    sSQL = sSQL & "'" & fdate2(dt_PreWork) & "',"		
                                            sSQL = sSQL & "'" & sSHF_CODE & "',"
                                            sSQL = sSQL & "'" & sSHF_CODE & "',"
                                            sSQL = sSQL & "'" & sSHF_CODE & "',"
                                            sSQL = sSQL & "'" & sSTIME & "',"
                                            sSQL = sSQL & "'" & sETIME & "',"
                                            sSQL = sSQL & "'" & sSTIME & "',"
                                            sSQL = sSQL & "'" & sETIME & "',"
                                            sSQL = sSQL & "'" & sTime & "'," 
                                            sSQL = sSQL & "'" & sTime & "'," 
                                            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"        
                                            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                    sSQL = sSQL & ") "
                                        end if
                                    else '==== the time 07,08,09 all till 23, is consider IN

        'response.write sHour & " , " & sSTIME_H & " and " & sHour & " , " & sETIME_H
        'response.end
                                        sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,AllCode,OSTIME,OETIME,STIME,ETIME,OTIN,TIN,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                sSQL = sSQL & "values ("
                                        sSQL = sSQL & "'" & sCode & "',"		
		                                sSQL = sSQL & "'" & fdate2(dt_ActWork) & "',"		
                                        sSQL = sSQL & "'" & sSHF_CODE & "',"
                                        sSQL = sSQL & "'" & sSHF_CODE & "',"
                                        sSQL = sSQL & "'" & sSHF_CODE & "',"
                                        sSQL = sSQL & "'" & sSTIME & "',"
                                        sSQL = sSQL & "'" & sETIME & "',"
                                        sSQL = sSQL & "'" & sSTIME & "',"
                                        sSQL = sSQL & "'" & sETIME & "',"
                                        sSQL = sSQL & "'" & sTime & "'," 
                                        sSQL = sSQL & "'" & sTime & "'," 
                                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"        
                                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                sSQL = sSQL & ") "
                                     end if

      '  if sCode = "ZN0056" then
      '      response.write " U1900-0700@@@@  Insert  in sSQL " & "<br>"
      '  end if
                                    conn.execute sSQL
                                end if '=== End rstPre
                            
                            elseif  sInOut = "OUT" then 
 
                                Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_ActWork) & "'" '===Check TMCLK2 got record on the day. 
                                rstTMClk2.Open sSQL, conn, 3, 3
                                if rstTMClk2.eof then '=== No record on that day
                                    Set rstPrev = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                    sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_PreWork) & "'"
                                    sSQL = sSQL & " and TIN <> '' "   
                                    rstPrev.Open sSQL, conn, 3, 3
                                    if not rstPrev.eof then ' === Got record on previous day, TIN is inserted, Insert previous day TOUT
                                        sSQL = "UPDATE TMCLK2 SET "             
                                        sSQL = sSQL & "OTOUT = '" & sTime & "',"
                                        sSQL = sSQL & "TOUT = '" & sTime & "'"
                                        sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                        sSQL = sSQL & " AND DT_WORK = '" & fdate2(dt_PreWork) & "'" 

        'if sCode = "102408" and fdate2(dt_ActWork) = "2018-05-17" then
           ' response.write " UPDATE TOUT TMCLK2 1900-0700 preWork in sSQL " & "<br>"
        'end if
                                        conn.execute sSQL
                                    else '=== No record previous day, INCOMPLETE, insert into TOUT previous day
                                        if sHour > sETime_H then
                                            Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                            sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                            sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_ActWork) & "'" '===Check TMCLK2 got record on the day. 
                                            rstTMClk2.Open sSQL, conn, 3, 3
                                            if rstTMClk2.eof then
                                                sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,AllCode,OSTIME,OETIME,STIME,ETIME,OTOUT,TOUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                        sSQL = sSQL & "values ("
                                                sSQL = sSQL & "'" & sCode & "',"		
		                                        sSQL = sSQL & "'" & fdate2(dt_ActWork) & "',"		
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSTIME & "',"
                                                sSQL = sSQL & "'" & sETIME & "',"
                                                sSQL = sSQL & "'" & sSTIME & "',"
                                                sSQL = sSQL & "'" & sETIME & "',"
                                                sSQL = sSQL & "'" & sTime & "'," 
                                                sSQL = sSQL & "'" & sTime & "',"   
                                                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"      
                                                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                        sSQL = sSQL & ") "
                                                conn.execute sSQL
                                            else
                                                sSQL = "UPDATE TMCLK2 SET "             
                                                sSQL = sSQL & "OTOUT = '" & sTime & "',"
                                                sSQL = sSQL & "TOUT = '" & sTime & "'"
                                                sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                                sSQL = sSQL & " AND DT_WORK = '" & fdate2(dt_PreWork) & "'"
                                                conn.execute sSQL
                                            end if
                                        else
                                            Set rstPrev = server.CreateObject("ADODB.RecordSet")    
                                            sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                            sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_PreWork) & "'"
                                            rstPrev.Open sSQL, conn, 3, 3
                                            if rstPrev.eof then ' === No Incomplete, previous TOUT record inserted 
                                                    
                                                sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,AllCode,OSTIME,OETIME,STIME,ETIME,OTOUT,TOUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                        sSQL = sSQL & "values ("
                                                sSQL = sSQL & "'" & sCode & "',"		
		                                        sSQL = sSQL & "'" & fdate2(dt_PreWork) & "',"		
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSTIME & "',"
                                                sSQL = sSQL & "'" & sETIME & "',"
                                                sSQL = sSQL & "'" & sSTIME & "',"
                                                sSQL = sSQL & "'" & sETIME & "',"
                                                sSQL = sSQL & "'" & sTime & "'," 
                                                sSQL = sSQL & "'" & sTime & "',"   
                                                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"      
                                                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                        sSQL = sSQL & ") "
                                                conn.execute sSQL
                                            end if
                                        end if
        'if sCode = "102408" and fdate2(dt_ActWork) = "2018-05-17" then
            'response.write " INSERT or UPDATE TMCLK2 1900-0700@@@@@@@ in sSQL " & sSQL & "<br>"
        'response.end
        'end if
                                    end if                        
                                
                                else '==== Got record on the day, IRREG. Insert in TOUT on that day.
                                    sSQL = "UPDATE TMCLK2 SET "             
                                    sSQL = sSQL & "OTOUT = '" & sTime & "',"
                                    sSQL = sSQL & "TOUT = '" & sTime & "'"
                                    sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                    sSQL = sSQL & " AND DT_WORK = '" & fdate2(dt_ActWork) & "'" 

        'if sCode = "32964" then
           ' response.write " UPDATE TOUT TMCLK2 1900-0700@@@@@@@ in sSQL " & "<br>"
        'end if
                                    conn.execute sSQL
                                end if
        
                            end if '=== End if sInOut = "IN" elseif sInOut = "OUT"  

        
    '===================  When normal morning shfit ==============================================================================           

                        else  '=== If Stime < ETime, 0700 - 1900
     'response.write "<br> === EMP_CODE : " & sCode & "-------DT_WORK-------: " & dt_ActWork & " ----SHIFT IN ---- " & sSTIME_H & " ----SHIFT OUT--- " & sETIME_H & "---Time to Check: " & sTime & "---IN OUT----" & sInOut & "<br>"
                       
                            if sInOut = "IN" then

                                Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_ActWork) & "'" '===Check TMCLK2 got record on that day. 
                                rstTMClk2.Open sSQL, conn, 3, 3
                                if rstTMClk2.eof then '=== No record on that day
                                    sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,AllCode,OSTIME,OETIME,STIME,ETIME,OTIN,TIN,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                            sSQL = sSQL & "values ("
                                    sSQL = sSQL & "'" & sCode & "',"		
		                            sSQL = sSQL & "'" & fdate2(dt_ActWork) & "',"		
                                    sSQL = sSQL & "'" & sSHF_CODE & "',"
                                    sSQL = sSQL & "'" & sSHF_CODE & "',"
                                    sSQL = sSQL & "'" & sSHF_CODE & "',"
                                    sSQL = sSQL & "'" & sSTIME & "',"
                                    sSQL = sSQL & "'" & sETIME & "',"
                                    sSQL = sSQL & "'" & sSTIME & "',"
                                    sSQL = sSQL & "'" & sETIME & "',"
                                    sSQL = sSQL & "'" & sTime & "',"         
                                    sSQL = sSQL & "'" & sTime & "'," 
                                    sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"        
                                    sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                            sSQL = sSQL & ") "
        'if sCode = "7003679" then
         '   response.write " TIN @@@@@@@@@@@ Insert in sSQL " & sSQL & "<br>"
        'end if
		                            conn.execute sSQL
                                end if

                            elseif sInOut = "OUT" then

                            '==== Half of shift, TIN and TOUT outside TIN+-iHalfOfShift or TOUT+- iHalfOfShift respectively is consider irregular
                            
                                iHalfOfShift_H = (sETIME_H - sSTIME_H)/2
                                
                                if Cint(sHour) - Cint(sETIME_H) <= Cint(iHalfOfShift_H) or (sSHF_CODE = "OFF" or sSHF_CODE = "REST") then '== TOUT is within +- iHalfOfShift, NOT IRREGULAR
                                    Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                    sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_ActWork) & "'" '===Check TMCLK2 got record on that day. 
                                    rstTMClk2.Open sSQL, conn, 3, 3
                                    if not rstTMClk2.eof then '=== Got record on that day
           
                                        sSQL = "UPDATE TMCLK2 SET "
                                        sSQL = sSQL & "OTOUT = '" & sTime & "',"
                                        sSQL = sSQL & "TOUT = '" & sTime & "'"
                                        sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                        sSQL = sSQL & " AND DT_WORK = '" & fdate2(dt_ActWork) & "'"
        'if sCode = "32964" then
         'response.write " ------------------ UPDATE TMCLK2 " & sSQL & "<br>"
        'end if
                                        conn.execute sSQL
             
                                    else '==== Forgot IN but got OUT insert new OUT.

                                        if Cint(sHour) < Cint(sEtime_H) then

                                            Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                            sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                            sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_PreWork) & "'" '===Check TMCLK2 got record on that day. 
                                            rstTMClk2.Open sSQL, conn, 3, 3
                                            if not rstTMClk2.eof then '=== Got record on that day
           
                                                sSQL = "UPDATE TMCLK2 SET "
                                                sSQL = sSQL & "OTOUT = '" & sTime & "',"
                                                sSQL = sSQL & "TOUT = '" & sTime & "'"
                                                sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                                sSQL = sSQL & " AND DT_WORK = '" & fdate2(dt_PreWork) & "'"
                'if sCode = "32964" then
                 'response.write " Abnormal UPDATE TMCLK2 " & sSQL & "<br>"
                'end if
                                                conn.execute sSQL
                                            else
                                                sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,AllCode,OSTIME,OETIME,STIME,ETIME,OTOUT,TOUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                        sSQL = sSQL & "values ("
                                                sSQL = sSQL & "'" & sCode & "',"		
		                                        sSQL = sSQL & "'" & fdate2(dt_Actwork) & "',"		
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSHF_CODE & "',"
                                                sSQL = sSQL & "'" & sSTIME & "',"
                                                sSQL = sSQL & "'" & sETIME & "',"
                                                sSQL = sSQL & "'" & sSTIME & "',"
                                                sSQL = sSQL & "'" & sETIME & "',"
                                                sSQL = sSQL & "'" & sTime & "',"         
                                                sSQL = sSQL & "'" & sTime & "',"         
                                                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                                sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                        sSQL = sSQL & ")" 
                'if sCode = "102570" then
                 '   response.write " AbNormal INSERT TMCLK2 " & sSQL & "<br>"
                'end if
                                                conn.execute sSQL

                                            end if
                                        else
        
                                            sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,AllCode,OSTIME,OETIME,STIME,ETIME,OTOUT,TOUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                    sSQL = sSQL & "values ("
                                            sSQL = sSQL & "'" & sCode & "',"		
		                                    sSQL = sSQL & "'" & fdate2(dt_ActWork) & "',"		
                                            sSQL = sSQL & "'" & sSHF_CODE & "',"
                                            sSQL = sSQL & "'" & sSHF_CODE & "',"
                                            sSQL = sSQL & "'" & sSHF_CODE & "',"
                                            sSQL = sSQL & "'" & sSTIME & "',"
                                            sSQL = sSQL & "'" & sETIME & "',"
                                            sSQL = sSQL & "'" & sSTIME & "',"
                                            sSQL = sSQL & "'" & sETIME & "',"
                                            sSQL = sSQL & "'" & sTime & "',"         
                                            sSQL = sSQL & "'" & sTime & "',"         
                                            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                    sSQL = sSQL & ")" 
            'if sCode = "32964" then
                'response.write " AbNormal 2 INSERT TMCLK2 " & sSQL & "<br>"
            'end if
                                            conn.execute sSQL
                                        end if
                                    end if 

                                else  '=== Its a IRREGULAR, check if previous day got record, if got UPDATE, if not INSERT.
         
                                    Set rstTMClk2 = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMCLK2 where EMP_CODE = '" & sCode & "'"
                                    sSQL = sSQL & " and DT_WORK = '" & fdate2(dt_PreWork) & "'" '===Check TMCLK2 got record on PREVIOUS day. 
                                    rstTMClk2.Open sSQL, conn, 3, 3
                                    if not rstTMClk2.eof then '=== Got record on PREVIOUS day
   
                                        sSQL = "UPDATE TMCLK2 SET "
                                        sSQL = sSQL & "OTOUT = '" & sTime & "',"
                                        sSQL = sSQL & "TOUT = '" & sTime & "'"
                                        sSQL = sSQL & " WHERE EMP_CODE = '" & sCode & "'"
                                        sSQL = sSQL & " AND DT_WORK = '" & fdate2(dt_PreWork) & "'"
        'if sCode = "32964" then
            'response.write " ************************ ABNORMAL UPDATE TMCLK2 " & sSQL & "<br>"
        'end if
                                        conn.execute sSQL

                                    else '==== Forgot IN but got OUT insert new OUT.
                                    
                                        sSQL = "insert into TMCLK2 (EMP_CODE,DT_WORK,OSHF_CODE,SHF_CODE,AllCode,OSTIME,OETIME,STIME,ETIME,OTOUT,TOUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                sSQL = sSQL & "values ("
                                        sSQL = sSQL & "'" & sCode & "',"		
		                                sSQL = sSQL & "'" & fdate2(dt_PreWork) & "',"		
                                        sSQL = sSQL & "'" & sSHF_CODE & "',"
                                        sSQL = sSQL & "'" & sSHF_CODE & "',"
                                        sSQL = sSQL & "'" & sSHF_CODE & "',"
                                        sSQL = sSQL & "'" & sSTIME & "',"
                                        sSQL = sSQL & "'" & sETIME & "',"
                                        sSQL = sSQL & "'" & sSTIME & "',"
                                        sSQL = sSQL & "'" & sETIME & "',"
                                        sSQL = sSQL & "'" & sTime & "',"         
                                        sSQL = sSQL & "'" & sTime & "',"
                                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                        sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                sSQL = sSQL & ") "
        'if sCode = "32964" then
           ' response.write " ********************ABNORMAL INSERT TMCLK2 " & sSQL & "<br>"
        'end if
                                        conn.execute sSQL
                                    end if 
                                end if
                            end if '=== End sInOut = In or Out                            
                        end if '=== End sETIME < sSTIME
                    end if '=== End if got shift
                    
                    rstTMClk1.movenext
                
                Loop
                
            end if '===  if not TMClk1.eof

        '============================================================================================
        '======= Check for abnormal, OT, Late, Early, Half Day, Total and TotalOT====================
    
            dtpCheckFr = dateadd("d", -1, dtProcess) '==== Process one day before because of the night shift
            dtpCheckTo = dtProcess '==== Process until the date of file is not to process too much 

            Set rstTMClk2 = server.CreateObject("ADODB.RecordSet") 
            sSQL = "select * from TMCLK2 " 
            sSQL = sSQL & " where isnull(1DTAPV) and isnull(1OTDTAPV) " '=== Filter out all those that has been approved
            sSQL = sSQL & " and (DT_WORK between '" & fdate2(dtpCheckFr) & "'" '==== Only check the newly inserted and 1 day before for overnight processing
            sSQL = sSQL & " and '" & fdate2(dtpCheckTo) & "')" 
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

                    Set rstGRADE_ID = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select tmemply.GRADE_ID, OTSHFALL from TMEMPLY "
                    sSQL = sSQL & " left join TMGRADE"
                    sSQL = sSQL & " on tmemply.GRADE_ID = tmgrade.GRADE_ID"
                    sSQL = sSQL & " where EMP_CODE = '" & rstTMClk2("EMP_CODE") & "'"
                    rstGRADE_ID.Open sSQL, conn, 3, 3
                    if not rstGRADE_ID.eof then
                        sGrade_ID = rstGRADE_ID("GRADE_ID")    
                        sOtShfAll = rstGRADE_ID("OTSHFALL")
                    end if
                    pCloseTables(rstGRADE_ID)

                    if sSTIME <> "" then 
                        sSTIME_H = Cint(Mid(sSTIME,1,2))
                        iSTimeMins = Cint(TimeToMin(sSTime))
                    end if

                    if sETIME <> "" then
                        sETIME_H = Cint(Mid(sETIME,1,2))
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
                        if sSTIME_H > sETIME_H then ' === this is 1900 to 0700 Shift
                    
                            'if  rstTMClk2("EMP_CODE") = "102469" then                     
                             '   sHoliday ="Y"
                              '  response.end
                            'end if
                            '===== Check if it is Holiday or OffRest Code
                            if sOTShfAll = "Y" and (sHoliday = "Y" or sOffRest = "Y") then
                                if sTIN_H > 12 and sTOUT_H <= 12 then
                                    iTOUTMins = iTOUTMins + 1440
                                end if
        
                                sOT = "Y"
                                iTotal = iTOUTMins - iTINMins
                                iTotalOT = iTotal  '==== Holiday work is all OT
                            end if
                            
                            '==== For Night Shift calculation tweak
                            iETimeMins = iETimeMins + 1440
                            iHalfOfShift_H = Cint(((sETIME_H +24)-sSTIME_H)/2)
                            iHalfOfShiftMins = Cint((iETimeMins - iSTimeMins)/2)
                                
                            if sTIN_H < 12 and sTOUT_H < 12 then '=== 2nd Half Day For punch in at 00:00 onwards till 11:59 and out is also 00:00 till 11:59
                                sTIN_H = sTIN_H + 24
                                iTINMins = iTINMins + 1440
                            end if
                            
                            if sTOUT_H <= 12 then '=== Punch out from 00:00am till 11:59am, ADD 24Hours for calculation
                                iTOUTMins = iTOUTMins + 1440
                            End if

                            if (sTIN_H <= (sSTIME_H + iHalfOfShift_H ) and sTIN_H >= (sSTIME_H - iHalfOfShift_H )) or sHoliday = "Y" or sOffRest = "Y" then
                                sIrreg = ""
                            else
                                sIrreg = "Y"
                            end if
       
'response.write rstTMClk2("EMP_CODE") & " : sTIN : " & sTIN & " , sTOUT : " & sTOUT & " , IRREG :  " & sIrreg & "  WHAT : " 

                            if sIrreg <> "Y" and sOTShfAll = "Y" and sHoliday <> "Y" and sOffRest <> "Y"  then '== Only with OTShf allowance and not Holiday or OffRest 
                                '=== Early In
                                if iTINMins < iSTimeMins then
                                                
                                    '====Early In More then MinOT
                                    if (iSTimeMins-iTINMins) >= Cint(sMinOT) then
                                                    
                                        '=== Late Out or Normal
                                        if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(sMinOT)) then 
        
                                            'response.write "EarlyInOT and LateOutOT"
                                            sOT = "Y"
                                            iOTIn = iSTimeMins-iTINMins
                                            iOTOut = iTOUTMins - iETimeMins
                                                
                                            iTotal = iTOUTMins - iTINMins
                                            iTotalOT = iOTIn + iOTOut
                                        else
                            
                                            'response.write "EarlyInOT and NormalOut"
                                            sOT = "Y"
                                            iOTIn = iSTimeMins - iTinMins
                                                
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iETimeMins - iTINMins
                                            iTotalOT = iOTIn
                                        end if
                                    else '=== Not more than MinOT In
                                        '=== Late Out or Normal
                                        if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(sMinOT)) then 
        
                                            'response.write "Not more than minOT and LateOutOT"
                                            sOT = "Y"
                                            iOTOut = iTOUTMins - iETimeMins
      
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iTOUTMins - iSTimeMins
                                            iTotalOT = iOTOut                       
                                        else

                                            'response.write "Not more than minOT and NormalOut"
                                            sOT="N"
                                                
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iETimeMins - iSTimeMins '=== Shift in until Shift Out time
                                            iTotalOT = 0
                                        end if
                                    end if
                                else '=== Punch in after STIME
                                    if (iTINMins - iSTimeMins) > Cint(sLateGR) then
                                        'response.write "late"
                                        sLate = "Y"
                                    end if
                                    '==== Late out or Normal
                                        if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(sMinOT)) then 
        
                                            'response.write " Normal IN and LateOutOT "
                                            sOT = "Y"
                                            iOTOut = iTOUTMins - iETimeMins
                                            
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iTOUTMins - iSTimeMins
                                            iTotalOT = iOTOut  
                                        else
                                            'response.write " Normal IN and Normal Out"                          
                                            sOT="N"
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iETimeMins - iSTimeMins '=== Shift in until Shift Out time
                                            iTotalOT = 0
                                        end if
                                end if '=== iTINMins < iSTimeMins then

                                if iTOUTMins < iETimeMins Then
                                    if (iETimeMins - iTOUTMins) > Cint(sEarlyGR) then
                                        sEarly = "Y"
                                    end if
                                end if
                                
                                '==== For Half Day 
                                if iTotal <> "" then
                                    if iTotal <= (iHalfOfShiftMins + Cint(TimeToMin(sHalfDayGr)))  then
                                        sHalfDay = "Y"
                                    end if 
                                end if
                                                       
                            end if '=== sIrreg <> "Y" and sOTShfAll = "Y" then 
                            
         'response.write "<br>" 
                       
                        elseif sSTIME_H < sETIME_H then '==== for Morning 0700-1900 Shift


                                
                            'if  rstTMClk2("EMP_CODE") = "102469" then                     
                             '   sHoliday ="Y"
                            'response.end
                            'end if

                            if sHoliday = "Y" or sOffRest = "Y" then          
                                if iTOUTMins < iTINMins then        
                                    iTOUTMins = iTOUTMins + 1440  '=== This is when his previous week is normal shift, but weekend is overnight shift. Need to take care of the tOUT
                                    iETimeMins = iETimeMins + 1440
                                end if
                                    
                                sOT = "Y"
                                iTotal = iTOUTMins - iTINMins
                                iTotalOT = iTotal  '==== Holiday work is all OT
                            end if
        
                            '==== Half of the shift in hours, so 0700-1900 is six hours
                            iHalfOfShift_H = Cint((sETIME_H-sSTIME_H)/2)
                            iHalfOfShiftMins = Cint((iETimeMins - iSTimeMins)/2)

                            '===== 1300 <= 0700 <= 0100, TIN is witin plus minus 6 hours from 0700 
                            if (sTIN_H <= (sSTIME_H + iHalfOfShift_H ) and sTIN_H >= (sSTIME_H - iHalfOfShift_H )) or sHoliday = "Y" or sOffRest = "Y"  then
                                sIrreg = ""
                            else
                                sIrreg = "Y"
                            end if
   
    'response.write rstTMClk2("EMP_CODE") & " : sTIN : " & sTIN & " , sTOUT : " & sTOUT & " , IRREG :  " & sIrreg & "  WHAT : " 
             
                            if sIrreg <> "Y" and sOTShfAll = "Y" and sHoliday <> "Y" and sOffRest <> "Y" then '== Only with OTShf allowance will calculate OT. 
                    
                                '=== Early In
                                if iTINMins < iSTimeMins then
                                                
                                    '====Early In More then MinOT
                                    if (iSTimeMins-iTINMins) >= Cint(sMinOT) then
                                                    
                                        '=== Late Out or Normal
                                        if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(sMinOT)) then 
        
                                            'response.write "EarlyInOT and LateOutOT"
                                            sOT = "Y"
                                            iOTIn = iSTimeMins-iTINMins
                                            iOTOut = iTOUTMins - iETimeMins
                                                
                                            iTotal = iTOUTMins - iTINMins
                                            iTotalOT = iOTIn + iOTOut
                                        else
                            
                                            'response.write "EarlyInOT and NormalOut"
                                            sOT = "Y"
                                            iOTIn = iSTimeMins - iTinMins
                                                
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iETimeMins - iTINMins
                                            iTotalOT = iOTIn
                                        end if
                                    else '=== Not more than MinOT In
                                        '=== Late Out or Normal
                                        if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(sMinOT)) then 
        
                                            'response.write "Not more than minOT and LateOutOT"
                                            sOT = "Y"
                                            iOTOut = iTOUTMins - iETimeMins
      
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iTOUTMins - iSTimeMins
                                            iTotalOT = iOTOut                       
                                        else

                                            'response.write "Not more than minOT and NormalOut"
                                            sOT="N"
                                                
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iETimeMins - iSTimeMins '=== Shift in until Shift Out time
                                            iTotalOT = 0
                                        end if
                                    end if
                                else '=== Punch in after STIME
                                    if (iTINMins - iSTimeMins) > Cint(sLateGR)  then
                                        'response.write "late"
                                        sLate = "Y"
                                    end if
                                    '==== Late out or Normal
                                        if (iTOUTMins > iETimeMins) and ((iTOUTMins - iETimeMins) >= Cint(sMinOT)) then 
        
                                            'response.write " Normal IN and LateOutOT "
                                            sOT = "Y"
                                            iOTOut = iTOUTMins - iETimeMins
                                            
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iTOUTMins - iSTimeMins
                                            iTotalOT = iOTOut  
                                        else
                                            'response.write " Normal IN and Normal Out"                          
                                            sOT="N"
                                            iTotal = iTOUTMins - iTINMins
                                            'iTotal = iETimeMins - iSTimeMins '=== Shift in until Shift Out time
                                            iTotalOT = 0
                                        end if
                                end if '=== iTINMins < iSTimeMins then

                                if iTOUTMins < iETimeMins Then
                                    if (iETimeMins - iTOUTMins) > Cint(sEarlyGR) then
                                        sEarly = "Y"
                                    end if
                                end if
                                
                                if iTotal <> "" then
                                    if iTotal <= (iHalfOfShiftMins + Cint(TimeToMin(sHalfDayGr)))  then
                                        sHalfDay = "Y"
                                    end if 
                                end if  
                            
                            'response.write "<br>"

                            end if '=== sIrreg <> "Y" and sOTShfAll = "Y" then 
                        
                        end if  '===if sSTIME_H > sETIME_H
        
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
                        conn.execute sSQL
                        
                    end if '===if sIncom
                rstTMClk2.movenext
                loop
            end if '=== End if not rstTMClk2.eof
    
        '============================================================================================

        '======= END Check ==========================================================================
    
        '===== Process one before because night shift data finish inserted =======================================
        '==== Latest Leave Information need to be uploaded into TMEOFF and then only =============================
        
            dtAbsent = dateadd("d", -1, dtProcess)
            
            sSQL = "select tmemply.EMP_CODE as EMPCODE, tmemply.NAME, SUP_CODE, tmemply.GRADE_ID, tmemply.GENSHF, WORKGRP_ID, tmworkgrp.HOL_ID, "
            sSQL = sSQL & "tmshiftot.SHF_CODE as SHFCODE, tmshiftot.DT_SHIFT, tmclk2.* from tmemply" 
            sSQL = sSQL & " left join tmworkgrp on tmemply.EMP_CODE = tmworkgrp.EMP_CODE "
            sSQL = sSQL & " left join tmshiftot on tmemply.EMP_CODE = tmshiftot.EMP_CODE "
            sSQL = sSQL & " left join tmclk2 on tmshiftot.EMP_CODE = tmclk2.EMP_CODE and  DT_SHIFT = DT_WORK"
            sSQL = sSQL & " where isnull(DT_RESIGN) "
            sSQL = sSQL & " and tmshiftot.SHF_CODE <> 'OFF' and tmshiftot.SHF_CODE <> 'REST' "  
            sSQL = sSQL & " and GENSHF = 'Y' "
            sSQL = sSQL & " and  (DT_SHIFT = '" & fdate2(dtAbsent) & "')  "
            sSQL = sSQL & " order by tmemply.EMP_CODE, DT_SHIFT desc"
            set rstTMABSENT = server.createobject("adodb.recordset")
            rstTMABSENT.Open sSQL, conn, 3, 3
            if not rstTMABSENT.eof then

                Do while not rstTMABSENT.eof
                    sHoliday = ""
                    sLeave = ""
        
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
                        sLeave = "Y"
                    end if
    
                    if isnull(rstTMABSENT("DT_WORK")) and sHoliday <> "Y" and sLeave <> "Y" then
           
                        sSQL = "select * from TMABSENT where EMP_CODE = '" & rstTMABSENT("EMPCODE") & "'"
                        sSQL = sSQL & " and DT_ABSENT = '" &  fdate2(dtAbsent) & "'"
                        set rstTMABS = server.CreateObject("ADODB.Recordset")
                        rstTMABS.open sSQL, conn, 3, 3
                        if rstTMABS.eof then  '=== To avoid duplicate records when process everytime, only insert if record doesn't exist
        
                            sSQL = "INSERT into TMABSENT (EMP_CODE,NAME,GRADE_ID,WORKGRP_ID,SHF_CODE,DT_ABSENT,"
                            sSQl = sSQL & " ATTENDANCE,TYPE,SUP_CODE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                            sSQL = sSQL & " values ("
                            sSQL = sSQL & "'" & rstTMABSENT("EMPCODE") & "',"
                            sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                            sSQL = sSQL & "'" & rstTMABSENT("GRADE_ID") & "',"
                            sSQL = sSQL & "'" & rstTMABSENT("WORKGRP_ID") & "',"
                            sSQL = sSQL & "'" & rstTMABSENT("SHFCODE") & "',"
                            sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                            sSQL = sSQL & "'Absent',"
                            sSQL = sSQL & "'F',"
                            sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                            sSQL = sSQL & "'" & fdate2(dtProcess) & "',"
                            sSQL = sSQL & "'SERVER'," 
                            sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                            sSQL = sSQL & "'SERVER'," 
                            sSQL = sSQL & "'" & fdatetime2(Now()) & "')"

                            conn.execute sSQL
        
                        end if
                    elseif not isnull(rstTMABSENT("DT_WORK")) and sHoliday <> "Y" and sLeave <> "Y" and rstTMABSENT("HALFDAY") = "Y" then
            
                            sSQL = "select * from TMABSENT where EMP_CODE = '" & rstTMABSENT("EMPCODE") & "'"
                            sSQL = sSQL & " and DT_ABSENT = '" &  fdate2(dtAbsent) & "'"
                            set rstTMABS = server.CreateObject("ADODB.Recordset")
                            rstTMABS.open sSQL, conn, 3, 3
                            if rstTMABS.eof then  '=== To avoid duplicate record
                                sSQL = "INSERT into TMABSENT (EMP_CODE,NAME,GRADE_ID,WORKGRP_ID,SHF_CODE,DT_ABSENT,"
                                sSQl = sSQL & " ATTENDANCE,TYPE,SUP_CODE,DTPROCESS,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                                sSQL = sSQL & " values ("
                                sSQL = sSQL & "'" & rstTMABSENT("EMPCODE") & "',"
                                sSQL = sSQL & "'" & pRTIN(rstTMABSENT("NAME")) & "',"
                                sSQL = sSQL & "'" & rstTMABSENT("GRADE_ID") & "',"
                                sSQL = sSQL & "'" & rstTMABSENT("WORKGRP_ID") & "',"
                                sSQL = sSQL & "'" & rstTMABSENT("SHFCODE") & "',"
                                sSQL = sSQL & "'" & fdate2(rstTMABSENT("DT_SHIFT")) & "',"
                                sSQL = sSQL & "'Absent',"
                                sSQL = sSQL & "'H',"
                                sSQL = sSQL & "'" & rstTMABSENT("SUP_CODE") & "',"
                                sSQL = sSQL & "'" & fdate2(dtProcess) & "',"
                                sSQL = sSQL & "'SERVER'," 
                                sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                sSQL = sSQL & "'SERVER'," 
                                sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                                conn.execute sSQL
                            end if

                    end if '=== end if not is null (DT_WORK)
                    rstTMABSENT.movenext
                loop
            end if '=== end if sSQL

        'end if '@@@@@@@@@@@@@@@@@@@@@@@@
   
        '===== Process the 3 days absents consecutively============================================================'
        '===== Depends on the above code to generate records into TMABSENT  
         
            dtAbsent3Fr = dtPayFrom
            dtAbsent3To = dtPayTo
            iAbsent = 0

   
            sSQL = " select tmshiftot.emp_code as EMPCODE,dt_shift, tmhol1.dt_hol, tmclk2.dt_work, tmabsent.dt_absent, "
            sSQL = sSQL & " tmshiftot.shf_code, tmworkgrp.hol_id, tmemply.NAME, tmemply.SUP_CODE, tmworkgrp.WORKGRP_ID "
            sSQL = sSQL & " from tmshiftot "
            sSQL = sSQL & " left join tmhol1 on dt_shift = dt_hol and tmshiftot.hol_id = tmhol1.hol_id "
            sSQL = sSQL & " left join tmclk2 on dt_shift = dt_work and tmshiftot.EMP_CODE = tmclk2.EMP_CODE"
            sSQL = sSQL & " left join tmabsent on dt_shift = dt_absent and tmshiftot.EMP_CODE = tmabsent.EMP_CODE "
            sSQL = sSQL & " left join tmemply on tmshiftot.EMP_CODE =tmemply.EMP_CODE "
            sSQL = sSQL & " left join tmworkgrp on tmshiftot.EMP_CODE = tmworkgrp.EMP_CODE "
            sSQL = sSQL & " where isnull(DT_RESIGN) "
            sSQL = sSQL & " and GENSHF = 'Y' "
            sSQL = sSQL & " and isnull(dt_hol) "
            sSQL = sSQL & " and tmshiftot.SHF_CODE <> 'OFF' and tmshiftot.SHF_CODE <> 'REST' "  
            sSQL = sSQL & " and DT_SHIFT between '" & fdate2(dtAbsent3Fr) & "' and '" & fdate2(dtAbsent3To) & "'" 
            'sSQL = sSQL & " and tmemply.EMP_CODE = '174996'" 
            sSQL = sSQL & " order by tmemply.EMP_CODE, DT_SHIFT asc"
            set rstTMABSENT3 = server.CreateObject("ADODB.Recordset")
            rstTMABSENT3.open sSQL, conn, 3, 3
            if not rstTMABSENT3.eof then
                
                Do while not rstTMABSENT3.eof

                    if sEmpCode <> rstTMABSENT3("EMPCODE") then '=== Begin record compare with last record, if change set iAbsent back to zero
                        iAbsent = 0
                    end if

    'response.write "<br> ********* " & sEmpCode & "<>"  & rstTMABSENT3("EMPCODE") & " ********* " & rstTMABSENT3("DT_SHIFT") & "=====iAbsent=== " & iAbsent & "<br>"        
                    
                    '===== Check if the Date is it an Absent date, if yes then increase the count by 1, else need to check
                    if not isNULL(rstTMABSENT3("DT_ABSENT")) then
                        
    'response.write "TMABSENT GOT RECORD" & sSQL & "<br>"

                        '=== Check if that day got MC or not    
                        sSQL = "select * from TMEOFF where EMP_CODE = '" & rstTMABSENT3("EMPCODE") & "'"
		                sSQL =  sSQL & " and '" & fdate2(rstTMABSENT3("DT_SHIFT")) & "'"  
		                sSQL =  sSQL & " between DTFR and DTTO "  
		                set rstTMEOFF = server.CreateObject("ADODB.Recordset")
		                rstTMEOFF.open sSQL, conn, 3, 3
                        if not rstTMEOFF.eof then
    'response.write "TMEOFF " &  sSQL & "<br>"  
                            iAbsent = 0
                        
                        else 
    'response.write " NO TIME OFF and GOT ABSENT" &  sSQL & "<br>"   
                            iAbsent = iAbsent + 1

    'response.write " The iAbsent : " & iAbsent
        
                            if iAbsent = 1 then '=== When the 1st Absent mark the dtFr date.
                                dtFr = rstTMABSENT3("DT_ABSENT")
                            end if 

                            if Cint(iAbsent) >= 3 then
        
    'response.write " It is more than three and will come in  " & iAbsent
        
                                dtTo = rstTMABSENT3("DT_ABSENT")

                                sSQL = "select * from TMABSENT3 where EMP_CODE = '" & rstTMABSENT3("EMPCODE") & "'"
                                sSQL = sSQL & " and DTFR = '" & fdate2(dtFr) & "'"
                                set rstTMAB3 = server.CreateObject("ADODB.Recordset")
		                        rstTMAB3.open sSQL, conn, 3, 3
                                if not rstTMAB3.eof then '=== Got same DT FR so only update the Duration or iAbsent
                                    sSQL = "UPDATE TMABSENT3 set " 
                                    sSQL = sSQL & "EMP_CODE = '" & sEmpCode & "',"
                                    sSQL = sSQL & "NAME = '" & pRTIN(rstTMABSENT3("NAME")) & "',"
                                    sSQL = sSQL & "WORKGRP_ID = '" & rstTMABSENT3("WORKGRP_ID") & "',"
                                    sSQL = sSQL & "SUP_CODE = '" & rstTMABSENT3("SUP_CODE") & "',"
                                    sSQL = sSQL & "DTTO = '" & fdate2(dtTo) & "',"
                                    sSQL = sSQL & "DURA = '" & iAbsent & "',"
                                    sSQL = sSQL & "USER_ID = 'SERVER'," 
                                    sSQL = sSQL & "DATETIME = '" & fdatetime2(Now()) & "'"
                                    sSQL = sSQL & " where EMP_CODE ='" & sEmpCode & "'"
                                    sSQL = sSQL & " and DTFR = '" & fdate2(dtFr) & "'"
                                    conn.execute sSQL
        
                                else '=== No record of new
                                    sSQL = "INSERT into TMABSENT3 (EMP_CODE,NAME,WORKGRP_ID,SUP_CODE,DTFR,DTTO,DURA,USER_ID,DATETIME,CREATE_ID,DT_CREATE)"
                                    sSQL = sSQL & " values ("
                                    sSQL = sSQL & "'" & sEmpCode & "',"
                                    sSQL = sSQL & "'" & pRTIN(rstTMABSENT3("NAME")) & "',"
                                    sSQL = sSQL & "'" & rstTMABSENT3("WORKGRP_ID") & "',"
                                    sSQL = sSQL & "'" & rstTMABSENT3("SUP_CODE") & "',"
                                    sSQL = sSQL & "'" & fdate2(dtFr) & "',"
                                    sSQL = sSQL & "'" & fdate2(dtTo) & "',"
                                    sSQL = sSQL & "'" & iAbsent & "',"
                                    sSQL = sSQL & "'SERVER'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                    sSQL = sSQL & "'SERVER'," 
                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "')"
                                    conn.execute sSQL
                                end if
                            end if '=== if Cint(iAbsent) >= 3
                        end if '=== if not rstTMEOFF.eof then
                    else '=== Not Absent means working
                    
                        iAbsent = 0
                        
                    end if '=== if not rstTMABST.eof then
                    
            'response.write "<br>"     
                    sEmpCode = rstTMABSENT3("EMPCODE") '==== Retain last record
                    
                    rstTMABSENT3.movenext
                loop 
            end if
           
            '=============Insert into TMLOG =====================
            sChangesM = " AUTO PROCESS completed on " & Now() & " Inserted EntryPass records for " & dtProcess
            sChangesM = sChangesM & " Processed  Abnormals and OTs on " & dtpCheckFr 
            sSQL = "insert into TMLOG (TYPE,CHANGESM,USER_ID,DATETIME) "
	        sSQL = sSQL & "values ("
            sSQL = sSQL & "'AUTOPROC',"
            sSQL = sSQL & "'" & sChangesM & "',"
            sSQL = sSQL & "'SERVER'," 
            sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
	        sSQL = sSQL & ") "
            conn.execute sSQL


            'end if ' if a = 1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

            response.write "<script language='javascript'>"
		    response.write "turnoff();"
		    response.write "</script>"
            
            if sEmp_Code <> "" then
                Call alertbox("Insert and Process completed for Employee " & sEmp_Code & "! Records on =" & dtProcess & " inserted, Abnormals and OTs from " & dtpCheckFr & " till " & dtProcess & " processed, Absences until " & dtpCheckFr & " processed " )    
            else
                Call alertbox("Insert and Process completed! Records on " & dtProcess & " inserted, Abnormals and OTs from " & dtpCheckFr & " till " & dtProcess & " processed, Absences until " & dtpCheckFr & " processed " )    
            end if

        end if '=== End if btnProcess <> ''
        
    %>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div id="loader-wrapper" style="display:none">
         <div id="loader"></div>
    </div>
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_tm.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Import and Process</h1>
            </section>
            <!-- Main content -->
            <section class="content" style="min-height:210px;padding-bottom:0px;">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <div class="box box-info">
                            <div class="box-body">
                                <div id="darkLayer" class="darkClass" style="display:none">                     
                                </div>
                                <form class="form-horizontal" action="tmimport.asp" enctype="multipart/form-data" method="post" name="form1">
                                    <div class="form-group">
                                        <div class="col-sm-5">
                                            <h4><b><i>Step 1: Import from File</i></b></h4>
                                        </div>
                                    </div>
                                    <div class="form-group" style="margin-bottom: 4px">
                                        <label class="col-sm-3 control-label">File Name : </label>
                                        <div class="col-sm-7" style="padding-top: 7px">
                                            <input type="FILE" name="txtFile" size="60" accept="text/plain">
                                            <!-- <input type="FILE" id="txtFile" name="txtFile" class="inputfile inputfile-1" data-multiple-caption="{count} files selected" multiple>
                                           <label for="txtFile"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> <span>Choose a file&hellip;</span></label>-->
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-7" style="padding-top: 7px">
                                            <input type="SUBMIT" name="cmdSubmit" value="Submit" style="width: 90px; margin-right: 10px" onclick="this.style.display = 'none';">
                                            <input type="button" value="Cancel" style="width: 90px" onclick="window.location = ('tmimport.asp')">
                                        </div>
                                    </div>
                                </form>
                                <div class="form-group">
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-7" style="padding-left: 7px">
                                        <%
                                            set o = new clsUpload
                                            if o.Exists("cmdSubmit") then

                                                'get client file name
                                                sFile = o.FileNameOf("txtFile") 
                                            response.write sFile
                                                o.FileFullPath = Server.MapPath(".") & "\Database\attendanceData\ManuallyImportNProcess\" & sFileSaved
                                                o.save
                                                'Create the File System Ojbect
'Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

'Get the Absolute Path of the current directory
'szCurrentRoot = objFSO.GetParentFolderName(Server.MapPath(Request.ServerVariables("URL")))

'Print to the screen.
'Response.Write szCurrentRoot
                                                response.write request("txtFile")
                                            
                                                response.write "please got soemhing come out " & o.FileNameOf("txtFile") & "<br>"
                                                response.end

                                                

                                                dtsnow = Now()        
                                                dd = Right("00" & Day(dtsnow), 2)
                                                mm = Right("00" & Month(dtsnow), 2)
                                                yy = Year(dtsnow)
                                                hh = Right("00" & Hour(dtsnow), 2)
                                                nn = Right("00" & Minute(dtsnow), 2)
                                                ss = Right("00" & Second(dtsnow), 2)
                                                
                                                '=== sFile=Data20180224.txt
                                                a = Split(sFile,".")
                                                '=== a = [Data20180224, txt]

                                                sDtProcess = Trim(Mid(a(0),5,8))
                                                sDtProcess = Mid(sDtProcess,7,2) & "/" & Mid(sDtProcess,5,2) & "/" & Mid(sDtProcess,1,4)
                                                
                                                dtpDtProcess = CDate(sDTProcess) '==== For use on javascript dates
                                                dtpDtAbnormNOT = DateAdd("d",-1,dtpDTProcess) '=== For use on javascript dates
                                                
                                                '==== The File Name 20180302_094524Data20180224.OLD
                                                sFileSaved = yy & mm & dd & "_" & hh & nn & ss & a(0) & ".OLD"

                                                '==== Save into savedtmclk1file
                                                o.FileInputName = "txtFile"
                                                o.FileFullPath = Server.MapPath(".") & "\Database\attendanceData\ManuallyImportNProcess\" & sFileSaved
                                                o.save
                                                
                                                strFileName = "Database\attendanceData\ManuallyImportNProcess\" & sFileSaved
        
                                                Set fso = Server.CreateObject("Scripting.FileSystemObject") 
                                                set fs = fso.OpenTextFile(Server.MapPath(strFileName), 1, true) 
                                                if not fs.AtEndOfStream then
                                                    Do while not fs.AtEndOfStream 
                                                        
                                                        strRow = fs.ReadLine
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
                                                                    sHour = Mid(strRow, 1, iColonPos -1)
                                
                                                                    sMin = Mid(strRow, iColonPos + 1, 2)
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
                                                                sCode = Trim(Mid(strRow, 1, iPos - 1))
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
                      
                                    'response.write " ----@@---- : " & sDate & "," & sHour & "," & sMin & "," & sValid & "," & sCode & "," & sName & "," & sInOut & "<br>"    
                                         
                                                            if sValid = "Valid" then 
                            
                                                                Set rstTMClk1 = server.CreateObject("ADODB.RecordSet")    '=== Transfer from file to TMCLK1
                                                                sSQL = "select * from TMCLK1 where CODE ='" & sCode & "'" 
                                                                sSQL = sSQL & " and DT_WORK = '" & fdate2(sDate) & "'"
                                                                sSQL = sSQL & " and HOUR = '" & sHour & "'"
                                                                sSQL = sSQL & " and MIN = '" & sMin & "'" 
                                                                rstTMClk1.Open sSQL, conn, 3, 3
                                                                if rstTMClk1.eof then '=== To avoid duplicates
                                                                    sSQL = "insert into TMCLK1 (DT_WORK,HOUR,MIN,CODE,NAME,IN_OUT,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
		                                                            sSQL = sSQL & "values ("
		                                                            sSQL = sSQL & "'" & fdate2(sDate) & "',"		
		                                                            sSQL = sSQL & "'" & sHour & "',"
		                                                            sSQL = sSQL & "'" & sMin & "',"
		                                                            sSQL = sSQL & "'" & sCode & "',"
	                                                                sSQL = sSQL & "'" & pRTIN(sName) & "',"
                                                                    sSQL = sSQL & "'" & sInOut & "',"
                                                                    sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "',"
                                                                    sSQL = sSQL & "'" & session("USERNAME") & "'," 
                                                                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		                                                            sSQL = sSQL & ") "
                                                                    conn.execute sSQL
                                                                end if
                                                                pCloseTables(rstTMClk1)
                                                            end if '=== End if sValid = "Valid"
                                                        end if '==== End if strRow and isDate(sDate)
                                                    Loop
                                                end if '=== End if not fs.AtEndOfStream
                                                pCloseTables(fs)
                                       
                                                if o.Error = "" then

                                                    '===== After inserting into TMCLK1 MOVE the Attenance Data to LOG
                                                    sFileFrom = Server.MapPath(".") &  "\DATABASE\ATTENDANCEDATA\" & sFile
         
                                                    sFileTo = Server.MapPath(".") & "\DATABASE\ATTENDANCEDATA\LOG\"
        
                                                    set fsm=Server.CreateObject("Scripting.FileSystemObject")
                                                    fsm.CopyFile sFileFrom , sFileTo
                                                    fsm.DeleteFile(sFileFrom)
                                                    set fsm=nothing
                                                    '==================================================================

		                                            response.write "Success. File saved to  " & o.FileFullPath 
		                                            response.write "<script language='javascript'>"
		                                            response.write "dimOn();"
		                                            response.write "</script>"
		                                            sFL = replace(sFile,".txt","")
		                                        else
                                                     call alertBox( o.Error & "Data File is not at the correct location path " )
		                                            'response.write "Failed due to the following error: " & o.Error 
	                                            end if

                                            end if
                                            set o = nothing
                                        %>
                                    </div>
                                    <!-- class col-sm-7-->
                                </div>
                                <!--form-group-->
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        
   
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <div class="box box-info">
                            <div class="box-body">
                                <!--<div id="darkLayerproc" class="darkClass" style="display:none">                     
                                </div>-->
                                <form class="form-horizontal" action="tmimport.asp" method="post" name="form2" id="form2">
                                    <div class="form-group">
                                        <div class="col-sm-5">
                                            <h4><b><i>Step 2: Process</i></b></h4>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Date of Records : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtpFrDate" name="dtpFrDate" type="text" value='<%=fdatelong(dtpFrDate)%>' class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="javascript:void(0);" id="btndtpFrDate" class="btn btn-default">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Process Abnormals and OTs from : </label>
                                        <div class="col-sm-2" style="width:10.66667%">
											<span class="mod-form-control" id="dtpFromDate"></span>
                                        </div>
                                        <label class="col-sm-1 control-label" style="width:4%">To</label>
                                        <div class="col-sm-2" style="width:10.66667%">
											<span class="mod-form-control" id="dtpToDate" ></span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 col-lg-3 control-label">Process Absences until : </label>
                                        <div class="col-sm-6 col-lg-6">
                                            <div class="input-group">
                                                <span id="dtpProcessAb" class="mod-form-control" style="text-align:center;"></span>
                                            </div>
                                        </div>
                                    </div>
                                     <div class="form-group">
                                        <label class="col-sm-3 col-lg-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input class="form-control" id="txtID" name="txtID" value="" maxlength="10" style="text-transform: uppercase" placeholder="All">
                                                <span class="input-group-btn">
                                                    <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default"
                                                        onclick = "fOpen('EMP','mycontent','#mymodal')">
                                                        <i class="fa fa-search"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-7">
                                            <input type="SUBMIT" name="btnProcess" value="Process" style="width: 90px; margin-right: 10px" onclick="turnon();">
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <!-- box body-->
                        </div>
                        <!-- box info -->
                    </div>
                    <!--col-sm-12-->
                </div>
                <!-- row -->
                <div class="modal fade bd-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                            </div>
                            <div id="mycontent">
                                <!--- Content ---->
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->
        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <script src="plugins/input-mask/jquery.mask.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
    <!-- JQuery for the Choose a file label -->
    <script src="plugins/Custom/custom-file-input.js"></script>

    <script>

    //=== This is diasble enter key to post back
    $('#form2').on('keyup keypress', function(e) {
      var keyCode = e.keyCode || e.which;
      if (keyCode === 13) { 
        e.preventDefault();
        return false;
      }
    });


    $(document).ready(function(){
      $('[date-picker]').mask('00/00/0000');
    });

    
    $("#dtpFrDate").datepicker(
        {   changeMonth: true,
            changeYear: true,
            format: "dd/mm/yyyy",
            autoclose: true,
        
        });

    <%if sDtProcess = "" then %>
        var todayDate = new Date();
        $("#dtpFrDate").datepicker("setDate" , todayDate);
        document.getElementById('dtpToDate').innerHTML = todayDate.toLocaleDateString('en-GB');
        
        todayDate.setDate(todayDate.getDate() - 1);
        document.getElementById('dtpFromDate').innerHTML = todayDate.toLocaleDateString('en-GB');
        document.getElementById('dtpProcessAb').innerHTML = todayDate.toLocaleDateString('en-GB');
    <%else %>
        var todayDate = '<%=dtpDtProcess%>';
        $("#dtpFrDate").datepicker("setDate" , todayDate);
        document.getElementById('dtpToDate').innerHTML = todayDate;

        var processDate = '<%=dtpDtAbnormNOT%>';
        document.getElementById('dtpFromDate').innerHTML = processDate;
        document.getElementById('dtpProcessAb').innerHTML = processDate;
        
    <%end if %>
    
    $('#dtpFrDate').change(function() {
        
        var date2 = $('#dtpFrDate').datepicker('getDate'); 
        document.getElementById('dtpToDate').innerHTML = date2.toLocaleDateString('en-GB');

        date2.setDate(date2.getDate() -1); 
        document.getElementById('dtpFromDate').innerHTML = date2.toLocaleDateString('en-GB');
        document.getElementById('dtpProcessAb').innerHTML = date2.toLocaleDateString('en-GB');
    });

    
    $('#btndtpFrDate').click(function () {
        $('#dtpFrDate').datepicker("show");
        });

    function fOpen(pType,pContent,pModal) {
        showDetails('page=1',pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }

    function showDetails(str,pType,pContent){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

        var search = document.getElementById("txtSearch");
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }

  	    xhttp.open("GET", "ajax/ax_view_tmempid.asp?"+str, true);
  	    xhttp.send();
        
    }

    function turnon(){
         document.getElementById("loader-wrapper").style.display = "";
    }

    $( "#txtID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=EC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtID").val(ui.item.value);
				var str = document.getElementById("txtID").value;
				var res = str.split(" - ");
				document.getElementById("txtID").value = res[0];
			},0);
		}
	});

    </script>
</body>
</html>
