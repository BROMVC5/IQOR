<%@ LANGUAGE = VBScript.Encode %>
<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%#@~^8QcAAA==@#@&P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~@#@&kWPbKlT+~x,JJ~O4+U@#@&7bnCT+,'P8@#@&nx9Pr0@#@&d)9Nj"JP{PJL2Co'rP'PrKmonPL~JLYaOU+l.^4'EPL~k?nmD1t@#@&@#@&9ksPKlT+Jn	~nmL+gW~:GOl^ImGD[S:WOl^KlT+Sr	Yq9@#@&fr:,KmonUYmDYBnmL+Ax[@#@&P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~@#@&rI^;W;	Y,'P8!@#@&@#@&nCoSnU,'Pb]+1ZW!UO@#@&@#@&kWP.n$En/DcJhlLnr#P@!@*,JEPmU9POMks`D;!n/D`E4Dxj;(:kDE#*P',EEPDtx@#@&~7bZ;DhCoPx~M+;;nkYcJhCT+E*@#@&+Vk+@#@&Pik/EMnCLP',q@#@&+x9~r0@#@&@#@&O6Ojl.m4~',Y.rs`Dn5!+dYvED6OU+mDm4J*b@#@&kWPD6OjlD14P@!@*PrE~Y4+	@#@&dj^UY.P{~YXYjnmDm4@#@&P7?1jDD~{PM+w^l1n`UmjYM~Evr~JEvJ*@#@&,~7/$V|F~'~EStnD~`AHKm;rf3~^kV+,vuJ~LPUm?DD,'Pr]v#,J@#@&i/;^mF,'Pk5s{8PLPEW.~v2\n|Hbt2~sb3+~vuJ~[,j1?OMPLPJuB*~J@#@&7/$Vmq,'Pk5V|FPL~EWMPvK(ZF3:{Hr,sk0+~vuJP'~UmjYM~LPEuB*PJ@#@&UN,kW@#@&@#@&d$VP{~Jk+V^OPzj:r(1/S,K(Zn3K|16S,2HKm;r92B~AHK|1zH2BPAHK&KJ2t2HPBPnze{:5nAS~Zdb&H)~~9:{/Sz(H,0.GsPHjj:bos;~r@#@&b0,/;^{8~@!@*PEJ,Y4n	@#@&id;^P',d5V,[,/5Vmq@#@&nx9~k6P@#@&k;V~x,/5V,',JGMNDP(X,Pq;|3K|16~9+/1~J@#@&@#@&dnY,DkY3xPza+~',d+M\n.cmDnCD+G4Nn1Ycrl9WN(RMnmKD[/YEb@#@&DkO2	KXan m!DkW.Yz2PxPm[ra+UjDlYr^@#@&./D3	Kza+cmEM/K.VKmCYbWU~{Pl9i/ZVbnUY@#@&M/O2UPHwnR^Gm0Yz2P'~C9SGm0$mY^4raYkskkOk1@#@&DkY3U:Xw wmo+kr"+,',nConJx7d@#@&DkY3U:Xwn }wnx,d$VS,mKxxBP2SP2@#@&@#@&BMMCeeCMeCeeCMMeCPhlLkULJnCobUlDkGU,Zls^!VCYK.,eMCeCeeCeCMeCeMB@#@&(W,xWD~DkY2	PzwRWWPO4x@#@&,7DkY3U:Xwn m4dW^;D+2moP',k;;DhlL+@#@&~7bnlTnZKExD~xPM/D2UKz2RKlTnZKEUO@#@&+U[,kWP@#@&@#@&Kmo1W,',]+$En/DR};DXUODbxovEKlT+r#@#@&rW,nCoHW,'~ErPK4n	PKlTngW~{P8@#@&:WDCV"+^WMN~x,D/D3x:Xw ]+1WMN/W;UD@#@&nmL+UYC.DP'~cvnCoJxMhlT+1K# KlT+J+	#@#@&hlo3x9P',KCoSx@#@&@#@&&0~KKOl^In^KDN~@!{PKlTnd+U,K4+x@#@&iPWDlsnmon~{F@#@&3Vk+q6~cKKYmV]+^GMN~HK[PhlLnd+x~x,!bP:4x@#@&d:WYmVhCoPx`:WOC^I+1GD9znmLnSx*@#@&2sd@#@&d:GYmVKCT+Pxc:WOl^]mGMNJnlT+dnx*@#@&db0~PKYl^KlT+P@*~/k	YvKGYCshlL+*~Y4+U@#@&ddPGDlsnmLPx,ZbxYvKKOl^nCo#Qq@#@&ds/@#@&i7PWDl^nCon~{P/k	O`:WOC^nlLn*@#@&dU9Pr6@#@&2x9P&W@#@&BMeCeMMCeeCMeCee,/sWk+,r8Ln^DPCx9~ra+U~g+h~]mGD9jY~CeCeeCeCMeCeMeCB@#@&@#@&k,xPZ@#@&9yICAA==^#~@%>
    <div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
    <br />
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width:3%">No</th>
				<th style="width:5%;">Ticket No</th>
                <th style="width:10%;">Employee Code</th>
				<th style="width:20%;">Employee Name</th>
				<th style="width:12%;">Entitlement Type</th>
				<th style="width:9%;">Pay Type</th>
				<th style="width:6%;text-align:right">Amount</th>
				<th style="width:5%;">Date Claimed</th>
                <th style="width:3%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%#@~^FAYAAA==@#@&P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~@#@&P~P,~P,P~~,PP~~,NGPS4bVn,xKYPM/D3x:X2+c+GW,lx9~k,@!Pb]nm;W!xO@#@&~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~@#@&P,~P,PP,~~P,P,P~/i]dPxPr'wmonxrP[~Kmon1K~LPELYXY/lM^t{J~[,YaOU+lM^t@#@&P,~~P,P,P~P~~,P~k,xPbPQ~8PP~~,P~P,~@#@&@#@&P,PP,P,~P,P~P,P~./wKU/RhMrO+,J@!Y.@*E@#@&P~P,~P,P~~,PP~~,Dn/aG	/nchMkYPr@!Y9@*EPLPr~3P`vKlT+1KRq#CnmonSnU*P'Pr@!zDN@*E@#@&d77iDn/aG	/nchMkYPr@!Y9@*EPLP.dD2x:zw`J:(/|AK|16Jb~LPE@!JON@*J@#@&,PP~~,P~P,~,P~,PM+/aW	d+ch.kD+~E@!YN@*EPLPDkO3x:Xa+cJ3\h{/rG3J*P'~r@!zO[@*J@#@&i7id./aWxk+cADbYnPr@!O[@*JPL~DkY2	Pzw`r2\nmHzH3J*~[,J@!&DN@*E@#@&d7di./2Kxk+RSDbO+,J@!Y9@*E~LPDkO2	KXancJA1:qPS3\A1PJ*~[,J@!&DN@*E@#@&d7dir6P.kYAxKHwcJhbe{:5K3r#P{~JtJPD4nx@#@&,P~P~~,P~P,~P,P77M+/2G	/nRS.bYn,J@!YN@*Zmdt@!zON@*J~@#@&PP,~P,PP,~~P,P,PnVdn@#@&~P,~P,P~~,PP~~,P7DdaWUk+chDbY~J@!Y[@*;Dn[bYP;CD9@!zD[@*J,@#@&d7d7n	N~k6@#@&id77M+/2G	/nRS.bYn,J@!YN,/DzV'EJD+aO lVbLx=DkT4OirJ@*J~[~2wW.:mOfmc.kY2UPHwn`r/db(tbr#~y#,'Pr@!&Y9@*E@#@&ddi7D/wKUd+chMkO+~E@!Y[@*r~[,DdOAxKz2`Ef:m;S)&Hr#PLPr@!zDN@*J@#@&~~,PP,~P,PP,~~P,D/2WUdRADbO+,J@!O9P/Oz^+xJrAbNO4)y]iD+XOOmVro	)^n	Y+MEJ@*@!l,4.+6'E:d/OC60^{9nYcld2QwlLn{J'PhCT+HKPLPJLYXO/l.m4'E~LPYXO?lD14~[,JLYaY3ha{(f{E[,DdOAxKz2`E2tK|Z6G2r#PLPr'YXYPk13nO|1W{E[,D/D3UKHw`EK(/n2P{g6J*P'~r[YaOzEOW&U1'ELPM/YAx:zw`Eb`K6(gZJ*~[,JB@*@!r:TPkD^'EE9kdYJr:Tzn[bYO+Ryc w	LrJ~J@*@!zl@*@!JON@*J@#@&,P~~,PP,~P,PP,~~D/aWU/n SDrY~J@!zO.@*J@#@&~,P~P,~,P~,P,PP,DkO2	KzwRhG7+xaY@#@&d@#@&~P,P,P~P~~,PsWK2@#@&P~~,PP~~,P~P1C^V~aZ^W/Km8V/cDkY3U:Xwb@#@&@#@&,~~P,P,P~P~~J3gBAA==^#~@%>                     
        </tbody>
        
    </table>
    </div>
    <br />
    <div class="row">
        <div class="col-sm-5" style="margin-top:5px">  
            TOTAL RECORDS (<%=#@~^CwAAAA==PKYC^ImWMNYwQAAA==^#~@%>) <%=#@~^BwAAAA==sT{2mozwIAAA==^#~@%> <%=#@~^BgAAAA==KmongWOgIAAA==^#~@%> / <%=#@~^CQAAAA==PKYC^nmo+gQMAAA==^#~@%>
        </div>
        <div class="col-sm-7">
            <div class="dataTables_paginate">
                <ul class="pagination">
                    <%#@~^GgAAAA==(wP/bxD`nmoHW*P@*P8PO4xPZgcAAA==^#~@%>
                        <li class="paginate_button"><a href="javascript:showContent('page=1');" class="button_a" ><< First</a></li>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=#@~^CAAAAA==KmongW FmAIAAA==^#~@%>');" class="button_a" >< Back</a></li>
                    <%#@~^BgAAAA==3	N~&sxgEAAA==^#~@%>
				
                    <%#@~^GgAAAA==oKD~bxDqf,',qP:W~KKYCshloUQgAAA==^#~@%>
                    <%#@~^RgAAAA==~b0~vk	YqGP@*xPvZrxD`KCT+1KbO2##,CUN,`bxOq9~@!'~`;rxD`KCT+1Gb3&b#,P4+UiRMAAA==^#~@%>
                        <%#@~^HQAAAA==~b0~bxDqf,',/k	YcnmonHK#P:4+	LAkAAA==^#~@%>
                            <li class="paginate_button active"><a href="#"><%=#@~^BQAAAA==r	Y(G2AEAAA==^#~@%></a></li>
                        <%#@~^BAAAAA==3^/niQEAAA==^#~@%>
                            <li class="paginate_button"><a href="javascript:showContent('page=<%=#@~^BQAAAA==r	Y(G2AEAAA==^#~@%>');" class="button_a" ><%=#@~^BQAAAA==r	Y(G2AEAAA==^#~@%></a></li>
                        <%#@~^BgAAAA==3	N~&sxgEAAA==^#~@%>
                    <%#@~^BgAAAA==3	N~&sxgEAAA==^#~@%>
                    <%#@~^BAAAAA==H6OnwEAAA==^#~@%>

                    <%#@~^IgAAAA==(wP/bxD`nmoHW*P@!P:WOC^nlTnP:t+	~lAoAAA==^#~@%>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=#@~^CAAAAA==KmongW3FlgIAAA==^#~@%>');" class="button_a" >Next ></a></li>
                        <li class="paginate_button"><a href="javascript:showContent('page=<%=#@~^CQAAAA==PKYC^nmo+gQMAAA==^#~@%>');" class="button_a" >Last >></a></li>
                    <%#@~^BgAAAA==3	N~&sxgEAAA==^#~@%>
                </ul>
            </div>
        </div>
    </div>
    
    <!-- /.box -->
