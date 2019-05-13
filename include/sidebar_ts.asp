<%
Set rstTSPass = Server.CreateObject("ADODB.Recordset")
	sSQL = "select * from tspass where ID = '"& session("USERNAME") &"'"
	rstTSPass.Open sSQL, conn, 3, 3
	if not rstTSPass.BOF Then
		if rstTSPass("TSACCESS") = "A" then
			sTSAccess = "Y"
		end if
	end if
%>

<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
    <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <!--<li class="header"><LOGO></LOGO></li>-->
            <li style="background-color:black">
                   <a href="tsdash.asp"><span>Transport System</span></a>
            </li>
			<li class="treeview">
				<a href="#">
					<i class="fa fa-cog"></i><span>Maintenance</span>
						<span class="pull-right-container">
					<i class="fa fa-angle-left pull-right"></i>
					</span>
				</a>
				<ul class="treeview-menu">
					<li><a href="tsarea.asp"><i class="fa fa-user-o"></i>Area Code</a></li>
					<!--<li><a href="tsemply.asp"><i class="fa fa-user-o"></i>Employee Transport</a></li>-->
				</ul>
			</li>
            
			<li class="treeview">
				<a href="#">
				<i class="fa fa-bus"></i><span>Transaction</span>
				<span class="pull-right-container">
					<i class="fa fa-angle-left pull-right"></i>
				</span>
				</a>
				<ul class="treeview-menu">
					<li><a href="tstransport.asp"><i class="fa fa-male"></i>OT Arrangement</a></li>
				</ul>
			</li>
            	
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-book"></i><span>Report</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                    	<li><a href="tsreport.asp?type=TL"><i class="fa fa-file-o"></i>Transport Listing </a></li>
                    	<li><a href="tsreport.asp?type=EL"><i class="fa fa-file-o"></i>Employee Listing </a></li>
                        <li><a href="tsreport.asp?type=RL"><i class="fa fa-file-o"></i>Route Listing </a></li>
                        <li><a href="tsreport.asp?type=EX"><i class="fa fa-file-o"></i>Exceptional </a></li>
                    </ul>
            </li>   
            <%if sTSAccess = "Y" then%>
            <li class="treeview">
                <a href="#">
                    <i class="fa  fa-hourglass-2"></i><span>Utilities</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                    	<li><a href="tsexcept.asp"><i class="fa fa-th"></i>Exception</a></li>   
                    	<li><a href="tssetup.asp"><i class="fa fa-th"></i>Program Setup</a></li>     
                    </ul>

            </li>
            <%end if%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>