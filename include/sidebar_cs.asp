<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
    <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <!--<li class="header"><LOGO></LOGO></li>-->
           <li style="background-color:black">
                  <a href="csdash.asp"><span>CANTEEN MANAGEMENT</span></a>
           </li> 
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cog"></i><span>Maintenance</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                    	<li><a href="cstype.asp"><i class="fa fa-user-o"></i>Type</a></li>
                        <li><a href="csemply.asp"><i class="fa fa-user-o"></i>Employee</a></li>
                    </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-desktop"></i><span>Transaction</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                        <li><a href="cspos.asp"><i class="fa fa-cutlery"></i>Point Of Sales</a></li>
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
                    	<li><a href="csreport.asp?type=SD"><i class="fa fa-file-o"></i>Summary By Date</a></li>
                        <li><a href="csreport.asp?type=ES"><i class="fa fa-file-o"></i>Employee Summary</a></li>
                        <li><a href="csreport.asp?type=ED"><i class="fa fa-file-o"></i>Employee Details</a></li>
						<li><a href="csreport.asp?type=EMT"><i class="fa fa-file-o"></i>Employee Transaction</a></li>
						<li><a href="csreport.asp?type=ET"><i class="fa fa-file-o"></i>Subsidy Entitlement Detail</a></li>
						<li><a href="csreport.asp?type=SS"><i class="fa fa-file-o"></i>Subsidy Entitlement Summary</a></li>  
                    </ul>
            </li>   
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-gear"></i><span>Processing</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                        <li><a href="csimport.asp"><i class="fa fa-clone"></i>Generate Subsidy</a></li>
						<li><a href="csimportemp.asp"><i class="fa fa-clone"></i>Import Employee From TMS</a></li>
						<li><a href="csupload.asp"><i class="fa fa-clone"></i>Upload CSV Subsidy</a></li>
                    </ul>
            </li>   
             <li class="treeview">
                <a href="#">
                    <i class="fa  fa-hourglass-2"></i><span>Utilities</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                    <ul class="treeview-menu">
                        <li><a href="cssetup.asp"><i class="fa fa-th"></i>Program Setup</a></li>
                    </ul>
            </li>            
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>