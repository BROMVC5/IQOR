<%@ LANGUAGE = VBScript.Encode %>
<%#@~^IAAAAA==~U+.7+MR?1Db2Y:kh+KEO~{PFZT!Z!!,DwoAAA==^#~@%>
<!DOCTYPE html>
<html>

    <!-- #include file="include/connection.asp" -->
    <!-- #include file="include/proc.asp" -->
    <!-- #include file="include/option.asp" -->
    <!-- #include file="include/adovbs.inc" -->
    <!-- #include file="include/validate.asp" -->

    <head>

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
    <link rel="stylesheet" href="plugins/jQuery-ui/1.12.0/Css/jquery-autocomplete.css" />
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
    
<%#@~^2DMAAA==@#@&P~i/tWN?!8P{P.+$EndD`Jk;4r#@#@&~~dk?l.m4~{P.+$;+kYcED6YjnmD^trb@#@&~,P,knmo~',Dn;!+dOvJnmL+r#@#@&~~P,/tlrxi]dPxPrO/DDCUkwW.OcldwQE@#@&~,P,/b9N`]S,'~JD6OjlD14'rP[,dj+mD1t~[~ELnCoxJ,[~rhlon~@#@&7kz;DW(	m,'PM+$;+kYcJD6O)!YW&Umr#P,@#@&dkKbmV+O~{PODbh`M+5;/YcED6OKb^0+Or#*PP@#@&,~P@#@&~P,PrW,/HK[+UE4,@!@*PrJ,K4+U@#@&P~P,~P,P@#@&,PP~~,P~/U4b0O,',D+$sK.:vJ^4K?4r6YJ*@#@&,PP,~~P,NDfCYn~{P.+$oWM:cE9Yw9CD+E#@#@&,P~,P,PPkZKdY&f~',Dn5wWDscJD6Y;GdY&fr#@#@&~~,P~P,~@#@&P~~,PP~~b0~ND9mYn,',JJ,Y4nx,P~di@#@&7,PP,~P,dmmssPmVDO4GavJ9lDnP1lUUKYP8n,+hwDzr#@#@&d,PPi+	[Pb0@#@&iP~~i@#@&i~P,dPbW~/Utb0OPx~rJ~Y4nx,P~7i@#@&~~,P~P,7imC^V,lVDD8WX`E?4kWO,ml	UWDP4~n:aYHJb@#@&~,P7dUN,kW@#@&PP~7i@#@&dijY~M/DK?hlD4P{Pd+M\n.cZDCYr4Nn^YvJzf6f$ "+^WM[?YEb@#@&d7dUpJP{~r/n^+1YPCP6.WsPO/alO4,J@#@&7P,PPMdOKUnmY4R62x~/U}SBP^G	x~~fBPf@#@&7ikW,xKYPM/DP?hlOtc+GW,YtU@#@&ddid/EDr60~'~.kYP?hCY4`E9:{ZiPr#@#@&i7x[,k6@#@&ida/VK/nKm4snk`DkOKUnlD4b@#@&di@#@&d7d;EOr6WP{PW9mY+Prs++`k/!Y660*@#@&id9O?V~',NO9mY+,'PrPJ,'~Yb:`b@#@&7iNO?sP{PW9mY+Prs++`9OU+s*@#@&dd9YgGh,'~0GlOn:k:+`	Whvbb@#@&diNO2U[,'~fmO+zN[crNJSqBNCYc*#@#@&diNYAx9~',PWfmYnPb:+ycND2x9~'PrPZ!l!TlZ!E#@#@&diP@#@&idkW~9Yj+^~@*Pd;EDr06PmUN,NO?V~@!,NYAUN,WD,[O?V,@!~NOHKh~Y4nx@#@&77i?+O~M/OKU3XmnaY,'Pk+M-+MR/DlOn}4L^YvJbG69AcImGD[jYE#,~P,@#@&7,PP~~,P~/U}dPx,Jk+VmD~e,0.WsPOd6m2Y,J@#@&7~P,P,P~Pdj5S~',d?5S~',Jh4nM+~f:mA(/An:P',Br~[,09lD++c9YfmO+*P[,EvPmx9PjK)P`?~',vjEPE@#@&dP~~,P~P,.kYPU2Xm+aYc6wx~/UpJS,mW	U~,&~,f@#@&idikWP.dDKj2X^+aY nK0PO4x@#@&i7id^mV^Pl^+MO4K6cJGlOn,)Pr~[,NYGCO+,[,J~kd~^W^3[R,nsnm/+~^KxOl1O,C],b9:k	kkODmYGDr#@#@&iddUN,k0@#@&7dVk+@#@&77i?nY,./DKj3Xm+2O,'~/.7+.cZM+lD+}8LmO`rb96GAR"nmKDNUnOJ*P,P~@#@&7,P~P,~P,/j}dP'~Ek+s+1O,e~6DK:PD/amwOPr@#@&7,PP,~P,P/U}JP{Pk?}S~',JAt.+,fPmA(Z3K:PxPEE,[~6fmY+y`9OfmYn#,[~EEPl	[PUKb:ijP{PEAvPE@#@&d~P,~P,P~.kYKj3XmnwD }wn	Pk?pd~,^W	xSP2~~f@#@&di7k6PxKO~DkY:?36^naY +KWPDtnU@#@&d77i/$X`dD~{PM/Y:?AamwO`rZ]3zK2|(fr#@#@&77dimmVsPCsDO4Ka`rfCOP)~E,[~ND9mYn,[,JP(VK^3N~4HPE~LP/~zjk+D,'~JcJ*@#@&d77x[PbW@#@&d7n	NPrW@#@&~P,~@#@&~,P,PP,PbWPkHGN?;8,'Prdl7+J,P4+	@#@&P~P~~,P~@#@&~P,P~~,PddnDP./DPUnCDt,'Pk+M-+MR/DlOn}4L^YvJbG69AcImGD[dYE#@#@&diddj5SPx~r/nV^DPM,0MW:,Yk2lDt~J@#@&77iD/DP?hlY4 Gwx,/jpJS,mGx	SP2~~f@#@&d77b0~xKO,DdDKUnlDtcnW6POtx@#@&iddid?xNtCrV,',DdYPjhlOtvE?A19\zqSEb@#@&7din	N~b0@#@&did1CV^P2Z^Wdn:l4^n/vD/DPjnmY4#@#@&7~,d~P,~@#@&d~~iPP~~mD.P{~UwsbYvD+$EdYvJPWdAEbBJ~rb@#@&dP,7~P,P@#@&7P~7,P~PkjpdPx~rkxdnMY~k	OKPOkYMx/,`GP{:IH?BPju&sKB~J@#@&P,~~P,P,P~P~dUpJP{~/UpJ~LPJ/]AbP2|(G~~GK|ZIAb:3~,jj2"{(9BPfzP2:qHAb~J@#@&,P~P~~,P~P,~/UpJ~{P/j}dP'Pr-mV;/,`J@#@&i7P,P~/UpJ~{P/U}S,[PrvEPLP6fCYn+vNOfmO+*P'~rB~E@#@&d7P,~,/j5S,'Pk?5JPLPEBrP'~aIK&H`k?tbWO#,[,Jv~E7iP@#@&i7P,P~dUpS~x,/jpd~LPEEJ,[Pk+kdkKxcJ`?3]gbHAE#,[PrvSJ,@#@&d7P~~,/jpd~',/j}dP[~EEJ~[,WGlOYb:+y`gGhv#bPLPEvBJ@#@&7d,PP,djpdP{Pd?}J,[~JEEPLPdnk/kGUvJi?A]gb\AJ*P[,JESJ,@#@&diP~~,/?5JP{P/U}JPLPrBEP'~6fCYOks++cgWhcb*P'Prvr@#@&,P,PP,P,~P,Pd?5S~x,/?5JPLPJ*~E@#@&PiP~d~~,P^W	UR6n^!Y+~dUpJ@#@&7id@#@&did/Upd~',Jrxk+.O,kxDGPD/YMUdy,`*P-ls;/~`*E@#@&d771WxU 6nm!OPdUpd@#@&idi@#@&id7?Y~.kYKUPD	/b!OGP{Pk+.\n.cZ.+mO+}4%n1Y`E)Gr9Ac]mGMNU+Yr#,~P,@#@&P,P~~,PPid?5SP{~E/VmOPM~6DG:,O/DDUd,J@#@&~,P~P,~,ddUpdP',/U}S,[~JKD[nMP4H~b`Kr&H/P9+km~VrhbY~Fr@#@&,P~~,PP~7M/OKUPMxdzEDWR}wUPk?}SBP^G	x~,f~,&@#@&~~P,P,P~drW,xGY,./DKjPMx/);DW +KW,Y4x@#@&P,P,~P,P7d9In^KDNz;YKqx1~xPM/DKjK.Ukb;YKcJzjP6&1ZEb@#@&~P,~,P~,dxN,k6@#@&@#@&~P,P~~,PP,~PU+Y,.dY:k13nY~x,/nD7nDcZ.nmY+68N+^YvEzf6GAcI+1WM[?YE#,P~~@#@&di~P,P/U}JP{Pr/nVn^DPMP6.WsPOdDDxd",J~@#@&7iP~,Pk?pdP{~/UpJPLPEGMN+M~4HPb`P6qgZ,Nn/^~^khkD~Fr@#@&7iPP~~M/OKb^0+Ocra+x,/U}SBP^W	xS~2~P2@#@&idP,~~k6P	WOP.dDKrm0nYc+GW,YtnU@#@&7d,~,P7kq	kYbl^~',JP?r@#@&7iPP,~d9bEDG(x1P{P./OPbmV+DcJzjP6&1ZEb@#@&7d,~,P7kKbm3Y,xPkqUkDkCs,[P9)EDWq	^@#@&id,P~P7@#@&d7d,~P,/j}dP'~E`n9b:3,YdDD	/PU2:~Jid7P,P~@#@&ddi7/UpS,x~/UpdP'PEP&ZF2:m1}Px~EJP'~aIPqgckKr13Y#,[,EBr@#@&did7dUpS,xPk?pd~'Pr_2]2~)`K6qg/P{PvE,[P[]mGD9)!YG&x1P[,JEE@#@&d7dimGU	R+Xnm!Y+,djpd@#@&d7P~~,+UN,r0@#@&77,PP~^mVsPa/^WdKm4V/v./DKrm0+Ob@#@&P,~P,PP,~~P,@#@&P~P~~,P~P,~PwW.~bP'~T,YGP`8KEU9`mDD*@#@&~P,P~P,P~~,P@#@&~P,PP,~~P,P,dd2h2;W[+,xPDDrhvlD.cb#b@#@&~,P~,P,PP,P,7@#@&P~P,P~~,PP,~dk?pd~xPrk	/nDO~bxOW,O/DDUd8P`P(;|3K|H}~3tn|ZrG2B~Pr@#@&d,P~~,PP,~P,P/U}JP{Pk?}S~',J/IA)KA{(9BPfPm;I3b:3BPiU2"{qG~,9b:2Pqt2b~r@#@&i~P,PP,~~P,P,/jpJ~{Pd?5JPLPE-mVEnd,`Edi~@#@&7,P,PP,P,~P,Pd?5S~x,/?5JPLPJEE~[,/:k^3nO,[~JESJ@#@&77iPP~~k?}S,x,/j5S,[PrBr~[,w]K&1cdA:w;GN#PL~EBBJ@#@&7d7~,P~/U}S,'~dUpS~',JvJ,',/nk/bWxvJ`j2"1)HAJb~LPJESJ,@#@&i77P,P,/jpJ~{Pd?5JPLPEvrP[~WGlO+Drs++v1Kh`*#,'PrBSJ@#@&77iPP,~/UpS,x~/UpdP'PEvrP'Pkn/kkGUvJjj3"1)HAE*P',JE~J,@#@&7diP~P,/j}dP',d?5SPL~EBrPLPWfCOYr:+`gWAc*#P'~rBE@#@&7,P~,P,PP,P,~/UpJP{Pdj5SPL~J*PJ@#@&7PiP,d~P~~1WUxcn6m;OP/j}d@#@&d,7,P7,P,Pd,d,~d,P~P@#@&77idk6~/U+x9\Ck^P{PE5E~Dtnx@#@&did7@#@&dd77i?nY,.kYPt2swVHP{~/D-+MR/.lY64N+mDcEbGrGA In^KD[?OJ*P~~,@#@&77id~P,~k?}dP{PJk+^nmDPHbt2S/}?K|(f,0DKh~Ys+swsX~E,@#@&di7d,P~~k?pJ~{Pd?5J,[~rh4+DPDh+swsXc2\K|ZrG3P{PBr~'Pk2sw/W[n,[~JEE@#@&d77iPP~~M/OKt3swsHR}w+	Pkjpd~~mKxUS,&~,f@#@&ddi7~P,Pb0~xGO,DdY:\2swszc+WW~Dtnx@#@&id7iP,PP,P,~/A:21m:n~{PDkOKt2:asz`r1zH3Jb@#@&d7di7dkZGdDqf~x,DdY:\A:2^XvJZ}?:mqGJb@#@&d77iPP,~+	NPbW@#@&idid~P~~1lsV,2Z^Wdn:l4snk`./DPt2haVH#@#@&@#@&7d,d~PiP~~,/+D~DkYA"6\lbV,'~/n.7+.R;.+mYn6(L+^OvJ)f}9~R]mKDNk+DE#@#@&7d,d~~iPP,~/UpS,x~Jk+^+^Y~~D:n:asXc2\K|Zr93B2\b&J,0.K:,Y::asX,J@#@&id77i/?5JP{P/U}JPLPrVn0O~NWrx,O/DDUd8PWU~D:n:asHR3tn|ZrG2,xPD/OD	/q :w|/rG2Pr@#@&dididd?}J,'~/U}S,[~ESt+.n,Yh+s2^X :a{mKN~k	Pc/Vn^DP/!2{1WN~WDK:,Yh+h2^X~h4nDPnha{mG['vJL~k2haZKN+,[rv#,J@#@&id~7,Pd,~P,D/D$]rtlbV W2n	Pd?5J~,mGU	~PfS,&@#@&i7id7b0,xWDPMdY~I6Hmks W0,Otx@#@&77didi/jE2nMkGD,xPM/O$"rHCr^`E2tK|Z6G2r#@#@&di7diddImnr7+D,xPM/Y~]6Hmk^`E2\)&SE#@#@&did77V/n@#@&d7di7i/j!wDkKD,xPrJ@#@&id77id/"nmk\.~',Jr@#@&d77idnx9~k6@#@&7idd7^mVsPa/^WdKm4V/v./DA]rtlrs*@#@&i7did@#@&77didb0~/]n1+r\.P@!@*~ErPY4n	@#@&di7id7k?!4LmD~',J6K,K.C	/wK.Y,D+$;n/DP(X~J~',/3:a/W9+~',JJ@#@&i@#@&di7id7kH//,',EZ}HKbg5~l,JPL~///bGU`rZ}1)H3E*P'Pr@!4M@*E@#@&dd77iddHdkPx,/t+/kPL~J:q/|AK~H}P),EPLP/:r^3Y,[~J@!8M@*E@#@&7did77kH+dd,'~/tnk/~LPr2HhS}e2AP/rG2~l,JPL~/A:w;G[+,[,J@!4.@*r@#@&di7didd\//~x,/\+kd,[~r2tnS}5A3Pgb\2,)~E,[Pk3:a1lsn~[,J@!4.@*E@#@&d7di7dkHndkP'~dt+d/,',J9mYP),J,'P9Y9lD+~',J@!(.@*r@#@&i77didkHn/d~{PdHd/,[~EUtkWO,)~J,',/j4k6Y[,J@!8D@*J@#@&id77id@#@&7diddidjpdP{PEkUdDOPbUYKP8.K:lrs,`jjhm;r9A~"2ZAqj3IB?iAx2/PBZrgP2gK~:eK2BPr@#@&d77,P~P,~P,P~~,/?}J,'~/U}dP',J;I2zKAmqG~~f:{/]AbKASP`?2"m(fBPGbP2P(t2bPr@#@&id7~,PP~~,P~P,~k?}dP{P/Upd~[,J-l^End,`Ji7P@#@&di77d,P,Pd?}J,'~/U}S,[~EEJP'~aIPqgck?;a+MkWM#,'PrBSJ@#@&77idd,~P,/?5J~',/UpJP'~rBEPL~/"+^nb\+.~LPEBBE@#@&7ididP,P,d?5S~',/j}dP[,EBrP[,djE(LmOP'~rBSJ@#@&did77,PP~dUpJP{~k?}dPLPJEJ,'PaIPqg`d\//*~[,JBBE@#@&idid7P~~,/jpd~',/j}dP[~EEKjBBE@#@&7ididP,P,d?5S~',/j}dP[,EBrP[,dn/kkKxcJijAIHbt3J*P'~rB~E~@#@&7di7iP~,Pk?pdP{~/UpJPLPEvrP[,WfmY+Drh+y`gWA`bb,[~JESJ@#@&77idd~~,Pd?5J,'~k?5SPLPrvJ,[~//drKx`ri?AI1z\3J*PLPEBSE,@#@&di7diP~~,/?}J,'~/U}dP',JEJPLP69lD+Oks++cgWhvb#,[PrvE@#@&did~P~~,P~P,~P,/j}dP'~dUpJPL~r#~r@#@&ddiPi~PiP~P,mGU	R+Xnm!Y+,djpd@#@&d7d77x[PbW@#@&d77id@#@&7id7dknDP.kY~IrtlbsP{Pd+M\n.cZDCYr4Nn^YvJzf6f$ "+^WM[/YEb@#@&d7~iP~d,~,PdUpdP',JknVmOP,YhnswVH 2tn{;692B2tb(S~WMWhPDh+swsz,J@#@&7id7dkj5S~{Pk?pdPL~J^+WY,LGr	PYkOD	/F,GUPD::2Vz AHK{;6fAPx~D/Y.UkF +s2|Z6G2,J@#@&di7di/jpdPx~k?pd~[,Jh4n.+,Ys+hwszc+hw|^W9+~r	P`dn^+^Y,^K/Osl	{mKN~0MWhPD:^GkYPS4+M+P1GdY|k9'vJ'~kZG/D(f,[Ev*PJ@#@&id~d,~iP~,PM/Y~I}\lbV Wa+U~k?pdSP1Wx	S~&BP2@#@&d77idr0,UWDP.dDAI6\mksRG6PO4+	@#@&idi7di/jEa+.rKDP{~DkYA"6\lbVvJ3HKm;r92rb@#@&d77iddd]mnk7nMPx,DkYA"rtCk^`E2tb(Jr#@#@&7diddsd+@#@&id7d77k?;w.kKD~x,JJ@#@&id7di7kIn1+b\+MP{~Jr@#@&did77xN,r0@#@&di77d1l^V~w/sK/nKm8V/c.kYA]6tlrV*@#@&d7idi@#@&idi7db0~/"+^nb\+M~@!@*PJr~Otx@#@&7d77idd?!8LmO~{PJ6P,K.l	daW.DPM+;!+kOP(X~J,[~dA:w;GNP[,EE@#@&d@#@&7d77iddHd/,'~E;rHK)g5~),E,[~k+k/kKxvEZ}1)HAJb~LPJ@!8D@*J@#@&77didi/\+dd,'~/tn/kP'~rKq/FAK~1}~=PE,[,/Kbm0nY,[~J@!4.@*r@#@&i7diddk\n/kP{PdHndkP'Pr3HhS6eA2P/6G2~),E,[~k2swZKN~[,J@!4M@*E@#@&ddi7di/HddP{PkHn/d~LPE2tKS}533,1b\3,)~J,',/3swgl:PL~J@!4.@*r@#@&7iddi7/t+/k~xPkH/dP'~rfCY~),J~',NY9CD+~[,E@!4.@*J@#@&didi7dkHn/kPx~kH+kdPLPJU4r0DP=PEP'~k?4k6O[,J@!8M@*J@#@&id7di7@#@&7ididdk?5JP{PEk	/n.DPk	OW,4DKhCk^Pv?inm/}f3~"3ZAq#3"~?i$x2/KB/}1PA1:~KInASPr@#@&did~~,PP,~P,PP,djpdP{Pd?}J,[~J;]2zK3m&f~~9:{/IA):2S,jU2I|qGSPGbP2:q\3*PJ@#@&didP,~~P,P,P~P~dUpJP{~/UpJ~LPJ-C^En/,crd7,@#@&ddidi~P,Pd?5S~x,/?5JPLPJEE~[,w"K(1cdUE2+MrWM#~',JBSE@#@&7di7iP~,Pk?pdP{~/UpJPLPEvrP[,dIm+b-nD,[,Jv~E@#@&d7di7P,P~dUpS~x,/jpd~LPEEJ,[Pk?!8LmOPLPEvBJ@#@&7didd,~~Pk?5S~'~dUpJPL~JEJ~',wIP(g`dHdk#~LPrB~r@#@&7did7P,P~dUpS,xPk?pd~'PrB:?v~E@#@&d7di7P,P~dUpS~x,/jpd~LPEEJ,[Pk+kdkKxcJ`?3]gbHAE#,[PrvSJ,@#@&d7d77,P~PkjpdPx~k?pJ~LPEBr~LPWGlD+Yb:+`gWA`*#~',JBBE@#@&ddi77P,P,/jpJ~{Pd?5JPLPEvrP[~d/dkKUvJiU2"1bt2rbPLPEBBJ~@#@&ddi7d,PP,djpdP{Pd?}J,[~JEEPLPW9mY+Ors++`gGS`b*PLPJEJ@#@&did~P,P~~,PP,~Pk?pd~xPk?5S~[~E*PE@#@&7diP7~,dP~~,mGx	 6n1ED+Pk?5J@#@&d7didnU9Pk6@#@&iddi7@#@&ididnx[~b0@#@&@#@&P,P~~,PP~~,PH+XO@#@&~,P,PP,P,@#@&,P~P,P~~,PP,^l^VP1GU0bDsAG6cEUl-+,jE1mndk0EsZr~~/tCbxi"S,[Pkb9[j"Sb@#@&d7@#@&dds/k0,d\W9+UE8Px~rE2J,Ptx@#@&id@#@&7idr0,[DfCD+,'PrJ,Otx~P,d7@#@&dP,~P,PPi7^l^V,ls+.O(Wa`r9lD+~^mxxGO,4nPhaYzr#@#@&d,P,7dx[Pb0@#@&,PP,~P,Pd@#@&~P,P,P~P~~,Pr0,d?4kWO,'PEE,Y4+	~,P7i@#@&dP,P,~P,d7mmVs~mV+MO4K6`rj4k6Y,mCxUGDP8+,n:aYzE*@#@&7~,P7dU9Pr6@#@&PP,P,~P,P~P,P~~iPP,7d@#@&d,~~di?Y~DdO:?PD	dP{PdnM\+. ;DnlDn}4%mD`Jzf}9AcInmKD[jYJ*~P,P@#@&7~P,P,P~Pdj5S~',E/Vn^DPe~WMWhPDdDDUkF,J@#@&d,~P,P~P,/j}dP',d?5SPL~Eh4+M+~K(/n2P{g6P{PvELP/Pr13nY,'rB~r@#@&dP,P,~P,P./DKjPMx/c6wxPkj}SBP1WUxS~2~~&@#@&didrW,xWO~M/OKUPMxdc+K0PDtU@#@&d7di/j}dP',ENV+Dn~0MWsPO/O.	/qPS4+M+~P&Z|3P|16P{~EJ~LPkKk13OPLPEB,J@#@&,PP,~P,ddi^Gx	R6nm;OPd?5Jd,d~~iPP~~@#@&7P,7,P~,+	NPb0@#@&d,P7P,P~^mVV,2Z^W/PC4^+k`./OPUK.xkb@#@&d~~iPP~~@#@&7P,7,P~,lMDP{PU2VbYcD;;nkY`rPWdAJ*SE~r#@#@&~P~~,P~P,~P,@#@&~,PP~~,P~P,~wW.,k,'PZPDGP`4GE	NcCMD#@#@&P,PP,~~P,P,P@#@&~~,P~P,~P,P~7k2:2/KNnP{~DDrs`mDDvk*b@#@&P~P,P~~,PP,~d@#@&P,~~P,P,P~P~7k?}S,xPrkUdDY~r	YGPDdDDUkF,`K&Zn3K|16~AHKm;rfASPr@#@&i~~P,P,P~P~~,/jpd~',/j}dP[~E;I3b:3|q9BPGK{;IA)KA~~jU2]m&f~,9b:2K&\3#,J@#@&7P~~,P~P,~P,Pdj5SPx~k?}S,',J-mV!+/,`r7d,@#@&d,P~~,PP,~P,P/U}JP{Pk?}S~',JvJ,'PkKr^0+Y~',Jv~r@#@&d7iP,PPk?5JP{Pd?5S~',JBr~[,wI:(H`k2sw/W[n*P'Prv~r@#@&7idP~~,/jpd~{PdUpdP[,JEEPLPd+k/rG	`J`j2"1bt3E#,[,Jv~E~@#@&7di~P,Pdj5SPx~k?}S,',JvrPLP0GlDnYb:n v1GAv##,'PrB~r@#@&did,P~Pdj5S~',d?5S~',JBE~LPd+kdbWUvJ`?2"1z\2r#~[,JvSrP@#@&7diPP,~d?5S,'~/j}dP'PrvJ,[~WGlYnOb:n vHKhc*#,[PrBr@#@&iP~P,P~~,PP,~/UpS,x~/UpdP'PEb,J@#@&i~d,P7~,PP^G	x +Xn1EOPk?pd@#@&7did@#@&,P~~,PP,~P,P1aO@#@&P,P~P~~,P~P,@#@&,P~~,PP~~,P~mms^P^Kx6kDsAKa`rj2NmYn~UEm1n/k0E^ZE~,/tlrxi]dP'Pk)N9j]J*@#@&~~,P~P,~,P~,@#@&ddVknk6PdHKNnj!4P{~J6kVDn.J,K4+U@#@&7i@#@&diWE	mOrKxPj4KhixmdkkL	`*@#@&,P,~d,@#@&didrW,NYGCYP@!@*~EJ,Y4+U@#@&7id7?OPM/OjV+^O,'~/.7+.cZM+lD+}8LmO`rb96GAR"nmKDNUnOJ*P,P~P~@#@&d7did?5S~x,J/nsmOPDh:2^XcZrUK|(fBP~Ys+h2^XRA\n|ZrG3SPD::2Vz gb\2B~PD:d4b0YGOc?us|/}f3BPD:/4k6OWDR9K|?u(wK~,O::w^z b"2zZ6f3SD:4W^qR_rJm&f~Oh4WsFc9:{u}S,0DK:,O::2VHPE@#@&ddi7/UpS,x~/UpdP'PEs0OPNGk	POhktkWOKY~W	~D:nsw^XRAHhmZ}f3P{POhktk6OWDR2tKmZ}fAPE@#@&7id7/U}S,'~dUpS~',Js+6O,LGbx,Y:SWMVoMw~W	POh:w^zRAHn|/6fAP{PO:AGM3LDa 2tnm/}f2~E@#@&7di7k?}dP{P/Upd~[,Js+6Y~%Kkx,O:4WV8~Gx,YshGDVLMw C}J{&f~x,Y:4G^F C}J|q9,J@#@&didid?5S~',/j}dP[,Eh4+D~O::aVzR)]Ab/rG3P@!@*~vEPJ@#@&id7dE~k?}dP{P/Upd~[,JCx9PcOstW^qRGK{_6JP{PEJ'PW9mYn v[YGlOn*P[Ev,PGD,cGKmUC&sK,',vJLPWfmYn+vNYGCY#PLEvPmx9Pc?uo|Z6fA~',B6owBPG.,?us|/}f3,',BIA?:v#*#~J@#@&77id/U}S,'Pkj}S,[,JCx[~D:n:asXc2\K|Zr93,xGY,r	Pck+^+mDPA\n|Z6fAPW.K:PDdYMx/8~s+6Y,LGkU~D/OD	dPKx~OkYDUdcK(Zn3:{H}P{PYkYMU/8RPq;|3P|1r,E@#@&ddi7d?5S,'~/j}dP'PrAtDn~GK{P]g?~',vr[~6fmY+y`9OfmYn#,[Ev,lx9~?_qs:~xPEJLPd?4r6Y~[rv#,J@#@&idd7r6PdKU)1mnk/,@!@*,JIEPDtnx@#@&77iddkjpdP',djpdPLPElU[,Yh+s2VHR3\h{Z69AP(1,ck+smDP2tn|/rG2~0MWh~(DW9Gh	Ph4n.+,V\nV~@*,BTB,Cx9P;dD{r[,'~Br~LPd/kkW	`ri?AIHbt2Eb,[Prv#,JP,@#@&didi+UN~r6d7di7did77idd7@#@&d7dir6Pd;WkYqGP@!@*PrJ~Y4+U@#@&ddi7dk?pd~xPk?5S~[~Ez19P;6?:{(9,'BE~LP2I:(g`d;WkYqG#,'PrB~J@#@&77id+	[Pb0@#@&77di/UpJPx~k?}S,'Pro.G!wP8z,2\n|/}f3,J@#@&didid?5S~',/j}dP[,EWMN+M~8X,2tnmZ69APC/1E@#@&d77iBP.nkwGxknch.bYP/Upd@#@&id7dM/OjV+1OR}w+	~d?5SBP^WUUBPf~,f@#@&d77ik0~UKY~DkOU+smDR+K0,Otx@#@&id77iNW,AtbV+,UGY,DkYj+sn1Y +KWP@#@&77idd77@#@&7di7id./aWxk+cADbYnPr@!G2DkW	~\mVExvJ,[,DdYjn^+^YvE2tnm/}f2Eb,[~JE@*rP',DkY?V^YvJ3Hh{/6G2J*~[,JP ~EPLPM/O?nsmO`rHbt2EbLPJ@!&KwOkKU@*J~,@#@&ddidi7@#@&d7did7.kY?s+1YRsG-+	+XY@#@&77id7VKGw@#@&77id+U[,kWP,~,P@#@&didd1l^sPaZsWk+PC(V+kcDkY?snmD#@#@&7d7n	N~k6@#@&idnU9P0;U1YrW	@#@&d7@#@&,PP,P,~PAx[P&0~@#@&PP,~2	NP&W@#@&,P,P@#@&~~,Pj+D~DkYPr13+O~{Pd+M-D ;DlYr(%+1YcJzf69~RI^WMN?OE#,P,P@#@&~~,Pd?5JP{PEdV+^O,e~0MGsPOkYMx/,J@#@&P,P~/UpJ~{P/U}S,[PrA4+M+,YdY.UkRPq;F2:{H6,'PvELPdKb^0+O,[rBPr@#@&~P,P./DKr^0+Yc6wxPkj}SBP1WUxS~2~~&@#@&db0~UKYP.dDKrm0nDRnK0,Ytx@#@&diP[YGlOn,'PMdY:km0nO`rf:{PIHjr#@#@&i7Pk?4r6YPx~M/OKb^0+OvJUCqwKrbd,P7P,P~@#@&PP,~+	NPbW@#@&,P,P^lss,w/VKd+:l8s/`.dDKrm0nD#@#@&d,Pd,P,~@#@&@#@&dU+O~M/Y:jnm//,x~?D7+.R/.lO+}8LmOcrbf69~R]+1GMNdYr#@#@&dkjpdPxPr/nsmY,MP6DWs~O/alk/~h4nM+~qG~',BE',/+ddbWU`riU2]gbt2J*PLEBr@#@&dM/OPUnlkdR}w+	~d?5SBP^WUUBPf~,f@#@&drW,xWO~M/OKUKm/dcA}sP:tU@#@&d7k6P.dDK?hC/k`J:j)Z;2U?E#~x,J)J,Otx@#@&idddPUb^mdkPx,JIJ@#@&dinx9Pr0@#@&7n	NPbW@#@&@#@&i@#@&B3oMAA==^#~@%>


	</head>


