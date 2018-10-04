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
procedure DeleteAllFiles; stdcall ; external 'dctool.dll';
//procedure DeleteAllDCTOOL;
{ procedure ExtractSplashScreen; stdcall ; external 'dctool.dll';
procedure DeleteSplashScreen; stdcall ; external 'dctool.dll';
procedure ExtractDreamRip; stdcall ; external 'dctool.dll';
procedure DeleteDreamRip; stdcall ; external 'dctool.dll';
procedure ExtractLinkTest; stdcall ; external 'dctool.dll';
procedure DeleteLinkTest; stdcall ; external 'dctool.dll';
procedure ExtractLangExe(ToPath : PChar); stdcall ; external 'dctool.dll';
procedure DeleteDelFlash; stdcall ; external 'dctool.dll';
procedure ExtractDelFlash; stdcall ; external 'dctool.dll';  }

implementation

uses main, utils, u_kill_dctool;

procedure ExtractAllFiles; stdcall ; external 'dctool.dll';

//---IsCygwinInternalUsed---
function IsCygwinInternalUsed : boolean;
begin
  if Ini.ReadBool('Location', 'Internal', True) = True then
    Result := True
  else Result := False;
end;

//---ExtractAllDCTOOL---
procedure ExtractAllDCTOOL;
begin
  KillAllRunningDCTOOL;
  ExtractAllFiles;

  //External Used, on efface les DLL
  if IsCygwinInternalUsed = False then
  begin
    if FileExists(GetTempDir + 'CYGWIN1.DLL') = True then
      DeleteFile(GetTempDir + 'CYGWIN1.DLL');

    if FileExists(GetTempDir + 'CYGINTL.DLL') = True then
      DeleteFile(GetTempDir + 'CYGINTL.DLL');
  end;
end;

end.
