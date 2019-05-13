<%
Set rstCPPass = server.CreateObject("ADODB.RecordSet")
sql = "select * from CPPASS where ID = '" & session("USERNAME") & "' "
rstCPPass.Open sql, conn, 3, 3
if not rstCPPass.eof then
	if rstCPPass("CPACCESS") = "H" then
		sAccess = "H"
	elseif rstCPPass("CPACCESS") = "A" then
		sAccess = "A"
	elseif rstCPPass("CPACCESS") = "S" then
		sAccess = "S"
	elseif rstCPPass("CPACCESS") = "N" then
		sAccess = "N"
	end if
end if
call pCloseTables(rstCPPass)

%>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <!--<li class="header"><LOGO></LOGO></li>-->
            <li class="treeview" style = "background-color:#1a2226">
                <a href="cpdash.asp">
                    <span>Carpark Reservation</span>
                </a>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-exchange"></i><span>Transaction</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
					<%if sAccess = "H" then %>
						<li><a href="cppend.asp"><i class="fa fa-hand-stop-o"></i>Pending Reservation</a></li>
						<li><a href="cpapp.asp"><i class="fa fa-check"></i>Approved Reservation</a></li>
						<li><a href="cprej.asp"><i class="fa fa-times-circle"></i>Rejected Reservation</a></li>
					<%elseif sAccess = "A" then %>
						<li><a href="cpentry.asp"><i style="color:green" class="fa fa-car"></i>Car Registration</a></li>
						<li><a href="cpreserve.asp"><i class="fa fa-car"></i>New Reservation</a></li>
						<li><a href="cppend.asp"><i class="fa fa-hand-stop-o"></i>Pending Reservation</a></li>
						<li><a href="cpapp.asp"><i class="fa fa-check"></i>Approved Reservation</a></li>
						<li><a href="cprej.asp"><i class="fa fa-times-circle"></i>Rejected Reservation</a></li>
					<%elseif sAccess = "S" or sAccess = "N" then %>
						<li><a href="cpentry.asp"><i style="color:green" class="fa fa-car"></i>Car Registration</a></li>
						<li><a href="cpreserve.asp"><i class="fa fa-car"></i>New Reservation</a></li>
						<li><a href="cpapp.asp"><i class="fa fa-check"></i>Approved Reservation</a></li>
						<li><a href="cprej.asp"><i class="fa fa-times-circle"></i>Rejected Reservation</a></li>				
					<%end if%>
					
                </ul>
            </li>
			<%if sAccess <> "H" and sAccess <> "S" then %>
			<li class="treeview">
                <a href="#">
                    <i class="fa fa-book"></i><span>Report</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="cpreport.asp?type=PR"><i class="fa fa-file-text"></i>Parking</a></li>

                </ul>
            </li>
			<%end if%>
			<%if sAccess = "A" then %>
			<li class="treeview">
                <a href="#">
                    <i class="fa fa-hourglass-2"></i><span>Utilities</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="cpsetup.asp"><i class="fa fa-th"></i>Program Setup</a></li>

                </ul>
            </li>
			<%end if%>
			
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
