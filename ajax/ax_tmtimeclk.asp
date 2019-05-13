<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
    'ters
Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd

sOrderBy = trim(request("txtOrderBy"))
sAscDesc = trim(request("txtAscDesc"))     

sEMP_CODE = trim(request("txtEMP_CODE"))
dtpFrDate = fdate2(request("dtpFrDate"))
dtpToDate = fdate2(request("dtpToDate"))
    
Set rstBROPATH = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from BROPATH" 
rstBROPATH.Open sSQL, conn, 3, 3
if not rstBROPATH.eof then
    sNumRows = rstBROPATH("NUMROWS")
end if
pCloseTables(rstBROPATH)

PageLen = Cint(sNumRows)

if request("Page") <> "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMEMPLY where "
sSQL = sSQL & " EMP_CODE ='" & session("USERNAME") & "'"  
rstTMEMPLY.Open sSQL, conn, 3, 3
if not rstTMEMPLY.eof then
    sAType = rstTMEMPLY("ATYPE")
end if 

sSQL = "select tmshiftot.DT_SHIFT, tmshiftot.SHF_CODE as SHF_CODEFrSched, tmshfcode.STIME as START_TIMEFrSched, tmshfcode.ETIME as END_TIMEFrSched, "
sSQL = sSQL & " tmclk2.SHF_CODE as SHIFT_CODE, tmclk2.STIME as START_TIME,tmclk2.ETIME as END_TIME, " 
sSQL = sSQL & " tmclk2.*,tmemply.DT_RESIGN, tmemply.GENSHF from tmshiftot " 
sSQL = sSQL & " left join tmshfcode on tmshiftot.SHF_CODE = tmshfcode.SHF_CODE"  
sSQL = sSQL & " left join tmclk2 on tmshiftot.DT_SHIFT = tmclk2.DT_WORK and tmshiftot.EMP_CODE= tmclk2.EMP_CODE"
sSQL = sSQL & " left join tmemply on tmshiftot.EMP_CODE= tmemply.EMP_CODE"
sSQL = sSQL & " where (tmshiftot.EMP_CODE = '" & sEMP_CODE & "') "
sSQL = sSQL & " and (DT_SHIFT between '" & dtpFrDate & "' and '" & dtpToDate & "')"     
'sSQL = sSQL & " and isnull(DT_RESIGN) "
sSQL = sSQL & " and GENSHF = 'Y' "
    
if sOrderBy = "undefined"  then
    sSQL = sSQL & "order by tmshiftot.DT_SHIFT asc"
else
    if sAscDesc = "Asc" then
        sSQL = sSQL & "order by " & sOrderBy
    elseif sAscDesc = "Desc" then
        sSQL = sSQL & "order by " & sOrderBy & " desc"
    end if
end if
    'response.write "*****" & sSQL & "<br>"
set rstTMCLK2 = server.createobject("adodb.recordset")
rstTMCLK2.cursortype = adOpenStatic
rstTMCLK2.cursorlocation = adUseClient
rstTMCLK2.locktype = adLockBatchOptimistic
rstTMCLK2.pagesize = PageLen		
rstTMCLK2.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMCLK2.eof then
 	rstTMCLK2.absolutepage = iCurPage
 	iPageCount = rstTMCLK2.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMCLK2.RecordCount
PageStart = ((PageLen*PageNo)-PageLen)
PageEnd = PageLen

If TotalRecord <= PageLen Then
	TotalPage =1
ElseIf (TotalRecord Mod PageLen = 0) Then
	TotalPage =(TotalRecord/PageLen)
Else
	TotalPage =(TotalRecord/PageLen)
	if TotalPage > Cint(TotalPage) then
		TotalPage = Cint(TotalPage)+1
	else
		TotalPage = Cint(TotalPage)
	end if
End If
    

