<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <!--<li class="header"><LOGO></LOGO></li>-->
            <li class="treeview" style = "background-color:#1a2226">
                <a href="msdash.asp">
                    <span>Medical System</span>
                </a>
            </li>
			<%if Session("MSFM") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cog"></i><span>Maintenance</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<% if Session("MSFM1") = "Y" then %>
						<li><a href="msentype.asp?type=ET"><i class="fa fa-plus-square"></i>Entitlement Type</a></li>
					<%end if%>
					<% if Session("MSFM2") = "Y" then %>
						<li><a href="msen.asp?type=EN"><i class="fa fa-money"></i>Entitlement</a></li> 
					<%end if%>
					<% if Session("MSFM3") = "Y" then %>
						<li><a href="msfamily.asp?type=FM"><i class="fa fa-users"></i>Family</a></li>
					<%end if%>
					<% if Session("MSFM4") = "Y" then %>
						<li><a href="mspanelc.asp?type=PC"><i class="fa fa-heartbeat"></i>Panel Clinic</a></li>
					<%end if%>
                </ul>
            </li>
			<%end if%>
			<%if Session("MSTE") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-exchange"></i><span>Transaction</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<%if Session("MSTE1") = "Y" then %>
						<li><a href="msstaffc.asp"><i class="fa fa-stethoscope"></i>Staff Claim Entry</a></li>
					<%end if%>
                </ul>
            </li>
			<%end if%>
			<%if Session("MSPR") = "Y" then %>
			<li class="treeview">
                <a href="#">
                    <i class="fa fa-book"></i><span>Report</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<%if Session("MSPR1") = "Y" then %>
						<li><a href="msreport.asp?type=CR"><i class="fa fa-file-text"></i>Medical Claim</a></li>
					<%end if%>
					<%if Session("MSPR2") = "Y" then %>
						<li><a href="msreport.asp?type=BE"><i class="fa fa-file-text"></i>Balance Entitlement</a></li>
					<%end if%>
					<%if Session("MSPR3") = "Y" then %>
						<li><a href="msreport.asp?type=EX"><i class="fa fa-file-text"></i>Exception</a></li>
					<%end if%>
                </ul>
            </li>
			<%end if%>
			<%if Session("MSPC") = "Y" then %>
			<li class="treeview">
                <a href="#">
                    <i class="fa fa-gear"></i><span>Processing</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<%if Session("MSPC1") = "Y" then %>
						<li><a href="msimportclaim.asp"><i class="fa fa-clone"></i>Import Claim History</a></li>
					<%end if%>
					<%if Session("MSPC2") = "Y" then %>
						<li><a href="msimportclinic.asp"><i class="fa fa-clone"></i>Import Internal Clinic </a></li>
					<%end if%>
                </ul>
            </li>
			<%end if%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
