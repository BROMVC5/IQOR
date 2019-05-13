<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
iPage = 1

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
  	sql_1 = "where (EMP_CODE like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (NAME like '%" & ScStr & "%') "
end if

sql = "select EMP_CODE, NAME from TMEMPLY "
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & "order by EMP_CODE, NAME "

set rstTMEMPLY = server.createobject("adodb.recordset")
rstTMEMPLY.cursortype = adOpenStatic
rstTMEMPLY.cursorlocation = adUseClient
rstTMEMPLY.locktype = adLockBatchOptimistic
rstTMEMPLY.pagesize = PageLen		
rstTMEMPLY.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMEMPLY.eof then
 	rstTMEMPLY.absolutepage = iCurPage
 	iPageCount = rstTMEMPLY.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMEMPLY.RecordCount
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
 <section class="content">
    <form id="viewform" class="form-horizontal" action="javascript:showDetails('page=1','EMP','mycontent');") method="post">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-4">
                <div class="pull-left">
                    <h3>View Cost Center Manager</h3>
                </div>
            </div>
            <div class="col-sm-4 pull-right">
                <div class="input-group">
                    
                    <input class="form-control" id="txtSearch" name="txtSearch" value="<%=txtSearch%>" placeholder="Search" maxlength="100" type="text" />
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="submit" name="search" value="Search" onclick="showDetails('page=1','EMP','mycontent');return false;"><i class="fa fa-search"></i>
                        </button>
                    </span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-12">
    <br />
    <table id="example1" class="table table-bordered">
        <thead>
            <tr>
                <th style="width:5%">No</th>
                <th style="width:25%">Employee Code</th>
                <th style="width:25%">Name</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
            do while not rstTMEMPLY.eof and i < iRecCount
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                
                i = i + 1
                response.write "<tr onmouseover=this.bgColor='#FFF59D' onmouseout=this.bgColor='white' onclick=""getValue2('" & rstTMEMPLY("EMP_CODE") & "','txtCostManCode','" & rstTMEMPLY("NAME") & "','txtName')"">"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                response.write "<td>" & rstTMEMPLY("EMP_CODE") & "</td>"
                response.write "<td>" & rstTMEMPLY("NAME") & "</td>"
                response.write "</tr>"
                rstTMEMPLY.movenext
            loop
            call pCloseTables(rstTMEMPLY)

            %>                     
        </tbody>
        
    </table>
    </div>
    <br />
    <div class="row">
        <div class="col-sm-4" style="margin-top:10px">
            TOTAL RECORDS (<%=TotalRecord%>) <%=lg_page%> <%=PageNo%> / <%=TotalPage%>
        </div>
        <div class="col-sm-8">
            <div class="dataTables_paginate">
                <ul class="pagination">
                    <%IF Cint(PageNo) > 1 then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=1','EMP','mycontent');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo-1%>','EMP','mycontent');" class="button_a" >< Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showDetails('page=<%=intID%>','EMP','mycontent');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo+1%><%=strURL%>','EMP','mycontent');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=TotalPage%><%=strURL%>','EMP','mycontent');" class="button_a" >Last >></a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
    </form>
</section>
    
    <!-- /.box -->
