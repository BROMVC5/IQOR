<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
    Response.ContentType = "application/json"	
	Server.ScriptTimeout = 1000000
	
    sWhat = request("txtWhat")
    sID = request("txtID")

    'response.write "{ ""data"": { ""status"": "" pwhat " & sWhat & " The EmpCode : " & request("txtEmpCode") & " The Dt : " & request("dtShift") & " "" } }"
    'response.end

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
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Card No cannot be empty"" } }"
            response.end
        else
            Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMEMPLY where CARDNO='" & sID & "'"
            sSQL = sSQL & " and isnull(DT_RESIGN)"  
            rstTMEMPLY.Open sSQL, conn, 3, 3
            if not rstTMEMPLY.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Punch No  : " & UCase(sID) & " already exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "AType" then
        
        sID = request("selID")
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Please select an Access Type. "" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if
   
    elseif sWhat = "Grade_ID" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Grade Code cannot be empty"" } }"
            response.end
        else
            Set rstTMGRADE = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMGRADE where GRADE_ID='" & sID & "'" 
            rstTMGRADE.Open sSQL, conn, 3, 3
            if rstTMGRADE.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Grade Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "Sup_CODE" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Superior Code cannot be empty"" } }"
            response.end
        else
            Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMEMPLY where EMP_CODE='" & sID & "'" 
            rstTMEMPLY.Open sSQL, conn, 3, 3
            if rstTMEMPLY.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Superior Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "Dept_ID" then
        
        if sID = "" then
            'response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Department Code cannot be empty"" } }"
            'response.end
        else
            Set rstTMDEPT = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMDEPT where DEPT_ID='" & sID & "'" 
            rstTMDEPT.Open sSQL, conn, 3, 3
            if rstTMDEPT.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Department Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "Cost_ID" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Cost Center cannot be empty"" } }"
            response.end
        else
            Set rstTMCOST = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMCOST where COST_ID='" & sID & "'" 
            rstTMCOST.Open sSQL, conn, 3, 3
            if rstTMCOST.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Cost Center : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "Cont_ID" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Employment Contract Code cannot be empty"" } }"
            response.end
        else
            Set rstTMCONT = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMCONT where CONT_ID='" & sID & "'" 
            rstTMCONT.Open sSQL, conn, 3, 3
            if rstTMCONT.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Employment Contract Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "Work_ID" then

        if sID = "" then
            'response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Work Location cannot be empty"" } }"
            'response.end
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

     elseif sWhat = "AreaCode" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Area Code cannot be empty"" } }"
            response.end
        else
            Set rstTMWORK = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TSAREA where AREACODE='" & sID & "'" 
            rstTMWORK.Open sSQL, conn, 3, 3
            if rstTMWORK.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Area Code: " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "GenShf" then
        
        sID = request("selID")
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Please select an Generate Shift. "" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

     elseif sWhat = "OwnTrans" then
        
        sID = request("selID")
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Please select Own Transport. "" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "Hol_ID" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Holiday Group cannot be empty"" } }"
            response.end
        else
            Set rstTMHOL = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMHOL1 where HOL_ID='" & sID & "'" 
            rstTMHOL.Open sSQL, conn, 3, 3
            if rstTMHOL.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Holiday Group : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "Design_ID" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Designation cannot be empty"" } }"
            response.end
        else
            Set rstTMDESIGN = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMDESIGN where DESIGN_ID='" & sID & "'" 
            rstTMDESIGN.Open sSQL, conn, 3, 3
            if rstTMDESIGN.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Designation : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "TOFF" then
        
        Set rstTMTIMEOFF = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from TMTIMEOFF where TOFF_ID='" & sID & "'" 
        rstTMTIMEOFF.Open sSQL, conn, 3, 3
        if rstTMTIMEOFF.eof then
            response.write "{ ""data"": { ""status"": ""notexist"",""value"":""Time Off Code " & UCase(sID) & " does not exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "USER" then
        
        Set rstBROPASS = server.CreateObject("ADODB.RecordSet")    
        sSQL = "select * from BROPASS where ID='" & sID & "'" 
        rstBROPASS.Open sSQL, conn, 3, 3
        if rstBROPASS.eof then
            response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Copy Access Permission ID : " & UCase(sID) & " does not exist"" } }"
            response.end
        else
            response.write "{ ""data"": { ""status"": ""OK"" } }"
            response.end
        end if

    elseif sWhat = "EMP" then
        
        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Employee Code cannot be empty"" } }"
            response.end
        else
            Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMEMPLY where EMP_CODE='" & sID & "'" 
            rstTMEMPLY.Open sSQL, conn, 3, 3
            if rstTMEMPLY.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Employee Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "dt_Shift" then
    
        sEmpCode = request("txtEmpCode")
        sID = request("dtShift")

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Shift Date cannot be empty"" } }"
            response.end
        else
            Set rstSHIFTOT = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMSHIFTOT where EMP_CODE='" & sEmpCode & "'" 
            sSQL = sSQL & " and DT_SHIFT='" & fdate2(sID) & "'"
            rstSHIFTOT.Open sSQL, conn, 3, 3
            if not rstSHIFTOT.eof then
                response.write "{ ""data"": { ""status"": ""exist"" ,""value"":""Shift Date : " & UCase(sID) & " already exist"" } }"
                response.end
            Else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "SHF_CODE" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Shift Code cannot be empty"" } }"
            response.end
        else
            Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMSHFCODE where SHF_CODE='" & sID & "'" 
            rstTMSHFCODE.Open sSQL, conn, 3, 3
            if rstTMSHFCODE.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Shift Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "EMAIL" then

        if sID = "" then
            response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Employee Code cannot be empty"" } }"
            response.end
        else
            Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select EMAIL from TMEMPLY where EMP_CODE='" & sID & "'" 
            rstTMEMPLY.Open sSQL, conn, 3, 3
            if rstTMEMPLY.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Employee Code : " & UCase(sID) & " does not exist"" } }"
                response.end
            elseif rstTMEMPLY("EMAIL") = "" then 
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":"" " &  UCase(sID) & ", Your email address does not exist, please contact Administrator!"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if

    elseif sWhat = "NATION" then
        if sID = "" then
            'response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Employee Code cannot be empty"" } }"
            'response.end
        else
            Set rstTMNATION = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMNATION where NATION='" & sID & "'" 
            rstTMNATION.Open sSQL, conn, 3, 3
            if rstTMNATION.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Nationalilty : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if
    elseif sWhat = "RELIG" then
        if sID = "" then
            'response.write "{ ""data"": { ""status"": ""empty"" ,""value"":""Employee Code cannot be empty"" } }"
            'response.end
        else
            Set rstrstRELIG = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMRELIG where RELIG='" & sID & "'" 
            rstrstRELIG.Open sSQL, conn, 3, 3
            if rstrstRELIG.eof then
                response.write "{ ""data"": { ""status"": ""notexist"" ,""value"":""Religion : " & UCase(sID) & " does not exist"" } }"
                response.end
            else
                response.write "{ ""data"": { ""status"": ""OK"" } }"
                response.end
            end if
        end if
      
    end if
%>


