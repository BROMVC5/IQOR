<%@ LANGUAGE = VBScript.Encode %>
<!DOCTYPE html>
<html>
<head>
    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <meta http-equiv=Content-Type content='text/html; charset=utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Print Report</title>

    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
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
    <!-- REPORT CSS -->
    <!-- #include file="include/reportcss.asp" -->
    
<style type="text/css" media="print">
@page {
	
    margin-top: 3mm;
    margin-bottom: 0mm;
    margin-right: 10mm;
    margin-left: 10mm;
  

}
  html,body{
height:auto;
}

p.break { page-break-before: always; }

</style>

<%#@~^rQAAAA==@#@&@#@&k2swZKN~',Dn;!+dOvJYXO2swZK[nJ*@#@&//WdO&N~',.+$EndD`JOaDZG/D(9Jb@#@&k?Ea{;GNPxPM+5;/YvEYXY?!2mZ}fAJb@#@&dhlL+~.+m3~x,D+5;/O`r^(WKmoADl0E#@#@&dnmon~{PF@#@&@#@&MDEAAA==^#~@%>


<%#@~^OwoAAA==@#@&w.b\mY+,/!8PalL+_+C[D`*@#@&@#@&dMndwKxk+ h.rD+~J@!Ol(Vn~1+Vsjal^k	L{!~1+^VwmN9rxT'TPSk[O4'%ZTP@*J@#@&77D/aWU/n SDrY~J@!Y.@*r@#@&77iDn/aG	/nchMkYPr@!Y9PAk9Y4x8!!,CVbox{sn0D@*,P]+2GMY~),3:aVGz+PJrkYrxT~"+2KDD@!zDN@*E@#@&d7dM+d2Kx/ hMkY~E@!DN,hrNO4{&T!,CVboUx1+xOnM@*@!?:]}1!,/DXV'EWW	YRhkL4D)PWT!E@*r:~PIz1Un6IP):q61,j5UK3\@!z?P]}1!@*@!&DN@*r@#@&ddiDdwKxd+ch.rD+Pr@!Y9Phb[Ot{%ZPCVrL	'.kT4Y@*fCOP)~ELPWfmOSG	ov1WS`*bPLJ@!zDN@*E@#@&di.+kwW	dnRSDbYnPE@!JY.@*r@#@&id@#@&idDndaWU/ SDrD+,J@!DD@*E@#@&d7dM+d2Kx/ hMkY~E@!DN,hrNO4{*TPmskTxxs0Y@*KmonP=~r[~knmo+,[r@!zDN@*J@#@&77iD+k2W	/+cA.kD+,J@!Y[~mVro	xmxOnM@*@!jP"rHM,dDXs'E0W	Y A+bo4Y=P*TZB@*r~[,/+kdrW	`rZ61)\AJbPL~J@!zjP"r1!@*@!zON@*E@#@&7idM+/aW	d+ch.kD+~E@!YN,CVbox{.ro4Y@*PPkhn,)~JL~lswhPb:+cHKhc#*~LJ@!JY9@*J@#@&i7D/2W	/n SDkDnPr@!zD.@*J@#@&id.+d2Kxd+cADbYn~r@!Y.@*r@#@&di7M+daW	/+chMrYPE@!DN~C^ko	xV0Y,8LmKVKDxBA4bYnB,Ak9Y4xy*!@*@!JY[@*r@#@&d7iD/wKxknRSDrYPE@!DNPmskTx'1nUYD,4LmGsKDxBS4kD+v@*@!zY[@*r@#@&di7M+daW	/+chMrYPE@!DN~C^ko	xDbotD~8o1W^W.'vA4kO+E~hbNO4{ *T@*@!zON@*E@#@&7iD/wKxknRSDrYPE@!JYD@*E@#@&dDd2W	/RADrOPE@!JOl(Vn@*r@#@&7@#@&d.+k2KxdRSDkD+,E@!Dl8VP^n^V?aCmbxo{T~mV^wCN[r	ox!,Ak9Y4xR!!~@*r@#@&di7i@#@&idM+/aW	d+ch.kD+~E@!YD@*E@#@&ddi.n/aW	/nRA.bYnPr@!Y9P^G^/wCU{G~l^rTxx^+6YP(o1GVKDxBStrOB@*r@#@&iddi.n/aW	/nRA.bYnPr@!tMP^sm//xvkk[+E~kk"'8PxK/4CNPdYHVnxE:lMLk	OYK2lP8!a6I:C.TkUO(GYDWhl,!waIE@*E@#@&7id./aWxk+cADbYnPr@!&O9@*J@#@&didDd2W	/RADrOPE@!JOD@*J7@#@&dd7./2W	dRAMkD+Pr@!D.@*r@#@&did.nkwW	d+chDbOnPr@!DN~lsrTxxVWY,hr[Dt'vqy]v@*AhaVGH+PZKN@!zDN@*J@#@&77iD+k2W	/+cA.kD+,J@!Y[~mVro	xV0O~SkNO4{Bf!uv@*2haVKX+PgC:@!&Y9@*E@#@&ddi.+kwW	dnRSDbYnPE@!DN~l^ro	'sn6YPAr9Y4'EqZ]v@*bM+l,ZK[+@!zON@*J@#@&iddMn/aWxkn hMkD+~J@!O9PCVbLx{VnWDPhr[DtxByXuB@*zDl@!JY9@*J@#@&7diDndaWxknRSDkDn~J@!Y9PCVrL	'.kT4Y,hr[Dt'vfl]v@*U;a+.7kkWD,1mh+@!zON@*J@#@&idDdwKx/ ADbYPE@!&OM@*E@#@&7dM+d2Kx/n SDrY~r@!OM@*r@#@&idi.+kwGxk+ AMkY~J@!YN,^GVkwmxxG~C^kLx{s+6Y~8TmWsGM'vh4rD+v@*J@#@&didi.+kwGxk+ AMkY~J@!tD,dry'8PUWd4mNnPkOX^+xvslDLr	OOWal,!2XislDTk	R4KYOWs)~Ta6B@*E@#@&ddi.n/aW	/nRA.bYnPr@!zDN@*E@#@&d7./2W	dRAMkD+Pr@!JOD@*J@#@&id@#@&i@#@&i.+kwW	dnRSDbYnPE@!DD@*J@#@&diDndaWxdnch.kDn,J@!DN,mW^/aCx{G@*J@#@&77M+/aGxk+RS.rYPr2hwsGH+nP;GNPl~r[Pd3sw/W9n,[E,[	4/aiLU4kwI[	4d2p[x(dwp[x(d2iLx(/2i'U(/2ir@#@&id.nkwWUdRADbOPE;WkYP;+	O+MPlPr[~d;W/D(f,[J,'U4kwp[U4d2p[U4k2iLx8dai[U8kwI[	8kwILx(/wpJ@#@&diDn/aWUdRhMrYPJU;2+MkKD~)~ELPd?!2{;W[n,[J~'	4dwp'	4daiLx4kwp'x(/2iLx8dai[	8/ai[	8dwpJ@#@&7d.nkwGxknRSDrOPJ@!8Mz@*J@#@&id./aWxk+cADbYnPr@!8.J@*J@#@&diD+k2Gxk+ch.kOn,J@!zD[@*r@#@&7M+/2G	/nRS.bYn,J@!zYM@*r@#@&@#@&nx9Pd;(@#@&O+8CAA==^#~@%>


