<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<!-- JQuery 2.2.3 Compressed -->
<%
                                        
iRecCount =2

sSHFPAT_ID = request("txtSHFPAT_ID")
sPAT = request("txtPat")
sPART = request("txtPart")
bEorS = request("EorS")

  if reqForm("btnSave") <> "" then
       
        sID = reqFormU("txtID")
        sPAT = reqForm("txtPat")    
        sPART = reqForm("txtPart")

        sMainURL = "../tmshfpat_det.asp?"
        sAddURL = "txtSHFPAT_ID=" & sID & "&EorS=Y"

        Set rs = server.CreateObject("ADODB.RecordSet")
        sSQL = "select * from TMSHFPAT where SHFPAT_ID ='" & sID & "'" 
        rs.Open sSQL, conn, 3, 3         
        if not rs.eof then
            call alertbox("Shift Pattern: " & sID & " already exist !")    
        end if

        
        j=0
        bInsert="Y"
        sAddURL2 = "txtSHFPAT_ID=" & sID & "&txtPat=" & sPAT & "&txtPart=" & sPART
        
        do while not j >= Cint(sPAT)
            j=j+1   
                For m = 1 to 7
                    sPatCode = reqFormU("selPATCODE" & j & "_" & m)
                    if sPatCode = "" then
                        call confirmbox1("You did not select one of the Shift Code!",sMainURL&sAddURL2)
                        bInsert= "N"
                    end if
                Next
        loop
        
        if bInsert = "Y" then
            j=0
            do while not j >= Cint(sPAT)
                j = j + 1

                    sSQL = "insert into TMSHFPAT (SHFPAT_ID,PART,PATTERN,USER_ID,DATETIME) "
		            sSQL = sSQL & "values ("
		            sSQL = sSQL & "'" & pRTIN(sID) & "',"		
		            sSQL = sSQL & "'" & pRTIN(sPart) & "',"
		            sSQL = sSQL & "'" & j & "',"
		            sSQL = sSQL & "'" & session("USERNAME") & "'," 
                    sSQL = sSQL & "'" & fdatetime2(Now()) & "'"
		            sSQL = sSQL & ") "
		            conn.execute sSQL            
   
                     For m = 1 to 7 
                
                        sPatCode = reqFormU("selPATCODE" & j & "_" & m )
                        sSQL = "UPDATE TMSHFPAT SET "             
                        sSQL = sSQL & "DAY_" & m & " = '" & sPatCode & "'"
                        sSQL = sSQL & " WHERE SHFPAT_ID = '" & sID & "'"
                        sSQL = sSQL & " AND PATTERN = '" & j & "'"
                        conn.execute sSQL
                    next
            loop

            call confirmBox("Save Successful!", sMainURL&sAddURL)
        end if
    end if

%>
    <style>
        .block {
      float: left;
      width: 20px;
      height: 20px;
      margin: 2px;
      margin-left: 20px;
      border: 1px solid rgba(0, 0, 0, .2);
    }
    </style>
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
                    response.write "<div class='block' style='background:"& rstCode("COLOR") & ";'></div>" & "(" & rstCode("SHF_CODE") & ") " & rstCode("PART") 
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
    <form name="form2" action="ajax/ax_tmshfpat_det.asp" method="post">
        <input type="hidden" name="txtID" value="<%=sSHFPAT_ID%>" />
        <input type="hidden" name="txtPat" value="<%=sPat%>" />
        <input type="hidden" name="txtPart" value="<%=sPart%>" />
        <div class="col-sm-12">

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th style="width: 10%">Pattern</th>
                        <th style="width: 10%;text-align:center">Day 1</th>
                        <th style="width: 10%;text-align:center">Day 2</th>
                        <th style="width: 10%;text-align:center">Day 3</th>
                        <th style="width: 10%;text-align:center">Day 4</th>
                        <th style="width: 10%;text-align:center">Day 5</th>
                        <th style="width: 10%;text-align:center">Day 6</th>
                        <th style="width: 10%;text-align:center">Day 7</th>
                    </tr>
                </thead>

                <tbody>
                    <%  
                        i = 0
                        Set rstTMSHFPAT = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMSHFPAT where SHFPAT_ID ='" & sSHFPAT_ID & "'" 
                    sSQL = sSQL & " order by PATTERN asc" '====From ROW 1 to 6 
                    rstTMSHFPAT.Open sSQL, conn, 3, 3
                    if not rstTMSHFPAT.eof then
                    
                        do while not rstTMSHFPAT.eof and i < sPAT '==="Do while not" means Do until condition is met. If not EOF, DO, if i < sPat, DO. 
                            i = i + 1                             
                                response.write "<tr>"
                                response.write "<td>Pattern " & i & "</td>"
                                For k = 1 to 7    
                                    variable = "DAY_" & k
                                    Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMSHFCODE where SHF_CODE ='" & rstTMSHFPAT("" & variable & "") & "'" 
                                    rstTMSHFCODE.Open sSQL, conn, 3, 3
                                    if not rstTMSHFCODE.eof then
                                        bgcolor = rstTMSHFCODE("COLOR")
                                        textcolor = hex2rgb(bgcolor)
                                        response.write "<td bgcolor='" & bgcolor & "'><p style='color:" & textcolor & ";text-align:center'>" & rstTMSHFPAT("" & variable & "") & "</p></td>"
                                    else
                                        response.write "<td>Shift code is invalid</td>"
                                    end if
                                    pCloseTables(rstTMSHFCODE)
                                next
                                response.write "</tr>"
                            rstTMSHFPAT.movenext
                        loop
                        
                    else
                        do while not i >= cint(sPAT)
                            i = i + 1
                                response.write "<tr>"
                                response.write "<td>" & i & "</td>"
                            
                                For k = 1 to 7
                                    response.write "<td>"
                                    response.write "<div class='input-group'>"
								    response.write "<select class='form-control' id='selPATCODE" & i & "_" & k & "' name='selPATCODE" & i & "_" & k & "'>"
                                    response.write "<option value=''>Select</option>"
                                    Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMSHFCODE order by SHF_CODE" 
                                    rstTMSHFCODE.Open sSQL, conn, 3, 3
                                    if not rstTMSHFCODE.eof then
                                        do while not rstTMSHFCODE.eof
                                            response.write "<option value='" & rstTMSHFCODE("SHF_CODE") & "'>" & rstTMSHFCODE("SHF_CODE") & "</option>" 
                                        rstTMSHFCODE.movenext
                                        loop
                                    end if
                                    response.write "</select>"
                                    response.write "</div>"
                                    response.write "</td>"
                                Next

                                response.write "</tr>"
                        loop
                    end if
                    call pCloseTables(rstTMSHFPAT)

                    %>
                </tbody>


            </table>
        </div>
        <div class="col-lg-12">
            <div class="row">
                <div class="pull-right">
                    <%if bEorS <> "" then %>
                        <a href="#" data-toggle="modal" data-target="#modal-delshfpat" data-shfpat_id="<%=sSHFPAT_ID%>" 
                            class="btn btn-danger pull-right" style="width: 90px">Clear All</a>
                    <%else%>
                        <button type="button" id="btnCheck" name="btnCheck" value="Check" class="btn btn-primary"
                            style="width: 90px" onclick="checkempty('<%=sPat%>');">
                            Save</button>
                        <button type="submit" id="btnSave" name="btnSave" value="Save" class="btnSaveHide">
                        </button>
                    <%end if%>
                </div>
            </div>
        </div>
    </form>
