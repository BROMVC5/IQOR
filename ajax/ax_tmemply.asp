<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
                                        
Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd

txtSearch = trim(request("txtSearch"))
sOrderBy = trim(request("sOrderBy"))
sAscDesc = trim(request("sAscDesc"))

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

sSQL = "select EMP_CODE, CARDNO, tmemply.NAME, tmemply.COST_ID, PART, DEPT_ID, DESIGN_ID, SUP_CODE, DT_RESIGN from TMEmply "
sSQL = sSQL & " left join TMCost on tmemply.cost_id = tmcost.cost_id "

if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sSQL_1 = "where (EMP_CODE like '%" & ScStr & "%') "
  	sSQL_1 = sSQL_1 & " or (tmemply.NAME like '%" & ScStr & "%') "
    sSQL = sSQL & sSQL_1
end if

if sOrderBy <> ""  then
    if sAscDesc = "Asc" then
        sSQL = sSQL & "order by " & sOrderBy
    elseif sAscDesc = "Desc" then
        sSQL = sSQL & "order by " & sOrderBy & " desc"
    end if
end if
    'response.write sSQL 

set rstTMEmply = server.createobject("adodb.recordset")
rstTMEmply.cursortype = adOpenStatic
rstTMEmply.cursorlocation = adUseClient
rstTMEmply.locktype = adLockBatchOptimistic
rstTMEmply.pagesize = PageLen		
rstTMEmply.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMEmply.eof then
 	rstTMEmply.absolutepage = iCurPage
 	'iPageCount = rstTMEmply.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMEmply.RecordCount
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
                <%If sAscDesc ="Desc" then %>
                    <th style="width:7%"><a href="javascript:showContent('page=<%=PageNo%>','EMP_CODE','Asc');">Emp Code</th>
                    <th style="width:7%"><a href="javascript:showContent('page=<%=PageNo%>','CARDNO','Asc');">Card No</a></th>
                    <th style="width:17%"><a href="javascript:showContent('page=<%=PageNo%>','tmemply.NAME','Asc');">Full Name</a></th>
                    <th style="width:5%"><a href="javascript:showContent('page=<%=PageNo%>','DEPT_ID','Asc');">Depart</a></th>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','tmemply.COST_ID','Asc');">Cost Center</a></th>
                    <th style="width:13%"><a href="javascript:showContent('page=<%=PageNo%>','PART','Asc');">Cost Part</a></th>
                    <th style="width:14%"><a href="javascript:showContent('page=<%=PageNo%>','DESIGN_ID','Asc');">Designation</a></th>
                    <th style="width:14%"><a href="javascript:showContent('page=<%=PageNo%>','SUP_CODE','Asc');">Superior</a></th>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','DT_RESIGN','Asc');">Date Resign</a></th>
                    
                <%else %>
                    <th style="width:7%"><a href="javascript:showContent('page=<%=PageNo%>','EMP_CODE','Desc');">Emp Code</th>
                    <th style="width:7%"><a href="javascript:showContent('page=<%=PageNo%>','CARDNO','Desc');">Card No</a></th>
                    <th style="width:17%"><a href="javascript:showContent('page=<%=PageNo%>','tmemply.NAME','Desc');">Full Name</a></th>
                    <th style="width:5%"><a href="javascript:showContent('page=<%=PageNo%>','DEPT_ID','Desc');">Depart</a></th>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','tmemply.COST_ID','Desc');">Cost Center</a></th>
                    <th style="width:13%"><a href="javascript:showContent('page=<%=PageNo%>','PART','Desc');">Cost Part</a></th>
                    <th style="width:14%"><a href="javascript:showContent('page=<%=PageNo%>','DESIGN_ID','Desc');">Designation</a></th>
                    <th style="width:14%"><a href="javascript:showContent('page=<%=PageNo%>','SUP_CODE','Desc');">Superior</a></th>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','DT_RESIGN','Desc');">Date Resign</a></th>
                <%end if %>
                <th style="width:3%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstTMEmply.eof and i < PageLen
                                            
                    sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                    i = i + 1                             
                    response.write "<tr>"
                        response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                        response.write "<td>" & rstTMEmply("EMP_CODE") & "</td>"
                        response.write "<td>" & rstTMEmply("CARDNO") & "</td>"
                        response.write "<td>" & rstTMEmply("NAME") & "</td>"
                        response.write "<td>" & rstTMEmply("DEPT_ID") & "</td>"
                        response.write "<td>" & rstTMEmply("COST_ID") & "</td>"
                        response.write "<td>" & rstTMEmply("PART") & "</td>"
                        response.write "<td>" & rstTMEmply("DESIGN_ID") & "</td>"
                        Set rsSUPNAME = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEMPLY where EMP_CODE='" & rstTMEmply("SUP_CODE") & "'" 
                        rsSUPNAME.Open sSQL, conn, 3, 3
                            if not rsSUPNAME.eof then
                                response.write "<td>" & rsSUPNAME("NAME") & "</td>"
                            else
                                response.write "<td> </td>"
                            end if
                        pClosetables(rsSUPNAME)    
                        response.write "<td>" & rstTMEmply("DT_RESIGN") & "</td>"
                        response.write "<td style=""text-align:center""><a href='tmemply_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtEMP_CODE="& rstTMEmply("EMP_CODE") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                    response.write "</tr>"
                    rstTMEmply.movenext
                loop
            call pCloseTables(rstTMEmply)

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
