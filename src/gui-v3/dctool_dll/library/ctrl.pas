unit ctrl;

interface

uses
  Windows, SysUtils;

procedure ExtractAllFiles; stdcall ; export;
procedure DeleteAllFiles; stdcall ; export;
//procedure ExtractSplashScreen; stdcall ; export;
//procedure DeleteSplashScreen; stdcall ; export;

implementation

uses utils, u_dctool_filenames;

const
  DCTOOL_BBA    : string = 'DCTOOLIP';
  DCTOOL_SERIAL : string = 'DCTOOL';
  DCTOOL_USB    : string = 'DCTOOL'; //le même pour l'instant...
  CYGWIN1_RES   : string = 'CYGWIN1';
  CYGINTL_RES   : string = 'CYGINTL';

//---CreateDcToolDir---
procedure CreateDcToolDir;
var
  Dir : string;

begin
  Dir := GetDcToolPath;
  if not DirectoryExists(Dir) then
    ForceDirectories(Dir);
end;

//---DeleteDcToolDir---
procedure DeleteDcToolDir;
var
  Dir : string;

begin
  Dir := GetDcToolPath;
  if DirectoryExists(Dir) then
    DeleteDir(Dir);
end;

//---ExtractThis---
procedure ExtractThis(SelectTheFile : TDcToolFile);
var
  Fn, Res : string;

begin
  Fn := GetCompleteFileName(SelectTheFile);

  case SelectTheFile of
    dfBBA     : Res := DCTOOL_BBA;
    dfSerial  : Res := DCTOOL_SERIAL;
    dfUSB     : Res := DCTOOL_USB;      //le même pour l'instant... (en haut)
    dfCygWin1 : Res := CYGWIN1_RES;
    dfCygIntl : Res := CYGINTL_RES;
  end;

  if not FileExists(Fn) then ExtractFile(Res, Fn);
end;

//---ExtractAllFiles---
procedure ExtractAllFiles;


begin
  CreateDcToolDir;

  ExtractThis(dfBBA);
  ExtractThis(dfSerial);
  ExtractThis(dfUSB);
  ExtractThis(dfCygWin1);
  ExtractThis(dfCygIntl);
end;

//---DeleteAllFiles---
procedure DeleteAllFiles;
begin
  DeleteDcToolDir;
end;

{
//---ExtractSplashScreen---
procedure ExtractSplashScreen;
begin
  if FileExists(GetTempDir + 'DCTOOL.BMP')     = True then
    DeleteFile(GetTempDir + 'DCTOOL.BMP');
  ExtractFile('SPLASH', 'BMP');
  //ChangeFileName('SPLASH.BMP', 'DCTOOL.BMP');
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
}

end.
