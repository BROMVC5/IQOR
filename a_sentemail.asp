<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

    <%  
        Dim ObjSendMail

        Set ObjSendMail = CreateObject("CDO.Message")
							
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.iqorams.net"
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = "False"
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = "hr@iqor.com"
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = ""
		ObjSendMail.Configuration.Fields.Update
		
		ObjSendMail.Subject = "Testing Send Email"
		ObjSendMail.From = "hr@iqor.com"
		ObjSendMail.To = "brosoftware@gmail.com"
		ObjSendMail.HTMLBody = "Send mail successful"
		
		'response.write " Before Send "
		'response.end
		ObjSendMail.Send
				    
		Set ObjSendMail = Nothing

        response.write "Email Sent Successfully"
     %>
</head>

<body>


</body>

</html>
