Option Explicit

Public tag, loopMax

Dim debg : debg=False
Dim timerloops : timerloops=30  '  100 ~3:30
Dim mec
Dim prefix : prefix = ".\myShortcuts\myShortcuts "
Dim prefixdt : prefixdt = ".\myShortcuts\_DataTables\myShortcuts "

Function read_select(param)
     ' debg = True
     if debg then msgbox "13 .vb " & param
     ' debg = False
     ' Set up Drop-Down list
     Dim objFSO, objFile, objOption
     Set objFSO = CreateObject("Scripting.FileSystemObject")
     ' Make sure .dataTables.txt exists, else create it
     If objFSO.FileExists(trim(prefix) & "-dataTables.txt") = true Then
          if debg then Msgbox "20 .vb " & trim(prefix) & "-dataTables.txt Exists!"  '  uncomment for debugging
     Else
          Msgbox trim(prefix) & "-dataTables.txt Doesnt Exist!" & vbcrlf _
               & vbcrlf & "Will create one for you with default data."
          objFSO.CreateTextFile(trim(prefix) & "-dataTables.txt")
          Set objFile = objFSO.OpenTextFile(trim(prefix) & "-dataTables.txt", 2)  '  2 = WriteOver
          objFile.WriteLine "<new>"
          objFile.WriteLine "Shortcuts"
          objFile.Close
     End If

     ' Now read in the .dataTables.txt as options for drop-down list
     Set objFile = objFSO.OpenTextFile(trim(prefix) & "-dataTables.txt", 1)  '  1 = ReadOnly
     Dim tryit : tryit = ""
     Do Until objFile.AtEndOfStream
          mec = objFile.ReadLine
          if debg then msgbox "36 .vb " & mec : debg=false
          if mec = "<new>" then mec = "&lt;new&gt;"
          tryit = tryit & "<option value=""" & mec & """>" & mec & "</option>"
          if debg then msgbox "39 .vb " & tryit : debg=false
     Loop
     objFile.Close
     Set objOption = Nothing
     Set objFile = Nothing
     Set objFSO = Nothing
     if debg then msgbox tryit
     read_select = tryit
End Function

Function read_buttons()
	' Debg=true
     if debg then msgbox "51 .vb Read Buttons"
     ' Debg=true
     ' Set up Button
     Dim objFSO, objFile, objOption
     Set objFSO = CreateObject("Scripting.FileSystemObject")

     ' Make sure .buttons.txt exists, else create it
     If objFSO.FileExists(trim(prefix) & "-buttons.txt") = true Then
          if debg then Msgbox trim(prefix) & "-buttons.txt Exists!"  '  uncomment for debugging
     Else
          Msgbox trim(prefix) & "-buttons.txt does not Exist!" & vbcrlf _
               & vbcrlf & "Will create one for you with default data."
          objFSO.CreateTextFile(trim(prefix) & "-buttons.txt")
          Set objFile = objFSO.OpenTextFile(trim(prefix) & "-buttons.txt", 2)  '  2 = WriteOver
          objFile.WriteLine "New Button"
          objFile.Close
     End If
     ' Now read in the .buttons.txt as buttons
	      Set objFile = objFSO.OpenTextFile(trim(prefix) & "-buttons.txt", 1)  '  1 = ReadOnly
     Dim tryit : tryit = ""
     Do Until objFile.AtEndOfStream
          mec = objFile.ReadLine
		  if Instr(mec, "<auto>") then
			mec = mid(mec,7)
			' debg=true
			if debg then msgbox "76 .vb " & tryit & vbCrlf _
				& vbCRLF & "<auto> """ & mec & """" : Debg = false
			' call AutoPressPG-button.vbs mec
				Dim objSCR
				Set objSCR = CreateObject("WScript.Shell")
				objSCR.Run (".\myShortcuts\myShortcuts-button.vbs " _
					& """" & mec & " myShortcuts """)
				Set objSCR = Nothing
		  end if
          tryit = tryit & "<button class=smBut>" & mec & "</button>"
          if debg then msgbox tryit
     Loop
     objFile.Close
     Set objOption = Nothing
     Set objFile = Nothing
     Set objFSO = Nothing
     if debg then msgbox "92 .vb " & tryit : debg=false
     read_buttons = tryit
End Function

Function read_data(param)
     if debg then msgbox "97 .vb " & param & " is passed to read_data vbs"
     ' Set up Data Table
     Dim objFSO, objFile
     Set objFSO = CreateObject("Scripting.FileSystemObject")
     ' Make sure dataTable.html exists, else create it
     If objFSO.FileExists(prefixdt & param & ".html") = true Then
           if debg then Msgbox "103 .vb " & prefixdt & param & ".html Exists!" : debg=false
     Else
          Msgbox prefixdt & param & ".html Doesnt Exist!" & vbcrlf _
               & vbcrlf & "Will create one for you with default data."
          objFSO.CreateTextFile(prefixdt & param & ".html")
          Set objFile = objFSO.OpenTextFile(prefixdt & param & ".html", 2)  '  2 = WriteOver
          objFile.WriteLine "<table id=""" & param & """ class=dataTable border=""2""><tbody>"
          objFile.WriteLine "</tbody></table>"
          objFile.Close
     End If
     ' Now read in the dataTables.html
     Set objFile = objFSO.OpenTextFile(prefixdt & param & ".html", 1)  '  1 = ReadOnly
     Dim tryit : tryit = ""
     dim x : x = 1
     Do Until objFile.AtEndOfStream
          mec = objFile.ReadLine
          If InStr(mec, "<") <>1 then
               mec = mec & "<br>"
               if debg then msgbox "121 .vb Replaced: " & mec : debg=false
          End If
          If InStr(mec, "<TR valign=""top"">") then
               mec = replace(mec, "<TR valign=""top"">", "<tr id=r" & x & " valign=""top"">")
               x=x+1
               if debg then msgbox "126 .vb Replaced: " & mec : debg=false
          End If
          tryit = tryit & mec
     Loop
     if debg then msgbox tryit : debg=false
     if InStr(tryit, "</tbody></table>") <1 then
          tryit = tryit & "</tbody></table>"
          debg=true : if debg then msgbox "Replaced: " & tryit : debg=false
     End If


     divDatatable.innerHTML = tryit
     if debg then msgbox "Success!"

' Alternate AHK Method:
'
' FileRead, html, C:\Users\Matt\OneDrive\AHK\a.html
' oDoc := ComObjCreate("htmlfile")
' oDoc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
' oDoc.write(html)
' table := oDoc.getElementsByClassName("MsoNormalTable")[0]
' rows := table.rows
' Loop % rows.length  {
'    cells := rows[A_Index - 1].cells
'    Loop % cells.length
'       MsgBox, % cells[A_Index - 1].innerText
' }
' 
     set mec = document.getElementById(param)
     dim cellShort()
     dim celllong()

     if debg then msgbox "158 .vb " & CStr(mec.rows.length) : debg=false

     redim cellShort(mec.rows.length-1)
     redim celllong(mec.rows.length-1)
     dim i
     for i=0 to mec.rows.length-1
          if debg then msgbox mec.rows(i).cells(0).innerHTML : debg=false
          cellShort(i)=replace(mec.rows(i).cells(0).innerHTML, "<BR></", "</")
          if debg then msgbox cellShort(i) : debg=false
          if debg then msgbox mec.rows(i).cells(1).innerHTML : debg=false
          celllong(i)=replace(mec.rows(i).cells(1).innerHTML, "<BR></", "</")
          if debg then msgbox celllong(i) : debg=false
     Next
     read_data = "<table id=""" & param & """ class=dataTable border=""2""><tbody>"
     for i=0 to mec.rows.length-1
          read_data = read_data & vbcrlf & "<tr id=r" & Cstr(i+1) & " valign=""top""><td>"
          read_data = read_data & vbcrlf & cellShort(i)
          read_data = read_data & vbcrlf & "</td><td>"
          read_data = read_data & vbcrlf & celllong(i)
          read_data = read_data & vbcrlf & "</td></tr>"'
          if debg then msgbox read_data
     Next
     read_data = read_data & vbcrlf & "</tbody></table>"
     if debg then msgbox "181 .vb " & "read_data"
     objFile.Close
     Set i = Nothing
     Set mec = Nothing
     Set objFile = Nothing
     Set objFSO = Nothing
     ' Set cellshort() = Nothing
     ' Set celllong() = Nothing
End Function

Sub addButton  '  (shorts, texts)
     Dim texts, shorts  '  texts is detail, shorts is key
     shorts = additemShort.Value
     texts = Replace(additemFull.Value, vbcrlf, "<br>")
     if debg then Msgbox "195 .vb " & shorts & ": " & texts  '  uncomment to debug
     AddRow shorts, texts  '  adds a new line and populates data
     if debg then msgbox datatblSel.value : debg=false
     copytoHTM(datatblSel.value)  '  writes the new table to the file
     read_data(datatblSel.value)
     read_format()
     clrButton  '  clears the form
     set texts = Nothing
     set shorts = Nothing
End Sub

Sub AddRow(shorts, texts)
     Dim int  '  need to determine how many rows (for numbering next row)
     ' Get the Table elements (first one) and see how many rows
     int=document.getElementsByTagName("table")(0).getElementsByTagName("tr").length
     if debg then MsgBox "210 .vb " & int  '  uncomment to debug
     Dim objTable : Set objTable=window.document.getElementsByTagName("Table")
     Dim objRow : Set objRow=objTable(0).insertRow()  '  insert row at end
          objRow.id="r" & CStr(int+1)  '  Row id
     Dim objCell
     Set objCell = objRow.insertCell()  '  Insert first cell w/ shorts
          objCell.innerHTML = "<div>" & shorts & "</div>"
     Set objCell = objRow.insertCell()  '  Insert second cell w/ texts
          objCell.innerHTML = "<div>" & texts & "</div>"
     Set int = Nothing
     Set objCell = Nothing
     Set objRow = Nothing
     Set objTable = Nothing
End Sub

Sub copytoHTM(x)
     Dim objFSO, objFile
     Set objFSO = CreateObject("Scripting.FileSystemObject")
     if debg then msgbox "228 .vb copyhtm " & x : debg=false
     if x="save_button" then x = datatblSel.value  '  If "Save" button, query dataTables.value
     ' Check to see the file exists
     If objFSO.FileExists(prefixdt & x & ".html")=true Then
          if debg then Msgbox prefixdt & x & ".html" & " Exists!" : debg=false
     Else  '  Create file
          Msgbox prefixdt & x & ".html" & " Doesn't Exist!"
          objFSO.CreateTextFile(prefixdt & x & ".html")
     End If
     ' Now write dataTable to file
     Set objFile = objFSO.OpenTextFile(prefixdt & x & ".html", 2)  '  2 = WriteOver
     objFile.WriteLine "<table id=""" & x & """ class=dataTable border=""2""><tbody>"
     Dim tryTable : set tryTable=document.getElementsByTagName("tr")
     if debg then msgbox cstr(tryTable.length)
     For Each x In tryTable
          objFile.WriteLine "<TR valign=""top""><td><div>"
          objFile.WriteLine Replace(x.getElementsByTagName("div")(0).innerHTML, "<BR>", vbcrlf)
          objFile.WriteLine "</div></td><td><div>"
          objFile.WriteLine Replace(x.getElementsByTagName("div")(1).innerHTML, "<BR>", vbcrlf)
          objFile.WriteLine "</div></td></tr>"
     Next
     objFile.WriteLine "</tbody></table>"
     objFile.Close
     set x = Nothing
     set objFile = Nothing
     set objFSO = Nothing
End Sub

Sub addEdited(datatblSelvalue, whichRow, newOnes, newTwos)
     debg=false : if debg then msgbox "257 .vb " & datatblSelvalue & " " & whichRow _
          & vbcrlf & newOnes _
          & vbcrlf & newTwos & " end" : debg=false
     Dim objFSO, objFile, newFile
     Set objFSO = CreateObject("Scripting.FileSystemObject")
     ' Check to see the file exists
     If objFSO.FileExists(prefixdt & datatblSelvalue & ".html")=true Then
          debg=false : if debg then Msgbox prefixdt & datatblSelvalue & ".html" & " Exists!" : debg=false
     Else  '  Create file
          Msgbox prefixdt & datatblSelvalue & ".html" & " Doesn't Exist!"
          objFSO.CreateTextFile(prefixdt & datatblSelvalue & ".html")
     End If
     Set objFile = objFSO.OpenTextFile(prefixdt & datatblSelvalue & ".html", 1)  '  1 = ReadOnly
     objFSO.CreateTextFile(prefixdt & datatblSelvalue & ".xxxx")
     Set newFile = objFSO.OpenTextFile(prefixdt & datatblSelvalue & ".xxxx", 2)  '  2 = WriteOver
     Dim tryit : tryit = 0
     Do Until objFile.AtEndOfStream
          mec = objFile.ReadLine
          newFile.WriteLine mec
          ' msgbox mec & " tryit: " & tryit & " row r" & Mid(whichRow,2)
          if InStr(mec, "<TR valign=""top"">") > 0 then
               tryit=tryit+1
               ' msgbox "success! " & mec & " new tryit: " & tryit
               if cstr(tryit)=Mid(whichRow,2) then
                    ' msgbox whichRow & " = " & tryit
                    newFile.WriteLine newOnes
                    Do
                         mec = objFile.ReadLine
                    Loop Until InStr(mec, "</div></td>") > 0
                    newFile.WriteLine mec
                    newFile.WriteLine newTwos
                    Do
                         mec = objFile.ReadLine
                    Loop Until InStr(mec, "</div></td>") > 0

                    newFile.WriteLine mec
               End If
          End If
     Loop
     objFile.Close
     objFSO.DeleteFile(prefixdt & datatblSelvalue & ".html")
     newFile.Close
     Set newFile = objFSO.GetFile(prefixdt & datatblSelvalue & ".xxxx")
     newFile.Copy(prefixdt & datatblSelvalue & ".html")
     objFSO.DeleteFile(prefixdt & datatblSelvalue & ".xxxx")
     Set mec = Nothing
     Set tryit = Nothing
     Set objFile = Nothing
     Set objFSO = Nothing
     debg=false : if debg then Msgbox "Done!" : debg=false
End Sub

Sub clrButton
     additemShort.Value = ""
     additemFull.Value = ""
End Sub

Function nowTime() 
     Dim timeNow : timeNow = Now 
     Dim strtime : strtime = strNN(Hour(timeNow)) & ":" & strNN(Minute(timeNow)) _
          & ":" & strNN(Second(timeNow))
     nowTime = strtime 
End Function 
 
Function strNN(x) 
     strNN=Right("00" & CStr(x), 2) 
End Function 
 
Sub start_timer(timer)
     ' msgbox "Start Timer " & timer
     tag = 1  '  increment tag and begin
     document.title = "[*] - myShortcuts"

     Do While tag>0
          tagArea.InnerHTML = tag  '  write current tag to app
          document.title = tag & " - myShortcuts"

          mec = nowTime
          additemFull.Value = additemFull.Value & mec & vbcrlf

          if tag > 0 then timerRoutine(timer)  '  call timer function
          ' tag=0
     Loop

     tagArea.InnerHTML = tag
     msgArea.InnerHTML = "Ready"
     docTitle()
     
     ' msgbox mec
     Set mec = nothing
     ' infoBox("myShortcuts Done")  '  call infoBox
End Sub

Sub StopTimer(timer)
     tag = 0
     ' MsgBox "StopTimer Done " & timer
End Sub

Sub timerRoutine(timer)
     ' msgbox "Timer Routine"
     Dim i
     msgArea.InnerHTML = "StartRoutine Starting . . . 0"
     Delay 2
     For i = 1 To timerloops
          If tag=0 Then
               Set i = Nothing
               Exit Sub
          End If
          msgArea.InnerHTML = "Looping " & i
          loopMax = i
          If tag>0 Then Delay 2
     Next
     If tag=0 Then
          Set i = Nothing
          Exit Sub
     End If

     if tag>0 then doThis(timer)

     Set i = Nothing
     If tag>0 Then tag=tag+1
     msgArea.InnerHTML = "StartRoutine Done"
     ' Msgbox "Timer Routine Done"
End Sub

Sub Delay(seconds)  '  called by timerRoutine
     Dim D : Set D = CreateObject("WScript.Shell")
     ' ping -n 3 127.0.0.1
     D.Run "ping -n " & (seconds + 1) & " 127.0.0.1", 0, True
     Set D = Nothing
End Sub

Sub doThis(timer)
     ' msgbox "Ending?"
     If tag=0 Then Exit Sub
     Dim S : Set S = CreateObject("WScript.Shell")
     ' msgbox """" & trim(prefix) & "-timer.vbs"" " & timer
     S.Run """" & trim(prefix) & "-timer.vbs"" " & timer, 0, True
     Set S = Nothing
End Sub

Sub cbut(x)  '  the COPY button
     ' MsgBox "c " & x ' : Exit Sub  '  uncomment to debug
     Dim ObjRow : Set ObjRow = document.getElementById(x)
     Dim objCell : Set objCell = objRow.cells
     Dim cell1 : cell1=objCell(0).innerHTML
     Dim cell2 : cell2=objCell(1).innerHTML
     ' MsgBox "c " & x & " " & cell1 & vbCRLF & Cell2
     set cell2=objCell(1).getElementsByTagName("div")
     document.parentwindow.clipboardData.SetData "text", Replace(cell2(0).innerHTML, "<BR>", vbCRLF)
     Set objRow = Nothing
     Set objCell = Nothing
     Set cell1 = Nothing
     Set cell2 = Nothing
End Sub

Sub ebut(x)  '  the EDIT button
     mec = x
     ' MsgBox "ebut mec: " & mec
     Dim ObjRow : Set ObjRow = document.getElementById(x)
     ' msgbox ObjRow.innerHTML

     Dim objCell : Set objCell = ObjRow.cells
     ' msgbox objCell.length
     Dim cell1
     set cell1=objCell(0).getElementsByTagName("div")
     Dim cont0 : cont0=cell1(0).innerHTML
     cont0=Replace(cont0, "<BR>", vbCRLF)
     Cell1(0).innerHTML="<div><textarea id=tempShort name=tempShort style=width:100%></textarea></div>"
     tempShort.Value = cont0
     set cell1=objCell(1).getElementsByTagName("div")
     Dim cont1 : cont1=cell1(0).innerHTML
     cont1=Replace(cont1, "<BR>", vbCRLF)
     Cell1(0).innerHTML="<div><textarea id=tempArea name=tempArea style=width:100%></textarea></div>"
     tempArea.Value = cont1
     set cell1=objCell(2).getElementsByTagName("button")
     cell1(1).Value = "s"
     Set objRow = Nothing
     Set objCell = Nothing
     Set cell1 = Nothing
     Set cont0 = Nothing
     Set cont1 = Nothing
End Sub

Sub sbutnada
     Dim newLong : newLong=tempArea.value
     Dim newShort : newShort=tempShort.value
     ' MsgBox "sbut mec: " & mec & vbcrlf & newLong
     newLong=Replace(newLong, vbCRLF, " <BR>")
     Dim ObjRow : Set ObjRow = document.getElementById(mec)
     Dim objCell : Set objCell = objRow.cells
     objCell(0).innerHTML="<div style=""HEIGHT: 102px"">" & newShort & "</div>"
     objCell(1).innerHTML="<div style=""HEIGHT: 102px"">" & newLong & "</div>"
     ' copytoHTM(datatblSel.value)  '  writes the new table to the file
     Set newLong = Nothing
     Set newShort = Nothing
     ' Location.Reload(True)
End Sub

Sub dbut(x)  '  the DELETE button
     ' MsgBox "d " & x
     Dim rInt : rInt=Mid(x,2)-1
     ' MsgBox "d " & x & " rInt " & CStr(rInt)
     if MsgBox("Are you quite sure you want to delete this?",vbYesNo,"myShortcuts - Delete")=vbNo then Exit Sub
     document.getElementsByTagName("Table")(0).deleteRow(rInt)
     Set rInt = Nothing
     copytoHTM(datatblSel.value)
End Sub

Sub outlookButton(x)
     ' msgbox "Outlook"
     Dim olApp : Set olApp = CreateObject("Outlook.Application")
     ' MsgBox olApp.version
     ' Get the clipboard (containing mtg info)
     Dim cont : cont = document.parentwindow.clipboardData.GetData("text")
     ' Make sure we have an appt to copy
     if IsNull(instr(cont,"Subject: ")) then msgbox "You need to copy a mtg first" : exit sub
     if instr(cont,"Subject: ") < 1 then msgbox "You need to copy a mtg first" : exit sub
     ' Create the new Mtg Item
     Dim olCal : Set olCal = olApp.CreateItem(1)  '  1 is olAppointmentItem
     olCal.MeetingStatus = 1  '  1 is olMeeting
     olCal.Recipients.Add("philipgilman@gmail.com")
     ' Parse out the Subject
     olCal.Subject = "bn " & mid(cont, instr(cont,"Subject: ")+9, _
          instr(cont,"When: ")-instr(cont,"Subject: ")-11)
     ' Parse out the Location
     olCal.Location = mid(cont, instr(cont,"Where: ")+7)
     ' Figure out the Start Time
     Dim conts
     conts = mid(cont, instr(cont,"When: ")+6, _
          instr(mid(cont, instr(cont,"When: ")+6),"-")-1)
     ' msgbox "1 " & conts
     conts = mid(conts, instr(conts, "day,")+5)
     ' msgbox "2 " & conts
     olCal.Start = cdate(conts)
     ' Figure out the End Time
     conts = mid(cont, instr(cont,"When: ")+6, _
          instr(mid(cont, instr(cont,"When: ")+6),"UTC")-2)
     ' msgbox "3 " & conts
     conts = mid(conts, instr(conts, "day,")+5)
     ' msgbox "4 " & conts
     conts = left(conts, instr(conts, ", ")+6) & mid(conts, instr(conts, "-")+1)
     ' msgbox "5 " & conts
     olCal.End = cdate(conts)
     olCal.Display  '  Display the meeting . . .
     ' Now, to get formatted text, shell out and sendkeys to paste
     Dim S : Set S = CreateObject("WScript.Shell")
     Delay 2  '  wait to make sure there is a shell
     S.AppActivate olCal.Subject
     Delay 2  '  wait to make sure the new mtg is selected
     ' Tab 8 times and paste (ctrl-v), then back to top (ctrl-home)
     S.SendKeys "{tab 8}^v^{Home}"
     Set S = Nothing
     ' MsgBox x.id & vbcrlf & x.parentnode.id & vbcrlf & x.parentnode.parentnode.id _
     '      & vbcrlf & "Clip: " & document.parentwindow.clipboardData.GetData("text")
     Delay 1  '  wait to make sure we're all good

     InfoBox2 "Ready to Send", "1000"

     Set cont = Nothing
     Set conts = Nothing
     Set olApp = Nothing
End Sub

Function InfoBox2(dispText, dispTime)
     Dim S : Set S = CreateObject("WScript.Shell")
     S.Run """" & trim(prefix) & "-infobox.hta"" """ & dispText _
          & """ """ & dispTime & """", 0, True
     Set S = Nothing
