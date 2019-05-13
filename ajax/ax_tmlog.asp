<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
iPage = request("page")
sOrderBy = trim(request("txtOrderBy"))
sAscDesc = trim(request("txtAscDesc"))     
'sEMP_CODE = UCase(request("txtEMP_CODE"))
dtpFrDate = request("dtpFrDate")
dtpToDate = request("dtpToDate")

if dtpFrDate = "" then
    dtpFrDate = "01-01-1000"
end if

if dtpToDate = "" then
    dtpToDate = "31-12-9999"
end if

sStatus = trim(request("selStatus"))

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

'if sEMP_CODE <> "" then
'    sSQL_1 = " and ( tmlog.EMP_CODE like '%" & sEMP_CODE & "%') "
'end if

if dtpFrDate <> "" then 
    sSQL_1 = sSQL_1 & " and DATE(tmlog.DATETIME) between '" & fdate2(dtpFrDate) & "' and '" & fdate2(dtpToDate) & "'"
end if

if sStatus <> "" then 
    sSQL_1 = sSQL_1 & " and STATUS = '" & sStatus & "'"
end if

sSQL = "select tmlog.EMP_CODE as EMPCODE, tmemply.NAME, tmlog.*"
sSQL = sSQL & " from TMlog left join tmemply"
sSQL = sSQL & " on tmemply.EMP_CODE = tmlog.EMP_CODE"
sSQL = sSQL & " where 1=1 " 

if sSQL_1 <> "" then
	sSQL = sSQL & sSQL_1
end if 

if sOrderBy = "undefined"  then
    sSQL = sSQL & " order by tmlog.DATETIME  desc"
else
    if sAscDesc = "Asc" then
        sSQL = sSQL & " order by " & sOrderBy & " asc "
    elseif sAscDesc = "Desc" then
        sSQL = sSQL & " order by " & sOrderBy & " desc"
    end if
end if

 '   response.write sSQL
   
set rsttmlog = server.createobject("adodb.recordset")
rsttmlog.cursortype = adOpenStatic
rsttmlog.cursorlocation = adUseClient
rsttmlog.locktype = adLockBatchOptimistic
rsttmlog.pagesize = PageLen		
rsttmlog.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rsttmlog.eof then
 	rsttmlog.absolutepage = iCurPage
 	iPageCount = rsttmlog.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rsttmlog.RecordCount
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

                    <th style="width:4%">No</th>
                    <th style="width:13%"><a href="javascript:showContent('page=<%=PageNo%>','tmlog.DATETIME','Asc');">Date and Time</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','TYPE','Asc');">Type</a></th>
                    <th style="width:5%"><a href="javascript:showContent('page=<%=PageNo%>','STATUS','Asc');">Status</a></th>
                    <th style="width:28%"><a href="javascript:showContent('page=<%=PageNo%>','REMARK','Asc');">Remark</a></th>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','DT_WORK','Asc');">Date Work</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','tmlog.EMP_CODE','Asc');">Emp Code</a></th>
                    <th style="width:14%"><a href="javascript:showContent('page=<%=PageNo%>','tmemply.NAME','Asc');">Name</a></th>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','USER_ID','Asc');">Updated By</a></th>
                
                <%else %>

                    <th style="width:4%">No</th>
                    <th style="width:13%"><a href="javascript:showContent('page=<%=PageNo%>','tmlog.DATETIME','Desc');">Date and Time</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','TYPE','Desc');">Type</a></th>
                    <th style="width:5%"><a href="javascript:showContent('page=<%=PageNo%>','STATUS','Desc');">Status</a></th>
                    <th style="width:28%"><a href="javascript:showContent('page=<%=PageNo%>','REMARK','Desc');">Remark</a></th>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','DT_WORK','Desc');">Date Work</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','tmlog.EMP_CODE','Desc');">Emp Code</a></th>
                    <th style="width:14%"><a href="javascript:showContent('page=<%=PageNo%>','tmemply.NAME','Desc');">Name</a></th>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','USER_ID','Desc');">Updated By</a></th>

                <%end if %>

            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rsttmlog.eof and i < PageLen
                                            
                    i = i + 1                             
                
                    response.write "<tr>"

                        response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                        response.write "<td>" & rsttmlog("DATETIME") & "</td>"
                        response.write "<td>" & rsttmlog("TYPE") & "</td>"
                        response.write "<td>" & rsttmlog("STATUS") & "</td>"
                        response.write "<td>" & rsttmlog("REMARK") & "</td>"

                        if rsttmlog("DT_WORK") <> "" then
                            response.write "<td>" & rsttmlog("DT_WORK") & "</td>"
                        else 
                            response.write "<td>Not Applicable</td>"
                        end if
                        
                        if rsttmlog("EMPCODE")  <> "" then 
                            response.write "<td>" & rsttmlog("EMPCODE") & "</td>"
                            response.write "<td>" & rsttmlog("NAME") & "</td>"
                        else
                            response.write "<td>Not Applicable</td>"
                            response.write "<td>Not Applicable</td>"
                        end if

                        response.write "<td>" & rsttmlog("USER_ID") & "</td>"
                    response.write "</tr>"
                rsttmlog.movenext
                loop
            call pCloseTables(rsttmlog)

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