</head>
<body>
<center>
<%#@~^IwAAAA==@#@&@#@&,mmVV,wmL+_+CNDcb@#@&P@#@&jwYAAA==^#~@%>

<%#@~^DAgAAA==@#@&?nDPM/Y:?Ahw^X~',/n.7+Dc/DlY68LmD`Eb96GA I^WMNjnDJ#~~,P@#@&kj5S~{Pr/+^+1OPD:n:aVz AHn|/rG2~,Oh+sw^X b]3zZ6fASPD:nhaVX HzH3~,Okl.lcbIAbB~Ys+hw^X j`n{;6fA~PDhn:aVHR/rjP|q9P6.WsPOh:wsz,J@#@&kj5S~{Pk?pdPL~J^+WY,LGr	PYkCDlPKU~YklM+CR)]Ab/rG3P{POh:wszcb]2z/}f3,J@#@&/Upd~',/jpdP'~rPh4nDPYsnhw^Xcb]2)/}f3P@!@*PEB~E@#@&kW~k2hw;G9+~@!@*,JJ,Y4nx@#@&7/UpJ~{P/U}S,[Pr)Hf,Ys+hwszc2\n|/rG2~xEJP'~aIPqgck2haZKN+*PL~JEJ@#@&x[~b0@#@&@#@&b0Pk/G/DqGP@!@*~ErPOtU@#@&ddj5SPx~k?}S,',J)gf,Y::asXcZ6?:{(9,'Br~[,wI:(H`kZK/Oq9b,[~JE~J@#@&nU9PkW@#@&@#@&k6~k?;a{;WNP@!@*PrJ~Y4+U@#@&d/U}S,'Pkj}S,[,J)19~D:n:asXc?iK|Zr93,'vJ,',w]:qg`/UEamZKNn#,[~EEPJ@#@&+	NPbW@#@&idi@#@&/j}dPxPkjpdP'~rWD[nMP8X,Os+haVHRb"2z/rG2S2tnm/}f2,C/1PJ@#@&./DKU2hwszcr2+	~/UpJS,mWUUBPf~,f@#@&r6P	WY,DkOKU2hw^X nK0PD4+	@#@&i@#@&dM+1W.N~x,!@#@&i[W,h4r^+PUGDP./DPU2haVHR+K0@#@&d@#@&7dk?;2gl:~',JJ@#@&7d@#@&idj+O~M/OKt3:aZG[P'~dD-+M ;DnmYr4N+1O`rb9rGA ]mWM[?YJ*~@#@&idk?}S~x,Jd+^nmDPnha{mG[~~xmhPWMWsPYs+s2VHPE@#@&d7dUpS,xPk?pd~'PrPStnDn~:2{1GNPx~EJP'~M/OKU3swsH`r?jh{;6fAJbPLPEvr@#@&i7DkYKt3hw;W9+ r2n	Pd?5J~,mGU	~PfS,&@#@&i7b0~	WDPDkY:\2sw/W9+ nK0PD4+	@#@&i77/UEa1C:n~{P./DPHA:2/KN+cEgb\2rb@#@&7i+	NPb0@#@&d@#@&7dM+d2Kx/ hMkY~E@!DD,\CVrL	'OWa@*J@#@&77M+/2G	/nRS.bYn,J@!YN@*J,'PM/OKU2h2^X`r3Hh{Z}93J*PLPE@!&O9@*E@#@&7dM+d2Kx/n SDrY~r@!O9@*rP[,DkOKU2hw^XcEgbHAE#,[Pr@!&Y9@*r@#@&d7./2W	d+ch.rD+PE@!DN@*J,',DdDKU2:aVHcJzI3b;r93r#PL~J@!zY9@*E@#@&diDn/2G	/nRS.kD+~E@!YN@*E,[~DkO:?3sw^X`rb"3br#~[,J@!&DN@*r@#@&idDd2W	/RADrOPE@!D[PmVrL	'B.rTtOB@*E,[~k?!w1m:~[,J@!zDN@*E@#@&di.+kwW	dnRSDbYnPE@!JY.@*r@#@&id7@#@&dDdO:?3:asHRhK\x+XY@#@&db0~/hlLn~D+mVP{PJIE~Y4+	@#@&d7.mGD9~',Dn^KDN~Q,F@#@&i7b0~M+1WD9P@*xPW,~l	N~UKYPMdY:?2s2sXc+K0~Y4n	@#@&di@#@&id7./wGUk+ hMrD+~r@!JYl(V@*J@#@&7diDn^KDN,xPZ@#@&i77D/aWU/n SDrY~J@!4.&@*J@#@&7id.+k2KxdRqDkD+,EZKxOk	En~g+6D~nmo+c  J,P,P@#@&77iDn/aGxk+ AMkYn~r@!2PkOHVn{BaloO(.+m3R40G.)PmshmX/E@*@!za@*r@#@&d771lsV,2lT+unmN+.c*@#@&din	N~b0@#@&dx9~k6@#@&d^WG2id@#@&7mmVV,2/VK/KC4snk`./DP?A:2sH#@#@&7@#@&7DdaWUk+chDbY~J@!zOl(Vn@*r@#@&UN,k0@#@&@#@&@#@&XiUCAA==^#~@%>

