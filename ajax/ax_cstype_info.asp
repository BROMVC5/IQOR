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
  	sql_1 = "where (SUBTYPE like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (PART like '%" & ScStr & "%') "
end if

sql = "select SUBTYPE,PART,STIME,ETIME,AMOUNT,PRIORITY,STATUS from cstype "
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & "order by SUBTYPE asc "

set rstCSType = server.createobject("adodb.recordset")
rstCSType.cursortype = adOpenStatic
rstCSType.cursorlocation = adUseClient
rstCSType.locktype = adLockBatchOptimistic
rstCSType.pagesize = PageLen		
rstCSType.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstCSType.eof then
 	rstCSType.absolutepage = iCurPage
 	iPageCount = rstCSType.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstCSType.RecordCount
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
                <th style="width:10%">Subsidy Type</th>
                <th style="width:20%">Description</th>
                <th style="width:10%">Start Time</th>
                <th style="width:10%">End Time</th>
                <th style="width:10%;text-align:right">Amount(RM)</th>
                <th style="width:5%;text-align:right">Priority</th>
                <th style="width:5%;text-align:center">Status</th>
                <th style="width:5%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
             if not rstCSType.eof then                          
                do while not rstCSType.eof and i < iRecCount
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                response.write "<td>" & rstCSType("SUBTYPE") & "</td>"
                response.write "<td>" & rstCSType("PART") & "</td>"
                response.write "<td>" & rstCSType("STIME") & "</td>"
                response.write "<td>" & rstCSType("ETIME") & "</td>"
				response.write "<td style=""text-align:right"">" & pFormat(rstCSType("AMOUNT"),2) & "</td>"
				response.write "<td style=""text-align:right"">" & rstCSType("PRIORITY") & "</td>"
				if rstCSType("STATUS") = "A" then
                	response.write "<td style=""text-align:center""><b style='color:green'>Active</b></td>"
				else
                	response.write "<td style=""text-align:center""><b style='color:red'>Inactive</b></td>"
                end if
                response.write "<td style=""text-align:center""><a href='cstype_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtSubType="& rstCSType("SUBTYPE") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstCSType.movenext
           		
           		loop
            end if
            call pCloseTables(rstCSType)

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
