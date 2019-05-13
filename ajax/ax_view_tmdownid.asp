<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%

Dim PageLen,PageNo,TotalRecord,TotalPage,intID
Dim PageStart,PageEnd

sLogin = Session("Username")
sApprov = request("txtApprov")
sDown = request("txtDown")

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
    
    sqldel = " delete from TMTMPDOWN "
    conn.execute sqldel

    sSQL = "select EMP_CODE, SUP_CODE, NAME from TMEMPLY where 1=1 "

    if sAType = "V" and sApprov = "V" and sDown <> "A" then
    
        if sSQL_S <> "" then
            sql = sSQL    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sSQL 
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 
    
    elseif sAType = "V" and sApprov = "M" and sDown <> "A" then
        
         '==== For Manager with direct subordinate who needs to punch like Goo Feng Guan, M4 
        Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMEMPLY where "
        sSQL1 = sSQL1 & " SUP_CODE ='" & sDown & "'" '=== Retrieve all the employee under each Manager  
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
        sSQL2 = sSQL2 & " COSTMAN_CODE ='" & sDown & "'"  '==== He is Cost Manager of which Cost Center
        rstTMCOST.Open sSQL2, conn, 3, 3
        if not rstTMCOST.eof then
            sSQL = sSQL & " or ("
            sCount = 0
            Do while not rstTMCOST.eof 
                sCount = sCount + 1 
                '==== Retrieve the employee who is at his Cost Center and pending 2nd level Managerial Approval
                if sCount = 1 then 
                    sSQL = sSQL & " ( EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & sDown &"') )" '=== Don't select back the manager coz he is also in the Cost Center.
                else
                    sSQL = sSQL & " or ( EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & sDown &"') )"
                end if   
            rstTMCOST.movenext
            loop
            sSQL = sSQL & " ) "
        end if 

        set rsttmpdown = server.createobject("adodb.recordset")
        sSQL = sSQL & " order by EMP_CODE, NAME asc "
        rsttmpdown.Open SSQL, conn, 3, 3
        if not rsttmpdown.eof then
            Do while not rsttmpdown.eof
                sSQLT = "INSERT into TMTMPDOWN (EMP_CODE, NAME)"
                sSQLT = sSQLT & "values ("
		        sSQLT = sSQLT & "'" & rsttmpdown("EMP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & pRTIN(rsttmpdown("NAME")) & "')"
                conn.execute sSQLT
		    rsttmpdown.movenext
            loop
        end if

        if sSQL_S <> "" then
            sql = " select * from TMTMPDOWN where 1=1"    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sql & " select * from TMTMPDOWN "    
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 

    elseif sAType = "V" and sApprov = "M" and sDown = "A" then
        
        Set rstTMManagers = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMEMPLY where "
        sSQL1 = sSQL1 & " ATYPE ='M' " '=== Retrieve all the employee under each Manager  
        sSQL1 = sSQL1 & " order by EMP_CODE"
        rstTMManagers.Open sSQL1, conn, 3, 3
        if not rstTMManagers.eof then

            Do while not rstTMManagers.eof
    
                '==== For Manager with direct subordinate who needs to punch like Goo Feng Guan, M4 
                Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
                sSQL2 = "select * from TMEMPLY where "
                sSQL2 = sSQL2 & " SUP_CODE ='" & rstTMManagers("EMP_CODE") & "'" '=== Retrieve all the employee under each Manager  
                rstTMDOWN1.Open sSQL2, conn, 3, 3
                if not rstTMDOWN1.eof then
                    Do while not rstTMDOWN1.eof
                        sCount1 = sCount1 + 1
                        if sCount1 = 1 then 
                           sSQL = sSQL & " and ( ( EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"
                        else
                           sSQL = sSQL & " or ( EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"
                        end if      
                    rstTMDOWN1.movenext
                    loop

                end if

                Set rstTMCOST = server.CreateObject("ADODB.RecordSet")    
                sSQL3 = "select * from TMCOST where "
                sSQL3 = sSQL3 & " COSTMAN_CODE ='" & rstTMManagers("EMP_CODE") & "'"  '==== He is Cost Manager of which Cost Center
                rstTMCOST.Open sSQL2, conn, 3, 3
                if not rstTMCOST.eof then
                    
                    Do while not rstTMCOST.eof 
                       
                        sSQL = sSQL & " or (EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" &  rstTMManagers("EMP_CODE")  &"') )" '=== Don't select back the manager coz he is also in the cost center.
                         
                    rstTMCOST.movenext
                    loop
                    
                end if 
            
            rstTMManagers.movenext
            loop

            sSQL = sSQL & " ) "

        end if     

        set rsttmpdown = server.createobject("adodb.recordset")
        sSQL = sSQL & " order by EMP_CODE, NAME asc "
        rsttmpdown.Open SSQL, conn, 3, 3
        if not rsttmpdown.eof then
            Do while not rsttmpdown.eof
                sSQLT = "INSERT into TMTMPDOWN (EMP_CODE, NAME)"
                sSQLT = sSQLT & "values ("
		        sSQLT = sSQLT & "'" & rsttmpdown("EMP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & pRTIN(rsttmpdown("NAME")) & "')"
                conn.execute sSQLT
		    rsttmpdown.movenext
            loop
        end if

        if sSQL_S <> "" then
            sql = " select * from TMTMPDOWN where 1=1"    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sql & " select * from TMTMPDOWN "    
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 

    elseif sAType = "V" and sApprov = "S" and sDown <> "A" then
        
        Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMEMPLY where "
        sSQL1 = sSQL1 & " SUP_CODE ='" & sDown & "'"  
        rstTMDOWN1.Open sSQL1, conn, 3, 3
        if not rstTMDOWN1.eof then
            sCount = 0 
            sSQL = sSQL & " AND ( "
            Do while not rstTMDOWN1.eof
                sCount = sCount + 1
                if sCount = 1 then
                    sSQL = sSQL & " EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "'"
                else
                    sSQL = sSQL & " or EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "'"
                    
                end if
                sSQL = sSQL &   " or EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"  

            rstTMDOWN1.movenext
            loop
        sSQL = sSQL & " ) " 
        end if

        set rsttmpdown = server.createobject("adodb.recordset")
        sSQL = sSQL & " order by EMP_CODE, NAME asc "
        rsttmpdown.Open SSQL, conn, 3, 3
        if not rsttmpdown.eof then
            Do while not rsttmpdown.eof
                sSQLT = "INSERT into TMTMPDOWN (EMP_CODE, NAME)"
                sSQLT = sSQLT & "values ("
		        sSQLT = sSQLT & "'" & rsttmpdown("EMP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & pRTIN(rsttmpdown("NAME")) & "')"
                conn.execute sSQLT
		    rsttmpdown.movenext
            loop
        end if
        
        if sSQL_S <> "" then
            sql = " select * from TMTMPDOWN where 1=1"    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sql & " select * from TMTMPDOWN "    
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 
    
    elseif sAType = "V" and sApprov = "S" and sDown = "A" then
       
        Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMEMPLY where "
        sSQL1 = sSQL1 & " ATYPE ='S'"  '=== Select all the supervisor  
        rstTMDOWN1.Open sSQL1, conn, 3, 3
        if not rstTMDOWN1.eof then
            sCount = 0
            sSQL = sSQL & " AND ( "
            Do while not rstTMDOWN1.eof
                '==== 1 level down, all their subordinate
                sCount = sCount + 1
    
                if sCount = 1 then
                    sSQL = sSQL &   " EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"  
                else
                    sSQL = sSQL &   " or EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"  
                end if

                Set rstTMDOWN2 = server.CreateObject("ADODB.RecordSet")    
                sSQL2 = "select * from TMEMPLY where "
                sSQL2 = sSQL2 & " SUP_CODE ='" & rstTMDOWN1("EMP_CODE") & "'" '=== If the subordinate is a supervisor, select again the subordinate's subordinate  
                rstTMDOWN2.Open sSQL2, conn, 3, 3
                if not rstTMDOWN2.eof then
                    
                    Do while not rstTMDOWN2.eof
                        
                        sSQL = sSQL &   " or EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN2("EMP_CODE") & "')"  
            
                    rstTMDOWN2.movenext
                    loop
                end if
            rstTMDOWN1.movenext
            loop

        sSQL = sSQL & " ) " 
        end if
  
        set rsttmpdown = server.createobject("adodb.recordset")
        sSQL = sSQL & " order by EMP_CODE, NAME asc "
        rsttmpdown.Open SSQL, conn, 3, 3
        if not rsttmpdown.eof then
            Do while not rsttmpdown.eof
                sSQLT = "INSERT into TMTMPDOWN (EMP_CODE, NAME)"
                sSQLT = sSQLT & "values ("
		        sSQLT = sSQLT & "'" & rsttmpdown("EMP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & pRTIN(rsttmpdown("NAME")) & "')"
                conn.execute sSQLT
		    rsttmpdown.movenext
            loop
        end if

        if sSQL_S <> "" then
            sql = " select * from TMTMPDOWN where 1=1"    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sql & " select * from TMTMPDOWN "    
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 

    elseif sAtype = "M" and sApprov = "M" and sDown <> "A" then

        '==== For Manager with direct subordinate who needs to punch like Goo Feng Guan, M4 
        Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMEMPLY where "
        sSQL1 = sSQL1 & " SUP_CODE ='" & sDown & "'" '=== Retrieve all the employee under each Manager  
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
        sSQL2 = sSQL2 & " COSTMAN_CODE ='" & sDown & "'"  '==== He is Cost Manager of which Cost Center
        rstTMCOST.Open sSQL2, conn, 3, 3
        if not rstTMCOST.eof then
            sSQL = sSQL & " or ("
            sCount = 0
            Do while not rstTMCOST.eof 
                sCount = sCount + 1 
                '==== Retrieve the employee who is at his Cost Center and pending 2nd level Managerial Approval
                if sCount = 1 then 
                    sSQL = sSQL & " ( EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & sDown &"') )" '=== Don't select back the manager coz he is also in the Cost Center
                else
                    sSQL = sSQL & " or ( EMP_CODE in ( select EMP_CODE from TMEMPLY where COST_ID='" & rstTMCOST("COST_ID") & "' and EMP_CODE <> '" & sDown &"') )"
                end if   
            rstTMCOST.movenext
            loop
            sSQL = sSQL & " ) "
        end if 

        set rsttmpdown = server.createobject("adodb.recordset")
        sSQL = sSQL & " order by EMP_CODE, NAME asc "
        rsttmpdown.Open SSQL, conn, 3, 3
        if not rsttmpdown.eof then
            Do while not rsttmpdown.eof
                sSQLT = "INSERT into TMTMPDOWN (EMP_CODE, NAME)"
                sSQLT = sSQLT & "values ("
		        sSQLT = sSQLT & "'" & rsttmpdown("EMP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & pRTIN(rsttmpdown("NAME")) & "')"
                conn.execute sSQLT
		    rsttmpdown.movenext
            loop
        end if

        if sSQL_S <> "" then
            sql = " select * from TMTMPDOWN where 1=1"    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sql & " select * from TMTMPDOWN "    
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 

    elseif sAtype = "M" and sApprov = "S" and sDown <> "A" then
        Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMEMPLY where "
        sSQL1 = sSQL1 & " SUP_CODE ='" & sDown & "'"  
        rstTMDOWN1.Open sSQL1, conn, 3, 3
        if not rstTMDOWN1.eof then
            sCount = 0 
            sSQL = sSQL & " AND ( "
            Do while not rstTMDOWN1.eof
                sCount = sCount + 1
                if sCount = 1 then
                    sSQL = sSQL & " EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "'"
                else
                    sSQL = sSQL & " or EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "'"
                    
                end if
                sSQL = sSQL &   " or EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"  

            rstTMDOWN1.movenext
            loop
        sSQL = sSQL & " ) " 
        end if

        set rsttmpdown = server.createobject("adodb.recordset")
        sSQL = sSQL & " order by EMP_CODE, NAME asc "
        rsttmpdown.Open SSQL, conn, 3, 3
        if not rsttmpdown.eof then
            Do while not rsttmpdown.eof
                sSQLT = "INSERT into TMTMPDOWN (EMP_CODE, NAME)"
                sSQLT = sSQLT & "values ("
		        sSQLT = sSQLT & "'" & rsttmpdown("EMP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & pRTIN(rsttmpdown("NAME")) & "')"
                conn.execute sSQLT
		    rsttmpdown.movenext
            loop
        end if

        if sSQL_S <> "" then
            sql = " select * from TMTMPDOWN where 1=1"    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sql & " select * from TMTMPDOWN "    
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 

    elseif sAtype = "M" and sApprov = "S" and sDown = "A" then
          
        Set rstTMCOST = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMCOST where "
        sSQL1 = sSQL1 & " COSTMAN_CODE ='" & sLogin & "'"  '=== Check the Login is a Cost Manager for which Cost Center
        rstTMCOST.Open sSQL1, conn, 3, 3
        if not rstTMCOST.eof then
            sCount = 0
            Do while not rstTMCOST.eof '=== if got record, loop through each Cost Center that he is a Cost Manager
                Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                sSQL1 = "select * from TMEMPLY where "
                sSQL1 = sSQL1 & " COST_ID ='" & rstTMCOST("COST_ID")  & "'"  '=== Retrieve all Employees belong to the Cost Center
                sSQL1 = sSQL1 & " AND ATYPE = 'S' "  '=== Only take those who is a superior role
                rstTMEMPLY.Open sSQL1, conn, 3, 3
                if not rstTMEMPLY.eof then
                        
                    Do while not rstTMEMPLY.eof 
                        sCount = sCount + 1
                        '==== Insert into the sql where the 1DTAPV is null and the Employee who Superior of that Cost Center           
                        if sCount = 1 then
                            sSQL = sSQL & " and SUP_CODE ='" & rstTMEMPLY("EMP_CODE") & "'"
                        else
                            sSQL = sSQL & " or SUP_CODE ='" & rstTMEMPLY("EMP_CODE") & "'"
                        end if

                    rstTMEMPLY.movenext
                    loop
                end if
            rstTMCOST.movenext
            loop
        end if

        set rsttmpdown = server.createobject("adodb.recordset")
        sSQL = sSQL & " order by EMP_CODE, NAME asc "
        rsttmpdown.Open SSQL, conn, 3, 3
        if not rsttmpdown.eof then
            Do while not rsttmpdown.eof
                sSQLT = "INSERT into TMTMPDOWN (EMP_CODE, NAME)"
                sSQLT = sSQLT & "values ("
		        sSQLT = sSQLT & "'" & rsttmpdown("EMP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & pRTIN(rsttmpdown("NAME")) & "')"
                conn.execute sSQLT
		    rsttmpdown.movenext
            loop
        end if

        if sSQL_S <> "" then
            sql = " select * from TMTMPDOWN where 1=1"    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sql & " select * from TMTMPDOWN "    
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 

    elseif sAtype = "S" then

        Set rstTMDOWN1 = server.CreateObject("ADODB.RecordSet")    
        sSQL1 = "select * from TMEMPLY where "
        sSQL1 = sSQL1 & " SUP_CODE ='" & sDown & "'"  
        rstTMDOWN1.Open sSQL1, conn, 3, 3
        if not rstTMDOWN1.eof then
            sCount = 0 
            sSQL = sSQL & " AND ( "
            Do while not rstTMDOWN1.eof
                sCount = sCount + 1
                if sCount = 1 then
                    sSQL = sSQL & " EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "'"
                else
                    sSQL = sSQL & " or EMP_CODE = '" & rstTMDOWN1("EMP_CODE") & "'"
                    
                end if
                
                sSQL = sSQL &   " or EMP_CODE in (select EMP_CODE from TMEMPLY where SUP_CODE = '" & rstTMDOWN1("EMP_CODE") & "')"  

            rstTMDOWN1.movenext
            loop
        sSQL = sSQL & " ) " 
        end if

        set rsttmpdown = server.createobject("adodb.recordset")
        sSQL = sSQL & " order by EMP_CODE, NAME asc "
        rsttmpdown.Open SSQL, conn, 3, 3
        if not rsttmpdown.eof then
            Do while not rsttmpdown.eof
                sSQLT = "INSERT into TMTMPDOWN (EMP_CODE, SUP_CODE, NAME)"
                sSQLT = sSQLT & "values ("
		        sSQLT = sSQLT & "'" & rsttmpdown("EMP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & rsttmpdown("SUP_CODE") & "',"		
		        sSQLT = sSQLT & "'" & pRTIN(rsttmpdown("NAME")) & "')"
                conn.execute sSQLT
		    rsttmpdown.movenext
            loop
        end if
        
        if sSQL_S <> "" then
            sql = " select * from TMTMPDOWN where 1=1"    
            sql = sql & sSQL_S & " order by EMP_CODE, NAME asc "
        else
            sql = sql & " select * from TMTMPDOWN "    
            sql = sql & " order by EMP_CODE, NAME asc "
        end if 

    end if
    'response.write sql
    'response.end
set rstUser = server.createobject("adodb.recordset")
rstUser.cursortype = adOpenStatic
rstUser.cursorlocation = adUseClient
rstUser.locktype = adLockBatchOptimistic
rstUser.pagesize = PageLen		
rstUser.Open sql, conn, 3, 3

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
    <form id="viewform" class="form-horizontal" action="javascript:showDetails('page=1','EMP','mycontent');") method="post">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-3">
                <div class="pull-left">
                    <h3>View Employee</h3>
                </div>
            </div>
            <div class="col-sm-4 pull-right">
                <div class="input-group">
                    
                    <input class="form-control" id="txtSearch_down" name="txtSearch" value="<%=txtSearch%>" placeholder="Search" maxlength="100" type="text" />
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="submit" name="search" value="Search" onclick="showDetails('page=1','EMP','mycontent');return false;"><i class="fa fa-search"></i>
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
                <th style="width:45%">Employee No</th>
                <th style="width:50%">Name</th>
                
            </tr>
        </thead>
        
        <tbody>
            <%
                                        
            do while not rstUser.eof and i < PageLen
                i = i + 1                        
                
                sURL = "&page=" & PageNo & "&txtsearch=" & txtSearch
                
                '===Escape ' for Javascript
                sName = Replace(rstUser("NAME"), "'", "\'")
                
                response.write "<tr onmouseover=this.bgColor='#FFF59D' onmouseout=this.bgColor='white' onclick=""getValue2('" & rstUser("EMP_CODE") & "','txtID','" & sName & "','txtNAME')"">"
                    response.write "<td>" & i + ((PageNo-1)*PageLen) & "</td>"
                    response.write "<td>" & rstUser("EMP_CODE") & "</td>"
                    response.write "<td>" & rstUser("NAME") & "</td>"
                    'response.write "<td>" & sDown & "</td>"
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
                        <li class="paginate_button"><a href="javascript:showDetails('page=1','EMP','mycontent');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo-1%>','EMP','mycontent');" class="button_a" >< Back</a></li>
                    <%End IF%>
				
                    <%For intID = 1 To TotalPage%>
                    <% if (intID >= (Cint(PageNo)-3)) and (intID <= (Cint(PageNo)+3)) Then%>
                        <% if intID = Cint(PageNo) Then%>
                            <li class="paginate_button active"><a href="#"><%=intID%></a></li>
                        <%Else%>
                            <li class="paginate_button"><a href="javascript:showDetails('page=<%=intID%>','EMP','mycontent');" class="button_a" ><%=intID%></a></li>
                        <%End IF%>
                    <%End IF%>
                    <%Next%>

                    <%IF Cint(PageNo) < TotalPage Then %>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=PageNo+1%>','EMP','mycontent');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showDetails('page=<%=TotalPage%>','EMP','mycontent');" class="button_a" >Last >></a></li>
                    <%End IF%>
                </ul>
            </div>
        </div>
    </div>
    </form>
</section>
    
    <!-- /.box -->
