OPTION Explicit

Public param
param = "(No%20parameter%20passed)"
if WScript.Arguments.Count > 0 then param = WScript.Arguments(0)
param = Replace(param, "%20", " ")

Dim debg
'debg=True
if debg Then Msgbox "10 button.vb Debugging . . ."

Dim objFSO
Set objFSO = CreateObject("Scripting.FileSystemObject")
Dim objSCR
Set objSCR = CreateObject("WScript.Shell")
If objFSO.FileExists(".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".ahk") = true Then
    if debg Then Msgbox "19 button.vbs .\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".ahk Exists!"
	objSCR.Run (""".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) & ".ahk""")
ElseIf objFSO.FileExists(".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".lnk") = true Then
    if debg Then Msgbox "27 button.vbs .\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".lnk Exists!"
	objSCR.Run (""".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) & ".lnk""")
ElseIf objFSO.FileExists(".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".vbs") = true Then
    if debg Then Msgbox "35 button.vbs .\myShortcuts\myShortcuts-" _
    	& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
    		& ".vbs Exists!"
	objSCR.Run (""".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) & ".vbs")
ElseIf objFSO.FileExists(".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".js") = true Then
    if debg Then Msgbox "43 button.vbs .\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".js Exists!"
	objSCR.Run (""".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) & ".js""")
ElseIf objFSO.FileExists(".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".exe") = true Then
    if debg Then Msgbox "51 button.vbs .\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".exe Exists!"
	objSCR.Run (""".\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) & ".exe""")
Else
	Msgbox "57 button.vbs .\myShortcuts\myShortcuts-" _
		& Left(param,instr(param & " myShortcuts "," myShortcuts ")-1) _
			& ".ahk .lnk .vbs .js .exe Don't Exist!" & vbcrlf & vbcrlf _
				& "This external vbs process with" & vbcrlf & vbcrlf _
					& """" & param & """" & vbcrlf & vbcrlf _
						& "as the passed parameter(s)"
End If
Set objFSO = Nothing
Set objSCR = Nothing
