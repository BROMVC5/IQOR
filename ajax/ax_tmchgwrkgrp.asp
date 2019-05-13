<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<!-- JQuery 2.2.3 Compressed -->
<%

Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd

sOrderBy = trim(request("sOrderBy"))
sAscDesc = trim(request("sAscDesc"))      
sWorkGrp_ID = request("txtWorkGrp_ID")
sSup_CODE = request("txtSup_CODE")
sEMP_CODE = trim(request("txtEMP_CODE"))

Set rstBROPATH = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from BROPATH" 
rstBROPATH.Open sSQL, conn, 3, 3
if not rstBROPATH.eof then
    sNumRows = rstBROPATH("NUMROWS")
end if
pCloseTables(rstBROPATH)

PageLen = Cint(sNumRows)

if request("Page") <> "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

sSQL = "select tmemply.EMP_CODE, tmemply.NAME, WORKGRP_ID, PART, tmshiftot.DT_SHIFT, tmshiftot.USER_ID, tmshiftot.DATETIME from tmemply "
sSQL = sSQL & " left join tmworkgrp on tmemply.EMP_CODE = tmworkgrp.EMP_CODE"
sSQL = sSQL & " left join tmshiftot on tmemply.EMP_CODE = tmshiftot.EMP_CODE"
sSQL = sSQL & " where GENSHF = 'Y' and not isnull(WORKGRP_ID) and isNull(DT_RESIGN)" 

if sWorkGrp_ID <> "" then
    sSQL_1 = " and WORKGRP_ID = '" & sWorkGrp_ID & "'"
end if 

if sSup_CODE <> "" then
    sSQL_2 = " and tmemply.EMP_CODE in (select tmemply.EMP_CODE from tmemply where SUP_CODE = '" & sSup_CODE & "')"
end if

if sEmp_Code <> "" then
    sSQL_3 = " and tmemply.EMP_CODE = '" & sEMP_CODE & "'"
end if

sSQL = sSQL & sSQL_1 & sSQL_2 & sSQL_3
sSQL = sSQL & " group by EMP_CODE "

if sOrderBy <> ""  then
    if sAscDesc = "Asc" then
        sSQL = sSQL & "order by " & sOrderBy
    elseif sAscDesc = "Desc" then
         sSQL = sSQL & "order by " & sOrderBy & " desc"
    end if
end if

set rstTMCHGWRKGRP = server.createobject("adodb.recordset")
rstTMCHGWRKGRP.cursortype = adOpenStatic
rstTMCHGWRKGRP.cursorlocation = adUseClient
rstTMCHGWRKGRP.locktype = adLockBatchOptimistic
rstTMCHGWRKGRP.pagesize = PageLen		
rstTMCHGWRKGRP.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMCHGWRKGRP.eof then
    rstTMCHGWRKGRP.absolutepage = iCurPage
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMCHGWRKGRP.RecordCount
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

    sMainURL = "../tmot.asp?"
    

%>
<form name="form2" action="ajax/ax_tmchgwrkgrp.asp" method="post">
<input type="hidden" name="txtWorkGrp_ID" value="<%=sWorkGrp_ID%>" />
<input type="hidden" name="txtSup_CODE" value="<%=sSup_CODE%>" />
<input type="hidden" name="txtEmp_Code" value="<%=sEMP_CODE%>" />

<div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
        
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <%If sAscDesc ="Desc" then %>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','EMP_CODE','Asc');">Emp Code</a></th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','NAME','Asc');">Full Name</a></th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','WORKGRP_ID','Asc');">Work Group</a></th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','DT_SHIFT','Asc');">Scheduled End Date</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','USER_ID','Asc');">Updated By</a></th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','DATETIME','Asc');">Updated Date</a></th>
                    <th style="width:5%;text-align:center">Edit</th>
                <%else %>
                    <th style="width:8%"><a href="javascript:showContent('page=<%=PageNo%>','EMP_CODE','Desc');">Emp Code</a></th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','NAME','Desc');">Full Name</a></th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','WORKGRP_ID','Desc');">Work Group</a></th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','DT_SHIFT','Desc');">Scheduled End Date</a></th>
                    <th style="width:15%"><a href="javascript:showContent('page=<%=PageNo%>','USER_ID','Desc');">Updated By</a></th>
                    <th style="width:10%"><a href="javascript:showContent('page=<%=PageNo%>','DATETIME','Desc');">Updated Date</a></th>
                    <th style="width:5%;text-align:center">Edit</th>
                <%end if %>
            </tr>
        </thead>
        
        <tbody>
            <%
                do while not rstTMCHGWRKGRP.eof and i < PageLen ' When recordset is not EOF and i < iRecCount continue to do, stop when 
                                            
                i = i + 1                             
                response.write "<tr>"
                
                response.write "<td>" & rstTMCHGWRKGRP("EMP_CODE") & "</td>"

                response.write "<td>" & rstTMCHGWRKGRP("NAME") & "</td>"
                response.write "<td>" & rstTMCHGWRKGRP("WORKGRP_ID") & "</td>"
                
                Set rstTMSHIFTOT = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMSHIFTOT where EMP_CODE ='" & rstTMCHGWRKGRP("EMP_CODE") & "'" 
                sSQL = sSQL & " order by DT_SHIFT desc limit 1 "
                rstTMSHIFTOT.Open sSQL, conn, 3, 3
                
                if not rstTMSHIFTOT.eof then
                    dtEndShf = rstTMSHIFTOT("DT_SHIFT")
                    response.write "<td>" & fdatelong(dtEndShf) & "</td>"
                    response.write "<td>" & rstTMSHIFTOT("USER_ID") & "</td>"
                    response.write "<td>" & rstTMSHIFTOT("DATETIME") & "</td>"
                else
                    response.write "<td></td>"
                    response.write "<td></td>"
                    response.write "<td></td>"
                end if
                pCloseTables(rstTMSHIFTOT)
               
                response.write "<td style=""width:2%;text-align:center""><a href='tmchgwrkgrp_det.asp?txtWorkGrp_ID=" & rstTMCHGWRKGRP("WORKGRP_ID") & "&txtSup_CODE=" & sSup_CODE & "&txtEMP_CODE="& rstTMCHGWRKGRP("EMP_CODE") & "'><img src=""dist/img/edit-2-24.png"" /></a></td>"
                response.write "</tr>"
                rstTMCHGWRKGRP.movenext
            loop
            call pCloseTables(rstTMCHGWRKGRP)

            %>
           
        </tbody>
        
        
    </table>
    </div>

 </form>

    <div class="row">
        <div class="col-sm-5" style="margin-top:5px">
        <br />  TOTAL RECORDS (<%=TotalRecord%>) <%=lg_page%> <%=PageNo%> / <%=TotalPage%>
        </div>
        <div class="col-sm-7">
            <br />
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
    
    <script>
  
   </script>