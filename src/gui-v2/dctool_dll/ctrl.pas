unit ctrl;

interface

uses
  Windows, SysUtils;

procedure ExtractAllFiles; stdcall ; export;
procedure DeleteAllFiles; stdcall ; export;
procedure ExtractSplashScreen; stdcall ; export;
procedure DeleteSplashScreen; stdcall ; export;
procedure ExtractLangExe(ToPath : PChar); stdcall ; export;
procedure ExtractDreamRip; stdcall ; export;
procedure DeleteDreamRip; stdcall ; export;
procedure ExtractLinkTest; stdcall ; export;
procedure DeleteLinkTest; stdcall ; export;
procedure ExtractDelFlash; stdcall ; export;
procedure DeleteDelFlash; stdcall ; export;

implementation

uses utils;

//---ExtractAllFiles---
procedure ExtractAllFiles;
begin
  if FileExists(GetTempDir + 'DC-TOOL.EXE') = False then
  begin
    ExtractFile('DCTOOL', 'EXE');
    ChangeFileName('DCTOOL.EXE', 'DC-TOOL.EXE');
  end;

  if FileExists(GetTempDir + 'DC-TOOL-IP.EXE') = False then
  begin
    ExtractFile('DCTOOLIP', 'EXE');
    ChangeFileName('DCTOOLIP.EXE', 'DC-TOOL-IP.EXE');
  end;

  if FileExists(GetTempDir + 'CYGWIN1.DLL') = False then
     ExtractFile('CYGWIN1', 'DLL');

  if FileExists(GetTempDir + 'CYGINTL.DLL') = False then
    ExtractFile('CYGINTL', 'DLL');

end;

//---DeleteAllFiles---
procedure DeleteAllFiles;
begin
  if FileExists(GetTempDir + 'DC-TOOL.EXE')     = True then
    DeleteFile(GetTempDir + 'DC-TOOL.EXE');

  if FileExists(GetTempDir + 'DC-TOOL-IP.EXE')  = True then
    DeleteFile(GetTempDir + 'DC-TOOL-IP.EXE');

  if FileExists(GetTempDir + 'CYGWIN1.DLL')     = True then
    DeleteFile(GetTempDir + 'CYGWIN1.DLL');

  if FileExists(GetTempDir + 'CYGINTL.DLL')     = True then
    DeleteFile(GetTempDir + 'CYGINTL.DLL');
end;

//---ExtractSplashScreen---
procedure ExtractSplashScreen;
begin
  if FileExists(GetTempDir + 'DCTOOL.BMP')     = True then
    DeleteFile(GetTempDir + 'DCTOOL.BMP');
  ExtractFile('SPLASH', 'BMP');
  ChangeFileName('SPLASH.BMP', 'DCTOOL.BMP');
end;

//---DeleteSplashScreen---
procedure DeleteSplashScreen;
var
  BatchFile  : TextFile;
  DCTOOL_BMP : string;
  BatchName  : string;

begin
  //Definitions des variables.
  DCTOOL_BMP := GetTempDir + 'DCTOOL.BMP';
  BatchName  := GetTempDir + 'SPLASH.BAT';

  //Effacer le BAT.
  if FileExists(BatchName) = True then DeleteFile(BatchName);

  //Créer un fichier BAT qui efface le BMP + le BAT.
  AssignFile(BatchFile, BatchName);
  ReWrite(BatchFile);
  WriteLn(BatchFile, '@ECHO OFF');
  WriteLn(BatchFile, ':LABEL');
  WriteLn(BatchFile, 'DEL ' + DCTOOL_BMP);
  WriteLn(BatchFile, 'IF EXIST ' + DCTOOL_BMP + ' GOTO LABEL');
  WriteLn(BatchFile, 'DEL ' + BatchName);
  //WriteLn(BatchFile, 'PAUSE');
  CloseFile(BatchFile);

  //Executer ce fichier.
  WinExec(PChar(BatchName), SW_HIDE);
  //WinExec(PChar(BatchName), SW_SHOWNORMAL);
end;

//---ExtractLangExe---
procedure ExtractLangExe(ToPath : PChar);
begin
  ToPath := PChar(GetRealPath(ToPath));
  if FileExists(ToPath + 'LANG.EXE') = True then Exit;
  ExtractFile('LANG', 'EXE');
  CopyFile(PChar(GetTempDir + 'LANG.EXE'), PChar(ToPath + 'LANG.EXE'), False);
  if FileExists(GetTempDir + 'LANG.EXE') = True then
    DeleteFile(GetTempDir + 'LANG.EXE');
end;

//---ExtractDreamRip---
procedure ExtractDreamRip;
begin
  if FileExists(GetTempDir + 'DREAMRIP.BIN') = True then
    DeleteFile(GetTempDir + 'DREAMRIP.BIN');

  ExtractFile('DREAMRIP', 'BIN');
end;

//---DeleteDreamRip---
procedure DeleteDreamRip;
begin
  if FileExists(GetTempDir + 'DREAMRIP.BIN') = True then
    DeleteFile(GetTempDir + 'DREAMRIP.BIN');
end;

//---ExtractLinkTest---
procedure ExtractLinkTest;
begin
  if FileExists(GetTempDir + 'LINKTEST.ELF') = True then
    DeleteFile(GetTempDir + 'LINKTEST.ELF');

  ExtractFile('LINKTEST', 'ELF');
end;

//---DeleteLinkTest---
procedure DeleteLinkTest;
begin
  if FileExists(GetTempDir + 'LINKTEST.ELF') = True then
    DeleteFile(GetTempDir + 'LINKTEST.ELF');
end;

//---ExtractDelFlash---
procedure ExtractDelFlash;
begin
  if FileExists(GetTempDir + 'DELFLASH.BIN') = True then
    DeleteFile(GetTempDir + 'DELFLASH.BIN');

  ExtractFile('DELFLASH', 'BIN');
end;

//---DeleteDelFlash---
procedure DeleteDelFlash;
begin
  if FileExists(GetTempDir + 'DELFLASH.BIN') = True then
    DeleteFile(GetTempDir + 'DELFLASH.BIN');
end;

end.
