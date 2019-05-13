<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
                                        
iRecCount =2
sSHFPLAN_ID = request("txtSHFPLAN_ID")
sPart = request("txtPart")
sSHFPAT_ID = request("txtSHFPAT_ID")
sRow = request("txtRow")
sCol = request("txtCol")
bEdit = request("Edit")

  if sSHFPLAN_ID <> "" then
    sID = sSHFPLAN_ID
  else
    sID = reqFormU("txtID")
  end if  

  if reqForm("btnSave") <> "" then
       
        sPART = reqForm("txtPart")
        sShfPat_ID = reqFormU("txtShfPat_ID")
        sRow = reqForm("txtRow")
        sCol = reqForm("txtCol")

        sMainURL = "../tmshfplan.asp?"
        sMainURL2 = "../tmshfplan_det.asp?"
        sAddURL = "txtSHFPLAN_ID=" & sID & "&txtPart=" & sPART & "&txtShfPat_ID=" & sShfPat_ID & "&txtRow=" & sRow & "&txtCol=" &sCol

        Set rs = server.CreateObject("ADODB.RecordSet")
        sSQL = "select * from TMSHFPLAN where SHFPLAN_ID ='" & sID & "'" 
        rs.Open sSQL, conn, 3, 3         
        if not rs.eof then
            call alertbox("Shift Plan: " & sID & " already exist !")    
        end if

        '====Checking before insert records
        i=0
        bInsert="Y"
        do while not i >= Cint(sROW)
            
            sWorkGrp_ID = reqFormU("selWorkGrp" & i)
            if sWorkGrp_ID = "" then
                call confirmbox1("You did not select one of the Workgroup!",sMainURL2&sAddURL)
                bInsert= "N"
            end if
                For m = 1 to Cint(sCol)
                    sShfPat = reqForm("selShfPat" & i & "_" & (m+2))
                    if sShfPat = "" then
                        call confirmbox1("You did not select one of the Pattern!",sMainURL2&sAddURL)
                        bInsert= "N"
                    end if
                Next
            i=i+1
        loop

        '===Inserting records
        if bInsert = "Y" then 
            i=0
            do while not i >= Cint(sROW)
            
                sWorkGrp_ID = reqFormU("selWorkGrp" & i )
                sTotalHrs = reqForm("txtTotHours" & i)
   
                sSQL = "insert into TMSHFPLAN (SHFPLAN_ID,PART,SHFPAT_ID,ROW,COL,WORKGRP_ID,TOTALHRS,USER_ID,DATETIME) "
		        sSQL = sSQL & "values ("
		        sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		        sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		        sSQL = sSQL & "'" & pRTIN(sShfPat_ID) & "',"		
		        sSQL = sSQL & "'" & sRow & "',"
		        sSQL = sSQL & "'" & sCol & "',"
		        sSQL = sSQL & "'" & sWorkGrp_ID & "',"
                sSQL = sSQL & "'" & sTotalHrs & "',"
		        sSQL = sSQL & "'" & session("USERNAME") & "'," 
                sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		        sSQL = sSQL & ") "
	            conn.execute sSQL            
   
                    For m = 1 to Cint(sCol)
                
                    sShfPat = reqForm("selShfPat" & i & "_" & (m+2)) '=== Plus 2 because 1 column is workgroupID and 2nd column is total hours, only the 3rd onwards is shift
                    sSQL = "UPDATE TMSHFPLAN SET "             
                    sSQL = sSQL & "WEEK_" & m & " = '" & sShfPat & "'"
                    sSQL = sSQL & " WHERE SHFPLAN_ID = '" & sID & "'"
                    sSQL = sSQL & " AND WORKGRP_ID = '" & sWorkGrp_ID & "'"
                    conn.execute sSQL

                    next
                i=i+1
            loop
        call confirmBox("Save Successful!", sMainURL&sAddURL)
        end if
    end if

