<%@ LANGUAGE = VBScript.Encode %>
<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%#@~^ggcAAA==@#@&P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~@#@&kWPbKlT+~x,JJ~O4+U@#@&7bnCT+,'P8@#@&nx9Pr0@#@&d)9Nj"JP{PJL2Co'rP'PrKmonPL~JLYaOU+l.^4'EPL~k?nmD1t@#@&@#@&9ksPKlT+Jn	~nmL+gW~:GOl^ImGD[S:WOl^KlT+Sr	Yq9@#@&fr:,KmonUYmDYBnmL+Ax[@#@&P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~~@#@&rI^;W;	Y,'P8!@#@&@#@&nCoSnU,'Pb]+1ZW!UO@#@&@#@&kWP.n$En/DcJhlLnr#P@!@*,JEPmU9POMks`D;!n/D`E4Dxj;(:kDE#*P',EEPDtx@#@&~7bZ;DhCoPx~M+;;nkYcJhCT+E*@#@&+Vk+@#@&Pik/EMnCLP',q@#@&+x9~r0@#@&@#@&O6Ojl.m4~',Y.rs`Dn5!+dYvED6OU+mDm4J*b@#@&kWPD6OjlD14P@!@*PrE~Y4+	@#@&dj^UY.P{~YXYjnmDm4@#@&P7?1jDD~{PM+w^l1n`UmjYM~Evr~JEvJ*@#@&,~7/$V|F~'~Emx[PvnxDkOs:+UO,Vr3~E]E,[,?mUYM~[,JYB*PE@#@&+x9~k6@#@&@#@&d;^P{PE/nsmOPUYbYsns+xOS,:C61~Bo.mN{k9~,[+kkL~kYCO!/~,CEDWk	^~0MWsP\?3H,J@#@&k5V,'~d$VP'~rPAt.PdDlDE/,@!@*~BgB~J@#@&rW,/;^mF,@!@*,EEPDtx@#@&7d$V~',d;^P'~k;Vmq@#@&nx9~b0~@#@&k;V,',d;^P'PrW.[DP(zPxYbOs+s+	Y~ld^,J@#@&@#@&/Y~.kY2UPHwnP{~k+.7+MRmM+mO+K4%+1YcEmNW98RM+mK.[/Yr#@#@&.dD2UKH2+cm;.kWDOza+~',C9r2xUYlDk1@#@&M/O2	Kz2Rm!./KDVK^CYbW	PxPC[`/nZ^r+	Y@#@&M/Y3U:X2+csKmVDXa+P{Pm[SKmVAmY^4}wYbhkkYk1@#@&DkYAxPX2ncwCodk.+~x,nlLnd+Udi@#@&DdD2	KXa+c6wx~/$VS~1Wx	SP2~P2@#@&@#@&BCeMeMMCeMeCMeCeM~hlorUTzKlTr	lObW	PZmV1;VmYGD,eMMCeeCMeCeeCMMB@#@&&0~xGO,DdYAUKHwn W0~O4+U@#@&~iDdD2	KXa+cC4kWsED+2CT+P{~k;EDhCL+@#@&,drnCLZGE	OP{P.dD2xPza+ nmLZG!xD@#@&x9~k6P@#@&@#@&KCT+1K~',I+$;n/DR5EnDzjDDrxTcJhlLnr#@#@&r6PKlTngW~{PrJP:tUPhlL+gW~x,F@#@&PWDlV"n^WMN,'~DdOAxPXanR"+^GMNZG;	Y@#@&hCT+jDlMYP{PvcnmonSxMKmo+gG# nlTnJ+	#@#@&KlLnAx[P{~nmonJx@#@&@#@&qWP:GDls"+1WD9P@!xPhlL+d+U~:t+	@#@&iKWDCsnmoPxF@#@&AVd+&WPvKGOmVIn^KD[PtG9PKmoS+	P{~!*PPtx@#@&iKWDCVhlo~x`:WDlsIn^KD[zhCoSnU*@#@&3sk+@#@&iPKYC^nmo+,'vPWDlsImG.9znmL+d+x*@#@&db0,KGYCshlL+,@*P;kUOvKWOC^nCob,Y4x@#@&diKKOl^nCoPx~;kxDcKKYl^KCo#3F@#@&7n^/n@#@&7d:WOC^nlLn,'~ZbUD`PKYmVnmob@#@&dnx9PrW@#@&2	[P&0@#@&vMeCeCeMeMMCeMeC~Z^Wdn,r4%n1Y~l	[,r2x,1+SP"nmKD[?Y~MCeeCMeCeeCMMeCB@#@&@#@&r~{PT@#@&Aw8CAA==^#~@%>
    <div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
    <br />
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width:5%">No</th>
                <th style="width:20%;">Entitlement Type</th>
				<th style="width:8%;text-align:right;">Max Claim</th>
				<th style="width:5%;">Grade Code</th>
				<th style="width:10%;">Manager Type</th>
				<th style="width:4%; text-align:center;">Status</th>
                <th style="width:5%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%#@~^8wUAAA==@#@&P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~@#@&P~P,~P,P~~,PP~~,NGPS4bVn,xKYPM/D3x:X2+c+GW,lx9~k,@!Pb]nm;W!xO@#@&~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~@#@&P,~P,PP,~~P,P,P~/i]dPxPr'wmonxrP[~Kmon1K~LPELYXY/lM^t{J~[,YaOU+lM^t@#@&di77@#@&did7/\PHwnP{~Jr@#@&7idd@#@&id7dbW,DdD2	KXa+vEfA?(Mr#~x,JHr~Y4+x@#@&7didi/\Kz2PxPr\l	lLnMJ@#@&7id7+^dkW,DkY2	KH2+vJ92Uq!E*P',EstJPD4nx@#@&id7d7dtKzw~',Jo;	mYrG	lsPtC	lLDr@#@&idi7+	N~k6@#@&7idd@#@&diddb~xPbP3PqP~~,@#@&di7dM+d2Kx/n SDrY~r@!OM@*r@#@&idi7D/2W	/n SDkDnPr@!Y9@*EPLPbPQPcchlL+gGO8#MKmo+Jn	#~[,E@!zO9@*r@#@&idi7D/2W	/n SDkDnPr@!Y9@*EPLP`mC/ncM/O2	PXa+cEA1K(Pd2\2gPr#b,[,J@!JY9@*J@#@&7did.nkwW	d+chDbOnPr@!DN~/Oz^+xJrO+XYRC^koUlMkLtDIrJ@*rPLPwwWMhlDfnmvDdOAxKH2+vJHzp/J*~y#~[~E@!zON@*E@#@&d77iD+d2Kxd+cAMkOPr@!Y9@*r~[,DdYAxPza+`r!Izf2|(9J*PLPE@!&O9@*E@#@&7did.nkwWUdRADbOPE@!Y9@*J,[,dH:X2+,[~E@!zY9@*J@#@&di77k6PM/O2UPHwn`rjKzKijr#Px~r5EPD4x@#@&diddiDdwKxd+ch.rD+Pr@!Y9P/Dzs+{JrYn6ORmVro	lmxOnMJJ@*@!(PdYHs'v1W^WD=oMn+	B@*b1Yr-@!z(@*@!JYN@*E~@#@&did7+sd@#@&di7diDndaWxdnch.kDn,J@!DN,/YHVxJrYn6DOCsbox=^+	Y+MEE@*@!4,/OXsn{B^W^GD=Dn[E@*qUC1Yr\@!J4@*@!zDN@*rP@#@&did7+	N~r6@#@&i7diD+k2Gxk+ch.kOn,J@!Y9~/DXsn{JJAr9Y4)yYpYnXY lVbo	lmxO+MJE@*@!lP4.+6'Bsdnx|NY ld2QwCoxJLPKCT+1G~LPE[DaD/nmD1t'rPL~YXYj+mD^4,[Pr'YXYb!OGq	m{J'P.dD2UKH2+vJ)i:rqH/r#~[,EE@*@!b:TP/Mm{EJ9kdYJkhLJ+NbOOyO W 2xTJrP&@*@!&m@*@!zD[@*r@#@&7idd.nkwGxknch.bYPJ@!zD.@*r@#@&did7.kY2	PXa+RsG-+	+XY@#@&77id@#@&i@#@&,P~~,PP~~,P~VKGa@#@&,P,PP,P,~P,P^l^V~2;VWknKm4VdcDkYAxPX2n*@#@&@#@&~P,P~~,PP~~,73YBAA==^#~@%>                     
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
