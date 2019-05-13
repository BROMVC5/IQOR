<!-- #include file="include/connection.asp" -->

<%
sType = request("Type") 

Set rstSourceID = Server.CreateObject ("ADODB.recordset")

if sType = "TM" then
	sSQL = "SELECT DEB_CODE, NAME FROM ARDM where DEB_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR Name like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "DEB_CODE"
	temp = "NAME"
	
elseif sType = "EC" Then
	sSQL = "select EMP_CODE, NAME from TMEMPLY where EMP_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR NAME like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "EMP_CODE"
	temp2 = "NAME"

elseif sType = "SUPERIOR" Then
	sSQL = "select EMP_CODE, NAME from TMEMPLY where ATYPE <> 'E' and EMP_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR NAME like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "EMP_CODE"
	temp2 = "NAME"

elseif sType = "EC2" Then
	sSQL = "select EMP_CODE, NAME, DT_RESIGN from TMEMPLY where EMP_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR NAME like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "EMP_CODE"
	temp2 = "NAME"
	temp3 = "DT_RESIGN"
	
elseif sType = "EC3" Then
	sSQL = "select EMP_CODE, DEPT_ID from TMEMPLY where EMP_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "EMP_CODE"
	temp2 = "DEPT_ID"
	
elseif sType = "DP" Then 
	sSQL = "select DEPT_ID, PART from TMDEPT where DEPT_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "DEPT_ID"
	temp2 = "PART"

elseif sType = "HR" Then
	sSQL = "select EMP_CODE, NAME, DESIGN_ID from TMEMPLY where DESIGN_ID like 'HR%' "
	sSQL = sSQL & "AND (EMP_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & "OR NAME like '"  & Request.QueryString("term") & "%')"
	sSQL = sSQL & " Limit 50"

	temp = "EMP_CODE"
	temp2 = "NAME"

elseif sType = "CI" Then
	sSQL = "SELECT COMPNAME, STATUS, CREATE_ID , DT_CREATE from VRCOMP "
	sSQL = sSQL & "WHERE STATUS <> 'N' "
	sSQL = sSQL & "AND COMPNAME like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "COMPNAME"
	temp2 = ""
	
elseif sType = "ET" Then
	sSQL = "SELECT ENTITLEMENT, STATUS from MSENTYPE "
	sSQL = sSQL & "WHERE STATUS <> 'N' "
	sSQL = sSQL & "AND ENTITLEMENT like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "ENTITLEMENT"
	temp2 = ""
	
elseif sType = "GC" Then
	sSQL = "SELECT GRADE_ID, PART from TMGRADE "
	sSQL = sSQL & "WHERE GRADE_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "GRADE_ID"
	temp2 = "PART"

elseif sType = "DS" Then
	sSQL = "select DESIGN_ID, PART from TMDESIGN "
	sSQL = sSQL & "WHERE DESIGN_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "DESIGN_ID"
	temp2 = "PART"

elseif sType = "PC" Then
	sSQL = "select PANELCODE, PANELNAME, STATUS from MSPANELC "
	sSQL = sSQL & "WHERE STATUS <> 'N' "
	sSQL = sSQL & "AND PANELCODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & "OR PANELNAME like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "PANELCODE"
	temp2 = "PANELNAME"	
	
elseif sType = "CC" Then
	sSQL = "select COST_ID, PART from TMCOST "
	sSQL = sSQL & "WHERE COST_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "COST_ID"
	temp2 = "PART"
	
elseif sType = "CT" Then
	sSQL = "select CONT_ID, PART from TMCONT "
	sSQL = sSQL & "WHERE CONT_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"

	temp = "CONT_ID"
	temp2 = "PART"
	
elseif sType = "AC" Then
	sSQL = "select AREACODE, AREA from TSAREA "
	sSQL = sSQL & "WHERE AREACODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR AREA like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "AREACODE"
	temp2 = "AREA"

elseif sType = "FN" Then
	sSQL = "select EMP_CODE, NAME from TMEMPLY WHERE ATYPE = 'M'"
	sSQL = sSQL & "AND (EMP_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR NAME like '"  & Request.QueryString("term") & "%')"
	sSQL = sSQL & " Limit 50"
	
	temp = "EMP_CODE"
	temp2 = "NAME"
	
elseif sType = "WL" Then
	sSQL = "select WORK_ID, PART from TMWORK "
	sSQL = sSQL & "WHERE WORK_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "WORK_ID"
	temp2 = "PART"
	
elseif sType = "HC" Then
	sSQL = "select DISTINCT HOL_ID, NAME from TMHOL1 "
	sSQL = sSQL & "WHERE HOL_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR NAME like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "HOL_ID"
	temp2 = "NAME"
	
elseif sType = "SP" Then
	sSQL = "select DISTINCT SHFPAT_ID, PART from TMSHFPAT "
	sSQL = sSQL & "WHERE SHFPAT_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "SHFPAT_ID"
	temp2 = "PART"
	
elseif sType = "ALLOW" Then
	sSQL = "select ALLCODE, PART from TMALLOW "
	sSQL = sSQL & "WHERE ALLCODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " order by ALLCODE asc Limit 50"
	
	temp = "ALLCODE"
	temp2 = "PART"
	
elseif sType = "TC" Then
	sSQL = "select SHF_CODE, PART,STIME,ETIME from TMSHFCODE "
	sSQL = sSQL & "WHERE SHF_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " order by SHF_CODE"
	sSQL = sSQL & " Limit 50"
	
	temp = "SHF_CODE"
	temp2 = "PART"
    temp3 = "STIME"
    temp4 = "ETIME"

