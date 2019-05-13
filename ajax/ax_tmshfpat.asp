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
  	sql_1 = "where (SHFPAT_ID like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (PART like '%" & ScStr & "%') "
end if

sql = "select DISTINCT SHFPAT_ID, PART from TMSHFPAT " ' Here I only call DISTINCT record
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & "order by autoinc asc "

set rstTMSHFPAT = server.createobject("adodb.recordset")
rstTMSHFPAT.cursortype = adOpenStatic
rstTMSHFPAT.cursorlocation = adUseClient
rstTMSHFPAT.locktype = adLockBatchOptimistic
rstTMSHFPAT.pagesize = PageLen		
rstTMSHFPAT.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMSHFPAT.eof then
 	rstTMSHFPAT.absolutepage = iCurPage
 	iPageCount = rstTMSHFPAT.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMSHFPAT.RecordCount
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
    <style>
        .block {
      float: left;
      width: 10px;
      height: 30px;
      margin: 2px;
      border: 1px solid rgba(0, 0, 0, .2);
    }
    </style>
    <div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
    <br />
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width:5%">No</th>
                <th style="width:15%">Name</th>
                <th style="width:30%">Description</th>
                <th style="width:40%">Pattern</th>
                <th style="width:5%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstTMSHFPAT.eof and i < PageLen
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                response.write "<td>" & rstTMSHFPAT("SHFPAT_ID") & "</td>"
                response.write "<td>" & rstTMSHFPAT("PART") & "</td>"
                response.write "<td>"
                                    Set rs = server.CreateObject("ADODB.RecordSet")  'HERE i retrive back the total records  
                                    sSQL = "select * from TMSHFPAT where SHFPAT_ID ='" & rstTMSHFPAT("SHFPAT_ID") & "'" 
                                    rs.Open sSQL, conn, 3, 3        
                                        do while not rs.eof
                                            response.write "<div>"
                                            For k = 1 to 7
                                                variable = "DAY_" & k    
                                                Set rstTMSHFCODE = server.CreateObject("ADODB.RecordSet")    
                                                sSQL = "select color from TMSHFCODE where SHF_CODE ='" & rs("" & variable & "") & "'"
                                                rstTMSHFCODE.Open sSQL, conn, 3, 3
                                                if not rstTMSHFCODE.eof then
                                                    response.write "<div class='block' style='background:"& rstTMSHFCODE("COLOR") & ";'></div>" 
                                                end if
                                                next
                                           response.write "<div class='block' style='width:30px;border:none'>&nbsp;</div>"
                                           response.write "</div>"
                                            rs.movenext
                                        loop
                response.write "</td>"
                response.write "<td style=""width:2%;text-align:center""><a href='tmshfpat_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtSHFPAT_ID="& rstTMSHFPAT("SHFPAT_ID") & "&EorS=Y'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstTMSHFPAT.movenext
            loop
            call pCloseTables(rstTMSHFPAT)

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
