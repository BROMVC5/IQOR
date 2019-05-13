<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<style>
    .block {
        float: left;
        width: 10px;
        height: 30px;
        margin: 2px;
        border: 1px solid rgba(0, 0, 0, .2);
    }

    .blockcolor {
      float: left;
      width: 20px;
      height: 20px;
      margin: 2px;
      margin-left: 20px;
      border: 1px solid rgba(0, 0, 0, .2);
    }
</style>
<%
sID = request("txtSHFPLAN_ID")

Set rstTMShfplan = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMSHFPLAN where SHFPLAN_ID='" & sID & "'" 
rstTMShfplan.Open sSQL, conn, 3, 3
if not rstTMShfPlan.eof then 
    sRow = rstTMShfPlan("ROW")
    sCol = rstTMShfPlan("COL")
end if
%>
    <div class="form-group">
        <label class="col-sm-3 control-label">Pattern Start From : </label>
        <div class="col-sm-3">
            <select id="selStart" name="selStart" class="form-control">
                <option value="" selected="selected" disabled>Please select</option>
                <%
                    j = 1
                    do while not j > Cint(sCol)
                        if j = 1 then
                            response.write "<option value='" & j & "'>Day " & Cint(j) & " - " & (7*Cint(j)) & "</option>"
                        else
                            response.write "<option value='" & j & "'>Day " & (7*Cint(j-1)+1) & " - " & (7*Cint(j)) & "</option>"
                        end if
                    j = j + 1
                    loop
                 %>
            </select>
        </div>
    </div>
    <div>
        <table class="table table-bordered table-striped">
            <%
            i = 0
            Set rstCode = server.CreateObject("ADODB.RecordSet")    
            sSQL = "select * from TMSHFCODE order by SHF_CODE"
            rstCode.Open sSQL, conn, 3, 3
                do while not rstCode.eof

                    if i mod 3 = 0 then 
                        response.write "<tr>" 
                    end if 
                    
                    response.write "<td>"
                    response.write "<div class='blockcolor' style='background:"& rstCode("COLOR") & ";'></div>" & "(" & rstCode("SHF_CODE") & ") " & rstCode("PART") 
                    response.write "</td>"

                    if i = i + 2 then 
                        response.write "</tr>" 
                    end if 
                    
                    i = i + 1
                    rstCode.movenext
                loop
            pClosetables(rstCode)    
            %>
        </table>
    </div>

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

                <%  
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
                    
                %>
            </tbody>
        </table>
    </div>
    <div class="box-footer">
        <button type="button" class="btn btn-primary pull-right" style="width: 90px" onclick="check();">Generate</button>
        <button type="submit" id="btnSave" name="btnSave" value="save" class="btnSaveHide"></button>
    </div>
    <!-- /.box-footer -->


