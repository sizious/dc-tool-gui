unit utils;

interface

uses
  Windows, SysUtils, Classes, ShellApi;
  
function RunAndWait(FileName : string) : boolean;
procedure DeleteEXE;
procedure DeleteAllFiles;
procedure CreateBatch(Line : string);
function GetTempDir: String;
function Droite(substr : string ; s: string) : string;
procedure CreateBatchDeleteFile;

implementation

uses u_kill_dctool;

//---Droite---
function Droite(substr : string ; s: string) : string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

//---CreateBatch---
procedure CreateBatch(Line : string);
var
  F : TextFile;
  FileName : string;

begin
  FileName := GetTempDir + 'turbodc.bat';
  if FileExists(FileName) = True then DeleteFile(FileName);

  AssignFile(F, FileName);
  ReWrite(F);
  WriteLn(F, '@echo off');
  WriteLn(F, 'echo TURBO DC-TOOL GUI - Context Extender - by [big_fury]SiZiOUS');
  WriteLn(F, 'echo Powered by DC-TOOL by andrewk@napalm-x.com');
  //WriteLn(F, 'echo Command : ' + Line);
  WriteLn(F, 'echo.');
  WriteLn(F, Line);
  WriteLn(F, 'pause');
  WriteLn(F, ':retry');
  WriteLn(F, 'del ' + GetTempDir + 'DC-TOOL.EXE');
  WriteLn(F, 'del ' + GetTempDir + 'DC-TOOL-IP.EXE');
  WriteLn(F, 'del ' + GetTempDir + 'CYGWIN1.DLL');
  WriteLn(F, 'del ' + GetTempDir + 'CYGINTL.DLL');
  WriteLn(F, 'del ' + FileName);
  WriteLn(F, 'if exists ' + FileName + ' goto retry');
  CloseFile(F);

  //ShellExecute(Upload_Form.Handle, 'open', PChar(FileName), '', '', SW_SHOWNORMAL);
  RunAndWait(FileName);
end;

//---CreateBatchDeleteFile---
procedure CreateBatchDeleteFile;
var
  F : TextFile;
  FileName : string;

begin
  FileName := GetTempDir + 'eraser.bat';
  if FileExists(FileName) = True then DeleteFile(FileName);

  AssignFile(F, FileName);
  ReWrite(F);
  WriteLn(F, '@echo off');
  WriteLn(F, 'REM TURBO DC-TOOL GUI - Eraser program');
  WriteLn(F, ':retry');
  WriteLn(F, 'del ' + GetTempDir + 'DC-TOOL.EXE');
  WriteLn(F, 'del ' + GetTempDir + 'DC-TOOL-IP.EXE');
  WriteLn(F, 'del ' + GetTempDir + 'CYGWIN1.DLL');
  WriteLn(F, 'del ' + GetTempDir + 'CYGINTL.DLL');
  WriteLn(F, 'del ' + FileName);
  WriteLn(F, 'if exists ' + GetTempDir + 'DC-TOOL.EXE goto retry');
  WriteLn(F, 'if exists ' + GetTempDir + 'DC-TOOL-IP.EXE goto retry');
  WriteLn(F, 'if exists ' + GetTempDir + 'CYGWIN1.DLL goto retry');
  WriteLn(F, 'if exists ' + GetTempDir + 'CYGINTL.DLL goto retry');
  WriteLn(F, 'if exists ' + FileName + ' goto retry');
  CloseFile(F);
end;

//---DeleteAllFiles---
procedure DeleteAllFiles;
begin
  if FileExists(GetTempDir + 'DC-TOOL.EXE') = True then
    DeleteFile(GetTempDir + 'DC-TOOL.EXE');
  if FileExists(GetTempDir + 'DC-TOOL-IP.EXE') = True then
    DeleteFile(GetTempDir + 'DC-TOOL-IP.EXE');
  if FileExists(GetTempDir + 'CYGWIN1.DLL') = True then
    DeleteFile(GetTempDir + 'CYGWIN1.DLL');
  if FileExists(GetTempDir + 'CYGINTL.DLL') = True then
    DeleteFile(GetTempDir + 'CYGINTL.DLL');
  if FileExists(GetTempDir + 'turbodc.bat') = True then
    DeleteFile(GetTempDir + 'turbodc.bat');
end;

//---RunAndWait---
function RunAndWait(FileName : string) : boolean;
var
  StartInfo : TStartupInfo;
  ProcessInformation : TProcessInformation;

begin
  result:=true;
  ZeroMemory(@StartInfo, sizeof(StartInfo)); // remplie de 0 StartInfo
  StartInfo.cb:=sizeof(StartInfo);
  if CreateProcess(nil,PChar(FileName), nil, nil, true, 0, nil, nil, StartInfo, ProcessInformation)
  then WaitForSingleObject(ProcessInformation.hProcess, INFINITE)// attend que l'application désignée par le handle ProcessInformation.hProcess soit terminée
  else result:=false;
end;

//---DeleteEXE---
procedure DeleteEXE;

  function GetTmpDir: string; 
  var 
    pc: PChar; 
  begin 
    pc := StrAlloc(MAX_PATH + 1); 
    GetTempPath(MAX_PATH, pc); 
    Result := string(pc); 
    StrDispose(pc); 
  end; 

  function GetTmpFileName(ext: string): string; 
  var 
    pc: PChar; 
  begin 
    pc := StrAlloc(MAX_PATH + 1); 
    GetTempFileName(PChar(GetTmpDir), 'uis', 0, pc); 
    Result := string(pc); 
    Result := ChangeFileExt(Result, ext); 
    StrDispose(pc); 
  end; 
   
var 
  batchfile: TStringList; 
  batchname: string;
   
begin 
  batchname := GetTmpFileName('.bat'); 
  FileSetAttr(ParamStr(0), 0); 
  batchfile := TStringList.Create; 
  with batchfile do 
  begin 
    try 
      Add(':LABEL');
      Add('del "' + ParamStr(0) + '"');
      Add('del ' + ChangeFileExt(batchname, '.tmp'));
      //Add('rmdir "' + Directory + '"');
      Add('if Exist "' + ParamStr(0) + '" goto LABEL');
      //Add('rmdir "' + ExtractFilePath(ParamStr(0)) + '"');
      Add('del ' + batchname);
      SaveToFile(batchname);
      ChDir(GetTmpDir); 
      //ShowMessage('Uninstalling program...');
      WinExec(PChar(batchname), SW_HIDE);
    finally 
      batchfile.Free;
    end;
  end; 
end;

//---GetRealPath---
function GetRealPath(Path : string) : string;
var
  i : integer;
  LastCharWasSeparator : Boolean;

begin
  Result := '';
  LastCharWasSeparator := False;

  Path := Path + '\';

  for i := 1 to Length(Path) do
  begin
    if Path[i] = '\' then
    begin
      if not LastCharWasSeparator then
      begin
        Result := Result + Path[i];
        LastCharWasSeparator := True;
      end
    end
    else
    begin
       LastCharWasSeparator := False;
       Result := Result + Path[i];
    end;
  end;
end;

//---GetTempDir---
function GetTempDir: String;
var
  Dossier: array[0..MAX_PATH] of Char;

begin
  Result := '';
  if GetTempPath(SizeOf(Dossier), Dossier)<>0 then Result := StrPas(Dossier);
end;

end.