<table cellSpacing=0 cellpadding=0 width=800 class="fontrptdetail">
	
	<tr>
		<td colspan=5><hr size=1 noshade style="margin-top: 0px;margin-bottom: 0px"></td>
	</tr>
	<tr>
		<td align=left>End of Report</td>
	</tr>
</table>
<%#@~^DgIAAA==@#@&0;	mDkW	PmhwsKr:`(U:k:b@#@&PP,~[ksP}EOCG;M~~ls2:@#@&~~,PP~~,kWP4G!Dc&x:k:#,@!P8 ~Y4+U@#@&PP,~P,PP,~~P}EDCGE.~{P4W!.`&xPrs+#@#@&,P~P,~,P~,P,l:a:,xPrb\J@#@&~~,PP,~PxN,rW@#@&P,P~P~~,kWP4GEM`(U:k:nb,'~Fy~Dtn	@#@&PP,P,~P,P~P,r;O_WEM~',tW!.cq	Kb:n#@#@&,P~P,~P,P~~,l:2h,'~Jh\r@#@&,P,PP,P,nx9Pr0@#@&~~,PP,~Pb0P4G;Dvq	Kr:nb,@*~Fy~Y4+U@#@&PP~~,P~P,~,P6!Y_WEMP{~tKE.`&xPrs+#,RP8 @#@&~~P,P,P~P~~,lhws~',JK\r@#@&~~,P~P,~x[,k6@#@&,P,~P,P~lswhPb:+,xPwWDsCOfmYKr:nc}EOCK;D,[~E=JP'~skUEDnvqUDks+#Bc*~[,J~J,[~Csw:@#@&dxN,W;x1YbWU@#@&jHsAAA==^#~@%>
</center>
</body>


</html>


