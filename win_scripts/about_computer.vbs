Dim result
result = result & "Computer name: " & GetComputerName & vbCrLf & vbCrLf
result = result & "IP Address(es): " & GetIPAddresses & vbCrLf & vbCrLf
result = result & "Serial Number: " & GetDellSerial & vbCrLf & vbCrLf
result = result & "Boot Up Time: " & GetBootTime & vbCrLf
result = result & "Hours Since Last Boot: " & HoursSince(GetBootTime) & vbCrLf & vbCrLf
result = result & "Logged On User: " & GetLoggedOnUser
Msgbox result, 0, "About " & GetComputerName

Function GetComputerName()
	Dim objNet
	Set objNet = CreateObject("Wscript.Network")
	GetComputerName = objNet.Computername
End Function

Function GetLoggedOnUser()
	Dim objNet
	Set objNet = CreateObject("Wscript.Network")
	GetLoggedOnUser = objNet.UserName
End Function

Function GetBootTime() 
	Dim objWMI, objWMIDateTime, colOS, objOS
	Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
	Set objWMIDateTime = CreateObject("WbemScripting.SWbemDateTime")
	Set colOS = objWMI.InstancesOf("Win32_OperatingSystem")
	For Each objOS in colOS
		objWMIDateTime.Value = objOS.LastBootUpTime
	Next
	GetBootTime = objWMIDateTime.GetVarDate
End Function

Function HoursSince(inputDate)
	Dim result
	result = DateDiff("h", inputDate, Now)
	HoursSince = result
End Function

Function GetIPAddresses()
	Dim objWMI, colItems, objItem, strIP, result
	Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
	Set colItems = objWMI.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled=True","WQL")
	For each objItem in colItems
	  For Each strIP in objItem.IPAddress
		If len(strIP) < 16 Then
			result=result & vbCrLf & strIP
		End If
	  Next
	Next
	GetIPAddresses = result
End Function

Function GetDellSerial()
	Dim objWMI, colItems, objItem, result
	Set objWMI = GetObject("winmgmts:\\.\root\cimv2")
	Set colItems = objWMI.ExecQuery("SELECT * FROM Win32_ComputerSystemProduct", "WQL")
	For Each objItem In colItems
		result = objItem.IdentifyingNumber
	Next
	GetDellSerial = result
End Function