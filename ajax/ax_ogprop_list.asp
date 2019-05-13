<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<meta http-equiv=Content-Type content='text/html; charset=utf-8'>    


<%
sStatus = request("List")
                                        
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

Set rstOGPass = server.CreateObject("ADODB.RecordSet")
sql = "select * from ogpass where ID = '" & session("USERNAME") & "' "
rstOGPass.Open sql, conn, 3, 3
if not rstOGPass.eof then
	if rstOGPass("OGACCESS") = "N" then
		sAccess = "N"
	elseif rstOGPass("OGACCESS") = "A" then
		sAccess = "A"
	elseif rstOGPass("OGACCESS") = "F" then
		sAccess = "F"
	elseif rstOGPass("OGACCESS") = "D" then
		sAccess = "D"
	elseif rstOGPass("OGACCESS") = "S" then
		sAccess = "S"
	end if
end if
call pCloseTables(rstOGPass)


txtSearch = trim(request("txtSearch"))
if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "and ((ogprop.EMP_CODE like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (tmemply.NAME like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (ogprop.TICKET_NO like '%" & ScStr & "%')) "

end if

if sStatus = "Appr" then
sql = "select distinct(ogprop.TICKET_NO), ogprop.EMP_CODE, ogprop.DATETIME, ogprop.RSTATUS, ogprop.STATUS,ogprop1.DT_RETURN, tmemply.NAME from ogprop "
sql = sql & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
sql = sql & "left join ogprop1 on ogprop.TICKET_NO = ogprop1.TICKET_NO "
sql = sql & "where ogprop.STATUS = 'A' and (RSTATUS = 'Y' or RSTATUS = 'N') and BAL <> '0' and SSTATUS = 'A' and ASTATUS = 'N' "
if sAccess = "N" then
	sql = sql & "and (ogprop.EMP_CODE = '" & session("USERNAME") & "' or ogprop.CREATE_ID = '" & session("USERNAME") & "') "
end if
elseif sStatus = "Comp" then
sql = "select distinct(ogprop.TICKET_NO), ogprop.EMP_CODE, ogprop.DATETIME, ogprop.RSTATUS, ogprop.STATUS, ogprop.STATUS, tmemply.NAME from ogprop "
sql = sql & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
sql = sql & "left join ogprop1 on ogprop.TICKET_NO = ogprop1.TICKET_NO "
sql = sql & "where ogprop1.TICKET_NO NOT IN (select TICKET_NO from ogprop1 where BAL <> '0') and (RSTATUS = 'N' or RSTATUS = 'Y') and STATUS = 'A' and SSTATUS = 'A' and ASTATUS = 'Y' "
if sAccess = "N" then
	sql = sql & "and (ogprop.EMP_CODE = '" & session("USERNAME") & "' or ogprop.CREATE_ID = '" & session("USERNAME") & "') "
end if
elseif sStatus = "Ack" then
sql = "select distinct(ogprop.TICKET_NO), ogprop.EMP_CODE, ogprop.DATETIME, ogprop.RSTATUS, ogprop.STATUS, ogprop.STATUS, tmemply.NAME from ogprop "
sql = sql & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
sql = sql & "left join ogprop1 on ogprop.TICKET_NO = ogprop1.TICKET_NO "
sql = sql & "where ogprop1.TICKET_NO NOT IN (select TICKET_NO from ogprop1 where BAL <> '0') and (RSTATUS = 'N' or RSTATUS = 'Y') and STATUS = 'A' and SSTATUS = 'A' and ASTATUS = 'N' "
if sAccess = "N" then
	sql = sql & "and (ogprop.EMP_CODE = '" & session("USERNAME") & "' or ogprop.CREATE_ID = '" & session("USERNAME") & "') "
end if
elseif sStatus = "Pend" then
sql = "select ogprop.TICKET_NO, ogprop.EMP_CODE, ogprop.DATETIME, ogprop.RSTATUS, ogprop.STATUS, tmemply.NAME from ogprop "
sql = sql & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
sql = sql & "where ogprop.STATUS = 'P' "
if sAccess = "N" then
	sql = sql & "and (ogprop.EMP_CODE = '" & session("USERNAME") & "' or ogprop.CREATE_ID = '" & session("USERNAME") & "') "
