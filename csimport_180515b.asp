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
    
<%#@~^PCcAAA==@#@&P~i/tWN?!8P{P.+$EndD`Jk;4r#@#@&~~P,/tlrxi]dPxPr^/b:2GMYRCdagE@#@&~,P~,@#@&PP,PbWPkHGN?;8,@!@*,EJ,KtU@#@&,P,P~P~~@#@&~P,~P,P~d:Xwn~{P.+$oKDhvJk+V:XanJ*@#@&P,P~~,PP9OfmY+,x~D;wW.:cE9Y2fmO+r#@#@&,PP~~,P~NDPKfCD+,'PM+$oWM:cJ9Y2PKflDnJ*@#@&,~~P,P,Pdfn2Dq9P{~D;oGM:`EOXY9+aO&fE*@#@&PP,P,~P,/!DmNn(GP',.+$sWMhcJD6DM.l[n&fE#@#@&P,P~~,PP[OxWrxGCD+~{PM+;wWMh`rNOwxWrUGlYE#@#@&P,~~P,P,//WdO&f~',.+$sG.s`JOaDZG/D(GJb@#@&,PP,P,~PkZGxDq9~{PD5sKD:vEO6DZKxOq9E*@#@&P,~P,P~~9ZW;2Kx~',.;oKDs`JD6D/W!wGxr#@#@&,PP,~P,P/UOCY!/,'~JeE@#@&~P,~P,P~~@#@&P~~,P~P,r6PdtW9+?!4,xPrE2J,K4n	@#@&,~P,PP,~7@#@&P,P~P~~,P~P,CDMPx~UwVrOvDn;!nkYcrKKSAr#BE~r#@#@&,P~~,PP,~P,PP,~@#@&,P,P~P~~,P~PbWPM+5;/YcE:WJArb,'~rJ,Ytx,~Pid@#@&iP~~,PP,7d1lV^~CVDD4G6cEgW~+s2VKXnn,l/drTxnNrb@#@&7,P,ddx9~k6@#@&P,P~~,PP,~P,@#@&,~~P,P,P~P~~wW.Pb~',!~OKPj8G!x[`m.M#@#@&P,PP,P,~P,P~@#@&P~~,PP,~P,PPid3:aZKNnPx~DDr:vCDM`rb*@#@&77id[YUOmDO,',NYGlDn@#@&d7diP~~,PP,~P,PP@#@&~P,P,P~P~~,P7k6~/:X2n,'PEHrPPtU@#@&~,P,PP,P,~P,d@#@&iP~~,PP,~P,PPirWP9ZKE2WU~{PEJ,GD,xGO,k/H;s+.k1c9ZG!wKx#,Y4nx@#@&7P,P~~,PP,~P,dd1CsV,l^+.Y8GX`E?!8/bNz~m:W;UDP^l	UKY~(+,+:aYHE#@#@&7did7n	NPbW@#@&ddi77@#@&d,P~P~~,P~P,~P,P~jYP.dDZj2s2^X~{Pk+D7+M ZM+CYr8%mYvEbGrf~ ]+1WMNj+OE*P~P,@#@&id~~,PP~~,P~P,dUpJ,',J/V^Y,e~0MWh~1/+s2VHPJ@#@&7d,P,P~P~~,P~PkjpdPx~k?pJ~LPEh4nM+~AHh{Z}fA~',BEPLPd3swZK[+,[PrvE@#@&diP~P~~,P~P,~PM/O/U2:2sHR6wU,/j5SBPmKx	SP2~~&id~~,PP,~P,PP,@#@&diP,P~P~~,P~P,r0,xGO,D/O/U2hw^zc+G6PDt+	@#@&7d,P~P,P~~,PP,@#@&idP,~~P,P,P~P~~,P~/U}S,'~E`nf)PAP^/haVz,?AKPrP,~P,P~P,P~~,PP,~P,PP,@#@&did,P~P~~,P~P,~/UpJ~{P/j}dP'Pr/}jK}1,'PEJ,'PasGDslOc9ZW!2W	~ *~'PrBBJ@#@&77iP~P,~P,P~~,P/j}dPxPkj5S~LPrj?AI|(f,'vJ,[~d//bGxvJjU3]1zHAJbP'~rBSJ,~P,P~~@#@&d77,P~P,~,P~,P,/?5S,xPk?}S,[~EGbKAPqt2P{~vJ,[,09lOnDkh+yc1Khcb*P[~EEJ@#@&i7iP~,P,PP,P,~Pk?}S,'~dUpS,'PrP_3]2,2tnmZ69APxPEEPLPd3swZG[P'Prvr@#@&idiPP,P,~P,P~P,mGU	R+Xnm!Y+,djpd@#@&d7d77id@#@&i~P,P~7id+sd@#@&d,~,P~ididP,P,~did@#@&iP~~,Pdi7dU+Y,.dY:HA:2Vz~{Pd+M-+MR/.lYn6(LnmDcrb9}f~RImK.NU+OJ*P~~,@#@&i7d,PP,~~P,P,P~/j}dPxPrd+^+^O,ePW.K:~YsnswsHPr@#@&idi~P,P~P,P~~,P/U}S,'Pkj}S,[,JAtn.P3HhmZ}f3~{PBE~LPd2s2;W[PLPJEJ@#@&did~P,P~~,PP,~PM/Y:\3:aVHR6wnU,/jpdSP1WUUBP&S~2@#@&di7id7b0,xWDPMdY:H3:aVz W0,Otx@#@&77didi@#@&d77id~P,~P,P~dUpS~x,JrxknMY~bxDWP1/hw^X~`AHKm;rfASPgbHAS~ZzIG16~~/}jKrgSPUK)P`?~~E@#@&7di7,P~,P,PP,P,~/UpJP{Pdj5SPL~J;I2zP3{&fBP9Km/"2)KASP`?3]|qfS~GbP2:(t2b,J@#@&didi~P,P~P,P~~,P/U}S,'Pkj}S,[,J-ls;/~`r@#@&id77idP~~,/jpd~{PdUpdP[,JEEPLP2I:qHck2:a/W9+#,'~JE~rd7P@#@&id7di7P,P~dUpS~x,/jpd~LPEEJ,[PM/DPHA:2VH`EHzH2rbPLPJESE@#@&did7d7~,P~/U}S,'~dUpS~',JvJ,',DdDKt2:aVHcJ;b]fgrEb,[Prv~r@#@&i77did,P~Pdj5S~',d?5S~',JBE~LP2sK.slOvN;WEaW	S *P'PrBSE@#@&di7didP,~~/UpdPxPdj5S~[,EBrP'~k?YCO!/~[,EE~E@#@&iddidi~P,Pd?5S~x,/?5JPLPJEE~[,//dkGUvJi?A]1zH3E*P[~EE~EP@#@&id7idiPP,PkjpdPxPk?}J,[PrvJ,[P69CYYb:n cHKhc#*~[,JvSr@#@&77id7d,~,PdUpdP',/U}S,[~JEJ~',/+kdkKx`rij2"1zH3Jb~LPEBBEP@#@&77idd7~,P~/U}dPx,/UpS,[,EBrP'P6fCOYksn v1WScb#,[,JvJ@#@&id7d,~P,P~~,PP~~k?}S,x,/j5S,[Pr#,E@#@&d7diP7~,dP,~P1Wx	 n6m!YnPdj5S@#@&i7diP7~,dP~~,@#@&di7,d~,d,PP,+	[Pb0@#@&id7~iPPi~P,PmmssPaZ^Wd+PC(Vn/v./DK\3swVzb@#@&7di~,P~,P,P@#@&di7P,P~P,P~n	NPbWP,@#@&i7~P,P,P~P~~,P^l^sPaZsGk+KC8^+d`MdDZjA:aVX*@#@&7d,P~P,P~~,PP,@#@&iPP,~~P,P,P~Pnsk+@#@&i~P,P~~,PP~~,d~P,~,P~,P,PPi@#@&~P,P~P,P~~,Pdir0,NYGCO+,',JEPO4x~P,7d@#@&77iPP~~,P~di^mVs,l^+DD4Ka`rs.WsP9CD+P1Cx	WY,8nP:aYzJb@#@&d7d,~PidnU9PkW@#@&d7d,~,P@#@&didP,P,~P,Pr0,NOPKflDnP{PJr~Otx@#@&7d7~,P~P,~P,P~~1lVs~mVnDD8K6crKKPfmY~mmxUWDP8n,+:aOXr#@#@&77d,P,P~P~~x[PbW@#@&d77,PP~~,P~di7,P~,P,PP@#@&i7d,P~P,P~~bIl	L+,'Pv9CYfb0W`E[r~[YGCY~[O:WfCO#b@#@&7id~,P,PP,PUnY,DdY;?3haVX,xPk+D7n.R;DlO+68N+^YvEbGr9$cI+^GMNj+DE*P~,P@#@&diP,~P,P~P,P~~k?pd~',J/snmDPCPWDGh,md+s2VHPE@#@&dd~~,P~P,~,P~,/UpS,',d?5S~[,JA4D+,3Hh{Z}93P{PEJ~[~dA:2ZK[+,[~EEJ@#@&7iP~P,~,P~,P,PDkY;j2swsXcr2n	P/U}SBPmKUU~,&BPfd7~,P~P,~P,P~~@#@&d7~,P~P,~,P~,Pb0PM/D/?A:2VHRnG6PY4nx@#@&di~~P,P,P~P~~,P~P,@#@&id~~,PP~~,P~P,~,P~U+DPDkY:\2swsX,'~dD\.R;D+mOnr(LmO`E)Gr9Ac]+1W.[U+YEb,P~P@#@&id7,P,PP,P,~P,Pd?5S~x,J/s+1YPC~WDK:,Yh+h2^X~J@#@&did~~,PP~~,P~P,dUpJ,',/?5S,'Prh4+M+~3tn{;6fAP',vEPLPk2hw/G9+~[,EBr@#@&7idP~~,P~P,~,P~M/DKHA:asXcr2+	Pdj5S~,^W	x~,fSP2@#@&d7d77ikWP	GY,DdO:H2h2^X +KW,Y4x@#@&didi7di@#@&did77id?OPM/Y;jKlDt,'~/n.7+.R;.+mYn6(L+^OvJ)f}9~R]mKDNU+DE#,P~P@#@&77idP,~P,PP,~~P,/UpJPx~r/nV^Y,e~WMW:~^kwCY4~r@#@&ididP,P,~P,P~P,P.dDZ?hCY4RranUPk?5SSP^G	xSP2SP2@#@&7idd77ikWP	GDP.kY;?nmY4 +K0~Y4+U@#@&ddi7did@#@&77didiP~P~~,P~/U}S,'~Ebx/n.DPrxDG,md:aVX,`A\n|Z6fA~~HzH2B~ZzIfg6SP;r`n61S~UK)K`jPr@#@&7idd7~,P~P,~,P~,Pk?pdP{~/UpJPLPE/"2b:3{&f~,9P{;IAbP2S~`?3I|(fBP9):2K(\A#~J@#@&id7id,PP,P,~P,P~Pk?}J,'PkjpdP[,E-l^E/~`E@#@&d7di7diP~~,/?}J,'~/U}dP',JEJPLPa]K&1c/A:2/KN+*~[,JBBE7d,@#@&d7d77id~P,~/UpJ~{P/j}dP'PrvrP',DkYKt2s2VH`E1zH3E*P[,EBBJ@#@&77didid~P~~k?}S,xPk?}J,[PEvrP'PMdDK\A:aVXvJ;)IG16J*P'~rB~r@#@&iddi77d,P,Pd?}J,'~/U}S,[~EEJP'~M/OZUKmY4vJ;rjhrgE#,[~JE~E@#@&ddi7didP,~~/UpdPxPdj5S~[,EBrP'~k?YCO!/~[,EE~E@#@&iddidi7P,P~/UpJ~{P/U}S,[PrvEPLPk+d/rG	`EjU3Igb\3r#P'~rBSJ,@#@&d7ididd,P,~/UpJP{Pdj5SPL~JEJPL~WfmYYr:n+v1Ghvb#,[~EE~J@#@&id7di7iP~,Pk?pdP{~/UpJPLPEvrP[,d+k/kKUcJ`?AIHb\3r#~[,EBBJ~@#@&dd77id7P,~,/j5S,'Pk?5JPLPEBrP'~6flDnYb:+ycHWS`*#~[~EEJ@#@&i7did~~,PP~~,P~P,dUpJ,',/?5S,'Pr#~J@#@&77idd,7P,dP,~~mKx	Rn6n^!YnPkjpd@#@&7idd~7,P7P,~,@#@&ididPiP,7P,P~+	N~r6@#@&i7diPd,~7P,P,mCVs~aZsWknKm4snk`DdO;?KlD4*@#@&@#@&idd,d,~d,P~Px[~b0@#@&7diPd,~7P,P,mCVs~aZsWknKm4snk`DdO:H3:asH#@#@&didPiP,7P,P~@#@&d77,dP,7+	NPbW@#@&idid7d@#@&id7dioWMPrUDqf~x,!~YK~bIC	o@#@&idi7di@#@&did77,PP,j+DPDkO/?A:aVzF~x,/nD7nDcZ.nmY+68N+^YvEzf6GAcI+1WM[?YE#,P~~@#@&di7P,PP,~~P,P,Pd?}J,'~JknVmO~CP0.GsP^/haVz8Pr@#@&idi~P,P~P,P~~,P/U}S,'Pkj}S,[,JAtn.P3HhmZ}f3~{PBE~LPd2s2;W[PLPJEJ@#@&did~P,P~~,PP,~Pk?pd~xPk?5S~[~Emx[P:enAPx~EJP'~kKzw~LPEEJ@#@&did,~P,P~P,P~~,/?5JP{P/U}JPLPrlUN~9:{jj~~',BE~LP09CD++`9OUYCMY*P[,JEEP@#@&7diP~~,PP,~P,PPMdOZU2swsXq }wnx,d?5SS~1WxUS,&SP2@#@&d7iP,PP,P,~P,P~k6PUGDPDkOZU2:aszFc+K0~Y4n	@#@&P,~P,P~~,dd@#@&id~P,~,P~,P,PPidknY,DdY;?Pza+P{~/D\. ZM+mYnr8%mO`r)f}f$ "+mG.9?nYrb,P~,@#@&ddid,~P,P~P,P~~,/?5JP{PJkns+1Y,e~0.GsP^/DzwPA4D+~j`AP5h3,'~EJ,[PkKH2+,[~JEPE~@#@&di7d,PP,~~P,P,P~DdO;?PXanR}wnU,/?}JBP^W	UBPfBP2@#@&idi7P,P~P,P~~,PPbWP	WY,.dY;?:X2+ nK0~Y4nx@#@&7@#@&dd77,P~P,~,P~,P,PP,PkjpdPxPrjK9zK2,^/:w^zqPU2:PEP~~,P~P,~P,P~~,PP~~,P~@#@&7id7iP,PP,P,~P,P~/UpJ~{P/U}S,[Pr3\n|Z}f3PxvrP'Pa]K&1cdA:w/G9+bPL~rBSrdiP@#@&di7did7P,P~dUpS,xPk?pd~'PrKIn3PxvrP'Pa]K&1cd:Xwnb,[~JESr@#@&ididdid,~P,/jpdPx~k?pd~[,Jf:mjj~P{BEP'~6NCY+`9YjOmDYb~LPEBBE@#@&7ididdiP,~Pk?}S,'~dUpS,'PrbH}iHK,'EJ~[~2wW.:mO`M/O/UKX2nvJ)H}igKE*~y#PLPrv~r@#@&did77idP,~Pk?pd~xPk?5S~[~E`?3I|(f,'vE,[Pdnk/rW	crjjAIgbHAJ*~[,Jv~rP@#@&iddi7diPP,~d?5S,'~/j}dP'Pr9b:2P(t2PxvrP'P6[mYnDks+ v1KA`*#~[,JvE@#@&di7diPP,~~P,P,P~Pdj5S~',d?5S~',Ju3"2~2tK|Z6G2,'PEJ,'Pk2hw;W[n,[PrvJ@#@&di77d,P,P~P~~,P~PkjpdPx~k?pJ~LPEl	[,fP|?`AP{PEEPLPWNmYn+vNYUOlMY#,'~JEJ@#@&7d77iP~P,~P,P~~,P/j}dPxPkj5S~LPrlx9P:enAPxPEJ~',/KH2+,[PrvE@#@&did7d77imGx	 +X+^;D+Pdj5S@#@&i7id7idi@#@&idi7didnx9PrW@#@&di7didda/sWk+:l8VndvDdY;jKHwnbi@#@&77id7di7@#@&7iP,PP,di7+^/n@#@&d7~,PP,7did@#@&7~P,P,d7d77k+OPMdY;?Pza+Px~k+.\.cZ.lD+r(L^YvJ)f}f$ "+mK.NU+Yrb~P,P@#@&7d77,P~P,~P,P~~,/?}J,'~Jkn^+^DPCP0MWs~mkYzwPA4D+,jj~K5h3~',BrP'PdPHwnPL~JEPE~@#@&d77iP~P,~,P~,P,PDkY;jKHwnR}wnU,/?5J~,mW	USP2~,&@#@&77id~P,~P,P~~,PPrW,xGY,.kY/UKHw+c+KWPDtnx@#@&77idP,~P,PP,~~P,@#@&d7d77iP~P,~P,Pdj5SPx~rkU/.DPr	YKPmk+s2VHF~`AHKm;rfASP:5nAS~f:{Uj$~~)tri1:SPr@#@&7idd7~,P~P,~,P~,Pk?pdP{~/UpJPLPE/"2b:3{&f~,9P{;IAbP2S~`?3I|(fBP9):2K(\A#~J@#@&id7id,PP,P,~P,P~Pk?}J,'PkjpdP[,E-l^E/~`E@#@&d7di7diP~~,/?}J,'~/U}dP',JEJPLPa]K&1c/A:2/KN+*~[,JBBE7d,@#@&d7d77id~P,~/UpJ~{P/j}dP'PrvrP',w"Kqg`kPXa+bPLPEvBJ@#@&7diddi7~P,Pk?}S~x,/jpd~[,JvE,[PW[mYn v[D?OmDD#PLPrv~r@#@&did77idP,~Pk?pd~xPk?5S~[~EEJ~[,2sKDhCD`DdO;?PXanvJ)tr`1Kr#B+#,[~JE~E@#@&ddi7didP,~~/UpdPxPdj5S~[,EBrP'~k+/drKxcJ`jAIHzHAJ#,[,EBBJ@#@&id77idd,~P,/?5J~',/UpJP'~rBEPL~09lOnDk:n+v1Ghvb*P',JE~J@#@&i7did7d,P~~k?pd~',/?5J~[,JEJ~[~d/dkKU`rjj3"1b\3r#~[,EE~E@#@&iddidi7P,P~/UpJ~{P/U}S,[PrvEPLP6NCYnOb:n vHWS`bb,[PEvr@#@&di7id~,P,PP,P,~P,/jpdPx~k?pd~[,J#,E@#@&idid7P~~,P~P,~P,P^G	xRnam;Y~k?}d@#@&ddidi~P,P~P,P~~,P@#@&7didP,~~P,P,P~P~n	N~k6@#@&id77idd2/^Wd+:C(Vnk`M/Y;?:zw#@#@&@#@&77idP,~P,PP,nUN,k6P~@#@&7id~P,~P,P~~,PP^C^V~w;sK/n:l(V+k`MdY;?3:aVzq*@#@&i7@#@&dd,~~P,P,P~P~7iNO?DCDDPx~vflOnzN[`r[r~qBND?YmDDb#i@#@&did77i@#@&i7P,PP,~~P,P,PH+aO@#@&7d,~P,P~~,2x[~&0@#@&,~,P~,P,PP,P@#@&P,P~P,P~~,PPgn6D@#@&,~~P,P,P~P~~@#@&~P,~P,P~~,PP^C^V~mKU6k.sAK6`rja[lD+~?!m^nk/0!s"r~Pk\Ck	j"S'/)[9j]S*@#@&,P~~,PP~~,P~@#@&~,P~,P,P+^/r0,/\W9+j;(P',ENVJ,P4+	@#@&P~P~~,P~d,@#@&,P~~,PP~7b0~ND9mYn,',JJ,Y4nx,P~di@#@&7,PP,~P,dd1CsV,l^+.Y8GX`EsMG:,fCOPmCU	WOP(n,+haYHJ#@#@&i~P,d7+	N~r6@#@&i~P,P@#@&7~P,P,P~PrW,NOKK9lD+~x,JJ~O4+U@#@&7,P~,P,PP,P,~mmVsPmVn.D4WXcJ:WPGCO+,mmxUWO~(+~+s2YHJb@#@&dP~~,P~P,n	N~b0@#@&d,P,~P,P~@#@&d~~,PP,~PmDD,x~?aVbYcDn5!+dYvEKKS$E*~JSE*@#@&P,~,P~,P,PP,P,~@#@&P~P,P~~,PP,~k6PD5;+kYvJPWJ$r#~',EJ,Y4n	PP~7i@#@&d,~,P~,PidmmV^~l^+.Y(Wacr1W,n:aVWHnnPm/kkLxn[r#@#@&i~P,d7n	NPrW@#@&~P,~,P~,P,PP@#@&,~P,P~P,P~~,sWM~k,'PZ~OW,j(W;x[cmD.#@#@&P,P~~,PP~~,P@#@&,~,P~,P,PP,Pid2sw/W9+~x,YDbh`mDDvrb#@#@&id7d[OUYCDD~',NO9mY+@#@&iP~P,~,P~,P,PP,P,~P,P~P,@#@&7iddb]l	o+,x~`GlD+9kWWvJ[JB[YGlOnBNYPGGlO+*b@#@&7idisWMPbUY&f~',!~OKPk"CxT+@#@&@#@&dididd+O~M/OZU3:aVzq,'PdnM\nDc/M+CD+}4LmDcJzf6f~R]n1WD9j+DJ#,~~P@#@&id7d7dUpJP{~Jk+sn1YPM~6DG:,^k+haVHFPr@#@&7did7/UpJ~{P/U}S,[PrA4+M+,2\nm/}f3P{~BrP'~k2:2/KNnPL~rBE@#@&iddidkjpdPxPk?}J,[PrCx9PKIK3P{PEJ~[~d:X2+,'PrBE@#@&dd77i/jpd~{PdUpdP[,JmUN,fP{Uj$~{PBr~[,0fmOn vND?Ol.O*P'PrvJ,@#@&7idd7.kY/?AhaVz8R}w+	Pkjpd~~mKxUS,&~,f@#@&ddi77k6P	WOP.dDZj2s2VHF nK0PO4x@#@&i7id7@#@&iddidid?5S~',J[n^+Y~0MW:,^d+sw^XqPE@#@&d7di7dk?}J,'Pdj5S~[,EStnM+,2Hh{;6fAPxPEJ~',/2s2ZKN+,'~JEPr@#@&d77id7/U}S,'~dUpS~',JCx9~:5KAP{PBrPL~/:X2+,[~EEPJ@#@&diddi7d?5S,'~/j}dP'PrCx9P9P|?j$x,BEPL~6fCD+y`ND?DCDD#~[,JvE,@#@&i7didd1GUxc+X+^EOn,/jpd@#@&id77id@#@&7id7dU9Pr6@#@&ddidi2Z^Wd+:l8s/`MdY;?2s2sX8#@#@&7d77iNO?DCDDPx~vflOnzN[`r[r~qBND?YmDDb#i@#@&did7H6Y@#@&@#@&ddiHn6D@#@&d7d@#@&,P~P,~P,P~~,mlss,mGx6rM:$K6vJfVO+,?;m1+dd6EVeE~,/HmrUj"SL/)N[i"Sb@#@&7di@#@&~,PP~~,P3x9~&0~@#@&,PP,2	[P&0@#@&/XUIAA==^#~@%>


	</head>


