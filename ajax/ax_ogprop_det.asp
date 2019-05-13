<!DOCTYPE html>


<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<!-- #include file="../include/validate.asp"-->

<%
                                      
Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd
                                        
iRecCount = 5

PageLen = iRecCount

if request("Page") <> "1" and trim(request("btnSubmit")) = "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

sTicket = UCase(request("txtTicket"))
    
sql = "select * from ogprop1 where TICKET_NO = '" & sTicket & "'"
sql = sql & "order by autoinc asc "

set rstOGProp1 = server.createobject("adodb.recordset")
rstOGProp1.cursortype = adOpenStatic
rstOGProp1.cursorlocation = adUseClient
rstOGProp1.locktype = adLockBatchOptimistic
rstOGProp1.pagesize = PageLen		
rstOGProp1.Open sql, conn, 3, 3

Set rstOGProp = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from ogprop where TICKET_NO ='" & sTicket & "'" 
rstOGProp.Open sSQL, conn, 3, 3
if not rstOGProp.eof then
	sStatus = rstOGProp("STATUS")
end if
call pCloseTables(rstOGProp)

'**************** Paging/Pagination Calculator ***************'
If not rstOGProp1.eof then
 	rstOGProp1.absolutepage = iCurPage
 	iPageCount = rstOGProp1.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstOGProp1.RecordCount
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
    <br/>
    <table id="example1" class="table table-bordered table-striped">
            <thead>
            <tr>
            	<th style="width:5%">No</th>
                <th style="width:15%">Serial/Part No</th>
                <th style="width:30%">Property Description</th>
                <th style="width:5%">Qty</th>
                <th style="width:30%;">Purpose</th>
                <th style="width:10%;">Due Date</th>
                <th style="width:10%;text-align:center">Delete</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                if not rstOGProp1.eof then
                                        
		            do while not rstOGProp1.eof and i < iRecCount
				                          
		            i = i + 1                          
		            response.write "<tr>"
		            response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
		            response.write "<td>" & rstOGProp1("SERIAL") & "</td>"
		            response.write "<td>" & rstOGProp1("PART") & "</td>"  
		            response.write "<td>" & pFormat(rstOGProp1("QTY"),2) & "</td>"
		            response.write "<td>" & rstOGProp1("PURPOSE") & "</td>"
		            response.write "<td>" & rstOGProp1("DT_DUE") & "</td>"
		            response.write "<td style=""text-align:center"">" %>
		            <%if sStatus = "P" then%>
		            <a href="#" onclick="fOpen('DELP','<%=rstOGProp1("AUTOINC")%>','mycontent','#mymodal')"><img src="dist/img/x-mark-24.png" /></a>
		            <%else%>
		            <a href="#"></a>
		            <%end if%>
		            <%
		            response.write "</td>"
		            response.write "</tr>"
		            rstOGProp1.movenext
		            
			        loop
			        call pCloseTables(rstOGProp1)
				end if
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

