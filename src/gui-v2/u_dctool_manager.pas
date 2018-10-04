{
  Unit u_kill_dctool : Permet d'extraire/effacer les DC-TOOL et DC-TOOL-IP
  For DC-TOOL GUI v1.2
  by [big_fury]SiZiOUS
}

unit u_dctool_manager;

interface

uses
  Windows, SysUtils;
  
procedure ExtractAllDCTOOL;
procedure DeleteAllDCTOOL;
procedure ExtractSplashScreen; stdcall ; external 'dctool.dll';
procedure DeleteSplashScreen; stdcall ; external 'dctool.dll';
procedure ExtractDreamRip; stdcall ; external 'dctool.dll';
procedure DeleteDreamRip; stdcall ; external 'dctool.dll';
procedure ExtractLinkTest; stdcall ; external 'dctool.dll';
procedure DeleteLinkTest; stdcall ; external 'dctool.dll';
procedure ExtractLangExe(ToPath : PChar); stdcall ; external 'dctool.dll';
procedure DeleteDelFlash; stdcall ; external 'dctool.dll';
procedure ExtractDelFlash; stdcall ; external 'dctool.dll';
//procedure PrepareDCTOOL;

implementation

uses main, tools, u_kill_dctool, cygwin;

procedure ExtractAllFiles; stdcall ; external 'dctool.dll';
procedure DeleteAllFiles; stdcall ; external 'dctool.dll';
//procedure ExtractSplashScreen; stdcall ; external 'dctool.dll';
//procedure DeleteSplashScreen; stdcall ; external 'dctool.dll';
//procedure ExtractLangExe(ToPath : PChar); stdcall ; external 'dctool.dll';

//---IsCygwinInternalUsed---
function IsCygwinInternalUsed : boolean;
begin
  if Ini.ReadBool('Cygwin', 'Internal', True) = True then
    Result := True
  else Result := False;
end;

//---ExtractAllDCTOOL---
procedure ExtractAllDCTOOL;
begin
  //DC-TOOL (SERIAL) :
  {ExtractFile(GetTempDir, 'DCTOOL', 'EXE');
  RenameFile(GetTempDir + 'DCTOOL.EXE', GetTempDir + 'DC-TOOL.EXE');
  DeleteFile(GetTempDir + 'DCTOOL.EXE'); }

  KillAllRunningDCTOOL;
  ExtractAllFiles;
  DCTOOL := GetRealPath(GetTempDir) + 'DC-TOOL.EXE';
  DCTOOLIP := GetRealPath(GetTempDir) + 'DC-TOOL-IP.EXE';

  //External Used, on efface les DLL
  if IsCygwinInternalUsed = False then
  begin
    if FileExists(GetTempDir + 'CYGWIN1.DLL') = True then
      DeleteFile(GetTempDir + 'CYGWIN1.DLL');

    if FileExists(GetTempDir + 'CYGINTL.DLL') = True then
      DeleteFile(GetTempDir + 'CYGINTL.DLL');
  end;

  //DC-TOOL-IP :
  { ExtractFile(GetTempDir, 'DCTOOLIP', 'EXE');
  RenameFile(GetTempDir + 'DCTOOLIP.EXE', GetTempDir + 'DC-TOOL-IP.EXE');
  DeleteFile(GetTempDir + 'DCTOOLIP.EXE'); }
end;

//---DeleteAllDCTOOL---
procedure DeleteAllDCTOOL;
begin
 { DeleteFile(GetTempDir + 'cygintl.dll');
  DeleteFile(GetTempDir + 'cygwin1.dll');
  DeleteFile(GetTempDir + 'DC-TOOL.EXE');
  DeleteFile(GetTempDir + 'DC-TOOL-IP.EXE'); }
  KillAllRunningDCTOOL;
  DeleteAllFiles;
end;

//---PrepareDCTOOL---
{procedure PrepareDCTOOL;
begin

  ExtractAllFiles;
  
  //External Used, on efface les DLL
  if IsCygwinInternalUsed = False then
  begin
    if FileExists(GetTempDir + 'CYGWIN1.DLL') = True then
      DeleteFile(GetTempDir + 'CYGWIN1.DLL');

    if FileExists(GetTempDir + 'CYGINTL.DLL') = True then
      DeleteFile(GetTempDir + 'CYGINTL.DLL');
  end;

end;  }

end.
