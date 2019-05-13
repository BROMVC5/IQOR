VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form frmEmail 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Send Mail System"
   ClientHeight    =   9930
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11880
   ControlBox      =   0   'False
   Icon            =   "frmEmail.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9930
   ScaleWidth      =   11880
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdPurgeIC 
      Caption         =   "Clear All"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   10320
      TabIndex        =   5
      Top             =   4200
      Width           =   1275
   End
   Begin VB.CommandButton cmdRemove 
      Caption         =   "&Remove Service"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   2280
      TabIndex        =   11
      Top             =   3360
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.CommandButton cmdService 
      Caption         =   "&Run as Service"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   120
      TabIndex        =   10
      Top             =   3360
      Visible         =   0   'False
      Width           =   2115
   End
   Begin VB.ComboBox cboCompany 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      ItemData        =   "frmEmail.frx":030A
      Left            =   2160
      List            =   "frmEmail.frx":030C
      Style           =   2  'Dropdown List
      TabIndex        =   9
      Top             =   4200
      Width           =   4335
   End
   Begin VB.Timer tmRecord 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   9840
      Top             =   4200
   End
   Begin VB.CommandButton cmdDetail 
      Caption         =   "&Detail"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   8280
      TabIndex        =   7
      Top             =   3360
      Width           =   1275
   End
   Begin VB.Timer tmCount 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   6000
      Top             =   0
   End
   Begin VB.Timer tmRun 
      Interval        =   500
      Left            =   3000
      Top             =   0
   End
   Begin VB.CommandButton cmdMinimize 
      Caption         =   "&Minimize To Tray"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   9600
      TabIndex        =   4
      Top             =   3360
      Width           =   2115
   End
   Begin VB.ListBox lstConnection 
      BackColor       =   &H00FFFFFF&
      Height          =   2790
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   5640
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "&Exit"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   6960
      TabIndex        =   1
      Top             =   3360
      Width           =   1275
   End
   Begin VB.ListBox lstStatus 
      BackColor       =   &H00FFFFFF&
      Height          =   2790
      Left            =   5880
      TabIndex        =   0
      Top             =   480
      Width           =   5880
   End
   Begin MSDataGridLib.DataGrid dtgView1 
      Bindings        =   "frmEmail.frx":030E
      Height          =   4695
      Left            =   120
      TabIndex        =   14
      Tag             =   "4"
      Top             =   4680
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   8281
      _Version        =   393216
      AllowUpdate     =   0   'False
      Enabled         =   -1  'True
      HeadLines       =   1
      RowHeight       =   17
      FormatLocked    =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   4
      BeginProperty Column00 
         DataField       =   "SUP_CODE"
         Caption         =   "Supervisor"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   "RECEIVER"
         Caption         =   "Receiver"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column02 
         DataField       =   "TYPE"
         Caption         =   "Type"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column03 
         DataField       =   "SUBJECT"
         Caption         =   "Subject"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
            ColumnWidth     =   1830.047
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   3614.74
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   1425.26
         EndProperty
         BeginProperty Column03 
            ColumnWidth     =   4364.788
         EndProperty
      EndProperty
   End
   Begin MSAdodcLib.Adodc adoDetail1 
      Height          =   330
      Left            =   120
      Tag             =   "CROUTBOX"
      Top             =   9480
      Visible         =   0   'False
      Width           =   3000
      _ExtentX        =   5292
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   8
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   1
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   ""
      OLEDBString     =   ""
      OLEDBFile       =   ""
      DataSourceName  =   "TS_GL"
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   ""
      Caption         =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin VB.Label l2 
      Caption         =   "Label7"
      Height          =   255
      Left            =   4200
      TabIndex        =   13
      Top             =   120
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.Label l1 
      Caption         =   "Label7"
      Height          =   255
      Left            =   3720
      TabIndex        =   12
      Top             =   120
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Company Database :"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   8
      Top             =   4200
      Width           =   1965
   End
   Begin VB.Shape shpStatus 
      BackColor       =   &H0000FF00&
      BackStyle       =   1  'Opaque
      Height          =   255
      Left            =   2160
      Top             =   120
      Width           =   735
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Connection Status :"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   1845
   End
   Begin VB.Label lblCount 
      Alignment       =   1  'Right Justify
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   6480
      TabIndex        =   6
      Top             =   120
      Width           =   3735
   End