%>
<div>
    <table class="table table-bordered table-striped">
        <%
            i=0
            Set rs = server.CreateObject("ADODB.RecordSet")  '===HERE i retrive back the total records  
            sSQL = "select * from TMSHFPAT where SHFPAT_ID ='" & sShfPat_ID & "'" 
            sSQL = sSQL & " order by PATTERN"
            rs.Open sSQL, conn, 3, 3
                do while not rs.eof
                    if i mod 3 = 0 then  '=== This will fill one row 3 items
                        response.write "<tr>"
                    end if 
                                            
                    response.write "<td>"
                    response.write "<div class='block' style='width:80px;border:none'>&nbsp;</div>"
                        
                        For k = 1 to 7 '===Here it insert the 7 color bar
                                                    
                            variable = "DAY_" & k    
                            Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                            sSQL = "select color from TMSHFCODE where SHF_CODE ='" & rs("" & variable & "") & "'"
                            rstTMSHFCODE.Open sSQL, conn, 3, 3
                            if not rstTMSHFCODE.eof then
                                response.write "<div class='block' style='background:"& rstTMSHFCODE("COLOR") & ";'></div>" 
                            end if
                        next
                        response.write "<div class='block' style='width:80px;border:none'>PATTERN " & rs("PATTERN") & "</div>"
                    response.write "</td>"
                                               
                    if i = i + 2 then '=== if mod 3, here + 2; if mod 4, here +3 
                        response.write "</tr>" 
                    end if 
                    
                    i = i + 1
                rs.movenext
                loop
                response.write "</tr>"
        %>
    </table>
