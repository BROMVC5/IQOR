//******* To calculate, Total Work, Total OT, Approve OT, Late and Early Dismiss
//******* With Given ShfCode

//Convert a time in hh:mm format to minutes
function timeToMins(time) {
    var b = time.split(':');
    return b[0] * 60 + +b[1];
}

//Convert minutes to a time in format hh:mm
//Returned value is in range 00  to 24 hrs
function timeFromMins(mins) {
    function z(n) { return (n < 10 ? '0' : '') + n; }
    var h = (mins / 60 | 0) % 24;
    var m = mins % 60;
    return z(h) + ':' + z(m);
}

function timeFromMins30(mins) {
    function z(n) { return (n < 10 ? '0' : '') + n; }
    var h = (mins / 60 | 0) % 24;
    var m = 30;
    return z(h) + ':' + z(m);
}

function timeFromMins0(mins) {
    function z(n) { return (n < 10 ? '0' : '') + n; }
    var h = (mins / 60 | 0) % 24;
    var m = 00;
    return z(h) + ':' + z(m);
}

//Add two times in hh:mm format
function addTimes(t0, t1) {
    return timeFromMins(timeToMins(t0) + timeToMins(t1));
}

function calATotalOT(pTotalWork) {

    document.getElementById('selOT').value = "Y";

    var ATotalOT = pTotalWork;

    document.getElementById('txtTotalOT').value = timeFromMins(ATotalOT);

    var i3ATotalOT = ATotalOT / 60; // Divide by 60 will get like 20.578
    var f3ATotalOT = parseInt(i3ATotalOT); // parseInt 20.578 will get 20. 

    if ((i3ATotalOT - f3ATotalOT) > 0.5) {  // minus the 20 will get 0.578

        document.getElementById('txt3ATotalOT').value = timeFromMins30(ATotalOT);

    } else {

        document.getElementById('txt3ATotalOT').value = timeFromMins0(ATotalOT);

    }

}

function calTotal(pTotal) {

    document.getElementById('txtTotal').value = timeFromMins(pTotal);

}


function noOT() {
    document.getElementById('selOT').value = "N";
    document.getElementById('txtTotalOT').value = "00:00";
    document.getElementById('txt3ATotalOT').value = "";
}

