{
  GetProc.pas

  Unité "Light" de GetProc.pas original.
}

unit getproc;

interface

uses
  StdCtrls, Tlhelp32, SysUtils, Windows, Classes;

function KillFileName(FileName : string) : boolean;

implementation

//---GetProcessID---
//fonction qui retourne l'id d'un process fournit en parametre
function GetProcessId(ProgName : string) : Cardinal;
var
  Snaph : THandle;
  Proc  : TProcessEntry32;
  PId   : Cardinal;
  
begin
  PId := 0;
  Proc.dwSize:=sizeof(Proc);
  Snaph := CreateToolHelp32SnapShot(TH32CS_SNAPALL, 0);  //recupere un capture de process
  Process32First(Snaph, Proc);  //premeir process de la list
  if UpperCase(ExtractFileName(Proc.szExeFile)) = UpperCase(ProgName) then  //test pour savoir si le process correspond
     PId := Proc.th32ProcessID // recupere l'id du process
  else begin
    while Process32Next(Snaph, Proc) do  //dans le cas contraire du test on continue à cherche le process en question
    begin
      if UpperCase(ExtractFileName(Proc.szExeFile)) = UpperCase(ProgName) then
        PId := Proc.th32ProcessID;
    end;
  end;
  CloseHandle(Snaph);
  Result := PId;
end;

//---IsFileRunning---
function IsFileRunning(EXEName : string) : boolean;
begin
  if GetProcessId(EXEName) = 0 then Result := False
  else Result := True;
end;

//---KillFileName---
function KillFileName(FileName : string) : boolean;
var
  Proch : THandle;
  PId   : Cardinal;
  
begin
  Result := False;

  //messageboxa(0, pchar(FileName), '', 0);

  if not IsFileRunning(FileName) then Exit;

  PId := GetProcessId(FileName);
  Proch := OpenProcess(PROCESS_ALL_ACCESS, True, PId); //handle du process
  if TerminateProcess(Proch, PId) then Result := True;//terminer le process
end;

end.
