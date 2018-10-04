unit options;

interface

uses
  Forms;
  
procedure CreateFileTypes;
function DeleteFileTypes : boolean;
procedure AddPrgToTheContextMenu;
procedure RemovePrgToTheContextMenu;

implementation

uses regshell, regext;

//---CreateFileTypes---
procedure CreateFileTypes;
begin
  CreateExtension('ELF', 'Executable and Linkable Format', Application.ExeName + ',1');
  CreateExtension('BIN', 'Generic Binary File', Application.ExeName + ',2');
end;

//---DeleteFileTypes---
function DeleteFileTypes : boolean;
var
  Res1, Res2 : boolean;

begin
  Res1 := DeleteExtension('BIN');
  Res2 := DeleteExtension('ELF');

  if Res1 = Res2 then
    Result := True
  else Result := False;
end;

//---AddPrgToTheContextMenu---
procedure AddPrgToTheContextMenu;
begin
  AddContextMenuItem('ELF', 'TURBO DC-TOOL GUI', '&Upload to Dreamcast...', Application.ExeName + ' %1');
  AddContextMenuItem('BIN', 'TURBO DC-TOOL GUI', '&Upload to Dreamcast...', Application.ExeName + ' %1');
end;

//---RemovePrgToTheContextMenu---
procedure RemovePrgToTheContextMenu;
begin
  RemoveContextMenuItem('ELF', 'TURBO DC-TOOL GUI');
  RemoveContextMenuItem('BIN', 'TURBO DC-TOOL GUI');
end;

end.
