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


	
    <%#@~^fxwAAA==@#@&P~,Pk?E(KH2+,'~j;ldnvD+$;+kY`rOaYUE(KzwnE*#@#@&,~P,@#@&7b0Pdj!4PXan,@!@*,JrPY4+	@#@&,P~P,P~~kqf,xPk?E(PzwP@#@&~P~~Vd+@#@&P,P~~,PPd(GPxP`/m/nvD;sKDscJD6OqGJbb@#@&P,~PxN,rW@#@&P,P~P~~,@#@&P,~PkHG[?E8~{P.+$;/OvJkE4r#@#@&P,P~/U+C.1tP{~D;EdO`rYXYj+C.1tE#@#@&P,P~rhlon~{P]+$;/OvJhloJ*@#@&,P~P,P~~@#@&P,~PkHlbUiIdP{PEmdOHwnRmdwQJ@#@&,PP~dzN[j"J,'~rYXY?lM^t{J~[,/n.7+DcuKtS2	^GN`k?nl.^4#~[,E[hlLn{JP'~bnCo~@#@&~,P,PP,P,~P,@#@&P,P~r6P/tGN?E(~@!@*,JrPPtnU@#@&~P,~P,P7@#@&PP~~,P~dkj!4PHwP',D5sKDh`rYaOUE4:zwJ#@#@&~P,P,P~dd9/^P{~D;oGM:`EOXY9+k^r#@#@&P,PP,P,7/UYCDDPx~M+;wGDs`JDaO?DlMYE#@#@&,P~P,~Pi/3U9P'~.;oWMhvJOXYAxNr#@#@&di/jYmDO+,'PMn;wWDscEYXYUYCDO+r#@#@&,~P,P~~i/2U[yPxPMn$sGM:vJYXYAUNyJb@#@&P~~,PP,7Nz:W!UOP{PM+5sG.s`EYXObsW;UDJ#@#@&,P~P,~,d[hDbWDbYH~',Dn;wW.hvJYXOnMkWMrOXr#@#@&~P~~,P~dkjYmY;d,'P.n$sGDscrm8K?DlY!/rb@#@&d7@#@&d7r6PD50KD:vE^40?4WAJb~{PEW	EP:tnU@#@&d77k?4WS)sY~{Pr5J@#@&i72^/n@#@&d77k?tKAbsYP{~E1r@#@&d72U[,qW@#@&7d@#@&77kZtn^0NO?DCMY~{P&x?DDv~/UYCDD~~E|JP*@#@&id/;4nm0ND2UN~x,qU?D.`,/3U9~PEmrPb@#@&7i//4+13ND?DCDD ~',qUjDD`,d?DlDD+SPr{rPb@#@&7i//t^39Y3U9 Px~&xjYMc,/3	Ny~Pr{r~#@#@&7d@#@&77b0Pk/tm39OjYmDDP@!@*~EZJ~Y4nx@#@&77imlss,ls+MO(WavJUYlMY,qP&x-l^k[~wWDsCYr#@#@&77+	N,kW@#@&7i@#@&dir0,//4m3[OAx[P@!@*,JTrPDt+	@#@&7dimCV^PCsDY(G6vJ2	[~F,q	\CVr[,sGDsCYr#@#@&id+U[,kW@#@&7i@#@&idb0PkZ4nm0NO?Dl.OyP@!@*~JZJPD4nx@#@&id7mCs^PCV.Y(Wacr?YC.DP+P&U7lsbN,sWM:mOJ*@#@&di+U[,k0@#@&di@#@&i7r0,/;tnmV[D2UNy~@!@*PETrPY4n	@#@&di71ls^PmV+MY(G6vJ3x9P+~&x\msk9PsK.hlDJ*@#@&d7n	N~k6@#@&id@#@&idkW~k2UN,@!{PdUYmDY,Y4nx@#@&7dimCs^Pl^nDD4WXcE2	N,F~mCU	WOPkhl^Vn.,YtnU,?OlMO,FE*@#@&ddx9~k6@#@&di@#@&7ik0,d2	N ,@!@*PrJ,W.PdjDl.Yy~@!@*PEE,YtnU@#@&7dir6PdAx9 P@!',d?Dl.YyPO4x@#@&7didmmssPmVDO4GavJ3x9~ ,mCU	WY~dslsV.,Y4x,?YmDD~ r#@#@&id7n	NPbW@#@&ddU[Pb0@#@&@#@&~~,P~dbWPkHG[?E8~{PEEaE,K4x@#@&P,Pi~P,P~P,PrW,/fdm,'PrE~Y4+	@#@&d~~,P~P,~P,P~^mVV~C^+.Y(GX`EG+kmDbwDrW	P^l	xGO,4+,n:aYXrb@#@&iP,P~P~~,+UN,r0iP~~,PP~@#@&d~P,~,P~,@#@&dP,P,~P,Pr0,/jOmDY,xPrJPD4nx@#@&iP~P~~,P~P,~P1lss,lVn.D4G6vEUYCMY,Kks+,qP1lUxKY~8P+s2YHJ#@#@&7P,P,P~P~n	N~k6@#@&iP~~,PP~~@#@&7P,~,P~,Pb0Pk2	[P{PEJ,Y4n	@#@&i~P,PP,~~P,P,mCVs~mVnDD8WX`E3	NPPrs+~F,^mxUKY,4+,+s2YHJb@#@&d~~,PP,~PxN,rWP,P,P~@#@&7,P~P,~P,@#@&7,PP~~,P~k6~9bhKE	YP{PrEPDtnx@#@&7~,PP,~P,PP,~^l^V,ls+.O(Wa`r):KEUO,mlUUKY~4~:2DXr#@#@&d,~P,P~P,+U[,k0,~@#@&dP,~~P,P,d~P~~,P~P@#@&d,P~~,PP~jY~DkO;?PHwP',/.\D ZM+COr4NnmD`Jz96f~R"+^W.[U+OJ*~P,P@#@&,PP~~,P~P,~,/j5S,'Pr/s+1Y~e,0.GsPmkOXa+PS4nDPhI(r](:5~',vJ,[~[hDkG.bYzPL~rB~mx9Pn"q}]q:5~@!@*Pvv,J@#@&~P,PP,~~P,P,/jpJ~{Pd?5JPLPEC	NPji~KenA~@!@*~EJ,[Pkq9~[,JvPr@#@&~,PP,~P,PP,~./DZUKzwn }wnx,d?5SS~1WxUS,&SP2@#@&P~,P,PP,P,~Pb0~xKY~.kYZUPXa+RGWPDtx@#@&~~,P~P,~P,P~~,PP^C^V~l^nMY8K6vJnMkK.kDX~=rP'~9nDbGDbYX,'~J#PmV.+C[HPC/kro	+[~DWPOza+~=r~LP.kY;?KHwcJUj$KIn3E*P[,E=,PPeEb@#@&didnx[~b0~P@#@&P,P~~,PP~~,P2Z^Gk+Pm4^+/vDkOZUKzw#@#@&iPP,~P,PP,~~P,P,P~P~~@#@&~P,~P,P~~,PPdj5S~',E`n9zKAPmkYH2+,?3K,J~~,PP,~P,PP,~~P,P,P~P~~,@#@&P,~P,P~~,PP~dUpJP{~k?}dPLPJhb"PP{PvJ,[~2"Kqgc/G+/1b~[,JE~E@#@&~,P~P,~P,P~~k?pJ~{Pd?5J,[~r?:qHAP{~BrP'PaIP(g`/UOlMY#,'~JE~rP@#@&~~,P~P,~P,P~dUpS~x,/jpd~LPEAK&H2,',vJ,[~w"K(Hv/2	[#,[PrvSJ,@#@&d7ddj5S~',d?5S~',J?P(t2+P{~EJ~LPaIK&1vd?Dl.Yy#~',JBBEP@#@&P,~~P,P,P~P~dUpJP{~/UpJ~LPJ3P&H3 ,x,BE,[,wI:qgc/Ax[ *P'~rB~r~@#@&PP,~~P,P,P~Pdj5S~',d?5S~',Jb\6`1PP{~EJ~LPasWM:mO`9bhW!xOSy#PL~JE~J@#@&7di/UpJPx~k?}S,'Pr?u6qbHP~{PvJ,',w]:qg`/UtKAbsYbPLPEvBJdi7d@#@&P,~~P,P,P~P~dUpJP{~/UpJ~LPJK]&r]q:e,'~EJ,[PaI:(1vNKDbW.rDX#,'PrB~r~~P,P,@#@&P~~,P~P,~P,Pdj5SPx~k?}S,',Jj:b:j?,',vJ,[~w"K(Hv/?DCY!/#,'~JE~rP~@#@&~,P~P,~P,P~~k?pJ~{Pd?5J,[~rjU2I|qG~',BEPLPdnk/kKU`rj?A]Hbt2r#~[~EE~EP,~P,P~~@#@&P~~,P~P,~,P~k?5SP{PkjpdP'Prf)PAKqt3P{PBr~'P6fmYnYrh c1KA`*#~',JB~E@#@&~P,~,P~,P,PPk?5JP{Pd?5S~',J_3IAP?`$P5h2,'~BE~LPdq9~[,JvE@#@&P~~,P~P,~,P~1W	xR6^ED+~/UpJ@#@&PP,~P,PP,~~P@#@&id7mCs^P^W	WkM:$GX`Ji29lO+,j!m^/k0E^"rSPkHCk	j]JL/b9[j"S#@#@&~P,P,P~P~~iP~P,~P,P~~i@#@&~~,P~P,~Vdk6P/tW9n?!4~',JdC7+J,Ptx@#@&~~P,P,P~@#@&~,P~P,~P,P~~U+Y~.kY/?:za+~{Pk+D7+M ZM+CYr8%mYvEbGrf~ ]+1WMNj+OE*P~P,@#@&,P~~,PP~~,P~/U}dPx,Jk+VmD~e,0.WsP^dDXw~h4+D~jj~KIn3Px~EJ~[,dq9P'~rBJ~@#@&P~P,~,P~,P,PDkY;jKHwnR}wnU,/?5J~,mW	USP2~,&@#@&~~,P~P,~P,P~r6PxGO,DdY;j:X2RW0,Y4nx@#@&~P,P~~,PP,~P,PP,^CV^PmVnDO8K6cJU;4kk[z,KX2n,)~J,',/(9PLPJ,l^.+mNzP6rdDP"rb@#@&ddinUN,k6P~@#@&~,P~P,~P,P~~aZVGdKC4^nk`.kY;?KHwb@#@&@#@&didrW,/q9~',JJ,O4+	@#@&d~P~~,P~P,~P,mCs^PlsnMY8WXcr?;(/bNX,KH2+,mCx	WO~(+PhwDXJ*@#@&d,P,P~P~~x[PbW@#@&@#@&7,PP~~,P~k6~kfnkm,'PrJ,Otx@#@&iP~~,PP,~P,PP1CsV,l^+.Y8GX`EfdmMk2ObWx~^mxUWD~(+~:aYXr#@#@&d,P~P,P~~xN,r0iPP,~~P,@#@&d~P~~,P~P@#@&d,P~~,PP~r6Pd?DCMY~{PrJPDtU@#@&d~P,P~~,PP,~P1lV^~CVDD4G6cEUYCDD~Kb:n~8PmCU	WOP(n,+haYHJ#@#@&i~P,P~P,PnU9Pk6@#@&iPP,~~P,P@#@&7P~~,P~P,r0,/3U9P'~ErPOtU@#@&7,P,PP,P,~P,P^l^V~C^+DD8WX`JAU[P:ks+~F~^mxUWD~4PnhaYXEb@#@&7P,~,P~,PxN,k6~P,P~P@#@&7~,PP,~P,@#@&i~~P,P,P~kW~9bhW!UY,'~ErPY4n	@#@&d,~,P~,P,PP,P1CV^PCVDO8K6`r):KExD~^l	xKY~4n~:2YHE#@#@&7~,PP~~,Pnx9~b0~,@#@&dP,P,~P,P@#@&iP~~,PP,~?YPMdOZUKHwnPx~k+.\.R;DnCD+r8%mO`r)Gr9~R"+mKD9j+DJbP,P~@#@&PP,~P,PP,~~Pk?5S~'~Ek+s+1OPCPW.K:P^dDX2+,A4+.PhIq}I&P5,'~BrP'~9nDbGDbYX,'~JEPr@#@&P~~,P~P,~P,Pdj5SPx~k?}S,',JC	N,?j~KIK2,@!@*PEJ~',/q9~[,JB,E@#@&,P,P~P~~,P~PMdY;?Pza+R62x~/U}d~~1W	x~,&B~&@#@&~P,P~~,PP,~Pb0P	GOPM/DZjKz2RnW6~Y4+U@#@&PP~~,P~P,~,P~,P,dmmV^~l^+.Y(WacrnDbGDbYX,|EPLP9n.kG.bYzPL~J#PCsM+l[z,ld/bL	+[,YKPYHw~=rP'PM/O/UKXan`r?j~PenAJ*P'PE|,P~"rb@#@&d77xN~r6P~@#@&~,P~,P,PP,P,2Z^Wd+:l8s/`MdY;?KH2n#,P@#@&@#@&~~,P~P,~P,P~dUpS~x,JrxknMY~bxDWP1/DzwPc?`APeh2~,Kb"K~,jPqt2BP3K(\A~~?:(HA S~AKq\3y~~bt6`1PBPUCrqbtP~,n]q}I(PI~PUPb:j?B~E@#@&P,P~P~~,P~P,d?5S~x,/?}J,[~J;]AbPA{&f~,f:mZ"2)KA~~iU2I|(fBPfzP3K&HA#~J@#@&,P~P,~P,P~~,/?}J,'~/U}dP',J7lV!+k~`r@#@&diP~~,/?5JP{P/U}JPLPrBEP'~aIPqgc/&Nb~LPJvSrd7P@#@&id~,P,/?5S,xPk?}S,[~EEJPL~w"Kqgcdf/1#~[~EE~E@#@&7d,P~~k?pJ~{Pd?5J,[~rBrP[,w"Pqg`d?Dl.O*P[,EBBJ@#@&77P,P,/jpJ~{Pd?5JPLPEvrP[~2"K(1vdAx[*PLPJE~r@#@&id7/UpJ~{P/U}S,[PrvEPLPaIPqHck?OlMO *P'~rB~E@#@&d7P,~,/j5S,'Pk?5JPLPEBrP'~aIK&H`k2x9+bPLPrBSJ@#@&id~P,~/UpJ~{P/j}dP'PrvrP',wwWDslDcNz:GE	YS+*P[,EBBJ@#@&77dk?5S~'~dUpJPL~JEJ~',wIP(g`d?4GSbhD#LPJE~r@#@&id~P,Pdj5SP{~/UpS,'~JEJ,[~w]P&1cNh.kKDrOH#[~EE~E@#@&7iP~,Pk?pdP{~/UpJPLPEvrP[,2I:q1vdjYmY!/b[~EE~E@#@&7d,P~~k?pJ~{Pd?5J,[~rBrP[,/d/bWU`rjj3"1bt3J*P[,Ev~rP@#@&7d~~,Pd?5JP{Pdj5SP'~rBEPL~6NCD+Dk: vHWS`b#,[~EE~J@#@&diPP,~d?5S,'~/j}dP'PrvJ,[~d//rG	`EjU3"1)t2r#PLPrv~rP@#@&id~~,P/U}S,'Pkj}S,[,JvJ~',0[lDnYb:n+v1WAc*#~[,EEJ@#@&P,PP,P,~P,P~/UpJ~{P/U}S,[Prb~J@#@&,P~P~~,P~P,~BM+d2Kx/n SDrY~k?}d@#@&dd,P,~mKxUR6n^!Y+,d?5S@#@&~~P,P,P~P~~,@#@&di7mmVs~1WxWrM:$WXcr?C7+,?E1md/6Es"r~~dtlk	iId[/z[[j"S*@#@&P~~,P~P,~P,P~~,PP@#@&id~+	[,kW@#@&,PP,2	[P&0@#@&,P~~,PP,~P@#@&P,~~?Y,DdY/j:X2+,xPk+.-DR/.lO+}8N+^D`rbf}f~ ImGD9?nOr#P,~P@#@&P,~~/UpdPxPEdVnmD~e,0.GsPmdOHwnPS4Dn,?`AKInAxBrP'Pkq[~LPJEEP@#@&P,~~DkY;?PX2ncr2+	~/UpJS,mWUUBPf~,f@#@&~,P,k0,xKOPM/OZUKz2R+KWPDt+	@#@&P,P,P~P~dUE8KH2+,'~.kYZjPHwn`rj`APInAJ#@#@&,~P,P~P,/9nkmP{~DkYZUPzw`rn)IPE*P~P,~P,P~~,P@#@&~,P~P,~,/jDlMYP{PMdY;?PXa+cEUKqt3J*@#@&,~~P,P,Pd2U[,'~DkOZUKz2`J3P&H3J*@#@&d7k?DlDD ,xPM/OZUKz2`JUPqt2 rb@#@&,P,P~P~~k2UNy~',DdO;?Kz2`E2:(t2+r#@#@&P,P,~P,P[bsW;UDP',./DZ?:z2+vJzH6jHPr#@#@&i7/UtGAz:Y~x,DdY;j:X2`r?C}z\Kr#@#@&,P~~,PP,[nMkWMrOX,',DdY/j:X2+vEn"q6]&K5Eb@#@&~P,~,P~,/UYlDEk~',DdY;?Pza+`rjKzKjUEb@#@&di@#@&P~~,+UN,r0@#@&~~,PmCs^P2Z^Gk+Pm4^+/vDkOZUKzw#@#@&,PP,@#@&,PP,~@#@&,P,P2bkGAA==^#~@%>
 
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
