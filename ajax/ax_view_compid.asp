<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
sSearch = request("txtSearch")
iPage = 1

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
  	sql_1 = "and (compname like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (status like '%" & ScStr & "%') "
	sql_1 = sql_1 & " or (user_id like '%" & ScStr & "%') "
end if

sql = "select compname, status, create_id , dt_create from VRCOMP "
sql = sql & " where status <> 'N' "
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & "order by compname asc "

set rstVRComp = server.createobject("adodb.recordset")
rstVRComp.cursortype = adOpenStatic
rstVRComp.cursorlocation = adUseClient
rstVRComp.locktype = adLockBatchOptimistic
rstVRComp.pagesize = PageLen		
rstVRComp.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstVRComp.eof then
 	rstVRComp.absolutepage = iCurPage
 	iPageCount = rstVRComp.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstVRComp.RecordCount
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
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-3">
                <div class="pull-left">
                    <h3>View Company</h3>
                </div>
            </div>
            <div class="col-sm-4 pull-right">
                <div class="input-group">
                    <input class="form-control" id="txtSearch_comp" name="txtSearch" value="<%=sSearch%>" placeholder="Search" maxlength="100" type="text" />
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="submit" name="search" value="Search" onclick="showDetails('page=1','txtComp_Name','COMP','mycontent');return false;"><i class="fa fa-search"></i>
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
                <th style="width:30%">Company Name</th>
				<th style="width:8%;text-align:center">Active</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstVRComp.eof and i < iRecCount
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
				response.write "<tr onmouseover=this.bgColor='#FFF59D' onmouseout=this.bgColor='white' onclick=""getValue('" & server.HTMLEncode(rstVRComp("COMPNAME")) & "','txtComp_Name')"">"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                response.write "<td>" & rstVRComp("COMPNAME") & "</td>"
				if rstVRComp("STATUS") = "Y" then
               		response.write "<td style=""text-align:center""><b style='color:green'>Active</b></td>" 
				else
					response.write "<td style=""text-align:center""><b style='color:red'>Inactive</b></td>"
				end if
                response.write "</tr>"
                rstVRComp.movenext
            loop
            call pCloseTables(rstVRComp)

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
                        <li class="paginate_button"><a href="javascript:showDetails('page=1','','COMP','mycontent');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo-1%>','','COMP','mycontent');" class="button_a" >< Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showDetails('page=<%=intID%>','','COMP','mycontent');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo+1%><%=strURL%>','','COMP','mycontent');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=TotalPage%><%=strURL%>','','COMP','mycontent');" class="button_a" >Last >></a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
</section>
    
    <!-- /.box -->
