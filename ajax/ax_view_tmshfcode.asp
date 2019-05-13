<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<!-- JQuery 2.2.3 Compressed -->
<%

Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd
                                        
iRecCount =10

PageLen = iRecCount

if request("Page") <> "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

txtSearch = trim(request("txtSearch"))

if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "where (SHF_CODE like '%" & ScStr & "%') "
  	sql_1 = sql_1 & " or (PART like '%" & ScStr & "%') "
end if

sql = "select SHF_CODE, PART, WORK_ID, STIME, ETIME, COLOR, STATUS from TMSHFCODE "

sql = sql & sql_1
sql = sql & " order by SHF_CODE asc "

set rstTMSHFCODE = server.createobject("adodb.recordset")
rstTMSHFCODE.cursortype = adOpenStatic
rstTMSHFCODE.cursorlocation = adUseClient
rstTMSHFCODE.locktype = adLockBatchOptimistic
rstTMSHFCODE.pagesize = PageLen		
rstTMSHFCODE.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMSHFCODE.eof then
 	rstTMSHFCODE.absolutepage = iCurPage
 	iPageCount = rstTMSHFCODE.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMSHFCODE.RecordCount
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

%>
<section class="content">
    <form id="viewform" class="form-horizontal" action="javascript:showDetails('page=1','SHFCODE','mycontent');") method="post">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-5">
                <div class="pull-left">
                    <h3>View Shift Code</h3>
                </div>
            </div>
            <div class="col-sm-4 pull-right">
                <div class="input-group">
                    
                    <input class="form-control" id="txtSearch_shfcode" name="txtSearch" value="<%=txtSearch%>" placeholder="Search" maxlength="100" type="text" />
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="submit" name="search" value="Search" onclick="showDetails('page=1','SHFCODE','mycontent');return false;"><i class="fa fa-search"></i>
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
                <th style="width:10%">Shift Code</th>
                <th style="width:20%">Description</th>
                <th style="width:15%">Work Location</th>
                <th style="width:10%">Start Time</th>
                <th style="width:10%">End Time</th>
                <th style="width:10%">Color Code</th>
                <th style="width:5%">Status</th>
                
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstTMSHFCODE.eof and i < iRecCount ' When recordset is not EOF and i < iRecCount continue to do, stop when 
                                            
                i = i + 1                             
                    response.write "<tr onmouseover=this.bgColor='#FFF59D' onmouseout=this.bgColor='white' onclick=""getValue3('" & rstTMSHFCODE("SHF_CODE") & "','" & rstTMSHFCODE("STIME") & "','" & rstTMSHFCODE("ETIME") & "','txtSHF_CODE','txtSTIME','txtETIME')"">"
                    response.write "<td>" & rstTMSHFCODE("SHF_CODE") & "</td>"
                    response.write "<td>" & rstTMSHFCODE("PART") & "</td>"
                    Set rstTMWORK = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMWORK where WORK_ID ='" & rstTMSHFCODE("WORK_ID") & "'" 
                    rstTMWORK.Open sSQL, conn, 3, 3
                        if not rstTMWORK.eof then
                            response.write "<td>" & rstTMWORK("PART") & "</td>"
                        else
                            response.write "<td style='color:red'>No such work location</td>"
                        end if
                    pCloseTables(rstTMWORK)

                    response.write "<td>" & rstTMSHFCODE("STIME") & "</td>"
                    response.write "<td>" & rstTMSHFCODE("ETIME") & "</td>"
                    response.write "<td bgcolor='" & rstTMSHFCODE("COLOR") &"'></td>"
                    response.write "<td>" & rstTMSHFCODE("STATUS") & "</td>"
                    response.write "</tr>"
                rstTMSHFCODE.movenext
            loop
            call pCloseTables(rstTMSHFCODE)

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
            <br />
            <div class="dataTables_paginate">
                <ul class="pagination">
                    <%IF Cint(PageNo) > 1 then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=1','SHFCODE','mycontent');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo-1%>','SHFCODE','mycontent');" class="button_a" >< Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showDetails('page=<%=intID%>','SHFCODE','mycontent');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo+1%>','SHFCODE','mycontent');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=TotalPage%>','SHFCODE','mycontent');" class="button_a" >Last >></a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
    </form>
</section>