End Function

Function InfoBox3(dispText, dispTime, dispSize)
     Dim S : Set S = CreateObject("WScript.Shell")
     S.Run """" & trim(prefix) & "-infobox.hta"" """ & dispText _
          & """ """ & dispTime & """ """ & dispSize & """", 0, True
     Set S = Nothing
End Function

' TO DO
Sub rtfEdit
     Dim strComputer, objWMIService, colItems, objItem, intHorizontal, intVertical, intLeft, intTop
     Dim wWid, wHei

     ' msgbox "Here . . ."

     wWid=900
     wHei=700
     Window.resizeTo wWid,wHei

     ' Center the box on screen
     strComputer = "."
     Set objWMIService = GetObject("Winmgmts:\\" & strComputer & "\root\cimv2")
     Set colItems = objWMIService.ExecQuery("Select * From Win32_DesktopMonitor")
     For Each objItem in colItems
         intHorizontal = objItem.ScreenWidth
         intVertical = objItem.ScreenHeight
     Next
     intLeft = (intHorizontal - wWid) / 2
     intTop = (intVertical - wHei) / 2
     window.moveTo intLeft, intTop

     Dim tryit, pgSkip
     pgSkip = "cle"

If pgSkip="n" then
     tryit = "<hr><div id=rtfEditarea>"

     tryit=tryit & "<textarea id=area1 "
     tryit=tryit & "cols=""82"" rows=""19"" "
     tryit=tryit & "style=""overflow:auto; background-color:lightyellow"">"
     tryit=tryit & "</textarea></div>"

ElseIf pgSkip="x" then
     tryit = "<hr><div id=rtfEditarea>"

     tryit=tryit & "<div id=nicButtonpanel style=""width:98%;padding:3px;"
     tryit=tryit & "border:4px solid Green;background-color:Green"">"
     tryit=tryit & "</div>"

     tryit=tryit & "<div id=area1cont style=""height:22em;"
     tryit=tryit & "overflow:auto;width:100%""><div id=area1 "
     tryit=tryit & "style=""font-size:16px; height:92%; overflow:auto; "
     tryit=tryit & "padding:3px;border:4px solid Green;width: 98%;"">"
     tryit=tryit & "</div></div>"

ElseIf pgSkip="y" then
     tryit = "<hr><div id=rtfEditarea>"

     tryit=tryit & "<div id=buttonPanel style=""width:98%;padding:3px;"
     tryit=tryit & "border:4px solid Green;background-color:Green;height:3em"">"
     tryit=tryit & "</div>"

     tryit=tryit & "<div id=area1cont style=""height:19em;"
     tryit=tryit & "overflow:auto;width:100%""><div id=area1 "
     tryit=tryit & "style=""font-size:16px; height:92%; overflow:auto; "
     tryit=tryit & "padding:3px;border:4px solid Green;width: 98%;"">"
     tryit=tryit & "</div></div>"

ElseIf pgSkip="cle" then
     tryit = "<hr><div id=rtfEditarea "
     tryit=tryit & "style=""width:100%; "
     tryit=tryit & "overflow:auto"">"

     tryit=tryit & "<textarea id=area1 "
     tryit=tryit & "cols=""82"" rows=""24"">"
     tryit=tryit & "</textarea></div>"

Else

End If

     tryit=tryit & "<div id=pgbottom><center><hr />"
     tryit=tryit & "<button id=okbut style=""width:20%"" "
     tryit=tryit & "onClick=""rtfBut()"""
     tryit=tryit & ">O K</button>"
     tryit=tryit & "<span style=""width:20%"">&nbsp;</span>"
     tryit=tryit & "<button id=cncbut style=""width:20%"" "
     tryit=tryit & "onClick=""cancelBut()"""
     tryit=tryit & ">Cancel</button>"

     divDatatable.innerHTML=tryit

     area1.style.backgroundColor="LightYellow"

     ' rtfEditFormat
     ' msgbox "Done"
