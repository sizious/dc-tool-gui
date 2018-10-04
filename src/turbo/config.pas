unit config;

interface

uses
  IniFiles, SysUtils;
  
procedure WriteConfig;
procedure ReadConfig;
procedure WriteUploadConfig;
procedure ReadUploadConfig;
procedure InitControls;

implementation

uses main, options, upload;

//---WriteConfig---
procedure WriteConfig;
begin
  //Connection
  Ini.WriteBool('Connection', 'Serial', Main_Form.rbSerial.Checked);
  Ini.WriteBool('Connection', 'BBA', Main_Form.rbBBA.Checked);

  //Config
  Ini.WriteInteger('Connect Config', 'Baudrate', Main_Form.eBaudrate.ItemIndex);
  Ini.WriteBool('Connect Config', 'Alternate', Main_Form.cbAlternate.Checked);
  Ini.WriteBool('Connect Config', 'COM1', Main_Form.rbCOM1.Checked);
  Ini.WriteBool('Connect Config', 'COM2', Main_Form.rbCOM2.Checked);
  Ini.WriteBool('Connect Config', 'COM3', Main_Form.rbCOM3.Checked);
  Ini.WriteBool('Connect Config', 'COM4', Main_Form.rbCOM4.Checked);
  Ini.WriteString('Connect Config', 'IP', Main_Form.eIP.Text);

  //Options
  Ini.WriteBool('BIN Detection', 'AskOnlyIfScrambled', Main_Form.rbAskOnlyIfScrambled.Checked);
  Ini.WriteBool('BIN Detection', 'AlwaysConfirmDetectionResult', Main_Form.rbAlwaysConfirmDetectionResult.Checked);
  Ini.WriteBool('BIN Detection', 'UnscrambleWithoutPrompt', Main_Form.rbUnscrambleWithoutPrompt.Checked);
  Ini.WriteBool('BIN Detection', 'DontUseThisModule', Main_Form.rbDontUseThisModule.Checked);

  //Options...
  //--Sauver les options...
  Ini.WriteBool('Options', 'CreateFileType', Main_Form.cbFileType.Checked);
  Ini.WriteBool('Options', 'AddContextMenu', Main_Form.cbContextMenu.Checked);

  //--Application les options...
  if Main_Form.cbFileType.Checked = True then
    CreateFileTypes
  else DeleteFileTypes;

  if Main_Form.cbContextMenu.Checked = True then
    AddPrgToTheContextMenu
  else RemovePrgToTheContextMenu;

  //Par défaut, c'est coché (finalement non)
{  if Main_Form.cbContextMenu.Checked = True then
    AddPrgToTheContextMenu;

  if Main_Form.cbFileType.Checked = True then
    CreateFileTypes;  }

  //Location
  Ini.WriteBool('Location', 'Internal', Main_Form.rbInternal.Checked);
  Ini.WriteBool('Location', 'External', Main_Form.rbExternal.Checked);
  Ini.WriteBool('Location', 'ExternalSerial', Main_Form.rbLocSerial.Checked);
  Ini.WriteBool('Location', 'ExternalBBA', Main_Form.rbLocBBA.Checked);
  Ini.WriteString('Location', 'ExternalDCTOOL', Main_Form.eDCTOOL.Text);
  Ini.WriteString('Location', 'ExternalCYGWIN', Main_Form.eCYGWIN.Text);

  //Init... en cas de changements
  InitControls;
end;

