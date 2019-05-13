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
                                        
iRecCount = 10

PageLen = iRecCount

if request("Page") <> "" and trim(request("btnSubmit")) = "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

txtSearch = trim(request("txtSearch"))
sBadgeType = trim(request("txtBadgeType"))

if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = " and (BADGE_NO like '%" & ScStr & "%') "
end if

' sql = "SELECT VRTRNS.BADGE_NO, VRVEND.NRIC, VRVEND.VNAME, VRVEND.HP, VRTRNS.CAR_NO, VRTRNS.APP_NAME, VRTRNS.DEPT, VRTRNS.DT_IN  FROM VRTRNS "
' sql = sql & " LEFT JOIN VRVEND ON VRVEND.NRIC=VRTRNS.NRIC"
sql = sql & " SELECT NRIC, BADGE_NO, CAR_NO, APP_NAME, DEPT, DT_IN FROM VRTRNS "
sql = sql & " where DT_OT is null "
sql = sql & " and BADGE_NO is not null"
if sBadgeType <> "" then
	sql = sql & " and BADGE_NO like '" & sBadgeType & "%'"
end if
if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & " order by VRTRNS.autoinc DESC "
set rstVROUT = server.createobject("adodb.recordset")
rstVROUT.cursortype = adOpenStatic
rstVROUT.cursorlocation = adUseClient
rstVROUT.locktype = adLockBatchOptimistic
rstVROUT.pagesize = PageLen		
rstVROUT.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstVROUT.eof then
 	rstVROUT.absolutepage = iCurPage
 	iPageCount = rstVROUT.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstVROUT.RecordCount
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
                <th style="width:5%">Badge No</th>
				<th style="width:10%">Vendor Name</th>
				<th style="width:10%">Employee Name</th>
				<th style="width:10%">Department ID</th>
				<th style="width:8%">Check In Date</th>
                <th style="width:3%;text-align:center">Check Out</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstVROUT.eof and i < iRecCount
				
					sName = ""
					sHP = "" 
					
					set rstVRVend = server.CreateObject("ADODB.RecordSet")    
					sSQL = "select * from vrvend where NRIC = '" & rstVROUT("NRIC") & "' " 
					rstVRVend.Open sSQL, conn, 3, 3
					if not rstVRVend.eof then	            	
						sName = rstVRVend("VNAME")
						sHP = rstVRVend("HP")
					end if
					pCloseTables(rstVRVend)
				                      
					sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
					i = i + 1                             
					response.write "<tr>"
					response.write "<td>" & rstVROUT("BADGE_NO")& "</td>"
					response.write "<td>" & sName & "</td>"
					response.write "<td>" & rstVROUT("APP_NAME") & "</td>"
					response.write "<td>" & rstVROUT("DEPT") & "</td>"
					response.write "<td>" & rstVROUT("DT_IN") & "</td>"
					response.write "<td style=""color:grey;width:1%;font-size:20px;text-align:center""><a href='vrout_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtBadge_No="& rstVROUT("BADGE_NO") &"'><i class=""fa fa-sign-out""></i></a></td>"
					response.write "</tr>"
					rstVROUT.movenext
	
            loop
            call pCloseTables(rstVROUT)

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
