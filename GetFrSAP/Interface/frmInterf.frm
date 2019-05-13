VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form frmInterf 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Get Data from SAP"
   ClientHeight    =   9930
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   15105
   ControlBox      =   0   'False
   Icon            =   "frmInterf.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9930
   ScaleWidth      =   15105
   StartUpPosition =   3  'Windows Default
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
      TabIndex        =   10
      Top             =   5640
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
      TabIndex        =   9
      Top             =   5640
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
      ItemData        =   "frmInterf.frx":030A
      Left            =   2040
      List            =   "frmInterf.frx":030C
      Style           =   2  'Dropdown List
      TabIndex        =   8
      Top             =   6120
      Width           =   4335
   End
   Begin VB.Timer tmRecord 
      Enabled         =   0   'False
      Interval        =   5000
      Left            =   6600
      Top             =   6000
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
      Left            =   11520
      TabIndex        =   6
      Top             =   5640
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
      Left            =   12840
      TabIndex        =   4
      Top             =   5640
      Width           =   2115
   End
   Begin VB.ListBox lstConnection 
      BackColor       =   &H00FFFFFF&
      Height          =   5130
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   7320
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
      Left            =   10200
      TabIndex        =   1
      Top             =   5640
      Width           =   1275
   End
   Begin VB.ListBox lstStatus 
      BackColor       =   &H00FFFFFF&
      Height          =   5130
      Left            =   7560
      TabIndex        =   0
      Top             =   480
      Width           =   7440
   End
   Begin MSDataGridLib.DataGrid dtgView1 
      Bindings        =   "frmInterf.frx":030E
      Height          =   2895
      Left            =   120
      TabIndex        =   13
      Tag             =   "4"
      Top             =   6480
      Width           =   14775
      _ExtentX        =   26061
      _ExtentY        =   5106
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
      ColumnCount     =   5
      BeginProperty Column00 
         DataField       =   "EMP_CODE"
         Caption         =   "Employee Code"
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
         DataField       =   "DTFR"
         Caption         =   "Date From"
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
         DataField       =   "DTTO"
         Caption         =   "Date To"
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
         DataField       =   "TOFF_ID"
         Caption         =   "Time Off Code"
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
      BeginProperty Column04 
         DataField       =   "LTYPE"
         Caption         =   "Leave Type"
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
            ColumnWidth     =   1530.142
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   1470.047
         EndProperty
         BeginProperty Column03 
         EndProperty
         BeginProperty Column04 
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
      TabIndex        =   12
      Top             =   120
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.Label l1 
      Caption         =   "Label7"
      Height          =   255
      Left            =   3720
      TabIndex        =   11
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
      Left            =   0
      TabIndex        =   7
      Top             =   6120
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
      TabIndex        =   5
      Top             =   120
      Width           =   3735
   End
End
Attribute VB_Name = "frmInterf"
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
Dim rstTMEOFF As ADODB.Recordset
Dim rstTMEMPLY As ADODB.Recordset
Dim rstTMDESIGN As ADODB.Recordset
Dim rstTMTimeOff As ADODB.Recordset
Dim rstTMABSENT As ADODB.Recordset
Dim rstTMWorkGrp As ADODB.Recordset
Dim rstCSCoupon As ADODB.Recordset

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
Dim gPath As String
Dim iPos As Integer
Dim FileDelete As String

Dim sFolderDir As String
Dim sLogFolder As String
Dim sArr() As String
Dim tempStr As String
Dim iAbsInserted As Integer
Dim iInserted As Integer
Dim iUpdated As Integer
Dim sSQL1 As String

Dim gDate As Date           'SUSAN PJ14/0106

Dim sSecu As String, sCVT As String, lA As String, lB As String, sC As String
Dim lStart As Long, lCount2 As Long

Dim gCompanyName As String

Private Sub cboCompany_Change()
    Call cboCompany_Click
End Sub

Private Sub cboCompany_Click()

    gConnVw = "DRIVER={MySQL ODBC 5.3 Unicode Driver};"
    
    '==== Connection Change 1 =============
    gConnVw = gConnVw & "Server=" & gComIP & ";Port=3307;UID=root;Password=Pass;Database=" & gComDir & ";OPTION=3;" '==IQOR SERVER
    'gConnVw = gConnVw & "Server=" & gComIP & ";Port=3307;UID=root;Password=admin@987412;Database=" & gComDir & ";OPTION=3;" '===BRO Desktop Debug
    
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
        Me.Height = 10485
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
    'minimize_to_tray
    Shell_NotifyIcon NIM_DELETE, nid

    With Me
        .Move (Screen.Width - .Width), (Screen.Height - .Height)
        .Top = 0
        .Left = 0
    End With
    tmCount.Enabled = True
    cmdDetail.Caption = "&Summary"
    
    gPath = App.Path '===Drive Letter:\BROMY\IQOR\GetFrSap '=== When running at 221
                     '===Drive Letter:\BROMY\IQOR '=== When at iQOR Server
                     
    '===== Connection Change 2 =====================
    'gPath = Replace(gPath, "\GetFrSap", "") '=== When running at 221, enable this to remove GetFrSap
    
    sFolderDir = gPath & "\EMPMASTER_CHANGE_ABSENCE\"
    sLogFolder = gPath & "\EMPMASTER_CHANGE_ABSENCE\LOG\"
    
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
    iConnect = 0
    iCheck = 0
    bNoRefresh = False
    