//---ReadConfig---
procedure ReadConfig;
begin
  //Connection
  Main_Form.rbSerial.Checked := Ini.ReadBool('Connection', 'Serial', True);
  Main_Form.rbBBA.Checked := Ini.ReadBool('Connection', 'BBA', False);

  //Config
  Main_Form.eBaudrate.ItemIndex := Ini.ReadInteger('Connect Config', 'Baudrate', 7);
  Main_Form.cbAlternate.Checked := Ini.ReadBool('Connect Config', 'Alternate', False);
  Main_Form.rbCOM1.Checked := Ini.ReadBool('Connect Config', 'COM1', True);
  Main_Form.rbCOM2.Checked := Ini.ReadBool('Connect Config', 'COM2', False);
  Main_Form.rbCOM3.Checked := Ini.ReadBool('Connect Config', 'COM3', False);
  Main_Form.rbCOM4.Checked := Ini.ReadBool('Connect Config', 'COM4', False);
  Main_Form.eIP.Text := Ini.ReadString('Connect Config', 'IP', '000.000.000.000');

  //Options
  Main_Form.rbAskOnlyIfScrambled.Checked := Ini.ReadBool('BIN Detection', 'AskOnlyIfScrambled', True);
  Main_Form.rbAlwaysConfirmDetectionResult.Checked := Ini.ReadBool('BIN Detection', 'AlwaysConfirmDetectionResult', False);
  Main_Form.rbUnscrambleWithoutPrompt.Checked := Ini.ReadBool('BIN Detection', 'UnscrambleWithoutPrompt', False);
  Main_Form.rbDontUseThisModule.Checked := Ini.ReadBool('BIN Detection', 'DontUseThisModule', False);

  Main_Form.cbFileType.Checked := Ini.ReadBool('Options', 'CreateFileType', True);
  Main_Form.cbContextMenu.Checked := Ini.ReadBool('Options', 'AddContextMenu', True);

  //Location
  Main_Form.rbInternal.Checked := Ini.ReadBool('Location', 'Internal', True);
  Main_Form.rbExternal.Checked := Ini.ReadBool('Location', 'External', False);
  Main_Form.rbLocSerial.Checked := Ini.ReadBool('Location', 'ExternalSerial', True);
  Main_Form.rbLocBBA.Checked := Ini.ReadBool('Location', 'ExternalBBA', False);
  Main_Form.eDCTOOL.Text := Ini.ReadString('Location', 'ExternalDCTOOL', '');
  Main_Form.eCYGWIN.Text := Ini.ReadString('Location', 'ExternalCYGWIN', '');
end;

//---WriteUploadConfig---
procedure WriteUploadConfig;
begin
  Ini.WriteString('Upload Config', 'CurrentFile', Upload_Form.eFile.Text);
  Ini.WriteBool('Upload Config', 'DoNotAttachConsole', Upload_Form.cbDoNotAttachConsole.Checked);
  Ini.WriteBool('Upload Config', 'UseDumbTerminal', Upload_Form.cbUseDumbTerminal.Checked);
  Ini.WriteBool('Upload Config', 'DoNotClearScreen', Upload_Form.cbDoNotClearScreen.Checked);
  Ini.WriteBool('Upload Config', 'UseChroot', Upload_Form.cbChroot.Checked);
  Ini.WriteString('Upload Config', 'ChrootPath', Upload_Form.eChroot.Text);
  Ini.WriteBool('Upload Config', 'UseISO', Upload_Form.cbISO.Checked);
  Ini.WriteString('Upload Config', 'ISOFile', Upload_Form.eISO.Text);
end;

//---ReadUploadConfig---
procedure ReadUploadConfig;
begin
  Upload_Form.eFile.Text := Ini.ReadString('Upload Config', 'CurrentFile', '');
  Upload_Form.cbDoNotAttachConsole.Checked := Ini.ReadBool('Upload Config', 'DoNotAttachConsole', False);
  Upload_Form.cbUseDumbTerminal.Checked := Ini.ReadBool('Upload Config', 'UseDumbTerminal', False);
  Upload_Form.cbDoNotClearScreen.Checked := Ini.ReadBool('Upload Config', 'DoNotClearScreen', False);
  Upload_Form.cbChroot.Checked := Ini.ReadBool('Upload Config', 'UseChroot', False);
  Upload_Form.eChroot.Text := Ini.ReadString('Upload Config', 'ChrootPath', '');
  Upload_Form.cbISO.Checked := Ini.ReadBool('Upload Config', 'UseISO', False);
  Upload_Form.eISO.Text := Ini.ReadString('Upload Config', 'ISOFile', '');

  //Init Controls...
  InitControls;
end;

//---InitControls---
procedure InitControls;
begin
  //Init des contrôles pour la form Upload.
  if Main_Form.rbBBA.Checked = True then
    Upload_Form.cbUseDumbTerminal.Enabled := False
  else Upload_Form.cbUseDumbTerminal.Enabled := True;

  if FileExists(Upload_Form.eISO.Text) = False then
    Upload_Form.cbISO.Checked := False;

  if DirectoryExists(Upload_Form.eChroot.Text) = False then
    Upload_Form.cbChroot.Checked := False;
end;

end.
