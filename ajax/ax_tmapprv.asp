<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<!-- JQuery 2.2.3 Compressed -->
<%
    sAfterApprove = request("AfterApprove")
    sLogin = request("txtLogin")
   
    Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMEMPLY where "
    sSQL = sSQL & " EMP_CODE ='" & sLogin & "'"  
    rstTMEMPLY.Open sSQL, conn, 3, 3
    if not rstTMEMPLY.eof then
        sApvName = rstTMEMPLY("NAME")
        sAType = rstTMEMPLY("ATYPE")
    end if 

    sApprov = request("txtApprov")
    sDown = request("txtDown")

    if sApprov = "V" then
        sApprovlb = "Verifier "
    elseif sApprov = "M" then
        sApprovlb = "Manager "
    elseif sApprov = "S" then
        sApprovlb = "Superior "
    end if

%>

    <label class="col-sm-2 control-label"><%response.write sApprovlb %> : </label>
    <div class="col-sm-3">
        <select id="selDown" name="selDown" class="form-control" onchange="showContent2('Page=<%=iPage%>');return false;">
            <option value="">Please select</option>
            <%  if sAType = "V" and sApprov = "V" then '=== Whether it is from save or New Load, Verifier, will load verifier name
                    
                    response.write "<option value='" & sLogin & "' selected='selected'>" & sApvName & "</option>" 
                
                elseif sAType = "V" and sApprov = "M" then '=== Verifier but take the role as Manager
                
                    if sAfterApprove = "Y" then '=== If from Save/Approve button.
                        Set rstTMDOWNLINE = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEMPLY where "
                        sSQL = sSQL & " ATYPE = 'M'"  
                        rstTMDOWNLINE.Open sSQL, conn, 3, 3
                        if not rstTMDOWNLINE.eof then
                            if sDown = "A" then '=== He selected All and click Save/Approve button
                                response.write "<option value='A' selected='selected'> All </option>"
                                Do while not rstTMDOWNLINE.eof '=== Need to fill all the managers names
                                    response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "'>" & rstTMDOWNLINE("NAME") & "</option>"
                                    rstTMDOWNLINE.movenext
                                loop 
                            else '=== He selected a particular manager
                                    response.write "<option value='A'> All </option>" '=== Show the All option
                                Do while not rstTMDOWNLINE.eof '=== Fill the managers names in option
                                    if sDown = rstTMDOWNLINE("EMP_CODE") then '=== if the Emp_Code = selected sDown
                                        response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "' selected='selected' >" & rstTMDOWNLINE("NAME") & "</option>" 
                                    else
                                        response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "'>" & rstTMDOWNLINE("NAME") & "</option>"
                                    end if
                                    rstTMDOWNLINE.movenext
                                loop 
                            end if
                        end if
                    else '=== New load, not from Save/Approve button
                        Set rstTMDOWNLINE = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEMPLY where "
                        sSQL = sSQL & " ATYPE = 'M'"  
                        rstTMDOWNLINE.Open sSQL, conn, 3, 3
                        if not rstTMDOWNLINE.eof then
                                response.write "<option value='A'> All </option>"
                            Do while not rstTMDOWNLINE.eof
                                response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "'>" & rstTMDOWNLINE("NAME") & "</option>" 
                                rstTMDOWNLINE.movenext
                            loop 
                        end if
                    end if

                elseif sAType = "V" and sApprov = "S" then '=== When Verifier take over as a Superior position 
                
                    if sAfterApprove = "Y" then '=== This is when press Save/Approve button and want to maintain the info
                    
                        Set rstTMDOWNLINE = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEMPLY where "
                        sSQL = sSQL & " ATYPE = 'S'"  
                        rstTMDOWNLINE.Open sSQL, conn, 3, 3
                        if not rstTMDOWNLINE.eof then
                            if sDown = "A" then '=== If he selected All 
                                response.write "<option value='A' selected='selected'> All </option>"
                                Do while not rstTMDOWNLINE.eof
                                    response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "'>" & rstTMDOWNLINE("NAME") & "</option>"
                                    rstTMDOWNLINE.movenext
                                loop 
                            else '=== Selected a particular Superior Name
                                    response.write "<option value='A'> All </option>" '=== Need to flood All options
                                Do while not rstTMDOWNLINE.eof
                                    if sDown = rstTMDOWNLINE("EMP_CODE") then '=== Which one he selected
                                        response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "' selected='selected' >" & rstTMDOWNLINE("NAME") & "</option>" 
                                    else
                                        response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "'>" & rstTMDOWNLINE("NAME") & "</option>"
                                    end if
                                    rstTMDOWNLINE.movenext
                                loop 
                            end if
                        end if

                    else '==== Fresh load not from press Save/Approve
                
                        Set rstTMDOWNLINE = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEMPLY  where "  
                        sSQL = sSQL & " ATYPE = 'S'"  
                        rstTMDOWNLINE.Open sSQL, conn, 3, 3
                        if not rstTMDOWNLINE.eof then
                                response.write "<option value='A'> All </option>"
                            Do while not rstTMDOWNLINE.eof
                                    response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "'>" & rstTMDOWNLINE("NAME") & "</option>" 
                                rstTMDOWNLINE.movenext
                            loop 
                        end if

                    end if
                
                elseif sAType = "M" and sApprov = "M" then '===Initial launch when he is Manager, he will choose his own name
                
                    response.write "<option value='" & sLogin & "' selected='selected'>" & sApvName & "</option>" 
                
                elseif sAType = "M" and sApprov = "S" then '=== Manager but take his subordinate rols as Superior
                    
                     if sAfterApprove = "Y" then '=== After Approve button is press. Need to maintain the selection

                        Set rstTMDOWNLINE = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEMPLY where "
                        sSQL = sSQL & " SUP_CODE ='" & sLogin  & "'"  
                        sSQL = sSQL & " AND ATYPE = 'S' " 
                        rstTMDOWNLINE.Open sSQL, conn, 3, 3
                        if not rstTMDOWNLINE.eof then
                            if sDown = "A" then '=== He selected All and click Save/Approve button
                                
                                response.write "<option value='A' selected='selected'> All </option>"
                                
                                Do while not rstTMDOWNLINE.eof '=== Need to fill all the managers names
                                    response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "'>" & rstTMDOWNLINE("NAME") & "</option>"
                                    rstTMDOWNLINE.movenext
                                loop 

                            else '=== He selected a particular supervisor

                                response.write "<option value='A'> All </option>" '=== Show the All option
                                
                                Do while not rstTMDOWNLINE.eof '=== Fill the managers names in option
                                
                                    if sDown = rstTMDOWNLINE("EMP_CODE") then '=== if the Emp_Code = selected sDown
                                        response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "' selected='selected' >" & rstTMDOWNLINE("NAME") & "</option>" 
                                    else
                                        response.write "<option value='" & rstTMDOWNLINE("EMP_CODE") & "'>" & rstTMDOWNLINE("NAME") & "</option>"
                                    end if
                                    rstTMDOWNLINE.movenext

                                loop 
                            end if
                        end if

                    else '=== Initial select to Superior role
                
                        Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEMPLY where "
                        sSQL = sSQL & " SUP_CODE ='" & sLogin  & "'"  
                        sSQL = sSQL & " AND ATYPE = 'S' "  
                        rstTMEMPLY.Open sSQL, conn, 3, 3
                        if not rstTMEMPLY.eof then
                
                            response.write "<option value='A'> All </option>"

                            Do while not rstTMEMPLY.eof            
                                response.write "<option value='" & rstTMEMPLY("EMP_CODE") & "'>" & rstTMEMPLY("NAME") & "</option>" 
                            rstTMEMPLY.movenext
                            loop
                        end if
                    end if

                elseif sAType = "S" and sApprov = "S" then  '=== Login in as Superior and Approve Role as Superior Only
                
                    response.write "<option value='" & sLogin & "' selected='selected'>" & sApvName & "</option>" 
                
                end if
            %>
        </select>
    </div>    

        