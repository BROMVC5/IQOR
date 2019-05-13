<%@ LANGUAGE = VBScript.Encode %>
<!DOCTYPE html>
<%#@~^GAAAAA==~U+dkkKxR:ksnW!Y~',F**ZPfwcAAA==^#~@%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>IQOR</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="font_awesome/css/font-awesome.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="ionicons/css/ionicons.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css" />
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css" />
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />
    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery 1.12.0 UI CSS -->
    <link href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" rel="stylesheet" type="text/css" />
    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <!--<script src="dist/js/pages/dashboard.js"></script>-->
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Bootstrap 3.3.6 CSS-->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
	<%#@~^nQIAAA==@#@&dW!x1YkKx,WbsnhKb:nc&xKbh+*@#@&,~~P9ksP6EOuKE.~,C:a:@#@&,PP~r6P4W!.vqU:ks+#,@!,q ,Y4+	@#@&~,PP,~P,rEDuGEMP{P4W;.vqUKbh+*@#@&~,PP~~,PC:ah,'~rbtJ@#@&P,~Px[Pb0@#@&,PP,r0,tW!.cq	Kb:n#~x,F+PD4+	@#@&~,PP~~,P6EDuKE.,',tW!Dv(x:kh+*@#@&~,PP,~P,l:ah~',JhHE@#@&~,P~+	[Pb0@#@&,PP~r6P4W!.vqU:ks+#,@*,q ,Y4+	@#@&~,PP,~P,rEDuGEMP{P4W;.vqUKbh+*PR~8 @#@&~,P~P,~,lha:,'PrntE@#@&P~P,+U[,k0@#@&P,PP@#@&~P,P6bhnhPb:nP{~sKDhCDflOn:kh+v6!YuKEMP[,J=EPLPhk	EOnvqxDr:#~Wb~[,J,J~[~Cswh@#@&7+	N~W!xmOrKx@#@&i@#@&dW!x1YkKx,WKb:n vNPnsw#i@#@&id0:rh+yP{PjY.r	oc ,RPd+Uc_WE.c9Kn:ab*~EZJ*P[,CK;DvNP+swb~LP{@#@&diddrlEPLPUY.kULv ~O,J+	`\r	EYnc9Kn:ab*~EZJ*P[,HbUED+cN:+h2*@#@&inx9Ps!U^YbW	@#@&@#@&7zaQAAA==^#~@%>
	
	<!-- Time Clock -->
	<script type="text/javascript">
	
	var bGetClock = true;
	var iClockDiff = 0;
	function toSeconds(t) {
	var bits = t.split(':');
	return bits[0]*3600 + bits[1]*60 + bits[2]*1;
	}
	
	function updateClock() {
	var clientTime = new Date ();
	var clientHours = clientTime.getHours ( );
	var clientMinutes = clientTime.getMinutes ( );
	var clientSeconds = clientTime.getSeconds ( );
	
	clientTime = clientHours + ":" + clientMinutes + ":" + clientSeconds;
	var secClient = toSeconds(clientTime);
	
	if (bGetClock) {
	<%#@~^cwEAAA==7@#@&7iYkCW!D,xP_W;Dv0G.slY9CYYksncxKhv#Scbb@#@&7dDdHbx;OP'~\bx;Yc6W.slDNlD+Dr:`UWS`bSW##@#@&diY/Un^W	N,'~?n^Kx[`6GDslO[mY+Ors+cxKAv#S2#*@#@&id&WP^+U`D/uG!D#,xP8PY4nUPD/_W;D~x,JTJ,'PD/uG!D@#@&7iqWP^n	`OkHbxED+*~',F~Y4+U~D/HbUED+P{~E!rPLPO/\r	EO+@#@&diqW~^+xcOk?nmKU9#~{P8PY4+	~Yk?nmKx[~{PJZEPLPYkjnmKx9@#@&d7dU+.\.Kb:n~{PYduKE.PL~r)E,[,Y/tk	;YP'Pr)E~LPYkj+1Wx9@#@&dyWoAAA==^#~@%>
	  	var serverTime = "<%=#@~^CwAAAA==dU+.7+MKks+eQQAAA==^#~@%>";
	  	var secServer = toSeconds(serverTime);
	  	iClockDiff = secServer - secClient
	  	bGetClock = false;
	}
	
	secClient = secClient + iClockDiff;
	
	clientHours = parseInt( secClient / 3600 ) % 24;
	clientMinutes = parseInt( secClient / 60 ) % 60;
	clientSeconds = secClient % 60;
	
	clientHours = ( clientHours < 10 ? "0" : "" ) + clientHours;
	clientMinutes = ( clientMinutes < 10 ? "0" : "" ) + clientMinutes;
	clientSeconds = ( clientSeconds < 10 ? "0" : "" ) + clientSeconds;
	
	clientTimeString = clientHours + ":" + clientMinutes + ":" + clientSeconds;

	document.getElementById("clock").firstChild.nodeValue = clientTimeString;
	}
		
	</script>
		
	<script type="text/javascript">
	function init() {
		updateClock();
		setInterval('updateClock()', 1000 );
	}
	</script>


