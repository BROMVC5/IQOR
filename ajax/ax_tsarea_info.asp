<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>    


<%
                                        
if iPage = "" then
	iPage = 1
end if
sAddURL = "&page=" & iPage & "&txtSearch=" & sSearch

Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd
                                        
iRecCount = 10

PageLen = iRecCount

if request("Page") <> "" and trim(request("btnSubmit")) = "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

txtSearch = trim(request("txtSearch"))
if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "where ((AREACODE like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (AREA like '%" & ScStr & "%')) "
end if

sql = "select AREACODE,AREA,ROUTE,STATUS from tsarea  "
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & "order by AREACODE asc "

set rstTSArea = server.createobject("adodb.recordset")
rstTSArea.cursortype = adOpenStatic
rstTSArea.cursorlocation = adUseClient
rstTSArea.locktype = adLockBatchOptimistic
rstTSArea.pagesize = PageLen		
rstTSArea.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTSArea.eof then
 	rstTSArea.absolutepage = iCurPage
 	iPageCount = rstTSArea.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTSArea.RecordCount
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
                <th style="width:3%">No</th>
                <th style="width:10%">Area Code</th>
                <th style="width:20%">Area</th>
                <th style="width:50%">Route</th>
                <th style="width:5%;text-align:center">Status</th>
                <th style="width:5%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
             if not rstTSArea.eof then                          
                do while not rstTSArea.eof and i < iRecCount
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                response.write "<td>" & rstTSArea("AREACODE") & "</td>"
                response.write "<td>" & rstTSArea("AREA") & "</td>"
                response.write "<td>" & rstTSArea("ROUTE") & "</td>"
				if rstTSArea("STATUS") = "A" then
                	response.write "<td style=""text-align:center""><b style='color:green'>Active</b></td>"
				else
                	response.write "<td style=""text-align:center""><b style='color:red'>Inactive</b></td>"
                end if
                response.write "<td style=""text-align:center""><a href='tsarea_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtAreaCode="& rstTSArea("AREACODE") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstTSArea.movenext
           		
           		loop
            end if
            call pCloseTables(rstTSArea)

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
                        <li class="paginate_button"><a href="javascript:showContent('page=1');" class="button_a" >
						&lt;&lt; First</a></li>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=PageNo-1%>');" class="button_a" >
						&lt; Back</a></li>
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
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=PageNo+1%>');" class="button_a" >
						Next &gt;</a></li>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=TotalPage%>');" class="button_a" >
						Last &gt;&gt;</a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- /.box -->
