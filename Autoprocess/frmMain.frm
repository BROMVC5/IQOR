VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "ieframe.dll"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form frmMain 
   Caption         =   "TM AUTOPROCESS"
   ClientHeight    =   3375
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6285
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3375
   ScaleWidth      =   6285
   StartUpPosition =   2  'CenterScreen
   Begin MSComCtl2.Animation AniFile 
      Height          =   495
      Left            =   1080
      TabIndex        =   0
      Top             =   0
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   873
      _Version        =   393216
      FullWidth       =   345
      FullHeight      =   33
   End
   Begin SHDocVwCtl.WebBrowser Wb1 
      Height          =   1455
      Left            =   120
      TabIndex        =   1
      Top             =   960
      Width           =   6015
      ExtentX         =   10610
      ExtentY         =   2566
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Left            =   2880
      Top             =   2640
   End
   Begin VB.Label Label2 
      Caption         =   "180"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5520
      TabIndex        =   3
      Top             =   2560
      Width           =   375
   End
   Begin VB.Label Label1 
      Caption         =   "Close in (Sec) :"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   3960
      TabIndex        =   2
      Top             =   2550
      Width           =   1455
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim sURL1 As String
Dim gCounter As Integer


Private Sub cmdClose_Click()
    End
End Sub

Private Sub Form_Load()
    
    Timer1.Enabled = True
    Timer1.Interval = CDbl(1) * 1000 '=== 1 second interval
    
    'sURL1 = "http://localhost/tm_autoprocess.asp" '=== IQOR SERVER
    
    sURL1 = "http://localhost/iqor/tm_autoprocess.asp" '===BRO server
    
End Sub

Private Sub Timer1_Timer()
    Dim hDoc As Object
    Dim i As Integer
    Dim iForm As Integer
    Dim result As String
    
    Timer1.Enabled = False
    gCounter = gCounter + 1
    Label2.Caption = Label2.Caption - 1
    
    If gCounter = 1 Then
        AniFile.Open "D:\WEB\IQOR\Graphics\Filemove.avi"
        'AniFile.Open "C:\BROMY\IQOR\Graphics\Filemove.avi" '==IQOR SERVER
        AniFile.Play
        
        iForm = 0
        Wb1.Navigate sURL1
        
        Do
            DoEvents
        Loop Until Not Wb1.Busy
        
        Set hDoc = Wb1.Document
        
        AniFile.Close
    ElseIf gCounter = 15 Then '=== How many secs, 180 = 3 minutes
        End
    End If
    
    Timer1.Enabled = True
    
End Sub