End Sub

Sub rtfEditFormat
     set mec = document.getElementsByTagName("*")
     ' msgbox mec.length

     dim i
     for i=0 to mec.length-1
          ' msgbox "Class: " & mec(i).className & " html: " & mec(i).innerHTML

          if mec(i).className <> "" then
               ' msgbox "found one! Class = " & mec(i).className
          end if

          if mec(i).id = "rtfEditarea" then
               ' msgbox "found one " & mec(i).id
               mec(i).style.backgroundColor="LightGreen"
          end if

          if instr(mec(i).className, "panel") then
               ' msgbox "found one " & mec(i).className
               mec(i).style.backgroundColor="LightGreen"
          end if

          if instr(mec(i).className, "panelContain") then
               ' msgbox "found one " & mec(i).className
               mec(i).style.backgroundColor="LightGreen"
          end if

          if instr(mec(i).className, "button") then
               ' msgbox "found one " & mec(i).className
               mec(i).style.backgroundColor="HoneyDew"
          end if

          if instr(mec(i).className, "main") then
               ' msgbox "found one " & mec(i).className
               mec(i).style.backgroundColor="LightCyan"
          end if

     Next

End Sub

Function OpenNotepad1()
     Dim S : Set S = CreateObject("WScript.Shell")
     S.run("notepad.exe")
	if Len(additemFull.Value) > 0 then
		Delay 1
		S.SendKeys(additemFull.Value)
	End if
     Set S = Nothing
End Function
