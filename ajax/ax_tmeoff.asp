<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
iPage = request("page")
sOrderBy = trim(request("txtOrderBy"))
sAscDesc = trim(request("txtAscDesc"))     
sEMP_CODE = UCase(request("txtEMP_CODE"))
dtpFrDate = request("dtpFrDate")
dtpToDate = request("dtpToDate")
sTOff_ID = request("txtTOff_ID")

if iPage = "" then
	iPage = 1
end if
sAddURL = "&page=" & iPage & "&txtSearch=" & sSearch

Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd
                                        
Set rstBROPATH = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from BROPATH" 
rstBROPATH.Open sSQL, conn, 3, 3
if not rstBROPATH.eof then
    sNumRows = rstBROPATH("NUMROWS")
end if
pCloseTables(rstBROPATH)

PageLen = Cint(sNumRows)

if request("Page") <> "" and trim(request("btnSubmit")) = "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

if sEMP_CODE <> "" then
    sSQL_1 = " and ( tmeoff.EMP_CODE like '%" & sEMP_CODE & "%') "
end if

if dtpFrDate <> "" then 
    sSQL_1 = sSQL_1 & " and DTFR >= '" & fdate2(dtpFrDate) & "' and DTTO <='" & fdate2(dtpToDate) & "'"
end if

if sTOff_ID <> "" then 
    sSQL_1 = sSQL_1 & " and TOFF_ID = '" & sTOff_ID & "'"
end if

sSQL = "select tmemply.EMP_CODE, tmemply.NAME, DTFR, DTTO, DURA, TOFF_ID, LTYPE, REMARK"
sSQL = sSQL & " from TMEMPLY left join TMEOFF"
sSQL = sSQL & " on tmemply.EMP_CODE = tmeoff.EMP_CODE" 
sSQL = sSQL & " where not isnull(DTFR)"
if sSQL_1 <> "" then
	sSQL = sSQL & sSQL_1
end if 

if sOrderBy = "undefined"  then
    sSQL = sSQL & " order by DTFR desc"
else
    if sAscDesc = "Asc" then
        sSQL = sSQL & " order by " & sOrderBy & " asc ,  DTFR desc"
    elseif sAscDesc = "Desc" then
        sSQL = sSQL & " order by " & sOrderBy & " desc, DTFR desc"
    end if
end if

set rstTMEOFF = server.createobject("adodb.recordset")
rstTMEOFF.cursortype = adOpenStatic
rstTMEOFF.cursorlocation = adUseClient
rstTMEOFF.locktype = adLockBatchOptimistic
rstTMEOFF.pagesize = PageLen		
rstTMEOFF.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMEOFF.eof then
 	rstTMEOFF.absolutepage = iCurPage
 	iPageCount = rstTMEOFF.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMEOFF.RecordCount
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
'*************** Close Object and Open New RecordSet ***************'

i = 0
%>
    <div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
    <br />
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <%If sAscDesc ="Desc" then %>
                    <th style="width:5%">No</th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','tmeoff.EMP_CODE','Asc');">Employee Code</a></th>
                    <th style="width:20%"><a href="javascript:showContent('page=<%=PageNo%>','tmemply.NAME','Asc');">Name</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','DTFR','Asc');">From Date</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','DTTO','Asc');">To Date</a></th>
                    <th style="width:7%"><a href="javascript:showContent('page=<%=PageNo%>','DURA','Asc');">Duration</a></th>
                    <th style="width:12%"><a href="javascript:showContent('page=<%=PageNo%>','TOFF_ID','Asc');">Time Off Code</a></th>
                    <!--<th style="width:5%"><a href="javascript:showContent('page=<%=PageNo%>','LTYPE','Asc');">Type</a></th>-->
                    <th style="width:15%">Remark</th>
                    <th style="width:5%;text-align:center">Edit</th>
                <%else %>
                    <th style="width:5%">No</th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','tmeoff.EMP_CODE','Desc');">Employee Code</a></th>
                    <th style="width:20%"><a href="javascript:showContent('page=<%=PageNo%>','tmemply.NAME','Desc');">Name</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','DTFR','Desc');">From Date</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','DTTO','Desc');">To Date</a></th>
                    <th style="width:7%"><a href="javascript:showContent('page=<%=PageNo%>','DURA','Desc');">Duration</a></th>
                    <th style="width:12%"><a href="javascript:showContent('page=<%=PageNo%>','TOFF_ID','Desc');">Time Off Code</a></th>
                    <!--<th style="width:5%"><a href="javascript:showContent('page=<%=PageNo%>','LTYPE','Desc');">Type</a></th>-->
                    <th style="width:15%">Remark</th>
                    <th style="width:5%;text-align:center">Edit</th>

                <%end if %>

            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstTMEOFF.eof and i < PageLen
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                    response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                    response.write "<td>" & rstTMEOFF("EMP_CODE") & "</td>"
                    response.write "<td>" & rstTMEOFF("NAME") & "</td>"
                    response.write "<td>" & rstTMEOFF("DTFR") & "</td>"
                    response.write "<td>" & rstTMEOFF("DTTO") & "</td>"
                    response.write "<td>" & rstTMEOFF("DURA") & "</td>"
                    response.write "<td>" & rstTMEOFF("TOFF_ID") & "</td>"
                    'response.write "<td>" & rstTMEOFF("LTYPE") & "</td>"
                    response.write "<td>" & rstTMEOFF("REMARK") & "</td>"
                    response.write "<td style=""width:2%;text-align:center""><a href='tmeoff_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtEMP_CODE="& rstTMEOFF("EMP_CODE") & "&dtFr="& rstTMEOFF("DTFR") & "&dtTo="& rstTMEOFF("DTTO") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstTMEOFF.movenext
            loop
            call pCloseTables(rstTMEOFF)

            %>                     
        </tbody>
        
    </table>
    </div>
    <br />
    <div class="row">
        <div class="col-sm-5" style="margin-top:5px">
        
            TOTAL RECORDS (<%=TotalRecord%>) <%=lg_page%> <%=PageNo%> / <%=TotalPage%>
        </div>
        <div class="col-sm-7">
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
