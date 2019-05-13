<%@ LANGUAGE = VBScript.Encode %>
<!DOCTYPE html>
<html>

    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

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


	
    <%#@~^QhwAAA==@#@&P~,Pk?E(KH2+,'~j;ldnvD+$;+kY`rOaYUE(KzwnE*#@#@&,~P,@#@&7b0Pdj!4PXan,@!@*,JrPY4+	@#@&,P~P,P~~kqf,xPk?E(PzwP@#@&~P~~Vd+@#@&P,P~~,PPd(GPxP`/m/nvD;sKDscJD6OqGJbb@#@&P,~PxN,rW@#@&P,P~P~~,@#@&P,~PkHG[?E8~{P.+$;/OvJkE4r#@#@&P,P~/U+C.1tP{~D;EdO`rYXYj+C.1tE#@#@&P,P~rhlon~{P]+$;/OvJhloJ*@#@&,P~P,P~~@#@&P,~PkHlbUiIdP{PEmdOHwnRmdwQJ@#@&,PP~dzN[j"J,'~rYXY?lM^t{J~[,/n.7+DcuKtS2	^GN`k?nl.^4#~[,E[hlLn{JP'~bnCo~@#@&~,P,PP,P,~P,@#@&P,P~r6P/tGN?E(~@!@*,JrPPtnU@#@&~P,~P,P7@#@&PP~~,P~dkj!4PHwP',D5sKDh`rYaOUE4:zwJ#@#@&~P,P,P~dd9/^P{~D;oGM:`EOXY9+k^r#@#@&P,PP,P,7/UYCDDPx~M+;wGDs`JDaO?DlMYE#@#@&,P~P,~Pi/3U9P'~.;oWMhvJOXYAxNr#@#@&di/jYmDO+,'PMn;wWDscEYXYUYCDO+r#@#@&,~P,P~~i/2U[yPxPMn$sGM:vJYXYAUNyJb@#@&P~~,PP,7Nz:W!UOP{PM+5sG.s`EYXObsW;UDJ#@#@&,P~P,~,d[hDbWDbYH~',Dn;wW.hvJYXOnMkWMrOXr#@#@&~P~~,P~dkjYmY;d,'P.n$sGDscrm8K?DlY!/rb@#@&d7@#@&d7r6PD50KD:vE^40?4WAJb~{PEW	EP:tnU@#@&d77k?4WS)sY~{Pr5J@#@&i72^/n@#@&d77k?tKAbsYP{~E1r@#@&d72U[,qW@#@&7d@#@&77kZtn^0NO?DCMY~{P&x?DDv~/UYCDD~~E|JP*@#@&id/;4nm0ND2UN~x,qU?D.`,/3U9~PEmrPb@#@&7i//4+13ND?DCDD ~',qUjDD`,d?DlDD+SPr{rPb@#@&7i//t^39Y3U9 Px~&xjYMc,/3	Ny~Pr{r~#@#@&7d@#@&77b0Pk/tm39OjYmDDP@!@*~EZJ~Y4nx@#@&77imlss,ls+MO(WavJUYlMY,qP&x-l^k[~wWDsCYr#@#@&77+	N,kW@#@&7i@#@&dir0,//4m3[OAx[P@!@*,JTrPDt+	@#@&7dimCV^PCsDY(G6vJ2	[~F,q	\CVr[,sGDsCYr#@#@&id+U[,kW@#@&7i@#@&idb0PkZ4nm0NO?Dl.OyP@!@*~JZJPD4nx@#@&id7mCs^PCV.Y(Wacr?YC.DP+P&U7lsbN,sWM:mOJ*@#@&di+U[,k0@#@&di@#@&i7r0,/;tnmV[D2UNy~@!@*PETrPY4n	@#@&di71ls^PmV+MY(G6vJ3x9P+~&x\msk9PsK.hlDJ*@#@&d7n	N~k6@#@&id@#@&idkW~k2UN,@!{PdUYmDY,Y4nx@#@&7dimCs^Pl^nDD4WXcE2	N,F~mCU	WOPkhl^Vn.,YtnU,?OlMO,FE*@#@&ddx9~k6@#@&di@#@&7ik0,d2	N ,@!xPk?Dl.Y+~Dtnx@#@&did^C^VPCsDO4KavJ3	N, P1l	UWDPd:mVsnMPY4nx,?Ym.OPyJ*@#@&d7n	N~k6@#@&@#@&~~,PP7r6PdHK[?;(P{PJ!wr~K4+U@#@&P~~iPP,~P,PPbW~/G+km~'~ErPOtU@#@&d~~,PP~~,P~P,^mVs,l^+DD4Ka`rfn/1Dr2DkW	~mmxxKO~4P:2YzE*@#@&d,~P,P~~,+x[~b07P,~,P~,@#@&dP,P,~P,P@#@&iP~~,PP,~k6P/UOCDDP{PEJ~O4+U@#@&7P,P~~,PP~~,P^l^s,lsDD4WX`rjYmDOP:khn,FP1Cx	WY,8nP:aYzJb@#@&d~P,~P,P~n	NPrW@#@&7P,~,P~,P@#@&d,P,~P,P~k6Pd3	NP{~JrPY4nU@#@&d,P~P~~,P~P,~mmVs~mV+.O(Wa`r3	N~:ks+P8P1Cx	WOP(+~nswYHE#@#@&d,~~P,P,Pnx[~b0~P,~P,@#@&7,PP~~,P~@#@&7,P~,P,PPb0,[bsW;xDPx~rJPD4+	@#@&i~~P,P,P~P~~,mCV^~l^+.O(W6cEz:GE	O,mC	xKYP(+,n:aYzJ*@#@&7,PP,~P,P+	[~k6P,@#@&d~~,P~P,~d,P~~,PP~@#@&d~P,~,P~,?YPM/D/?:X2+,'~dD\.R;D+mOnr(LmO`E)Gr9Ac]+1W.[U+YEb,P~P@#@&,P~,P,PP,P,~/UpJP{PEdV+1OPCP0MGhP1/DX2+~A4+.+,KI&r](:5Px~EJ~[,[hDrKDbYX,[,EB,lUN,n](}Iq:eP@!@*PEv~J@#@&,P~P~~,P~P,~/UpJ~{P/j}dP'PrC	N~Uj~K5h2,@!@*,BEPLPd(9P[,EB,J@#@&~~P,P,P~P~~,DdY;jKHwn }w+U~k?}SB~1WU	~,&~,&@#@&P,P~P,P~~,PPbWP	WY,.dY;?:X2+ nK0~Y4nx@#@&~~,PP~~,P~P,~,P~1l^VPmV.Y(Wa`rn.rKDkDzP#JPL~[nMkKDrYz~LPE=,CVM+C[HPlddboU+9~DW~DXa+P#J,'PM/OZUKz2`JUiA:5nAEbPLPr=~P~Zr#@#@&i7dx[~b0P~@#@&P~P,~,P~,P,Pw;VKd+:l8V/c.kYZUPXa+#@#@&7P,P,P~P~~,P~P,~P,P~~@#@&P~~,P~P,~,P~k?5SP{PrinGbP2,mdOHw+,j2:PJ,~~P,P,P~P~~,P~P,~P,P~~,@#@&~~,P~P,~,P~,/UpS,',d?5S~[,JK)"KP{~BrP[,2]K&1v/9+d^*P'Prv~r@#@&~,PP~~,P~P,~k?}dP{P/Upd~[,JjK&H3~{PBr~[,wI:(H`k?Dl.Yb~LPEBBEP@#@&~~,PP~~,P~P,dUpJ,',/?5S,'Pr2Pqt2~x,BJ,'PaIK&Hc/Ax9#~[~EE~EP@#@&diddj5SPx~k?}S,',Jj:qt2 ,',vJ,[~w"K(Hv/?DCDD #,'~JE~rP@#@&~~,P~P,~P,P~dUpS~x,/jpd~LPEAK&H2yP{~BrP'PaIP(g`/AUNy#PL~EBBJ,@#@&P~~,P~P,~P,Pdj5SPx~k?}S,',J)tr`1K,',vJ,[~wwW.hmY`9):KExDS+#,[,Jv~E@#@&d7dkjpdPx~k?pJ~LPE?_6qb\:P{PBrPL~w"K(1v/j4KhbsO#,[PrvSJidid@#@&~~,P~P,~P,P~dUpS~x,/jpd~LPEhI&rI&KI~',BEPLP2]:q1v[nMkWMrOX*PLPEBSE,P~P,~@#@&P~~,PP~~,P~Pkj5S~{Pk?pdPL~JUK)K`?~x,BJ,'PaIK&Hc/UYmY;/b~LPEBBEP,@#@&~,PP~~,P~P,~k?}dP{P/Upd~[,Ji?AIm(GP',vJ,[Pknd/bW	`Ejj3"1)HAE#,[~EE~J~~,P~P,~@#@&~,P,PP,P,~P,/jpdPx~k?pd~[,JfzP3K&HAPxPvE,[~0GCYYrh `HGS`b#,',Jv,J@#@&P,P,~P,P~P,Pdj5SP{~/UpS,'~JqCAI3Pji~KenA~',BE~LP/([,[~JEE@#@&~,P,PP,P,~P,mGx	RnamEDnPk?pd@#@&P,P,P~P~~,P~@#@&7dimCs^PmGU6k.:~GX`E`w9lYPU;m1+d/6EsZr~Pk\lbxj"J'/zN9j]Sb@#@&P~P,~P,P~~iPP~~,P~P,~i@#@&,P,PP,P,nVk+r0,/\G9+?!8P{PJkC-+rP:tnx@#@&,P~P,~P,@#@&~,PP~~,P~P,~U+O,DkYZUKH2+,'~/D-nMRZMnlD+r(%nmD`rb9r9$cInmK.NU+OE*PP~~@#@&~P,~,P~,P,PPk?5JP{PE/Vn^DPe,WDK:P1dOXa+,h4+.n,?iA:enAPx~EJP'~kq[PL~rBE,@#@&PP,P,~P,P~P,DdO;?KH2+crwU~/Upd~~mGU	~~&B~&@#@&~~,PP~~,P~P,r6PUKY,D/DZUPXa+ +K0~O4+x@#@&P,PP,~~P,P,P~P~~1lsV,CVDO8K6`Ej!4dk9z,Kza+,)PrPL~/&N~[,J~C^D+m[X,+6bdOPeJ*@#@&d77x[PbWP,@#@&~,PP~~,P~P,~aZsK/Kl(Vd`M/OZUKz2#@#@&@#@&iddbW~/&N,'~JE~Dtnx@#@&d,P~~,PP~~,P~mms^PC^+MY4K6vE?!4dk9X~PHw+,^l	xWD~8+,+swOXEb@#@&7P,~P,P~~xN~r6@#@&@#@&7,P~,P,PPb0,df/^P{PEE,YtU@#@&dP,~~P,P,P~P~^mVsPms+MY8GX`J9nkm.kaObWU,mmxxKY,8+,+hwDXEb@#@&d,~P,PP,~nx9Pb07P~~,P~P@#@&d,P~~,PP~@#@&d~P,~,P~,k6P/UYm.Y,'~JrPO4x@#@&7P,PP,~~P,P,P^lss,ls+MO4K6cEUYl.O,Kr:~8P^mx	WY,4~+swOXr#@#@&iPP,~P,PPU[Pb0@#@&7P~~,P~P,@#@&iP~~,PP~~b0~/AU9Px,JrPY4+	@#@&iP~P,P~~,PP,~mmVV,Cs+MY(Wa`E3	N~Kbh+,F~^mxxGO,4nPhaYzr#@#@&d,P,~P,P~+	N~r6PP,~P,@#@&i~~P,P,P~@#@&7,P~P,~P,kW~9b:G;	Y~',ErPO4+	@#@&iP,~P,P~P,P~~1lV^~l^+DD8G6vJz:GEUO,mCx	GY,4n~:wOzr#@#@&i~,P~,P,P+	N,r0,P@#@&iP~~,PP,~@#@&dP,~~P,P,?nY~.kY/?:zwPx~k+D-nMR/DCD+6(LmYvJz9rGA ImG.9?+DE#,PP,@#@&P,P,P~P~~,P~/U}S,'~Ek+Vn^DPMP6.K:~1/DXwPS4+M+~n"q6]&K5,xPEJPL~[nMkKDrYz~LPEB,E@#@&P~~,PP~~,P~Pkj5S~{Pk?pdPL~Jmx[PUj$PIn2,@!@*,BJ,'~/&N,[~Jv~r@#@&P,~P,P~~,PP~.kY/?:za+ }wxPk?5J~,mGx	~~fBP&@#@&P,PP,~~P,P,Pr0~UKY~DkOZUKz2R+GW,Y4+	@#@&P~,P,PP,P,~P,P~PimCs^Pl^nDD4WXcEnMkKDrYz~#J~[,[nMkG.bYX~',J|PmsM+C9X,l/kkTU+9POW,Yz2P=r~[,D/D/jKHw`E?i$:5K2rbPLPE|,PPZE*@#@&di7x[,k6PP@#@&,~P,P~P,P~~,wZ^G/Kl(sn/vDkY/?Pza+bP,@#@&@#@&~~,PP~~,P~P,dUpJ,',Jk	/.Y,kUYKP^dDXw~`UjA:eK2BPhb]KS~UK(HASPAK(\A~PjP&H3 B~AK(t2y~PzH}i1:~~?_r	)tK~,KI&rI&Pe~,?:bPjjS,J@#@&,~P,P~~,PP~~k?}S,x,/j5S,[PrZ"3b:2mqG~~9:{Z"3b:2~,ij2"{&fSP9):2Pqt3#,J@#@&,PP~~,P~P,~,/j5S,'Pk?5JPLPE\mV;nkP`r@#@&idP,~~/UpdPxPdj5S~[,EBrP'~aIK(Hv/(N*~LPEE~rdd,@#@&7d,P~Pk?}J,'PkjpdP[,EvJ,[,w]K(Hv/9+k^#,[~EE~J@#@&id~P,~k?}dP{P/Upd~[,JvJ,[~2"Kqgc/UYlMObPLPrBSJ@#@&id~P,~/UpJ~{P/j}dP'PrvrP',w"Kqg`k3x9#~[,JvSr@#@&i7dk?pd~xPk?5S~[~EEJ~[,2I:qHck?YC.D bPL~rBSr@#@&dd,P,~/UpJP{Pdj5SPL~JEJPL~2I:qg`d2U[y#~[,EBBJ@#@&idP~~,/jpd~{PdUpdP[,JEEPLP2sKDhCD`NzhW!xYB+bPLPrBSJ@#@&id7/U}S,'~dUpS~',JvJ,',w]:qg`/UtKAbsYb[,JvSr@#@&i7P,PPkj}S,',/jpJ~LPEBr~[,w]P&1`[KMkGDbOH#',JE~J@#@&i7P,P~/UpJ~{P/U}S,[PrvEPLPaIPqHck?OlD;/*[~EE~J@#@&id~P,~k?}dP{P/Upd~[,JvJ,[~d//bGxvJjU3]1zHAJbP'~rBSJ,@#@&id~~,P/j}dPxPkj5S~LPrBJ,[,WNmYnYb:n+v1WSc#*P[,Ev~r@#@&d7P~~,/jpd~',/j}dP[~EEJ~[,d/dbW	`J`?A]1zH3J*P'~rB~r~@#@&dd,~~Pk?5S~'~dUpJPL~JEJ~',0NCOYr:+v1GS`*#PLPrvJ@#@&~P,P~~,PP,~Pk?pd~xPk?5S~[~E*PE@#@&~P,P~~,PP~~,B.+k2KxdRSDkD+,d?5S@#@&id~~,PmKUxc+6^;YPk?}S@#@&,P~P,~P,P~~,@#@&77imCV^~1WU6kM:AK6vE?m\nPUE^^//6;VeJ~,d\lbx`IJ[d)9NiIdb@#@&P~~,PP~~,P~P,~,P~@#@&idPx9~k6@#@&P,P~3	NP&W@#@&PP,~~P,P,P@#@&~~,Pj+D~DkY/j:Xwn~{Pd+M-D ;DlYr(%+1YcJzf69~RI^WMN?OE#,P,P@#@&~~,Pd?5JP{PEdV+^O,e~0MGsP^kYHw+,h4nDPjj~KeKA'Br~[,/q9~'PrBrP@#@&~~,P./D/?:X2ncrwnU,/jpdS,mG	xBP&BP2@#@&,P~Pb0~UKYPMdY;?KH2nRW6POtnU@#@&~P,~P,P~dUE4Pza+~',.kY/UKHw+vJUiA:5K2r#@#@&,PP,~P,P/Gndm,',DdY/j:X2+vEnzIPE*PP~~,P~P,~,P@#@&P,PP,P,~/UYCDDPx~M/Y;jKHw+vEjK&HAJb@#@&~,P~P,~Pk2U[,'P.dDZjKH2`EAK&H2r#@#@&di/jYmDO+,'PMdY;?KH2n`r?:q\2+E*@#@&P,~P,P~~k2x[+,'~DkO;?PHw`JAK&\2yJb@#@&P~~,PP,~Nz:W!UOP{PM/OZjPHwn`r)H}jHPr#@#@&7i/jtKAz:O,',D/DZUPXa+cJUC6	zHKrb@#@&PP,~~P,P9n.kG.bYzP{~DkY/j:Xwncrn]q}]&Ker#@#@&P,P,~P,Pd?DlO;kP',./DZ?:z2+vJUK)Kijr#@#@&i7@#@&P~~,+x[~b0@#@&,~,P^mV^Pw;VKd+:l8V/c.kYZUPXa+#@#@&~P,P@#@&~P~~,@#@&P,~P/KwGAA==^#~@%>
 
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Subsidy Type Details</h1>
            </section>
            <!-- Main content -->      
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        	<!-- form start -->
                        	<form class="form-horizontal" action="cstype_det.asp" method="post">
                            <input type="hidden" id="txtSearch" name="txtSearch" value='<%=#@~^BwAAAA==dU+CMm4yQIAAA==^#~@%>' />
                            <input type="hidden" name="Page" value='<%=#@~^BQAAAA==rhlL5gEAAA==^#~@%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=#@~^CAAAAA==dtlr	j"S6wIAAA==^#~@%><%=#@~^BwAAAA==dzN[`IdbwIAAA==^#~@%>');" />
                                </div>
                                <!-- /.box-header -->
                               <div class="box-body">
                                
									<!-- Subsidy Type -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Subsidy Type : </label>
										<div class="col-sm-3">
											<%#@~^GQAAAA==r6PdUE(KXa+,@!@*,JEPDtnU,GwcAAA==^#~@%>
												<span class="mod-form-control"><%#@~^GQAAAA==~M+daW	/+chMrYPd?!4Pza+PZwkAAA==^#~@%></span>
												<input type="hidden" id="txtID" name="txtID" value="<%=#@~^AwAAAA==d&fAAEAAA==^#~@%>" />
                                            <%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
                                           		<input class="form-control" id="txtID" name="txtID" value="<%=#@~^AwAAAA==d&fAAEAAA==^#~@%>" maxlength="10" style="text-transform: uppercase" input-check />
                                            <%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
										</div>
									</div>
                                
                                	<!-- Description -->
									<div class="form-group">
										<label class="col-sm-3 control-label">Description : </label>
										<div class="col-sm-6">
											<input class="form-control" id="txtDesc" name="txtDesc" value="<%=#@~^GAAAAA==dD-DctYsVUmKNn`kfnd1#KwkAAA==^#~@%>" maxlength="30" input-check />
										</div>
									</div>
                                    
                                    <!-- Period 1 -->                                   
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Start 1 : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtStart" name="txtStart" value='<%=#@~^BgAAAA==dUYCMYgQIAAA==^#~@%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
										
										<label class="col-sm-1 control-label">End 1 : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtEnd" name="txtEnd" value='<%=#@~^BAAAAA==dAx[igEAAA==^#~@%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Period 2 --> 
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Start 2 : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtStart2" name="txtStart2" value='<%=#@~^BwAAAA==dUYCMYyswIAAA==^#~@%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
										
										<label class="col-sm-1 control-label">End 2 : </label>
                                        <div class="col-sm-2">
                                            <div class="input-group">
                                                 <input id="txtEnd2" name="txtEnd2" value='<%=#@~^BQAAAA==dAx[yvAEAAA==^#~@%>' type="text" class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask>
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
									
									<!-- Amount -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Subsidy Amount (RM) : </label>
                                        <div class="col-sm-2" >
                                            <input  class="form-control" id="txtAmount" name="txtAmount" value="<%=#@~^KAAAAA==dD-DctYsVUmKNn`asG.slYGnmvNbsG;xD~y#bpQ4AAA==^#~@%>" maxlength="10" placeholder="RM" onkeypress='return isNumberKey(event)' style="text-align:right;" >    	
											
										</div>
										<div class="control-label" >
											<div class="col-sm-2">
												<input type="checkbox" id="cbkShow" name="cbkShow" <%#@~^FAAAAA==r6PdUtKhbsY{E5rPOtxzgYAAA==^#~@%>checked<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>/>&nbsp;Show Amount
											</div>
										</div>	
                                    </div>
									
									<!-- Priority -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Priority : </label>
                                        <div class="col-sm-2" >
                                            <input  class="form-control" id="txtPriority" name="txtPriority" value="<%=#@~^CQAAAA==[hDrKDbYXxgMAAA==^#~@%>" maxlength="2" onkeypress='return isNumberKey(event)' style="text-align:right;" >    	
                                        </div>
                                    </div>

                                                       
                                    <!-- Status -->
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Status : </label>
                                        <div class="col-sm-2" >
                                            <select id="cboStatus" name="cboStatus" class="form-control">
                                                <option value="A" <%#@~^FQAAAA==r6PdUYmYEkP{~JzJ~Y4+UtwYAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Active</option>
                                                <option value="I" <%#@~^FQAAAA==r6PdUYmYEkP{~J&J~Y4+UvwYAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                              </div>

									<!-- Footer Button -->
	                                <div class="box-footer">
	                                    <%#@~^GQAAAA==r6PdUE(KXa+,@!@*,JEPDtnU,GwcAAA==^#~@%>
		                                    <a href="#" onclick="fOpen('DEL','','mycontent','#mymodal')" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
		                                    <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
	                                    <%#@~^BQAAAA==n^/n,yQEAAA==^#~@%>
	                                    	<button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
	                                    <%#@~^BwAAAA==n	N~b0,RgIAAA==^#~@%>
	                                </div>
                                <!-- /.box-footer -->
									 
                                <!-- /.box -->
		                    </div>
		            
						    
					 		 </form>
						 	 <!-- form end -->
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
    
     <!--mymodal start-->   
    <div class="modal fade bd-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel"></h4>
                </div>
                <div class="modal-body">
                    <div id="mycontent">
                        <!---mymodal content ---->
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!--mymodal end-->
	
	<!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
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
    </script>
     
    <!--open modal-->
	<script>
    function fOpen(pType,pfldName,pContent,pModal) {

		showDetails('txtSubType=<%=#@~^CAAAAA==dUE8:Xa+PwMAAA==^#~@%>',pfldName,pType,pContent)
		$(pModal).modal('show');
	}
	    
    function showDetails(str,pfldName,pType,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };
		
		xhttp.open("GET", "cstype_del.asp?"+str, true);
	  		  	
  	    xhttp.send();
    }
	</script>
	
	<!--check numeric-->
    <script>
	 function isNumberKey(evt) {
     var charCode = (evt.which) ? evt.which : evt.keyCode;
     if (charCode != 46 && charCode > 31 
       && (charCode < 48 || charCode > 57))
        return false;
  
      return true;
 	}
 	</script>
 	
 	<script>
    $(function () {

        //Time mask
        $("[data-mask]").inputmask();
    
    });
    </script>
	<!--Script End-->
	<!--Script End-->
	

</body>
</html>