End
Attribute VB_Name = "frmEmail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Option Compare Text

Public srv_name As String
Public path_name As String
Private Const HKEY_LOCAL_MACHINE = &H80000002
Private Const KEY_WRITE = &H20006
Private Const REG_SZ = 1
Private Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Long
End Type
Private Declare Function RegCreateKeyEx Lib "advapi32.dll" Alias "RegCreateKeyExA" (ByVal _
    hKey As Long, ByVal lpSubKey As String, ByVal Reserved As Long, ByVal lpClass _
    As String, ByVal dwOptions As Long, ByVal samDesired As Long, lpSecurityAttributes _
    As SECURITY_ATTRIBUTES, phkResult As Long, lpdwDisposition As Long) As Long
Private Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal _
    hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType _
    As Long, lpData As Any, ByVal cbData As Long) As Long
Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

'-------------------------------------------------------------------------------------------------
Dim sBatFile As String
Dim gConn(10) As ADODB.Connection
Dim gCompany(10) As String
Dim iConnect As Integer
Dim sSQL As String
Dim sDelete As String
Dim rstBROMAIL As ADODB.Recordset
Dim rstBROPATH As ADODB.Recordset

Dim lCount As Long
Dim lSecStart As Long
Dim lSecEnd As Long

Dim nid As NOTIFYICONDATA2
Dim ptSend As CDO.Message
Dim bNoRefresh As Boolean
Dim iCal As Integer
Dim iRestart As Integer

Dim gComDir As String       'SUSAN PJ14/0078
Dim gComIP As String        'SUSAN PJ14/0078
Dim gConnVw As String       'SUSAN PJ14/0078

Dim gDate As Date           'SUSAN PJ14/0106
Dim gEmail As String
Dim gSup_Code As String

Dim sSecu As String, sCVT As String, lA As String, lB As String, sC As String
Dim lStart As Long, lCount2 As Long

Dim gCompanyName As String

Private Sub cboCompany_Change()
    Call cboCompany_Click
End Sub

Private Sub cboCompany_Click()

    gConnVw = "DRIVER={MySQL ODBC 5.3 Unicode Driver};"
    gConnVw = gConnVw & "Server=" & gComIP & ";Port=3307;UID=root;Password=admin@987412;Database=" & gComDir & ";OPTION=3;"
    adoDetail1.ConnectionString = gConnVw
  
End Sub

Private Sub cmdDetail_Click()
    If cmdDetail.Caption = "&Detail" Then
        cmdDetail.Caption = "&Summary"
        
        Me.Height = 10485
        adoDetail1.Enabled = True
        Call cboCompany_Click
        Call tmRecord_Timer
        tmRecord.Enabled = True
    Else
        cmdDetail.Caption = "&Detail"
        Me.Height = 4320
        tmRecord.Enabled = False
        Call pCloseTables(adoDetail1.Recordset)
        adoDetail1.Enabled = False
    End If
End Sub

Private Sub cmdMinimize_Click()
    If cmdDetail.Caption = "&Summary" Then
        cmdDetail.Caption = "&Summary"
        Call cmdDetail_Click
    End If

    minimize_to_tray
    Shell_NotifyIcon NIM_DELETE, nid
    
End Sub

Private Sub Form_Load()
    sDelete = "" 'hkchan
    minimize_to_tray
    Shell_NotifyIcon NIM_DELETE, nid

    With Me
        .Move (Screen.Width - .Width) / 2, (Screen.Height - .Height) / 2
        .Top = 0
        .Left = 0
    End With
    tmCount.Enabled = True
    cmdDetail.Caption = "&Summary"
    Call cmdDetail_Click
    bNoRefresh = True
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

