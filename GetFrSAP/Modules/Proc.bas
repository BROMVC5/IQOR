Attribute VB_Name = "Proc"
Option Explicit

Public Function mCONNEXIST(sConn As String) As String '***PL 18/04/05
    Dim errLoop As Error
    Dim cConnTest As ADODB.Connection
    Dim gConn As String
    Dim sIP As String
    
    On Error GoTo ERRPASS
    Set cConnTest = New ADODB.Connection
    
    sIP = Mid(sConn, 1, InStr(1, sConn, ";"))
    sConn = Replace(sConn, sIP, "")
    sIP = Replace(sIP, ";", "")
        
    gConn = "DRIVER={MySQL ODBC 5.3 Unicode Driver};"
   
    gConn = gConn & "Server=" & sIP & ";Port=3307;UID=root;Password=Pass;Database=" & sConn & ";OPTION=3;" '==IQOR SERVER
    
    'gConn = "DRIVER={MySQL ODBC 3.51 Driver};"
    'gConn = gConn & "Server=" & sIP & ";UID=root;PWD=;Database=" & sConn & ";OPTION=3;"
    
    cConnTest.Open gConn
    'cConnTest.Open "DSN=" & sConn & ";UID=root"
    mCONNEXIST = "Y"
    Call pCloseTables(cConnTest)
    Exit Function
ERRPASS:
        mCONNEXIST = "N"
End Function

Sub Message(strmessage As String)
  
  '******************************************************************'
  '*  Description: This module will accept a string as parameter.   *'
  '*               The content of the string contain the error      *'
  '*               message to be displayed.                         *'
  '*                                                                *'
  '******************************************************************'
  Dim strStyle As String
  Dim strTitle As String
  
  strStyle = vbInformation + vbOKOnly     ' Define buttons.
  strTitle = "Error Message"              ' Define title.
  MsgBox strmessage, strStyle, strTitle  ' Display the message
  
End Sub

Function warningMessage(strmessage As String) As Boolean
  
  '******************************************************************'
  '*  Description: This module will accept a string as parameter.   *'
  '*               The content of the string contain the warning    *'
  '*               message to be displayed. It will return true if  *'
  '*               user choose yes or False if user choose no       *'
  '******************************************************************'
  Dim strStyle As String, strTitle As String

  strStyle = vbYesNo + vbExclamation      ' Define buttons.
  strTitle = "Warning"                    ' Define title.
  If MsgBox(strmessage, strStyle, strTitle) = vbYes Then  ' Display the message
    warningMessage = True
  Else
    warningMessage = False
  End If
  
End Function

Function pQMsg(strMsg As String) As Boolean
  
  '******************************************************************'
  '*  Description: This module will accept a string as parameter.   *'
  '*               The content of the string contain the error      *'
  '*               message to be displayed.                         *'
  '*                                                                *'
  '******************************************************************'
  Dim strStyle As String
  Dim strTitle As String
  
  strStyle = vbQuestion + vbYesNo          ' Define buttons.
  strTitle = "Question Form"              ' Define title.
  If MsgBox(strMsg, strStyle, strTitle) = vbYes Then
      pQMsg = True
  Else
      pQMsg = False
  End If
End Function

Sub CenterForm(frmToCenter As Form)
   
   '******************************************************'
   '*   Description: This module will centerise a form.  *'
   '*                                                    *'
   '******************************************************'

   frmToCenter.Top = ((Screen.Height - frmToCenter.Height) / 2)
   frmToCenter.Left = (Screen.Width - frmToCenter.Width) / 2

End Sub

