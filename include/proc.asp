<%
	'--function to validate correct characters entered by the user
	Function fValidate(sParam, sSet)
		Dim sValid
		Dim sValidString
		
		sValid="Y"   '--set condition to valid
				
		If Len(sParam) > 0 Then			
			
			For i = 1 To Len(sParam)
				iOneChar = CInt(Asc(Mid(sParam, i, 1)))
				sValid="N"
				
				If sSet = "1" Then
					'--check For standard characters
					sValidString="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -_."
					For j = 1 To Len(sValidString)
						If CInt(Asc(Mid(sParam, i, 1))) = CInt(Asc(Mid(sValidString, j, 1))) Then
							sValid="Y"
							Exit For
						End If
					Next
				End If
				
				If sSet = "2" Then
					'--check For standard characters and Apostraphe
					sValidString="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -_'"
					For j = 1 To Len(sValidString)
						If CInt(Asc(Mid(sParam, i, 1))) = CInt(Asc(Mid(sValidString, j, 1))) Then
							sValid="Y"
							Exit For
						End If
					Next
				End If
				
				If sSet = "3" Then
					'--check For standard characters and @ and .
					sValidString="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 -_@.%"
					For j = 1 To Len(sValidString)
						If CInt(Asc(Mid(sParam, i, 1))) = CInt(Asc(Mid(sValidString, j, 1))) Then
							sValid="Y"
							Exit For
						End If
					Next
				End If
				
				If sSet = "4" Then
					'--check For numeric only
					sValidString="1234567890"
					For j = 1 To Len(sValidString)
						If CInt(Asc(Mid(sParam, i, 1))) = CInt(Asc(Mid(sValidString, j, 1))) Then
							sValid="Y"
							Exit For
						End If
					Next
				End If
				
				'--if condition invalid Exit For loop and return fValidate() false condition
				If sValid = "N" Then 
					Exit For
				End If
			Next
		Else
			sValid="Y"
		End If
		
		fValidate=sValid
	End Function
	
	Function fDateTime()	
		fDateTime = Year(Date) & _
				"-" & String(2 - Len(Month(Date)),"0") & Month(Date) & _
				"-" & String(2 - Len(Day(Date)), "0") & Day(Date) & " "
		fDateTime = fDateTime & String(2 - Len(Hour(Time)),"0") & Hour(Time) & _
				":" & String(2 - Len(Minute(Time)),"0") & Minute(Time) & _
				":" & String(2 - Len(Second(Time)),"0") & Second(Time)
	End Function
	
	Function fDateTime2(dTemp)	
		fDateTime2 = Year(dTemp) & _
				"-" & String(2 - Len(Month(dTemp)),"0") & Month(dTemp) & _
				"-" & String(2 - Len(Day(dTemp)), "0") & Day(dTemp) & " "
		fDateTime2 = fDateTime2 & String(2 - Len(Hour(dTemp)),"0") & Hour(dTemp) & _
				":" & String(2 - Len(Minute(dTemp)),"0") & Minute(dTemp) & _
				":" & String(2 - Len(Second(dTemp)),"0") & Second(dTemp)
	End Function
	
	Function fDateTimeDMY(dTemp)	
		fDateTimeDMY = String(2 - Len(Day(dTemp)), "0") & Day(dTemp) & _
				"/" & String(2 - Len(Month(dTemp)),"0") & Month(dTemp) & _
				"/" & Year(dTemp) & " "
		fDateTimeDMY = fDateTimeDMY & String(2 - Len(Hour(dTemp)),"0") & Hour(dTemp) & _
				":" & String(2 - Len(Minute(dTemp)),"0") & Minute(dTemp) & _
				":" & String(2 - Len(Second(dTemp)),"0") & Second(dTemp)
	End Function
	
	
	Function fTime(dTemp)	
		fTime = String(2 - Len(Hour(dTemp)),"0") & Hour(dTemp) & _
				":" & String(2 - Len(Minute(dTemp)),"0") & Minute(dTemp) & _
				":" & String(2 - Len(Second(dTemp)),"0") & Second(dTemp)
	End Function
	
	Function fDate(dTemp)
		If dTemp <> "" then
			FDate = String(2 - Len(Day(dTemp)), "0") & Day(dTemp) & _
			"-" & String(2 - Len(Month(dTemp)),"0") & Month(dTemp) & _
			"-" & Year(dTemp)
		End If  
	End Function
	
	Function fDate2(dTemp)
  
		If dTemp <> "" then
			If IsDate(dTemp) then
				FDate2 = Year(dTemp) & "-" & _
				String(2 - Len(Month(dTemp)),"0") & Month(dTemp) & "-" & _
				String(2 - Len(Day(dTemp)), "0") & Day(dTemp) 
			End if
		End If  
	End Function

    Function fDateOnly(dTemp)
		If dTemp <> "" then
			fDateOnly = String(2 - Len(Day(dTemp)), "0") & Day(dTemp) & _
			String(2 - Len(Month(dTemp)),"0") & Month(dTemp) & _
			Year(dTemp)
		End If  
	End Function
	
	Function fDateShort(dTemp)
		If dTemp <> "" then
			FDateShort = String(2 - Len(Day(dTemp)), "0") & Day(dTemp) & _
			"/" & String(2 - Len(Month(dTemp)),"0") & Month(dTemp) & _
			"/" & Right(Year(dTemp), 2)
		End If  
	End Function
	
	Function fDateLong(dTemp)
		If dTemp <> "" then
			fDateLong = String(2 - Len(Day(dTemp)), "0") & Day(dTemp) & _
			"/" & String(2 - Len(Month(dTemp)),"0") & Month(dTemp) & _
			"/" & Year(dTemp)
		End If  
	End Function
	
	Function pFormatDec(sParam, iDec)
		If IsEmpty(iDec) Then
    	    iDec = 0
    	End If
        If sParam = "" Or Not IsNumeric(sParam) Then
    	    sParam = "0"
    	End If
		If Not IsNumeric(sParam) Then
			pFormatDec = FormatNumber(0, iDec)
		else
			pFormatDec = FormatNumber(sParam, iDec)
		End If
	End Function
	
	Function pFormat(sParam, iDec)
		If IsEmpty(iDec) Then
    	    iDec = 0
    	End If
        If sParam = "" Or Not IsNumeric(sParam) Then
    	    sParam = "0"
    	End If
		If Not IsNumeric(sParam) Then
			sParam = FormatNumber(0, iDec)
		else
			sParam = FormatNumber(sParam, iDec)
		End If
		pFormat = Replace(sParam, ",", "")
	End Function
	
	Function pFormatDash(sParam, iDec)
		If IsEmpty(iDec) Then
    	    iDec = 0
    	End If
        If sParam = "" Or Not IsNumeric(sParam) Then
    	    sParam = "0"
    	End If
		If Not IsNumeric(sParam) Then
			pFormatDash = "-"
		ElseIf sParam = 0 Then
			pFormatDash = "-"
		ElseIf sParam < 0 Then
			pFormatDash = "(" & FormatNumber(Abs(sParam), iDec) & ")"
		Else
			pFormatDash = FormatNumber(sParam, iDec)
		End If
	End Function
	
	Function pFormatEmpty(sParam, iDec)
		If IsEmpty(iDec) Then
    	    iDec = 0
    	End If
        If sParam = "" Or Not IsNumeric(sParam) Then
    	    sParam = "0"
    	End If
		If Not IsNumeric(sParam) Then
			pFormatEmpty = ""
		elseif sParam = 0 Then
			pFormatEmpty = ""
		else
			pFormatEmpty = FormatNumber(sParam, iDec)
		End If
	End Function
	
	Function pRound(Number ,NumDigits) 
		Dim dblPower, vPSTEmp, intSgn
	    
	    dblPower = 10 ^ NumDigits
	    vPSTEmp = CDbl(Number * dblPower + 0.5)
	    pRound = Int(vPSTEmp) / dblPower
	End Function

    Function pAddZero(sParam)
        if Cint(sParam) < 10 then
            pAddZero = "0" & sParam
        else
            pAddZero = sParam
        end if	    
	End Function
	
	Function pRTIN(aRSField)
	   If IsNull(aRSField) Then
	       pRTIN = ""
	   Else
	       pRTIN = Trim(Replace(Replace(Replace(aRSField, "'", "''"), "\", "\\"),chr(34)," "))
	   End If
	End Function

	Function pPassConv(sPass)
		Dim iLoop
		Dim iL
	    Dim iTotal
	    
	    iL = 3
	    iTotal = 0
	    For iLoop = 1 To Len(sPass)

	        iTotal = iTotal + Asc(Mid(sPass, iLoop, 1)) * (iL + iLoop - 1)
	    Next
		    	    
	    pPassConv = iTotal
	End Function
	
	Function pLastNumber(lastNum, startNum, runNum) 

    	Dim iLoop 

    	pLastNumber = ""
    	If runNum > 0 And startNum > 0 And Len(lastNum) <= 13 And Len(lastNum) - startNum - runNum > -2 Then
        	For iLoop = 0 To runNum - 1
            	If IsNumeric(Mid(lastNum, startNum + iLoop, runNum - iLoop)) Then
            		iRun = CDbl(Mid(lastNum, startNum + iLoop, runNum - iLoop)) + 1
            		iRun = right("00000000" & iRun, runNum)
                	pLastNumber = Left(lastNum, startNum - 1) & iRun & _
                                  Right(lastNum, Len(lastNum) + 1 - startNum - runNum)
                	Exit Function
            	End If
        	Next
      	End If
   	End Function
   	
   	Function pCloseTables(iLoop)
    	iLoop.Close
    	Set iLoop = Nothing
	End Function
	
	Sub Msg(ByVal str)
 		response.write str
	End Sub
	
	Function pShowText(ByVal pStrC, ByVal pStrE)
		if session("CSLANG") = "C" then
	 		response.write pStrC
	 	else
	 		response.write pStrE
	 	end if
	End Function
	
	Function pGetText(ByVal pStrC, ByVal pStrE)
		if session("CSLANG") = "C" then
	 		pGetText = pStrC
	 	else
	 		pGetText = pStrE
	 	end if
	End Function
	
    Function req(ByVal pParam)
		req = trim(request(pParam))
	End Function

    Function reqU(ByVal pParam)
		reqU = UCase(trim(request(pParam)))
	End Function

	Function reqForm(ByVal pParam)
		reqForm = trim(request.form(pParam))
	End Function
	
	Function reqFormU(ByVal pParam)
		reqFormU = ucase(trim(request.form(pParam)))
	End Function
	
	Function reqString(ByVal pParam)
        reqString = trim(request.querystring(pParam))
    End Function
	
	
	Sub alertBox(ByVal pParam)
 		response.write "<script language='javascript'>"
		response.write "window.alert ('" & pParam & "');"
		response.write "window.history.back();"
		response.write "</script>"
		response.end
	End Sub
	
	Sub confirmBox(pParam, pURL)
 		response.write "<script language='javascript'>"
		response.write "window.alert ('" & pParam & "');"
		response.write "window.location=('" & pURL & "');"
        response.write "</script>"
        response.end
	End Sub 
	
	Sub confirmBox1(pParam, pURL)
 		response.write "<script language='javascript'>"
		response.write "window.alert ('" & pParam & "');"
		response.write "window.location=('" & pURL & "');"
		response.write "self.close(); "
		response.write  "window.opener.location.reload();"
		response.write "</script>"
        response.End
	End Sub
	
	Sub showBox(ByVal pParam)
   	response.write "<script language='javascript'>"
  	response.write "window.alert ('" & pParam & "');"
  	response.write "</script>"
 	End Sub
 	
 	Sub URLBox(pURL)
 		response.write "<script language='javascript'>"
		response.write "window.location=('" & pURL & "');"
		response.write "</script>"
	End Sub 

	
	Function GetFirstDate(pParam)
		GetFirstDate = "01/" & mid(fDateLong(pParam),4)
	end Function
	
	
	Function GetLastDay(pParam)
	    dim intMonth
	    dim dteFirstDayNextMonth
	
	    dtefirstdaynextmonth = dateserial(year(pParam),month(pParam) + 1, 1)
	    GetLastDay = Day(DateAdd ("d", -1, dteFirstDayNextMonth))
	end function

    Function hex2rgb(sParam)
        if len(sParam) = 0 then
            hex2rgb = "#000000"
        else
            Color = Replace(sParam, "#", "")
            R = CInt("&H" & Mid(Color,1,2))
            G = CInt("&H" & Mid(Color,3,2))
            B = CInt("&H" & Mid(Color,5,2))
        
            whtorblk = ((R * 299) +  (G * 587) + (B * 114)) / 1000 
        
            if Cint(whtorblk) > 125 then
                hex2rgb = "#000000"
            else
                hex2rgb = "#FFFFFF"
            end if
        end if

    end function

    Function MinToTime(sParam)
        if len(sParam) = 0 then
            MinToTime = "" 
        else
            sHour = Fix(Cint(sParam) / 60)
            if sHour < 10 then
                sHour = "0" & sHour
            end if
            
            sMin = Cint(sParam) mod 60

            if sMin < 10 then
                sMin = "0" & sMin
            end if
                
            MinToTime = sHour & ":" & sMin
        end if  
    end function

    Function TimeToMin(sParam)
        if len(sParam) = 0 then
            TimeToMin = 0 
        else
            TimeToMin = Cint((mid(sParam,1,2))*60) + Cint((mid(sParam,4,2)))
        end if  
    end function
    
    Function TimeToDec(sParam)
        if len(sParam) = 0 or sParam = "0" then
            TimeToDec = "0.00" 
        elseif isnull(sParam) then
            TimeToDec = ""
        else
            sHour = Cint((mid(sParam,1,2))) 
            sDec = Cint((mid(sParam,4,2)))
            if sDec = 30 then
                sDec = "50"
            else
                sDec = "00"
            end if 
            
            TimetoDec = sHour & "." & sDec
        end if  
    end function

    Function TimeToDec2(sParam)
        if len(sParam) = 0 or sParam = "0" then
            TimeToDec2 = "0.00" 
        elseif isnull(sParam) then
            TimeToDec2 = ""
        else
            sSplit = Split(sParam,":") 
            sHour = Cint(sSplit(0))
            sMin = Cint(Cint(sSplit(1))/60 *100)

            if sMin < 10 then
                sMin = "0" & sMin 
            end if
            
            TimetoDec2 = sHour & "." & sMin
        end if  
    end function

    Function RoundOT(sParam)
        if len(sParam) = 0 or sParam = "0" then
            RoundOT = "0.00" 
        elseif isnull(sParam) then
            RoundOT = ""
        else
            sSplit = Split(sParam,":") 
  
            sHour = Cint(sSplit(0))
            sMin = sSplit(1)

            if Cint(sMin) > 30 then
                RoundOT = sHour & ".5"
            else
                RoundOT = sHour & ".0"
            end if
        end if  
    end function

    Function Lpad(strInput, length, character)
	    Dim strOutput
        If Len(strInput) >= length Then
		    strOutput = strInput
	    Else
		    Do While Len(strOutput) <= length - Len(strInput) - 1
    			strOutput = character & strOutput 
		    Loop
		    strOutput = strOutput & strInput
	    End if
	    Lpad = strOutput
    End Function

    Function GetLastMonth(iCurrentMonth,iCurrentYear)
    GetLastMonth=month(dateserial(iCurrentYear,iCurrentMonth,1)-1)
    End Function
 
    Function GetLastMonthYear(iCurrentMonth,iCurrentYear)
     GetLastMonthYear=Year(dateserial(iCurrentYear,iCurrentMonth,1)-1)
    End Function
 
    Function GetNextMonth(iCurrentMonth,iCurrentYear)
     GetNextMonth=month(dateserial(iCurrentYear,iCurrentMonth+1,1))
    End Function
 
    Function GetNextMonthYear(iCurrentMonth,iCurrentYear)
     GetNextMonthYear=year(dateserial(iCurrentYear,iCurrentMonth+1,1))
    End Function

    'Example Usage:
'response.write GetLastMonth(1, 2018) & "/" & GetLastMonthYear(1, 2018)  & " " & GetNextMonth(Month(Now), Year(Now)) & "/" & GetNextMonthYear(Month(Now), Year(Now))

    %>
 