<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ts.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>OT Transportation Arrangement Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
            	  <!--/row -->
                <div class="row">
                	   <!-- col-md-12 -->
                    <div class="col-md-12">
                        <!-- form start -->
                        <form class="form-horizontal" action="tstransport_det.asp?" method="post">
                        	<!-- box box-info -->
                            <div class="box box-info">
                            	<div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=#@~^CAAAAA==dtlr	j"S6wIAAA==^#~@%><%=#@~^BwAAAA==dzN[`IdbwIAAA==^#~@%>');" />
                                </div>
                                <!-- box body -->
                                <div class="box-body">
                                   <!-- form group -->
                                   		<%#@~^GAAAAA==r6Pd:k13+DP@!@*PrJ~Y4+U~swYAAA==^#~@%>
	                               		<!-- Ticket No -->
										<div class="form-group">
											
											<label class="col-sm-2 control-label">Ticket No : </label>
											
											<div class="col-sm-4">
											<div class="input-group">
											<span class="mod-form-control"><%#@~^GAAAAA==~M+daW	/+chMrYPdKbmVnDP/wgAAA==^#~@%></span>
											<input type="hidden" id="txtTicket" name="txtTicket" value="<%=#@~^BwAAAA==d:k^0+D1wIAAA==^#~@%>" />					
											</div>
											</div>
										</div>
										<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
                                   
										<div class="form-group">

											<!--Date-->
											<label class="col-sm-2  control-label">Date : </label>
											<div class="col-sm-4">
												<div class="input-group">
													<%#@~^FwAAAA==r6Pd:k13+DP@!@*PrJ~Y4+UkwYAAA==^#~@%>
													<span class="mod-form-control"><%#@~^FwAAAA==~M+daW	/+chMrYP[YGlOn,fggAAA==^#~@%></span>
													<input type="hidden" id="dtpDate" name="dtpDate" value="<%=#@~^EQAAAA==WGlOVKxovND9lD+bOwYAAA==^#~@%>">
													<%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
													<input id="dtpDate" name="dtpDate" value="<%=#@~^EQAAAA==WGlOVKxovND9lD+bOwYAAA==^#~@%>" type="text" class="form-control" date-picker >
													<span class="input-group-btn">
													<a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
													<i class="fa fa-calendar"></i>
													</a>
													</span>
													<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
												</div>
											</div>
										</div>
										<!--/.form group -->


										<!-- form group -->
										<div class="form-group">
											<!-- Shift -->
											<label class="col-sm-2  control-label" >Shift : </label>
											<div class="col-sm-4" >
												<%#@~^FgAAAA==~b0~kKbm3Y,xPrJ~Y4+U~lgYAAA==^#~@%>
													<select id="cboShift" name="cboShift" class="form-control">
														<option value="" <%#@~^EwAAAA==r6PdUtb0Y,',EJ,Y4+	8AUAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Select One</option>
														<option value="M" <%#@~^FAAAAA==r6PdUtb0Y,',EHrPOtxPQYAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Morning</option>
														<option value="N" <%#@~^FAAAAA==r6PdUtb0Y,',E1rPOtxPgYAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Night</option>
													</select>
												<%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
													<%#@~^FAAAAA==r6PdUtb0Y,',EHrPOtxPQYAAA==^#~@%>	
														<span class="mod-form-control">Morning</span>
														<input type="hidden" id="cboShift" name="cboShift" value="<%=#@~^BgAAAA==dUtr6YcQIAAA==^#~@%>">
													<%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
														<span class="mod-form-control">Night</span>
														<input type="hidden" id="cboShift" name="cboShift" value="<%=#@~^BgAAAA==dUtr6YcQIAAA==^#~@%>">
													<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
												<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
												
											</div>   
											<%#@~^LAAAAA==r6Pd:k13+DP{~JrPCx9PdPUbZ;3?UP@!@*~E5rPDtnx~DAwAAA==^#~@%>
												<div class="input-group">
													<button type="submit" name="sub" value="filter" class="btn btn-info" style="width: 94px">Filter</button>
												</div>
											<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
										</div>
										<!--/.form group -->
										
                                   		<%#@~^FwAAAA==r6Pd:?zZZA?U~',JeJ,Y4n	pAYAAA==^#~@%>					   
										<!-- form group -->
										<div class="form-group">
											<!--Cost Center-->
											
											<label class="col-sm-2  control-label" >Cost Center :</label>
											<div class="col-sm-4" >
												<div class="input-group">
													<input class="form-control" id="txtCostID" name="txtCostID" value="<%=#@~^BwAAAA==d;WdDqGmQIAAA==^#~@%>" maxlength="30" style="text-transform: uppercase" placeholder="Empty For All" input-check  >
													<span class="input-group-btn">
													<a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('COST','txtCostID','mycontent','#mymodal')">
													<i class="fa fa-search"></i>
													</a>
													</span>	
												</div>
												
											</div>		
											
												<div class="input-group">
													<button type="submit" name="sub" value="filter" class="btn btn-info" style="width: 94px">Filter</button>
												</div>
											

										</div>
										<!--/.form group -->
  										<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
								   <!-- form group -->
                                   <div id="selList" class="form-group" style="overflow:auto;padding:0px;margin:0px">
                                    	<table id="example1">
                                        <tbody>
                                            <tr>
                                                <td width="2%"></td>
                                                <td width="5%" style="padding: 7px"><b>Unassigned Employee :</b>
                                                	
                                                    <select multiple size="15" style="width: 405px;" name="FromLB" id="FromLB" ondblclick="move(this.form.FromLB,this.form.ToLB)">
                                                       <%#@~^0QAAAA==~,@#@&,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~UtKhj	lkdkTxc#@#@&~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P@#@&~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,PXxwAAA==^#~@%>
                                                    </select>
                                                    			  
                                                </td>
                                                
                                                <td width="3%" >
                                                	<input type="button" class="btn btn-primary" style="width: 50px" onclick="moveAll(this.form.FromLB, this.form.ToLB)" value="   >>   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="move(this.form.FromLB, this.form.ToLB)" value="   >   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="move(this.form.ToLB, this.form.FromLB)" value="   <   ">
                                                    <br>
                                                    <br>
                                                    <input type="button" class="btn btn-primary" style="width: 50px" onclick="moveAll(this.form.ToLB, this.form.FromLB)" value="   <<   ">

                                                </td>
                                                	
                                                <td width="5%" style="padding: 7px"><b>Assigned Employee : </b>
                                                	<%#@~^FgAAAA==r6P[DfmY+,@!@*~JrPOtxEgYAAA==^#~@%>
                                                	
                                                    <select multiple size="15" style="width: 405px;" name="ToLB" id="ToLB" ondblclick="move(this.form.ToLB,this.form.FromLB)">
                                                    	<%#@~^hQQAAA==~,@#@&iP,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,Pj+D~M/OU+^+mDP{~/D-+MR/.lY64N+mDcEbGrGA In^KD[?OJ*P~~,PP~~@#@&7di7id7ididdidid?5S~',Jdn^+mD~e,0DKh~YkYMxdF~E@#@&7di7did77idd77i/jpd~{PdUpdP[,J^n0DP%Wbx~Os+:asX,Wx,OdYMxkF 2\K|Z6fA~',YhnswVz AHK{;6G2~r@#@&ddidi7did7did77k?pd~',/?5J~[,JStnDn~:q/|AP{gr~x,BJ'~kKrm0nDP'rB,Jdidi7did7d@#@&7~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~DkYj+^+^OcrwUPk?pdS~mKx	~~&S~2@#@&d,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,Pr0~UKY~DkO?Vn^DR+GW,Y4+	@#@&d7,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,NGPS4bVn,xKYPM/Dj+^+^Yc+GW,@#@&i7P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,d@#@&7d,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PDdwKx/ ADbYPE@!G2DkGx,-l^EnxEJP'~M/O?smOvJAHn|Z}92r#~[,Jv@*rP[,./D?+^n^YvJAHK{/6G2E#,'PrPR~rP[~.kYj+^n1Ycr1zH2r#L~J@!zGwDkGU@*JP,@#@&idP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,./D?+^n^Yc:K\nxnaD@#@&di~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~VGGa@#@&d,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,Pnx[~b0~P,@#@&iP~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,PrNsAAA==^#~@%>      
                                                    </select>
                                                    <%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
                                                    <select multiple size="15" style="width: 405px;" name="ToLB" id="ToLB" ondblclick="move(this.form.ToLB,this.form.FromLB)">
                                                    </select>
                                                    <%#@~^BwAAAA==n	N~b0,RgIAAA==^#~@%>
                                                     
                                                </td>
                                               
                                            </tr>
                                        </tbody>
                                    	</table>
                                   </div>
                                   <!--/.form group -->

                                
                                
									<!-- box-footer -->
									<div class="box-footer">
										<%#@~^FQAAAA==r6Pd:k13+DP{~JrPOtx~dgYAAA==^#~@%>
										<button type="submit" id="btnSave" name="sub" value="save" class="btn btn-success pull-right" style="width: 90px">Save</button>
										<%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
										<a href="#" onclick="fOpen('DEL','','mycontent','#mymodal')" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
										<button type="submit" id="btnUp" name="sub" value="up" class="btn btn-success pull-right" style="width: 90px">Update</button>										
	                                	<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>
	                                </div>
	                                <!-- /.box-footer -->
                                </div>
                                <!--/.box body-->
                            </div>
                            
                            <!-- /.box box-info -->
                        </form>
                        <!-- form end -->
                    </div>
                    <!--/.col-md-12 -->
                </div>
                <!--/.row -->
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
	<!--Document Ready-->
	<script>
    $(document).ready(function () {
        $('#btnUp').click(function () {
         $('#ToLB').each(function () {
            $('#ToLB option').attr("selected", "selected");
            });
         });
         
         $('#btnSave').click(function () {
         $('#ToLB').each(function () {
            $('#ToLB option').attr("selected", "selected");
            });
         });
    });
    
 	</script>
	            
	<!--date picker-->
    <script>
    $('#btndt_date').click(function () {
        $('#dtpDate').datepicker("show");
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

    <!--open modal-->
	<script>
    function fOpen(pType,pFldName,pContent,pModal) {
		document.getElementById(pContent).innerHTML = ""
		showDetails('txtTicket=<%=#@~^BwAAAA==d:k^0+D1wIAAA==^#~@%>&txtDtDate=<%=#@~^BgAAAA==[DfCD+VgIAAA==^#~@%>&txtShift=<%=#@~^BgAAAA==dUtr6YcQIAAA==^#~@%>',pFldName,pType,pContent)
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
  	    
  	    if (pType=="COST") {
  	    var search = document.getElementById("txtSearch2");
  	    } else {
  	    var search = document.getElementById("txtSearch");
  	    }
  	    
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			
 			str = str + "&fldName=" + pFldName;
 			
		if (pType=="COST") {
	  	    xhttp.open("GET", "ajax/ax_tsview_costID.asp?"+str, true);
	  	} else if(pType=="DEL") {
	  		xhttp.open("GET", "tstransport_del.asp?"+str, true);
  		} 
  			  	
  	    xhttp.send();
    }
	</script>

	<!--move selected-->
    <script>
    function move(tbFrom, tbTo) {
	 	var arrFrom = new Array(); var arrTo = new Array(); 
	 	var arrLU = new Array();
	 	var i;
	 	for (i = 0; i < tbTo.options.length; i++) {
	  		arrLU[tbTo.options[i].text] = tbTo.options[i].value;
	  		arrTo[i] = tbTo.options[i].text;
	 	}
	 	var fLength = 0;
	 	var tLength = arrTo.length;
	 	for(i = 0; i < tbFrom.options.length; i++) {
	  		arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;
	  		if (tbFrom.options[i].selected && tbFrom.options[i].value != "") {
	   			arrTo[tLength] = tbFrom.options[i].text;
	   			tLength++;
	  		} else {
				arrFrom[fLength] = tbFrom.options[i].text;
	   			fLength++;
	  		}
		}
	
		tbFrom.length = 0;
		tbTo.length = 0;
		var ii;
	
		for(ii = 0; ii < arrFrom.length; ii++) {
	  		var no = new Option();
	  		no.value = arrLU[arrFrom[ii]];
	  		no.text = arrFrom[ii];
	        tbFrom[ii] = no;
	
		}
	
		for(ii = 0; ii < arrTo.length; ii++) {
	 		var no = new Option();
	 		no.value = arrLU[arrTo[ii]];
	 		no.text = arrTo[ii];
	 		tbTo[ii] = no;
		}
	}
	</script>
	
	<!--move all-->
	<script>
    function moveAll(tbFrom, tbTo) {
	 	var arrFrom = new Array(); var arrTo = new Array(); 
	 	var arrLU = new Array();
	 	var i;
	 	for (i = 0; i < tbTo.options.length; i++) {
	  		arrLU[tbTo.options[i].text] = tbTo.options[i].value;
	  		arrTo[i] = tbTo.options[i].text;
	 	}
	 	var fLength = 0;
	 	var tLength = arrTo.length;
	 	for(i = 0; i < tbFrom.options.length; i++) {
	  		arrLU[tbFrom.options[i].text] = tbFrom.options[i].value;
	  		arrTo[tLength] = tbFrom.options[i].text;
	   		tLength++;
	  	}
	
	
		tbFrom.length = 0;
		tbTo.length = 0;
		var ii;
	
		for(ii = 0; ii < arrFrom.length; ii++) {
	  		var no = new Option();
	  		no.value = arrLU[arrFrom[ii]];
	  		no.text = arrFrom[ii];
	        tbFrom[ii] = no;
	
		}
	
		for(ii = 0; ii < arrTo.length; ii++) {
	 		var no = new Option();
	 		no.value = arrLU[arrTo[ii]];
	 		no.text = arrTo[ii];
	 		tbTo[ii] = no;
		}
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
 	
	$( "#txtCostID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtCostID").val(ui.item.value);
				var str = document.getElementById("txtCostID").value;
				var res = str.split(" | ");
				document.getElementById("txtCostID").value = res[0];
			},0);
		}
	});	
    </script>
    
	<!--Script End-->
</body>
</html>