'On Error GoTo ErrorHandler
    
    Open App.Path & "\IP.TXT" For Input As 1
    Do While Not EOF(1)
        Line Input #1, sComDir
        If sComDir <> "" Then
            bPass = True
            iCheck = iCheck + 1
            
             '===== Connection Change 3 =====================
            'connect to server
            sComIP = sComDir
            
            'sComDir = "IQOR190228 " '==Use in 221 Databse
            sComDir = "IQOR " '==Use in IQOR
            
            gComIP = sComIP
            
            'gComDir = "IQOR190228 " '==Use in 221 Databse
            gComDir = "IQOR " '==Use in IQOR
            
            sDatabase = "DRIVER={MySQL ODBC 5.3 Unicode Driver};"
            
            '===== Connection Change 4 =====================
            sDatabase = sDatabase & "Server=" & sComIP & ";Port=3307;UID=root;Password=Pass;Database=" & sComDir & ";OPTION=3;" '==IQOR SERVER
            'sDatabase = sDatabase & "Server=" & sComIP & ";Port=3307;UID=root;Password=admin@987412;Database=" & sComDir & ";OPTION=3;" '==BRO
            
            Set gConn(iConnect) = New ADODB.Connection
            gConn(iConnect).Open sDatabase
            If bPass = True Then
                gCompany(iConnect) = sComIP & "; " & sComDir
                lstConnection.AddItem gCompany(iConnect) & " >> Connected"
                
                cboCompany.AddItem gCompany(iConnect) & " > " & iConnect
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
        
        Call pInsAbsConn
        
        Call pInsEmpConn
        
        Call pUpEmpConn
        
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
        lstConnection.AddItem sComDir & " >> Insert Failed"
    Else
        lstConnection.AddItem sComDir & " >> Unexpected Error !! ( " & pDateTime() & " )"
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
        
        'If iRestart >= 10 Then
        '    Shell App.Path & "/Email.exe"
        '    End
        'End If
    
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

Private Sub pInsAbsConn()
    Dim sErrorMsg As String
    Dim iLoop As Integer
    Dim sFileName As String
    Dim strFileName As String
    Dim bInsertAbs As Boolean
    Dim lFileSize As String
    
    If lstConnection.ListCount > 10000 Then
        lstConnection.Clear
        lstConnection.Refresh
    End If
    
    lstConnection.AddItem "Start Checking < " & Time() & " >"
    lstConnection.Refresh
    
    If lstStatus.ListCount > 10000 Then
        lstStatus.Clear
        lstStatus.Refresh
    End If
    
    
    For iLoop = 0 To iConnect - 1
        
        Dim fso As New FileSystemObject
        
        If fso.FolderExists(sFolderDir) Then
            sFileName = Dir(sFolderDir & "ABSENCE*.txt")
            If Len(sFileName) > 0 Then
                lFileSize = FileLen(sFolderDir & sFileName)
                If lFileSize > 0 Then
                    strFileName = sFolderDir & sFileName
                    sErrorMsg = pInsertAbs(iLoop, strFileName)
                    
                    If sErrorMsg <> "" Then

                        sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'From SAP',"
                        sSQL = sSQL & "'Fail',"
                        sSQL = sSQL & "'Insert Absence failed! Filename : " & sFileName & " , " & sErrorMsg & "',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(0).Execute sSQL
                        
                        lstConnection.AddItem "Insert Time Off failed!" & sFileName & " , " & sErrorMsg
                        lstConnection.Refresh
                        
                    Else

                        sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'From SAP',"
                        sSQL = sSQL & "'Success',"
                        sSQL = sSQL & "'Inserted/Updated Absences completed! Filename: " & sFileName & ", " & iAbsInserted & " record/s imported! ', "
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(0).Execute sSQL
                    
                        lstConnection.AddItem "Insert/Update Time Off completed. Filename: " & sFileName & ", " & iAbsInserted & " record/s imported! at < " & Time() & " >"
                        lstConnection.Refresh
                        
                        '====Below is Copy and Replace the destination folder ====
                        FileCopy sFolderDir & sFileName, sLogFolder & sFileName
                        Kill (sFolderDir & sFileName)
                        
                        '==== This is move and will not replace if existing file is in the destination folder but will give an error =========
                        'Name sFolderDir & sFileName As sLogFolder & sFileName
                        
                    End If
                    
                Else
                    Call cmdDetail_Click
                    bInsertAbs = False
                End If
            Else
                Call cmdDetail_Click
                bInsertAbs = False
            End If
        End If
    Next
End Sub

Private Function pInsertAbs(iConn As Integer, sFileLoc As String) As String

Dim strRow As String
Dim sDate As String
Dim iPos As Integer

