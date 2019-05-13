<%
    sSYS = request("sys")
    
%>


<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
    <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="header"><LOGO></LOGO></li>
            <li class="header" style="color:white;font-size:medium"><%=sSYS%></li>   
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-usd"></i><span>Deposit & Withdrawal</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="deposit_info.asp"><i class="fa fa-circle-o"></i>Deposit Ticket</a></li>
                    <li><a href="withdrawal_info.asp"><i class="fa fa-circle-o"></i> Withdrawal Ticket</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-user-o"></i><span>Member Management</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="member_info.asp"><i class="fa fa-circle-o"></i> Member Information</a></li>
                    <li><a href="member_group.asp"><i class="fa fa-circle-o"></i> Member Group</a></li>
                    <li><a href="member_statistics.asp"><i class="fa fa-circle-o"></i> Member Statistics</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> SMSLog</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-user-o"></i><span>Affiliate Management</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="affiliate_info.asp"><i class="fa fa-circle-o"></i> Affiliate Information</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Performance Report</a></li>
                    <li><a href="affiliate_market.asp"><i class="fa fa-circle-o"></i> Marketing Methods</a></li>
                    <li><a href="commission_settings.asp"><i class="fa fa-circle-o"></i> Commission Settings</a></li>
                    <li><a href="commission_calculation.asp"><table><tr><td><i class="fa fa-circle-o"></i></td>
                                    <td style="padding-left:10px"> Commission <br /> Calculation</td></tr>
                                    </table></a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Commission Report</a></li>
                    <li><a href="under_con.asp"><table><tr><td><i class="fa fa-circle-o"></i></td>
                                    <td style="padding-left:10px"> Commission <br /> Withdrawal</td></tr>
                                    </table></a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-wrench"></i><span>Checking Tools</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> IP Analytics</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-file"></i><span>Report</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Bank Transfer</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Bonus</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Bank</a></li>
                    <li><a href="report_member.asp"><i class="fa fa-circle-o"></i> Member Stats</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Adjustment</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Rebate</a></li>
                    <li><a href="under_con.asp"><table><tr><td><i class="fa fa-circle-o"></i></td>
                                    <td style="padding-left:10px">  Reward Customer <br /> Service</td></tr>
                                    </table></a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Win/Loss</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-bank"></i><span>Bank</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="bank_info.asp"><i class="fa fa-circle-o"></i> Bank List</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Accum Reset Log</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                <i class="fa fa-gift"></i><span>Promotion</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="bonus_type_info.asp"><i class="fa fa-circle-o"></i> Bones Type</a></li>
                    <li><a href="bonus_banner.asp"><i class="fa fa-circle-o"></i> Bonus Banner</a></li>
                    <li><a href="bonus_info.asp"><i class="fa fa-circle-o"></i> Bonus</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-money"></i><span>Rebate System</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="rebate_info.asp"><i class="fa fa-circle-o"></i> Rebate Setting</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Rebate</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-address-card"></i><span>User Account</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="active_user.asp"><i class="fa fa-circle-o"></i> Users</a></li>
                    <li><a href="user_role.asp"><i class="fa fa-circle-o"></i> User Role</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> User Action Log</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-desktop"></i><span>System Setting</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="announcements.asp"><i class="fa fa-circle-o"></i> Announcement</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Popup Announcement</a></li>
                    <li><a href="under_con.asp"><i class="fa fa-circle-o"></i> Web Analytics</a></li>
                    <li><a href="game_provider.asp"><i class="fa fa-circle-o"></i> Provider</a></li>
                </ul>
            </li>
            <li>
                <a href="change_password.asp">
                    <i class="fa fa-lock"></i><span>Change Password</span>
                </a>
            </li>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>