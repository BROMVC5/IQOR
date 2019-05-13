Attribute VB_Name = "Minimize"
Public Type NOTIFYICONDATA2
    cbSize As Long
    hwnd As Long
    uId As Long
    uFlags As Long
    uCallBackMessage As Long
    hIcon As Long
    szTip As String * 64
End Type
Public Const NIM_ADD2 = &H0
Public Const NIM_MODIFY = &H1
Public Const NIM_DELETE2 = &H2
Public NIM_DELETE
Public Const WM_MOUSEMOVE2 = &H200
Public Const NIF_MESSAGE2 = &H1
Public Const NIF_ICON2 = &H2
Public Const NIF_TIP2 = &H4
Public Const WM_LBUTTONDBLCLK2 = &H203
Public Const WM_LBUTTONDOWN2 = &H201
Public Const WM_LBUTTONUP2 = &H202
Public Const WM_RBUTTONDBLCLK2 = &H206
Public Const WM_RBUTTONDOWN2 = &H204
Public Const WM_RBUTTONUP2 = &H205
Public Declare Function Shell_NotifyIcon Lib "shell32" Alias "Shell_NotifyIconA" (ByVal dwMessage As Long, pnid As NOTIFYICONDATA2) As Boolean