Dim sEmp_Code As String
Dim sDtFr As String
Dim sDtTo As String
Dim sTOFF_ID As String
Dim sPart As String
Dim sPaid As String
Dim sLType As String
Dim sDura As String

    Open sFileLoc For Input As #2
    
        iAbsInserted = 0
        
        Do While Not EOF(2)
            
            Line Input #2, strRow
            
            If strRow = "$$$$" Then
                Exit Do
            End If
            
            sDate = Mid(Trim(strRow), 10, 8)
            If sDate <> "" Then
                sDate = Mid(sDate, 1, 2) & "/" & Mid(sDate, 3, 2) & "/" & Mid(sDate, 5, 4)

                If Not IsDate(sDate) Then
                    pInsertAbs = "Error In " & sFileLoc & " , Please Contact Your Dealer!!"
                    Exit Function
                End If
            Else
                pInsertAbs = "Error In " & sFileLoc & " , Please Contact Your Dealer!!"
                Exit Function
            End If
        
            If strRow <> "" Then
                
                iPos = InStr(1, strRow, ",")
                If iPos > 0 Then
                    sEmp_Code = Mid(strRow, 1, iPos - 1)
                        
                    tempStr = Trim(sEmp_Code)
                    
                    Do While Left(tempStr, 1) = "0" And tempStr <> ""
                        tempStr = Right(tempStr, Len(tempStr) - 1)
                    Loop
                    
                    sEmp_Code = tempStr
                End If
                strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
    
                iPos = InStr(1, strRow, ",")
                If iPos > 0 Then
                    sDtFr = Mid(strRow, 1, iPos - 1)
                    sDtFr = Mid(sDtFr, 1, 2) & "/" & Mid(sDtFr, 3, 2) & "/" & Mid(sDtFr, 5, 4)
                End If
                strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
    
                iPos = InStr(1, strRow, ",")
                If iPos > 0 Then
                    sDtTo = Mid(strRow, 1, iPos - 1)
                    sDtTo = Mid(sDtTo, 1, 2) & "/" & Mid(sDtTo, 3, 2) & "/" & Mid(sDtTo, 5, 4)
                End If
                strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
    
                iPos = InStr(1, strRow, ",")
                If iPos > 0 Then
                    sTOFF_ID = Mid(strRow, 1, iPos - 1)
                End If
                strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
    
                iPos = InStr(1, strRow, ",")
                If iPos > 0 Then
                    sDura = Mid(strRow, 1, iPos - 1)
                    If sDura = "1.00" Then
                        sLType = "F"
                    Else
                        sLType = "H"
                    End If
                End If
                strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
    
                '================Check if Time OFF ID exist ===================================
                sSQL = "select PART,PAID from TMTIMEOFF where TOFF_ID ='" & pRTIN(sTOFF_ID) & "'"
                Set rstTMTimeOff = New ADODB.Recordset
                rstTMTimeOff.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                If Not rstTMTimeOff.EOF Then
                    
                    sPart = rstTMTimeOff("PART")
                    sPaid = rstTMTimeOff("PAID")
                    
                    '=========== Check if this date already exist==============================
                    sSQL = "select * from TMEOFF where EMP_CODE ='" & pRTIN(sEmp_Code) & "'"
                    sSQL = sSQL & " and DTFR= '" & fDate2(CDate(sDtFr)) & "'"
                    sSQL = sSQL & " and DTTO = '" & fDate2(CDate(sDtTo)) & "'"
                    Set rstTMEOFF = New ADODB.Recordset
                    rstTMEOFF.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                    If rstTMEOFF.BOF Then
                        '=== No leave has been apply insert into TMEOFF
                        sSQL = "insert into TMEOFF (EMP_CODE,DTTO,DTFR,TOFF_ID,PART,PAID,LTYPE,DURA,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'" & pRTIN(sEmp_Code) & "',"
                        sSQL = sSQL & "'" & fDate2(CDate(sDtFr)) & "',"
                        sSQL = sSQL & "'" & fDate2(CDate(sDtTo)) & "',"
                        sSQL = sSQL & "'" & pRTIN(sTOFF_ID) & "',"
                        sSQL = sSQL & "'" & pRTIN(sPart) & "',"
                        sSQL = sSQL & "'" & pRTIN(sPaid) & "',"
                        sSQL = sSQL & "'" & sLType & "',"
                        sSQL = sSQL & "'" & sDura & "',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(iConn).Execute sSQL
                        
                        
                        If CDate(sDtFr) = CDate(sDtTo) Then '=== Only applies when the leave duration is 1 day
                            '=== WHEN new leave is inserted
                            '=== I assume ABSENT has already been generated.
                            '=== If you apply Half-day LEAVE in ADVANCE, you are not absent YET. Therefore no INSERT
                            '=== However if you apply leave after ABSENT is inserted. You are either 1 day or Half day absent
                            '=== If 1 day ABSENT but you apply for Half day LEAVE, I will update your ABSENT to Half Day
                            sSQL = "select * from TMABSENT where EMP_CODE = '" & pRTIN(sEmp_Code) & "'"
                            sSQL = sSQL & " and DT_ABSENT = '" & fDate2(CDate(sDtFr)) & "'"
                            Set rstTMABSENT = New ADODB.Recordset
                            rstTMABSENT.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                            If Not rstTMABSENT.BOF Then
                                sSQL = "UPDATE TMABSENT SET "
                                sSQL = sSQL & " TYPE='" & sLType & "',"
                                sSQL = sSQL & " USER_ID='SERVER',"
                                sSQL = sSQL & " DATETIME='" & fDateTime2() & "'"
                                sSQL = sSQL & " WHERE EMP_CODE= '" & pRTIN(sEmp_Code) & "'"
                                sSQL = sSQL & " AND DT_ABSENT='" & fDate2(CDate(sDtFr)) & "'"
                                gConn(iConn).Execute sSQL
                                
                            End If
                        End If
                       
                       
                        lstStatus.AddItem "Inserted Time Off for Employee : " & sEmp_Code & " >> " & sDtFr & " - " & sDtTo & " Leave Type : " & sLType
                        lstStatus.Refresh
                    
                    Else
                        
                        sSQL = "UPDATE TMEOFF SET"
                        sSQL = sSQL & " TOFF_ID = '" & pRTIN(sTOFF_ID) & "',"
                        sSQL = sSQL & " PART = '" & pRTIN(sPart) & "',"
                        sSQL = sSQL & " PAID = '" & pRTIN(sPaid) & "',"
                        sSQL = sSQL & " LTYPE='" & sLType & "',"
                        sSQL = sSQL & " DURA = '" & sDura & "',"
                        sSQL = sSQL & " USER_ID = 'SERVER',"
                        sSQL = sSQL & " DATETIME = '" & fDateTime2() & "'"
                        sSQL = sSQL & " WHERE EMP_CODE = '" & pRTIN(sEmp_Code) & "'"
                        sSQL = sSQL & " AND DTFR = '" & fDate2(CDate(sDtFr)) & "'"
                        sSQL = sSQL & " AND DTTO = '" & fDate2(CDate(sDtTo)) & "'"
                        gConn(iConn).Execute sSQL
                        
                        
                        If CDate(sDtFr) = CDate(sDtTo) Then '=== Only applies when the leave duration is 1 day
                            '=== IF UPDATING WHEN new leave is inserted
                            '=== I assume ABSENT has already been generated.
                            '=== If you apply Half-day LEAVE in ADVANCE, you are not absent YET. Therefore no INSERT
                            '=== However if you apply leave after ABSENT is inserted. You are either 1 day or Half day absent
                            '=== If 1 day ABSENT but you apply for Half day LEAVE, I will update your ABSENT to Half Day
                            sSQL = "select * from TMABSENT where EMP_CODE = '" & pRTIN(sEmp_Code) & "'"
                            sSQL = sSQL & " and DT_ABSENT = '" & fDate2(CDate(sDtFr)) & "'"
                            Set rstTMABSENT = New ADODB.Recordset
                            rstTMABSENT.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                            If Not rstTMABSENT.BOF Then
                                sSQL = "UPDATE TMABSENT SET "
                                sSQL = sSQL & " TYPE='" & sLType & "',"
                                sSQL = sSQL & " USER_ID='SERVER',"
                                sSQL = sSQL & " DATETIME='" & fDateTime2() & "'"
                                sSQL = sSQL & " WHERE EMP_CODE= '" & pRTIN(sEmp_Code) & "'"
                                sSQL = sSQL & " AND DT_ABSENT='" & fDate2(CDate(sDtFr)) & "'"
                                gConn(iConn).Execute sSQL
                            End If
                        End If
                        
                        lstStatus.AddItem " Updated Time Off for Employee : " & sEmp_Code & " From : " & sDtFr & " To : " & sDtTo & " Leave Type : " & sLType
                        lstStatus.Refresh
                    
                    End If
                    Call pCloseTables(rstTMEOFF)
                    
                    iAbsInserted = iAbsInserted + 1
                    
                Else

                sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                sSQL = sSQL & "values ("
                sSQL = sSQL & "'From SAP',"
                sSQL = sSQL & "'Fail',"
                sSQL = sSQL & "' Failed! Time OFF ID : " & sTOFF_ID & " does not exist for Employee : " & sEmp_Code & " From : " & sDtFr & " To : " & sDtTo & " Leave Type : " & sLType & "', "
                    sSQL = sSQL & "'SERVER',"
                    sSQL = sSQL & "'" & fDateTime2() & "'"
                    sSQL = sSQL & ") "
                    gConn(0).Execute sSQL
                    
                    lstStatus.AddItem " Failed! Time OFF ID : " & sTOFF_ID & " does not exist for Employee : " & sEmp_Code & " From : " & sDtFr & " To : " & sDtTo & " Leave Type : " & sLType
                    lstStatus.Refresh
                
                
                End If
                Call pCloseTables(rstTMTimeOff)
            
            End If
        
        Loop
        Close #2
