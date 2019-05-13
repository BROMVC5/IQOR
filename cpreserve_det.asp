<%@ LANGUAGE = VBScript.Encode %>
<!DOCTYPE html>
<html>
<head>
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
    <!-- Jquery 1.12.0 UI CSS -->
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-ui.css" />
	<!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    
	<style>
	textarea {
		resize: none;
	}
	</style>
	
    <%#@~^ES4AAA==@#@&P~,PkIs,',iZm/n`M+5;/YvEYXYIdnD7+wJb#@#@&i/Pk1V+D{HG,'P.n$En/DcrYaDKbm3Y|HWr#@#@&,P~~kHW9n?!4P{~.+$E/O`Ed!4E#@#@&P,P~dU+l.^4PxPMn$EnkYvJYXYUnlMm4J*@#@&~,PPbKlT+P{~]+$E/O`EKmonJ*@#@&i/3ha{q9~{Pd+kdbWUvJ`?2"1z\2r#@#@&,P~~kHlbUj"SP{~EmaD/nD-ncldwQE@#@&P~~,/b[[`IJP{~rYaD?lD1t{EPLPd+M\n.ctYss+	mW9nc/U+mD^tb~LPE[hCo'E~LPkKCT+~@#@&7i@#@&,P,Pk6Pk\W9+jE(P@!@*,JJ,Ptx@#@&~~P,P,P~@#@&7i/]+knD7+o~{PDn5wW.:vED6O"+k+D7+wE#@#@&7dkSGO|qf,xPM+;wG.:vJD6OSGO|pOXrb@#@&d7dA:wm(GPxPMn$sGM:vJYXYAhw|q9J*@#@&7i/Zm.{gWP{~.+$sKDh`EOXY/lMm1KJb@#@&ddd9Ds.fmOPx,D;sKDscJ9YoDGlOnr#@#@&7dkfY:G9lD+,'~Dn5wW.:vENDKG9mY+Eb@#@&7dkPb:n&x,'PM+$oWM:cJD6OPb:+&UJ*@#@&i7dKb:r;Y~x,Dn;wGDs`EOXYKrhr;Yrb@#@&7i/"+:mD0~',Dn;wW.hvJYXOI:lMVE#@#@&,P~P~~,P[YGr06Px~M+;oGM:cJ9OGkW6J*@#@&id@#@&dikWPkIndD\oP{PJr~Otx@#@&7d~~,P^l^sPmVn.D4WacrIn/.7+~wWMPmmx	GY,4nP:2OHJ#@#@&di+x9~r0@#@&id@#@&77b0~/;CD|1G~{PJE~Dtnx@#@&id~,P,ml^V,CVDO4K6cEj+tb^VP1K~^l	xKY~4n~:2YHE#@#@&77xN~r6@#@&di@#@&d7b0,/SKY|(f,'~JrPO4x@#@&7d,PP,^CV^PmVnDO8K6cJdGY,q9~1lxUGDP8+,nswOHJ*@#@&idUN,kW@#@&d7@#@&ddbWPk2:am(f,',JEPO4x@#@&i7P,P~^mVV~C^+.Y(GX`EA:aVWH+~ZKNnP1lUUKYP(nP:wDzE#@#@&idnx[~b0@#@&i7@#@&d7r6P/3ha{(f,@!@*PErPDt+	@#@&~P,P~P,P~~,P?OPM/Y"/JWDP{Pd+.-D ZMnlD+68N+mOcrb9rG$cIn1WMN?YrbP,P~@#@&P~~,PP,~P,PPkj}S,',Jd+sn1Y~e,WDK:~Os+:2sHPAt.P3tn|ZrG2,xBrP'Pk2h2|qf,'PrBJ,@#@&P,P,P~P~~,P~DkOI;SGOcrwnU,/jpdS,mG	xBP&BP2@#@&id7k6P.dDIZdGYc+W6~Otx@#@&~P~~,P~P,~P,P~~,mlss,ls+MO(WavJA:w^WHn+,ZGNPl~rP[,d2sw{&9~[,J,NG+d~	WOPakkY~Zr#@#@&7idnx9~b0@#@&P,PP,P,~P,P~w;VGdKl(s+k`DkO]ZdWD#@#@&~~,P~P,~+	N~r6@#@&@#@&idr0,dGYoMfmY+,',EJ,Y4+	@#@&7iPP,~mmVV,Cs+MY(Wa`EoMWhPGCYP^C	xWO~(+~+s2DXE*@#@&ddx9~k6@#@&di@#@&7ik0,dfDKWGCO+,',JEPO4x@#@&i7P,P~^mVV~C^+.Y(GX`E:W,flD+,^l	xGY,4n~:wDzJ*@#@&i7nx9Pb0@#@&77@#@&7dbWPkKrhqx~x,JEPD4x@#@&diPP,P1CV^PCVDO8K6`rPks+PbU~mmx	WOP8n,+hwDzJ*@#@&7i+x[~b0@#@&i7@#@&7ik6P/:ksnr!Y~',JE~Dt+	@#@&idP,~~mmV^PCVn.D4G6vEKb:n~KEY~^mxUWD~(+~:aYXr#@#@&di+UN,kW@#@&@#@&,~P,PP,~r0,/:kh+6;DP@!',dKb:n(	PY4n	@#@&P,~,P~,P,PP,mmsV,ls+MY8GX`J&U\mVk9~Pks+r#@#@&~~,P~P,~+	N~r6@#@&7~,P~@#@&~,P~,P,P/Y,./DZKnmY4~{P/.\DR;.nlD+}4%+^OvJ)f}9AcIn^KDNdnDJb@#@&~,P~,P,P/Upd~',Jd+^+^O,eP6.WsPma2CY4J@#@&~P~~,P~PMdY;nKCDtR62x~/U}d~~1W	x~,&B~&@#@&~P,P~~,Pk6~xKYPMdOZhnmY4RnG6POtU@#@&P~~,PP~~,P~P,~kZ;Dr60P{PMdY;nKlDtcEGK{;iKr#@#@&@#@&@#@&P,P~P~~,+UN,r0@#@&~~,PP~~,w/VKdKC(V/`M/D/nhlOt*@#@&~,PP,~P,PP,@#@&P,P,P~P~d;EOr6WP{PW9mY+Prs++`k/!Y660*@#@&,P,~P,P~ND?ns,'Pk9YwDfmOnPLPrPEP'~kKr:(x@#@&~~,PP~~,NO?s,'~6fmY+:ksn vNO?Vb@#@&PP,~P,PP9OHWSP{PWfCOKr:+`	WAc*#@#@&~,P~P,~,NOAx9P',fmO+zN[`rNESy~NmO+v##@#@&~P,P,P~P[OAx[P{~0GlOn:k:n+vNO2	[,[~rPZ!)Z!=T!r#@#@&@#@&~~,PP,~Pb0Pv[O1Kh,@*~//;DrW0*~l	N~c9Y?ns,@!~ND3	Nb,Y4+x@#@&,~P,P~P,P~~,PmmsV,lV.O4K6vJ]+dnM\CYbGx,0G.,ml.~al.3,rkPsKm0+NcPhs+m/nP1WUOmmY,j+	kWM~j+1EMkOX~660rm.J*@#@&~,PP~~,Pnx9~b0@#@&@#@&PP,P,~P,NOfb0W~{PfmO+Gk06cENr~kfOs.9mYn~k9Y:W9CD+#@#@&,P~P,~,Pr6P9Yfb06~@!,!~Y4+U~@#@&P,~P,PP,~~P,mmVsPCsDO4Ka`rqU-mVk[~GlO+rb@#@&~,P,PP,PUN,kW@#@&@#@&~,PP,~P,k0,d\W9+UE8Px~rE2J,Ptx@#@&,PP~~,P~P,~,@#@&,P,PP,P,~P,Pd?5S~x,Jjh9b:2P12.+k\,?3K~E,P~P,~P,P~~,P@#@&7idd?5J,'~k?5SPLPr]{gb\2,'~vrP[,2I:q1vd]+k+M\nsb~LPEBBE@#@&d77k?pJ~{Pd?5J,[~rS}K{5KI~',BEPLP2]:q1vdSKY{&9bPLPrBSJ@#@&id7/U}S,'~dUpS~',J3Hhm;r9AP{PBrPL~w"K(1v/3ha{qGbPLPJESE@#@&didd?}J,'~/U}S,[~E;bImH}PxPEE,[~aI:q1v/;CD|1G#,[~EE~J@#@&did/U}JP{Pk?}S~',J9{&HP{PvE,[P2]:qH`k9Ds.GlD+#,[,EBBJ@#@&id7dUpS,xPk?pd~'Prf|riK~x,BEPL~w"K(Hv/fOPKfCYb,[~rBBJ@#@&di7/UpJP{Pdj5SPL~J:{qg~xPEJ,[~w]P&1c/:r:qUb,[PEvBJ@#@&i7i/j5S,'Pk?5JPLPEK|riP,'PEEPLPw"P(1v/:kh+6;D#~[,EBBJ@#@&idddj5S~',dUpJ,[,JfzKAPqt2~',BE~LP0GCYYksn+`gWS`b#~',Jv~r@#@&id7dUpS~x,/jpd~LPE`?AI{&f,xPEJ~[,/ndkkW	cJ`?2"H)HAJ*P'PEvBJ@#@&i7dk?}J,'Pdj5S~[,E"2\zInP',Br~[,w]K&1cd"+:m.3*P[,EvJ@#@&,P~P~~,P~P,~/UpJ~{P/j}dP'Pr	_2]AP:qZn2:m1}PxPEJ~',/Kb^3Y{gG~[,JEJ@#@&~~,P~P,~P,P~^Kxx nX+^EDn,/j5S@#@&P,P,~P,P@#@&,P~~,PP,~P,PmmssP1W	0rDh$K6cJ`2NmYn~UEm^nk/WE^Zr~~kHmkx`Id'/zN[j"S'ELY6DPk13+DmHW{J,[~/Pr13nY|HW,[~Er#@#@&@#@&P~P,~,P~Vk+k6Pk\W9+jE(Px~r/l7nJ,KtU@#@&,P,P~P~~,P~P@#@&P,P~~,PP~~,Pd?5J,'~rk	/+MY,rxDW~maDnd7P`"m1zH2B~Jr:{5Ke~~3tnmZ}92BP/)"{16S,fmqgS,fm}j:~P:{&H~,Kmr`KS~GK{;]2zK2B~/IAb:2mq9S,I3Hz]|BP)KhIr#3*PE@#@&7iP~,Pk?pdP{~/UpJPLPE-mVEdPvJd@#@&7d,P,Pd?}J,'~/U}S,[~EEJP'~aIPqgckInk+M\+w#,'PrBSJ@#@&77i/?5JP{P/U}JPLPrBEP'~aIPqgc/dWOm&f#~',Jv~r@#@&d7i/UpS,',d?5S~[,JvE,[Pa]K&1`k3hw|qG#~[~EE~E@#@&7di/j}dP'~dUpJPL~rBE,[,wI:qgc/;l.{gWb~LPJESJ@#@&di7d?5S,'~/j}dP'PrvJ,[~2"KqHckfOsM9mYn*PLPJE~r@#@&id7/UpJ~{P/U}S,[PrvEPLPaIPqHckfOKK9lD+b~LPJvSr@#@&di7k?}dP{P/Upd~[,JvJ,[~2"Kqgc/:k:(U#,[,Jv~E@#@&d7dkjpdPx~k?pJ~LPEBr~LP2"K&1`kKbh+}EO#,[~EE~J@#@&did/U}JP{Pk?}S~',JvJ,'P6fCOYkhny`HWSc*#~LPrB~r@#@&7di/jpdPx~k?pd~[,JBr~'Pk+k/rWUcrjj2"Hbt2Eb,[PEvBJ~@#@&7iddUpdP',/U}S,[~JEJ~',wI:(1v/IhCD0#,[~JvSr@#@&P,~P,P~~,PP~dUpJP{~k?}dPLPJEnEE@#@&d7P,P~dUpS,xPk?pd~'Pr#,J@#@&77,P~P1Gx	RnamEOn,/jpd@#@&d7i@#@&ddi/U}S,'~JbxdnMYPbUYKPma.n/7y,`bP-C^En/,c#r@#@&7idmGU	Rn6^!Yn,/UpS@#@&@#@&P,P~P,P~~,PP@#@&did@#@&77dU+DP./O/hIn/7~',/n.7+D /M+CY6(Ln1YvJbGrG$R"+^WMNjnDJ#,~P,@#@&,~~P,P,P7/j}dPxPrd+^+^O,ePW.K:~ma./-,J@#@&P,P,~P,P7/UpJ~{P/U}S,[PrG.ND,4zP)i:r(1;~N/^~^k:rO,FE@#@&~,P~,P,PdM/D/n"+d\cr2n	P/U}SBPmKUU~,&BPf@#@&~,P~P,~PikW~	WY~.kY/n"nk\ W6PY4+	@#@&,P~P,P~~idN"nmKDNz;OW&x1PxP.dDZKId\vJ)i:rqH/r#@#@&,~,P~,P,d+	N,r0@#@&7di@#@&7id?OPM/Y;K]+k\,'~/n.7+.R;.+mYn6(L+^OvJ)f}9~R]mKDNU+DE#,P~P@#@&77,PP,d?5SP{~E/VmOPM~6DG:,^wM+d-.PJ~@#@&d7P,~,/j5S,'Pk?5JPLPEWMNn.,4X,)j:rqg/~N/1PskhrDPqJ@#@&diP~~,D/O/hIn/7 }wn	Pk?pd~,^W	xSP2~~f@#@&di~P,Pk6~UWDPM/OZK]/-RG0,Y4n	@#@&77,P~Pid&xrDkmVP{Pr/nr@#@&diP~~,dNz;YKqx1~xPM/DZKInd7`Eb`Pr&1/E*@#@&77,P~Pid:k^0+DP',/&UkDkCV,[~[zEYK(x1@#@&i7~P,Pi@#@&d77,P~PkjpdPx~rjn9):2~ma./-,?AKPrdi7P,P~@#@&d77i/?5JP{P/U}JPLPrK(ZF3:{Hr,xPEJ~',wIP(g`dKb^0+O*PLPJEJ@#@&did7/UpJ~{P/U}S,[Pr	u2"2,biK6(gZ~',vJ,[~["+mG.9b;YK(	m~LPrBJ@#@&i7dimGx	RnamEDnPk?pd@#@&diP,P~+U[,kW@#@&7d,P~~1lVs~aZsWkn:l8^+k`DkY;KI/-#@#@&77i@#@&i7dEOO RRO O ORORR ORO RO ORR OORR ORO R@#@&7iP,PPEO RO ORO ?3HGP2t)qdP?:)]K O ORORR OR@#@&~P,P~~,PP~~,BRO R OR O OO O RO ORO ORR OO RO OO R@#@&idi/nY~.kY/nhCY4Px~k+D-nMR/DCD+6(LmYvJz9rGA ImG.9/+DE#@#@&di7d?5S,'~Jdn^+^Y,MP6DGh,mw2CDt~J@#@&id7M/DZnhlD4RKwnx,/j}d~P1Gx	~P2S~&@#@&id7kW~	WOPMdY;nKCDtRnG6POtU@#@&7idi/C"P{~DkY/nhlO4vJC"mHz1J*@#@&didi/)mOr	o~',./DZKKmYtcEAHK{;6G2E*@#@&ddidkj+	N\lbV~x,D/D/nhlY4cE?A1GH)qJE*@#@&di7+	N~r6@#@&77imCV^~aZsK/Kl(Vd`M/OZhnCO4#@#@&7di@#@&i77/Y,DdY/KhlOt,xPk+.-DR/.lO+}8N+^D`rbf}f~ ImGD9/nOr#@#@&7di/?5J~',Jk+s+^O,m2wmOtcC]mtb1S^awCY4 AHK|Z}f2Bma2lDt ?A19\zqSB~mawlD4 f:{wI6HS~1w2lD4RGKmP}~YhnswsXc3tb(dP6DWsP12wmY4Pr@#@&7id/U}S,'Pkj}S,[,Js+WO,LGk	~Ys+h2^XPGU,m2wmO4Ru"{tb1,',O::2VHR3\h{Z}92,J@#@&77dM/DZKnCO4RGwUPk?}JBPmGU	~~&B~2@#@&idik0,xKOPM/OZhnCO4R+KWPDt+	@#@&didi/]+^nb\nD,xPM/O/hnlO4vJ3Hz(dJb@#@&iddiNDoDK:~',DdO;nnmOtvJf:moI}Hr#@#@&77id[Y:GP{P.dDZnKCDtcJGP|K6r#@#@&didUN,kW@#@&d771lV^~w;VWknPl(V/cDdO;nKlD4#@#@&~~,PP~~,P~P,7@#@&7idk+Y,DkOA"rKlDt~x,/+M-+MRZMnCYr(LnmOcrb9rG$R"+^GMN/nOr#@#@&i7i/j5S,'Pr/s+1Y~e,0.GsP4MGwmYt,E@#@&idiDdY$]}nCY4 Wa+U~k?pJS,mGx	S,&S,&@#@&didbWP	WOPM/O$"rnmOtc+W6~Otx@#@&7d77k?[+sCk^Px~M/Y$]}nCY4cr?9AHzqSr#@#@&did7/UN2A,'PMdY~IrhCOtvJUfKEb@#@&7di7/U:O2,'P.dDA]rhCDtcr?tKnr#@#@&did7/hW.O,'PMdY~IrhCOtvJhr]KEb@#@&7di7k6P.dDAI6KmY4`riU2jUSr#P{PrPJ,Y4+	@#@&7iddidjk+/ks~',J:D;+E@#@&d7dinVk+@#@&idd77kjd+kd^Px,JwlVk+r@#@&id7dx[~b0@#@&7di+x9~r0@#@&id7mCs^P2Z^G/KC8^+/c.kY$I}KmY4*@#@&ddi@#@&7di?nY,DdO:H2s2VHP',dnD7+MR/DnCD+64NnmD`E)Grf$ "+^WM[U+Or#,PP,@#@&7d,P~Pk?}J,'Prd+^+mD~Hbt2BP92KP|q9P6.WsPOh:wsz,J~@#@&7iP~,Pk?pdP{~/UpJPLPEA4+D~Ys+:aszRAHh{/r93,'~Br~[,/3ha{q9~LPEBr@#@&d7,P,PDkY:\2swsXcr2n	P/U}SBPmKUU~,&BPf@#@&7iP~P,r0,xGO,D/OPt2hw^zc+G6PDt+	@#@&7d,P~P,P~~k2:aHls+P{~./DKt2hwszvJHbt3J*P@#@&idd7dG+2Y&[,'~M/DKHA:asXvJ92hKm(GJ#@#@&diPP,~nx9Pb0@#@&77,P~P1CV^P2/^W/nPm4s+kcM/O:HA:w^X*@#@&id7@#@&d77b0Pkj+	NHmrsP{Pr5EPO4x@#@&i@#@&id77b0Pd]mnk7nMP@!@*PrJPDtU@#@&d7d@#@&77iddkjE(L+1O~',Jg+AP/CMwCD0~I/n.7lYrG	P]+$;/O,4HPJ,[,d2swmqGP'~rJ@#@&7diddAPzwP{PEZKE@#@&7di7d@#@&77iddd\/dP{~rZ6tnz15,),(p}I~Mdr$)dP?A].&Z2U~\bdbI?(b~jG1~A_9PrP'~r@!4.@*r@#@&di7iddt+k/P{Pk\+k/~[,JP(;|2:~1}P),E~[,/:k^3nO|1GPL~J@!4.@*r@#@&77id7/tnk/~{PkH+k/,'PrI3?AI#3,sr"~),JPL~dI/D-+o~LPE@!(.@*r@#@&7idd7dt+d/,x,/\/kP[,JA\ndre2AP/6G2P=~J,[Pk3hw|qGP'PE@!(D@*J@#@&did77kH+dd,'~/tnk/~LPr2HhS}e2APHbt2~l,JPL~/A:wgCh+,[,J@!4.@*r@#@&di7di/\nk/Px~kHn/k~LPEG2hbI:HAHK,)~J,[~dG+wD(N,[Pr@!8D@*J@#@&7d77i/\+kdP{Pd\//~',J#2_(;S3,1}P),J,'PkZCD|1G~LPJ@!8D@*J@#@&77didkHn/d~{PdHd/,[~EdrK~}!lUYbOHPl,J,[PkSKO{&f~[,J@!8M@*@!(.@*r@#@&i77diB,/\+dd,'~/tn/kP'~r@!l~4M+W'rE4YOa)Jzw1FO&k$W.z1w2n	N{9nYcl/a_O6DKbmV+OmgWxJ,'PkKr^0+YmHKP'PrEr@*/dq;|P_2"3P:r~bhn]6j2Pc R@!zl@*E@#@&idid7@#@&7id7dkjpdPx~rkxdnMY~k	OKP$"rtbqdPv3Hh{/rG2S]AZ2&#2"~?`$B2;KBZ61P3gKSKIK2Bjj3"{q9SGbP2:(t2S;IAbKA{&9~GKmZ"2)PA#Pr@#@&iddi7d?5S,'~/j}dP'Pr-l^End,`J@#@&id7didUpJ,',/?5S,'PrBEPLPdu"P[,EBBJdi@#@&dididd?}J,'~/U}S,[~EEJP'~kInmr7+.,[,JBBJ@#@&did7dk?}J,'PkjpdP[,EvJ,[,/jE8%mOPL~JE~E@#@&dd77i/jpd~{PdUpdP[,JEEPLPdH/d~LPJESJ@#@&di77dk?5S~'~dUpJPL~JEJ~',2Kz2P'PrvBJ@#@&diddi/U}S,'~/UpJ~LPJEEPLP/ddkKxvJi?3]gb\2rbPLPEvBJP@#@&id7didUpJ,',/?5S,'PrBEPLPW[mY+Dr: `gGA`*#,[~JvSr@#@&di7di/j}dP'~dUpJPL~rBE,[,/+k/bGxvJi?AIH)t2J*~[,JBBE~@#@&did7ddj5S~',d?5S~',JBE~LPWNmOYrs+y`1Khvb#,[~JEJ@#@&iddi7/UpS,x~/UpdP'PEb,J@#@&i7did^G	xRnam;Y~k?}dP@#@&didinx9Pr0@#@&77id@#@&7didk6~dImk-+.q,@!@*PrEPDtnU@#@&d77i@#@&di7iddUE(L+1Y,xPr1nh,ZC.alD0~I/+M-CYbW	P]+5;/OP(zPrP'~k2:2m&f~[,Er@#@&ididdAKH2+,'~J;nE@#@&ddi7d@#@&di77dkH/dPx~rZ6Hh)1IPl~&pr]~VS6AzJ,?3".&Z2UPt)Sz5jqzPj9gPA_9PrP[,E@!4M@*r@#@&d77iddHd/,'~dt+/d~LPEK&/n2P,1}P),J,'PkKrm0+OmgWPL~J@!4D@*E@#@&idid7/\nk/~',dH/d~LPJ]3U2].A~wr],),JPLPk]+k+.\s~',J@!(.@*r@#@&i77di/t+d/~x,/\+kdPLPE3tnS6eA2~Z}9APl,J,[Pk2s2{&f~[,J@!8M@*J@#@&diddid\+k/,'~/\nk/~[,E2tnJ6I22~HzH3P=~rP',/A:wglsnPLPE@!(D@*E@#@&di7di/HddP{PkHn/d~LPEfAKb"K\3gKPl~rP'Pk9wO&N,[Pr@!(.@*r@#@&did77kH+kdP{P/tnd/,[,J#2u(;S3Pg6P=PE~LP//CM{HW,',J@!(D@*J@#@&di7di/\+k/~x,/Hd/,[PrJ6K,p!lUYrOHPlPr~[,/JGD{q9~LPE@!(.@*@!8M@*r@#@&idi7dEPdH/d~{P/tn/kP[,E@!l,tM+W'EE4YOw=&zamq1Jk;G.Jm2wU9{[Ycl/agDaY:k^3YmHK'J,'PkKk1VnY|1KP'PEEr@*/S&/|,C3]APK6~znKI}#AP cR@!zl@*J@#@&did7d@#@&77iddkjpdP',Erxk+MY~kUOKP$I}\b&S~cAHnm/}f3~"3;2(j2"~?`Ax3Z:~/rgK3H:~KIK2Bj?A]mqG~GbP2P(t2SZ"3b:2m(G~fPm;I3b:3*PE@#@&iddidkjpdPxPk?}J,[Pr-l^E+k~cJ@#@&id7d7dUpJP{~/UpJ~LPJvE,[~/_],[~rBBJdi@#@&7did7/UpJ~{P/U}S,[PrvEPLPkInmnr7+.F,'PrBSE@#@&d77idd?5J,'~k?5SPLPrvJ,[~/UE8%mY,'PrB~r@#@&dididd?}J,'~/U}S,[~EEJP'~kHn/k~LPEE~r@#@&idi7dk?}S,'~dUpS,'PrBJ,'~2:Xa+~[~EE~E@#@&7did7dUpS~x,/jpd~LPEEJ,[Pk+kdkKxcJ`?3]gbHAE#,[PrvSJ,@#@&d7d77k?}S,xPk?}J,[PEvrP'P6[mYnDks+ v1KA`*#~[,JvSr@#@&i7did/U}JP{Pk?}S~',JvJ,'Pk+ddbWxcE`?3Ig)t2E*PLPJE~r~@#@&d7diddj5SP{~/UpS,'~JEJ,[~0[CD+Oksn v1GAv##~',JvJ@#@&id7idk?pdP{~/UpJPLPEb,J@#@&7didd1GUxc+X+^EOn,/jpd~@#@&d77i+x[~b0@#@&i7id7@#@&iddx9~k6@#@&P,P~~,PP,~P,BO RRO O ORORR ORO RO ORR OORR ORO R @#@&id,PP,B RO ORO Oj3gfPA\b&SPAH9O O ORORR O@#@&,~P,P~~,PP~~EORO R OR O OO O RO ORO ORR OO RO OO @#@&did@#@&7d~~,P^l^sP1WUWbD:$GX`E?m-Pj!m1+/k0!s"r~~/tlrU`ISLdb9Nj"J'JLYXYPk^VYm1KxJ,[~d:kmVnD{HW,',JE*P,PP@#@&@#@&P,P~P,P~~AxN,(0,@#@&,~~PAx9P(0@#@&,P~P,~P,P~@#@&PP~~U+OPMdDI/"+k+D7+{~/D-+MR/.lY64N+mDcEbGrGA In^KD[?OJ*P~~,@#@&~~,Pd?5J,'~r/V+1Y,MP6DG:,m2./\,AtD+,P(Zn2:{Hr~xEJ~[,dKbmVnD{1G~LPEBr~@#@&~,P,D/DI;]+k+.\R62xPkjpd~P1GUxBP2~~&@#@&,P~P,~P,kW~	WY~.kY]Z"nk+.7+c+W6PD4+	@#@&diddPbm3O{gWP{~./DI;In/n.7+cJ:(Zn2PmgrJb@#@&P~P,~,P~,P,P/"+knD7+oP{P.dDIZ"n/D\cEI|1zH3Jb@#@&d7dkJWD{(9,'P.dDI/IdD-`rSr:{5P5r#@#@&id7dA:w|(f,'PMdOI;I/nD-nvJ3HhmZ}f3E*@#@&77i//lMmgW~{PM/Y"Z"n/D-+vJ/)"{1}E#@#@&di7dfDsMfCYn~{P./D]Z"+dnM\+cEG{(1rb@#@&7idkfY:WGCYPxPM/O];I+knD7+`r9mr`Kr#@#@&77i/Pksnq	Px~M/Y]/"+d+M-`E:{&1J*@#@&7di/Pks+6;DP',./DIZ"nd+M\`EKm6`KE#@#@&didd]:l.V,'~DkO"Z]/D\`r]2tb]|r#@#@&,PP,~P,PP,~~/zwaDG\n~{P./D]Z"+dnM\+cEznKI}#AJb@#@&,PP,P,~Px[Pb0@#@&,PP,2Z^W/PC4^+k`./O];In/.\#@#@&i@#@&~~,P8ykLAA==^#~@%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left sICe column. contains the logo and sICebar -->
        <!-- #include file="include/sidebar_cp.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Carpark Reservation Detail</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="cpreserve_det.asp" method="post">
                            <input type="hidden" name="txtSearch" value='<%=#@~^BwAAAA==dU+CMm4yQIAAA==^#~@%>' />
                            <input type="hidden" name="Page" value='<%=#@~^BQAAAA==rhlL5gEAAA==^#~@%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=#@~^CAAAAA==dtlr	j"S6wIAAA==^#~@%><%=#@~^BwAAAA==dzN[`IdbwIAAA==^#~@%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
									<%#@~^GgAAAA==r6Pd:k13+D{gG@!@*PEJ,Y4n	PrwcAAA==^#~@%>
									<div class="form-group">
                                        <label class="col-sm-3 control-label" style="">Ticket No : </label>
                                        <div class="col-sm-3">
                                            <span class="mod-form-control"><%#@~^GwAAAA==~M+daW	/+chMrYPdKbmVnD{1K~GwoAAA==^#~@%> </span>
                                        </div>
                                    </div>
									<%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
										<div class="form-group" visibility: hidden></div>
									<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Reserve For : </label>
                                        <div class="col-sm-7">
											<input class="form-control" id="txtReserveF" name="txtReserveF" value="<%=#@~^CQAAAA==d"+dD7+slQMAAA==^#~@%>" maxlength="50"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Vehicle No : </label>
                                        <div class="col-sm-7">
											<input class="form-control" id="txtCar_No" name="txtCar_No" value="<%=#@~^BwAAAA==d;l.|1KpQIAAA==^#~@%>" maxlength="10"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Lot Quantity : </label>
                                        <div class="col-sm-3">
											<input class="form-control" id="txtLot_Qty" name="txtLot_Qty" value="<%=#@~^BwAAAA==ddWO|qGjgIAAA==^#~@%>" maxlength="2" style="text-align:right;"/>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Employee Code : </label>
                                        <div class="col-sm-3">
											<span class="mod-form-control"><%#@~^GAAAAA==~M+daW	/+chMrYPd2swm(GPqQgAAA==^#~@%> </span>
											<input type="hidden" id="txtEmp_ID" name="txtEmp_ID" value='<%=#@~^BwAAAA==dA:2|qGgQIAAA==^#~@%>' />
                                        </div>
                                    </div>
									<!--From Date-->
									<div class="form-group">
                                        <label class="col-sm-3 control-label">From Date : </label>
                                        <div id="div_dt_join" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtFrDate" name="dtFrDate" value="<%=#@~^CQAAAA==dGYoMfmY+YQMAAA==^#~@%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
										<label class="col-sm-2 control-label">To Date : </label>
                                        <div id="div_dt_join" class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                <input id="dtToDate" name="dtToDate" value="<%=#@~^CQAAAA==dGYPKfmY+bAMAAA==^#~@%>" type="text" class="form-control" date-picker>
                                                <span class="input-group-btn">
                                                    <a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
                                                        <i class="fa fa-calendar"></i>
                                                    </a>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
									<div class="form-group">
										<label class="col-sm-3 control-label">Time In : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                 <input id="txtTimeIn" name="txtTimeIn" value='<%=#@~^BwAAAA==d:khq	uQIAAA==^#~@%>' type="text" 
                                                     class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask onkeyup="sum();">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
										<label class="col-sm-2 control-label">Time Out : </label>
                                        <div class="col-sm-3 col-lg-3">
                                            <div class="input-group">
                                                 <input id="txtTimeOut" name="txtTimeOut" value='<%=#@~^CAAAAA==d:khr!YOgMAAA==^#~@%>' type="text" 
                                                     class="form-control" data-inputmask="'alias': 'hh:mm'" data-mask onkeyup="sum();">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-clock-o"></i>
                                                    </div>
                                             </div>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Remark : </label>
                                        <div class="col-sm-7">
											<textarea rows="4" cols="90" id="txtRemark" name="txtRemark" maxlength="50"><%=#@~^BwAAAA==d"+hmD01QIAAA==^#~@%></textarea>
                                        </div>
                                    </div>
									<div class="form-group" visibility: hidden>
                                        <label class="col-sm-3 control-label" style="">Ticket No : </label>
                                        <div class="col-sm-3">
                                            <input class="form-control" name="txtTicket_No" value="<%=#@~^HQAAAA==dD-DctYsVUmKNn`kKr^0+Y|HW*LAsAAA==^#~@%>" maxlength="10">
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%#@~^FwAAAA==r6P~kbawDK\~',JKJ,Y4n	PwcAAA==^#~@%>
                                        <a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=#@~^GwAAAA==dD-DctYsVUmKNn`kb22MW\biQoAAA==^#~@%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
                                        <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                    <%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
                                        <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
                                    <%#@~^BwAAAA==n	N~b0,RgIAAA==^#~@%>
                                 
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
                        </form>
                    </div>
                </div>
				<div class="modal fade bd-example-modal-lg" id="mymodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                            </div>
                            <div id="mycontent">
                                <!--- Content ---->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade in" id="modal-delcomp" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="exampleModalLabel"></h4>
                            </div>
                            <div class="modal-body">
                                <div id="del-content">
                                    <!--- Content ---->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- #include file="include/footer.asp" -->
    </div>
    <!-- ./wrapper -->

    <!-- JQuery 2.2.3 Compressed -->
    <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
    <!-- Bootstrap 3.3.6 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- Jquery 1.12.0 UI -->
    <script src="plugins/jQuery-ui/1.12.0/jquery-ui.js"></script>
    <!-- Jquery for autocomplete -->
    <script src="plugins/jQueryAutoComplete/jquery.ui.autocomplete.scroll.min.js"></script>
    <!-- SlimScroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="plugins/fastclick/fastclick.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- input-check -->
    <script src="plugins/Custom/input-check.js"></script>
	<!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
	<!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="plugins/colorpicker/bootstrap-colorpicker.min.js"></script>

	<script>
    $('#btndt_date').click(function () {
        $('#dtFrDate').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtToDate').datepicker("show");
    }); 
    
	$('#btndt_Joindate').click(function () {
        $('#dtJoinDate').datepicker("show");
    }); 
    
    $(function () {        
       $("[date-picker]").datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            })
    });
	
	$(function () {
	    //Date picker
	    $("[date-picker]").datepicker({
	        format: "dd/mm/yyyy",
	        autoclose: true,
	        })
	});
	
    </script>
	
	<script>
    $(function () {

        //Time mask
        $("[data-mask]").inputmask();
    
    });
    </script>
	
    <script>
        $('#modal-delcomp').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var work_id = button.data('work_id')
        var modal = $(this)
        modal.find('.modal-body input').val(work_id)
        showDelmodal(work_id)
    })

    function showDelmodal(str){
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
      	    document.getElementById("del-content").innerHTML = xhttp.responseText;
    	    }
  	    };
		
  	    xhttp.open("GET", "cpreserve_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtReserveF').focus();
    }); 
    </script>
	<script>
    function fOpen(pType,pFldName,pContent,pModal) {
        showDetails('page=1',pFldName,pType,pContent)
		$(pModal).modal('show');
	}

    function getValue(svalue, pFldName) {
        document.getElementById(pFldName).value = svalue;
        $('#mymodal').modal('hide');
    }
    
    function showDetails(str,pFldName,pType,pContent) {
        var xhttp;
  	
  	    xhttp = new XMLHttpRequest();
  	    xhttp.onreadystatechange = function() {
    	    if (xhttp.readyState == 4 && xhttp.status == 200) {
			  	document.getElementById(pContent).innerHTML = xhttp.responseText;
    	    }
  	    };

        if (pType=="EMP") { 
            var search = document.getElementById("txtSearch_emp");
		}
        
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
		
		if (pType=="EMP") {
	  	    xhttp.open("GET", "ajax/ax_view_empid.asp?"+str, true);
		}
  	    xhttp.send();
    }

	function timeToMins(time) {
      var b = time.split(':');
      return b[0]*60 + +b[1];
    }

    // Convert minutes to a time in format hh:mm
    // Returned value is in range 00  to 24 hrs
    function timeFromMins(mins) {
      function z(n){return (n<10? '0':'') + n;}
      var h = (mins/60 |0) % 24;
      var m = mins % 60;
      return z(h) + ':' + z(m);
    }

    // Add two times in hh:mm format
    function addTimes(t0, t1) {
      return timeFromMins(timeToMins(t0) + timeToMins(t1));
    }
	
	$(document).ready(function() {
		$("#txtLot_Qty").keydown(function (e) {
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
	
	$('#txtLot_Qty').keyup(function () {
		if (this.value != this.value.replace(/[^0-9\.]/g, '')) {
       this.value = this.value.replace(/[^0-9\.]/g, '');
		}
	});
    </script>
</body>
</html>
