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


<%#@~^FwEAAA==@#@&@#@&9YwDfmY~',Dn;!+dOvJNDoDGlYEb@#@&NDKGfCOPxPMn;!+dOvJNOPKfCYE*@#@&k2swZKN~',Dn;!+dOvJYXO2swZK[nJ*@#@&//WdO&N~',.+$EndD`JOaDZG/D(9Jb@#@&k?Ea{;GNPxPM+5;/YvEYXY?!2mZKNJb@#@&dzDnl;GNPx~M+;;nkYcJDaDb.l;WNJ*@#@&knCoA.nm3P{~D;EdO`rm(WKlLn~Dnl0E#@#@&dKmo+~x,F@#@&@#@&L1IAAA==^#~@%>


<%#@~^iwwAAA==@#@&w.b\mY+,/!8PalL+_+C[D`*@#@&@#@&dMndwKxk+ h.rD+~J@!Ol(Vn~1+Vsjal^k	L{!~1+^VwmN9rxT'TPSk[O4'%ZTP@*J@#@&77D/aWU/n SDrY~J@!Y.@*r@#@&77iDn/aG	/nchMkYPr@!Y9PAk9Y4x8!!,CVbox{sn0D@*,P]+2GMY~),PDmxd2KDY~Jb/Ok	L,InaWMY@!JY9@*J@#@&7diDndaWxknRSDkDn~J@!Y9PAk[O4'f!Z~l^kLU{m+UOD@*@!UP"rHVPkYX^+{v0KxOOS+rL4Y),*!ZB@*}P~K"bg?Kr]PzK(rg~?I?P3t@!zjP"rHM@*@!JY[@*J@#@&didMn/aWU/RA.bY+,E@!DNPSr[Y4'R!~lsrTxxDbLtD@*9CD+Pl~r[~0GCD+JKxT`1Khvb#,[E@!JY[@*r@#@&i7D/wKUd+chMkO+~E@!zOD@*E@#@&d7@#@&dd.nkwGxknch.bYPJ@!YM@*J@#@&7diDndaWxknRSDkDn~J@!Y9PAk[O4'X!,CVboUx^+0O@*hlL+,l,J',/hloPLE@!JY[@*r@#@&7idDdwKx/ ADbYPE@!O[,lskTU'1+UOD@*@!j:I61V~kYz^+{B0KxDRhkLtD)~*Z!B@*EPLP/ddkKxvJ/rH)t2E#,'Pr@!&j:IrH!@*@!&Y9@*r@#@&idiD+kwKU/RADbYn~r@!Y9~l^ko	x.kTtD@*~KrhPlPr'Pm:2h:k:ncgWA`*b,[E@!zDN@*r@#@&7dM+dwKxdnchDbO+,J@!JO.@*r@#@&d7DndaWU/ hMkOn,J@!O.@*J@#@&i7iDnkwKx/RS.kD+~J@!Y[~mVkTU'^+0D~8o1W^W.'vA4kO+E~hbNO4{ *T@*@!zON@*E@#@&7idM+/aW	d+ch.kD+~E@!YN,CVbox{^nxD+MP8o^G^W.'EAtbYnv@*@!zO[@*J@#@&i7iDnkwKx/RS.kD+~J@!Y[~mVkTU'Mko4O~4TmKVGDxvStrYvPSk[O4' XT@*@!&Y9@*r@#@&idM+/aW	d+ch.kD+~E@!zYM@*J@#@&dMndwKxk+ h.rD+~J@!&Ym4sn@*J@#@&7@#@&7DdaWUk+chDbY~J@!YC4^+~^VVU2l1kxTxTP1+^V2l[[bxL'Z~hbNO4{%!T~1VC/kxE0G	YMwY9+DCk^B~@*r@#@&7idd@#@&didDd2W	/RADrOPE@!D.@*r@#@&7idDndaWU/ SDrD+,J@!DN,^W^/2l	'{~mVkTU'^+0D~8o1W^W.'vA4kO+E@*J@#@&77idDndaWU/ SDrD+,J@!4D,^Vm/d'E/r[BPkry'F,UG/4l9+~/Oz^+xBsCDTkURDWwl~8!26phmDLbx 4WDYKh),!26pB@*E@#@&di7D/wKUd+chMkO+~E@!zON@*E@#@&d77M+/2G	/nRS.bYn,J@!zYM@*r7@#@&d7dM+d2Kx/ hMkY~E@!DD@*J@#@&77iDn/aGxk+ AMkYn~r@!ON,AbNO4'8!@*:k1V+DPHW@!zO[@*J@#@&7diD+k2Gxk+ch.kOn,J@!Y9~hbNO4{F!@*9mYn@!JO9@*E@#@&iddM+k2W	/nRSDrOPJ@!ON,hk9O4'8!@*?4kWO@!zON@*E@#@&d77M+/2G	/nRS.bYn,J@!YN,hb[Y4'q!@*2h2^WXnP;WN@!&Y9@*r@#@&d77M+dwKU/RA.bY+~E@!Y[PSr9Y4{%Z@*2sw^GX+~1m:n@!JYN@*E@#@&ddi.n/aW	/nRA.bYnPr@!Y9PAr9Ytx+Z@*)DC,ZG9+@!zY9@*r@#@&id7D/2G	/+cADbY+,E@!Y9PmVroUxMkLtD~hbNO4{ !@*j!wnD7rkW.,1m:+@!zD[@*r@#@&diDndaWxknRSDkDn~J@!zDD@*J@#@&id.+k2W	/n SDkOn,J@!YM@*r@#@&idiD+kwKU/RADbYn~r@!Y9~mKV/aCU'FPmVroUx^+WY,8o1WsGM'BA4bYnB@*E@#@&7idiD+kwKU/RADbYn~r@!tM~/by+{q~xK/4l[+~dDXs+{v:mDLr	OYG2=PTwXIsl.Tk	O4KYDG:=PTwXB@*E@#@&di7D/wKUd+chMkO+~E@!zON@*E@#@&d7./wGUk+ hMrD+~r@!JYD@*J@#@&di@#@&dEDndaWxknRSDkDn~J@!zDl8Vn@*r@#@&di@#@&iB.nkwWUdRADbOPE@!Ym4VP1nV^?2l1kUL{!P1nV^wl9[rxT'ZPAk[O4'0!Z~m^ldd{B0GUDD2Y9nDlr^B@*J@#@&d@#@&dM+dwKxdnchDbO+,J@!D.@*J@#@&id.+d2Kxd+cADbYn~r@!Y[~1Ws/aC	'{@*J@#@&diDdwKxd+ch.rD+ProDK:PGCO+,),J'P[OwD9lDnPLJ~~:WPE',NOKK9mYn,[rP[	4k2iLx8/ai'U(/wp'x(/wp'U4kwp[U4d2p[U4k2ir@#@&7iD+d2Kxd+cAMkOPr@!4Mz@*E@#@&d7D/2G	/+cADbY+,E3:aVKXn+~/KNnP=~JLPd3swZG[P'J,'	4daiLx4kwp'x(/2iLx8dai[	8/ai[	8dwp[	4dwIE@#@&7dMn/aWUdRh.rD+~J;GkY~;+	Y+MP=~JLPdZK/O(GP[r~[	4/aI'x(/ai'x8dai'x(dwp[U8kwi'U(/2iLU(/2pJ@#@&diDdwKxd+ch.rD+Pr)DlP;G[+,),J'Pd)M+CZK[+,[E~Lx4d2p[U4k2p[U(/ai[	4k2iLx8/ai'U(/wp'x(/wpE@#@&idM+dwGUk+ hMrYPEj!w+.rKD~),ELPdUEa{ZKN~[rP'x(/2ILx4k2iLx4k2I[	4kwI[U8kwI[	8/ai'U(/wIE@#@&7dMnkwG	/RhMkDnPr@!8DJ@*E@#@&ddMn/aWxkn hMkD+~J@!8Mz@*J@#@&diDndaWxdnch.kDn,J@!JY9@*J@#@&i.+kwGxk+ AMkY~J@!zYM@*E@#@&di@#@&dv./2W	d+ch.rD+PE@!JYC4^n@*J@#@&dED+kwKU/RADbYn~r@!Ym8VPmss?al1kUoxT,mnV^2l9NrUT'!~AbNOt{0Z!~1Vm//{B6GxDD2Y9+OCbVB,dYHV+{vOl(VOslzG!YlP6r6NIv@*J@#@&n	N~/!8@#@&aaIDAA==^#~@%>