End Function

Private Sub pInsEmpConn()
    Dim sErrorMsg As String
    Dim iLoop As Integer
    Dim sFileName As String
    Dim strFileName As String
    Dim bInsertAbs As Boolean
    Dim lFileSize As String
    
    For iLoop = 0 To iConnect - 1
        
        Dim fso As New FileSystemObject
     
        If fso.FolderExists(sFolderDir) Then
            sFileName = Dir(sFolderDir & "EmpMaster*.txt")
            If Len(sFileName) > 0 Then
                lFileSize = FileLen(sFolderDir & sFileName)
                If lFileSize > 0 Then
                    strFileName = sFolderDir & sFileName
                    sErrorMsg = pInsEmp(iLoop, strFileName)
                    
                    If sErrorMsg <> "" Then

                        sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'From SAP',"
                        sSQL = sSQL & "'Fail',"
                        sSQL = sSQL & "'Insert Employee failed! Filename : " & sFileName & " , " & sErrorMsg & "',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(0).Execute sSQL
                        
                        lstConnection.AddItem "Insert Employee failed!" & sFileName & " , " & sErrorMsg
                        lstConnection.Refresh
                        
                    Else

                        sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'From SAP',"
                        sSQL = sSQL & "'Success',"
                        sSQL = sSQL & "'Insert Employee completed! Filename : " & sFileName & "," & iInserted & " record/s imported! ', "
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(0).Execute sSQL
                        
                        lstConnection.AddItem "Insert Employee completed. Filename: " & sFileName & ", " & iInserted & " record/s imported! at < " & Time() & " >"
                        lstConnection.Refresh
                        
                        '====Below is Copy and Replace the destination folder ====
                        FileCopy sFolderDir & sFileName, sLogFolder & sFileName
                        Kill (sFolderDir & sFileName)
                        
                        '==== This is move and will not replace if existing file is in the destination folder but will give an error =========
                        'Name sFolderDir & sFileName As sLogFolder & sFileName
                        
                    End If
                Else
                    Call cmdDetail_Click
                    bInsertAbs = False
                End If
            Else
                Call cmdDetail_Click
                bInsertAbs = False
            End If
        End If
    Next
End Sub

Private Function pInsEmp(iConn As Integer, sFileLoc As String) As String

Dim strRow As String
Dim sDate As String
Dim iPos As Integer

