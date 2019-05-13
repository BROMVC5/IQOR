<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
    Response.ContentType = "application/json"	
	Server.ScriptTimeout = 1000000
	
	sID = request("txtEmp_Code")
    dtFr = request("dtpFr")
    dtTo = request("dtpTo")
    sWhat = request("txtWhat")

    'response.write "{ ""data"": { ""status"": ""DateFrom " & request("dtpFr") & "fdsfds"" } }"
	'response.end 

    Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
    sSQL = "select * from TMEMPLY where EMP_CODE='" & sID & "'" 
    rstTMEMPLY.Open sSQL, conn, 3, 3
    if rstTMEMPLY.eof then
        response.write "{ ""data"": { ""status"": ""invalid"", ""value"":""Invalid Employee Code"" } }"
        response.end
    else
        
        if dtFr <> "" and dtTo <>"" then

	        do while CDate(dtFr) <= CDate(dtTo)  '==== Loop Date Apply From to To and check if the leave apply already exist
		        
                if sWhat = "TMCLK2" then
                    sSQL = "select * from TMCLK2 where EMP_CODE = '" & sID & "'"
		            sSQL =  sSQL & " and DT_WORK = '" & fdate2(dtFr) & "'"  
		            set rstTMCLK2 = server.CreateObject("ADODB.Recordset")
		            rstTMCLK2.open sSQL, conn, 3, 3
		            if not rstTMCLK2.eof then
                        response.write "{ ""data"": { ""status"": ""dtexist"" , ""value"":""(" & dtFr & ") has clock in time. Cannot be deleted!"" } }"
	                    response.end 
                     else
                        response.write "{ ""data"": { ""status"": ""ok"" } }"
	                    response.end 
                    end if 
		            pCloseTables(rstTMCLK2)
                    
                else
		            sSQL = "select * from TMEOFF where EMP_CODE = '" & sID & "'"
		            sSQL =  sSQL & " and DTFR <= '" & fdate2(dtFr) & "'"  
		            sSQL =  sSQL & " and DTTO >= '" & fdate2(dtFr) & "'"  
		            set rstTMEOFF = server.CreateObject("ADODB.Recordset")
		            rstTMEOFF.open sSQL, conn, 3, 3
		            if not rstTMEOFF.eof then
                        response.write "{ ""data"": { ""status"": ""dtexist"" , ""value"":""Leave Applied on date (" & dtFr & ") already existed"" } }"
	                    response.end 
		            end if
		            pCloseTables(rstTMEOFF)
                
                end if

                dtFr = DateAdd("d",1,dtFr) '=== add another day to from until FROM is bigger than TO, then the loop stop
	
            loop
        else
            response.write "{ ""data"": { ""status"": ""ok"" } }"
	        response.end 
        end if 
    end if
    pCloseTables(rstTMEMPLY)





%>