Public Function ValidateCur(KeyAscii As Integer, sText As String) As Integer
   
   '*********************************************************************'
   '*   Description: This function works like ValidateInt but it allows *'
   '*                more charecters to be entered such as dot(.) and   *'
   '*                and commor(,). Retruns Integer containing the      *'
   '*                ASCII code represented the key pressed. If the key *'
   '*                is valid, then it will return the key pressed else *'
   '*                it will return 0 (zero) represent no key is        *'
   '*                pressed.                                           *'
   '*                                                                   *'
   '*     Arguments: KeyAscii -> ASCII code represent key just pressed. *'
   '*                sText    -> Text to be used for validation.        *'
   '*                                                                   *'
   '*        Syntax: ValidateCur(KeyAscii, sText)                       *'
   '*                                                                   *'
   '*********************************************************************'
   
   Dim iCount As Integer
   Dim sChar As String
   
   Select Case KeyAscii
      Case 44        'Commor (,)
         'ValidateCur = KeyAscii
         ValidateCur = 0
      Case 46        'Dot (.)
         'Check and only allow one dot(.)
         'to be entered.
         For iCount = 1 To Len(sText)
            sChar = Mid(sText, iCount, 1)
            If StrComp(sChar, ".") = 0 Then
               'String already containt dot(.)
               ValidateCur = 0
               Exit For
            Else
               ValidateCur = KeyAscii
            End If
         Next iCount
      Case 48 To 57  'Number 0 - 9
         ValidateCur = KeyAscii
      Case 8         'Backspace.
         ValidateCur = KeyAscii
'      Case 13
'         ValidateCur = sText
      Case Else
         ValidateCur = 0
   End Select
   
End Function

Public Function ValidateCurNeg(KeyAscii As Integer, sText As String) As Integer
   
   '*********************************************************************'
   '*   Description: This function works like ValidateInt but it allows *'
   '*                more charecters to be entered such as dot(.) and   *'
   '*                and commor(,). Retruns Integer containing the      *'
   '*                ASCII code represented the key pressed. If the key *'
   '*                is valid, then it will return the key pressed else *'
   '*                it will return 0 (zero) represent no key is        *'
   '*                pressed.                                           *'
   '*                                                                   *'
   '*     Arguments: KeyAscii -> ASCII code represent key just pressed. *'
   '*                sText    -> Text to be used for validation.        *'
   '*                                                                   *'
   '*        Syntax: ValidateCur(KeyAscii, sText)                       *'
   '*                                                                   *'
   '*********************************************************************'
   
   Dim iCount As Integer
   Dim sChar As String
   
   Select Case KeyAscii
      Case 44        'Commor (,)
         'ValidateCur = KeyAscii
         ValidateCurNeg = 0
      Case 46        'Dot (.)
         'Check and only allow one dot(.)
         'to be entered.
          For iCount = 1 To Len(sText)
               sChar = Mid(sText, iCount, 1)
               If StrComp(sChar, ".") = 0 Then
                  'String already containt dot(.)
                  ValidateCurNeg = 0
                  Exit For
               Else
                  ValidateCurNeg = KeyAscii
               End If
          Next iCount
      Case 48 To 57  'Number 0 - 9
         ValidateCurNeg = KeyAscii
      Case 8         'Backspace.
         ValidateCurNeg = KeyAscii
      Case 45        'Negative
         'Check and only allow one Neg(-)
         'to be entered.
         If Len(sText) <> 0 Then
            For iCount = 1 To Len(sText)
               sChar = Mid(sText, iCount, 1)
               If StrComp(sChar, "-") = 0 Then
                  'String already containt Neg(-)
                  ValidateCurNeg = 0
                  Exit For
               Else
                  ValidateCurNeg = KeyAscii
               End If
            Next iCount
         Else
            ValidateCurNeg = KeyAscii
         End If
'      Case 13
'         ValidateCurNeg = sText
      Case Else
         ValidateCurNeg = 0
   End Select
   
End Function

Public Function pValidInt(KeyAscii As Integer) As Integer
   Select Case KeyAscii
        Case 48 To 57  'Number 0 - 9.
           pValidInt = KeyAscii
        Case 8         'Backspace.
           pValidInt = KeyAscii
        Case Else
           pValidInt = 0
   End Select
End Function

Public Function ValidateDate(KeyAscii As Integer, sText As String) As Integer

   Dim iCount As Integer, Num As Integer
   Dim sChar As String
   
   Select Case KeyAscii
      Case 47 To 57  'Number 0 - 9
         ValidateDate = KeyAscii
      Case 8         'Backspace.
         ValidateDate = KeyAscii
      Case Else
         ValidateDate = 0
   
   End Select
   
End Function


