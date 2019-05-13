<%

    If lcase(Request.ServerVariables("HTTPS")) = "on" Then 
        sProtocol = "https" 
    Else
        sProtocol = "http" 
    End If

    sDomain= Request.ServerVariables("SERVER_NAME")
    sPath= Trim(Request.ServerVariables("SCRIPT_NAME") )
    sQueryString= Request.ServerVariables("QUERY_STRING")

    sFullUrl = sProtocol & "://" & sDomain & sPath
    If Len(sQueryString) > 0 Then
       sFullUrl = sFullUrl & "?" & sQueryString
    End If

    'Response.Write "Domain : " & sDomain & "</br>"
    'Response.Write "Path : " & sPath & "</br>"
    'Response.Write "QueryString : " & sQueryString & "</br>"
    'Response.Write "FullUrl : " & sFullUrl & "</br>"

if session("USERNAME") = "" then
	response.redirect("login.asp")

else
    
    Set rstCPPass = server.CreateObject("ADODB.RecordSet")
	sql = "select * from CPPASS where ID = '" & session("USERNAME") & "' "
	rstCPPass.Open sql, conn, 3, 3
	if not rstCPPass.eof then
		if rstCPPass("CPACCESS") = "H" then
			response.redirect("cppend.asp")
		elseif rstCPPass("CPACCESS") = "S" then
			response.redirect("cpreserve.asp")
		end if
	end if

    Set rstCSPass = Server.CreateObject("ADODB.Recordset")
	sSQL = "select * from cspass where ID = '"& session("USERNAME") &"'"
	rstCSPass.Open sSQL, conn, 3, 3
	if not rstCSPass.BOF Then
		if rstCSPass("CSACCESS") = "C" then
			response.redirect("cspos.asp")
		end if
	end if

	Set rstOGPass = Server.CreateObject("ADODB.Recordset")
	sSQL = "select * from ogpass where ID = '"& session("USERNAME") &"'"
	rstOGPass.Open sSQL, conn, 3, 3
	if not rstOGPass.BOF Then
		if rstOGPass("OGACCESS") = "S" then
			response.redirect("oglist.asp")
		end if
	end if


end if
%>