<%
	Function fFilterString(sParam)		
		sParam = trim(sParam)
		'sParam = replace(sParam,"'","")
		'sParam = replace(sParam,"-","")
		sParam = replace(sParam,"--","")
		sParam = replace(sParam,";","")
		sParam = replace(sParam,":","")
		sParam = replace(sParam,"?","")
		sParam = replace(sParam,"=","")
		sParam = replace(sParam,"+","")
		sParam = replace(sParam,"!","")
		sParam = replace(sParam,"*","")
		sParam = replace(sParam,",","")
		sParam = replace(sParam,"\","")
		sParam = replace(sParam,"""","")
		
		fFilterString=sParam 
	End Function
	
	Function fFilterString2(sParam)		
		sParam = trim(sParam)
		sParam = replace(sParam,"'","")
		sParam = replace(sParam,"-","")
		sParam = replace(sParam,"--","")
		sParam = replace(sParam,";","")
		sParam = replace(sParam,":","")
		sParam = replace(sParam,"?","")
		sParam = replace(sParam,"=","")
		sParam = replace(sParam,"+","")
		sParam = replace(sParam,"!","")
		sParam = replace(sParam,"*","")
		sParam = replace(sParam,",","")
		sParam = replace(sParam,"\","")
		sParam = replace(sParam,"""","")
		
		fFilterString2=sParam 
	End Function

	
	Function fFilterDate(sParam)
		sParam = trim(sParam)	
		sParam = replace(sParam,"'","")
		sParam = replace(sParam,"--","")
		sParam = replace(sParam,";","")
		sParam = replace(sParam,":","")
		sParam = replace(sParam,"?","")
		sParam = replace(sParam,"=","")
		sParam = replace(sParam,"+","")
		sParam = replace(sParam,"!","")
		sParam = replace(sParam,"*","")
		sParam = replace(sParam,",","")
		sParam = replace(sParam,"\","")
		sParam = replace(sParam,"""","")
		
		fFilterDate=sParam 
	End Function
	
	Function fFilterNum(sParam)
		sParam = trim(sParam)	
		sParam = replace(sParam,"'","")
		sParam = replace(sParam,"--","")
		sParam = replace(sParam,";","")
		sParam = replace(sParam,":","")
		sParam = replace(sParam,"?","")
		sParam = replace(sParam,"=","")
		sParam = replace(sParam,"+","")
		sParam = replace(sParam,"!","")
		sParam = replace(sParam,"*","")
		sParam = replace(sParam,",","")
		sParam = replace(sParam,"\","")
		sParam = replace(sParam,"""","")
		
		fFilterNum=sParam 
	End Function
	
	
	Function fFilterSQL(sParam)
		sParam = trim(sParam)	
		sParam = replace(sParam,"--","")
		
		fFilterSQL=sParam 
	End Function
%>