Public Function pPassConv(sPass As String)
    Dim iLoop As Integer, iL As Integer
    Dim iTotal As Long
    
    iL = 3
    iTotal = 0
    For iLoop = 1 To Len(sPass)
        iTotal = iTotal + Asc(Mid(sPass, iLoop, 1)) * (iL + iLoop - 1)
    Next
    pPassConv = iTotal
End Function

Public Function LastDate(ByVal fYear As Integer, ByVal fMonth As Integer) As Date
    If fMonth < 12 Then
        LastDate = CDate("01/" & CStr(fMonth + 1) & "/" & CStr(fYear))
    Else
        LastDate = CDate("01/01/" & CStr(fYear + 1))
    End If
    LastDate = LastDate - 1
End Function

Public Function pAllowShare(sDatabase As Database, sFileName As String, sMessage As String, Optional iRestrict As Integer) As Boolean
    Dim rsttmpcheck As Recordset
    pAllowShare = True
    On Error GoTo ErrorHandler:
    If IsMissing(iRestrict) Then
        Set rsttmpcheck = sDatabase.OpenRecordset(sFileName, dbOpenTable)
    Else
        Set rsttmpcheck = sDatabase.OpenRecordset(sFileName, dbOpenTable, iRestrict)
    End If
    rsttmpcheck.Close
    Exit Function
    
ErrorHandler:
    pAllowShare = False
    Select Case Err.Number
        Case 3262, 3261, 3027, 3186, 3008
            Message (sMessage)
        Case Else
            Message ("Error found : " & Err.Number & Chr(13) & Err.Description)
    End Select
    Set rsttmpcheck = Nothing
End Function

Public Function pOpenTable(sDatabase As Database, sTableName As String, rstTmpOpen As Recordset, iType As Integer, Optional iRestrict As Integer) As Boolean
    
    On Error GoTo ErrorHandler:
    If IsMissing(iRestrict) Then
         pOpenTable = pAllowShare(sDatabase, sTableName, "Some files are currently not accesible! Please try again later.")
        If pOpenTable Then
            Set rstTmpOpen = sDatabase.OpenRecordset(sTableName, iType)
        End If
    Else
        pOpenTable = pAllowShare(sDatabase, sTableName, "Some files are currently shared by other user! Please try again later.", iRestrict)
        If pOpenTable Then
            Set rstTmpOpen = sDatabase.OpenRecordset(sTableName, iType, iRestrict)
        End If
    End If
    Exit Function

ErrorHandler:
    pOpenTable = False
    Select Case Err.Number
        Case 0
        Case Else
            Message ("Error found : " & Err.Number & Chr(13) & Err.Description)
    End Select
End Function

Public Sub pCloseTables(ParamArray Tables())
    Dim iLoop As Variant
    On Error GoTo ErrorHandler:
    For Each iLoop In Tables
        iLoop.Close
        Set iLoop = Nothing
    Next
    Exit Sub
    
ErrorHandler:
    Select Case Err.Number
        Case 91
            Set iLoop = Nothing
            Resume Next
        Case 3426
            Set iLoop = Nothing
            Resume Next
        Case Else
            Message ("Error found : " & Err.Number & Chr(13) & Err.Description)
    End Select
End Sub

Public Function pLastNumber(lastNum As String, ByVal startNum As Integer, ByVal runNum As Integer) As String
    Dim iLoop As Integer
    
    pLastNumber = ""
    If runNum > 0 And startNum > 0 And Len(lastNum) <= 13 And Len(lastNum) - startNum - runNum > -2 Then
        For iLoop = 0 To runNum - 1
            If IsNumeric(Mid(lastNum, startNum + iLoop, runNum - iLoop)) Then
                pLastNumber = Left(lastNum, startNum - 1) & _
                               Format(CLng(Mid(lastNum, startNum + iLoop, runNum - iLoop)) + 1, String(runNum, "0")) & _
                                Right(lastNum, Len(lastNum) + 1 - startNum - runNum)
                Exit Function
            End If
        Next
    End If
    
End Function

Public Function pFormatDec(tText As String, Optional iDec As Integer) As String
    If IsEmpty(iDec) Then
        iDec = 0
    End If
    If tText = "" Or Not IsNumeric(tText) Then
        tText = "0"
    End If
    If iDec < 1 Then
        pFormatDec = Format(pRound(tText, CLng(iDec)), "###,###,###,##0")
    Else
        pFormatDec = Format(pRound(tText, CLng(iDec)), "###,###,##0." & String(iDec, "0"))
    End If