elseif sType = "WG" Then
	sSQL = "select DISTINCT WORKGRP_ID, PART from TMWORKGRP "
	sSQL = sSQL & "WHERE WORKGRP_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "WORKGRP_ID"
	temp2 = "PART"	

elseif sType = "TO" Then
	sSQL = "select TOFF_ID, PART from TMTIMEOFF "
	sSQL = sSQL & "WHERE TOFF_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "TOFF_ID"
	temp2 = "PART"		
	
elseif sType = "SHP" Then
	sSQL = "select DISTINCT SHFPLAN_ID, PART from TMSHFPLAN "
	sSQL = sSQL & "WHERE SHFPLAN_ID like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "SHFPLAN_ID"
	temp2 = "PART"

elseif sType = "NAT" Then
	sSQL = "select NATION, PART from TMNATION "
	sSQL = sSQL & "WHERE NATION like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "NATION"
	temp2 = "PART"		

elseif sType = "REL" Then
	sSQL = "select RELIG, PART from TMRELIG "
	sSQL = sSQL & "WHERE RELIG like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR PART like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " Limit 50"
	
	temp = "RELIG"
	temp2 = "PART"

elseif sType = "EC4" Then
	
	sSQL = "select tmemply.EMP_CODE , tmemply.NAME , tmemply.COST_ID, tmcost.PART from tmemply "
	sSQL = sSQL & "left join tmcost on tmemply.COST_ID = tmcost.COST_ID "
	sSQL = sSQL & "where tmemply.EMP_CODE like '" & Request.QueryString("term") & "%'"
	sSQL = sSQL & "or tmemply.NAME like '" & Request.QueryString("term") & "%'"
	sSQL = sSQL & "group by emp_code asc "
	sSQL = sSQL & "Limit 50"

	temp = "EMP_CODE"
	temp2 = "NAME"
	temp3 = "COST_ID"
	temp4 = "PART"

elseif sType = "DC" Then
	
	sSQL = "select COMPNAME, TEL, ADD1, ADD2, CITY, POST from vrcomp where 1=1  "
	sSQL = sSQL & "and STATUS = 'Y'  "
	sSQL = sSQL & "and COMPNAME like '" & Request.QueryString("term") & "%'"
	'sSQL = sSQL & "or tmemply.NAME like '" & Request.QueryString("term") & "%'"
	'sSQL = sSQL & "group by COMPNAME asc "
	sSQL = sSQL & "Limit 50"

	temp = "COMPNAME"
	temp2 = "TEL"
	temp3 = "ADD1"
	temp4 = "ADD2"
	temp5 = "CITY"
	temp6 = "POST"

elseif sType = "BROPASS" Then
	
    sSQL = "SELECT ID,NAME FROM BROPASS  where id like '%"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR NAME like '"  & Request.QueryString("term") & "%'"
    sSQL = sSQL & "order by id asc "
	sSQL = sSQL & "Limit 50"

	temp = "ID"
	temp2 = "NAME"

elseif sType = "SUBORD" Then '=== The subordinate according to access type

    sLogin = session("USERNAME")

    Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMEMPLY where "
    sSQL = sSQL & " EMP_CODE ='" & sLogin & "'"  
    rstTMEMPLY.Open sSQL, conn, 3, 3
    if not rstTMEMPLY.eof then
        sAType = rstTMEMPLY("ATYPE")
    end if 
    
    sSQL = "select EMP_CODE, NAME from TMEMPLY where EMP_CODE like '"  & Request.QueryString("term") & "%'"
	sSQL = sSQL & " OR NAME like '"  & Request.QueryString("term") & "%'"  '=== Still able to search resigned employee

    if sAtype = "V" then '=== Verifier will view everyone
    
    elseif sAType = "M" then

        '==== For Manager with direct subordinate who needs to punch in
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

    sSQL = sSQL & " order by EMP_CODE, NAME asc limit 50 "

    temp = "EMP_CODE"
	temp2 = "NAME"

end if

	rstSourceID.Open sSQL, conn, 3, 3
	output = "["   

	do While NOT rstSourceID.EOF 

		if sType <> "DC" then
			
			If temp4 <> "" Then
	            
	            output = output & "{""value"":""" & rstSourceID(temp) & " | " & rstSourceID(temp2) & """, ""data"":""" & rstSourceID(temp3) & " | " & rstSourceID(temp4) & """},"
	            
	        ElseIf temp3 <> "" Then
				output = output & "{""value"":""" & rstSourceID(temp) & " | " & rstSourceID(temp2) & """, ""data"":""" & rstSourceID(temp3) & """},"
			
	        Elseif temp2 <> "" Then
	        		output = output & "{""value"":""" & rstSourceID(temp) & " | " & rstSourceID(temp2) & """},"

			Else
				output = output & "{""value"":""" & rstSourceID(temp) & """},"
			End If

		elseif sType = "DC" then 
			output = output & "{""value"":""" & rstSourceID(temp) & " | " & rstSourceID(temp2) & """, ""data"":""" & rstSourceID(temp3) & " | " & rstSourceID(temp4) & " | " & rstSourceID(temp5) & " | " & rstSourceID(temp6) & """},"
		end if
		
		rstSourceID.MoveNext
	Loop
	
	rstSourceID.Close()
	Set rstSourceID = Nothing

	output=Left(output,Len(output)-1)
	output = output & "]"

	response.write output
%>

