<%
Set rstOGPass = server.CreateObject("ADODB.RecordSet")
sql = "select * from ogpass where ID = '" & session("USERNAME") & "' "
rstOGPass.Open sql, conn, 3, 3
if not rstOGPass.eof then
	if rstOGPass("OGACCESS") = "N" then
		sAccess = "N"
	elseif rstOGPass("OGACCESS") = "A" then
		sAccess = "A"
	elseif rstOGPass("OGACCESS") = "F" then
		sAccess = "F"
	elseif rstOGPass("OGACCESS") = "D" then
		sAccess = "D"
	elseif rstOGPass("OGACCESS") = "S" then
		sAccess = "S"
	end if
end if
call pCloseTables(rstOGPass)
Set rstOGPath = server.CreateObject("ADODB.RecordSet")
sql = "select * from ogpath where EMP_CODE = '" & session("USERNAME") & "' "

rstOGPath.Open sql, conn, 3, 3
if not rstOGPath.eof then
	if fDate2(now()) >= fDate2(rstOGPath("DT_FROM")) and fDate2(now()) <= fDate2(rstOGPath("DT_TO")) then
		sActMan = "Y"
	end if
end if
call pCloseTables(rstOGPath)


%>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
    <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <!--<li class="header"><LOGO></LOGO></li>-->
            <li style="background-color:black">
                   <a href="ogdash.asp"><span>OUT GOING GOODS PASS</span></a>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cog"></i><span>Maintenance</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                    	<%if sAccess = "A" or sAccess = "F" or sAccess = "D" or sActMan = "Y" then %>
	                        <li><a href="ogprop.asp"><i class="fa fa-user-o"></i>Outgoing Good Pass</a></li>
	                        <li><a href="oglist.asp"><i class="fa fa-user-o"></i>View/Return OGP</a></li>
	                        <li><a href="ogapprlist.asp"><i class="fa fa-user-o"></i>Approve/Reject OGP List</a></li>
                        <%elseif sAccess = "N" then%>
                            <li><a href="ogprop.asp"><i class="fa fa-user-o"></i>Outgoing Good Pass</a></li>
	                        <li><a href="oglist.asp"><i class="fa fa-user-o"></i>View OGP</a></li>
                       	<%elseif sAccess = "S" then%>	
                       		<li><a href="oglist.asp"><i class="fa fa-user-o"></i>View/Return OGP</a></li>
                        <%end if%>
                    </ul>

            </li>
            <%if sAccess <> "S" then%>	
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-book"></i><span>Report</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                    	<li><a href="ogreport.asp?type=AG"><i class="fa fa-file-o"></i>Aging </a></li>
                    	<li><a href="ogreport.asp?type=OG"><i class="fa fa-file-o"></i>Outgoing Goods </a></li>
                        <li><a href="ogreport.asp?type=OD"><i class="fa fa-file-o"></i>Overdue </a></li>
                        <li><a href="ogreport.asp?type=LF"><i class="fa fa-file-o"></i>Log File </a></li>
                    </ul>
            </li>   
            <%end if%>
            
            <%if sAccess = "A" or sAccess = "F" or sAccess = "D" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa  fa-hourglass-2"></i><span>Utilities</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                    	<li><a href="ogsetup.asp"><i class="fa fa-th"></i>Program Setup</a></li>     
                    </ul>
            </li>
            <%end if%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>