End Function

Public Sub pSelect(ByRef cControl As Control)
    If TypeName(cControl) <> "TextBox" And _
    TypeName(cControl) <> "MaskEdBox" Then
        Exit Sub
    End If
    If TypeName(cControl) = "TextBox" Then
        'If cControl.SelStart < 1 Then
        If Len(cControl) > 0 Then
            cControl.SelStart = 0
            cControl.SelLength = Len(cControl)
        End If
    End If
    If TypeName(cControl) = "MaskEdBox" Then
        If Len(cControl) > 0 Then
            cControl.SelLength = Len(cControl)
        End If
    End If
End Sub

Public Sub pCheckAccess(fSupplied As Variant, mSubMenu As Variant)
    If Not fSupplied.Value = "Y" Then
        mSubMenu.Enabled = False
    End If
End Sub

Public Function pRound(ByVal Number As Variant, ByVal NumDigits As Long, _
                       Optional UseIeee As Boolean = False) As Double
   Dim dblPower As Double
   Dim vPSTEmp As Variant
   Dim intSgn As Integer
   Dim iSgn As Integer
     iSgn = 1
     If Not IsNumeric(Number) Then
       pRound = 0
   Else
       If Number < 0 Then
           iSgn = -1
           Number = Abs(Number)
       End If
       dblPower = 10 ^ NumDigits
       vPSTEmp = CDec(Number * dblPower + 0.5)
       If UseIeee Then
           intSgn = Sgn(Number)
           vPSTEmp = Abs(vPSTEmp)
           If Int(vPSTEmp) = vPSTEmp Then
               If vPSTEmp Mod 2 = 1 Then
                   vPSTEmp = intSgn * (vPSTEmp - intSgn)
               End If
           End If
       End If
       pRound = Int(vPSTEmp) / dblPower
   End If
   pRound = pRound * iSgn
End Function

Public Function ExistForms(chkForm As Form) As Boolean
    Dim iLoop As Integer, iFormMax As Integer
    On Error GoTo ErrorHandler:
    ExistForms = False
    iFormMax = Forms.Count - 1
    For iLoop = 0 To iFormMax
        If Mid(chkForm.Name, 1, 5) = "frmPr" And Mid(Forms(iLoop).Name, 1, 5) = "frmPr" Then
            Call Forms(iLoop).cmdClose_Click
            Exit Function
        End If
        If chkForm.Name = Forms(iLoop).Name Then
            Call chkForm.cmdClose_Click
            Forms(iLoop).SetFocus
            ExistForms = True
            Exit Function
        End If
    Next
    Exit Function
ErrorHandler:
    Select Case Err.Number
        Case 0
        Case 438        'frmprint form not unload
        Case Else
            Message ("Error found : " & Err.Number & Chr(13) & Err.Description)
    End Select
End Function

Public Function pIniPrint(iFStart As Integer, iFEnd As Integer, _
    iSStart As Integer, iSEnd As Integer, _
    iDStart As Integer, iDEnd As Integer)
    
'    Dim i As Integer
'    For i = iFStart To iFEnd
'        frmPrint.rptReport.Formulas(i) = ""
'    Next
'    For i = iSStart To iSEnd
'        frmPrint.rptReport.SortFields(i) = ""
'    Next
'    For i = iDStart To iDEnd
'        frmPrint.rptReport.DataFiles(i) = ""
'    Next
'    frmPrint.rptReport.SelectionFormula = ""
End Function

Public Function pRD(aRSField) ':DATE
'read date data-type from recordset
    If (IsNull(aRSField)) Then
        pRD = Null
    Else
        pRD = Format(aRSField, "DD/MM/YYYY")
    End If
End Function

Public Function pRN(aRSField) ':integer/double
'read numeric data-type from recordset
  If IsNull(aRSField) Then
    pRN = 0
  ElseIf Not IsNumeric(aRSField) Then
    pRN = 0
  Else
    pRN = aRSField
  End If
End Function