%>
<div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
        
    <table id="example1" class="table table-bordered table-striped">
       <thead>
            <tr>
                <%If sAscDesc ="Desc" then %>
                    <th style="width:3%">Day</th>
                    <th style="width:7%"><a href="javascript:showContent('page=<%=PageNo%>','DT_SHIFT','Asc');">Shift Date</a></th>
                    <th style="width:13%"><a href="javascript:showContent('page=<%=PageNo%>','SHIFT_CODE','Asc');">Shift</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TIN','Asc');">In</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TOUT','Asc');">Out</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TOTAL','Asc');">Total</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TOTALOT','Asc');">Total OT</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TOTALOT','Asc');">Apv OT</a></th>
                    <th style="width:23%">Time Off</th>
                    <th style="width:12%">Status</th>
                    <th style="width:7%;text-align:center">History</th>
                    <% if sAtype <> "S" then%>
                        <th style="width:5%;text-align:center">Edit</th>
                    <% end if%>
                <%else %>
                    <th style="width:3%">Day</th>
                    <th style="width:7%"><a href="javascript:showContent('page=<%=PageNo%>','DT_SHIFT','Desc');">Shift Date</a></th>
                    <th style="width:13%"><a href="javascript:showContent('page=<%=PageNo%>','SHIFT_CODE','Desc');">Shift</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TIN','Desc');">In</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TOUT','Desc');">Out</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TOTAL','Desc');">Total</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TOTALOT','Desc');">Total OT</a></th>
                    <th style="width:6%"><a href="javascript:showContent('page=<%=PageNo%>','TOTALOT','Desc');">Apv OT</a></th>
                    <th style="width:23%">Time Off</th>
                    <th style="width:12%">Status</th>
                    <th style="width:7%;text-align:center">History</th>
                    <% if sAtype <> "S" then%>
                        <th style="width:5%;text-align:center">Edit</th>
                    <% end if%>
                 <%end if %>
            </tr>
        </thead>
        
        <tbody>
        <%

            do while not rstTMCLK2.eof and i < PageLen 

                i = i + 1 'keep track of how many records per page
                
                sTimeOffColumn = ""
                sStatus  = ""

                if isNull(rstTMCLK2("DT_RESIGN")) then
                    sDtResign = "9999-12-31" '=== Haven't resign so just choose a inifite date
                else
                    sDtResign = rstTMCLK2("DT_RESIGN")
                end if 

                response.write "<tr>"
                    response.write "<td>" & Weekdayname(weekday(rstTMCLK2("DT_SHIFT"),1),True) & "</td>"
                    response.write "<td>" & rstTMCLK2("DT_SHIFT") & "</td>"

                    if CDate(rstTMCLK2("DT_SHIFT")) <= CDate(sDtResign) then '=== Anything before resign date

                        '===Shift column==========================================================
                        if not isnull(rstTMCLK2("SHIFT_CODE")) then '=== There is an attendance, TMCLK2 got record, working

                            if rstTMCLK2("SHIFT_CODE") ="OFF" or rstTMCLK2("SHIFT_CODE") ="REST" then 
                                response.write "<td>" & rstTMCLK2("SHIFT_CODE") & "</td>"
                                sStatus = sStatus & rstTMCLK2("SHIFT_CODE") & " " 
                            
                            else '=== Normal schedule

                                response.write "<td>" & rstTMCLK2("SHIFT_CODE") & " " & rstTMCLK2("START_TIME") & "-" & rstTMCLK2("END_TIME") & "</td>"
                            
                                if  rstTMCLK2("SHIFT_CODE") <> "" and ( rstTMCLK2("HALFDAY") = "" or rstTMCLK2("HALFDAY") = "N" ) then
                                    sStatus = sStatus & "Normal " 
                                elseif rstTMCLK2("SHIFT_CODE") <> "" and rstTMCLK2("HALFDAY") = "Y" then
                                    sStatus = sStatus & "0.5 Day Work"
                                elseif isnull(rstTMCLK2("SHIFT_CODE")) then
                                    sStatus = sStatus & "No Schedule " 
                                end if

                            end if

                        else '=== Don't have attendance record, get SHF_CODE from Schedule

                            if rstTMCLK2("SHF_CODEFrSched") ="OFF" or rstTMCLK2("SHF_CODEFrSched") ="REST" then
                                response.write "<td>" & rstTMCLK2("SHF_CODEFrSched") & "</td>"
                                sStatus = sStatus & rstTMCLK2("SHF_CODEFrSched") & " " 
                            else
                                response.write "<td>" & rstTMCLK2("SHF_CODEFrSched") & " " & rstTMCLK2("START_TIMEFrSched") & "-" & rstTMCLK2("END_TIMEFrSched") & "</td>"
                            
                                if  rstTMCLK2("SHF_CODEFrSched") <> "" and ( rstTMCLK2("HALFDAY") = "" or rstTMCLK2("HALFDAY") = "N" ) then
                                    sStatus = sStatus & "Normal " 
                                elseif rstTMCLK2("SHF_CODEFrSched") <> "" and rstTMCLK2("HALFDAY") = "Y" then
                                    sStatus = sStatus & "0.5 Day Work"
                                elseif isnull(rstTMCLK2("SHF_CODEFrSched")) then
                                    sStatus = sStatus & "No Schedule " 
                                end if
                            end if
                         end if
                        '=========================================================================
            
                        response.write "<td>" & rstTMCLK2("TIN") & "</td>"
                        response.write "<td>" & rstTMCLK2("TOUT") & "</td>"
                        response.write "<td>" & rstTMCLK2("TOTAL") & "</td>"
                        response.write "<td>" & rstTMCLK2("TOTALOT") & "</td>"
                        response.write "<td>" & rstTMCLK2("3ATOTALOT") & "</td>" '=== Only Final approval by Verifier then only APVOT will appear
                        
                        '=======Time Off column consist of Employee Time Off=============
                        Set rstTMABSENT = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMABSENT where EMP_CODE = '" & sEMP_CODE & "'"
                        sSQL = sSQL & " and DT_ABSENT = '" & fdate2(rstTMClk2("DT_SHIFT")) & "'" 
                        rstTMABSENT.Open sSQL, conn, 3, 3
                        if not rstTMABSENT.eof then '=== Absent is recorded
                            if rstTMABSENT("TYPE") = "F" then '=== Check the ABSENT recorded as FULL or HALF
                                Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMEOFF where "
                                sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                                sSQL = sSQL & " and ('" & fdate2(rstTMABSENT("DT_ABSENT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                                rstTMEOFF.Open sSQL, conn, 3, 3
                                if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off
                                    sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                                else
                                    sTimeOffColumn =  "Absent"
                                end if
                            elseif rstTMABSENT("TYPE") = "H" then
                                Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMEOFF where "
                                sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                                sSQL = sSQL & " and ('" & fdate2(rstTMABSENT("DT_ABSENT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                                rstTMEOFF.Open sSQL, conn, 3, 3
                                if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off
                                    sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                                else
                                    sTimeOffColumn =  "0.5 Day Absent"
                                end if
                            end if

                        else '=== No Absent recorded, Not working check if is it a Holiday
            'response.write " 1s: " & sSQL &"<br>"
                            if isNull(rstTMCLK2("TOTAL")) then
                                Set rstTMHOL1 = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "SELECT tmworkgrp.HOL_ID, tmhol1.* FROM tmworkgrp "
                                sSQL = sSQL & " left join tmhol1 on tmhol1.HOL_ID = tmworkgrp.HOL_ID "
                                sSQL = sSQL & " where tmworkgrp.EMP_CODE = '" & sEMP_CODE & "'"
                                sSQL = sSQL & " and tmhol1.DT_HOL = '" & fdate2(rstTMClk2("DT_SHIFT")) & "'" 
                                rstTMHOL1.Open sSQL, conn, 3, 3
                                if not rstTMHOL1.eof then '=== it is a holiday

             'response.write " 2s: " & sSQL &"<br>"
                                    sTimeOffColumn = rstTMHOL1("PART")
                                    sStatus = "Holiday"
                                    '=== Check if the person accidentally apply for leave on Holiday
                                    Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                                    sSQL = "select * from TMEOFF where "
                                    sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                                    sSQL = sSQL & " and ('" & fdate2(rstTMCLk2("DT_SHIFT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                                    rstTMEOFF.Open sSQL, conn, 3, 3
                                    if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off
                                        if rstTMEOFF("LTYPE") = "F" then '=== Check the Leave applied is Full or Half
                                            sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                                        else '=== Half Day leave
                                               sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART") & " - " & rstTMEOFF("DURA") & " Day "
                                        end if
                                    end if
                                else '===Not holiday, A Normal Working with Scheduled day 
                                    if rstTMCLK2("SHF_CODEFrSched") ="OFF" or rstTMCLK2("SHF_CODEFrSched") ="REST" then
                                        sTimeOffColumn = ""
                                    else
                                        '=== Check if it is on sick leave 
                                        Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                                        sSQL = "select * from TMEOFF where "
                                        sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                                        sSQL = sSQL & " and ('" & fdate2(rstTMCLk2("DT_SHIFT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                                        rstTMEOFF.Open sSQL, conn, 3, 3
            'response.write sSQL
            'response.end
                                        if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off
                                            if rstTMEOFF("LTYPE") = "F" then '=== Check the Leave applied is Full or Half
                                                sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                                            else '=== Half Day leave
                                                sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART") & " - " & rstTMEOFF("DURA") & " Day "
                                            end if
                                        end if
                                    end if
                                end if
                            else
                                '=== Check if it is on sick leave 
                                Set rstTMEOFF = server.CreateObject("ADODB.RecordSet")    
                                sSQL = "select * from TMEOFF where "
                                sSQL = sSQL & " EMP_CODE ='" & sEMP_CODE & "'"
                                sSQL = sSQL & " and ('" & fdate2(rstTMCLk2("DT_SHIFT")) & "' between DTFR and DTTO )" '===Can't left join between DTFR and DTTO
                                rstTMEOFF.Open sSQL, conn, 3, 3
    'response.write sSQL
    'response.end
                                if not rstTMEOFF.eof then  '==== Check if got Apply leave Time off
                                    if rstTMEOFF("LTYPE") = "F" then '=== Check the Leave applied is Full or Half
                                        sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART")
                                    else '=== Half Day leave
                                        sTimeOffColumn = rstTMEOFF("TOFF_ID") & " - " & rstTMEOFF("PART") & " - " & rstTMEOFF("DURA") & " Day "
                                    end if
                                end if
                            end if
                        end if

                        response.write "<td>" & sTimeOffColumn & "</td>"

                        '==================================================================================================

                        '===== STATUS column NORMAL, OFF, REST and OT if got, IRREG INCOMPLETE============================
            
                        if (rstTMCLK2("OTIN") = "" and rstTMCLK2("OTOUT") = "") then
                            sStatus = sStatus & " No Info " 
                        elseif (rstTMCLK2("OTIN") = "" or rstTMCLK2("OTOUT") = "") and isNull(rstTMCLK2("2DTAPV")) then '==Incomplete, only after verifier will not show
                            sStatus = sStatus & " Incomplete " 
                        elseif rstTMCLK2("IRREG") = "Y" and isNull(rstTMCLK2("2DTAPV")) then '=== Only after verifier approve will disappear
                            sStatus = sStatus & " Irregular "
                        end if    
                    
                        if rstTMCLK2("TOTALOT") <> "00:00" and rstTMCLK2("TOTALOT") <> ""  then
                            sStatus = sStatus & " OT "
                        end if

                        if rstTMCLK2("LATE") = "Y" and rstTMCLK2("EARLY") ="Y" then
                            sStatus = sStatus & " Late and Early Dimiss "
                        elseif rstTMCLK2("LATE") = "Y" then
                            sStatus = sStatus & " Late "
                        elseif rstTMCLK2("EARLY") = "Y" then
                            sStatus = sStatus & " Early Dismiss "
                        end if
                        
                        if CDate(rstTMCLK2("DT_SHIFT")) = CDate(sDtResign) then
                            sStatus = sStatus & "<b> Resigned</b> " 
                        end if

                        if not isnull(rstTMCLK2("EARLY")) then '=== Simply that a field that will be null if no record
                            response.write "<td>" & sStatus & "</td>"
                            response.write "<td style='text-align:center'><a href=""javascript:fShowHisAbOT('" & sEMP_CODE & "','" & rstTMClk2("DT_SHIFT") & "','mycontent','#mymodal')"">Show</a></td>"
                        else
                            response.write "<td>" & sStatus & " No info </td>"
                            response.write "<td></td>"
                        end if
                        '=====================================================================================================  
            
                        if sAtype <> "S" then
                            response.write "<td style=""width:2%;text-align:center""><a href='tmtimeclk_det.asp?Page="& PageNo & "&txtEMP_CODE="& sEMP_CODE & "&dtpFrDate="& dtpFrDate & "&dtpToDate="& dtpToDate & "&txtdt_Work=" & rstTMCLK2("DT_SHIFT") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                        end if
                    end if
                response.write "</tr>"
                rstTMCLK2.movenext
            loop
            call pCloseTables(rstTMCLK2)

        %>                     
        </tbody>
        
    </table>
    </div>
    
    <div class="row">
        <div class="col-sm-5" style="margin-top:5px">
        <br />  TOTAL RECORDS (<%=TotalRecord%>) <%=lg_page%> <%=PageNo%> / <%=TotalPage%>
        </div>
        <div class="col-sm-7">
            <br />
            <div class="dataTables_paginate">
                <ul class="pagination">
                    <%IF Cint(PageNo) > 1 then %>
                        <li class="paginate_button"><a href="javascript:showContent('page=1','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=PageNo-1%>','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" >< Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showContent('page=<%=intID%>','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=PageNo+1%>','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=TotalPage%>','<%=sOrderby%>','<%=sAscDesc%>');" class="button_a" >Last >></a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- /.box -->
