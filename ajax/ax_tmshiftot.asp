<!DOCTYPE html>
<html>
<head>
    <title></title>
    <!-- #include file="../include/connection.asp" -->
    <!-- #include file="../include/proc.asp" -->
    <!-- #include file="../include/option.asp" -->
    <!-- #include file="../include/adovbs.inc" -->
    <!-- #include file="../include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <style>
        .td{
            padding:5px;
        }

    </style>
</head>
<body>
<div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
    
    <table id="example1" class="table table-bordered table-striped">
    
        <thead>
            <%
                sURL = "&page=" & PageNo & "&txtEMP_CODE=" & sEMP_CODE
                sEMP_CODE = request("txtEMP_CODE")
                sBegMonth = CInt(request("txtMonth"))
                sBegYear = CInt(request("txtYear"))
                sEndMonth = CInt(sBegMonth) + 12
                sStrFrMth = sBegMonth
                sStrFrYr = sBegYear

                Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMEMPLY where EMP_CODE='" & sEMP_CODE & "'" 
                rstTMEMPLY.Open sSQL, conn, 3, 3
                if rstTMEMPLY.eof then
                    call alertbox("Employee Code: " & sEMP_CODE & " does not exist !")
			    End if  
                pCloseTables(rstTMEMPLY)

                if sEMP_CODE <> "" then

                    response.write "<tr>"
                        response.write "<th>Month</th>"
                        For i = 1 to 31
                            if i < 10 then
                                i = "0" & i
                            end if
                            response.write "<th style='text-align:center'>" & i & "</th>"
                        next
                   response.write "<tr>"     
            %>             
        </thead>
         <tbody>
            <%      
                    

                    do while sBegMonth <=sEndMonth
                    
                        sMonth = sBegMonth
                        sYear = sBegYear
                        if sMonth > 12 then
                            sMonth = sBegMonth mod 12
                            if sMonth = 0 then
                                sMonth = 12
                            end if 
                            sYear = sBegYear + 1
                        end if                        
         
                        response.write "<tr>"
                        response.write "<td>" & MonthName(sMonth,True) & "</td>"
                        
                            For j = 1 to 31
                            
                                sDate = j & "/" & sMonth & "/" & sYear
                                
                                if IsDate(sDate) then 'Check if the date is valid
                                    Set rstTMSHIFTOT = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMSHIFTOT where DT_SHIFT ='" & fdate2(sDate) & "'" 
                                    sSQL = sSQL & " and EMP_CODE='" & Ucase(sEMP_CODE) & "'"
                                    rstTMSHIFTOT.Open sSQL, conn, 3, 3
                                    if not rstTMSHIFTOT.eof then
                                        Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                                        sSQL = "select * from TMSHFCODE where SHF_CODE ='" & rstTMSHIFTOT("SHF_CODE") & "'" 
                                        rstTMSHFCODE.Open sSQL, conn, 3, 3
                                        if not rstTMSHFCODE.eof then
                                            bgcolor = rstTMSHFCODE("COLOR")
                                            textcolor = hex2rgb(bgcolor)
                                        
                                        response.write "<td bgcolor='" & bgcolor & "'><a style='color:" & textcolor & ";display:block;text-align:center' href='tmshiftot_det.asp?Page="& PageNo & "&txtEMP_CODE="& sEMP_CODE & "&txtdt_Shift=" & fdatelong(sDate) & "&bUpdate=Y&txtMonth=" & sStrFrMth & "&txtYear=" & sStrFrYr & "' >" & rstTMSHIFTOT("SHF_CODE") & "</a></td>"
                                        
                                        end if
                                    else                             
                                    
                                        if weekday(sDate, 1) = 1 then 'Check if it is Sunday
                                            response.write "<td bgcolor='#F08080' style='border:1px solid #f08080;'><a style='display:block;' href='tmshiftot_det.asp?Page="& PageNo & "&txtEMP_CODE="& sEMP_CODE & "&txtdt_Shift=" & fdatelong(sDate) & "&txtMonth=" & sStrFrMth & "&txtYear=" & sStrFrYr & "'>&nbsp;</a></td>"    
                                            'response.write "<td bgcolor='#F08080'><a href='#' style='display:block;' data-toggle=""modal"" data-target=""#modal-shiftotentry"" data-EMP_CODE=" & sYear & " data-sdate=" & sDate & ">&nbsp;</a></td>"
                                        else
                                           response.write "<td><a style='display:block;' href='tmshiftot_det.asp?Page="& PageNo & "&txtEMP_CODE="& sEMP_CODE & "&txtdt_Shift=" & fdatelong(sDate) & "&txtMonth=" & sStrFrMth & "&txtYear=" & sStrFrYr & "'>&nbsp;</a></td>"
                                           'response.write "<td><a href='#' style='display:block;' data-toggle=""modal"" data-target=""#modal-shiftotentry"" data-EMP_CODE=" & sYear & " data-sdate=" & sDate & ">&nbsp;</a></td>"
                                        end if
                                    end if
                                end if    
                             next
                            response.write "</tr>"

                    sBegMonth = sBegMonth + 1 

                    loop
 
              end if '=== End if sEMP_CODE <> ""
            %>                     
        </tbody>
    </table>
</div>
</body>
</html>