</head>
	
	<%#@~^/ikAAA==7@#@&7kHKN+UE(~',Dn;!+dOvJ/!8J*@#@&idjYmY!/~'~Er@#@&dkjYmY;dz:Y~x,JE@#@&7@#@&7U+DPDkY;jnmY4P{PdnM\+M ZM+lDn64N+1YcJ)9}f$R"nmKD[jYJb~,P~@#@&~,P~k?5SP{Prd+^+^Y,e~WMW:,^/alY4~EP@#@&,P~P.dDZjnmOtcr2n	P/j}d~~mKU	~~2~,&@#@&P,~Pb0~xKY~.kYZUKlDtRGWPDtx@#@&~~,P7/&UkDkCs,'P.dDZjnmO4`E;r`1KAIrb@#@&dnx9PrW@#@&d1CV^Pw;sG/Km4s+dcM/OZUKlDtb@#@&d@#@&7b0~/tG9+j!4,@!@*,Jr~K4+U@#@&d@#@&,ddk/lMN1K~xPM+$sGDhcrYaY1CD91GE*@#@&77kZCD9HKPx,`"ko4YvdZmD[1K~b*@#@&,~P,PP,~@#@&idb0~/\G9+jE(~',Jd^mxJ~O4+U@#@&@#@&d7i?YPM/D/?A:2VHPx~k+D7nDcZDCO+}4N+^YcEzf6f~ ImG.9?+OE*P~P@#@&,P~,P,PP,P,~/UpJP{PEdV+1OPCPP6.G:,mk+hwsz,J@#@&,~P,P~~,PP~~k?}S,x,/j5S,[PrVWY,LGk	POh:w^zPKxP1dn:aVHRn:2m1W[+,xPD:nhaVX nswmmK[PE@#@&,PP,P,~P,P~Pk?}J,'PkjpdP[,EAtDP^/nhaVzR1CD916~{PBE~LPdmm.91G,[,JB,l	[P1/n:aVz 1lD9Hr,@!@*,vvPmx9P^/nhaVzRUPb:jj~{PBev,lUN,cD:nsw^XRGK|]2Uq!1,@*~vrP[,WfmY+ycHWS`*#~[~EEPGD,9K|I3j&M1~(UPHjdJ*PE@#@&,PP,P,~P,P~PM/O/U2:asXcrwU~/Upd~~mGU	~~&B~&@#@&77ik0~UKY~DkO;?3sw^XRW6~Y4+U@#@&d77@#@&di7dU+Y,.dY;?A:2Vzq,'~/.\D /M+lOn}4%+1OvJ)GrGAR"+1GD9?nYr#~~,P@#@&7did/U}JP{Pr/nVn^DP^/hw^Xq AHnm/}f3~,^k+haVHFR:5h3~,md+swsz8Rf:m?`A~,^d+sw^XqR)\}jHKB~mkYz2R?P(t2SmkOHwnc2:qHA~1dYHwnRhI(6"qKISmkYXan ?_rqb\KS~1/n:asXcZ)]G1r~WMWhP1d:2^X8PJ@#@&i7di/jpdPx~k?pd~[,JVWOPNWbx~mdOHwnPKUP1/nhaVXq :5K2,x,mdDXa+RUj~P5h2~J@#@&77id/U}S,'Pkj}S,[,Js+WO,LGk	~mk+h2^XPGU,md+s2^Xqc2tn{;rG3P{P^/:2sHR2tK{;rfA~E@#@&did7/j}dPxPkjpdP'~rhtn.P/b"9gr~{PEJPLPk/lMNHW,[~EEPJ@#@&diddkj}S,',/jpJ~LPEl	[PGKmj`APx~EJ~[,WGlO v1WS`*bPLPEB,J@#@&iddid?5SP{~d?5S,[~JCU9PcBr~[,0Prs+ cUKhc#*~LPEEP~2Kq2AHPUK(HAPCU9P2:(HAPWM~vJ,[,0Pkhny`UWSc#*P'~rBP$3:32g~UK(t2yPl	N,3K&H3 *PE@#@&ddi7/UpS,x~/UpdP'PEC	N~KIK2,16P,q1~ck+s+1O,Keh2,0DK:,^/DDU/,h4nM+P;)IG1r,x~BrPLPdZC.91GPL~JEPCU9PfPm:IH?,J&|3,BuJPLP69lD++`gWAc*#PL~JuBPmU[PUKzKi?~x,BeB*~J@#@&77id/j}dPxPkj5S~LPrWD9+M~4HP2DbW.rDXPmdm,J@#@&77diB"2jn6HU2 "(KAPjj5SP'~r@!8DJ@*r@#@&ididDkY;j2swsX8R62xPkjpd~P1GUxBP2~~&@#@&id7dbWP	WO~M/Y/jA:2VHqc+G6PDt+	@#@&7did7@#@&d77id?OPM/Y;jPD	/,'~/n.7+.R;.+mYn6(L+^OvJ)f}9~R]mKDNU+DE#,P~P@#@&77,PP,~P,PP,~~/UpdPxPEdVnmD~e,0.GsPmdOMxdPr@#@&d7,P,PP,P,~P,Pd?5S~x,/?5JPLPJS4nDP;b]fH6,'~Br~[,//CMN1G~LPEB,C	N~:5h2P{PEEPLP./DZj3swVHq`rK5h3E#,[,JvJ@#@&id~P,~P,P~~,PPdj5S~',dUpJ,[,Jl	N,9K|K]1UPJ(n2PEYJ,[P69CY v1Ghcb*P'PrYB,J@#@&idP~~,P~P,~,P~M/DZ?:D	dR}wnx,/j}d~P1Gx	~P2S~&@#@&id7d7r6P./D/?:DUdc+WW~Dtnx@#@&id7id@#@&didi7dk?}S,'~Ebx/.Y,kxDG~mkYMxd`/)"fHrB~Z}jK6g~PPeh2SPGP|K]g?BP?:b:i?BPi?AIm(G~PG)KAKqt3bJ@#@&id7d77k?}S,xPk?}J,[PE-mV;+k~vJ@#@&diddidkjpdPxPk?}J,[PrvJ,[Pa]Pqg`kZCD[HK#~[,EBBJ@#@&idd77i/jpd~{PdUpdP[,JEEPLP2sKDhCD`DkOZU2:aszFvJzH6jHPr#S *~[,JvSrd@#@&7id7didUpJ,',/?5S,'PrBEPLP.dDZ?Ahw^XFvEP5h2r#~[~EE~E@#@&7did77k?pJ~{Pd?5J,[~rBrP[,0GCYYr: cHKh`*bPLPJESEdidid7d@#@&id7di7/UpJ~{P/j}dP'PrvIBSrPiP@#@&di7didd?5S~x,/?5JPLPJEE~[,//dkGUvJi?A]1zH3E*P[~EE~EP@#@&id7idi/?5S,xPk?}S,[~EEJPL~0GlYOr: v1Ghcb*P'PrvJ,P~~,PP~~@#@&7di7iddUpdP',/U}S,[~J*PE7@#@&di7didmKUUR6m;Yn~k?}S@#@&did77iP@#@&7id7didUpJ,',Jk	/.Y,kUYKP^dDDxk"Pv#P7CsE/,`bJ@#@&id7di7mKxU 6+^;D+~/U}d@#@&ididdi@#@&7did7dU+O~M/Y;jKMx/z;OW,',/nD-nMR/DCYr8%mYcEzf6f~ "+^KD9?+DJ*~P,P@#@&id77id/U}S,'PrdnVmDPMPW.K:~mkOD	/~E@#@&d77id7/U}dPx,/UpS,[,EWMNnD,4z~zjK}(1;PNd^P^kskOPqE@#@&7di7diDdO;?K.Ukb;YK }wn	Pk?pd~,^W	xSP2~~f@#@&di7didk6~UWDPM/OZjPMxdb!OWc+GW,YtnU@#@&7di7id79ImWMNz;YKqUm,'~.kYZUPD	/b!OG`rb`K6qH/r#@#@&i7did7n	NPrW@#@&7d@#@&id7idi?+DPMdY;?PD	/+~{P/.\DR;.nlD+}4%+^OvJ)f}9AcIn^KDNjnDJbP,~,@#@&ididdi/U}S,'~Jk+sn1YPC~0MW:,^dYMxky~J~~@#@&7di7di/j}dP'~dUpJPL~rW.9+MP4HPm;YKkUm,Nnd1PVbhkDPFr@#@&didid7DdO;?PD	d cr2n	P/j}d~~mKU	~~2~,&@#@&di7didr0,xGO,D/D/?:Dxk+ +K0,Y4+U@#@&d7di7diN);DWqU^,'~DkO;?PMxk `rb`Pr&1/J*@#@&7iddi7dkI+6HGP{PkqUkOrmV~[,[b!YG(	m@#@&7id7di7@#@&7ididdi/U}S,'~J`n9):2P1dYMx/,j3K,Jid7P~~,@#@&di7did7dUpS~x,/jpd~LPE"2w1r,',vJ,[~w"K(Hv/IW1K#PL~EBr@#@&d7d77idd?5JP{Pdj5SP'~ru2"3,bi:r&1Z,',vJ,[~N"+^GMNb!OW&xm,'~JEPr@#@&d77id7d1Gx	RnamEOn,/jpd@#@&d7idid+	N,r0@#@&7did771lV^~w;VWknPl(V/cDdO;?PD	d *d@#@&idd77id7di7i@#@&ididdik6~DkY/?A:2sHF`rjC}btPE#,',JeJ~O4+Udi7did7@#@&dd77id7/UOmY;kP{PJIJ@#@&did7di+sd@#@&i7diddidjYmY!/~'~EI E@#@&7did77xN~r6@#@&di7id7k?DlY!/zhY,'~wwW.hmY`MdY;?2s2sX8`rb\riH:Jb~yb@#@&d77idd@#@&id7din^/n@#@&iddidid?5S~',JrUk+DD~k	YW,^dYMxkPcZ)]G16~,/r`n6HBPfPm:IH?B~UK):jU~P`?A]{&fSPGbP3:qHAbJ@#@&di77di/UpJPx~k?}S,'Pr\Cs!+/~cr@#@&di7id7k?5SP{PkjpdP'PrBE~LPw"Pqg`/;C.NgW*P'PEvBJ@#@&i7did7dUpS~x,/jpd~LPEE!c!!E~r7@#@&d7did7dUpS,xPk?pd~'PrBrP'PW9mYnYbh+y`HGS`#b~LPEBBEid7idid@#@&di7didd?5S~x,/?5JPLPJEHv~rPiP@#@&77id7dkjpdPx~k?pJ~LPEBr~LPd/kkW	`ri?AIHbt2Eb,[Prv~rP@#@&77didi/jpJ~{Pd?5JPLPEvrP[~WGlO+Drs++v1Kh`*#,'PrBEP,P~~,PP,@#@&iddi77/UpdPxPdj5S~[,E#,J@#@&idd77imGx	 6n1ED+Pk?5J@#@&d7did7@#@&ddi7di/?5J~',Jbxd+.O,kUYK~mkY.UkyPcb,\CV!nkPc*J@#@&didi7d1WUxc+an1EY~/UpS@#@&7didid@#@&77id7dUnY,DdO;?K.Ukb;YK~{PdD7+DcZMnlD+64N+^OvJbG6f~RI^GD9?YE#~~,P@#@&i7did7dUpS~x,Jd+^n1Y~CP6DWsP1dYMxdPr@#@&7iddi7/UpS,x~/UpdP'PEGMNnD,8X,biP}q1/~9+dm,sb:rDP8J@#@&di7did./DZjPMx/z;YKRranUPk?5SSP^G	xSP2SP2@#@&7idd77b0~xKO,DdDZUKD	/z;YKRnW6PO4x@#@&7diddi7[ImKD[b;OKqUm,xPM/O/UKDUdzEOWvEzjP}qgZJ*@#@&7did7dx[~b0@#@&7d@#@&di77di?Y~DdO;?PD	d ,'~dD\n.cZ.+mOr8N+1Y`rbG6f~R]+1W.[U+YrbP,PP@#@&7dididd?}J,'~JknVmO~CP0.GsP^/D.	/",J,P@#@&di7didd?5S~x,/?5JPLPJK.[+MP(X~l;OKkUm,[+km~sb:kO~8J@#@&i7id7iDkYZUKMU/yR6wx~dUpSB~mKxxB~f~,&@#@&7d77idr0,UWDP.dDZ?P.	/+RG6PO4+	@#@&idi7did[b!YG(	mP{~DkYZUP.xk vJ)jP6&1/J*@#@&id77iddd]0HW,x,/(	kDkl^PL~NzEOW&x^@#@&ddi7did@#@&77dididd?}J,'~J`KfzK3~1/Y.UkPj2:~rd7iP,PP@#@&i7did7dk?}J,'PkjpdP[,E]2w1}PxPvE,[~w"Pqg`d]01Gb,[~JEE@#@&7ididdi/U}S,'~/UpJ~LPJqu2"2PziPr&1;PxPvE,[~N"nmKD[)!YW(U1P'Prv,J@#@&diddidi^W	x +X+^;D+Pkjpd@#@&i77didx[PrW@#@&7di7dimCs^Pw/sK/nKm8^+dvDkYZUKMU/y#@#@&id77idd@#@&diddi7d?DlDEdPx~r1E@#@&7did7n	NPrW@#@&7di7imC^V,wZ^WknKm4s+k`.dDZ?:.xk#@#@&77d@#@&id7d3sk+@#@&@#@&did77U+Y~.kY/?hCDt~{Pk+D7+M ZM+CYr8%mYvEbGrf~ ]+1WMNj+OE*P~P,@#@&id77i/?}J,'~Jkn^+^DPCP0MWs~mkwCY4PE~@#@&di7di/?5J~',/UpJP'~rh4+MnPEJ~',0Krh cxKAv#b,[,JB,AAPA2HPg{jP&H2,Cx9P1|3Pqt2,J@#@&77id7DkOZUnCO4Rr2n	Pd?5JBP^Kx	~P2~,f@#@&d7didrW,xWD~DkYZUKCY4RWWPO4x@#@&i7di@#@&7idd77U+OPMdDZj:D	/P{PknD7+.R;DnCD+r(%+1Y`r)9rGAcInmG.9?nYrbP,P~@#@&dd77idd?5J,'~r/V+1Y,MP6DG:,mdOMx/,E@#@&ddi77dk?5S~'~dUpJPL~JStn.PZ)]G16P{~EJ~LPkZlMNgGPLPEB,lU[,K5h3P{PBgvE@#@&did7d7dUpJP{~/UpJ~LPJCU9P9K|P"1j,S&|2,BuEPLPWfmYn+v1WSc#*P[,EYB,J@#@&7d77id./D/?:DUdcrwnU,/jpdS,mG	xBP&BP2@#@&id7didrW,D/D/?:Dxk nW6PDtnx@#@&id7di7did7@#@&dd77id7/U}dPx,Jbx/DD~k	YGP1/O.	/Pv/b"f1}S~Z}jhrH~~PIn3~,9K|K]HU~PjPzKi?B~`?3"{&f~,fzP2:q\2*J@#@&iddi7di/?5J~',/UpJP'~r\CV!n/,`E@#@&dd77id7/U}dPx,/UpS,[,EBrP'PaIP(g`/1CD91W*~'PrBBJ@#@&77id7did?5S~x,/?}J,[~JEE,[~asKD:mYv./DZj2swszvJZ}in}1J*S+#,[,Jv~E7@#@&7di7diddj5SPx~k?}S,',JvgBBJ@#@&di7did7/UpJ~{P/U}S,[PrvEPLP6fCYnOb:n vHWS`bb,[PEvBJ7di7id@#@&diddidid?5S~',/j}dP[,EBIB~r~7P@#@&id7d77i/jpd~',/j}dP[~EEJ~[,d/dbW	`J`?A]1zH3J*P'~rB~r~@#@&ddi77di/UpJPx~k?}S,'PrBE~LP09CD+Oksny`HKhv##,[,EBrP~P,P~~,P@#@&7diddi7d?5S,'~/j}dP'PrbPr@#@&7idd77imGx	 6n1ED+Pk?5J@#@&d7did77@#@&di7diddkj}S,',JrxdnMY~k	OW,mdOMx/"~v#~\ms!+d,`*J@#@&di7did7mKxU 6+1;YP/U}J@#@&did7d77@#@&7di7didjnDPDdO;?PD	dzEOKP{P/D7nDcZ.+mYn6(L+1O`rbf}9$R"+1W.NjnDJbP,~P@#@&77idd77k?}S,x,JdVmY,e,WDK:~mkY.UkPJ@#@&diddi77/UpdPxPdj5S~[,EWMNn.,4X~)`K6qg/,Nnkm,VkskD~Fr@#@&did77idDkOZUKD	d)EDWcr2+U~k?}SB~mKxUS,&~~f@#@&7di7id7b0,xWDPMdY;?PD	/);DWRG0,YtU@#@&idid7d779InmK.NzEOG&xm~x,DdY;j:DUkb!YWvJziK}qHZr#@#@&iddi7di+x9~r0@#@&id7@#@&7id7di7?Y~.kYZjPMxd ,x,/nM\DR;DCYr8LmOcrbf}9AcI+1G.NU+DJbP~~,@#@&di7did7dUpS~x,Jd+^n1Y~CP6DWsP1dYMxdy,J~~@#@&di7diddkj}S,',/jpJ~LPEWM[+MP8z,lEOGbx^P9nkm~^kskY,Fr@#@&id7did7.kYZUPD	/ c62+	Pk?}SS~1WUxB~&BPf@#@&dd77id7k6~	WO,DkYZUKMU/yRnW6PO4x@#@&7diddi77NzEDW(x^~{P./D/?:DUdy`J)i:r(1;E*@#@&ididdididI0HW,'~d&xkDrl^P[,[)EDW&x^@#@&7id7di7d@#@&77idd77i/jpd~{PE`nGbKAP1dYMxdPU2P~rddi~P,P@#@&77didid7/j}dPxPkjpdP'~rI2oH}PxPEE,[~aI:q1v/"n0gWbPLPEvr@#@&i7diddi7d?5S,'~/j}dP'Pr	CAI3~zjK6(gZ~',vrP',N"+mKD9)EDW(x1P'~rBPr@#@&iddi77dimKxURnam;Y~/UpJ@#@&dd77id7+	[,kW@#@&iddidi7mmVsPaZsGk+Km8V/`MdOZUKMxd b@#@&d7di7di@#@&7idd77i/jYmO!/~{Pr5J,P@#@&did7diddjDlY!dbsYP{~2sKDslO`.dDZj2s2VH`E/}jn6Hr#S *@#@&d~,d@#@&didi7dVd+@#@&77iddi@#@&iddi77dk?5S~'~Ebxd+MOPbxOG,m/O.	/~`;)"fH}~,Zr`n}H~,fP{:IHjBP?:)K`?~,ij2"{&fSP9):2Pqt3#r@#@&7idd~~,P~P,~,P~,/UpS,',d?5S~[,J-C^E+k~`r@#@&i77did,P~Pdj5S~',d?5S~',JBE~LP2I:(g`d;lMN1K#,'PrBSJ@#@&77iddi~P,P/U}JP{Pk?}S~',Jv!cT!E~E7@#@&d77id7dkj5S~{Pk?pdPL~JEJ~[,09CD+Ybh+y`1KAc#*PLPEBSEid7di7d@#@&77idd7~,P~/U}dPx,/UpS,[,EBgBSJ,d~@#@&ddi7diPP,~d?5S,'~/j}dP'PrvJ,[~d//rG	`EjU3"1)t2r#PLPrv~rP@#@&id77idP,~Pk?pd~xPk?5S~[~EEJ~[,WfmYnOb:++cgWA`*b,[~rBrPP,P,~P,P@#@&id77idP,~dk?pd~xPk?5S~[~E*PE@#@&7did~7,Pd~~,P^W	Uc+am!Y+,/U}S@#@&7did~7,Pd,~P,@#@&i77d,d,P7P~~,/jpd~',JrUk+DO~bxOW,^kY.	/.P`*P7CV!+dPv#E@#@&ddi7didmKUUR6m;Yn~k?}S@#@&did77id@#@&7id7di7U+O,DkYZUKMU/zEOW,'~dD\.R;D+mOnr(LmO`E)Gr9Ac]+1W.[U+YEb,P~P@#@&id7,P,PP,P,~P,P7/UpJ~{PJknVmY,M~0MWsP^/O.	/~J@#@&did~~,PP~~,P~P,7k?}dP{P/Upd~[,JGD9+.~(XPziK}q1;~[+km,Vr:rO,FE@#@&7diP~~,PP~~,P~Pi.kY/UKMx/zEDGR}wnx,/j}d~P1Gx	~P2S~&@#@&id7P~~,P~P,~P,P7r6PxGO,DdY;j:DUkb!YWc+KWPDtnx@#@&77iPP,~P,PP,~~Pid9InmG.9b;YK(x1Px~M/Y/j:DU/z;DWcrb`Kr&1;E#@#@&7diP~~,PP,~P,PPinUN,k6@#@&d77@#@&7di7PiP~7,PP~jY~DkO;?PMxk P{PknD7+.R;DnCD+r(%+1Y`r)9rGAcInmG.9?nYrbP,P~@#@&dd77id~P,~k?}dP{PJk+^nmDPMP6DGh,m/D.xkyPr~~@#@&did7d7~,P~/U}S,'~dUpS~',JGD9nMP8HPmEYKk	^P9+dm,VrhbYP8E@#@&ddi77d,P,P./O/UK.xk+R}wnU,/?}JBP^W	UBPfBP2@#@&idi7diP~P,kW~	WY,./DZ?:.U/yRWWPO4x@#@&i7did7~,PP7[zEOW&U1Px,DkYZUKMU/y`Eb`K6(gZJ*@#@&iddi77P,P,ddInWgW~',dq	kOrmVP'~9b;YK(	m@#@&diddid,~P,d@#@&id77idd,~P,/?5J~',J`n9bP3,mdYMU/,?3P,Jd77,P~P@#@&id7ididdk?5JP{Pd?5S~',JIAo1}P',vEPLPaIPqHckIn0gG#,[~EEJ@#@&7id7di7i/j5S,'Pk?5JPLPE_2]3,bj:6qgZP{~vJ,[,N]+^GMN)EDGq	m~',JB~E@#@&7di7id7imKxxc+Xnm!YnPk?}J@#@&di7didP,~~+	N,kW@#@&7id7di~P,P^C^VP2/^Wd+:C(Vnk`M/Y;?:.xk b@#@&d77idPi~PiPP,~@#@&idid~d~~iP~P,d?DlO;kP'~EgJ@#@&i7id7idiPd,Pi~P,P@#@&id77id+	[Pb0@#@&77didimCVs~aZsWknKm4snk`DdO;?PD	d*@#@&ididd@#@&i7didnVk+@#@&iddi7dk?YmO;/,',J3J@#@&id7dinx9PrW@#@&d77id^l^s,w/^Wk+Km4^n/vDdY;?KCDt#@#@&didd@#@&7didAx[P(W@#@&7di7mmVs~aZVGdKC4^nk`.kY;?2sw^zF*@#@&did77@#@&Pi~Pid+^dn@#@&PiP~d77k?OlD;/,'~E&J@#@&~iP~din	N~b0@#@&PiP,7d1lsV,w/sK/+:C4^+/v.dY;?A:2Vzbi@#@&di7@#@&d7n	NPrW@#@&7+	[,kW@#@&@#@&P,P,j+DP./DSdO&:w,xPk+D7n.R;DlO+68N+^YvEbGr9$cI+^GMNj+DE*P~,P@#@&P,P,d?5S~',Jdn^+mD~f:{qtK~0MWsP^/2CDtE@#@&~P,P.dDS/O(sw ran	PdUpd~P1W	U~,&SP2@#@&~,PPbWP	WY,.dYd/Dqhw nK0~Y4nx,P~~,PP~~,@#@&P,~,P~,P9YfD{&hw,'~DkYJdDq:acJGK{&\KJ*P@#@&~P~~x[PbW@#@&P~~,mlss,w/VKdKC(V/`M/DJ/Dqhw*@#@&7@#@&P,~Pk+Y,.dY}06HGNn~{Pd+M-+MR/.lYn6(LnmDcrb9}f~RImK.NU+OJ*@#@&~,PPkjpdP',Ed+^+1Y~roo|H6fA~0MWh~1/wCO4J@#@&,~,P.kY}00tW9nR}wnx,/j}d~P1Gx	~P2S~&@#@&,P~PrW,xGY,./DrWWtWNn WWPD4x@#@&P,PP,P,~/}0WHKNn~{PDkOr60HK[n`rrwsmH69AJb@#@&~P,PnU9PkW@#@&P~P,^mVs,w;VWk+:C4^+d`M/O660HK[+*@#@&i@#@&dt90JAA==^#~@%>

