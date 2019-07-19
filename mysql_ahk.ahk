#Warn
#NoEnv 
SetBatchLines -1
SendMode Input 
SetWorkingDir %A_ScriptDir%  
;DetectHiddenWindows, On
DetectHiddenText, On
SetTitleMatchMode 2
;#INCLUDE com.ahk
#SingleInstance Force 


ver=v0.1
bgcolor=FFFFFF


/*
	if !FileExist("config.ini")
	{
		IniWrite, 1, config.ini, COUNT, count
	}
	IniRead, ccount,config.ini, COUNT, count
	IniWrite, %ccount%, config.ini, COUNT, count
	
	IniRead, pathfound,config.ini, PATH, binpath, %A_SPACE%
	if (pathfound="")
	{
		FileSelectFolder, binpath,, 3,Select The Path of BIN Folder in MySQL directory `nExample (C:\Program Files\MySQL\MySQL Server 8.0\bin)
		IniWrite, %binpath%, config.ini, PATH, binpath
	}
	IniRead, user,config.ini, USERDATA, username, %A_SPACE%
	if (user="")
	{
		InputBox, user, User Data, Please enter the username of created database., , 200, 150,,,,,root
		InputBox, pass, %use% Password, Please enter password of created  %user% database user.,HIDE , 200, 150,,,,,1234
		IniWrite, %user%, config.ini, USERDATA, username
		IniWrite, %pass%, config.ini, USERDATA, password
	}
	
	IniRead, user,config.ini, USERDATA, username, %A_SPACE%
	IniRead, pass,config.ini, USERDATA, password, %A_SPACE%
	drive := SubStr(pathfound, 1, 1)
	
	;Gui 2,Show, w479 h377, MySQL Automation v0.1 by Akshay Parakh
	
	
	*/
	
	
	
	
	IniWrite, 1, config.ini, COUNT, count
	IniRead, fts_check,config.ini,FIRST_TIME_SETUP, fts
	;IniWrite, 1, config.ini, FIRST TIME SETUP, Ffts
	;if !FileExist("config.ini")
	if !(fts_check=1)
	{
		IniWrite, 1, config.ini, COUNT, count
		goto, FirstTime
		return
	}
	else
	{
		IniRead, ccount,config.ini, COUNT, count
		ccount++
		IniWrite, %ccount%, config.ini, COUNT, count
		IniRead, pathfound,config.ini, PATH, binpath, %A_SPACE%
		;msgbox % pathfound
		drive := SubStr(pathfound, 1, 1)
		IniRead, IniDB,config.ini, DATABASE,Initial_database, %A_SPACE%
		IniRead, user,config.ini, USERDATA, username, %A_SPACE%
		IniRead, pass,config.ini, USERDATA, password, %A_SPACE%
		goto,Main
	}
	
	FirstTime:
	{
		Gui 2: Font, , Arial
		Gui 2: Add, Text, x98 y51 , 1]
		Gui 2: Add, CheckBox, x138 y45 h28 vBFold , MySQL Sever/bin folder stored
		Gui 2: Add, Text, x98 y83 w328 0x10 

		Gui 2: Add, Text, x98 y101 , 2]
		Gui 2: Add, CheckBox, x138 y95  h28 vUData, Username and Password stored
		Gui 2: Add, Text, x98 y133 w328 0x10 

		Gui 2: Add, Text, x98 y151 , 3]
		Gui 2: Add, CheckBox, x138 y145  h28 vInDB , Initial database created
		Gui 2: Add, Text, x98 y183 w328 0x10 

		Gui 2:Add, Text, x98 y201 , 4]
		Gui 2: Add, CheckBox, x138 y195 h28 vAlDB, Always use this database
		Gui 2: Add, Text, x98 y233 w328 0x10 

		Gui 2: Add, Button, x328 y45 w96 h28 Default vBFoldB gBFold , Browse
		Gui 2: Add, Button, x328 y95 w96 h28 vUDataB gUData, Store
		Gui 2: Add, Button, x328 y145 w96 h28 vInDBB gInDB, Create


		Gui 2: Add, Button, x40 y276 w124 h38 gResetB, Reset
		Gui 2: Add, Button, x184 y276 w115 h38 gFinB vFin , Finish
		Gui 2: Add, Button, x319 y276 w115 h38 gCancelB, Cancel

		GuiControl,2: Disable, BFold
		GuiControl,2: Disable, UData
		GuiControl,2: Disable, InDB
		GuiControl,2: Disable, AlDB
		GuiControl,2: Disable, Fin
		GuiControl,2: Disable, UDataB
		GuiControl,2: Disable, InDBB
		Gui 2: Add, StatusBar
		SB_SetParts(20)
		SB_SetText("  >",1)
		SB_SetText("PERFORM ALL THE STEPS SEQUENTIALLY",2)
		Gui 2: Show, w483 h379, First Time Setup - MySQL Automation %ver% by Akshay Parakh
		return
		
		BFold:
		{
			FileSelectFolder, binpath,, 3,Select The Path of BIN Folder in MySQL directory `nExample (C:\Program Files\MySQL\MySQL Server 8.0\bin)
			if !(binpath="")
			{
				IniWrite, %binpath%, config.ini, PATH, binpath
				SB_SetText("PATH SAVED!",2)
				GuiControl,2: Enable, UDataB
				GuiControl,2: Disable, BFoldB
				GuiControl,2:,BFold,1
			}
			return
		}

		UData:
		{
			InputBox, user, User Data, Please enter the username of MySQL, , 200, 150,,,,,root
			InputBox, pass, %use% Password, Please enter password of %user% database user.,HIDE , 200, 150,,,,,1234
			IniWrite, %user%, config.ini, USERDATA, username
			IniWrite, %pass%, config.ini, USERDATA, password
			SB_SetText("USERDATA SAVED!",2)
			GuiControl,2: Enable, InDBB
			GuiControl,2: Disable, UDataB
			GuiControl,2:,UData,1
			return
		}

		InDB:
		{
			InputBox, IniDB,Initial Database, Please enter the database name to be created initially., , 200, 150,,,,,Akshay
			if !(IniDB="")
			{
				IniWrite, %IniDB%, config.ini, DATABASE, Initial_database
			}
			IniRead, IniDB,config.ini, DATABASE,Initial_database, %A_SPACE%
			IniRead, pathfound,config.ini, PATH, binpath, %A_SPACE%
			IniRead, user,config.ini, USERDATA, username, %A_SPACE%
			IniRead, pass,config.ini, USERDATA, password, %A_SPACE%
			drive := SubStr(pathfound, 1, 1)
			Run, %ComSpec% /k "%drive%: && cd %pathfound% &&  mysql.exe -u %user% -p%pass% " ,,,pid
			WinWaitActive, %ComSpec% ahk_pid %pid%
			controlsend,,CREATE DATABASE %IniDB%;`n,ahk_pid %pid%
			sleep 100
			WinKill,ahk_pid %Pid%
			SB_SetText("INITIAL DATABASE CREATED!",2)
			GuiControl,2: Enable, Fin
			GuiControl,2: Disable, InDBB
			;GuiControl, Enable, AlDB
			GuiControl,2:,InDB,1
			GuiControl,2:,AlDB,1
			return
		}

		ResetB:
		{
			reload
			return
		}

		FinB:
		{
			IniWrite, 1, config.ini, FIRST_TIME_SETUP, fts
			reload
		}

		CancelB:
		2GuiClose:
		ExitApp

		return
	}

	Main:
	{
		Run, %ComSpec% /k "%drive%: && cd %pathfound% &&  mysql.exe -u %user% -p%pass% " ,,,pid
		WinWaitActive, %ComSpec% ahk_pid %pid%
		;controlsend,,show databases;`n,ahk_pid %pid%
		controlsend,,use %IniDB%;`n,ahk_pid %pid%
	;	Send {WheelDown} 
	
	
		endcount = 1
		tempexec=1
		Gui, Font, , Arial
		;Gui,color,%bgcolor%
		Gui, Add, Tab2, x1 y1 w478 h376 , DDL Commands|DML Commands|DCL Commands|TCL Commands|Settings|About
		Gui, Tab,DDL Commands

		Gui, Add, Button, x23 y260 w125 h35 gCreateTable , Create Table
		Gui, Add, Button, x176 y260 w125 h35 , Alter Table
		Gui, Add, Button, x329 y260 w125 h35 , Drop Table 
		Gui, Add, Button, x23 y310 w125 h35 , Rename Table
		Gui, Add, Button, x176 y310 w125 h35 , Truncate Table
		Gui, Add, Button, x329 y310 w125 h35 ,Add Comment
		goto,CreateTable
		
		CreateTable:
		{
		;	reload
			
			;msgbox, gg
			Gui, Add, Edit, ReadOnly x15 y82 w70 h19 +center , Create Table
			Gui, Add, Edit,  x85 y82 w75 h19 +center vTName, Table_Name
			Gui, Add, Edit,ReadOnly x160 y82 w9 h19 +center , (
			Gui, Add, Edit, x169 y82 w76 h19 +center vCName%endcount%, Column_Name
			Gui, Add, Button, x169 y102 w77 h19 vAddCol gAddCol , + Add Column
			Gui, Add, ComboBox, x245 y82 w76 h100 vDType%endcount% , Int|Float|Char|Varchar|Date|Blob
			Gui, Add, Text, x243 y65 w76 h14 +center , DATA_TYPE
			Gui, Add, Text, x327 y65 w30 h14 +center , SIZE
			Gui, Add, Text, x353 y65 w111 h14 +center , ADD MORE
			Gui, Add, Edit, ReadOnly x321 y82 w9 h19 +center , (
			Gui, Add, Edit, x330 y82 w24 h19 +center vSize%endcount%, 
			Gui, Add, Edit, ReadOnly x354 y82 w9 h19 +center , )
			Gui, Add, Edit, x363 y82 w86 h19 +center vMore%endcount%,
			Gui, Add, Edit, Readonly x449 y82 w12 h19 vEnd%endcount%, );
			Gui, Add, Button, x329 y200 w125 h34 +center vExecCreate gExecCreate, EXECUTE
			Gui, Add, Text, x23 y250 w432 0x10 
			Gui, Add, StatusBar
			SB_SetParts(20)
			SB_SetText("  >",1)
			Gui, Show, w479 h377, MySQL Automation %ver% by Akshay Parakh

			ymore=102
			y=82


			return
			
			AddCol:
			{
				while(endcount<5)
				{
					SB_SetText("Added Column "endcount+1,2)
					Gui, Submit,NoHide
					y += 22
					ymore += 22
					GuiControl,, End%endcount%,,
					endcount++
					tempexec=%endcount%
					Gui, Add, Edit, x169 y%y% w76 h19 vCName%endcount% +center, Column_Name
					Gui, Add, ComboBox, x245 y%y% w76 h100 vDType%endcount% , Int|Float|Char|Varchar|Date|Blob
					Gui, Add, Edit, ReadOnly x321 y%y% w9 h19 +center , (
					Gui, Add, Edit, x330 y%y% w24 h19 vSize%endcount% +center , 
					Gui, Add, Edit, ReadOnly x354 y%y% w9 h19 +center , )
					Gui, Add, Edit, x363 y%y% w86 h19 vMore%endcount% +center,
					Gui, Add, Edit, Readonly x449 y%y% w12 h19 vEnd%endcount%, );
					GuiControl, Move, AddCol,  y%ymore% 
					return
				}
				return
			}

			ExecCreate:
			{
				Gui, Submit,NoHide
				GuiControlGet, TName
				endcount=1
				controlsend,,create table %TName%(,ahk_pid %pid%
				statcommand="create table TName("
				while (endcount<=tempexec)
				{
					GuiControlGet, CName2
					GuiControlGet, CName%endcount%
					GuiControlGet, DType%endcount%
					GuiControlGet,Size%endcount%
					GuiControlGet, More%endcount%
					CoName:=CName%endcount%
					DaType:=DType%endcount%
					SizeT:=Size%endcount%
					MoreT:=More%endcount%
					comma=,
					if (tempexec=1)
					{
						controlsend,,%CoName% %DaType%(%SizeT%) %MoreT%);`n,ahk_pid %pid%
					}
					else
					{
						if !(tempexec=endcount)
						{
							controlsend,,%CoName% %DaType%(%SizeT%)%MoreT%%comma%,ahk_pid %pid%
						}
						else
						{
							controlsend,,%CoName% %DaType%(%SizeT%) %MoreT%);`n,ahk_pid %pid%
						}
					}
					endcount++
				}
				SB_SetText("Query Executed",2)
				return
			}
		}
		
		AlterTable:
		{
			
		}
		
		GuiClose:
		{
			WinKill,ahk_pid %Pid%
			ExitApp
		}
	
	return
	}
		
	
	

	
	
	
	
	
	
	