Public Function pRTIN(aRSField)
   If IsNull(aRSField) Then
       pRTIN = ""
   Else
       pRTIN = Trim(Replace(Replace(aRSField, "'", "''"), "\", "\\"))
   End If
End Function

Public Function pRT(aRSField)
   If IsNull(aRSField) Then
       pRT = ""
   Else
       pRT = aRSField
   End If
End Function

Public Sub pCentreTop(aForm As Form, aTop As Integer, aType As String)
'IC
'centre a form horizontally on screen
'  aForm.Left = Screen.Width / 2 - aForm.Width / 2
  
  aForm.Left = 0
  aForm.Top = aTop
  
  Select Case aType
    Case "FM"       'MAINTENANCE
        aForm.Width = 8000
        aForm.Height = 2000
    Case "FM1"      'MAINTENANCE
        aForm.Width = 8000
        aForm.Height = 7000
    Case "TE"       'TRANSACTION
        aForm.Width = 9400
        aForm.Height = 6500
    Case "PT"       'POSTING
        aForm.Width = 8200
        aForm.Height = 4000
        aForm.Top = (Screen.Height - aForm.Height) / 2 - 800
        aForm.Left = (Screen.Width - aForm.Width) / 2
    Case "DT"       'DETAIL
        aForm.Width = 8640
        aForm.Height = 4200
        aForm.Top = (Screen.Height - aForm.Height) / 2 - 800
        aForm.Left = (Screen.Width - aForm.Width) / 2
    Case "SODT"       'DETAIL
        aForm.Width = 8000
        aForm.Height = 6435
        aForm.Top = (Screen.Height - aForm.Height) / 2 - 800
        aForm.Left = (Screen.Width - aForm.Width) / 2
    Case "AI"       'IQE
        aForm.Width = 11300
        aForm.Height = 7000
    Case "PC"       'PROCESSING
        aForm.Width = 7800
        aForm.Height = 4700
        aForm.Top = (Screen.Height - aForm.Height) / 2 - 800
        aForm.Left = (Screen.Width - aForm.Width) / 2
    Case "PR"       'REPORT
        aForm.Width = 7200
        aForm.Height = 3500
  End Select
End Sub

Public Function ptoWord(dNUM As Double) As String
    'IC
    Dim sEnglish1, sEnglish2, sEnglish3 As String
    Dim sWord1, sWord2, sWord3 As String
    Dim iDec, iConv, ddnum As Long
    
    sEnglish1 = "ONE       TWO       THREE     FOUR      FIVE      SIX       SEVEN     EIGHT     NINE      TEN        "
    sEnglish2 = "ELEVEN    TWELVE    THIRTEEN  FOURTEEN  FIFTEEN   SIXTEEN   SEVENTEEN EIGHTEEN  NINETEEN   "
    sEnglish3 = "TWENTY    THIRTY    FORTY     FIFTY     SIXTY     SEVENTY   EIGHTY    NINETY               "
    
    sWord3 = ""
    If Fix(dNUM) <> Fix(dNUM + 0.99) Then
        iConv = Fix(pRound((dNUM - Fix(dNUM)) * 100, 3))
        If iConv > 1 Then
            sWord3 = "AND CENTS " & sWord3
        Else
            sWord3 = "AND CENT " & sWord3
        End If
        If iConv >= 20 And iConv < 100 Then
            sWord3 = sWord3 & RTrim(Mid(sEnglish3, ((Fix(iConv / 10) - 2) * 10) + 1, 10)) & " "
            iConv = iConv - (Fix(iConv / 10) * 10)
            If iConv > 0 Then
                sWord3 = sWord3 & RTrim(Mid(sEnglish1, ((iConv - 1) * 10) + 1, 10)) & " "
            End If
        ElseIf iConv > 10 Then
            sWord3 = sWord3 & RTrim(Mid(sEnglish2, ((iConv - 11) * 10) + 1, 10)) & " "
        ElseIf iConv > 0 Then
            sWord3 = sWord3 & RTrim(Mid(sEnglish1, ((iConv - 1) * 10) + 1, 10)) & " "
        End If
        dNUM = Fix(dNUM)
    End If
    
    iDec = 0
    Do While dNUM >= 1000
        iDec = iDec + 1
        dNUM = dNUM / 1000
    Loop
    
    sWord2 = ""
    Do While dNUM > 0
        If Fix(dNUM) > 0 Then
        
            iConv = Fix(dNUM / 100)
            If iConv >= 1 Then
                sWord2 = sWord2 & RTrim(Mid(sEnglish1, ((iConv - 1) * 10) + 1, 10)) & " "
                sWord2 = sWord2 & "HUNDRED "
            End If
            
            iConv = Fix(dNUM - (Fix(dNUM / 100) * 100))
            If iConv >= 20 And iConv < 100 Then
                sWord2 = sWord2 & RTrim(Mid(sEnglish3, ((Fix(iConv / 10) - 2) * 10) + 1, 10)) & " "
                iConv = iConv - (Fix(iConv / 10) * 10)
                If iConv > 0 Then
                    sWord2 = sWord2 & RTrim(Mid(sEnglish1, ((iConv - 1) * 10) + 1, 10)) & " "
                End If
            ElseIf iConv > 10 Then
                sWord2 = sWord2 & RTrim(Mid(sEnglish2, ((iConv - 11) * 10) + 1, 10)) & " "
            ElseIf iConv > 0 Then
                sWord2 = sWord2 & RTrim(Mid(sEnglish1, ((iConv - 1) * 10) + 1, 10)) & " "
            End If
            
            Select Case iDec
                Case 1
                    sWord2 = sWord2 & "THOUSAND "
                Case 2
                    sWord2 = sWord2 & "MILLION "
                Case 3
                    sWord3 = sWord3 & "BILLION "
            End Select
        End If
        iDec = iDec - 1
        dNUM = pRound((dNUM * 1000) - (Fix(dNUM) * 1000), 9)
    Loop
    ptoWord = sWord2 & sWord3
    If Len(ptoWord) > 0 Then
        ptoWord = ptoWord & "ONLY "
    End If
   
End Function
Public Function pgetDec(iDec As Integer) As String
    'IC
    If iDec > 0 Then
        pgetDec = "###,###,##0." & String(iDec, "0")
    Else
        pgetDec = "###,###,##0"
    End If
End Function
Public Function pDate(dtDate As Date)  ':Date
  'IC
  pDate = Format(dtDate, "DD/MM/YYYY")
End Function
Public Function fDate2(dtDate As Date)  ':Date
  'IC
  fDate2 = Format(dtDate, "YYYY-MM-DD")
End Function
Public Function p2Dec(aNum) ':double
    'IC
'format to 2 dec
  p2Dec = Format(aNum, "###,###,##0.00")
End Function
Public Function p0Dec(aNum) ':double
    'IC
'format to 0 dec
  p0Dec = Format(aNum, "###,###,##0")
End Function
Public Function pDateTime() ':string
'return date and time
 pDateTime = Format(Date, "yyyymmdd") & " " & Format(Time, "hh:mm:ss")
End Function
Public Function fDateTime2() ':string
'return date and time
 fDateTime2 = Format(Date, "yyyy-mm-dd") & " " & Format(Time, "hh:mm:ss")
End Function

Public Sub pCalF(cF As Control, dLAmt As Double, sngRate As Double)
    If CDbl(sngRate) <> 0# Then
        cF.Text = pFormatDec(dLAmt / pRound(sngRate, 6), 2)
    End If
End Sub

Public Sub pCalL(cL As Control, dFAmt As Double, sngRate As Double)
    If sngRate <> 0# Then
        cL.Text = pFormatDec(dFAmt * pRound(sngRate, 6), 2)
    End If
End Sub

Public Sub pCalR(cR As Control, dLAmt As Double, dFAmt As Double)
    If CDbl(dFAmt) <> 0# And CDbl(pRN(cR)) = 0# Then
        cR.Text = pFormatDec(dLAmt / dFAmt, 6)
    End If
End Sub

Public Function pRTUR(aRSField) ':string  'pl 18/10/03
'UCASE AND RTRIM
    pRTUR = RTrim(UCase(aRSField))
End Function

Public Sub ShowADOError()
    MsgBox Err.Number & " - " & Err.Description
End Sub

Public Function pOpenEmpty(aRSField)
    pOpenEmpty = "SELECT * FROM " & aRSField & " WHERE AUTOINC = 0"
End Function