</div>
<form name="form2" action="ajax/ax_tmshfplan_det.asp" method="post">
    <input type="hidden" name="txtID" value="<%=sSHFPLAN_ID%>" />
    <input type="hidden" name="txtPart" value="<%=sPart%>" /> <!-- Passing from mainpage, store here must have server html encode, if not after request, string will " will disappear -->
    <input type="hidden" name="txtShfPat_ID" value="<%=sSHFPAT_ID%>" />
    <input type="hidden" name="txtRow" value="<%=sRow%>" />
    <input type="hidden" name="txtCol" value="<%=sCol%>" />
    <div class="col-sm-12" style="overflow: auto; padding: 0px; margin: 0px">

        <table id="example1" class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th style="width: 19%">Workgroup</th>
                    <th style="width: 9%; text-align: right">Total Hours</th>
                    <% 
                            j = 1
                            do while not j > Cint(sCol)
                                if j = 1 then
                                    response.write "<th>Day " & Cint(j) & " - " & (7*Cint(j)) & "</th>"
                                else
                                    response.write "<th>Day " & (7*Cint(j-1)+1) & " - " & (7*Cint(j)) & "</th>"
                                end if
                            j = j + 1
                            loop

                    %>
                </tr>
            </thead>

            <tbody>

                <%  if bEdit <> "" then
                    Set rstTMShfPlan = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMSHFPLAN where SHFPLAN_ID='" & sID & "' order by WORKGRP_ID" 
                    rstTMShfPlan.Open sSQL, conn, 3, 3
                        do while not rstTMShfPlan.eof 
                            response.write "<tr>"
                                response.write "<td>"
                                response.write "<div class='input-group'>"        
                                response.write rstTMShfPlan("WORKGRP_ID")
                                response.write "</div>"
                                response.write "</td>"
                                response.write "<td style='text-align:right'>" & rstTMShfPlan("TOTALHRS") & "</td>"
                                
                                For m = 1 to Cint(sCol) '=====Until how many columns. 
                                    response.write "<td>"
                                        response.write "<div class='input-group'>"
                                            variable = "WEEK_" & m
                                            Set rs = server.CreateObject("ADODB.RecordSet")  'HERE i retrive back the total records  
                                            sSQL = "select * from TMSHFPAT where SHFPAT_ID ='" & rstTMShfPlan("SHFPAT_ID") & "'" 
                                            sSQL = sSQL & " and PATTERN = '" & rstTMShfPlan("" & variable & "") & "'"
                                            rs.Open sSQL, conn, 3, 3  
                                            if not rs.eof then
                                                For k = 1 to 7
                                                    
                                                    variable = "DAY_" & k    
                                                    Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                                                    sSQL = "select color from TMSHFCODE where SHF_CODE ='" & rs("" & variable & "") & "'"
                                                    rstTMSHFCODE.Open sSQL, conn, 3, 3
                                                    if not rstTMSHFCODE.eof then
                                                        response.write "<div class='block' style='background:"& rstTMSHFCODE("COLOR") & ";'></div>" 
                                                    end if
                                                next
                                            
                                            end if
                                        response.write "</div>"
                                    response.write "</td>"
                                next
                            response.write "<tr>"
                            rstTMShfPlan.movenext
                        loop
                    else
                        i=0
                        do while not i >= Cint(sROW)
                       
                        response.write "<tr>"
                            
                            For m = 1 to Cint(sCol+2) '=====Until how many columns, add 2 coz column 1 is workgrp and column 2 is Total Hours and 3rd columns onwards is pattern.
                                if m = 1 then
                                     response.write "<td>"
                                        response.write "<div class='input-group'>"
                                        response.write "    <select class='form-control' id='selWorkGrp'" & i & "' name='selWorkGrp" & i & "'>"
                                        response.write "        <option value=''>Select</option>"
                                            Set rstTMWorkGrp = server.CreateObject("ADODB.RecordSet")    
                                            sSQL = "select distinct WORKGRP_ID from TMWORKGRP" 
                                            rstTMWorkGrp.Open sSQL, conn, 3, 3
                                            if not rstTMWorkGrp.eof then
                                                do while not rstTMWorkGrp.eof
                                                    Set rstTMSHFPLAN = server.CreateObject("ADODB.RecordSet")    
                                                    sSQL = "select * from TMSHFPLAN where WORKGRP_ID = '" & rstTMWorkGrp("WORKGRP_ID") & "'"
                                                    rstTMSHFPLAN.Open sSQL, conn, 3, 3
                                                    if rstTMSHFPLAN.eof then
                                                        response.write "<option value='" & rstTMWorkGrp("WORKGRP_ID") & "'>" & rstTMWorkGrp("WORKGRP_ID") & "</option>" 
                                                    end if
                                                rstTMWorkGrp.movenext
                                                loop
                                            end if
                                        response.write "    </select>"
                                        response.write "</div>"
                                    response.write "</td>"
                                elseif m = 2 then
                                    response.write "<td style='text-align:right'><input class='form-control' type='text' id =""txtTotHours" & i & """ name='txtTotHours" & i & "'/></td>"
                                else
                                    response.write "<td>"
                                        response.write "<div class='input-group'>"
                                        response.write "    <select class='form-control' id=""selShfPat" & i & "_" & m & """ name='selShfPat" & i & "_" & m & "' onchange=""calTotHours(this,'" & i & "','" & m & "')"">" '=== onchange here must be double quote
                                        response.write "        <option value=''>Select</option>"
                                            Set rstTMSHFPAT = server.CreateObject("ADODB.RecordSet")    
                                            sSQL = "select * from TMSHFPAT where SHFPAT_ID = '" & sShfPat_ID & "' order by PATTERN" 
                                            rstTMSHFPAT.Open sSQL, conn, 3, 3
                                            if not rstTMSHFPAT.eof then
                                                do while not rstTMSHFPAT.eof
                                                    response.write "<option value='" & rstTMSHFPAT("PATTERN") & "'>" & rstTMSHFPAT("PATTERN") & "</option>" 
                                                rstTMSHFPAT.movenext
                                                loop
                                            end if
                                        response.write "    </select>"
                                        response.write "</div>"
                                    response.write "</td>"
                                end if        
                            next
                        response.write "</tr>"
                        i = i + 1
                       loop
                   End if
                %>
            </tbody>
        </table>
        <div class="col-lg-12">
            <div class="row">
                <div class="pull-right">
                    <%if bEdit <> "" then %>
                    <a href="#" data-toggle="modal" data-target="#modal-delshfplan" data-shfplan_id="<%=sID%>"
                        class="btn btn-danger pull-right" style="width: 90px">Clear All</a>
                    <%else%>
                    <button type="submit" id="btnSave" name="btnSave" value="save" class="btn btn-primary"
                        style="width: 90px">
                        Save</button>
                    <%end if%>
                </div>
            </div>
        </div>
</form>
