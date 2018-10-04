unit main;

interface

uses
  Windows, SysUtils, RegExt, RegShell, Registry;

const
  ELF_EXT   : string = 'ELF';
  BIN_EXT   : string = 'BIN';
  DPU_EXT   : string = 'DPU';
  DPD_EXT   : string = 'DPD';
  ELF_DESC  : string = 'Executable and Linkable Format';
  BIN_DESC  : string = 'Generic Binary File';
  DPU_DESC  : string = 'DC-TOOL GUI Upload Preset';
  DPD_DESC  : string = 'DC-TOOL GUI Download Preset';
  ELF_ICON  : integer = 0;
  BIN_ICON  : integer = 1;
  DPU_ICON  : integer = 2;
  DPD_ICON  : integer = 3;

  APP_NAME  : string = 'DC-TOOL GUI';

  ELF_MENU  : string = '&Upload to Dreamcast';
  BIN_MENU  : string = '&Upload to Dreamcast';
  DPU_MENU  : string = '&Open';
  DPD_MENU  : string = '&Open';


procedure RegisterBinariesExts; stdcall; export;
procedure UnregisterBinariesExts; stdcall; export;
procedure RegisterPresetsExts; stdcall; export;
procedure UnregisterPresetsExts; stdcall; export;
procedure RegisterBinariesMenu(AppLocation : PChar ; Prompt : boolean); stdcall; export;
procedure UnregisterBinariesMenu; stdcall; export;
procedure RegisterPresetsMenu(AppLocation : PChar ; Prompt : boolean); stdcall; export;
procedure UnregisterPresetsMenu; stdcall; export;
function IsBinariesExtRegistered : boolean; stdcall; export;
function IsBinariesMenuRegistered : boolean; stdcall; export;
function IsPresetsMenuRegistered : boolean; stdcall; export;
function IsPresetsExtRegistered : boolean; stdcall; export;
function IsImmediatePresetExec : boolean; stdcall; export;
function IsImmediateBinariesExec : boolean; stdcall; export;

implementation

uses
  RegUtils;

//==============================================================================
//==============================================================================

function Sto_GetModuleName: String;
var
  szFileName: array[0..MAX_PATH] of Char;

begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

//------------------------------------------------------------------------------

function GetIconIndex(Index : integer) : string;
begin
  Result := Sto_GetModuleName + ',' + IntToStr(Index);
end;

//------------------------------------------------------------------------------

function IsImmediate(Extension : string) : boolean;
var
  RG : TRegistry;
  ExtID,
  Line : string;

begin
  Result := False;
  if Extension = '' then Exit;

  Extension := GetRealExt(Extension);

  RG := TRegistry.Create;
  try
    ExtID := '';
    RG.RootKey := HKEY_CLASSES_ROOT;

    //***Recuperation de l'ID de l'extension.
    ExtID := GetExtensionID(RG, Extension, True);
    if ExtID = '' then Exit;

    if not RG.OpenKey(ExtID + '\Shell\' + APP_NAME + '\Command', False) then Exit;

    Line := RG.ReadString('');
    Result := Pos('/prompt', PChar(Line)) <> 0;
    //si Pos renvoie une valeur differente de 0 alors la chaine est dans la
    //ligne de commande
  finally
    RG.Free;
  end;
end;

//==============================================================================
//==============================================================================

function IsBinariesMenuRegistered : boolean; stdcall; export;
begin
  Result := ContextMenuExists(BIN_EXT, APP_NAME)
    and ContextMenuExists(ELF_EXT, APP_NAME);
end;

//------------------------------------------------------------------------------

function IsBinariesExtRegistered : boolean; stdcall; export;
begin
  Result := IsAlreadySet(BIN_EXT, BIN_DESC) and IsAlreadySet(ELF_EXT, ELF_DESC);
end;

//------------------------------------------------------------------------------

function IsPresetsMenuRegistered : boolean; stdcall; export;
begin
  Result := ContextMenuExists(DPD_EXT, APP_NAME)
    and ContextMenuExists(DPU_EXT, APP_NAME);
end;

//------------------------------------------------------------------------------

function IsPresetsExtRegistered : boolean; stdcall; export;
begin
  Result := IsAlreadySet(DPD_EXT, DPD_DESC) and IsAlreadySet(DPU_EXT, DPU_DESC);
end;

//------------------------------------------------------------------------------

procedure RegisterBinariesExts; stdcall; export;
begin
  CreateExtension(ELF_EXT, ELF_DESC, GetIconIndex(ELF_ICON));
  CreateExtension(BIN_EXT, BIN_DESC, GetIconIndex(BIN_ICON));
end;

//------------------------------------------------------------------------------

procedure UnregisterBinariesExts; stdcall; export;
begin
  DeleteExtension(ELF_EXT);
  DeleteExtension(BIN_EXT);
end;

//------------------------------------------------------------------------------

procedure RegisterPresetsExts; stdcall; export;
begin
  CreateExtension(DPU_EXT, DPU_DESC, GetIconIndex(DPU_ICON));
  CreateExtension(DPD_EXT, DPD_DESC, GetIconIndex(DPD_ICON));
end;

//------------------------------------------------------------------------------

procedure UnregisterPresetsExts; stdcall; export;
begin
  DeleteExtension(DPU_EXT);
  DeleteExtension(DPD_EXT);
end;

//------------------------------------------------------------------------------

procedure RegisterBinariesMenu(AppLocation : PChar ; Prompt : boolean); stdcall; export;
var
  Line : string;

begin
  if Prompt then
    Line := ' /prompt';

  AddContextMenuItem(ELF_EXT, APP_NAME, ELF_MENU, AppLocation + ' "%1"' + Line);
  AddContextMenuItem(BIN_EXT, APP_NAME, BIN_MENU, AppLocation + ' "%1"' + Line);
end;

//------------------------------------------------------------------------------

procedure UnregisterBinariesMenu; stdcall; export;
begin
  RemoveContextMenuItem(ELF_EXT, APP_NAME);
  RemoveContextMenuItem(BIN_EXT, APP_NAME);
end;

//------------------------------------------------------------------------------

procedure RegisterPresetsMenu(AppLocation : PChar ; Prompt : boolean); stdcall; export;
var
  Line : string;

begin
  if Prompt then
    Line := ' /prompt';
    
  AddContextMenuItem(DPD_EXT, APP_NAME, DPD_MENU, AppLocation + ' "%1"' + Line);
  AddContextMenuItem(DPU_EXT, APP_NAME, DPU_MENU, AppLocation + ' "%1"' + Line);
end;

//------------------------------------------------------------------------------

procedure UnregisterPresetsMenu; stdcall; export;
begin
  RemoveContextMenuItem(DPU_EXT, APP_NAME);
  RemoveContextMenuItem(DPD_EXT, APP_NAME);
end;

//------------------------------------------------------------------------------

function IsImmediatePresetExec : boolean; stdcall; export;
begin
  Result := IsImmediate(DPU_EXT) and IsImmediate(DPD_EXT);
end;

//------------------------------------------------------------------------------

function IsImmediateBinariesExec : boolean; stdcall; export;
begin
  Result := IsImmediate(ELF_EXT) and IsImmediate(BIN_EXT);
end;

//------------------------------------------------------------------------------

end.
