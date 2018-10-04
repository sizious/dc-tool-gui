unit u_shellext_wrapper;

interface

procedure RegisterBinariesExts; stdcall; external 'shellext.dll';
procedure UnregisterBinariesExts; stdcall; external 'shellext.dll';
procedure RegisterPresetsExts; stdcall; external 'shellext.dll';
procedure UnregisterPresetsExts; stdcall; external 'shellext.dll';
procedure RegisterBinariesMenu(AppLocation : PChar ; Prompt : boolean); stdcall; external 'shellext.dll';
procedure UnregisterBinariesMenu; stdcall; external 'shellext.dll';
procedure RegisterPresetsMenu(AppLocation : PChar ; Prompt : boolean); stdcall; external 'shellext.dll';
procedure UnregisterPresetsMenu; stdcall; external 'shellext.dll';
function IsBinariesExtRegistered : boolean; stdcall; external 'shellext.dll';
function IsBinariesMenuRegistered : boolean; stdcall; external 'shellext.dll';
function IsPresetsMenuRegistered : boolean; stdcall; external 'shellext.dll';
function IsPresetsExtRegistered : boolean; stdcall; external 'shellext.dll';
function IsImmediatePresetExec : boolean; stdcall; external 'shellext.dll';
function IsImmediateBinariesExec : boolean; stdcall; external 'shellext.dll';

implementation

end.