Dim sEmp_Code As String
Dim sName As String
Dim sAccess As String
Dim sCompu As String
Dim sCost_ID As String
Dim sDtJoin As String
Dim sDtConfirm As String
Dim sDtResign As String
Dim sDesign As String
Dim sSup_ID As String
Dim sEntity As String
Dim sBuild_ID As String
Dim sWork_ID As String
Dim sClient As String
Dim sFunc As String
Dim sGrade_ID As String
Dim sWorkGrp_ID As String
Dim sHol_ID As String
Dim dCoupon As Double
Dim i As Integer

    Open sFileLoc For Input As #3
        
        Do While Not EOF(3)
            
            Line Input #3, strRow
            
            If strRow = "$$$$" Then
                Exit Do
            End If
            
                
            strRow = Replace(strRow, vbLf, "|")
            sArr = Split(strRow, "|")
        
            For i = 0 To UBound(sArr)
                      
                strRow = sArr(i)
              
                If strRow <> "" Then
            
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sEmp_Code = Mid(strRow, 1, iPos - 1)
                            
                        tempStr = Trim(sEmp_Code)
                        
                        Do While Left(tempStr, 1) = "0" And tempStr <> ""
                            tempStr = Right(tempStr, Len(tempStr) - 1)
                        Loop
                        
                        sEmp_Code = tempStr
                        
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
        
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sName = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
        
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sBuild_ID = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sCompu = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sCost_ID = Trim(Mid(strRow, 1, iPos - 1))
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sDtJoin = Mid(strRow, 1, iPos - 1)
                        sDtJoin = Mid(sDtJoin, 1, 2) & "/" & Mid(sDtJoin, 3, 2) & "/" & Mid(sDtJoin, 5, 4)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sDtConfirm = Mid(strRow, 1, iPos - 1)
                        If sDtConfirm <> "" Then
                            sDtConfirm = Mid(sDtConfirm, 1, 2) & "/" & Mid(sDtConfirm, 3, 2) & "/" & Mid(sDtConfirm, 5, 4)
                        End If
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sDtResign = Mid(strRow, 1, iPos - 1)
                        If sDtResign <> "" Then
                            sDtResign = Mid(sDtResign, 1, 2) & "/" & Mid(sDtResign, 3, 2) & "/" & Mid(sDtResign, 5, 4)
                        End If
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sDesign = Trim(Mid(strRow, 1, iPos - 1))
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sSup_ID = Mid(strRow, 1, iPos - 1)
                            
                        tempStr = Trim(sSup_ID)
                        
                        Do While Left(tempStr, 1) = "0" And tempStr <> ""
                            tempStr = Right(tempStr, Len(tempStr) - 1)
                        Loop
                        
                        sSup_ID = tempStr
                        
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sEntity = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sWork_ID = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sClient = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sFunc = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sGrade_ID = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    sWorkGrp_ID = Trim(strRow)
                    
                    '=== Employee Code must not exist in System ================================
                    sSQL = "select * from TMEMPLY where EMP_CODE ='" & pRTIN(sEmp_Code) & "'"
                    Set rstTMEMPLY = New ADODB.Recordset
                    rstTMEMPLY.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                    If rstTMEMPLY.BOF Then '=== Employee Code must not exist in System
                    
                        '=======Insert Employee===============================================
                        sSQL = "insert into TMEMPLY (EMP_CODE,NAME,COST_ID,SUP_CODE,DT_JOIN,DESIGN_ID,"
                        sSQL = sSQL & "WORK_ID,GRADE_ID,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'" & pRTIN(sEmp_Code) & "',"
                        sSQL = sSQL & "'" & pRTIN(sName) & "',"
                        sSQL = sSQL & "'" & pRTIN(sCost_ID) & "',"
                        sSQL = sSQL & "'" & pRTIN(sSup_ID) & "',"
                        sSQL = sSQL & "'" & fDate2(CDate(sDtJoin)) & "',"
                        sSQL = sSQL & "'" & pRTIN(sDesign) & "',"
                        sSQL = sSQL & "'" & pRTIN(sWork_ID) & "',"
                        sSQL = sSQL & "'" & pRTIN(sGrade_ID) & "',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(iConn).Execute sSQL
                        
                        '===== Insert Coupon for employee ======
                        sSQL = "select COUPON from cspath"
                        Set rstCSCoupon = New ADODB.Recordset
                        rstCSCoupon.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                        If Not rstCSCoupon.EOF Then
                            dCoupon = rstCSCoupon("COUPON")
                        End If
                        Call pCloseTables(rstCSCoupon)
                      
                        sSQL = "insert into CSEMPLY(EMP_CODE, NAME, COUPON, STATUS, CREATE_ID, DT_CREATE, USER_ID, DATETIME) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'" & pRTIN(sEmp_Code) & "',"
                        sSQL = sSQL & "'" & pRTIN(sName) & "',"
                        sSQL = sSQL & "'" & p2Dec(dCoupon) & "',"
                        sSQL = sSQL & "'Y',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(iConn).Execute sSQL
                        
                        lstStatus.AddItem "Inserted Employee Code : " & sEmp_Code & " , " & sName
                        lstStatus.Refresh
                        '==== Finish inserting employee and coupons =============================================
                        
                        '==========THIS PART IS TO UPDATE THE EMPLOYEE WORKGROUP====================
                        '===== Only if WorkGroup exist, get the HOL_ID
                        sSQL = "select HOL_ID from TMWORKGRP where WORKGRP_ID ='" & pRTIN(sWorkGrp_ID) & "'"
                        Set rstTMWorkGrp = New ADODB.Recordset
                        rstTMWorkGrp.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                        If Not rstTMWorkGrp.EOF Then
                            
                            sHol_ID = rstTMWorkGrp("HOL_ID")
                            
                            '========= Employee must NOT be in a WorkGroup in the system ===============
                            sSQL = "select * from TMWORKGRP where EMP_CODE ='" & pRTIN(sEmp_Code) & "'"
                            Set rstTMWorkGrp = New ADODB.Recordset
                            rstTMWorkGrp.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                            If rstTMWorkGrp.BOF Then
                                sSQL = "insert into TMWORKGRP (WORKGRP_ID,EMP_CODE,HOL_ID,USER_ID,DATETIME,CREATE_ID,DT_CREATE) "
                                sSQL = sSQL & "values ("
                                sSQL = sSQL & "'" & pRTIN(sWorkGrp_ID) & "',"
                                sSQL = sSQL & "'" & pRTIN(sEmp_Code) & "',"
                                sSQL = sSQL & "'" & pRTIN(sHol_ID) & "',"
                                sSQL = sSQL & "'SERVER',"
                                sSQL = sSQL & "'" & fDateTime2() & "',"
                                sSQL = sSQL & "'SERVER',"
                                sSQL = sSQL & "'" & fDateTime2() & "'"
                                sSQL = sSQL & ") "
                                gConn(iConn).Execute sSQL
                                
                                iInserted = iInserted + 1 '=== Count how records being updated
                                    
                                lstStatus.AddItem "Inserted WorkGroup : " & sWorkGrp_ID & " For Employee " & sEmp_Code
                                lstStatus.Refresh
                            
                            Else

                            '=== Employee Exist in Some WorkGroup
                            sSQL = "insert into TMLOG (EMP_CODE,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                            sSQL = sSQL & "values ("
                            sSQL = sSQL & "'" & sEmp_Code & "',"
                            sSQL = sSQL & "'From SAP',"
                            sSQL = sSQL & "'Error',"
                            sSQL = sSQL & "'Error! Employee " & sEmp_Code & " exsits in Workgroup " & rstTMWorkGrp("WORKGRP_ID") & "' "
                            sSQL = sSQL & "'SERVER',"
                                sSQL = sSQL & "'" & fDateTime2() & "'"
                                sSQL = sSQL & ") "
                                gConn(0).Execute sSQL
                                
                                lstStatus.AddItem " Error! Employee " & sEmp_Code & " exisit in Workgroup " & rstTMWorkGrp("WORKGRP_ID")
                                lstStatus.Refresh
                                
                            End If
                        Else

                        '=== Insert into Log can't find WorkGroup
                        sSQL = "insert into TMLOG (EMP_CODE,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                        sSQL = sSQL & "values ("
                            sSQL = sSQL & "'" & sEmp_Code & "',"
                        sSQL = sSQL & "'From SAP',"
                        sSQL = sSQL & "'Error',"
                        sSQL = sSQL & "'Can't find Workgroup " & sWorkGrp_ID & " for Employee " & sEmp_Code & "' "
                        sSQL = sSQL & "'SERVER',"
                            sSQL = sSQL & "'" & fDateTime2() & "'"
                            sSQL = sSQL & ") "
                            gConn(0).Execute sSQL
                            
                            lstStatus.AddItem "Can't find Workgroup " & sWorkGrp_ID & " for Employee " & sEmp_Code
                            lstStatus.Refresh
                        
                        End If
                        Call pCloseTables(rstTMWorkGrp)
                        
                    Else

                    '=== Insert into Log can't find WorkGroup
                    sSQL = "insert into TMLOG (EMP_CODE,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                    sSQL = sSQL & "values ("
                        sSQL = sSQL & "'" & sEmp_Code & "',"
                    sSQL = sSQL & "'From SAP',"
                    sSQL = sSQL & "'Fail',"

                    sSQL = sSQL & "'Insert Employee Unsuccessful! " & sEmp_Code & " alredy exist in the system.' , "
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(0).Execute sSQL
                        
                        lstStatus.AddItem "Insert Employee Unsuccessful! " & sEmp_Code & " alredy exist in the system. "
                        lstStatus.Refresh
                    
                    End If
                    Call pCloseTables(rstTMEMPLY)
                            
                End If
            
            Next
            
        Loop
        Close #3
End Function

Private Sub pUpEmpConn()
    Dim sErrorMsg As String
    Dim iLoop As Integer
    Dim sFileName As String
    Dim strFileName As String
    Dim bInsertAbs As Boolean
    Dim lFileSize As String

    For iLoop = 0 To iConnect - 1
        
        Dim fso As New FileSystemObject
                
        If fso.FolderExists(sFolderDir) Then
            sFileName = Dir(sFolderDir & "Change*.txt")
            If Len(sFileName) > 0 Then
                lFileSize = FileLen(sFolderDir & sFileName)
                If lFileSize > 0 Then
                    strFileName = sFolderDir & sFileName
                    sErrorMsg = pUpEmp(iLoop, strFileName)
                    
                    If sErrorMsg <> "" Then

                        sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'From SAP',"
                        sSQL = sSQL & "'Fail',"
                        sSQL = sSQL & "'Update Employee failed! Filename : '" & sFileName & " , " & sErrorMsg & "',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(0).Execute sSQL
                    
                        lstConnection.AddItem "Update Employee failed! Filename : '" & sFileName & " , " & sErrorMsg
                        lstConnection.Refresh
                        
                    Else

                        sSQL = "insert into TMLOG (TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                        sSQL = sSQL & "values ("
                        sSQL = sSQL & "'From SAP',"
                        sSQL = sSQL & "'Success',"
                        sSQL = sSQL & "'Update Employee completed! Filename : " & sFileName & "," & iUpdated & " record/s imported! ', "
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(0).Execute sSQL
                        
                        lstConnection.AddItem "Update Employee completed! Filename: " & sFileName & ", " & iUpdated & " record/s imported! at < " & Time() & " >"
                        lstConnection.Refresh
                        
                        '====Below is Copy and Replace the destination folder ====
                        FileCopy sFolderDir & sFileName, sLogFolder & sFileName
                        Kill (sFolderDir & sFileName)
                        
                        '==== This is move and will not replace if existing file is in the destination folder but will give an error =========
                        'Name sFolderDir & sFileName As sLogFolder & sFileName
                        
                    End If
                Else
                    Call cmdDetail_Click
                    bInsertAbs = False
                End If
            Else
                Call cmdDetail_Click
                bInsertAbs = False
            End If
        End If
    Next
End Sub


Private Function pUpEmp(iConn As Integer, sFileLoc As String) As String

Dim strRow As String
Dim sDate As String
Dim iPos As Integer

Dim sEmp_Code As String
Dim sName As String
Dim sChange As String
Dim sDtEffec As String
Dim sCost_ID As String
Dim sDesign As String
Dim sSup_ID As String
Dim sEntity As String
Dim sClient As String
Dim sFunc As String
Dim sGrade_ID As String
Dim sWorkGrp_ID As String
Dim sWork_ID As String
Dim sHol_ID As String

Dim i As Integer
Dim sSQLCS As String

    Open sFileLoc For Input As #4
        
        iUpdated = 0
        
        Do While Not EOF(4)
            
            Line Input #4, strRow
            
            If strRow = "$$$$" Then
                Exit Do
            End If
            
            strRow = Replace(strRow, vbLf, "|")
            sArr = Split(strRow, "|")
            
            For i = 0 To UBound(sArr)
                
                strRow = sArr(i)
                
                If strRow <> "" Then
                  
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                    
                        sEmp_Code = Mid(strRow, 1, iPos - 1)
                        
                        tempStr = Trim(sEmp_Code)
                        
                        Do While Left(tempStr, 1) = "0" And tempStr <> ""
                            tempStr = Right(tempStr, Len(tempStr) - 1)
                        Loop
                        
                        sEmp_Code = tempStr
                        
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
        
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sName = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
        
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sChange = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sDtEffec = Mid(strRow, 1, iPos - 1)
                        sDtEffec = Mid(sDtEffec, 1, 2) & "/" & Mid(sDtEffec, 3, 2) & "/" & Mid(sDtEffec, 5, 4)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sGrade_ID = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sDesign = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sCost_ID = Trim(Mid(strRow, 1, iPos - 1))
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sSup_ID = Mid(strRow, 1, iPos - 1)
                        
                        tempStr = Trim(sSup_ID)
                        
                        Do While Left(tempStr, 1) = "0" And tempStr <> ""
                            tempStr = Right(tempStr, Len(tempStr) - 1)
                        Loop
                        
                        sSup_ID = tempStr
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sWorkGrp_ID = Trim(Mid(strRow, 1, iPos - 1))
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sEntity = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sWork_ID = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sClient = Mid(strRow, 1, iPos - 1)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    iPos = InStr(1, strRow, ",")
                    If iPos > 0 Then
                        sFunc = Mid(strRow, 1, 4)
                    End If
                    strRow = Trim(Mid(strRow, iPos + 1, Len(strRow)))
                    
                    
                    '==== UPDATE TMEMPLY =========================================================
                    sSQL = "select * from TMEMPLY where EMP_CODE ='" & pRTIN(sEmp_Code) & "'"
                    Set rstTMEMPLY = New ADODB.Recordset
                    rstTMEMPLY.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                    If Not rstTMEMPLY.BOF Then '=== Here is UPDATE, so EMP_CODE must exist
                        
                        sSQL = "UPDATE TMEMPLY set "
                        sSQL = sSQL & "EMP_CODE ='" & pRTIN(sEmp_Code) & "',"
                        sSQL = sSQL & "NAME='" & pRTIN(sName) & "',"
                        
                        If sChange = "H" Then
                            sSQL = sSQL & "DT_JOIN='" & fDate2(CDate(sDtEffec)) & "',"
                            sSQL = sSQL & "DT_CONFIRM = NULL,"
                            sSQL = sSQL & "DT_RESIGN = NULL,"
                            
                            sSQLCS = "UPDATE CSEMPLY SET "
                            sSQLCS = sSQLCS & "STATUS = 'Y',"
                            sSQLCS = sSQLCS & "CREATE_ID = 'SERVER',"
                            sSQLCS = sSQLCS & "DT_CREATE = '" & fDateTime2() & "',"
                            sSQLCS = sSQLCS & "USER_ID = 'SERVER',"
                            sSQLCS = sSQLCS & "DATETIME = '" & fDateTime2() & "'"
                            sSQLCS = sSQLCS & " WHERE EMP_CODE = '" & pRTIN(sEmp_Code) & "'"
                            gConn(iConn).Execute sSQLCS
                            
                        ElseIf sChange = "X" Then
                            sSQL = sSQL & "DT_RESIGN = '" & fDate2(CDate(sDtEffec)) & "',"
                            
                            sSQLCS = "UPDATE CSEMPLY SET "
                            sSQLCS = sSQLCS & "STATUS = 'N',"
                            sSQLCS = sSQLCS & "CREATE_ID = 'SERVER',"
                            sSQLCS = sSQLCS & "DT_CREATE = '" & fDateTime2() & "',"
                            sSQLCS = sSQLCS & "USER_ID = 'SERVER',"
                            sSQLCS = sSQLCS & "DATETIME = '" & fDateTime2() & "'"
                            sSQLCS = sSQLCS & " WHERE EMP_CODE = '" & pRTIN(sEmp_Code) & "'"
                            gConn(iConn).Execute sSQLCS
                            
                        End If
                        
                        sSQL = sSQL & "GRADE_ID = '" & pRTIN(sGrade_ID) & "',"
                        sSQL = sSQL & "DESIGN_ID='" & pRTIN(sDesign) & "',"
                        sSQL = sSQL & "COST_ID = '" & pRTIN(sCost_ID) & "',"
                        sSQL = sSQL & "SUP_CODE='" & pRTIN(sSup_ID) & "',"
                        sSQL = sSQL & "WORK_ID='" & pRTIN(sWork_ID) & "',"
                        sSQL = sSQL & "USER_ID = 'SERVER',"
                        sSQL = sSQL & "DATETIME = '" & fDateTime2() & "'"
                        sSQL = sSQL & " WHERE EMP_CODE = '" & pRTIN(sEmp_Code) & "'"
                        gConn(iConn).Execute sSQL
                        
                        lstStatus.AddItem "Updated Employee Code : " & sEmp_Code & " , " & sName & " , " & sChange
                        lstStatus.Refresh
                        
                 '============END UPDATE TMEMPLY ===================================================
                        
                        '==========THIS PART IS TO UPDATE THE EMPLOYEE WORKGROUP====================
                        '===== Only if WorkGroup exist, get the HOL_ID
                        sSQL = "select HOL_ID from TMWORKGRP where WORKGRP_ID ='" & sWorkGrp_ID & "'"
                        Set rstTMWorkGrp = New ADODB.Recordset
                        rstTMWorkGrp.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                        If Not rstTMWorkGrp.EOF Then
                            
                            sHol_ID = rstTMWorkGrp("HOL_ID")
                            
                            '==== Employee must be in a WorkGROUP
                            sSQL = "select * from TMWORKGRP where EMP_CODE ='" & sEmp_Code & "'"
                            Set rstTMWorkGrp = New ADODB.Recordset
                            rstTMWorkGrp.Open sSQL, gConn(iConn), adOpenStatic, adLockPessimistic
                            If Not rstTMWorkGrp.EOF Then '=== must be in a workgroup
                                sSQL = "Update TMWORKGRP set "
                                sSQL = sSQL & "WORKGRP_ID = '" & pRTIN(sWorkGrp_ID) & "',"
                                sSQL = sSQL & "HOL_ID = '" & pRTIN(sHol_ID) & "',"
                                sSQL = sSQL & "USER_ID = 'SERVER',"
                                sSQL = sSQL & "DATETIME = '" & fDateTime2() & "'"
                                sSQL = sSQL & " WHERE EMP_CODE = '" & pRTIN(sEmp_Code) & "'"
                                gConn(iConn).Execute sSQL
                                
                                iUpdated = iUpdated + 1 '=== Count how records being updated
                                
                                lstStatus.AddItem "Updated WorkGroup : " & sWorkGrp_ID & " For Employee " & sEmp_Code
                                lstStatus.Refresh
                                
                            Else
                            '=== Insert into Log Can't find employee in any the WorkGroup
                            sSQL = "insert into TMLOG (EMP_CODE,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                            sSQL = sSQL & "values ("
                                sSQL = sSQL & "'" & sEmp_Code & "',"
                            sSQL = sSQL & "'From SAP',"
                            sSQL = sSQL & "'Error',"
                            sSQL = sSQL & "'Can't find employee, " & sEmp_Code & " in Workgroup " & sWorkGrp_ID & "' "
                                sSQL = sSQL & "'SERVER',"
                                sSQL = sSQL & "'" & fDateTime2() & "'"
                                sSQL = sSQL & ") "
                                gConn(0).Execute sSQL
                                
                                lstStatus.AddItem " Can't find employee, " & sEmp_Code & " in Workgroup " & sWorkGrp_ID
                                lstStatus.Refresh
                            
                            End If
                            
                        Else
                        '=== Insert into Log can't find WorkGroup
                        sSQL = "insert into TMLOG (EMP_CODE,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                        sSQL = sSQL & "values ("
                            sSQL = sSQL & "'" & sEmp_Code & "',"
                        sSQL = sSQL & "'From SAP',"
                        sSQL = sSQL & "'Error',"
                        sSQL = sSQL & "'Invalid Workgroup " & sWorkGrp_ID & " for Employee " & sEmp_Code & "', "
                        sSQL = sSQL & "'SERVER',"
                            sSQL = sSQL & "'" & fDateTime2() & "'"
                            sSQL = sSQL & ") "
                            gConn(0).Execute sSQL
                            
                            lstStatus.AddItem "Can't find Workgroup " & sWorkGrp_ID & " for Employee " & sEmp_Code
                            lstStatus.Refresh
                            
                        End If
                        Call pCloseTables(rstTMWorkGrp)
                        '=============END UPDATE WORKGROUP PART ===============================================
                        
                    Else

                    sSQL = "insert into TMLOG (EMP_CODE,TYPE,STATUS,REMARK,USER_ID,DATETIME) "
                    sSQL = sSQL & "values ("
                        sSQL = sSQL & "'" & sEmp_Code & "',"
                    sSQL = sSQL & "'From SAP',"
                    sSQL = sSQL & "'Fail',"
                    sSQL = sSQL & "'Update Employee " & sEmp_Code & " failed, not in database!',"
                        sSQL = sSQL & "'SERVER',"
                        sSQL = sSQL & "'" & fDateTime2() & "'"
                        sSQL = sSQL & ") "
                        gConn(0).Execute sSQL
                    
                        lstStatus.AddItem "NOT IN DATABSE! Employee Code : " & sEmp_Code & " , " & sName
                        lstStatus.Refresh
                        
                    End If
                    Call pCloseTables(rstTMEMPLY)
                    
                End If
                
            Next
            
        Loop
        Close #4
End Function
Private Sub tmRecord_Timer()
    
    sSQL = "SELECT * FROM TMEOFF ORDER BY EMP_CODE,DTFR"
    adoDetail1.RecordSource = sSQL
    adoDetail1.Refresh
    
    iRestart = iRestart + 1
    l2.Caption = iRestart
End Sub

Sub minimize_to_tray()
    Me.Hide
    nid.cbSize = Len(nid)
    nid.hwnd = Me.hwnd
    nid.uId = vbNull
    nid.uFlags = NIF_ICON2 Or NIF_TIP2 Or NIF_MESSAGE2
    nid.uCallBackMessage = WM_MOUSEMOVE2
    nid.hIcon = Me.Icon
    nid.szTip = "BRO Get Data from SAP" & vbNullChar
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

Public Function RemoveLeadingZeroes(str As String)
    Dim tempStr
    tempStr = str
    While Left(tempStr, 1) = "0" And tempStr <> ""
        tempStr = Right(tempStr, Len(tempStr) - 1)
    Wend
    RemoveLeadingZeroes = tempStr
End Function