end if
elseif sStatus = "Rej" then
sql = "select ogprop.TICKET_NO, ogprop.EMP_CODE, ogprop.DATETIME, ogprop.RSTATUS, ogprop.STATUS, tmemply.NAME from ogprop "
sql = sql & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
sql = sql & "where ogprop.STATUS = 'R' "
if sAccess = "N" then
	sql = sql & "and (ogprop.EMP_CODE = '" & session("USERNAME") & "' or ogprop.CREATE_ID = '" & session("USERNAME") & "') "
end if
elseif sStatus = "SRej" then
sql = "select ogprop.TICKET_NO, ogprop.EMP_CODE, ogprop.DATETIME, ogprop.RSTATUS, ogprop.STATUS, tmemply.NAME from ogprop "
sql = sql & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
sql = sql & "where ogprop.SSTATUS = 'R' "
if sAccess = "N" then
	sql = sql & "and (ogprop.EMP_CODE = '" & session("USERNAME") & "' or ogprop.CREATE_ID = '" & session("USERNAME") & "') "
end if
elseif sStatus = "All" then
sql = "select ogprop.TICKET_NO, ogprop.EMP_CODE, ogprop.DATETIME, ogprop.RSTATUS, ogprop.STATUS, tmemply.NAME from ogprop "
sql = sql & "left join tmemply on ogprop.EMP_CODE = tmemply.EMP_CODE "
sql = sql & "where 1=1 "
if sAccess = "N" then
	sql = sql & "and (ogprop.EMP_CODE = '" & session("USERNAME") & "' or ogprop.CREATE_ID = '" & session("USERNAME") & "') "
end if

end if
if sql_1 <> "" then
	sql = sql & sql_1
end if 

sql = sql & "order by ogprop.TICKET_NO desc "
set rstOGProp = server.createobject("adodb.recordset")
rstOGProp.cursortype = adOpenStatic
rstOGProp.cursorlocation = adUseClient
rstOGProp.locktype = adLockBatchOptimistic
rstOGProp.pagesize = PageLen

rstOGProp.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstOGProp.eof then
 	rstOGProp.absolutepage = iCurPage
 	iPageCount = rstOGProp.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstOGProp.RecordCount
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
                <th style="width:3%">Ticket No</th>
                <th style="width:7%">Employee Code</th>
                <th style="width:20%">Full Name</th>
                <th style="width:5%">Date</th>
                <th style="width:5%;text-align:center">Property Return</th>
                <%if sStatus = "All" then%>
                <th style="width:5%;text-align:center">Status</th>
                <%end if%>
                <th style="width:5%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
            if sStatus = "All" then 
            	do while not rstOGProp.eof and i < iRecCount
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<td>" & rstOGProp("TICKET_NO") & "</td>"
                response.write "<td>" & rstOGProp("EMP_CODE") & "</td>"
                response.write "<td>" & rstOGProp("NAME") & "</td>"
                response.write "<td>" & fDatelong(rstOGProp("DATETIME")) & "</td>"
                if rstOGProp("RSTATUS") = "Y" then
               		response.write "<td style=""text-align:center""><i style='color:green' class='fa fa-check'></i></td>" 
                else
                	response.write "<td style=""text-align:center""><i style='color:red' class='fa fa-remove'></i></td>" 
				end if
				if rstOGProp("STATUS") = "P" then
					response.write "<td style=""text-align:center"">Pending</td>"
				elseif rstOGProp("STATUS") = "A" then
					response.write "<td style=""text-align:center"">Approved</td>"
				elseif rstOGProp("STATUS") = "R" then
					response.write "<td style=""text-align:center"">Reject</td>"
				end if
                response.write "<td style=""text-align:center""><a href='oglist_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtTicket="& rstOGProp("TICKET_NO") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstOGProp.movenext
	            loop
	            call pCloseTables(rstOGProp)
	
			else    
			                      
                do while not rstOGProp.eof and i < iRecCount
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<td>" & rstOGProp("TICKET_NO") & "</td>"
                response.write "<td>" & rstOGProp("EMP_CODE") & "</td>"
                response.write "<td>" & rstOGProp("NAME") & "</td>"
                response.write "<td>" & fDatelong(rstOGProp("DATETIME")) & "</td>"
                if rstOGProp("RSTATUS") = "Y" then
               		response.write "<td style=""text-align:center""><i style='color:green' class='fa fa-check'></i></td>" 
                else
                	response.write "<td style=""text-align:center""><i style='color:red' class='fa fa-remove'></i></td>" 
				end if
                response.write "<td style=""text-align:center""><a href='oglist_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtTicket="& rstOGProp("TICKET_NO") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstOGProp.movenext
	            loop
	            call pCloseTables(rstOGProp)
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
