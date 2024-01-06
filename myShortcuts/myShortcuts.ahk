; myShortcuts.ahk original content
; [^ = Ctrl] [+ = Shift] [! = Alt] [# = Win] 

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; if not A_IsAdmin
;   {
;   Run *RunAs "%A_ScriptFullPath%"  ; Run as admin
;   ExitApp
;   }

global Me, debg, 1, 2, 3
Me := "myShortcuts"

If A_IsCompiled <> 1  ;  add icon if not compiled
   Menu, Tray, Icon, myShortcuts\bg.ico
Menu, Tray, Tip, %Me% (C) %A_Year% BG
Menu, Tray, Add, %Me%
Menu, Tray, Add, Config
Menu, Tray, NoStandard
Menu, Tray, Standard

#Persistent
#SingleInstance


; [^ = Ctrl] [+ = Shift] [! = Alt] [# = Win] 

myShortcuts:
   ;MsgBox, , %Me% , %Me% will start now , 2
   Run, myShortcuts.hta  ; my Shortcuts Manager
Return

Config:
   ;MsgBox, , %Me% , %Me% Config , 2
   ListHotkeys  ;  for debugging
   Edit
Return

; <EOF>
