<!-- #include file="include/proc.asp" -->
<%  
    sHelpDiv = Trim(request("txthelpDiv")) 
    sValue = Trim(request("txtValue"))    
%>

<%if sHelpDiv = "txtMinM4OTHelpDiv" then %>
<div id="txtTRangeHelpDiv">
        For grade M4 Employees, a minimum work of more than <%=TimetoMin(sValue) %> mins of Shift Time, then only OT will start to generate
</div>
<%end if %>
<%if sHelpDiv = "txtLateGrHelpDiv" then %>
<div id="txtLateGrHelpDiv">
    <%=sValue %> means that punch in after <%=TimetoMin(sValue) %> mins of Shift IN Time is considered as Late
</div>
<%end if %>
<%if sHelpDiv = "txtEarlyGrHelpDiv" then %>
<div id="txtEarlyGrHelpDiv">
    <%=sValue %> means that punch out before <%=TimetoMin(sValue) %> mins of Shift OUT Time is considered as Early dismiss
</div>
<%end if %>
<%if sHelpDiv = "txtMinOTHelpDiv" then %>
<div id="txtMinOTHelpDiv">
    For grade M0,M1,M2 Employees, a minimum work of more than <%=TimetoMin(sValue) %> mins of Shift Time, then only OT will start to generate
</div>
<%end if %>
<%if sHelpDiv = "txtMMDaysHelpDiv" then %>
<div id="txtMMDaysHelpDiv">
    Mid Month Minimum Days                                        
</div>
<%end if %>
<%if sHelpDiv = "txtMMAmtHelpDiv" then %>
<div id="txtMMAmtHelpDiv">
    Mid Month Amount                                        
</div>
<%end if %>
<%if sHelpDiv = "txtOTXHourHelpDiv" then %>
<div id="txtOTXHourHelpDiv">
    Overtime Exceed Limit in Hour                                       
</div>
<%end if %>
<%if sHelpDiv = "txtPayFromHelpDiv" then %>
<div id="txtPayFromHelpDiv">
    Pay Period From                                     
</div>
<%end if %>
<%if sHelpDiv = "txtPayToHelpDiv" then %>
<div id="txtPayToHelpDiv">
    Pay Period To                                     
</div>
<%end if %>
<%if sHelpDiv = "txtHalfDayGrHelpDiv" then %>
<div id="txtHalfDayGrDiv">
    Half Day Grace Period                                       
</div>
<%end if %>
<%if sHelpDiv = "txtNumRowsHelpDiv" then %>
<div id="txtNumRowsHelpDiv">
    Number of rows of records per page                                       
</div>
<%end if %>
