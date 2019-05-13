﻿<!DOCTYPE html>


<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<!-- #include file="../include/validate.asp"-->

<%
                                      
Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd
                                        
iRecCount = 10

PageLen = iRecCount

if request("Page") <> "1" and trim(request("btnSubmit")) = "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

dtDisplay = request("dtpDisplay")
dtDisplay = DateAdd("s",-10,dtDisplay)
    
if sEMP_CODE <> "" then
    sID = sEMP_CODE
else
    sID = UCase(reqForm("txtID"))
end if

sql = "select * from csemply1 where DATETIME >= '" & fdatetime2(dtDisplay) & "'"
sql = sql & "order by DT_SUB desc "
set rstcscoupon = server.createobject("adodb.recordset")
rstcscoupon.cursortype = adOpenStatic
rstcscoupon.cursorlocation = adUseClient
rstcscoupon.locktype = adLockBatchOptimistic
rstcscoupon.pagesize = PageLen		
rstcscoupon.Open sql, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstcscoupon.eof then
 	rstcscoupon.absolutepage = iCurPage
 	iPageCount = rstcscoupon.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstcscoupon.RecordCount
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
                <th style="width:10%">Date</th>
				<th style="width:15%">Employee Code</th>
				<th style="width:15%">Employee Name</th>
                <th style="width:15%">Type</th>
                <th style="width:30%">Description</th>
                <th style="width:20%;text-align:right">Subsidy Amount (RM)</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
                do while not rstcscoupon.eof and i < iRecCount
				
				sName = ""
				
				set rstEmpName = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from tmemply where EMP_CODE = '" & rstcscoupon("EMP_CODE") & "' " 
	            rstEmpName.Open sSQL, conn, 3, 3
	            if not rstEmpName.eof then
					sName = rstEmpName("NAME")
				end if
			                          
                i = i + 1 
                set rstCSType = server.CreateObject("ADODB.RecordSet")    
	            sSQL = "select * from cstype where SUBTYPE = '" & rstcscoupon("TYPE") & "' " 
	            rstCSType.Open sSQL, conn, 3, 3
	            if not rstCSType.eof then
                         
	                response.write "<tr>"
	                response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
	                response.write "<td>" & rstCSCoupon("DT_SUB") & "</td>"
					response.write "<td>" & rstcscoupon("EMP_CODE") & "</td>"
					response.write "<td>" & sName & "</td>"
	                response.write "<td>" & rstCSCoupon("TYPE") & "</td>"
	                response.write "<td>" & rstCSType("PART") & "</td>"  
	                response.write "<td align='right'>" & pFormatDec(rstcscoupon("AMOUNT"),2) & "</td>"
	                response.write "</tr>"
	                
	            end if
	            pCloseTables(rstCSTYPE)    
                rstcscoupon.movenext
            loop
            call pCloseTables(rstcscoupon)
				
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

