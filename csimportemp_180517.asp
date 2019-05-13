<%@ LANGUAGE = VBScript.Encode %>
<!DOCTYPE html>
<html>

    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>IQOR</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Bootstrap 3.3.6 CSS -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="dist/css/dataTables.bootstrap.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
        folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI CSS -->
    <link href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">

    
<%#@~^vwkAAA==@#@&djD7+Dc?1.kaYPks+G;DP',q!Z!!ZT@#@&@#@&i/\W[nUE8P{~D;;nkY`Ed!4E#@#@&i@#@&ik6P/tW9n?!4~@!@*PEE,KtU@#@&dd@#@&7dU+DP./O/UnCY4~',/n.7+D /M+CY6(Ln1YvJbGrG$R"+^WMNjnDJ#,~P,@#@&i7d?5S,'~Jdn^+^Y,MP6DGh,m/2CDt~J@#@&id.kY;?nmY4 ra+UPk?}JBPmKUxBP&B~fdiP,P~P~~,P~P,@#@&idrW,xWO~M/OZUKmY4c+K0PDtU@#@&d7d9ZG;aWx,xPM/Y;jKlDtvJ/riK}1E#@#@&di+U[,k0@#@&id^l^s,w/^Wk+Km4^n/vDdY;?KCDt#@#@&@#@&dP,~~k6PkHGNnj!4~',EkswG.DJPP4x@#@&i7@#@&7idU+Y,DkOKt2hw^X~x,/+M-+MRZMnCYr(LnmOcrb9rG$R"+^GMN?nOr#~P,~@#@&~,P,PP,P,~P,/jpdPx~r/+^nmDPe,W.WsPD:n:2sHPE@#@&7di/j}dP'~dUpJPL~rPA4+M+PGK|]2Uq!1,kd~	EV^E@#@&PP,~~P,P,P~P.dDK\2s2VHR62xPdj5SSP1G	xS,&BP&id,~P,P~P,P~~,@#@&,~P,PP,~~P,Pb0~xGO,DdY:\2swszc+WW~Dtnx@#@&,P~,P,PP,P,~@#@&d7diNG~Stk^nP	WY,.dY:HA:2Vz WW@#@&7did@#@&idd77U+OPMdDZjA:aVX,',d+M\nDcZ.nmY+}8LmYvE)f}f~R]+^GMNj+DE#,P~~@#@&d77idd?5J,'~r/V+1Y,MP6DG:,mdnswVH~h4+D~n:a{1W[+~x,BEPL~DkYP\A:wszvJ3Hhm;r9AJ*P[,JEE@#@&d7did.dDZ?Ahw^XR}2nx,/UpJ~~^KxU~,f~,&77,PP~~,P~P,~,@#@&ididdb0,UWDP./DZj3swVH +K0PD4nx@#@&id7d7@#@&d7di7dk?}J,'PEihf)KA~1/nsw^XPU2:~J,P~P,P~~,PP,~P,PP,~~P,d,@#@&d77id7/U}S,'~dUpS~',J/b"9gr~{PEJPLPa]K&1cDkYP\A:w^z`rZb"9Hrr#*P'PEvBJ@#@&i7did7dUpS~x,/jpd~LPEgbt2P{PEEPLP2I:qHc6NlDn vNYGCO+*#,[~JvSr@#@&di7diddj5SPx~k?}S,',J/}jhr1,',vJ,[~N;W;2KxPL~JE~J@#@&7dididd?}J,'~/U}S,[~EUKbPiUPxPEeE~E@#@&iddidid?5S~',/j}dP[,EZ"2b:3mqGP{PvJ~',/n/krW	`EiU2IH)t2E#,',JvBJ@#@&didi7dk?}S,'~dUpS,'PrfK|/]2zKAPxPvE,[~09CYYrh `HGS`b#,',JvBJ@#@&didi7dk?}S,'~dUpS,'Prj?A]mqGP{PvJ~',/n/krW	`EiU2IH)t2E#,',JvBJ@#@&didi7dk?}S,'~dUpS,'Prfb:3Pqt2,'~BE~LPWNmO+Dkhny`1GAv#bPL~rBE@#@&iddidid?5S~',/j}dP[,E_2IA~3Hh{;r92~x,BEPL~DkYP\A:wszvJ3Hhm;r9AJ*P[,JEE@#@&d7did7^Kxxcn6mEDn~/Upd@#@&d77id@#@&i7didnsk+@#@&7id7d@#@&id7idi/?5S,xPrkU/DO~bxYK~mk+:aszPvPAHK{/6G2SP;)IG16S,1b\3BP/r`K}1S,?:bK`?BE@#@&d7did7dUpS,xPk?pd~'PrP`?3Im(G~~fzP2:q\3*PJ@#@&id7di7k?}dP{P/Upd~[,J-l^End,`J@#@&diddi7d?5S,'~/j}dP'PrvJ,[~2"KqHcM/OKt3swsH`r2Hh{;6fAJb#,[~EE~J@#@&diddi7d?5S,'~/j}dP'PrvJ,[~2"KqHcM/OKt3swsH`rZb"fg6J*#~[,JvSr@#@&i7diddkj}S,',/jpJ~LPEBr~[,w]P&1`.dDK\2s2^Xcr1zH2r#*~[,Jv~r@#@&7iddi7/UpS,x~/UpdP'PEvrP'P9/W!wGU,[PEvBJ@#@&i7id7i/UpS,',d?5S~[,JveE~J@#@&diddi7d?5S,'~/j}dP'PrvJ,[~d//rG	`EjU3"1)t2r#PLPrv~rP@#@&id77id/U}S,'Pkj}S,[,JvJ~',0[lDnYb:n+v1WAc*#~[,EEJ@#@&diddidkjpdPxPk?}J,[PrbPr@#@&i77did1WUx nX+^EDnPk?}J@#@&d77id7@#@&7id7i+	NPb0@#@&did7@#@&d77iD/DPHA:w^z :K\xn6O@#@&d7disWKw@#@&,dd7n	N~k6@#@&d7immVV,w;sWk+Pl(VndvD/DPHA:w^zb@#@&di@#@&d7n	N~k6~@#@&d7^mVV~C^+.Y(GX`E&:aWDDPU;m1+d/6EsE*@#@&,~P,PP,~~P,P@#@&7+U[,kW@#@&7@#@&vzoCAA==^#~@%>
	

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Import Employee from TMS</h1>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="csimportemp.asp" method="post">
                            <div class="box box-info">   
	                            
     						   <!--body start-->
                               <div class="box-body">

	                              <div class="form-group">
	                                <label class="col-sm-3 control-label">Import Employee : </label>
	                                <div class="col-sm-2">
										<button type="submit" name="sub" value="import" class="btn btn-primary" style="width: 90px">Import</button>  
	                                </div>
	                              </div>
								  <div class="form-group">
										<label class="col-sm-9 control-label"><font color ="red">* Import employee from TMS to canteen system if the employee does not exist in canteen system</font></label>
	                              </div>
                                	
							   </div>
							   <!-- /.body end -->  
						   	</div>
							  <!-- /.box info end -->
					 		</form>
						 	 <!-- /.form end -->
		            </div>
		            <!-- /.col -->  
           		</div>
           		<!-- /.row -->  

			 </section>
            <!-- /.content -->
            
     	
        </div>
        <!-- /.content-wrapper -->
        <!-- #include file="include/footer.asp" -->
    </div>   		
    <!-- ./wrapper -->
    
   
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
     <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>

    <!--Script Start-->
    
    <!--check numeric-->
    <script>
	 function isNumberKey(evt) {
     var charCode = (evt.which) ? evt.which : evt.keyCode;
     if (charCode != 46 && charCode > 31 
       && (charCode < 48 || charCode > 57))
        return false;
  
      return true;
 	} 
 	
 	$(document).ready(function() {
		$("#txtCoupon").keydown(function (e) {
			// Allow: backspace, delete, tab, escape, enter and .
			if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
				 // Allow: Ctrl+A, Command+A
				(e.keyCode === 65 && (e.ctrlKey === true || e.metaKey === true)) || 
				 // Allow: home, end, left, right, down, up
				(e.keyCode >= 35 && e.keyCode <= 40)) {
					 // let it happen, don't do anything
					 return;
			}
			// Ensure that it is a number and stop the keypress
			if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
				e.preventDefault();
			}
		});
	});
	
	$('#txtCoupon').keyup(function () {
		if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
       this.value = this.value.replace(/[^0-9\.]/g, '');
		}
	});

    </script>
  		
	<script>
    $(function () {

        //Time mask
        $("[data-mask]").inputmask();
    
    });

    
    </script>

	<!--Script End-->
	

</body>
</html>