'    Shell_NotifyIcon NIM_DELETE, nid ' del tray icon
    Dim frmTemp As Form
    For Each frmTemp In Forms
        Unload frmTemp
        Set frmTemp = Nothing
    Next
    End
End Sub


Private Sub cmdExit_Click()
Dim frm As Form
    For Each frm In Forms
        Unload frm
        Set frm = Nothing
    Next
    End
End Sub

Private Sub pConnection()
    Dim sComDir As String
    Dim sComIP As String
    Dim sDatabase As String
    Dim bPass As Boolean
    Dim iCheck As Integer
    Dim iFaild As Integer
    
    cboCompany.Clear
    cboCompany.Refresh
    lstConnection.Clear
    iConnect = 0
    iCheck = 0
    bNoRefresh = False
    
On Error GoTo ErrorHandler
    
    Open App.Path & "\IP.TXT" For Input As 1
    Do While Not EOF(1)
        Line Input #1, sComDir
        If sComDir <> "" Then
            bPass = True
            iCheck = iCheck + 1
            
            'connect to server
            sComIP = sComDir
            sComDir = "IQOR"
            
            gComIP = sComIP
            gComDir = "IQOR"
            
            sDatabase = "DRIVER={MySQL ODBC 5.3 Unicode Driver};"
            sDatabase = sDatabase & "Server=" & sComIP & ";Port=3307;UID=root;Password=admin@987412;Database=" & sComDir & ";OPTION=3;"
            
            Set gConn(iConnect) = New ADODB.Connection
            gConn(iConnect).Open sDatabase
            If bPass = True Then
                gCompany(iConnect) = sComIP & ";" & sComDir
                lstConnection.AddItem gCompany(iConnect) & " >> Connected"
                
                cboCompany.AddItem gCompany(iConnect) & " >" & iConnect
                cboCompany.Refresh
                
                If cboCompany.ListIndex <> 0 Then
                    cboCompany.ListIndex = 0
                End If
                
                iConnect = iConnect + 1
                
            End If
            bPass = True
        
        End If
        DoEvents
    Loop
    Close #1
    bNoRefresh = True
    
    If iFaild <> iCheck Then
        cmdDetail.Enabled = True
        Call pSendMail
        shpStatus.BackColor = &HFF00&
        shpStatus.Refresh
    Else
        shpStatus.BackColor = &HFF&
        shpStatus.Refresh
        cmdDetail.Enabled = False
    End If
    Exit Sub
    
ErrorHandler:
    If Err.Number = -2147467259 Then
        bPass = False
        iFaild = iFaild + 1
        lstConnection.AddItem sComDir & " >> Connection Failed"
    Else
        lstConnection.AddItem sComDir & " >> Unexpected Error !! (" & gSup_Code & " , " & gEmail & ")"
    End If
    
    Resume Next
End Sub

Private Sub tmCount_Timer()
    Dim sTime As String
    

    lSecEnd = (Hour(Now) * 3600) + (Minute(Now) * 60) + Second(Now)
    
    If lCount <= 0 Then
        
        tmCount.Enabled = False
        lblCount.Caption = ""
        lblCount.Refresh
        Call pConnection
        tmCount.Enabled = True
        
        lSecStart = (Hour(Now) * 3600) + (Minute(Now) * 60) + Second(Now) + 10  '=== + 180 is 2 minutes
        lCount = lSecStart - lSecEnd
        
        sTime = Format(Fix(lCount / 60), "00") & ":" & Format(pRound(((lCount / 60) - Fix(lCount / 60)) * 60, 0), "00")
        lblCount.Caption = "Refresh After : " & sTime
        lblCount.Refresh
        
        If cmdDetail.Caption = "&Summary" Then
            iCal = iCal + 1
            l1.Caption = iCal
        Else
            iCal = 0
        End If
    
        If cmdDetail.Caption = "&Summary" And iCal >= 2 Then
            cmdDetail.Caption = "&Summary"
            Call cmdDetail_Click
            iCal = 0
        End If
        
        If iRestart >= 200 Then
            Shell App.Path & "/Email.exe"
            End
        End If
    Else
        lCount = lSecStart - lSecEnd
        
        sTime = Format(Fix(lCount / 60), "00") & ":" & Format(pRound(((lCount / 60) - Fix(lCount / 60)) * 60, 0), "00")
        lblCount.Caption = "Refresh After : " & sTime
        lblCount.Refresh
    End If
    
    DoEvents
    
    gDate = Now 'SUSAN PJ14/0106
    If Format(gDate, "HH:MM") > "00:00" And Format(gDate, "HH:MM") < "00:30" Then
        'Unload Me   'If detect close time then close and schedule on again
        End
    End If
