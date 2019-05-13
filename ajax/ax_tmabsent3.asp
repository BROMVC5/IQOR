<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->
<%
            
Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd

PageLen = 5

iCurPage = 1

Set rstTMPATH = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMPATH" 
rstTMPATH.Open sSQL, conn, 3, 3
if not rstTMPATH.eof then
    sPayFrom = rstTMPATH("PAYFROM") 
    sPayTo = rstTMPATH("PAYTO")
end if
pCloseTables(rstTMPATH)

dtProcess=CDate(Now())

if Cint(day(dtProcess)) > Cint(sPayTo) + 1 then '=== + 1 because during dtProcess 22 I want to process till 21
    dtAbsent3Fr = CDate(sPayFrom & "-" & Month(dtProcess) & "-" & Year(dtProcess))
else
    dtAbsent3Fr = CDate(sPayFrom & "-" & GetLastMonth(Month(dtProcess), Year(dtProcess)) & "-" & GetLastMonthYear(Month(dtProcess), Year(dtProcess)))
end if

dtAbsent3To = dateadd("d", -1, dtProcess)  

Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMEMPLY where "
sSQL = sSQL & " EMP_CODE ='" & session("USERNAME") & "'"  
rstTMEMPLY.Open sSQL, conn, 3, 3
if not rstTMEMPLY.eof then
    sAType = rstTMEMPLY("ATYPE")
end if 

sSQL = "SELECT * FROM TMABSENT3"
sSQL = sSQL & " where DTFR >= '" & fdate2(dtAbsent3Fr) & "'"
sSQL = sSQL & " and DTTO <='" & fdate2(dtAbsent3To) & "'"

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
                sSQL = sSQL & " and ( ( tmabsent3.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"
            else
                sSQL = sSQL & " or ( tmabsent3.EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"
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
                sSQL = sSQL & " ( tmabsent3.EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & session("USERNAME") &"') )" '=== Don't select back the manager coz he is also in the Cost Center
            else
                sSQL = sSQL & " or ( tmabsent3.EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & session("USERNAME") &"') )"
            end if   
        rstTMCOST.movenext
        loop
        sSQL = sSQL & " ) "
    end if 

elseif sAtype = "S" then

    sSQL = sSQL & " and SUP_CODE = '" & session("USERNAME") & "'" 

end if

sSQL = sSQL & " order by tmabsent3.EMP_CODE,NAME "

set rstTMABSENT3 = server.createobject("adodb.recordset")
rstTMABSENT3.cursortype = adOpenStatic
rstTMABSENT3.cursorlocation = adUseClient
rstTMABSENT3.locktype = adLockBatchOptimistic
rstTMABSENT3.pagesize = PageLen		
rstTMABSENT3.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstTMABSENT3.eof then
 	rstTMABSENT3.absolutepage = iCurPage
 	'iPageCount = rstTMABSENT3.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstTMABSENT3.RecordCount
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
    <h4><b>Absent for 3 consecutive days from <%=fdatelong(dtAbsent3Fr)%> to <%=fdatelong(dtAbsent3To)%> </b></h4>
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width:5%">No</th>
                <th style="width:15%">Employee Code</th>
                <th style="width:20%">Full Name</th>
                <th style="width:15%">Work Group</th>
                <th style="width:20%">Absence period</th>
                <th style="width:10%;text-align:right">Total Days</th>
                <th style="width:15%">Superior</th>
                
            </tr>
        </thead>
        
        <tbody>
            <%
          
                '========= Insert the recordset into Table according to Page ====================================
                do while not rstTMABSENT3.eof and i < PageLen
                    i = i + 1
                    response.write "<tr>"
                    response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                    response.write "<td>" & rstTMABSENT3("EMP_CODE") & "</td>"
                    response.write "<td>" & rstTMABSENT3("NAME") & "</td>"
                    response.write "<td>" & rstTMABSENT3("WORKGRP_ID") & "</td>"
                    response.write "<td>" & rstTMABSENT3("DTFR") & "-" &  rstTMABSENT3("DTTO")  & "</td>"
                    response.write "<td style='text-align:right'>" & rstTMABSENT3("DURA") & "</td>"
                    Set rstTMSUPNAME = server.CreateObject("ADODB.RecordSet")    
                    sSQL = "select * from TMEMPLY where EMP_CODE='" & rstTMABSENT3("SUP_CODE") & "'" 
                    rstTMSUPNAME.Open sSQL, conn, 3, 3
                    if not rstTMSUPNAME.eof then
                        response.write "<td>" & rstTMSUPNAME("NAME") & "</td>"
                    else
                        response.write "<td></td>"
                    end if
                    rstTMABSENT3.movenext
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
                    <li class="paginate_button"><a href="javascript:showAbsent3('page=1');" class="button_a" ><< First</a></li>
                    <li class="paginate_button"><a href="javascript:showAbsent3('page=<%=PageNo-1%>');" class="button_a" >< Back</a></li>
                <%End IF%>
				
                <%For intID = 1 To TotalPage%>
                <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                    <% if intID = Cint(PageNo) Then%>
                        <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                    <%Else%>
                        <li class="paginate_button"><a href="javascript:showAbsent3('page=<%=intID%>');" class="button_a" ><%=intID%></a></li>
                    <%End IF%>
                <%End IF%>
                <%Next%>

                <%IF Cint(PageNo) < TotalPage Then %>
                    <li class="paginate_button"><a href="javascript:showAbsent3('page=<%=PageNo+1%>');" class="button_a" >Next ></a></li>
                    <li class="paginate_button"><a href="javascript:showAbsent3('page=<%=TotalPage%>');" class="button_a" >Last >></a></li>
                <%End IF%>
            </ul>
        </div>
    </div>
</div>
