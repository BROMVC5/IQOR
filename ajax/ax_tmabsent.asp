<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<%
             
Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd

PageLen = 5

iCurPage = 1

dtabsent =  dateadd("d", -1, date()) 
'dtabsent = "2019-02-27" === For Debug
Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMEMPLY where "
sSQL = sSQL & " EMP_CODE ='" & session("USERNAME") & "'"  
rstTMEMPLY.Open sSQL, conn, 3, 3
if not rstTMEMPLY.eof then
    sAType = rstTMEMPLY("ATYPE")
end if 
                           
sSQL = "select tmabsent.EMP_CODE, NAME, SUP_CODE, WORKGRP_ID, SHF_CODE, DT_ABSENT, ATTENDANCE, TYPE from tmabsent" 
sSQL = sSQL & " where DT_ABSENT = '" & fdate2(dtabsent) & "'"

if sAtype = "V" then '=== Verifier will view everyone
    
elseif sAType = "M" then

    '==== For Manager with direct subordinate who needs to punch like Goo Feng Guan, M4 
    Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
    sSQL1 = "select * from TMEMPLY where "
    sSQL1 = sSQL1 & " SUP_CODE ='" & sLogin & "'" '=== Retrieve all the employee under each Manager  
    rstTMDOWN1.Open sSQL1, conn, 3, 3
    if not rstTMDOWN1.eof then
        Do while not rstTMDOWN1.eof
            sCount = sCount + 1
            if sCount = 1 then 
                sSQL = sSQL & " and ( ( tmabsent.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"
            else
                sSQL = sSQL & " or ( tmabsent.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"
            end if      
        rstTMDOWN1.movenext
        loop

        sSQL = sSQL & ")"

    end if

    Set rstTMCOST = server.CreateObject("ADODB.RecordSet")    
    sSQL2 = "select * from TMCOST where "
    sSQL2 = sSQL2 & " COSTMAN_CODE ='" & sLogin & "'"  '==== He is Cost Manager of which Cost Center
    rstTMCOST.Open sSQL2, conn, 3, 3
    if not rstTMCOST.eof then
        sSQL = sSQL & " or ("
        sCount = 0
        Do while not rstTMCOST.eof 
            sCount = sCount + 1 
            '==== Retrieve the employee who is at his Cost Center
            if sCount = 1 then 
                sSQL = sSQL & " ( tmabsent.EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & session("USERNAME") &"') )" '=== Don't select back the manager coz he is also in the Cost Center
            else
                sSQL = sSQL & " or ( tmabsent.EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & session("USERNAME") &"') )"
            end if   
        rstTMCOST.movenext
        loop
        sSQL = sSQL & " ) "
    end if 

elseif sAtype = "S" then

    sSQL = sSQL & " and SUP_CODE = '" & session("USERNAME") & "'" 

end if

sSQL = sSQL & " order by tmabsent.EMP_CODE, NAME "

set rstTMABSENT = server.createobject("adodb.recordset")
rstTMABSENT.cursortype = adOpenStatic
rstTMABSENT.cursorlocation = adUseClient
rstTMABSENT.locktype = adLockBatchOptimistic
rstTMABSENT.pagesize = PageLen		
rstTMABSENT.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMABSENT.eof then
 	rstTMABSENT.absolutepage = iCurPage
 	'iPageCount = rstTMABSENT.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMABSENT.RecordCount
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
<div class="col-sm-12" style="overflow:auto;padding:0px;margin-top:-20px">
<br />
    <h4><b>Absent Employee on <%=dtAbsent%></b></h4>
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width:3%">No</th>
                <th style="width:15%">Employee Code</th>
                <th style="width:20%">Full Name</th>
                <th style="width:12%">Work Group</th>
                <th style="width:10%">Shift Code</th>
                <th style="width:8%">Attendance</th>
                <th style="width:20%">Superior</th>
            </tr>
        </thead>
        
        <tbody>
            <%
          
                do while not rstTMABSENT.eof and i < PageLen
                    i = i + 1
                    response.write "<tr>"
                    response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                    response.write "<td>" & rstTMABSENT("EMP_CODE") & "</td>"
                    response.write "<td>" & rstTMABSENT("NAME") & "</td>"
                    response.write "<td>" & rstTMABSENT("WORKGRP_ID") & "</td>"
                    response.write "<td>" & rstTMABSENT("SHF_CODE") & "</td>"
                    if rstTMABSENT("TYPE") = "F" then
                        response.write "<td>" & rstTMABSENT("ATTENDANCE") & "</td>"
                    else
                        response.write "<td>" & rstTMABSENT("ATTENDANCE") & " - 0.5 Day </td>"
                    end if
                        Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")    
                        sSQL = "select * from TMEMPLY where EMP_CODE='" & rstTMABSENT("SUP_CODE") & "'" 
                        rstTMSUPNAME.Open sSQL, conn, 3, 3
                        if not rstTMSUPNAME.eof then
                            response.write "<td>" & rstTMSUPNAME("NAME") & "</td>"
                        else
                            response.write "<td></td>"
                        end if
                    rstTMABSENT.movenext
                loop
            %>
        </tbody>
        
    </table>
</div>
<br />
<div class="row">
    <div class="col-sm-5" style="margin-top:5px">
        TOTAL RECORDS (<%=TotalRecord%>) <%=PageNo%> / <%=TotalPage%>
    </div>
    <div class="col-sm-7">
        <div class="dataTables_paginate">
            <ul class="pagination">
                <%IF Cint(PageNo) > 1 then %>
                    <li class="paginate_button"><a href="javascript:showAbsent('page=1');" class="button_a" ><< First</a></li>
                    <li class="paginate_button"><a href="javascript:showAbsent('page=<%=PageNo-1%>');" class="button_a" >< Back</a></li>
                <%End IF%>
				
                <%For intID = 1 To TotalPage%>
                <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                    <% if intID = Cint(PageNo) Then%>
                        <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                    <%Else%>
                        <li class="paginate_button"><a href="javascript:showAbsent('page=<%=intID%>');" class="button_a" ><%=intID%></a></li>
                    <%End IF%>
                <%End IF%>
                <%Next%>

                <%IF Cint(PageNo) < TotalPage Then %>
                    <li class="paginate_button"><a href="javascript:showAbsent('page=<%=PageNo+1%>');" class="button_a" >Next ></a></li>
                    <li class="paginate_button"><a href="javascript:showAbsent('page=<%=TotalPage%>');" class="button_a" >Last >></a></li>
                <%End IF%>
            </ul>
        </div>
    </div>
</div>
