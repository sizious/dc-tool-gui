{
  Unit u_kill_dctool : Permet de tuer les DC-TOOL en execution
  For DC-TOOL GUI v1.2
  by [big_fury]SiZiOUS
}

unit u_kill_dctool;

interface

uses
  Windows, Classes;
  
const
  EXE  : string = 'DC-TOOL.EXE';
  EXE2 : string = 'DC-TOOL-IP.EXE';

procedure KillAllRunningDCTOOL;

implementation

uses getproc;

procedure KillAllRunningDCTOOL;
var
  KillList  : TStringList;
  i, Max    : integer;

begin
  KillList := TStringList.Create;

  try
    //Avoir le nombre de fois que l'EXE est lancé.
    Max := GetCurrentProcessCount;

    for i := 0 to Max - 1 do
    begin
      if IsFileRunning(EXE) then KillList.Add(EXE);
      if IsFileRunning(EXE2) then KillList.Add(EXE2);
    end;

    //Tous les killer!
    for i := 0 to KillList.Count - 1 do
      KillFileName(KillList.Strings[i]);

  finally
    KillList.Free;
  end;
end;

end.
