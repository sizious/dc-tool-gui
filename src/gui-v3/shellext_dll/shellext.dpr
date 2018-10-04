library shellext;

uses
  SysUtils,
  Classes,
  regext in 'regext.pas',
  regshell in 'regshell.pas',
  main in 'main.pas',
  regutils in 'regutils.pas';

{$R *.res}
{$R icons.RES}   

exports
  RegisterBinariesExts,
  UnregisterBinariesExts,
  RegisterPresetsExts,
  UnregisterPresetsExts,
  RegisterBinariesMenu,
  UnregisterBinariesMenu,
  RegisterPresetsMenu,
  UnregisterPresetsMenu,
  IsBinariesExtRegistered,
  IsBinariesMenuRegistered,
  IsPresetsMenuRegistered,
  IsPresetsExtRegistered,
  IsImmediatePresetExec,
  IsImmediateBinariesExec;

begin
 
end.
