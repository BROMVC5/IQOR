<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    
<%
sFldName = request("fldName")

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
  	sql_1 = "where (cost_id like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (part like '%" & ScStr & "%') "
end if

sql = "select cost_id, part from tmcost "
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & "order by cost_id asc "

set rstTMCost = server.createobject("adodb.recordset")
rstTMCost.cursortype = adOpenStatic
rstTMCost.cursorlocation = adUseClient
rstTMCost.locktype = adLockBatchOptimistic
rstTMCost.pagesize = PageLen		
rstTMCost.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMCost.eof then
 	rstTMCost.absolutepage = iCurPage
 	iPageCount = rstTMCost.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMCost.RecordCount
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
            <div class="col-sm-5">
                <div class="pull-left">
                    <h3>View Cost Center</h3>
                </div>
            </div>
            <div class="col-sm-4 pull-right">
                <div class="input-group">
                    
                    <input class="form-control" id="txtSearch" name="txtSearch" value="<%=txtSearch%>" placeholder="Search" maxlength="100" type="text" />
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="submit" name="search" value="Search" onclick="showDetails('page=1','<%=sFldName%>','COST','mycontent');return false;"><i class="fa fa-search"></i>
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
                <th style="width:30%">Cost Center ID</th>
                <th style="width:35%">Description</th>
                <th style="width:10%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstTMCost.eof and i < iRecCount
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<tr onmouseover=this.bgColor='#FFF59D' onmouseout=this.bgColor='white' onclick=""getValue('" & server.HTMLEncode(rstTMCost("COST_ID")) & "', '"& sFldName &"')"">"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                response.write "<td>" & rstTMCost("COST_ID") & "</td>"
                response.write "<td>" & rstTMCost("part") & "</td>"
                response.write "<td style='text-align:center'><button id=""btnSelect"" class=""btn btn-primary btn-sm"" onclick=""getValue('" & server.HTMLEncode(rstTMCost("COST_ID")) & "', '"& sFldName &"')"">Select</button></td>"
                response.write "</tr>"
                rstTMCost.movenext
            loop
            call pCloseTables(rstTMCost)

            %>                     
        </tbody>
        
    </table>
    </div>
    <br />
    <div class="row">
        <div class="col-sm-5" style="margin-top:5px">
        <%
            '--strURL - this variable no longer in use due to AJAX method
            '--strURL = "&txtSearch=" & sSearch 
        %>
            TOTAL RECORDS (<%=TotalRecord%>) <%=lg_page%> <%=PageNo%> / <%=TotalPage%>
        </div>
        <div class="col-sm-7">
            <div class="dataTables_paginate">
                <ul class="pagination">
                    <%IF Cint(PageNo) > 1 then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=1<%=strURL%>','<%=sFldName%>','COST','mycontent');" class="button_a" >
						&lt;&lt; First</a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo-1%><%=strURL%>','<%=sFldName%>','COST','mycontent');" class="button_a" >
						&lt; Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showDetails('page=<%=intID%><%=strURL%>','<%=sFldName%>','COST','mycontent');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo+1%><%=strURL%>','<%=sFldName%>','COST','mycontent');" class="button_a" >
						Next &gt;</a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=TotalPage%><%=strURL%>','<%=sFldName%>','COST','mycontent');" class="button_a" >
						Last &gt;&gt;</a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
</section>
    
    <!-- /.box -->
