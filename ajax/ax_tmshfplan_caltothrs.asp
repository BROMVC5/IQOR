<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
    Response.ContentType = "application/json"	
	Server.ScriptTimeout = 1000000
	
	sShfPatID = request("txtShfPat_ID")
   
    For wrkweek = 1 to 6 

    sWrkWeekPat = "txtColValue" & wrkweek
  
        if (isnumeric(request("" & sWrkWeekPat & "" ) ) and (request("" & sWrkWeekPat & "" ) <>"")) then 

            Set rstTMSHFPAT = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMSHFPAT where SHFPAT_ID ='" & sShfPatID & "'"
            sSQL = sSQL & " and PATTERN ='" & request("" & sWrkWeekPat & "" ) & "'" 
            rstTMSHFPAT.Open sSQL, conn, 3, 3
            if not rstTMSHFPAT.eof then    
                For wrkday = 1 to 7 
                    variable = "DAY_" & wrkday    
                    Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select SHFLEN from TMSHFCODE where SHF_CODE ='" & rstTMSHFPAT("" & variable & "") & "'"
                    rstTMSHFCODE.Open sSQL, conn, 3, 3
                    if not rstTMSHFCODE.eof then
                        sTotHrsH =  Mid(rstTMSHFCODE("SHFLEN"),1,2)
                        sTotHrsM =  Mid(rstTMSHFCODE("SHFLEN"),4,2)
                        if sTotHrsH <> "" then
                            iTotHrsMins = Cint(sTotHrsH)*60 + Cint(sTotHrsM)
                        else
                            iTotHrsMins = 0
                        end if
                        
                        iTotHrs = iTotHrs + iTotHrsMins
  
                    end if 
                next
            end if
        end if
    next

    sTotalHrsH = Fix(Cint(iTotHrs) / 60)
    if sTotalHrsH < 10 then
        sTotalHrsH = "0" & sTotalHrsH
    end if

    sTotalHrsM = Cint(iTotHrs) mod 60
    if sTotalHrsM < 10 then
        sTOtalHrsM = "0" & sTotalHrsM
    end if
                
    sTotalHrs = sTotalHrsH & ":" & sTotalHrsM  
    
    response.write "{ ""data"": { ""status"": ""ok"", ""value"":""" & sTotalHrs & """ } }"
    response.end
%>