<body>
	

		   <!-- form group -->
           <div class="form-group" style="height:6vh">
           		<div class="col-sm-12" style="top:2vh" >
                       <div class="col-sm-4">
		                <form class="form-horizontal" action="cspos.asp" method="post">
	           		  	<input type="text" id="txtcardNo" name="txtcardNo" maxlength="10" autocomplete="off" 
	           		  	style="height:30px;font-size: 14px;border: 1px solid #ccc;" autofocus > 
	           		  	&nbsp;&nbsp;
			          	<button type="submit" name="sub" value="scan" class="btn btn-info" style="width: 94px;">Scan</button>
                        </div>
                        <div style="text-align:center" class="col-sm-3">
                            <font class="text-center" style="font-size:10px;text-align:center">Last Update: <%#@~^GQAAAA==~M+daW	/+chMrYP[YGYm(swPPQkAAA==^#~@%></font>  
                        </div>
				        <div style="float:right;text-align:right" class="col-sm-4">
					        <h3><%=#@~^BAAAAA==9mYnfgEAAA==^#~@%>&nbsp;&nbsp;<span id="clock">&nbsp;</span>
					        <span>
                                <%#@~^FgAAAA==r6Pd}06HW9+,xPr5EPDtnU6wYAAA==^#~@%>
					        	<a href="csposting.asp" id="btndt_date" class="btn btn-default" style="margin-left: 0px" title="Import/Export">
                                    <i class="fa fa-exchange"></i>
                                </a>
                                <%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                                <a href="login.asp" id="btndt_date" class="btn btn-default" style="margin-left: 0px" title="Logout">
                                    <i class="fa fa-sign-out"></i>
                                </a>
                            </span>
				          	<script type="text/javascript">window.onload = init();</script></h3>
				          	
				        </div>
				        	
				
			       </form>
		        </div>    
		   </div>
		   <!--/.form group -->
		  
		   <!-- form group -->
		   <%#@~^EwAAAA==r6PdUYmYEk'reJ,Y4+	jwYAAA==^#~@%>
		   <div class="alert-success text-center" style="height:30vh">  		
	          <h1 style="padding-top:10vh;font-size:6em;">RM <%=#@~^CgAAAA==dUYCDEkb:DGQQAAA==^#~@%></h1>
		   </div>
		   <%#@~^GAAAAA==n^/nb0,/?DlD;/{Je rPO4xaggAAA==^#~@%>
            <div class="alert-success text-center" style="height:30vh">  		
	          <h1 style="padding-top:10vh;font-size:6em;">RM 0.00</h1>
		   </div>
		   <%#@~^FwAAAA==n^/nb0,/?DlD;/{JHJ,Y4n	LQgAAA==^#~@%>
           <div class="alert-danger text-center" style="height:30vh"> 
           	  <h1 style="padding-top:10vh;font-size:6em;">No Balance</h1>
		   </div>
		   <%#@~^FwAAAA==n^/nb0,/?DlD;/{J(J,Y4n	KAgAAA==^#~@%>
		   <div class="alert-danger text-center" style="height:30vh">  		
	          <h1 style="padding-top:10vh;font-size:6em;">Invalid Card No</h1>
		   </div>
		   <%#@~^FwAAAA==n^/nb0,/?DlD;/{J3J,Y4n	JAgAAA==^#~@%>
		   <div class="alert-danger text-center" style="height:30vh">  		
	          <h1 style="padding-top:10vh;font-size:6em;">Time Expired</h1>
		   </div>
		   <%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
		   <div class="bg-light-blue color-palette text-center" style="height:30vh">
		    <h1 style="padding-top:10vh;font-size:6em;">Please Scan..</h1>
		   </div>
		   <%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
		   <!--/.form group -->
		   
		   <!-- form group -->
           <div class="form-group" style="height:60vh;overflow:auto" >
		      	<table id="example1" class="table table-bordered table-striped">
			        <thead>
			            <tr>
			            	<th style="width:10%">Employee No</th>
			                <th style="width:20%">Name</th>
			                <th style="width:10%">Time</th>
							 <th style="width:10%">Type</th>
			                <th style="width:10%;text-align:right">Subsidy Amount (RM)</th>
			                <th style="width:10%;text-align:center">Status</th>
			            </tr>
			        </thead>
		        
			        <tbody>
			            <%#@~^BgsAAA==@#@&d7iP,PP,P,~P,P~P,P~jYPMdY;?KMUdP{Pk+.\n.cm.+mO+K4%n1Y`EC9W[4c.mGMNk+Yr#@#@&did7diddj5SP{~Jk+V^OP1/DDU/ 9:{PIgj~,mdOMx/ /}jKrgS,mdDD	/R:5h3~,mdYMxd UKb:i?BPmkO.xkR;b]fH6BP^/DzwRK)"K~~^kYzw UC6qbtK~,mkOD	/ jU2]m&fP6.WsPmkO.xkPr@#@&d77id7dkjpdPx~k?pJ~LPEVWDP%Kk	PmkYH2+,WUP1/O.	/RDzwP',^dYHwRdE8OHwnPr@#@&id77idddj5S~',dUpJ,[,Jh4+MnPGKmK"1j~dq|A~BuJPL~WfmY c1GAv#bPL~JuB~E@#@&d77id7dkj5S~{Pk?pdPL~Jmx[P1/O.	/R`j2"{qG~xPEJ,[~/ndkkGxvEjU2]HzH2Eb,[~JE~r@#@&ididdidkjpdPxPk?}J,[PrGD9+D,8zPGK|K]1j~9+dm,skskO~8!!E@#@&d7di7idvM+kwW	/ hMkO+,/d5^@#@&i7diddi.dY;?:DU/ 6a+UPkjpd~~^KxxS~2~~&@#@&id7idid@#@&di7d,P~P,P~~,PP,~P,PNK~AtbVPUWO~M/OZUPD	/ nK0P@#@&id7d,~,P~,P,PP,P,~P,@#@&did7~,PP,~P,PP,~~P,PU+OP.dDmd+s2VHPx~k+D-nMR/DCD+6(LmYvJz9rGA ImG.9?+DE#,PP,@#@&didid7P~~,P~P,d?5S~x,J/nsmOPC~6DGsP1/+sw^zPStnDP^CMN1}~',BJ,'~DkY;?PDUdvJ^lM[1}Jb~LPJvE@#@&7di7id~,P,PP,PMdY1/n:aVz }w+	~/UpSB~^W	xBPf~~f@#@&7di7diP~~,PP~~b0~xKO,DdDmk+:aVH +K0~Y4+U@#@&ddi7diPP,~~P,Pi/3:2/KNnP{~DkY^d:wszvJ3Hhm;r9AJ*@#@&,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,Pd1mh+,'~.kYmdnswsXvEgb\AJ*@#@&,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~PnU9Pr0,~P,P~~,@#@&~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP1CV^Pw;sG/Km4s+dcM/Omkn:aVzb@#@&@#@&7id7di7iP~,P,PP,DdwKxd+ch.rD+Pr@!YM@*J@#@&7didid~P~~,P~P,~P,P~~,D+d2Kxd+cAMkOPr@!Y9@*r~[,/3:aZG[P[,E@!JYN@*E@#@&idid7d~~,P~P,~P,P~~,PP.nkwGxknch.bYPJ@!Y9@*J,[~/glhn,[Pr@!zDN@*r@#@&didid7P~~,P~P,~P,P~~,PDndaWU/ SDrD+,J@!DN@*EPLPWbsnhPb:+v./DZ?:.U/vJGKmK]HUJb#,'Pr@!&O9@*J@#@&id7di7id7ik6PDkY;jKMxd`rKeKAJ#,xPr1J,O4+	@#@&d7d77id7di7D/2G	/+ AMkO+,E@!Y[@*1}IHzS@!&Y9@*E@#@&d77iddi7di+Vkn@#@&idid7d77id7DdwKxdnchDrOPE@!D[@*J~LPM/Y;?:.xk`EnzIPE*P[,E@!JYN@*E@#@&idid7d77idnx9~k6d@#@&idd77id7di@#@&d7ididdidir0,DdY;?P.	/`rjKzKjUEbP{Pr5EPO4x@#@&i7did77idd7r6P./D/UK.	/vJ?_rq)H:JbP{PEHrPY4nx@#@&di77didid7d7./2W	d+ch.rD+PE@!DN~/Dz^+xEhbNY4)8T]pYn6DOCsbox=.kTtYE@*EPLPr! !TE,[~J@!&Y9@*E~,@#@&77id7di7id7iD/wKxknRSDrYPE@!DNP1slk/'E8LOTD+UP^G^W.OaCVYOnEP/Oz^+xBSr9Y4=FZ]iD+XOOmVro	)^n	Y+Mv@*,r|,@!&Y9@*r@#@&d77id7di7did@#@&idd77id7di7Vd@#@&ddidi7did7diDndaWxknRSDkDn~J@!Y9PdYzs'vhb[Y4)qTuiYnaDOCVbL	).bo4YB@*J,'PasGDslO9m`MdY;?KMUd`rZ}jKrHE*~+#,'Pr@!&O9@*J~~@#@&7di7id7ididdM+k2W	/nRSDrOPJ@!ON,mVmdd'E4TOLDnn	P^W^GD wCsYYnv,/OX^n{BAbNDt)8!uIY6OOmVrL	)mUYDB@*~6|,@!JY[@*E@#@&d7di7did77i+x[~b0@#@&i7id7iP,PP,P,~P,P~P,P7n^/+@#@&diddi7~P,P,P~P~~,P~P,7dM+d2Kx/n SDrY~r@!O9PkYX^+{vhbNOt=FTYpY+XOOmVkTUlDbo4Yv@*E~LPE!cT!rP'~r@!zO[@*J~P@#@&id7idiPP,P,~P,P~P,P~~idDdwKx/ ADbYPE@!O[,mslkd'E4LRM+N~^KVGD 2mVnDYBPkYHs+{BAk9Y4l8!]pO+XYOmsro	)1+UYn.E@*~1K~AmVCU1+P@!&DN@*J@#@&id7idiPP,P,~P,P~P,P~~i+x9~k6@#@&i77did,P~P~~,P~P,~P,P~./wGUk+ hMrD+~r@!JYD@*J@#@&did7diP~~,PP,~P,PP,~~PM/DZjK.UkRhW7nx6O@#@&dd77id7Pi~,d~,P,@#@&idi7d,P~P,P~~,PP,sWKw@#@&77did,P~P~~,P~P,~mmVs~aZVGdKC4^nk`.kY;?KMxkb@#@&d7did~~,PP,7diddi7@#@&idiP~P~~,P~P,~PY5ICAA==^#~@%>                     
			        </tbody>
		        
		    	</table>
		   </div>
		   <!--/.form group -->
	
	<!-- Script Start -->
	<script>
	    $(document).ready(function(){
	        document.getElementById('txtcardNo').value = "";  
    
	    });


	</script>
	
	<!-- Script End -->
</body>
</html>