<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_cs.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Generate Subsidy</h1>
            </section>
            <!-- Main content -->
            <section class="content">
            	  <!--/row -->
                <div class="row">
                	   <!-- col-md-12 -->
                    <div class="col-md-12">
                        <!-- form start -->
                        <form class="form-horizontal" action="csimport.asp" method="post">
                        	<!-- box box-info -->
                            <div class="box box-info">
                                <!-- box body -->
                                <div class="box-body">
                                   <!-- form group -->
                                   <div class="form-group">
                                   		<!--Type-->
                                        
                                        <div class="col-sm-3" >
                                        	<label >Type : </label>
                                            <select id="selType" name="selType" class="form-control" onchange="hideDiv()">
                                                <option value="N" <%#@~^EwAAAA==r6Pd:Xa+P{PrHJ,Y4+	4gUAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Normal</option>
                                                <%#@~^igMAAA==@#@&d7idiPP,P,~P,P~P,P~~,PP,~P,PP,~~Pi?Y~DdO;?PXanP{PdnM\+. ;DnlDn}4%mD`Jzf}9AcInmKD[jYJ*~P,P@#@&77didid7d7~,P~P,~P,P~~k?pJ~{PE/smO,e,0DK:,^/DX2+,h4nM+PUPb:j?,x~BzB,J~@#@&7id7di7did~~,PP~~,P~P,.kY/UKHw+cranx,/jpd~~^KxxB~&BP&@#@&7didid7d77,P~P,~P,P~~,k0~UKY~DkO;?PHwR+K0,Otx@#@&id77iddi7diddi9GPStbVnPUGDP./D/?:X2nc+WW@#@&d7di7,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~7dM+kwGxdnch.kDnPr@!G2DkWU~7lsExEJ~LPM/Y;?:zw`E?`APeh2J*~[,JBr~@#@&idid7d77id7di7db0~d:Xwn~{P./D/UKza+vJ?`A:enAJbPDtnU@#@&di7diddi77didid7DndaWU/ hMkOn,JPdn^+^Y[r@#@&ididdidi7did7di+U[,k0@#@&diddi77didid7d7./2W	d+ch.rD+PE@*rP'PMdDZj:Xa+`r?`$KIn3J*P'~r@!zK2YbWx@*E@#@&idid7d77id7di7d@#@&77idd~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PPi./DZ?:z2+c:K\nxnaD@#@&di7diP~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,dJGKw@#@&7didd,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~PU9Pr6@#@&ddidi~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,w/VKd+:l8s/`.dDZjKH2#@#@&diddiP,~P,P~P,P~~,PP,~P,PP,~~P,P,P7QAAA==^#~@%>
                                            </select>
                                        </div>   
                                   </div>
                                   <!--/.form group -->
                                   
                               	   <%#@~^GAAAAA==r6PdV:XwP@!@*Pr1EPDtnU8AYAAA==^#~@%>
                                   <div id="divType" style="display: none"> 
                                   <%#@~^BAAAAA==n^/nqQEAAA==^#~@%>
                                   <div id="divType">	
                                   <%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>							
	                                   <!-- form group -->
			                           <div class="form-group">
			                           
			                           		<!--Extra Coupon From Date-->
					                        <div class="col-sm-3" >
					                        <label>From Date :</label>
					                            <div class="input-group">
					                                <input id="dtpDate" name="dtpDate" value="<%=#@~^EQAAAA==WGlOVKxovND9lD+bOwYAAA==^#~@%>" type="text" class="form-control" date-picker >
					                                <span class="input-group-btn">
					                                    <a href="#" id="btndt_date" class="btn btn-default" style="margin-left: 0px">
					                                        <i class="fa fa-calendar"></i>
					                                    </a>
					                                </span>
					                            </div>
					                        </div>
					                        
											<!--Extra Coupon To Date-->
					                        <div class="col-sm-3" >
					                        	<label>To Date :</label>
					                            <div class="input-group">
					                                <input id="dtpToDate" name="dtpToDate" value="<%=#@~^EwAAAA==WGlOVKxovNDPWGlO+*/gYAAA==^#~@%>" type="text" class="form-control" date-picker >
					                                <span class="input-group-btn">
					                                    <a href="#" id="btndt_Todate" class="btn btn-default" style="margin-left: 0px">
					                                        <i class="fa fa-calendar"></i>
					                                    </a>
					                                </span>
					                            </div>
					                        </div>  
					                 
									   </div>
									   <!--/.form group -->
								   </div>
								   
								   <!-- form group -->
                                   <div class="form-group">
                                   
                                   	    <!--Department-->
                               		    <div class="col-sm-3" >
                               		   	   <label>Department :</label>
										   <div class="input-group">
				                               <input class="form-control" id="txtDeptID" name="txtDeptID" value="<%=#@~^BwAAAA==dG+2DqGjQIAAA==^#~@%>" maxlength="6" style="text-transform: uppercase" input-check  >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('DEPT','txtDeptID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>

                                        </div>
                                   
                                       <!--Grade-->
                               		   <div class="col-sm-3" >
                               		   	   <label>Grade :</label>
 										   <div class="input-group">
				                               <input class="form-control" id="txtGradeID" name="txtGradeID" value="<%=#@~^CAAAAA==dVDC9+&f4wIAAA==^#~@%>" maxlength="6" style="text-transform: uppercase" input-check >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('GRADE','txtGradeID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>
                                       </div>
                                       
                                       <!--Join Date-->
                               		   <div class="col-sm-3" >
                               		       <label>Join Date :</label>
 										   <div class="input-group">
				                               <input id="dtpJoinDate" name="dtpJoinDate" value="<%=#@~^FQAAAA==WGlOVKxovNDBWbx9lD+bywcAAA==^#~@%>" type="text" class="form-control" date-picker >
					                                <span class="input-group-btn">
					                                    <a href="#" id="btndt_Joindate" class="btn btn-default" style="margin-left: 0px">
					                                        <i class="fa fa-calendar"></i>
					                                    </a>
					                                </span>
	                                       </div>
                                       </div>


                                  </div>
                                  <!--/.form group -->
                                  
							      <!-- form group -->
								  <div class="form-group">
  
                                       <!--Cost Center-->
                               		   <div class="col-sm-3" >
                               		   	   <label>Cost Center :</label>
 										   <div class="input-group">
				                               <input class="form-control" id="txtCostID" name="txtCostID" value="<%=#@~^BwAAAA==d;WdDqGmQIAAA==^#~@%>" maxlength="6" style="text-transform: uppercase" input-check >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('COST','txtCostID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>
                                       </div>
                                       
                                       <!--Employee Contract-->
                               		   <div class="col-sm-3" >
                               		       <label>Contract :</label>
 										   <div class="input-group">
				                               <input class="form-control" id="txtContID" name="txtContID" value="<%=#@~^BwAAAA==d;WUDqGlAIAAA==^#~@%>" maxlength="6" style="text-transform: uppercase" input-check >
		                                       <span class="input-group-btn">
		                                            <a href="#" name="btnSearchID" id="btnSearchID" class="btn btn-default" onclick="fOpen('CONT','txtContID','mycontent','#mymodal')">
		                                               <i class="fa fa-search"></i>
		                                            </a>
		                                       </span>
	                                       </div>  
                                       </div>
                                       
                                 	   <!--Add Button-->
				                       <div class="col-sm-4" align="LEFT">
				                        	<label></label>
				                      		<div class="input-group" >
				                      			 
					                       		<button type="button" name="sub" value="reset" class="btn btn-info" style="width: 94px" onclick="txtReset();">Clear</button>
					                       		&nbsp;
					 							<button type="submit" name="sub" value="filter" class="btn btn-info" style="width: 94px">Filter</button>
					 						</div>
				 					   </div>

								   </div>
	                               <!--/.form group -->
  
								   <!-- form group -->
                                   <div id="selList" class="form-group" style="overflow:auto;padding:0px;margin:0px">
                                    	<table id="example1">
                                        <tbody>
                                            <tr>
                                                <td width="2%"></td>
                                                <td width="5%" style="padding: 7px"><b>Unassigned Employee(s) :</b>
                                                    <select multiple size="15" style="width: 405px;" name="FromLB" id="FromLB" ondblclick="move(this.form.FromLB,this.form.ToLB)">
                                                        <%#@~^FQoAAA==~,@#@&,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,?nY,.kYjVmY,',d+M\nDcZ.nmY+}8LmYvE)f}f~R]+^GMNj+DE#,P~~,PP~@#@&d7di7id7ididdi/U}S,'~Jk+sn1YPC~0MW:,Oh+sw^X~h4nM+~F{qPr@#@&@#@&PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~PbWPkfn2Dqf~@!@*PEJ,O4+U@#@&iddidi7did7did7dUpS,xPk?pd~'Prbgf~f3K:{(f,xBrP'~aIK(Hv/9+aO&fb,[,JBr@#@&7did7did77iddinx9Pk6@#@&didid7d77id7di@#@&id77idd77id7dir6PdVDmN+&f,@!@*,JEPDtnU@#@&di7diddi77dididd?}J,'~/U}S,[~Ez1f~!"b92|(GPxEJ,[PaI:(1v/!DmNn(G#PL~JEJ@#@&77didid7d77id7+	[Pb07@#@&dd77id7di7id7i@#@&ddidi7did7did7r6P/;G/Dqf,@!@*PrJ,Y4+U@#@&d7di7did77idd77k?}S,x,/j5S,[Prbg9P;rjK|q9~{BJ,'PaIK&Hc/;WkY(fb~LPEBr@#@&id77idd77id7din	N~b0@#@&didi7did7did77@#@&di7diddi77didikWPd/KxOqG~@!@*PEE,YtnU@#@&7di7id7ididdidid?5S~',/j}dP[,EbgfP;6HK|qGPxBE~LP2I:(1v//G	Yq9b,[~JEE@#@&7ididdidi7did7+	N~r6@#@&i7diddi77didid@#@&77id7di7did77ik0~[D9Gk	9mYn,@!@*PJrPD4+	@#@&did77iddi7diddidjpdP{Pd?}J,[~JzHf,fPmxrqH~@*'vJ,',0[mY `9YxGk	fCY#~',JBr@#@&iddi77didid7d7n	N~k6@#@&id77idd77id7di@#@&d7ididdidi7didd?5S~x,/?5JPLPJ,G.ND,4zP3\h{/rG3Pm/^E@#@&P~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,./D?nsmY 6a+UPkj5SS,mKxxBP2SP2@#@&P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PPb0,UWDP./D?nsmYcnW6PY4nU@#@&d,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,NW,A4k^+,xGY~.kYj+^nmDRnG6P@#@&7,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,@#@&7~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~U+Y~.kYHlsn,'~k+M\+MR;.+mYnr(Ln^D`Jz9rGAR"n^WMNU+OJb~,P~@#@&7P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,Pd?5JP{PEdV+^O,1C:~6DGsP:H2tndePStnDP3\h{Z}92,'Br~'PM/D?nVn^D`E2tK{;r93r#P'~rBEP@#@&iP~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~DkOglhR}w+	Pkjpd~~mKxUS,&~,f@#@&dP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,r0,xWD~./D1m:nRnG6POtU@#@&d~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,PdHm:+~x,DdYgCs+cr1m:+r#@#@&d,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,+	[Pb0~P,P~~,P@#@&7P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,wZ^G/Kl(sn/vDkYHlhn*@#@&d@#@&d,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~DdwKxdnchDrOPE@!K2DkG	P7lV!+{vJ,[~DkYjn^+mDcJAHn|/6fAJ*P'PEv@*J~[,./D?nsmYcEAHK{;6G2E*PLPJ,O,EPLPd1m:n~LPJ@!&WaYkKU@*J,P@#@&7P~~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,DkYj+sn1Y :K-+	+aO@#@&d~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~VKW2@#@&PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~PUN,kW~,PP~@#@&P~P,~,P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,PS8gBAA==^#~@%>
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
                                                
                                                <td width="5%" style="padding: 7px"><b>Assigned Employee(s) : </b>
                                                    <select multiple size="15" style="width: 405px;" name="ToLB" id="ToLB" ondblclick="move(this.form.ToLB,this.form.FromLB)">    
                                                    </select>
                                                </td>
                                               
                                            </tr>
                                        </tbody>
                                    	</table>
                                   </div>
                                   <!--/.form group -->
									<!-- box-footer -->
									<div class="box-footer">
										<button type="submit" id="btnUp" name="sub" value="up" class="btn btn-success pull-right" style="width: 90px">Update</button>
										<!-- Coupon -->
												                                    	
										<div id="divType2" class="form-group">
											<label class="col-sm-7 control-label">Subsidy Amount (RM) : &nbsp;<font style="color:red">*</font> </label>
										
											<div class="col-sm-3 " >
												<input  class="form-control" id="txtCoupon" name="txtCoupon" value="" maxlength="10" placeholder="RM" onkeypress='return isNumberKey(event)' style="text-align:right;" >    	
											</div>
										</div>
										
										<div id="divType3" class="form-group">
											<button type="submit" id="btnDel" name="sub" value="del" class="btn btn-danger pull-left" style="width: 90px">Delete</button>
										</div>

										
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
         $('#btnDel').click(function () {
         $('#ToLB').each(function () {
            $('#ToLB option').attr("selected", "selected");
            });
         });

    });
    
    $( document ).ready(function() {
	var type = document.getElementById("selType").value;
	if (type == "N"){
		$("#divType").hide();
		$("#divType2").show();
		$("#divType3").hide();
	}else{
		$("#divType").show();
		$("#divType2").hide();
		$("#divType3").show();
	}
	});
 	</script>
	
	<!--Onclick Hide Div-->
    <script>
    function hideDiv(){
	var s = document.getElementById("selType").value;
	if ( s == "N"){
		$("#divType").hide();
		$("#divType2").show();
		$("#divType3").hide();
		document.getElementById("selType").value;
		}
	else{
		$("#divType").show();
		$("#divType2").hide();
		$("#divType3").show();
	}
	};
    </script>
        
    <!--Reset Button-->
    <script>
	function txtReset()
	{
		document.getElementById("txtContID").value = "";
	    document.getElementById("txtGradeID").value = "";
	    document.getElementById("txtDeptID").value = "";
		document.getElementById("txtCostID").value = "";
		document.getElementById("dtpJoinDate").value = "";
		document.getElementById("dtpDate").value = "";
		document.getElementById("dtpToDate").value = "";
	}
	</script>
    
	<!--date picker-->
    <script>
    $('#btndt_date').click(function () {
        $('#dtpDate').datepicker("show");
    });

	$('#btndt_Todate').click(function () {
        $('#dtpToDate').datepicker("show");
    }); 
    
	$('#btndt_Joindate').click(function () {
        $('#dtpJoinDate').datepicker("show");
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
  	    
  	    var search = document.getElementById("txtSearch");
        if (search != null && search != "") 
        {
            str = str + "&txtSearch=" + search.value;
        }
 			
 			str = str + "&fldName=" + pFldName;
 			
		if (pType=="DEPT") {
	  	    xhttp.open("GET", "ajax/ax_csview_deptID.asp?"+str, true);
	  	} else if(pType=="GRADE") {
	  		xhttp.open("GET", "ajax/ax_csview_gradeID.asp?"+str, true);
  		} else if(pType=="COST") {
  			xhttp.open("GET", "ajax/ax_csview_costID.asp?"+str, true);
		} else if(pType=="CONT") {  		
			xhttp.open("GET", "ajax/ax_csview_contID.asp?"+str, true);
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
	
	$( "#txtDeptID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=DP",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtDeptID").val(ui.item.value);
				var str = document.getElementById("txtDeptID").value;
				var res = str.split(" | ");
				document.getElementById("txtDeptID").value = res[0];
			},0);
		}
	});	
	
	$( "#txtGradeID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=GC",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtGradeID").val(ui.item.value);
				var str = document.getElementById("txtGradeID").value;
				var res = str.split(" | ");
				document.getElementById("txtGradeID").value = res[0];
			},0);
		}
	});	
	
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
	
	$( "#txtContID" ).autocomplete({
		delay:0,
		maxShowItems: 6,
		source: "intelli.asp?Type=CT",
		select: function (event, ui) {
			setTimeout(function() {
				$("#txtContID").val(ui.item.value);
				var str = document.getElementById("txtContID").value;
				var res = str.split(" | ");
				document.getElementById("txtContID").value = res[0];
			},0);
		}
	});	
    </script>
    
	<!--Script End-->
</body>
</html>
