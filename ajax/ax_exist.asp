<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
    Response.ContentType = "application/json"	
	Server.ScriptTimeout = 1000000
	
    sWhat = request("txtWhat")
    sID = request("txtID")
    
    if sWhat = "ID" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Employment Code cannot be empty"" } }"
            response.end
        else
            Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMEMPLY where EMP_CODE='" & sID & "'" 
            rstTMEMPLY.Open sSQL, conn, 3, 3
            if not rstTMEMPLY.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Employee Code : " & UCase(sID) & " already exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "CardNo" then
        
        Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMEMPLY where CARDNO='" & sID & "'" 
        rstTMEMPLY.Open sSQL, conn, 3, 3
        if not rstTMEMPLY.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Punch No  : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    'elseif sWhat = "AType" then
      '  sAType = request("selAType")
     '   if sID = "" then
       '     response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Please select Access Type"" } }"
        '    response.end
        'end if
    elseif sWhat = "HOL" then
        
        Set rstTMHOL = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMHOL where DT_HOL='" & fdate2(sID) & "'" 
        rstTMHOL.Open sSQL, conn, 3, 3
        if not rstTMHOL.eof then
            response.write "{ ""data"": { ""status"": ""exist"",""value"":""Holiday Date : " & fdatelong(sID) & " already exist!"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        End if  
        pCloseTables(rstTMHOL)

    elseif sWhat = "HOLC" then
        
        Set rstTMHOL1 = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMHOL1 where HOL_ID='" & sID & "'" 
        rstTMHOL1.Open sSQL, conn, 3, 3
        if not rstTMHOL1.eof then
            response.write "{ ""data"": { ""status"": ""exist"",""value"":""Holiday Group Code : " & UCase(sID) & " already exist!"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        End if  
        pCloseTables(rstTMHOL1)

    elseif sWhat = "DEP" then
        
        Set rstTMDEPT = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMDEPT where DEPT_ID ='" & sID & "'" 
        rstTMDEPT.Open sSQL, conn, 3, 3
        if not rstTMDEPT.eof then
            response.write "{ ""data"": { ""status"": ""exist"",""value"":""Department ID : " & UCase(sID) & " already exist!"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        End if  
        pCloseTables(rstTMDEPT)

    elseif sWhat = "DESIGN" then
        
        Set rstTMDESIGN = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMDESIGN where DESIGN_ID ='" & sID & "'" 
        rstTMDESIGN.Open sSQL, conn, 3, 3
        if not rstTMDESIGN.eof then
            response.write "{ ""data"": { ""status"": ""exist"",""value"":""Designation ID : " & UCase(sID) & " already exist!"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        End if  
        pCloseTables(rstTMDESIGN)

    elseif sWhat = "TOFF" then

        Set rstTMTIMEOFF = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMTIMEOFF where TOFF_ID='" & sID & "'" 
        rstTMTIMEOFF.Open sSQL, conn, 3, 3
        if not rstTMTIMEOFF.eof then
            response.write "{ ""data"": { ""status"": ""exist"",""value"":""Time Off Code " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "USER" then
        Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from BROPASS where ID='" & sID & "'" 
        rstTMEMPLY.Open sSQL, conn, 3, 3
        if not rstTMEMPLY.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""User ID : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "ALLOW" then
        Set rstTMALLOW = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMALLOW where ALLCODE='" & sID & "'" 
        rstTMALLOW.Open sSQL, conn, 3, 3
        if not rstTMALLOW.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Allowance Code : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "GRADE" then
        Set rstTMGrade = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMGRADE where GRADE_ID ='" & sID & "'" 
        rstTMGrade.Open sSQL, conn, 3, 3
        if not rstTMGrade.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Grade Code : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "CONT" then
        Set rstTMCont = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMCONT where CONT_ID ='" & sID & "'" 
        rstTMCont.Open sSQL, conn, 3, 3
        if not rstTMCont.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Contract Code : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "WORK" then
        Set rstTMWork = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMWORK where WORK_ID ='" & sID & "'" 
        rstTMWork.Open sSQL, conn, 3, 3
        if not rstTMWork.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Work Location : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if
    '======= For TMWORKGRP =====
    elseif sWhat = "WORKGRP" then
        sHolID = request("txtHolID") 

        Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMWORKGRP where WORKGRP_ID ='" & sID & "'" 
        rstTMWorkGrp.Open sSQL, conn, 3, 3
        if not rstTMWorkGrp.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Work Group : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            Set rstTMHOL1 = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMHOL1 where HOL_ID='" & sHolID & "'" 
            rstTMHOL1.Open sSQL, conn, 3, 3
            if rstTMHOL1.eof then
                response.write "{ ""data"": { ""status"": ""notexist"",""value"":""Holiday Group Code : " & UCase(sHolID) & " does not exist!"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            End if  
            pCloseTables(rstTMHOL1)
        end if 

    elseif sWhat = "COST" then
        Set rstTMCost = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMCOST where COST_ID ='" & sID & "'" 
        rstTMCost.Open sSQL, conn, 3, 3
        if not rstTMCost.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Cost Center Code : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "OTCODE" then
        Set rstTMOTCODE = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMOTCODE where OTCODE ='" & sID & "'" 
        rstTMOTCODE.Open sSQL, conn, 3, 3
        if not rstTMOTCODE.eof then
            response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""OT Code : " & UCase(sID) & " already exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if
    '==== This is for Department maintenance ===== 
    elseif sWhat = "Dept_ID" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Department Code cannot be empty"" } }"
            response.end
        else
            Set rstTMDEPT = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMDEPT where DEPT_ID='" & sID & "'" 
            rstTMDEPT.Open sSQL, conn, 3, 3
            if not rstTMDEPT.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Department Code : " & UCase(sID) & " already exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "DepManCode" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Department Manager Code cannot be empty"" } }"
            response.end
        else
            Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMEMPLY where EMP_CODE='" & sID & "'" 
            rstTMEMPLY.Open sSQL, conn, 3, 3
            if rstTMEMPLY.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Department Manager Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if
     '==== This is for Cost Center maintenance ===== 
    elseif sWhat = "Cost_ID" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Cost Center Code cannot be empty"" } }"
            response.end
        else
            Set rstTMDEPT = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMCOST where COST_ID='" & sID & "'" 
            rstTMDEPT.Open sSQL, conn, 3, 3
            if not rstTMDEPT.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Cost Center Code : " & UCase(sID) & " already exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "CostManCode" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Cost Center Manager Code cannot be empty"" } }"
            response.end
        else
            Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMEMPLY where EMP_CODE='" & sID & "'" 
            rstTMEMPLY.Open sSQL, conn, 3, 3
            if rstTMEMPLY.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Cost Center Manager Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if
    '==== This is Shift Code detail
     elseif sWhat = "Shf_Code" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Shift Code cannot be empty"" } }"
            response.end
        else
            Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMSHFCODE where SHF_CODE='" & sID & "'" 
            rstTMSHFCODE.Open sSQL, conn, 3, 3
            if not rstTMSHFCODE.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Shift Code : " & UCase(sID) & " already exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "Work_ID" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Work Location cannot be empty"" } }"
            response.end
        else
            Set rstTMWORK = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMWORK where WORK_ID='" & sID & "'" 
            rstTMWORK.Open sSQL, conn, 3, 3
            if rstTMWORK.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Work Location : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "RELIG" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Religion cannot be empty"" } }"
            response.end
        else
            Set rstTMRELIG = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMRELIG where RELIG='" & sID & "'" 
            rstTMRELIG.Open sSQL, conn, 3, 3
            if not rstTMRELIG.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":"" Religion : " & UCase(sID) & " already exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "NATION" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Nationality cannot be empty"" } }"
            response.end
        else
            Set rstTMNATION = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMNATION where NATION='" & sID & "'" 
            rstTMNATION.Open sSQL, conn, 3, 3
            if not rstTMNATION.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":"" Nationality : " & UCase(sID) & " already exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if
    end if
%>