End Sub

Private Sub tmRun_Timer()
    If shpStatus.Visible = True Then
        shpStatus.Visible = False
    Else
        shpStatus.Visible = True
    End If
End Sub

Private Sub pSendMail()
    Dim sErrorMsg As String
    Dim iLoop As Integer
    
    lstConnection.Clear
    lstConnection.AddItem "Start Checking <" & Time() & ">"
    lstConnection.Refresh
    For iLoop = 0 To iConnect - 1
        
        lstConnection.AddItem "Company :" & gCompany(iLoop) & "(SEND EMAIL)"
        lstConnection.Refresh

        sSQL = "SELECT * FROM BROMAIL order by TYPE"
        Set rstBROMAIL = New ADODB.Recordset
        rstBROMAIL.Open sSQL, gConn(iLoop), adOpenStatic, adLockPessimistic
        If Not rstBROMAIL.BOF Then
            Do While Not rstBROMAIL.EOF
                sErrorMsg = pSend(iLoop, pRT(rstBROMAIL!SUP_CODE), pRT(rstBROMAIL!RECEIVER), _
                            pRT(rstBROMAIL!Subject), pRT(rstBROMAIL!CONTENT), pRT(rstBROMAIL!Type))
                If sErrorMsg <> "" Then
                    lstConnection.AddItem sErrorMsg
                    lstConnection.Refresh
                Else
                    sSQL = "Delete from BROMAIL where AUTOINC = " & rstBROMAIL!AUTOINC
                    gConn(iLoop).Execute sSQL
                End If

                rstBROMAIL.MoveNext
                DoEvents
            Loop
            lstConnection.AddItem "Send Done <" & Time() & ">"
            lstConnection.Refresh
        Else
            lstConnection.AddItem "No Record Found <" & Time() & ">"
            lstConnection.Refresh
        End If
        Call pCloseTables(rstBROMAIL)

    Next
End Sub

