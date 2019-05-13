<!-- #include file="../include/connection.asp" -->
<!-- #include file="../include/adovbs.inc"-->
<!-- #include file="../include/proc.asp"-->

<%
sEmpCode = request("txtEmpCode")
sDtWork = request("txtDtWork")

Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
sSQL = "select * from TMEMPLY where EMP_CODE ='" & sEmpCode & "'" 
rstTMEMPLY.Open sSQL, conn, 3, 3
if not rstTMEMPLY.eof then
    sName = rstTMEMPLY("NAME")
end if

sSQL = "select * from TMCLK2"
sSQL = sSQL & " where EMP_CODE = '" & sEmpCode & "'"
sSQL = sSQL & " and DT_WORK = '" & fdate2(sDtWork) & "'"
set rstTMClk2 = server.createobject("adodb.recordset")
rstTMClk2.Open sSQL, conn, 3, 3
if not rstTMClk2.eof then
%>
<section class="content">
    <div class="row">
        <div class="col-sm-5">
            <div class="pull-left">
                <h3>Abnormal Details</h3>
            </div>
        </div>
        <div class="col-md-12">
            <div class="box">
                <div class="box-body ">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Employee Code : </label>
                        <label class="col-sm-3 control-label"><% response.write sEmpCode %> </label>
                        <label class="col-sm-3 control-label">Shift Code : </label>
                        <label class="col-sm-3 control-label"><% response.write rstTMCLK2("OSHF_CODE") %> </label>
                       
                    </div>
                    <div class="form-group">
                        <%  Set rstTMShfCode = server.CreateObject("ADODB.RecordSet")    
                            sSQL = "select * from TMSHFCODE where SHF_CODE ='" & rstTMCLK2("OSHF_CODE") & "'" 
                            rstTMShfCode.Open sSQL, conn, 3, 3
                            if not rstTMShfCode.eof then
                                sSTIME = rstTMShfCode("STIME")
                                sETIME = rstTMShfCode("ETIME")
                            end if
                         %>
                        <label class="col-sm-3 control-label">Name : </label>
                        <label class="col-sm-3 control-label"><% response.write sName %> </label>
                        <label class="col-sm-3 control-label">Start Time : </label>
                        <label class="col-sm-3 control-label"><% response.write sSTIME %> </label> 
                       
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Work Date : </label>
                        <label class="col-sm-3 control-label"><% response.write sDtWork %> </label>
                        <label class="col-sm-3 control-label">End Time : </label>
                        <label class="col-sm-3 control-label"><% response.write sETIME %> </label> 
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">Time In : </label>
                        <label class="col-sm-3 control-label"><% response.write rstTMCLK2("OTIN") %></label>
                        <label class="col-sm-3 control-label">Time Out : </label>
                        <label class="col-sm-3 control-label"><% response.write rstTMCLK2("OTOUT") %> </label>
                    </div>
 
       <br />

    <table id="example1" class="table table-bordered">
        <thead>
            <tr>
                <th style="width:18%;text-align:center">Approved Shift Code </th>
                <th style="width:15%;text-align:center">Approved Time In </th>
                <th style="width:15%;text-align:center">Approved Time Out </th>
                <th style="width:15%">Comment</th>
                <th style="width:15%">Approved By</th>
                <th style="width:15%">Approved Date Time</th>
            </tr>
        </thead>
        
        <tbody>
            <%
                response.write "<tr>"
                if not isnull(rstTMClk2("1DTAPV")) then 
                    response.write "<td align='center'>" & rstTMClk2("SHF_CODE") & "</td>"
                    response.write "<td align='center'>" & rstTMClk2("TIN") & "</td>"
                    response.write "<td align='center'>" & rstTMClk2("TOUT") & "</td>"
                else
                    response.write "<td align='center'></td>"
                    response.write "<td align='center'></td>"
                    response.write "<td align='center'></td>"
                end if

                Set rstTMEMPLY = server.CreateObject("ADODB.RecordSet")    
                sSQL = "select * from TMEMPLY where EMP_CODE ='" & rstTMClk2("1APVBY") & "'" 
                rstTMEMPLY.Open sSQL, conn, 3, 3
                if not rstTMEMPLY.eof then
                    s1ApvName = rstTMEMPLY("NAME")
                end if
                response.write "<td>" & rstTMCLK2("ABCOMMENT") & "</td>"
                response.write "<td>" & s1ApvName & "</td>"
                response.write "<td>" & rstTMCLK2("1DTAPV") & "</td>"
                response.write "</tr>"

            %>                     
        </tbody>
        
    </table>
                </div> <!-- class="box-body " -->
            </div> <!-- end class="box" -->
        </div> <!-- end class="col-md-12" -->
    </div> <!--end class="row"-->
</section>
<%end if %>
    