</head>
<body>
<center>
<%#@~^IwAAAA==@#@&@#@&,mmVV,wmL+_+CNDcb@#@&P@#@&jwYAAA==^#~@%>

<%#@~^RA8AAA==7@#@&jY,D/DKUPD	/~',/n.7+Dc/DlY68LmD`Eb96GA I^WMNjnDJ#~~,P@#@&EdUpJ,',J/V^Y,YdYMxd GK{:]1U~PDdOD	/8R3HKm;r92B~YkY.UkR?u(wKSPDdDDUkR;I2zKAmqG~~Yk+h2^XRz]2zZrG3SPD::2Vz gb\2BO::2sHRZ6j:{(f,WMWh,YkYD	/,E@#@&Bd?5S~x,/?5JPLPJ,sn0DPNWrx~OkY.xk~W	POdDDxd AHK{;6G2~{PD/YMxkqRAHKZ}f3~r@#@&Ed?5SP{~d?5S,[~Jsn6Y~LKrx,YhnswVz~Kx~YkOMxdc2tn{;rG3P{PO::2sHR2tK{;rfA~E@#@&Bk?}S~x,/jpd~[,Jsn6YP%Gbx~YknswsHPKxPD/D.xkR3Hh{/6G2P{~Yk+:aszRAHh{/r93,J@#@&Ed?5S~x,/?}J,[~JS4Dn,H&f`D/D.xkR9K|K]HU~FBq!*PAAP	2A1,BEP'~tk[`6[lD+Ors+ c[Ds.fmO#S8~8!#,[,EB,bHf,BE~LPHb[`6NlDnOks+y`[YPGGlO+*SFBFTb,[PEv,J@#@&@#@&k?}dP{PJk+^nmDPO/DDUdcKq;F2:{1}S~YkYMxdR9P|K]1USPD/O.	/Rju&sP~,OkY.	/8R2tn|/rG2SPD:nhaVXcHbt2~,Oh+sw^X b]3zZ6fASYs+h2^XR/6UKmqGS,Yh:aVXc?`K{;r92,0.GsPYkOD	/Pr@#@&/UpdPxPdj5S~[,EV0O~NWkU~D/OD	d8PG	PD/YMxk K&ZF2:{H6,'PDdYMx/8 Pq;|AKm16~r@#@&/U}S,'~dUpS~',Js+6O,LGbx,Y::asX,WUPD/O.	/Fc3Hh{Z}93P{PD:n:2sHR3HhmZ}f3~r@#@&dj5S~',dUpJ,[,Jh4+MnPtq9`D/O.	/RGP{:I1USq~8!*P$2P	A2HPEEPLP\r9`0[CD+Oksny`[DsMflD+*SFBFT#,[~EEPbg9PEJPL~\k9`6NCYnOb:n v[Y:W9CD+#SqBFT#,',Jv,Jiddidi7@#@&@#@&k6Pd3swZK[+,@!@*,EEPDtx@#@&7dUpJP{~/UpJ~LPJ)HGPO/D.	/ ;IAbKA{&9P{BEPLP2]:q1vd2swZK[n#,[,JvJ@#@&x[PbW@#@&d77@#@&kW~kZG/D(GP@!@*PrJPDtU@#@&dd?5S~x,/?5JPLPJzH9PD::2Vz ;rjK|(f,'vE,[P2]:qH`k/K/O&f*P[,JEE@#@&+UN,kW@#@&@#@&bWPkbDC/W9+,@!@*PEE,Y4+	@#@&i/j}dP'~dUpJPL~rbHGPzI2zZ}92,'vJ,[~2"Kqgc/zD+m/GN#,[~JvE@#@&nx9~k6@#@&@#@&k0~dUE2{;G9+~@!@*,JJ,Y4nx@#@&7/UpJ~{P/U}S,[Pr)Hf,?`nmZ69APxBr~[,w]P&1`dj!wmZK[#~LPrBJ@#@&UN,kW@#@&@#@&dUpS,xPk?pd~'PrWMNnD~8HPPq;F2:{H6BP2\K|Z6fA~m/^,J@#@&DkY:jKMxdR}wnU,/?5J~,mW	USP2~,&@#@&rW,xGY,./DKjPMx/ nK0~Y4n	@#@&iDmWMN,xPZ@#@&dkn.n7Kk1V+D1W,x~DkY:?PDUdvJPq;F2:{H6r#@#@&7kn.+79DfCD+,'PM/DP?:DU/vJ9P|KIgjJ*@#@&idKD\Utr0O~{P./DP?:DUdvJ?u(wKE#@#@&i4KMk	YP{PD.E@#@&d@#@&7[KPh4rVPxKO~DkY:?PDUdc+G0@#@&d@#@&77k?E2Hm:nP{~rJ@#@&di@#@&idUnY,DdY:H3haZW9nP{P/.-+MR;DnlOn}4%+1O`rb96GAR]n1W.NUnDJb,@#@&ddk?5JP{PE/Vn^DP+s2{1WNS~xm:PWDGh,Yh+s2VHPE@#@&dddj5S~',dUpJ,[,JPSt.+,+hw|mG[P',vJ,[PMdOKUKMxd`Ej`nmZ}92r#~',JBE@#@&d7DkO:H3sw;WNR}2+	Pd?5SS~1Wx	SP2~P2@#@&dik6PUWO~M/OKt3:aZG[R+GW,Y4+	@#@&d7i/UEwglsnP{P./DK\3swZK[+vJ1z\3J*@#@&d7+U[,kW@#@&7di@#@&7ik0~.kYP?:.	/crK&Z|AK|Hrr#~@!@*PdKM+\:rm0+YgG~WMPM/OKjPMxd`rjC&sPE*P@!@*~kn.+7j4kWDPDt+	@#@&7diDnmKD[~{PD^WMNP3~q@#@&diddn.n7Krm0nYgW~x,D/OPUK.xkcrK(;|AK{grrb@#@&d7PiB~dhD+79YGlY~xPM/DKjK.Uk`Ef:mK"1jE*@#@&77,ddnMn7?4b0DP',DkOKUK.xk`Ej_qs:E#@#@&di~7D/aWU/n SDrY~J@!Y.~7lVrL	'OWa@*r@#@&idiD+kwKU/RADbYn~r@!Y9@*@!(D@*@!&ON@*J@#@&7d7./2W	d+ch.rD+PE@!JY.@*r@#@&d7iDmWMN,xPM+^WMN~Q, @#@&7d,d4h.rxDP{POD;n@#@&7dUN,kW@#@&dd@#@&id.+k2KxdRSDkD+,E@!DD@*J@#@&77b0P(KDbxY,x~YMEPOtnU@#@&7di.+kwGUk+RA.bYnPr@!DN@*rPLPDkY:jKMxd`rK(/n2K|Hrr#PL~E@!JY9@*E@#@&7id.+k2W	/n SDkOn,J@!Y9@*rP',DkYKUKMU/vJ9K|K]HUJ#,'Pr@!zD[@*J@#@&id7kW~M/OKUPD	/cEUCqoPr#~',EtJ~Dtx@#@&di7D/2W	/n SDkDnPr@!Y9@*\WMxbxL@!&O9@*E@#@&7di+sd@#@&77iDn/aG	/nchMkYPr@!Y9@*HkTtO@!JYN@*E@#@&ddinUN,k6@#@&d77(n.k	OP{PWC^/+@#@&idnVkn@#@&7idM+/aW	d+ch.kD+~E@!YN@*@!zDN@*r@#@&didM+dwGUk+ hMrYPE@!DN@*@!&DN@*J@#@&id7M+kwW	/ hMkO+,J@!O9@*@!JON@*J@#@&77+	N,kW@#@&7i@#@&di.+kwGUk+RA.bYnPr@!DN@*rPLPDkY:jKMxd`r2\K|ZrG3J*P[,E@!zDN@*J@#@&77M+dwKU/RA.bY+~E@!Y[@*r~LP.kY:?KMxkcJgb\2r#~',J@!JON@*J@#@&77D/aWU/n SDrY~J@!Y[@*rP[~.kYP?:.	/crb"2b;rG3J*P'Pr@!&O9@*J@#@&diD+k2Gxk+ch.kOn,J@!Y9~l^kLU{BDrL4Yv@*r~LPdUEa1ls+,'Pr@!&Y9@*E@#@&ddMn/aWxkn hMkD+~J@!&DD@*Ji7d@#@&7@#@&dDdO:?PD	dc:G7+	+6D@#@&7k6Pdnmon$M+l0~',J5r~Otx@#@&7d.n1W.N,xPM+^GMNPQ~8@#@&dir6P.mKDN,@*{~cyPCx9PUGDPDkOKUKD	d +K0,Y4+U@#@&d7@#@&7diDndaWxdnch.kDn,J@!JYm4V@*r@#@&id7DmG.9P',T@#@&ddi.n/aW	/nRA.bYnPr@!4Mz@*E@#@&d77M+dwKUk+ qDbY+,J;GxDkUEPHnXYPhCoRRcE~P,P@#@&7d7./2W	d+ch.rD+PE@!aPdYHs'valT+O(DC3 4n0KDnl,lVSCXkB@*@!&2@*r@#@&d7d.nkwGxknRSDrOPJ@!8Mz@*J@#@&id7knmo+,',dnmonP3Pq@#@&ddi^l^VPaCL+_+mNnDcb@#@&7dUN,kW@#@&d+U[,kWdi7id7@#@&iVWKwi@#@&id@#@&id77@#@&+	[Pb0@#@&^CV^PaZsWdn:l8Vd`M/OPUKDUd*@#@&d@#@&iDnkwKx/RS.kD+~J@!zOC(V+@*E@#@&WRIEAA==^#~@%>

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


