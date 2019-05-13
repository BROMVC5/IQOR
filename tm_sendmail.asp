<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

    <!-- #include file="tm_process.asp" -->

    <%  
        Server.ScriptTimeout = 1000000
            
        '==== This will be 9:00am everymorning, it will wait for 7am end shift.
        '==== Then it will have 9am process for previous day. 
        '==== And send out the emails
       
        '=============== Insert into TMOUTBOX ==================================================================
               
        dtSentMail = dateadd("d",-1, date()) '=== Process Yesterday records, send out at 9am
            
        call fEmail((dtSentMail),sEmp_Code,"Y")

        '=========================================================================================================
        
    %>
</head>

<body>


</body>

</html>
