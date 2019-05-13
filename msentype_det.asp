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
    
    <%#@~^IgoAAA==@#@&dd:Xa+P{PMn;!+dYvJOaDKXanJ*@#@&,~~Pk2	{Hlhn,'~j;C/`.n$E+dOvJO6D3	{Hm:J#*@#@&7@#@&dr0,/3U|1lsnP@!@*PrE~Y4+	@#@&P~~,P~P,d2	{HCs+Px~k2U{gCs+@#@&P,PPVkn@#@&P~P,P~~,/2	m1m:+,x~j;lk+cDn5wW.:vEYXY3U|1lhnr#b@#@&~,P~x9Pk6@#@&@#@&,P~PkHG[?E(~',D+$;n/D`r/;4Eb@#@&~P,~/U+C.1tPx~M+5EdD`ED6D?+mD14J*@#@&P,P~rhlo~',I+$;n/D`rnConE*@#@&P,~P@#@&~~,P/\CbxiId~{PEs/xYHw lkw_J@#@&7@#@&PP,~/zNN`]JP{PrYaYjnmD^t{EPLPdnM\+. 4YhVU1W[`k?+mD14#,[~JLnCL'J,'PbnlTn~[,JLKzwnxrP'Pr3Kr@#@&~,PP~~,P~P,~,P~,@#@&PP,PbWPkHGN?;8,@!@*,EJ,KtU@#@&,P,P~P~~@#@&7dk3x|1ChP'~.;oWMhvJOXYAx{glsnJ*@#@&di/jOmYEk~',D+$oGDs`r/jYCO!/E#@#@&P,P~~,PP@#@&idr0,dAxmgls+P{PrEPDtnx@#@&77,PP,^l^VPmsnDD4K6cJ3UDkOVh+	Y~^mxxGO,4nPhaYzr#@#@&di+	[Pb0@#@&id77@#@&P,~P,PP,rWPkHKNn?;8,'~J!2J,K4n	@#@&~~,P~P,~,P~,@#@&PP,P,~P,P~P,/j}dP',Ejhfb:3~:k+	Yzwn~U2PPr~P,P~~,PP~~,P@#@&i7i/j5S,'Pk?5JPLPE?:bPiUP',vJ,[Pa]Pqg`k?OlO;k#~[,EBBJ@#@&idddj5S~',dUpJ,[,JfzKAPqt2~',BE~LP0GCYYksn+`gWS`b#~',Jv~r@#@&id7dUpS~x,/jpd~LPE`?AI{&f,xPEJ~[,/ndkkW	cJ`?2"H)HAJ*P'PEvr@#@&P,~P,P~~,PP~dUpJP{~k?}dPLPJqCA]2,2HK&KJ3t21:~',BJ,'~/Ax|1C:n~LPEBr@#@&,P~~,PP~~,P~mKU	RnX+1EYPkjpd@#@&P,P~~,PP@#@&P,PP,~~P,P,P^lss,mGx6rDsAGavJj2[mYnPU;1mnk/6EVeJB~/tlrx`IJ'kbN9iId[JLOaYAx|1C:nxrP'Pk3x|1ChP[~Er#@#@&@#@&,P~,P,PPVknk6PdHKNnj!4P{~Jkl\E~K4+	@#@&P~~,P~P,~P,P@#@&iddjnDP./D3	Kza+,'Pk+M-+MR/DlOn}4L^YvJbG69AcImGD[jYE#,~P,@#@&7id/j}dPxPrdVn1Y,eP6DKhPs/nxDX2n,ht.+,21:(PSAHA1PPxvrP'Pk3x|1ChP[~EEJ~@#@&7id.kYAxKHw ra+UPk?}JBPmKUxBP&B~f@#@&did7kW~	WOPMdYAxPza+RnG6POtU@#@&7ididmmV^~mKxWkM:$GX`JAUYbYVhnxDP:X2+~3XkdY["r~~dtlkUi"S'/z[9j]d[r[YXYAU{glh+{J~',/2	m1m:+,'~Jr#,P@#@&77idnVkn@#@&d77id/j}dPxPrr	/nMY,kxDW,h/xOXa+~cA1K&PSAH2gPSPUKzKi?S~GKmZ"3b:2S/"2bP3|q9#,E@#@&7idid/Upd~',/jpdP'~r\l^;+kP`r@#@&dididd?}J,'~/U}S,[~EEJP'~`mC/caIP&1v/2	{gC:#bPLPEvBJdi@#@&iddi7d?5S,'~/j}dP'PrvJ,[~dUYlO;kP'PrvBJ~@#@&iddidkjpdPxPk?}J,[PrvJ,[P69CYYb:n cHKhc#*~[,JvSr@#@&77id7/U}dPx,/UpS,[,EBrP'Pk+ddbWxvEjU2Ig)\2r#,[~JvE,@#@&di7di/j}dP'~dUpJPL~r#~r@#@&ddidi^W	x +X+^;D+Pkjpd@#@&i77d@#@&id7d7^mVsP1Gx6k.h~W6cEUl-+,j!m^/k0E^"rSPkHCk	j]JL/b9[j"S[r'O6D2	{Hlhn{J~[,d2	{HCs+P'~rJbP@#@&id7i+	NPb0@#@&did2Z^Wdn:l4^n/vD/D3UKHw#@#@&77i@#@&P,~P,P~~,PP~~,@#@&@#@&~,P~,P,PPAx9~q6P@#@&,P~~AxN,(0@#@&P,~~P,P,P~@#@&~,P~?OPM/O3	KX2n,'~/.7+.cZM+lD+}8LmO`rb96GAR"nmKDNUnOJ*P,P~@#@&~,P~/U}S,'~Ek+Vn^DPMP6.K:~s/xYHw~h4+.+,2HP&KSA\2gKP{vEPLPk2U{HCs+~[,EBrP@#@&,PP~.kY3x:za+ }wxPk?5J~,mGx	~~fBP&@#@&P,PP,~~Pb0,xGY~.kY3x:zwRnG6PY4n	@#@&P,~,P~,P,PP,/AU{glh+,'~.kY2	PXa+`r3HK&Kd2\2HPr#@#@&i7dk?OCDE/~x,DdYAU:X2`r?KzK`jJ*@#@&P,P~~,PPUN,k0@#@&~P,PaZsWdn:l8Vd`M/O3	KX2n*@#@&P,~,P~,P@#@&P,P,C3sCAA==^#~@%>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        <!-- #include file="include/header.asp" -->
        <!-- Left side column. contains the logo and sidebar -->
        <!-- #include file="include/sidebar_ms.asp" -->

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Entitlement Type Details</h1>
            </section>
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Horizontal Form -->
                        <!-- form start -->
                        <form class="form-horizontal" action="msentype_det.asp" method="post">
							<input type="hidden" name="txtType" id="txtType" value="<%=#@~^BQAAAA==d:X2FQIAAA==^#~@%>">
                            <input type="hidden" name="txtSearch" value='<%=#@~^BwAAAA==dU+CMm4yQIAAA==^#~@%>' />
                            <input type="hidden" name="Page" value='<%=#@~^BQAAAA==rhlL5gEAAA==^#~@%>' />
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <input type="button" class="btn btn-new" name="btnReturn" value="Back" onclick="window.location = ('<%=#@~^CAAAAA==dtlr	j"S6wIAAA==^#~@%><%=#@~^BwAAAA==dzN[`IdbwIAAA==^#~@%>');" />
                                </div>
                                <!-- /.box-header -->
                                <div class="box-body">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label">Entitlement Type : </label>
                                        <div class="col-sm-7">
                                            <%#@~^GQAAAA==r6PdAx|1ls+,@!@*,JEPDtnU,4gYAAA==^#~@%>
                                                <span class="mod-form-control"><%#@~^IAAAAA==~M+daW	/+chMrYPimm/nck2x|Hls+#,cAsAAA==^#~@%> </span>
                                                <input type="hidden" id="txtEn_Name" name="txtEn_Name" value='<%=#@~^CAAAAA==dAxmgls+BgMAAA==^#~@%>' />
                                            <%#@~^BAAAAA==n^/nqQEAAA==^#~@%>  
                                                <input class="form-control" id="txtEn_Name" name="txtEn_Name" value="<%=#@~^CAAAAA==dAxmgls+BgMAAA==^#~@%>" maxlength="50" />
                                            <%#@~^CAAAAA==~x[,k6PZgIAAA==^#~@%>
                                        </div>
                                    </div>
									<div class="form-group">
                                        <label class="col-sm-3 control-label">Status : </label>
                                        <div class="col-sm-3">
                                            <select name="sStatus" class="form-control">
                                                <option value="Y" selected="selected" <%#@~^FQAAAA==r6PdUYmYEkP{~JIJ~Y4+UzwYAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Active</option>
                                                <option value="N" <%#@~^FQAAAA==r6PdUYmYEkP{~JgJ~Y4+UxAYAAA==^#~@%>Selected<%#@~^BgAAAA==n	N~b0JgIAAA==^#~@%>>Inactive</option>

                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="box-footer">
                                    <%#@~^GQAAAA==r6PdAx|1ls+,@!@*,JEPDtnU,4gYAAA==^#~@%>
                                        <a href="#" data-toggle="modal" data-target="#modal-delcomp" data-work_id="<%=#@~^GwAAAA==dD-DctYsVUmKNn`k2Umgl:bPwoAAA==^#~@%>" class="btn btn-danger pull-left" style="width: 90px">Delete</a>
                                        <button type="submit" name="sub" value="up" class="btn btn-info pull-right" style="width: 90px">Update</button>
                                    <%#@~^BQAAAA==n^/n,yQEAAA==^#~@%>
                                        <button type="submit" name="sub" value="save" class="btn btn-primary pull-right" style="width: 90px">Save</button>
                                    <%#@~^BwAAAA==n	N~b0,RgIAAA==^#~@%>
                                </div>
                                <!-- /.box-footer -->

                                <!-- /.box -->
                            </div>
                        </form>
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

  	    xhttp.open("GET", "msentype_del.asp?txtstring="+str, true);
  	    xhttp.send();
        
    }

    $(document).ready(function(){
        document.getElementById('txtEn_Name').focus();
        }); 
    </script>

</body>
</html>
