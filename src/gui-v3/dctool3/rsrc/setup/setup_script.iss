; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=DC-TOOL GUI 3
AppVerName=DC-TOOL GUI 3 Beta 1
AppPublisher=[big_fury]SiZiOUS
AppPublisherURL=http://sbibuilder.shorturl.com/
AppSupportURL=http://sbibuilder.shorturl.com/
AppUpdatesURL=http://sbibuilder.shorturl.com/
DefaultDirName={pf}\Dreamcast-Scene\DC-TOOL GUI
DefaultGroupName=Dreamcast-Scene\DC-TOOL GUI
InfoBeforeFile=D:\Sources\Projets\DC-TOOL GUI\DC-TOOL GUI 3\Release\Beta1\files\Help\readme.rtf
Compression=lzma/ultra
SolidCompression=true
OutputDir=D:\Sources\Projets\DC-TOOL GUI\DC-TOOL GUI 3\Release\Beta1
SourceDir=D:\Sources\Projets\DC-TOOL GUI\DC-TOOL GUI 3\Release\Beta1\files
AppVersion=Version 3.0 WIP - Beta 1
UninstallFilesDir={app}\Uninstall\
ShowLanguageDialog=yes
InternalCompressLevel=ultra
SetupIconFile=D:\Sources\Outils\WinRES\ICONS\Setup\setup.ico
WindowVisible=true
UninstallDisplayIcon={app}\Uninstall\uninst.ico
UninstallDisplayName=DC-TOOL GUI 3
VersionInfoVersion=3.0.0.0
VersionInfoCompany=Created by [big_fury]SiZiOUS
VersionInfoDescription=DC-TOOL GUI 3 SERIES - Created by [big_fury]SiZiOUS
VersionInfoCopyright=� Copyright 2002, 2005
VersionInfoTextVersion=3.0 Beta 1

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked
Name: quicklaunchicon; Description: {cm:CreateQuickLaunchIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked

[Files]
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: ..\..\..\Release\Beta1\files\bincheck.dll; DestDir: {app}
Source: ..\..\..\Release\Beta1\files\dctool3.exe; DestDir: {app}
Source: ..\..\..\Release\Beta1\files\dctool.dll; DestDir: {app}
Source: ..\..\..\Release\Beta1\files\shellext.dll; DestDir: {app}
Source: ..\..\..\Release\Beta1\files\Help\*; DestDir: {app}\Help
Source: Uninstall\uninst.ico; DestDir: {app}\Uninstall

[INI]
Filename: {app}\Help\dctoolgui.url; Section: InternetShortcut; Key: URL; String: http://sbibuilder.shorturl.com/
Filename: {app}\Help\dctool.url; Section: InternetShortcut; Key: URL; String: http://adk.napalm-x.com/dc/; Tasks: 
Filename: {app}\Help\dcs.url; Section: InternetShortcut; Key: URL; String: http://www.dreamcast-scene.com/; Tasks: 

[Icons]
Name: {group}\DC-TOOL GUI 3; Filename: {app}\dctool3.exe; WorkingDir: {app}; Comment: Run DC-TOOL GUI.
Name: {group}\Help\Websites\DC-TOOL GUI; Filename: {app}\Help\dctoolgui.url; WorkingDir: {app}\Help\; Comment: Go to SiZiOUS's SBI Builder Domain.
Name: {group}\Help\Websites\DC-TOOL Official; Filename: {app}\Help\dctool.url; WorkingDir: {app}\Help\; Comment: Go to the ADK/NAPALM website.
Name: {group}\Help\Websites\Dreamcast-Scene; Filename: {app}\Help\dcs.url; WorkingDir: {app}\Help\; Comment: Go to Dreamcast-Scene.
Name: {group}\Help\Display main help; Filename: {app}\Help\todo.chm; WorkingDir: {app}; Comment: Open the main help.
Name: {group}\Help\Read me; Filename: {app}\Help\readme.rtf; WorkingDir: {app}; Comment: Open the file read me file.
Name: {group}\Uninstall DC-TOOL GUI; Filename: {uninstallexe}; WorkingDir: {app}; Comment: Uninstall DC-TOOL GUI.; IconFilename: {app}\Uninstall\uninst.ico
; Name: {group}\Set language; Filename: {app}\lang.exe; WorkingDir: {app}; Comment: Change the DC-TOOL GUI language.
Name: {userdesktop}\DC-TOOL GUI 3; Filename: {app}\dctool3.exe; Tasks: desktopicon; WorkingDir: {app}; Comment: Run DC-TOOL GUI.; IconIndex: 0
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\DC-TOOL GUI 3; Filename: {app}\dctool3.exe; Tasks: quicklaunchicon; WorkingDir: {app}; Comment: Run DC-TOOL GUI.

[Run]
Filename: {app}\dctool3.exe; Description: {cm:LaunchProgram,DC-TOOL GUI}; Flags: nowait postinstall skipifsilent; Tasks: 

[UninstallDelete]
Type: files; Name: {app}\Help\dctoolgui.url
Type: files; Name: {app}\Help\dctool.url
