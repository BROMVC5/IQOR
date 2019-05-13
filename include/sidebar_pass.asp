<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
    <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <!--<li class="header"><LOGO></LOGO></li>-->
            <li class="treeview">
                <a href="broprofile.asp">
                    <i class="fa fa-user"></i><span>View Profile</span>
                </a>
            </li>
            <% if Session("TMUTL") = "Y" then %>
                <li class="treeview">
                    <a href="bropass.asp">
                        <i class="fa fa-gears"></i><span>Password</span>
                    </a>
                </li>
                <li class="treeview">
                    <a href="bropath.asp">
                        <i class="fa fa-envelope"></i><span>Program Setup</span>
                    </a>
               </li>
           <%end if%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>