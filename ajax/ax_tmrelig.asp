<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
                                        
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

txtSearch = trim(request("txtSearch"))
if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "where (RELIG like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (part like '%" & ScStr & "%') "
end if

sql = "select RELIG, part from TMRELIG "
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & "order by RELIG asc "

set rstTMRELIG = server.createobject("adodb.recordset")
rstTMRELIG.cursortype = adOpenStatic
rstTMRELIG.cursorlocation = adUseClient
rstTMRELIG.locktype = adLockBatchOptimistic
rstTMRELIG.pagesize = PageLen		
rstTMRELIG.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMRELIG.eof then
 	rstTMRELIG.absolutepage = iCurPage
 	iPageCount = rstTMRELIG.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMRELIG.RecordCount
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
                <th style="width:5%">No</th>
                <th style="width:30%">Religion</th>
                <th style="width:35%">Description</th>
                <th style="width:10%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstTMRELIG.eof and i < PageLen
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                response.write "<td>" & rstTMRELIG("RELIG") & "</td>"
                response.write "<td>" & rstTMRELIG("PART") & "</td>"
                response.write "<td style=""width:2%;text-align:center""><a href='tmrelig_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtRELIG="& rstTMRELIG("RELIG") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstTMRELIG.movenext
            loop
            call pCloseTables(rstTMRELIG)

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
                        <li class="paginate_button"><a href="javascript:showContent('page=1');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=PageNo-1%>');" class="button_a" >< Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showContent('page=<%=intID%>');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=PageNo+1%>');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=TotalPage%>');" class="button_a" >Last >></a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- /.box -->