Private Function pSend(iConn As Integer, sSup_Code As String, sSEmail As String, _
                       sSubject As String, sContent As String, sType As String) As String

    Dim sFPass As String, sFName As String, sFEmail As String
    Dim sSMTP As String, sPort As String, bSSL As String
    Dim ptSend
            
    Set rstBROPATH = New ADODB.Recordset
    rstBROPATH.Open "BROPATH", gConn(0), adOpenStatic, adLockReadOnly
    If Not rstBROPATH.BOF Then
        gCompanyName = ""
        sSecu = "3289762759827438927432934872973897486433"
        sCVT = Trim(rstBROPATH!CONAME)
        lStart = 1
        lCount2 = 2
        Do While True
            lA = Val(Mid(sCVT, lCount2, 2))
            lB = Val(Mid(sSecu, lStart, 1))
            sC = Chr(lA - lB)
            gCompanyName = gCompanyName + sC
            If lCount2 < Len(sCVT) - 2 Then
                lCount2 = lCount2 + 2
                lStart = lStart + 1
            Else
                Exit Do
            End If
        Loop
    Else
        gCompanyName = "BRO SOFTWARE HOUSE (M) SDN BHD"
    End If
    Call pCloseTables(rstBROPATH)
     
    Set rstBROPATH = New ADODB.Recordset
    rstBROPATH.Open "BROPATH", gConn(iConn), adOpenStatic, adLockPessimistic
    If rstBROPATH.BOF Then
        pSend = "Path File Not Found !!"
        Exit Function
    Else
        sFName = gCompanyName
        sFEmail = pRT(rstBROPATH!SDEMAIL)
        sFPass = pRT(rstBROPATH!SDPW)
        sSMTP = pRT(rstBROPATH!SMTP)
        sPort = pRT(rstBROPATH!Port)
        bSSL = pRT(rstBROPATH!USESSL)
        If bSSL = "T" Then
            bSSL = "True"
        Else
            bSSL = "False"
        End If
        
        If sFEmail = "" Or sSMTP = "" Or sPort = "" Then
            pSend = "Email or SMTP on Program Setup Not Set Properly !!"
            Exit Function
        End If
    End If
    Call pCloseTables(rstBROPATH)

    gEmail = sSEmail
    gSup_Code = sSup_Code
    
    Set ptSend = New CDO.Message
    ptSend.Configuration.Fields(cdoSMTPServer) = sSMTP
    ptSend.Configuration.Fields(cdoSMTPServerPort) = sPort
    ptSend.Configuration.Fields(cdoSMTPUseSSL) = bSSL
    ptSend.Configuration.Fields(cdoSMTPAuthenticate) = 1
    ptSend.Configuration.Fields(cdoSendUserName) = sFEmail
    ptSend.Configuration.Fields(cdoSendPassword) = sFPass
    ptSend.Configuration.Fields(cdoSMTPConnectionTimeout) = 30
    ptSend.Configuration.Fields(cdoSendUsingMethod) = 2
    ptSend.Configuration.Fields.Update
    ptSend.To = sSEmail
    ptSend.From = gCompanyName & "<" & sFEmail & ">"
    
    ptSend.Subject = sSubject
    ptSend.HTMLBody = sContent
    ptSend.Send
    Set ptSend = Nothing
    
    If lstStatus.ListCount > 200 Then
        lstStatus.Clear
        lstStatus.Refresh
    End If
    lstStatus.AddItem sType & " : " & sSup_Code & " >> " & sSEmail & " - Send (" & Now & ")"
    lstStatus.Refresh

End Function


Private Sub tmRecord_Timer()
    
    sSQL = "SELECT * FROM BROMAIL"
    adoDetail1.RecordSource = sSQL
    adoDetail1.Refresh
    
    iRestart = iRestart + 1
    l2.Caption = iRestart
End Sub

Private Sub cmdPurgeIC_Click() 'HKCHAN 2014-12-5
    sSQL = "Delete from BROMAIL"
    gConn(0).Execute sSQL
    
    Call cmdDetail_Click
End Sub

Sub minimize_to_tray()
    Me.Hide
    nid.cbSize = Len(nid)
    nid.hwnd = Me.hwnd
    nid.uId = vbNull
    nid.uFlags = NIF_ICON2 Or NIF_TIP2 Or NIF_MESSAGE2
    nid.uCallBackMessage = WM_MOUSEMOVE2
    nid.hIcon = Me.Icon
    nid.szTip = "BRO Send Mail System" & vbNullChar
    Shell_NotifyIcon NIM_ADD2, nid
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    Dim msg As Long
    Dim sFilter As String
    
    msg = x / Screen.TwipsPerPixelX
    
    Select Case msg
        Case WM_LBUTTONDOWN2
            Me.Show ' show form
            Shell_NotifyIcon NIM_DELETE2, nid ' del tray icon
        Case WM_LBUTTONUP2
        Case WM_LBUTTONDBLCLK2
        Case WM_RBUTTONDOWN2
        Case WM_RBUTTONUP2
            Me.Show
            Shell_NotifyIcon NIM_DELETE2, nid
        Case WM_RBUTTONDBLCLK2
    End Select
End Sub



