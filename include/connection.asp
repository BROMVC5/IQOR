<%
session.lcid=2057

Set conn=Server.CreateObject("ADODB.Connection")
DSNtemp="Driver={MySQL ODBC 5.3 Unicode Driver};"
'DSNtemp= DSNtemp & "Server=" & "127.0.0.1" & ";Port=3307;UID=root;Password=;Database=iqor;OPTION=3;" '== Laptop
    
    '===Database iqor_from_iqor===
    DSNtemp= DSNtemp & "Server=" & "192.168.0.221" & ";Port=3307;UID=root;Password=admin@987412;Database=iqor190509;OPTION=3;" '===BRO

conn.Open DSNtemp
%>