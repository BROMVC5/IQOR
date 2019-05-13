<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <!--<li class="header"><LOGO></LOGO></li>-->
            <li class="treeview" style = "background-color:#1a2226">
                <a href="vrdash.asp">
                    <span>Vendor Registration</span>
                </a>
            </li>
			<%if Session("VRFM") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cog"></i><span>Maintenance</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<%if Session("VRFM1") = "Y" then %>
						<li><a href="vrcomp.asp?type=CP"><i class="fa fa-industry"></i>Company</a></li>
					<%end if%>
					<%if Session("VRFM2") = "Y" then %>
						<li><a href="vrvend.asp?type=VD"><i class="fa fa-user-o"></i>Vendor</a></li> 
					<%end if%>
                    <!--<li><a href="tmpost.asp"><i class="fa fa-sitemap"></i>Position</a></li>-->
                </ul>
            </li>
			<%end if%>
			<%if Session("VRTE") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-exchange"></i><span>Transaction</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<%if Session("VRTE1") = "Y" then %>
						<li><a href="vrin.asp"><i class="fa  fa-sign-in"></i>Vendor In</a></li>
					<%end if%>
					<%if Session("VRTE2") = "Y" then %>
						<li><a href="vrout.asp"><i class="fa  fa-sign-out"></i>Vendor Out</a></li>
					<%end if%>
                </ul>
            </li>
			<%end if%>
			<%if Session("VRPR") = "Y" then %>
			<li class="treeview">
                <a href="#">
                    <i class="fa fa-book"></i><span>Report</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<%if Session("VRPR2") = "Y" then %>
						<li><a href="vrreport.asp?type=VR"><i class="fa fa-file-text"></i>Vendor Check In</a></li>
					<%end if%>
					<%if Session("VRPR1") = "Y" then %>
						<li><a href="vrreport.asp?type=BL"><i class="fa fa-file-text"></i>Blacklist</a></li>
					<%end if%>					
                </ul>
            </li>
			<%end if%>
			<%if Session("VRPC") = "Y" then %>
			<li class="treeview">
                <a href="#">
                    <i class="fa fa-gear"></i><span>Processing</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<%if Session("VRPC1") = "Y" then %>
						<li><a href="vrpurge.asp"><i class="fa fa-remove"></i>Vendor Data Purging</a></li>		
					<%end if%>
                </ul>
            </li>
			<%end if%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
