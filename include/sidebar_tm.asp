<!-- Font Awesome Free more icons for those using fas -->
<link href="font_awesome/fontawesome-free-5.8.1-web/css/all.css" rel="stylesheet" />

<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="treeview"><a href="tmdash.asp"><span>TIME MANAGEMENT</span></a>
            </li>
             <!--<li style="background-color:black">
                <a href="tmdash.asp">TIME MANAGEMENT</a>
            </li>-->
            <% if Session("TMFM") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cog"></i><span>Maintenance</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <% if Session("TMFM1") = "Y" then %>
                        <li><a href="tmemply.asp"><i class="fas fa-user"></i>&ensp;Employee</a></li>
                    <% end if%>
                    <% if Session("TMFM2") = "Y" then %>
                        <li><a href="tmworkgrp.asp"><i class="fa fa-users"></i>Work Group</a></li>
                    <%end if%>
                    <% if Session("TMFM3") = "Y" then %>
                        <li><a href="tmholiday.asp"><i class="fa fa-gift"></i>Holiday Dates</a></li>
                    <% end if%>
                    <% if Session("TMFM4") = "Y" then %>
                        <li><a href="tmholcal.asp"><i class="fa fa-calendar-o"></i>Holiday Group</a></li>
                    <% end if%>
                    <% if Session("TMFM5") = "Y" then %>
                        <li><a href="tmdept.asp"><i class="fa fa-building"></i>Department</a></li>
                    <% end if%>
                    <% if Session("TMFM6") = "Y" then %>
                        <li><a href="tmgrade.asp"><i class="fa fa-id-badge"></i>Grade</a></li>
                    <%end if%>
                    <% if Session("TMFM7") = "Y" then %>
                        <li><a href="tmcont.asp"><i class="fa fa-clone"></i>Contract</a></li>
                    <%end if%>
                    <% if Session("TMFM8") = "Y" then %>
                        <li><a href="tmwork.asp"><i class="fa fa-map-marker"></i>Work Location</a></li>
                    <%end if%>
                    <% if Session("TMFM9") = "Y" then %>
                        <li><a href="tmcost.asp"><i class="fa fa-industry"></i>Cost Center</a></li>
                    <% end if%>
                    <% if Session("TMFM10") = "Y" then %>
                        <li><a href="tmtimeoff.asp"><i class="fa fa-file-code-o"></i>Time Off</a></li>
                    <% end if%>
                    <% if Session("TMFM11") = "Y" then %>
                        <li><a href="tmotcode.asp"><i class="fa fa-clock-o"></i>OT Code</a></li>
                    <% end if%>
                    <% if Session("TMFM12") = "Y" then %>
                        <li><a href="tmallow.asp"><i class="fa fa-money"></i>Allowance</a></li>
                    <% end if%>
                    <% if Session("TMFM13") = "Y" then %>
                        <li><a href="tmrelig.asp"><i class="fas fa-church"></i>&ensp;Religion</a></li>
                    <% end if%>
                    <% if Session("TMFM14") = "Y" then %>
                        <li><a href="tmnation.asp"><i class="fas fa-globe-asia"></i>&ensp;Nationality</a></li>
                    <% end if%>
                    <% if Session("TMFM15") = "Y" then %>
                        <li><a href="tmlog.asp"><i class="fas fa-file-archive"></i>&ensp;Log</a></li>
                    <% end if%>
                </ul>
            </li>
            <%end if%>
            <% if Session("TMSH") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-tasks"></i><span>Shift</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <% if Session("TMSH1") = "Y" then %>
                        <li><a href="tmshiftot.asp"><i class="fa fa-calendar-check-o"></i>Shift Schedule</a></li>
                    <%end if%>
                    <% if Session("TMSH2") = "Y" then %>
                        <li><a href="tmshfcode.asp"><i class="fa fa-list-ol"></i>Shift Code</a></li>
                    <%end if%>
                    <% if Session("TMSH3") = "Y" then %>
                        <li><a href="tmshfpat.asp"><i class="fa fa-bars"></i>Shift Pattern</a></li>
                    <%end if%>
                    <% if Session("TMSH4") = "Y" then %>
                        <li><a href="tmshfplan.asp"><i class="fa fa-check"></i>Shift Plan</a></li>
                    <%end if%>
                </ul>
            </li>
            <%end if%>
            <% if Session("TMTE") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fas fa-exchange-alt"></i><span>&ensp;Transaction</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <% if Session("TMTE1") = "Y" then %>
                        <li><a href="tmtimeclk.asp"><i class="fa fa-clock-o"></i>Time Clock</a></li>
                    <%end if%>
                    <% if Session("TMTE2") = "Y" then %>
                        <li><a href="tmabnorm.asp"><i class="fa fa-pencil-square-o"></i>Abnormal Attendance</a></li>
                    <%end if%>
                    <% if Session("TMTE3") = "Y" then %>
                        <li><a href="tmot.asp"><i class="fa fa-calendar-plus-o"></i>Overtime Pending</a></li>
                    <%end if%>
                    <% if Session("TMTE4") = "Y" then %>
                       <li><a href="tmeoff.asp"><i class="fa fa-power-off"></i>Employee Time Off</a></li>
                    <%end if%>
                </ul>
            </li>
            <%end if%>
            <% if Session("TMPC") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-desktop"></i><span>Processing</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <% if Session("TMPC1") = "Y" then %>
                        <li><a href="tmgenshf.asp"><i class="fa fa-th"></i>Generate Schedule</a></li>
                    <%end if%>
                    <% if Session("TMPC2") = "Y" then %>
                        <li><a href="tmchgwrkgrp.asp"><i class="fa fa-mars-double"></i>Change Work Group</a></li>
                    <%end if%>
                    <% if Session("TMPC3") = "Y" then %>
                        <li><a href="tmdelsch.asp"><i class="fa fa-calendar-minus-o"></i>Delete Schedule</a></li>
                    <%end if%>
                    <% if Session("TMPC4") = "Y" then %>
                        <li><a href="tmmidmth.asp"><i class="far fa-calendar"></i>&ensp;Mid Month Process</a></li>
                    <%end if%>
                    <% if Session("TMPC5") = "Y" then %>
                        <li><a href="tmmthend.asp"><i class="fab fa-ravelry"></i>&ensp;Month End Process</a></li>
                    <%end if%>
                    <% if Session("TMPC6") = "Y" then %>
                        <li><a href="tm_manualprocess.asp"><i class="fas fa-file-upload"></i>&ensp;Re-Insert Records</a></li>
                    <%end if%>
                    <% if Session("TMPC7") = "Y" then %>
                        <li><a href="tm_reprocess.asp"><i class="fa fa-refresh"></i>Reprocess</a></li>
                    <%end if%>
                </ul>
            </li>
            <%end if%>
            <% if Session("TMPR") = "Y" then %>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-book"></i><span>Report</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                        
                        <% if Session("TMPR1") = "Y" then %>
                    	    <li><a href="tmreport.asp?type=DA"><i class="far fa-file-alt"></i>&ensp;Daily Attendance</a></li>
                        <% end if%>
                        <% if Session("TMPR2") = "Y" then %>
                            <li><a href="tmreport.asp?type=ABNORM"><i class="far fa-file-alt"></i>&ensp;Abnormal Attendance </a></li>
                        <% end if%>
                    	<% if Session("TMPR3") = "Y" then %>
                            <li><a href="tmreport.asp?type=OT"><i class="far fa-file-alt"></i>&ensp;Overtime Transaction </a></li>
                        <% end if%>
                        <% if Session("TMPR4") = "Y" then %>
                            <li><a href="tmreport.asp?type=LED"><i class="far fa-file-alt"></i>&ensp;Late And Early Dismiss </a></li>
                        <% end if%>
                        <% if Session("TMPR5") = "Y" then %>
                            <li><a href="tmreport.asp?type=AWL"><i class="far fa-file-alt"></i>&ensp;Absence Without Leave</a></li>
                        <% end if%>
                        <% if Session("TMPR6") = "Y" then %>
                            <li><a href="tmreport.asp?type=ACD"><i class="far fa-file-alt"></i>&ensp;Absence For 3 Consecutive Days</a></li>
                        <% end if%>
                        <% if Session("TMPR7") = "Y" then %>
                            <li><a href="tmreport.asp?type=DL"><i class="far fa-file-alt"></i>&ensp;DL Mid Month Advance</a></li>
                        <% end if%>
                        <% if Session("TMPR8") = "Y" then %>
                            <li><a href="tmreport.asp?type=OTX"><i class="far fa-file-alt"></i>&ensp;Overtime Hour Exceeded Limit</a></li>
                        <% end if%>
                        <% if Session("TMPR9") = "Y" then %>
                            <li><a href="tmreport.asp?type=LWA"><i class="far fa-file-alt"></i>&ensp;Leave With Attendance</a></li>
                        <% end if%>
                        <% if Session("TMPR10") = "Y" then %>
                            <li><a href="tmreport.asp?type=ALLOW"><i class="far fa-file-alt"></i>&ensp;Allowance</a></li>
                        <% end if%>
                    </ul>
            </li>
            <%end if%>
            <% if Session("TMUTL") = "Y" then %>
            <li class="treeview">
                <a href="tmpath.asp">
                    <i class="fa fa-gears"></i><span>Program Setup</span>
                </a>
            </li>
            <%end if%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