function sum() {
    var sShfCode = document.getElementById('txtSHF_CODE').value;
    var sTIN = timeToMins(document.getElementById('txtTIN').value);
    var sTOUT = timeToMins(document.getElementById('txtTOUT').value);
    var sSTIME = timeToMins(document.getElementById('txtSTIME').value);
    var sETIME = timeToMins(document.getElementById('txtETIME').value);
    var sGradeID = document.getElementById('txtGrade_ID').value;
    var sEarlyGr = timeToMins(document.getElementById('txtEarlyGr').value);
    var sLateGr = timeToMins(document.getElementById('txtLateGr').value);
    var sMinOT = timeToMins(document.getElementById('txtMinOT').value);
    var sMinM4OT = timeToMins(document.getElementById('txtMinM4OT').value);
    var sHoliday = document.getElementById('txtHoliday').value;

    if (sShfCode == "REST" || sShfCode == "OFF" || sHoliday == "Y") {

        document.getElementById('selLate').value = "N";
        document.getElementById('selEarly').value = "N";

        if (sTOUT >= sTIN) {

            var TotalWork = sTOUT - sTIN;  // this is in mins
            document.getElementById('txtTotal').value = timeFromMins(TotalWork);

            if (sGradeID == "M4") {
                if (TotalWork >= sMinM4OT) {

                    calATotalOT(TotalWork);

                } else {  // if it is not OT then set value to ''

                    noOT();
                }

            } else {  // Not Grade M4 but REST or OFF and TOUT >= TIN

                //var TotalWork = sTOUT - sTIN;  // this is in mins
                //document.getElementById('txtTotal').value = timeFromMins(TotalWork);

                if (TotalWork >= sMinOT) {  //=== MinOT is different for other Grade

                    calATotalOT(TotalWork);

                } else {  // if it is not OT then set value to ''

                    noOT();
                }
            }

        } else if (sTIN >= sTOUT) {  //TIN is >= TOUT but still OFF and REST DAY 

            var TotalWork = ((sTOUT + 1440) - sTIN);   // this is in mins
            document.getElementById('txtTotal').value = timeFromMins(TotalWork);

            if (sGradeID == "M4") {
                if (TotalWork >= sMinM4OT) {

                    calATotalOT(TotalWork);

                } else {  // if it is not OT then set value to ''
                    noOT();
                }

            } else {  // Not Grade M4 but REST or OFF and TIN >= TOUT

                // var TotalWork = ((1440 - sTIN) + sTOUT);  // this is in mins
                // document.getElementById('txtTotal').value = timeFromMins(TotalWork);

                if (TotalWork >= sMinOT) {  //=== MinOT is different for other Grade
                    calATotalOT(TotalWork);

                } else {  // if it is not OT then set value to ''
                    noOT();
                }
            }

        }

    } else {  // Normal Shift, Not REST or OFF Day *****************************************************************************

        if (sGradeID == "M4") {
            var sMinOTStart = sMinM4OT;
        } else {
            var sMinOTStart = sMinOT;
        }

        if (sSTIME < sETIME) {

            // Early punch in and more than MinOT
            if ((sTIN < sSTIME) && ((sSTIME - sTIN) >= sMinOTStart)) {  // Early punch in and more than M4 min OT Time

                var sOTIn = sSTIME - sTIN;   // Early Shift in time - Early Punch in Time

                // Punch out is it Early Dismiss or not?
                if ((sTOUT < sETIME) && ((sETIME - sTOUT) > sEarlyGr)) {  //Early Dismiss
                    document.getElementById('selEarly').value = "Y";  // Early Dismiss, Totalwork = Punch Out - Punch in(early punch in)
                    TotalWork = sTOUT - sTIN;
                    calTotal(TotalWork)
                    calATotalOT(sOTIn)
                } else {  // Not early Dismiss
                    document.getElementById('selEarly').value = "N"; //Not early dismiss, Totalwork = Shiftout - Punch in(early punch in)
                    TotalWork = sETIME - sTIN;
                    calTotal(TotalWork)
                    calATotalOT(sOTIn)
                }

                // For Late Punch out
            } else if ((sTOUT > sETIME) && ((sTOUT - sETIME) >= sMinOTStart)) { //Late punch out and more than M4 min OT Time

                var sOTOut = sTOUT - sETIME;  // Late Punch Out, OT Out only = Punch Out - Shift End Time

                //Check if got Late Punch in or not
                if ((sTIN > sSTIME) & ((sTIN - sSTIME) > sLateGr)) {
                    document.getElementById('selLate').value = "Y";  //Late, TotalWork = Punch Out(late punch out) - Punch In 
                    TotalWork = sTOUT - sTIN;
                    calTotal(TotalWork)
                    calATotalOT(sOTOut)
                } else {
                    document.getElementById('selLate').value = "N";  //Not Late, TotalWork = Punch Out(late punch out) - Shift In Time
                    TotalWork = sTOUT - sSTIME;
                    calTotal(TotalWork)
                    calATotalOT(sOTOut)
                }

                // No OT, calculate total
            } else {

                noOT();

                // Early dismiss
                if ((sTOUT < sETIME) && ((sETIME - sTOUT) > sEarlyGr)) {
                    document.getElementById('selEarly').value = "Y";  // Early Dismiss, Totalwork = Punch Out - Shift In Time
                    TotalWork = sTOUT - sSTIME;
                    calTotal(TotalWork)

                    // Late come in 
                } else if ((sTIN > sSTIME) && ((sTIN - sSTIME) > sLateGr)) {
                    document.getElementById('selLate').value = "Y";  // Late, Totalwork = Punch in - Shift Out Time
                    TotalWork = sETIME - sTIN;
                    calTotal(TotalWork)

                    // Normal Punch in and punch out
                } else {
                    document.getElementById('selEarly').value = "N";
                    document.getElementById('selLate').value = "N";
                    TotalWork = sETIME - sSTIME;
                    calTotal(TotalWork)
                }

                // ***** A seperate if for Late and Early dismiss, BAD WORKER!
                if (((sTOUT < sETIME) && ((sETIME - sTOUT) > sEarlyGr)) && ((sTIN > sSTIME) && ((sTIN - sSTIME) > sLateGr))) {
                    document.getElementById('selEarly').value = "Y";
                    document.getElementById('selLate').value = "Y";
                    TotalWork = sTOUT - sTIN;
                    calTotal(TotalWork)
                }


            } // ******* End got OT or not

            // ********* A seperate if for Early Punch in and Late Punch out, OT 
            if (((sSTIME - sTIN) >= sMinOTStart) && ((sTOUT - sETIME) >= sMinOTStart)) {

                var sOTIn = sSTIME - sTIN;
                var sOTOut = sTOUT - sETIME;

                TotalWork = sTOUT - sTIN;
                calTotal(TotalWork)

                var sTotalOT = sOTIn + sOTOut;
                calATotalOT(sTotalOT)
            }
            //***********************************************************************************************************************
        } else {  //( sSTIME > sETIME ) (sSTIME = 1900 sETIM = 0700) ***************************************************************************

            // iTOUTMins = iTOUTMins + 1440
            // iETimeMins = iETimeMins + 1440 

            // Early punch in and more than MinOT
            if ((sTIN < sSTIME) && ((sSTIME - sTIN) >= sMinOTStart)) {  // Early punch in and more than M4 min OT Time

                var sOTIn = sSTIME - sTIN;   // Early Shift in time - Early Punch in Time

                // Punch out is it Early Dismiss or not?
                if ((sTOUT < sETIME) && (sETIME - sTOUT) > sEarlyGr) {  //Early Dismiss
                    document.getElementById('selEarly').value = "Y";  // Early Dismiss, Totalwork = Punch Out - Punch in(early punch in)
                    TotalWork = sTOUT + 1440 - sTIN;
                    calTotal(TotalWork)
                    calATotalOT(sOTIn)
                } else {  // Not early Dismiss
                    document.getElementById('selEarly').value = "N"; //Not early dismiss, Totalwork = Shiftout - Punch in(early punch in)
                    TotalWork = sETIME + 1440 - sTIN;
                    calTotal(TotalWork)
                    calATotalOT(sOTIn)
                }

                // For Late Punch out
            } else if ((sTOUT > sETIME) && ((sTOUT - sETIME) >= sMinOTStart)) { //Late punch out and more than M4 min OT Time

                var sOTOut = sTOUT - sETIME;  // Late Punch Out, OT Out only = Punch Out - Shift End Time

                //Check if got Late Punch in or not
                if ((sTIN > sSTIME) & ((sTIN - sSTIME) > sLateGr)) {
                    document.getElementById('selLate').value = "Y";  //Late, TotalWork = Punch Out(late punch out) - Punch In 
                    TotalWork = sTOUT + 1440 - sTIN;
                    calTotal(TotalWork)
                    calATotalOT(sOTOut)
                } else {
                    document.getElementById('selLate').value = "N";  //Not Late, TotalWork = Punch Out(late punch out) - Shift In Time
                    TotalWork = sTOUT + 1440 - sSTIME;
                    calTotal(TotalWork)
                    calATotalOT(sOTOut)
                }

                // No OT, calculate total
            } else {

                noOT();

                // Early dismiss
                if ((sTOUT < sETIME) && ((sETIME - sTOUT) > sEarlyGr)) {
                    document.getElementById('selEarly').value = "Y";  // Early Dismiss, Totalwork = Punch Out - Shift In Time
                    TotalWork = sTOUT + 1440 - sSTIME;
                    calTotal(TotalWork)

                    // Late come in 
                } else if ((sTIN > sSTIME) && ((sTIN - sSTIME) > sLateGr)) {
                    document.getElementById('selLate').value = "Y";  // Late, Totalwork = Punch in - Shift Out Time
                    TotalWork = sETIME + 1440 - sTIN;
                    calTotal(TotalWork)

                    // Normal Punch in and punch out
                } else {
                    TotalWork = sETIME + 1440 - sSTIME;
                    calTotal(TotalWork)
                }

                // A seperate if for Late and Early dismiss, BAD WORKER!
                if (((sTOUT < sETIME) && ((sETIME - sTOUT) > sEarlyGr)) && ((sTIN > sSTIME) && ((sTIN - sSTIME) > sLateGr))) {
                    document.getElementById('selEarly').value = "Y";
                    document.getElementById('selLate').value = "Y";
                    TotalWork = sTOUT + 1440 - sTIN;
                    calTotal(TotalWork)
                }


            } // End got OT or not

            // A seperate if for Early Punch in and Late Punch out, OT 
            if (((sSTIME - sTIN) >= sMinOTStart) && ((sTOUT - sETIME) >= sMinOTStart)) {

                var sOTIn = sSTIME - sTIN;
                var sOTOut = sTOUT - sETIME;

                TotalWork = sTOUT + 1440 - sTIN;
                calTotal(TotalWork)

                var sTotalOT = sOTIn + sOTOut;
                calATotalOT(sTotalOT)
            }

        } // night shift or morning shift 
    } // End REST,OFF, Normal shift

} // End Function sum    