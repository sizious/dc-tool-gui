unit utils;

interface

uses
  Windows, SysUtils, Classes;

function GetTempDir: string;
//function RunAndWait(FileName : string) : boolean;
//function IsFileInUse(FileName : string) : boolean;
//function GetCurrentPath : string;
procedure ExtractFile(Ressource : string ; Extension : string);
procedure ChangeFileName(OldFileNameInTempDir : string ; NewFileNameInTempDir : string);
function GetRealPath(Path : string) : string;

implementation

//---RunAndWait---
{ function RunAndWait(FileName : string) : boolean;
var
  StartInfo : TStartupInfo;
  ProcessInformation : TProcessInformation;
  
begin
  Result := True;
  ZeroMemory(@StartInfo, SizeOf(StartInfo)); // remplie de 0 StartInfo

  with StartInfo do
  begin
    CB := SizeOf(StartInfo);
    wShowWindow := SW_HIDE;
    lpReserved := nil;
    lpDesktop := nil;
    lpTitle := nil;
    dwFlags := STARTF_USESHOWWINDOW;
    cbReserved2 := 0;
    lpReserved2 := nil;
  end;

  if CreateProcess(nil, PChar(FileName), nil, nil, True, 0, nil, nil, StartInfo,
    ProcessInformation)
  then WaitForSingleObject(ProcessInformation.hProcess, INFINITE)
  // WaitForSingleObject attend que l'application désignée par le handle
  //ProcessInformation.hProcess soit terminée
  else Result := False;
end; }

//---GetRealPath---
function GetRealPath(Path : string) : string;
var
  Dir : string;

begin
  Dir := Path;
  if Path = '' then Exit;
  while Path[Length(Path)] = '\' do
  begin
    //MsgBox(0, 'Path : ' + Path, 'ERROR', 0);
    Path := Copy(Path, 1, Length(Path) - 1);
  end;
  if Path = '' then
  begin
    Result := Dir;
    Exit;
  end;
  Result := Path + '\';
end;

//---GetTempDir---
function GetTempDir: string;
var
  Dossier : array[0..MAX_PATH] of Char;

begin
  Result := '';
  if GetTempPath(SizeOf(Dossier), Dossier) <> 0 then Result := StrPas(Dossier);
  Result := GetRealPath(Result);
end;

//---ExtractFile---
procedure ExtractFile(Ressource : string ; Extension : string);
var
 StrNomFichier  : string;
 ResourceStream : TResourceStream;
 FichierStream  : TFileStream;

begin
  StrNomFichier := GetTempDir + Ressource + '.' + Extension;
  ResourceStream := TResourceStream.Create(hInstance, Ressource, RT_RCDATA);

  try
    FichierStream := TFileStream.Create(StrNomFichier, fmCreate);
    try
      FichierStream.CopyFrom(ResourceStream, 0);
    finally
      FichierStream.Free;
    end;
  finally
    ResourceStream.Free;
  end;
end;

//---IsFileInUse---
//Permet de savoir si le fichier n'est pas utilisé.
{ function IsFileInUse(FileName : string) : boolean;
var
  F : File;

begin
  Result := True;
  AssignFile(F, FileName);                               
  {$I-} //Reset(F, 1);{$I+}
{  if IOResult <> 0 then
  begin
    MessageBoxA(0, 'Error : File used! The result of the scrambled info can be wrong.', 'BINCHECK.DLL | Error', 16 + MB_SYSTEMMODAL);
    Exit;
  end;
  CloseFile(F);
  Result := False;
end;

//---GetCurrentPath---
function GetCurrentPath : string;
begin
  Result := GetRealPath(ExtractFilePath(ParamStr(0)));
end;     }

//---ChangeFileName---
procedure ChangeFileName(OldFileNameInTempDir : string ; NewFileNameInTempDir : string);
begin
  if FileExists(GetTempDir + OldFileNameInTempDir) = True then
  begin
    RenameFile(GetTempDir + OldFileNameInTempDir, GetTempDir + NewFileNameInTempDir);
    if FileExists(GetTempDir + OldFileNameInTempDir) = True then
      DeleteFile(GetTempDir + OldFileNameInTempDir);
  end;
end;

end.
