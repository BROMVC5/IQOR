<%@ LANGUAGE = VBScript.Encode %>
<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%#@~^PwcAAA==@#@&P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P@#@&b0~khCoPx~rJPO4x@#@&irhlLP{PF@#@&UN,kW@#@&/)[9jId~',J[aCL+{J,[~kKCT+~[,E[D6OjlD^4{J~[,dU+CMm4@#@&@#@&Gr:,nCoSnUBnlTn1K~KKOCV"+1W.NSPKYCVhCo~rUDqf@#@&GkhPhCT+jDlMY~hlTn2	N@#@&,P~~,PP,~P,PP,~~P,P,P~P~~,P~P,~P,P~~,PP~@#@&k]+1/KEUDP{PFZ@#@&@#@&hlL+d+U~{Pk"nm;WE	O@#@&@#@&b0~Dn5!+dYvEnmonE*P@!@*~rJ~l	[,Y.b:vD+$EdYvJ8Y	?;8skYrb#,'PrE~Y4+	@#@&P7r;E.nmL+,'~.;EndD`EnmLJb@#@&V/@#@&~dbZ;DhlLn,'P8@#@&xN,rW@#@&@#@&YaYjnmD^t,xPDDrhvD+5;/O`rOXYjlMmtr#*@#@&b0~YXYjnmDm4~@!@*PJr~Otx@#@&7?^jDD~',O6D?nCMmt@#@&,djmUOMPx,DwVmmc?1?ODBJvEBJBEE#@#@&P,7d;^{8PxPEA4+.+,c+	YrO^+:nUDPsk0n,BYrPLP?1?D.PLPE]E#~E@#@&+	[Pb0@#@&@#@&/$V,'~Jdn^+^Y,nxDkOs:+UOBPdYmO!/~6DK:Pt?AHKIn3Pr@#@&r6P/$s{8P@!@*~EJ,Y4+U@#@&7k;sP{~/$V~',/;sm8@#@&+	[,kW,@#@&/;^P{~/$V~[,JG.9+D,8X,+xDrOV:xOPCd1PE@#@&@#@&k+O~M/Y3U:X2+,x,/nM\DR1DCYW8LmOcrlNK[4cD+1G.Nk+DJb@#@&.kY3x:zwR^;M/W.OHwnP{~mN6a+	?YmYb^@#@&DdYAxPza+R1;DkWD^G^lDkKx~'~C9jd+;skxO@#@&D/O3	Kzw ^W^0YHw+,',CNdW^3~lO^4rwDr:b/Yb^@#@&M/D2UKz2R2lTn/byn~{PnCLSnxi7@#@&.kYAxKHw ra+UPk;sS,mW	U~,&~,f@#@&@#@&EeMeMMCeMeCMeCeMM,nlLr	o&nmLbxCDkKxP;l^^E^lOWMPMMCeeCMeCeeCMMeE@#@&qWPUGDP./D3x:X2nc+WW~Dtnx@#@&,d.kYAxKHw l(/GV!Yn2mo+,xPbZEMKCo@#@&P7kKCT+/W!UY,'~.kY2UPHwnRhCT+/KE	Y@#@&+	[Pb0~@#@&@#@&Kmo+gGP{PI5;+kYcp;+.zUY.k	L`rnCLJ#@#@&b0~nmL1G,',JJ,K4nx,nCo1G~{PF@#@&KKYl^]nmKD9PxP.dD2UKH2+cIn^KDN/G!xO@#@&KmonUYmDY,',c`hlL+d+UMhloHW*OnmLnSx*@#@&nCL2UN,xPhlLnd+x@#@&@#@&(0,PKYC^ImWMN,@!',nCoSnU,KtU@#@&dKKOCVhlT+~'q@#@&2s/(0,`PGDlV]n1W.N,\KN~hlT+Sx,xPZ#~K4+U@#@&dKKOl^nlTn~'vKKYCV]n1W.NJKlT+Jn	#@#@&3^/n@#@&7:WOmVhloP{cKKYCV"+^GMNzhCoS+	b@#@&ik6PPWOC^nCo~@*,ZrUD`KGOmVKlTn*PO4+	@#@&id:GYmVKlT+~x,Zk	O`:WYmsKlT+*_q@#@&7Vd+@#@&diKGOmVnCLPxP;r	Yc:WDlVhlTn#@#@&7+	N~r6@#@&AUN,q0@#@&veCeCeMeMMCeMeCMP;VGdPr8%mOPmU9P6a+	P1h,]+1W.NU+O~CeeCMeCeeCMMeCeE@#@&@#@&r,'~!@#@&0/sBAA==^#~@%>
    <div class="col-sm-12" style="overflow:auto;padding:0px;margin:0px">
    <br />
    <table id="example1" class="table table-bordered table-striped">
        <thead>
            <tr>
                <th style="width:5%">No</th>
                <th style="width:20%;">Entitlement Type</th>
				<th style="width:10%; text-align:center;">Status</th>
                <th style="width:10%;text-align:center">Edit</th>
            </tr>
        </thead>
        
        <tbody>
            <%#@~^xgQAAA==@#@&P~,P,PP,P,~P,P~P,P~~,PP,~P,PP,~~P,P,P~P~@#@&P~P,~P,P~~,PP~~,NGPS4bVn,xKYPM/D3x:X2+c+GW,lx9~k,@!Pb]nm;W!xO@#@&~,P~P,~P,P~~,PP~~,P~P,~,P~,P,PP,P,~P,P~P,P~~@#@&P,~P,PP,~~P,P,P~/i]dPxPr'wmonxrP[~Kmon1K~LPELYXY/lM^t{J~[,YaOU+lM^t@#@&P,~~P,P,P~P~~,P~k,xPbPQ~8PP~~,P~P,~@#@&@#@&P,PP,P,~P,P~P,P~./wKU/RhMrO+,J@!Y.@*E@#@&P~P,~P,P~~,PP~~,Dn/aG	/nchMkYPr@!Y9@*EPLPr~3P`vKlT+1KRq#CnmonSnU*P'Pr@!zDN@*E@#@&P~~,P~P,~,P~,P,PD/aGxk+ hMkOn,J@!D[@*rP[,i^lk+vDdY3U:X2+vE2gK(Pd2H3H:Jb#,',J@!JY9@*J@#@&i7dikWPM/O3	KXan`r?KzPi?r#,'~JeE,Y4+	@#@&,P~~,PP~~,P~P,~id./aWxk+cADbYnPr@!O[,/YHs+{JJDnaY l^kLxl^xO+MEJ@*@!8~kYXsn{B^W^GM)LM+xB@*b1Ok7+@!z(@*@!&DN@*r~@#@&PP,~~P,P,P~P~~,PnVkn@#@&P~~,PP~~,P~P,~,P7M+kwW	/ hMkO+,J@!O9P/DzV'JrOn6DOmVroUl1+UY.Jr@*@!8,/Yzs'vmKsKDlM+9B@*&xm^Yb\n@!J4@*@!JYN@*EP@#@&di77+	N,kW@#@&~,P~P,~P,P~~,PP~./2W	dRAMkD+Pr@!D[PkYzV'EESkND4)y]iDnaY l^kLxl^xO+MEJ@*@!C~4D+WxE:d+	OHwn|NYRm/a_wmon'r[~Kmo+gGPLPJLOaYk+mD^txE,[~YXO?l.^4P[~ELYaYAU|1Cs+{J[,DkO2	Kzw`E3gKq:J2t21:EbPLPrB@*@!rhTPdD1xJrNrdDzkhLJ+[kDRyO+WRaxorJ,&@*@!zC@*@!zO[@*J@#@&~P,PP,~~P,P,P~P~./2W	d+ch.rD+PE@!JY.@*r@#@&P~,P,PP,P,~P,P~PM/O3	KXanRsW\Un6D@#@&d@#@&~~,P~P,~P,P~sKWw@#@&,P~P,~,P~,P,ml^V,2Z^Wd+:l8s/`MdYAxKH2n#@#@&@#@&~P~~,P~P,~P,KiUBAA==^#~@%>                     
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
