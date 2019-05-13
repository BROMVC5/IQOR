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
sStatusType = trim(request("txtStatus"))

if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sql_1 = "and ((BADGE_NO like '%" & ScStr & "%') "
	sql_1 = sql_1 & " or (APP_NAME like '%" & ScStr & "%')) "
end if

' sql = "select VRVEND.NRIC, VRVEND.VNAME, VRVEND.HP, VRTRNS.CAR_NO, VRTRNS.APP_NAME, VRTRNS.DEPT, VRTRNS.AUTOINC, VRTRNS.BADGE_NO, VRTRNS.DT_CREATE, VRTRNS.GD_OT FROM VRVEND"
' sql = sql & " LEFT JOIN VRTRNS ON VRVEND.NRIC=VRTRNS.NRIC"
sql = "select NRIC, CAR_NO, APP_NAME, DEPT, AUTOINC, BADGE_NO, DT_CREATE, GD_OT FROM VRTRNS"
sql = sql & " where BADGE_NO is not null "
if sBadgeType <> "" then
	sql = sql & " and BADGE_NO like '" & sBadgeType & "%'"
end if

if sStatusType = "CO" then
	sql = sql & " and GD_OT <> '' "
elseif sStatusType = "CI" then
	sql = sql & " and GD_OT = '' "
end if

if sql_1 <> "" then
	sql = sql & sql_1
end if 
sql = sql & " ORDER BY VRTRNS.AUTOINC DESC"
set rstVRIn = server.createobject("adodb.recordset")
rstVRIn.cursortype = adOpenStatic
rstVRIn.cursorlocation = adUseClient
rstVRIn.locktype = adLockBatchOptimistic
rstVRIn.pagesize = PageLen		
rstVRIn.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstVRIn.eof then
 	rstVRIn.absolutepage = iCurPage
 	iPageCount = rstVRIn.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstVRIn.RecordCount
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
                <th style="width:5%">No</th>
				<th style="width:8%">Badge No</th>
				<th style="width:20%">Vendor Name</th>
				<th style="width:20%">Employee Name</th>
				<th style="width:10%">Department ID</th>
				<th style="width:15%">Date/Time</th>
				<th style="width:8%">Status</th>
                <th style="width:4%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstVRIn.eof and i < iRecCount
				
				sName = ""
				sHP = ""
				
				set rstVRVend = server.CreateObject("ADODB.RecordSet")    
				sSQL = "select * from vrvend where NRIC = '" & rstVRIn("NRIC") & "' " 
				rstVRVend.Open sSQL, conn, 3, 3
				if not rstVRVend.eof then	            	
					sName = rstVRVend("VNAME")
					sHP = rstVRVend("HP")
				end if
				pCloseTables(rstVRVend)
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                i = i + 1                             
                response.write "<tr>"
                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
				response.write "<td>" & rstVRIn("BADGE_NO") & "</td>"
                response.write "<td>" & sName & "</td>"
				response.write "<td>" & rstVRIn("APP_NAME") & "</td>"
				response.write "<td>" & rstVRIn("DEPT") & "</td>"
				response.write "<td>" & rstVRIn("DT_CREATE") & "</td>"
				if rstVRIn("GD_OT") = "" then
					response.write "<td><b style='color:green'>Check In</b></td>" 
				else
					response.write "<td><b style='color:red'>Check Out</b></td>" 
				end if
                response.write "<td style=""width:2%;text-align:center""><a href='vrin_det.asp?page="& PageNo & "&txtsearch=" & txtSearch & "&txtNRIC="& rstVRIn("NRIC") & "&txtAutoinc="& rstVRIn("AUTOINC") & "&txtBadge_No="& rstVRIn("BADGE_NO") &"'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstVRIn.movenext
	
            loop
            call pCloseTables(rstVRIn)

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
