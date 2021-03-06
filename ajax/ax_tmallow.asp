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

if request("Page") <> "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

txtSearch = trim(request("txtSearch"))
if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "where (ALLCODE like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (PART like '%" & ScStr & "%') "
end if

sql = "select DISTINCT ALLCODE, PART, MINWORK, SAPALLCODE from TMALLOW "
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & "order by allcode asc "

set rstTMALLOW = server.createobject("adodb.recordset")
rstTMALLOW.cursortype = adOpenStatic
rstTMALLOW.cursorlocation = adUseClient
rstTMALLOW.locktype = adLockBatchOptimistic
rstTMALLOW.pagesize = PageLen		
rstTMALLOW.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMALLOW.eof then
 	rstTMALLOW.absolutepage = iCurPage
 	iPageCount = rstTMALLOW.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMALLOW.RecordCount
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
                <th style="width:25%">Shift Allowance Code</th>
                <th style="width:30%">Description</th>
                <th style="width:15%">Minimum Work Hours</th>
                <th style="width:15%">SAP Code</th>
                <th style="width:5%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstTMALLOW.eof and i < PageLen
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                response.write "<td>" & rstTMALLOW("ALLCODE") & "</td>"
                response.write "<td>" & rstTMALLOW("PART") & "</td>"
                response.write "<td>" & rstTMALLOW("MINWORK") & "</td>"
                response.write "<td>" & rstTMALLOW("SAPALLCODE") & "</td>"
                response.write "<td style=""width:2%;text-align:center""><a href='tmallow_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtAllCode="& rstTMALLOW("ALLCODE") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstTMALLOW.movenext
            loop
            call pCloseTables(rstTMALLOW)

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
