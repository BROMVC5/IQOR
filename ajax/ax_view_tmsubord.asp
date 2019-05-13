<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%

Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd

sLogin = session("USERNAME")

Set rstBROPATH = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from BROPATH" 
rstBROPATH.Open sSQL, conn, 3, 3
if not rstBROPATH.eof then
    sNumRows = rstBROPATH("NUMROWS")
end if
pCloseTables(rstBROPATH)

'PageLen = Cint(sNumRows)
PageLen = 10

if request("Page") <> "" then
 	iCurPage = request("Page")
else
 	iCurPage = 1
end if

Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMEMPLY where "
sSQL = sSQL & " EMP_CODE ='" & sLogin & "'"  
rstTMEMPLY.Open sSQL, conn, 3, 3
if not rstTMEMPLY.eof then
    sAType = rstTMEMPLY("ATYPE")
end if 

txtSearch = trim(request("txtSearch"))

if txtSearch <> "" then
	ScStr = txtSearch
 	ScStr = replace(ScStr,"'","''")
  	sSQL_S = " and ((EMP_CODE like '%" & ScStr & "%') "
  	sSQL_S = sSQL_S & " or (NAME like '%" & ScStr & "%'))"
end if
    
sSQL = "select EMP_CODE, NAME from TMEMPLY where 1=1 " '=== Still able to search resigned employee

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
                sSQL = sSQL & " and ( ( EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"
            else
                sSQL = sSQL & " or ( EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"
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
                sSQL = sSQL & " ( EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & sLogin &"') )" '=== Don't select back the manager coz he is also in the Cost Center
            else
                sSQL = sSQL & " or ( EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & sLogin &"') )"
            end if   
        rstTMCOST.movenext
        loop
        sSQL = sSQL & " ) "
    end if 

elseif sAtype = "S" then

    sSQL = sSQL & " and SUP_CODE = '" & sLogin & "'" 

end if

if sSQL_S <> "" then
	sSQL = sSQL & sSQL_S
end if 

sSQL = sSQL & " order by EMP_CODE, NAME asc "

set rstUser = server.createobject("adodb.recordset")
rstUser.cursortype = adOpenStatic
rstUser.cursorlocation = adUseClient
rstUser.locktype = adLockBatchOptimistic
rstUser.pagesize = PageLen		
rstUser.Open sSQL, conn, 3, 3

'**************** Paging/Pagination Calculator ***************'
If not rstUser.eof then
 	rstUser.absolutepage = iCurPage
 	iPageCount = rstUser.PageCount
end if 

PageNo = Request.QueryString("Page")
if PageNo = "" Then PageNo = 1
TotalRecord = rstUser.RecordCount
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
 <section class="content">
    <form id="viewform" class="form-horizontal" action="javascript:showDetails('page=1','SUBORD','mycontent');") method="post">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-3">
                <div class="pull-left">
                    <h3>View Employee</h3>
                </div>
            </div>
            <div class="col-sm-4 pull-right">
                <div class="input-group">
                    
                    <input class="form-control" id="txtSearch_subord" name="txtSearch_subord" value="<%=txtSearch%>" placeholder="Search" maxlength="100" type="text" />
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="submit" name="search" value="Search" onclick="showDetails('page=1','SUBORD','mycontent');return false;"><i class="fa fa-search"></i>
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
                <th style="width:5%">No</th>
                <th style="width:25%">Employee No</th>
                <th style="width:25%">Name</th>
                
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
            do while not rstUser.eof and i < PageLen
                                            
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                
                i = i + 1
                'Escape ' for Javascript
                sName = Replace(rstUser("NAME"), "'", "\'")

                response.write "<tr onmouseover=this.bgColor='#FFF59D' onmouseout=this.bgColor='white' onclick=""getValue2('" & rstUser("EMP_CODE") & "','txtID','" & sName & "','txtNAME')"">"
                    response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                    response.write "<td>" & rstUser("EMP_CODE") & "</td>"
                    response.write "<td>" & rstUser("NAME") & "</td>"
                response.write "</tr>"
                rstUser.movenext
            loop
            call pCloseTables(rstUser)

            %>                     
        </tbody>
        
    </table>
    </div>
    <br />
    <div class="row">
        <div class="col-sm-4" style="margin-top:10px">
            TOTAL RECORDS (<%=TotalRecord%>) <%=lg_page%> <%=PageNo%> / <%=TotalPage%>
        </div>
        <div class="col-sm-8">
            <div class="dataTables_paginate">
                <ul class="pagination">
                    <%IF Cint(PageNo) > 1 then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=1','SUBORD','mycontent');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo-1%>','SUBORD','mycontent');" class="button_a" >< Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showDetails('page=<%=intID%>','SUBORD','mycontent');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo+1%>','SUBORD','mycontent');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=TotalPage%>','SUBORD','mycontent');" class="button_a" >Last >></a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
    </form>
</section>

