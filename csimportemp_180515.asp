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

    
<%#@~^zQYAAA==@#@&djD7+Dc?1.kaYPks+G;DP',q!Z!!ZT@#@&@#@&i/\W[nUE8P{~D;;nkY`Ed!4E#@#@&i@#@&ik6P/tW9n?!4~@!@*PEE,KtU@#@&dd@#@&7dU+DP./O/UnCY4~',/n.7+D /M+CY6(Ln1YvJbGrG$R"+^WMNjnDJ#,~P,@#@&i7d?5S,'~Jdn^+^Y,MP6DGh,m/2CDt~J@#@&id.kY;?nmY4 ra+UPk?}JBPmKUxBP&B~fdiP,P~P~~,P~P,@#@&idrW,xWO~M/OZUKmY4c+K0PDtU@#@&d7d9ZG;aWx,xPM/Y;jKlDtvJ/riK}1E#@#@&di+U[,k0@#@&id^l^s,w/^Wk+Km4^n/vDdY;?KCDt#@#@&@#@&dP,~~k6PkHGNnj!4~',EkswG.DJPP4x@#@&i7@#@&7idU+Y,DkOKt2hw^X~x,/+M-+MRZMnCYr(LnmOcrb9rG$R"+^GMN?nOr#~P,~@#@&~,P,PP,P,~P,/jpdPx~r/+^nmDPe,W.WsPD:n:2sHPE@#@&~P,P~~,PP~~,DdY:\A:2^Xcrwx,d?5SSP1WUUBP&B~&idP,~~P,P,P~P~@#@&P~P,~P,P~~,PkW~	WOPMdDK\A:aVXc+KWPDtnx@#@&~~,PP,~P,PP,@#@&didiNGPA4bVnP	GY,DdO:H2h2^X +KW@#@&7idi@#@&idi7dU+OPM/O/U2:asX,'Pkn.\DcZ.+COr8L^YvJ)9}fA ]mGD9jYE*P,PP@#@&i7didd?5S~x,J/s+1YPC~WDK:,md+h2^X~h4nDPnha{mG[PxPEE,[~M/DKHA:asXvJ3Hh{/6G2J*~[,JBr@#@&didid./O/U2hw^zR}wnU,/?}JBP^W	UBPfBP2dd,P,~P,P~P,P~@#@&ddi7db0PMdOZU2swsX nK0~Y4nx@#@&77idd@#@&id7di7k?}dP{PJbxknDDPrxDW~^k+:asX,`PA\K{;rG2SP/)"fHrB~1zH3S,ZriK}1SPUPzKiU~r@#@&idi7di/jpdPx~k?pd~[,JP`j3I|qG~~f)PAK(HAbPr@#@&7idd77k?}S,x,/j5S,[Pr\msE/~`r@#@&7iddi7/UpS,x~/UpdP'PEvrP'Pa]K&1c.kYK\3swsXvEAHK|Z}f2r#*~[,Jv~r@#@&7iddi7/UpS,x~/UpdP'PEvrP'PMdY:H3haVXcE;b]fg6r#~LPrB~r@#@&7did7dk?}J,'PkjpdP[,EvJ,[,DdYP\A:2VHcJgb\3r#P'~rBSJ@#@&id7idi/?5S,xPk?}S,[~EEJPL~N;WEaGUPLPrBSJ@#@&id7di7/UpJ~{P/j}dP'PrvIBSr@#@&ddidi7/UpJP{Pdj5SPL~JEJPL~d+k/bWU`EiU2]1z\2r#~',JBSE,@#@&di7id7k?5SP{PkjpdP'PrBE~LP09CYYksn+`gWS`b#~',JvJ@#@&did77i/?}J,'~/U}dP',J*PJ@#@&i7did7mKxU 6+1;YP/U}J@#@&did7d7@#@&d7di7+	N~r6@#@&77id@#@&i7id.kY:H2sw^zRsW-+	+aO@#@&di7d^WWa@#@&Pidi+UN~r6@#@&di7mmVs~aZVGdKC4^nk`.kY:H2sw^z#@#@&7d@#@&77xN,r0,@#@&i7^l^V,ls+.O(Wa`r(:aW.O,?E^^/d0!sr#@#@&P,PP,P,~P,P~@#@&dnU9Pk6@#@&i@#@&7JgBAA==^#~@%>
	

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
