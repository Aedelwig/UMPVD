;@Ahk2Exe-SetMainIcon UMPVD.ico
;@Ahk2Exe-SetDescription Unified MPV Dashboard
;@Ahk2Exe-SetProductName UMPVD
;@Ahk2Exe-SetVersion 1.0

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptFullPath%
SetBatchLines, 50ms
ListLines Off

OnClipboardChange("ClipRun")
Global File := ""
FileGetSize, Size, %A_ScriptDir%\UMPVD.conf
If (Errorlevel = 1) {
FileAppend, [extension.xwm]`nprofile=audio`n`n[extension.ac3]`nprofile=audio`n`n[extension.a52]`nprofile=audio`n`n[extension.eac3]`nprofile=audio`n`n[extension.mlp]`nprofile=audio`n`n[extension.dts]`nprofile=audio`n`n[extension.dts-hd]`nprofile=audio`n`n[extension.dtshd]`nprofile=audio`n`n[extension.true-hd]`nprofile=audio`n`n[extension.thd]`nprofile=audio`n`n[extension.truehd]`nprofile=audio`n`n[extension.thd+ac3]`nprofile=audio`n`n[extension.tta]`nprofile=audio`n`n[extension.pcm]`nprofile=audio`n`n[extension.wav]`nprofile=audio`n`n[extension.aiff]`nprofile=audio`n`n[extension.aif]`nprofile=audio`n`n[extension.aifc]`nprofile=audio`n`n[extension.amr]`nprofile=audio`n`n[extension.awb]`nprofile=audio`n`n[extension.au]`nprofile=audio`n`n[extension.snd]`nprofile=audio`n`n[extension.lpcm]`nprofile=audio`n`n[extension.ape]`nprofile=audio`n`n[extension.wv]`nprofile=audio`n`n[extension.shn]`nprofile=audio`n`n[extension.adts]`nprofile=audio`n`n[extension.adt]`nprofile=audio`n`n[extension.mpa]`nprofile=audio`n`n[extension.m1a]`nprofile=audio`n`n[extension.m2a]`nprofile=audio`n`n[extension.mp1]`nprofile=audio`n`n[extension.mp2]`nprofile=audio`n`n[extension.mp3]`nprofile=audio`n`n[extension.m4a]`nprofile=audio`n`n[extension.aac]`nprofile=audio`n`n[extension.flac]`nprofile=audio`n`n[extension.oga]`nprofile=audio`n`n[extension.ogg]`nprofile=audio`n`n[extension.opus]`nprofile=audio`n`n[extension.spx]`nprofile=audio`n`n[extension.mka]`nprofile=audio`n`n[extension.weba]`nprofile=audio`n`n[extension.wma]`nprofile=audio`n`n[extension.f4a]`nprofile=audio`n`n[extension.ra]`nprofile=audio`n`n[extension.ram]`nprofile=audio`n`n[extension.3ga]`nprofile=audio`n`n[extension.3ga2]`nprofile=audio`n`n[extension.ay]`nprofile=audio`n`n[extension.gbs]`nprofile=audio`n`n[extension.gym]`nprofile=audio`n`n[extension.hes]`nprofile=audio`n`n[extension.kss]`nprofile=audio`n`n[extension.nsf]`nprofile=audio`n`n[extension.nsfe]`nprofile=audio`n`n[extension.sap]`nprofile=audio`n`n[extension.spc]`nprofile=audio`n`n[extension.vgm]`nprofile=audio`n`n[extension.vgz]`nprofile=audio`n`n[extension.m3u]`nprofile=audio`n`n[extension.m3u8]`nprofile=audio`n`n[extension.pls]`nprofile=audio`n`n[extension.cue]`nprofile=audio`n`n[audio]`nosd-level=3`nosd-scale-by-window=no`nosd-font-size=35`nosd-msg3=" ${time-pos}/${time-remaining}\n\n"`n, %A_ScriptDir%\UMPVD.conf
}

If (A_ScreenDPI = 96) {
	VidW := 800*1.017811704834606
	VidH := VidW/1.39
	MinW := VidW/2.4
	MinH := VidH/3.15
	FonS = s14
}
If (A_ScreenDPI = 120) {
	VidW := 800*1.020408163265306
	VidH := VidW/1.375
	MinW := VidW/3
	MinH := VidH/3.95
	FonS = s12
}
If (A_ScreenDPI = 144) {
	VidW := 800*1.025641025641026
	VidH := VidW/1.3625
	MinW := VidW/3.58
	MinH := VidH/4.7
	FonS = s10
}
If (A_ScreenDPI = 168) {
	VidW := 800*1.028277634961440
	VidH := VidW/1.3475
	MinW := VidW/4.15
	MinH := VidH/5.475
	FonS = s8
}

/*
No Clock - Just in case
MinH := VidH/5.45
MinH := VidH/6.75
MinH := VidH/8
MinH := VidH/9.25
*/

Gui, Margin, 0,0
Gui, Color, c350035
Gui, Add, Groupbox
Gui, Show, x%A_ScreenWidth% w%VidW% h%VidH%
GuiControl, Disable, A
Gui, +MinSize%MinW%x%MinH% +HwndUDID +Resize -DPIScale
ControlGet, Glue, Hwnd,, Button1, %A_ScriptName%
Sleep, 125
Run, mpv.exe --include="%A_ScriptDir%\UMPVD.conf" --wid=%Glue% --input-ipc-server=\\.\pipe\mpvpipe --title=MPVSlave --image-display-duration=inf --screenshot-template=UMPVD-`%n --screenshot-format=png --screenshot-png-compression=0 --reset-on-next-file=pause --keep-open=yes --idle, %A_ScriptDir%, UseErrorLevel
	If (ErrorLevel = "ERROR") {
		Gui, Hide
		MsgBox, 16, Oopsie!, SMPVD & MPV need to be in the`nsame directory to work together. Exiting.
		ExitApp
		}
WinWaitActive, ahk_id %UDID%
WinSetTitle, ahk_id %UDID%,, UMPVD
Gui, Font, %FonS%, Consolas
Gui, Add, Slider, y1000 gProgress vProg w252 h23 Range-0-100 Center Thick20 NoTicks, 0
Gui, Add, Button, y1000 gBck w37 h25, ◄◄
Gui, Add, Button, y1000 gLoad w80 h25, ▲
Gui, Add, Button, y1000 gPlPu w37 h25 Default, ‖►
Gui, Add, Button, y1000 gStop w37 h25, ■
Gui, Add, Button, y1000 gFwd w37 h25, ►►
Gui, Add, Slider, y1000 gVolume vVol h92 w45 Vertical Invert Range-0-130 Center Thick25 TickInterval20, 100
Gui, Add, Button, y1000 gFullS w37 h25, ↕
Gui, Add, Button, y1000 gSshot w37 h25, ✶
Gui, Add, Button, y1000 gLewp w37 h25, ∞
Gui, Add, Button, y1000 gSubz w37 h25, ⅍
Gui, Add, Button, y1000 gMP3 w37 h25, ●
Gui, Add, Button, y1000 gMute h14 w37 h25, ₥
Gosub, RePos
WinMove, ahk_id %UDID%,, (A_ScreenWidth/2)-(VidW/2), (A_ScreenHeight/2)-(VidH/2), %VidW%, %VidH%
GroupAdd, Btn, ahk_id %UDID%

Menu, Tray, Add, Toggle Play/Pause, PlPu
Menu, Tray, Add, Previous Track, Bck
Menu, Tray, Add, Next Track, Fwd
Menu, Tray, Add, Stop Playback, Stop
Menu, Tray, Add
Menu, Tray, Add, Load Media File, Load
Menu, Tray, Add
Menu, Tray, Add, Take Screenshot, Sshot
Menu, Tray, Add, Toggle Fullscreen, FullS
Menu, Tray, Add
Menu, Tray, Add, About UMPVD, About
Menu, Tray, Add, Exit UMPVD, GuiClose
Menu, Tray, NoStandard

For X, File in A_Args
{
	Gosub, Play
}
Return

;-------------Item Re-positioning----------------

Repos:
GuiSize:
If (ErrorLevel = 1)
Return
NewW := A_GuiWidth
NewH := A_Guiheight-97
Col1 := A_GuiWidth/2-150
Row1 := NewH+4
Row2 := NewH+33
Row3 := NewH+63
GuiControl, MoveDraw, Button1, W%NewW% H%NewH%
GuiControl, MoveDraw, msctls_trackbar321, X%Col1% Y%Row1%
GuiControl, MoveDraw, Button2, X%Col1% Y%Row2%
GuiControlGet, But, Pos, Button2
ButX := ButX+43
GuiControl, MoveDraw, Button3, X%ButX% Y%Row2%
GuiControlGet, But, Pos, Button3
ButX := ButX+86
GuiControl, MoveDraw, Button4, X%ButX% Y%Row2%
GuiControlGet, But, Pos, Button4
ButX := ButX+43
GuiControl, MoveDraw, Button5, X%ButX% Y%Row2%
GuiControlGet, But, Pos, Button5
ButX := ButX+43
GuiControl, MoveDraw, Button6, X%ButX% Y%Row2%
GuiControl, MoveDraw, Button7, X%Col1% Y%Row3%
GuiControlGet, But, Pos, Button7
ButX := ButX+43
GuiControl, MoveDraw, Button8, X%ButX% Y%Row3%
GuiControlGet, But, Pos, Button8
ButX := ButX+43
GuiControl, MoveDraw, Button9, X%ButX% Y%Row3%
GuiControlGet, But, Pos, Button9
ButX := ButX+43
GuiControl, MoveDraw, Button10, X%ButX% Y%Row3%
GuiControlGet, But, Pos, Button10
ButX := ButX+43
GuiControl, MoveDraw, Button11, X%ButX% Y%Row3%
GuiControlGet, But, Pos, Button11
ButX := ButX+43
GuiControl, MoveDraw, Button12, X%ButX% Y%Row3%
GuiControlGet, But, Pos, Button12
ButX := ButX+43
GuiControl, MoveDraw, msctls_trackbar322, X%ButX% Y%Row1%
Return

GuiContextMenu:
Menu, RCM, Add, Toggle Play/Pause, PlPu
Menu, TR, Add, Previous Track, Bck
Menu, TR, Add, Next Track, Fwd
Menu, RCM, Add, Playlist, :TR
Menu, RCM, Add, Stop Playback, Stop
Menu, RCM, Add, —~—~—~—~, Null
Menu, RCM, Add, Load Media File, Load
Menu, RCM, Add, ~—~—~—~—~, Null
Menu, VB, Add, 0`%, VPos1
Menu, VB, Add, 25`%, VPos2
Menu, VB, Add, 50`%, VPos3
Menu, VB, Add, 75`%, VPos4
Menu, RCM, Add, Jump Position, :VB
Menu, RCM, Add, —~—~—~—, Null
Menu, DB, Add, 130`%, St130
Menu, DB, Add, 100`%, St100
Menu, DB, Add, 75`%, St75
Menu, DB, Add, 50`%, St50
Menu, DB, Add, 25`%, St25
Menu, RCM, Add, Set Volume, :DB
Menu, RCM, Add, Mute Volume, Mute
Menu, RCM, Add, ~—~—~—~, Null
Menu, RCM, Add, Take Screenshot, Sshot
Menu, RCM, Add, Toggle Fullscreen, FullS
Menu, RCM, Add, —~—~—~—~—, Null
Menu, RCM, Add, About UMPVD, About
Menu, RCM, Add, Exit UMPVD, GuiClose
Menu, RCM, Show
Return

Null:
Return

;--------------Import & Playback-----------------

GuiDropFiles(GuiHwnd, Select, Glue, X, Y) {
	Run, %ComSpec% /c "Echo stop > \\.\pipe\mpvpipe",, hide
	for index, File in Select {
		Gosub, Play
		}
	}
Return

ClipRun(Type) {
If (clipboard ~= "i)\.bmp$|\.jpg$|\.png$|\.xwm$|\.ac3$|\.a52$|\.eac3|\.mlp$|\.dts$|\.dts-hd$|\.dtshd$|\.true-hd$|\.thd$|\.truehd$|\.thd+ac3$|\.tta$|\.pcm$|\.wav$|\.aiff$|\.aif$|\.aifc$|\.amr$|\.awb$|\.au$|\.snd$|\.lpcm$|\.ape$|\.wv$|\.shn$|\.adts$|\.adt$|\.mpa$|\.m1a$|\.m2a$|\.mp1$|\.mp2$|\.mp3$|\.m4a$|\.aac$|\.flac$|\.oga$|\.ogg$|\.opus$|\.spx$|\.mka$|\.weba$|\.wma$|\.f4a$|\.ra$|\.ram$|\.3ga$|\.3ga2$|\.ay$|\.gbs$|\.gym$|\.hes$|\.kss$|\.nsf$|\.nsfe$|\.sap$|\.spc$|\.vgm$|\.vgz$|\.m3u$|\.m3u8$|\.pls$|\.cue$|\.yuv$|\.y4m$|\.m2ts$|\.m2t$|\.mts$|\.mtv$|\.ts$|\.tsv$|\.tsa$|\.tts$|\.trp$|\.mpeg$|\.mpg$|\.mpe$|\.mpeg2$|\.m1v$|\.m2v$|\.mp2v$|\.mpv$|\.mpv2$|\.mod$|\.tod$|\.vob$|\.vro$|\.evob$|\.evo$|\.mpeg4$|\.m4v$|\.mp4$|\.mp4v$|\.mpg4$|\.h264$|\.avc$|\.x264$|\.264$|\.hevc$|\.h265$|\.x265$|\.265$|\.ogv$|\.ogm$|\.ogx$|\.mkv$|\.mk3d$|\.webm$|\.avi$|\.vfw$|\.divx$|\.3iv$|\.xvid$|\.nut$|\.flic$|\.fli$|\.flc$|\.nsv$|\.gxf$|\.mxf$|\.wm$|\.wmv$|\.asf$|\.dvr-ms$|\.dvr$|\.wtv$|\.dv$|\.hdv$|\.flv$|\.f4v$|\.qt$|\.mov$|\.hdmov$|\.rm$|\.rmvb$|\.3gpp$|\.3gp$|\.3gp2$|\.3g2$|\.bik$|\.ogv$") {
	Run, %ComSpec% /c "Echo stop > \\.\pipe\mpvpipe",, hide
	Loop, parse, clipboard, `n, `r
		{
		File = %A_Loopfield%
		Gosub, Play
		}
	}
}
Return

Play:
If (File ~= "i)\.bmp$|\.jpg$|\.png$|\.xwm$|\.ac3$|\.a52$|\.eac3|\.mlp$|\.dts$|\.dts-hd$|\.dtshd$|\.true-hd$|\.thd$|\.truehd$|\.thd+ac3$|\.tta$|\.pcm$|\.wav$|\.aiff$|\.aif$|\.aifc$|\.amr$|\.awb$|\.au$|\.snd$|\.lpcm$|\.ape$|\.wv$|\.shn$|\.adts$|\.adt$|\.mpa$|\.m1a$|\.m2a$|\.mp1$|\.mp2$|\.mp3$|\.m4a$|\.aac$|\.flac$|\.oga$|\.ogg$|\.opus$|\.spx$|\.mka$|\.weba$|\.wma$|\.f4a$|\.ra$|\.ram$|\.3ga$|\.3ga2$|\.ay$|\.gbs$|\.gym$|\.hes$|\.kss$|\.nsf$|\.nsfe$|\.sap$|\.spc$|\.vgm$|\.vgz$|\.m3u$|\.m3u8$|\.pls$|\.cue$|\.yuv$|\.y4m$|\.m2ts$|\.m2t$|\.mts$|\.mtv$|\.ts$|\.tsv$|\.tsa$|\.tts$|\.trp$|\.mpeg$|\.mpg$|\.mpe$|\.mpeg2$|\.m1v$|\.m2v$|\.mp2v$|\.mpv$|\.mpv2$|\.mod$|\.tod$|\.vob$|\.vro$|\.evob$|\.evo$|\.mpeg4$|\.m4v$|\.mp4$|\.mp4v$|\.mpg4$|\.h264$|\.avc$|\.x264$|\.264$|\.hevc$|\.h265$|\.x265$|\.265$|\.ogv$|\.ogm$|\.ogx$|\.mkv$|\.mk3d$|\.webm$|\.avi$|\.vfw$|\.divx$|\.3iv$|\.xvid$|\.nut$|\.flic$|\.fli$|\.flc$|\.nsv$|\.gxf$|\.mxf$|\.wm$|\.wmv$|\.asf$|\.dvr-ms$|\.dvr$|\.wtv$|\.dv$|\.hdv$|\.flv$|\.f4v$|\.qt$|\.mov$|\.hdmov$|\.rm$|\.rmvb$|\.3gpp$|\.3gp$|\.3gp2$|\.3g2$|\.bik$|\.ogv$") {
	WinSetTitle, ahk_id %UDID%,, UMPVD - Press F5 for Playlist
	MP3F := File
	Gosub,ResDim
	File := StrReplace(File, "\", "/")
	Sleep, 75
	Run, %ComSpec% /c "Echo no-osd loadfile "%File%" append-play > \\.\pipe\mpvpipe",, hide
	Sleep, 75
	Run, %ComSpec% /c "Echo no-osd playlist-prev > \\.\pipe\mpvpipe",, hide
	GuiControl,, Prog, 0
}
Return

;-------------Button Functions-------------------

Bck:
Gosub,ResDim
Run, %ComSpec% /c "Echo playlist-prev > \\.\pipe\mpvpipe",, hide
Run, %ComSpec% /c "Echo show_text ${filename} > \\.\pipe\mpvpipe",, hide
Return

Load:
FileSelectFile, Slct, M3,, Select File to Play
If (Slct = "")
{
    Return
}
Run, %ComSpec% /c "Echo stop > \\.\pipe\mpvpipe",, hide
Loop, parse, Slct, `n
{
	If (A_Index = 1) {
		Dir = %A_LoopField%
	}
	Else If (A_Index > 1) {
		File = %A_LoopField%
		File = %Dir%\%File%
		Gosub, Play
	}
}
Return

PlPu:
Run, %ComSpec% /c "Echo cycle pause > \\.\pipe\mpvpipe",, hide
Return

Stop:
Run, %ComSpec% /c "Echo stop > \\.\pipe\mpvpipe",, hide
GuiControl,, Prog, 0
WinSetTitle, UMPVD
Return

Fwd:
Gosub,ResDim
Run, %ComSpec% /c "Echo playlist-next > \\.\pipe\mpvpipe",, hide
Run, %ComSpec% /c "Echo show_text ${filename} > \\.\pipe\mpvpipe",, hide
Return

FullS:
If (FS != 1) {
	WinGet, Box, MinMax, ahk_id %UDID%
	If (Box = -1) {
		WinRestore, ahk_id %UDID%
	}
	WinGetPos, ResX, ResY, ResW, ResH, ahk_id %UDID%
	WinSet, Style, -0xC40000, ahk_id %UDID%
	ControlMove, Button1,,, A_ScreenWidth, A_Screenheight, ahk_id %UDID%
	WinMove, ahk_id %UDID%,, 0, 0, A_ScreenWidth, A_Screenheight
	FS := 1
	Gosub, FSGui
	Settimer, FSGui, 1000
	}
Else If (FS = 1) {
	Settimer, FSGui, Delete
	WinSet, Style, +0xC40000, ahk_id %UDID%
	WinWaitActive, ahk_id %UDID%
	WinMove, ahk_id %UDID%,, %ResX%, %ResY%, %ResW%, %ResH%
	FS =
	Bll =
}
Return

FSGui:
MouseGetPos, MsX, MsY
If (MsY > A_ScreenHeight-97 && Bll = 1) {
	WinMove, ahk_id %UDID%,,,, A_ScreenWidth+1, A_Screenheight+1
	WinMove, ahk_id %UDID%,,,, A_ScreenWidth, A_Screenheight
	ControlMove, Button1,,, A_ScreenWidth, A_Screenheight-97, ahk_id %UDID%
	Bll =
	}
Else If (MsY < A_ScreenHeight-97 && Bll = "") {
	ControlMove, Button1,,, A_ScreenWidth, A_Screenheight, ahk_id %UDID%
	Bll := 1
}
Return

SShot:
Run, %ComSpec% /c "Echo screenshot > \\.\pipe\mpvpipe",, hide
Return

Lewp:
Run, %ComSpec% /c "Echo ab-loop > \\.\pipe\mpvpipe",, hide
Return

Subz:
Run, %ComSpec% /c "Echo cycle sub > \\.\pipe\mpvpipe",, hide
Return

Mute:
Run, %ComSpec% /c "Echo cycle mute > \\.\pipe\mpvpipe",, hide
If (Vpos = "") {
GuiControlGet, Vpos,, Vol
GuiControl,, Vol, 0
}
Else If (Vpos != ""){
GuiControl,, Vol, %Vpos%
Vpos =
}
Return

Volume:
Run, %ComSpec% /c "Echo set volume %Vol% > \\.\pipe\mpvpipe",, hide
Return

Progress:
Run, %ComSpec% /c "Echo seek %Prog% absolute-percent+keyframes > \\.\pipe\mpvpipe",, hide
Return

MP3:
GuiControl, Disable, Button11
FileDelete, %A_Temp%\Temp.mp3
RunWait, mpv.exe "%MP3F%" --oac=libmp3lame --oacopts=b=192000 --title=MP3Convert --no-video --o=%A_Temp%\Temp.mp3, %A_ScriptDir%, hide, KillPID
SplitPath, MP3F,,,, MP3N
MP3N := StrReplace(MP3N, "%20", " ")
MP3N := StrReplace(MP3N, "%2C", ",")
MP3N := StrReplace(MP3N, "%26", "&")
MP3N := StrReplace(MP3N, "%28", "(")
MP3N := StrReplace(MP3N, "%29", ")")
Filemove, %A_Temp%\Temp.mp3, %A_Desktop%\%MP3N%.mp3, 1
GuiControl, Enable, Button11
Return

About:
Gui, About:+owner +Toolwindow
Gui, About:Color, c350035
Gui, About:Font, s8 Bold cWhite
Gui, About:Add, Text, xp+20, Unified MPV Dashboard
Gui, About:Font, Norm
Gui, About:Add, Text, xm+0, Written by Rodney Caruana (2022)
Gui, About:Font, cWhite
Gui, About:Show,, About UMPVD
WinSet, AlwaysOnTop, On, A
Return

AboutGuiClose:
Gui, Destroy
Return

ResDim:
Run, %ComSpec% /c "Echo no-osd set speed 1 > \\.\pipe\mpvpipe",, hide
Run, %ComSpec% /c "Echo no-osd cycle-values video-aspect "-1" > \\.\pipe\mpvpipe",, hide
Run, %ComSpec% /c "Echo no-osd set video-pan-x 0 > \\.\pipe\mpvpipe",, hide
Run, %ComSpec% /c "Echo no-osd set video-pan-y 0 > \\.\pipe\mpvpipe",, hide
Run, %ComSpec% /c "Echo no-osd set video-zoom 0 > \\.\pipe\mpvpipe",, hide
Run, %ComSpec% /c "Echo no-osd set panscan 0 > \\.\pipe\mpvpipe",, hide
Return

St25:
Run, %ComSpec% /c "Echo set volume 25 > \\.\pipe\mpvpipe",, hide
Return

St50:
Run, %ComSpec% /c "Echo set volume 50 > \\.\pipe\mpvpipe",, hide
Return

St75:
Run, %ComSpec% /c "Echo set volume 75 > \\.\pipe\mpvpipe",, hide
Return

St100:
Run, %ComSpec% /c "Echo set volume 100 > \\.\pipe\mpvpipe",, hide
Return

St130:
Run, %ComSpec% /c "Echo set volume 130 > \\.\pipe\mpvpipe",, hide
Return

VPos1:
Run, %ComSpec% /c "Echo seek 0 absolute-percent+keyframes > \\.\pipe\mpvpipe",, hide
Return

VPos2:
Run, %ComSpec% /c "Echo seek 25 absolute-percent+keyframes > \\.\pipe\mpvpipe",, hide
Return

VPos3:
Run, %ComSpec% /c "Echo seek 50 absolute-percent+keyframes > \\.\pipe\mpvpipe",, hide
Return

VPos4:
Run, %ComSpec% /c "Echo seek 75 absolute-percent+keyframes > \\.\pipe\mpvpipe",, hide
Return

;-------------------Hotkeys----------------------

#IfWinActive ahk_group Btn
~WheelUp::
Run, %ComSpec% /c "Echo seek 1 relative+keyframes > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~WheelDown::
Run, %ComSpec% /c "Echo seek -1 relative+keyframes > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~LButton::
If (A_ThisHotkey = A_PriorHotkey && A_TimeSincePriorHotkey <= 200) {

Gosub, FullS
}
Return

#IfWinActive ahk_group Btn
~Esc::
Gosub, FullS
Return

#IfWinActive ahk_group Btn
~1::
Run, %ComSpec% /c Echo cycle contrast down > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~2::
Run, %ComSpec% /c "Echo cycle contrast > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~3::
Run, %ComSpec% /c "Echo cycle brightness down > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~4::
Run, %ComSpec% /c "Echo cycle brightness > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~5::
Run, %ComSpec% /c "Echo cycle gamma down > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~6::
Run, %ComSpec% /c "Echo cycle gamma > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~7::
Run, %ComSpec% /c "Echo cycle saturation down > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~8::
Run, %ComSpec% /c "Echo cycle saturation > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~9::
Run, %ComSpec% /c "Echo multiply speed 0.9438743126816935 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~0::
Run, %ComSpec% /c "Echo multiply speed 1.059463094352953> \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~-::
Run, %ComSpec% /c "Echo add volume -1 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~=::
Run, %ComSpec% /c "Echo add volume 1 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~q::
Gosub, Guiclose
Return

#IfWinActive ahk_group Btn
~u::
Gosub, Stop
Return

#IfWinActive ahk_group Btn
~i::
Run, %ComSpec% /c "Echo script-binding stats/display-stats > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~o::
Run, %ComSpec% /c "Echo show-progress > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~p::
Gosub, PlPu
Return

#IfWinActive ahk_group Btn
~MButton::
Gosub, PlPu
Return

#IfWinActive ahk_group Btn
~?::
Gosub, About
Return

#IfWinActive ahk_group Btn
~r::
Run, %ComSpec% /c "Echo set panscan 0 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~a::
Run, %ComSpec% /c "Echo cycle-values video-aspect "1.778:1" "16:10" "16:9" "5:4" "4:3" "-1" > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~s::
Gosub, Sshot
Return

#IfWinActive ahk_group Btn
~f::
Gosub, Load
Return

#IfWinActive ahk_group Btn
~l::
Gosub, Lewp
Return

#IfWinActive ahk_group Btn
~v::
Gosub, Subz
Return

#IfWinActive ahk_group Btn
~m::
Gosub, Mute
Return

#IfWinActive ahk_group Btn
~NumpadAdd::
Run, %ComSpec% /c "Echo add volume 1 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~NumpadSub::
Run, %ComSpec% /c "Echo add volume -1 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~[::
Run, %ComSpec% /c "Echo frame-back-step > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~]::
Run, %ComSpec% /c "Echo frame-step > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~F5::
Run, %ComSpec% /c "Echo show_text ${playlist} > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~Numpad1::
Run, %ComSpec% /c "Echo no-osd add panscan -0.1 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~Numpad2::
Run, %ComSpec% /c "Echo no-osd add video-pan-y -0.01 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~Numpad3::
Run, %ComSpec% /c "Echo no-osd add video-zoom -0.025 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~Numpad4::
Run, %ComSpec% /c "Echo no-osd add video-pan-x 0.01 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~Numpad5::
Gosub, ResDim
Return

#IfWinActive ahk_group Btn
~Numpad6::
Run, %ComSpec% /c "Echo no-osd add video-pan-x -0.01 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~Numpad7::
Run, %ComSpec% /c "Echo no-osd add panscan 0.1 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~Numpad8::
Run, %ComSpec% /c "Echo no-osd add video-pan-y 0.01 > \\.\pipe\mpvpipe",, hide
Return

#IfWinActive ahk_group Btn
~Numpad9::
Run, %ComSpec% /c "Echo no-osd add video-zoom 0.025 > \\.\pipe\mpvpipe",, hide
Return

GuiClose:
Process, Close, %KillPID%
ExitApp
Return