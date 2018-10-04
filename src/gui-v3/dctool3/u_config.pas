unit u_config;

interface

uses
  Windows, SysUtils, IniFiles, DCTool, Classes, Menus, Forms;

const
  CONFIG_FILE : string = 'config.ini';
  
type
  TSaveFile = class
  private
    FIni : TIniFile;
    FDCToolCfg : TFileName;
    FLogCfg : TFileName;
    procedure InitConfig;
  public
    constructor Create;
    destructor Destroy; override;
    
    function ReadBool(Section, Key : string ; Default : boolean = False) : boolean;
    function ReadString(Section, Key : string ; Default : string = '') : string;
    function ReadInteger(Section, Key : string ; Default : integer = 0) : integer;
    procedure WriteBool(Section, Key : string ; Value : boolean);
    procedure WriteString(Section, Key, Value : string);
    procedure WriteInteger(Section, Key : string ; Value : integer);

    procedure SaveConfig;   //sauvegarde la config du compo DCTOOL
    procedure LoadConfig;  //charge la config du composant DCTOOL
    procedure ReadDcToolExes(var ExternalBBA, ExternalSerial, ExternalUSB : boolean ;
      var exeBBA, exeSerial, exeUSB : string);
    procedure WriteDcToolExes(ExternalBBA, ExternalSerial, ExternalUSB : boolean ;
      exeBBA, exeSerial, exeUSB : string);
    procedure LoadOptions;
    procedure SaveOptions;
    procedure SaveHightlight;
    procedure LoadHightlight;
  end;

implementation

uses
  Main, IpCfg, Utils, u_dctool_wrapper, Config, DcToolCygWinCfg, BinCheck,
  Upload, u_dctool_binchk, options;

const
  DCTOOL_CFG  : string = 'driver.ini';
  LOG_CFG     : string = 'logcfg.ini';

{ TSaveFile }

procedure TSaveFile.InitConfig;
begin
  //PREMIER LANCEMENT
  if not DirectoryExists(GetConfigDir) then ForceDirectories(GetConfigDir);

  //mettre les executables de DC-TOOL par défaut (les internes)
  Main_Form.DCTool.BroadBand.Executable := GetCompleteFileName(dfBBA);
  Main_Form.DCTool.Serial.Executable := GetCompleteFileName(dfSerial);
  Main_Form.DCTool.USB.Executable := GetCompleteFileName(dfUSB);

  //Composant CygWin
  Main_Form.DcToolCygWinCfg.InternalDcToolPath := GetDcToolPath;
  Main_Form.DcToolCygWinCfg.CustomDcToolPaths.Update;
end;

procedure TSaveFile.SaveConfig;
begin
  Main_Form.DCTool.SaveToFile(FDCToolCfg);
  Main_Form.reLog.SaveCfgToFile(FLogCfg);

  FIni.WriteInteger('Cygwin', 'Config', Integer(Main_Form.DcToolCygWinCfg.Config));
  FIni.WriteString('Cygwin', 'CygWinExternalPath', Main_Form.DcToolCygWinCfg.CygWinExternalPath);
end;

procedure TSaveFile.LoadConfig;
var
  MI : TMenuItem;

begin
  Main_Form.reLog.LoadCfgToFile(FLogCfg);

  if FileExists(FDCToolCfg) then
  begin
    Main_Form.DCTool.LoadFromFile(FDCToolCfg);

    //*** Sélectionner le type de connexion. ***
    MI := TMenuItem(Main_Form.FindComponent('LinkType'
      + IntToStr(Integer(Main_Form.DCTool.ConnectionType))));
    MI.Click;

    //***SERIAL***

    //Sélectionner le baudrate
    MI := TMenuItem(Main_Form.FindComponent('Baudrate'
      + IntToStr(Integer(Main_Form.DCTool.Serial.Baudrate))));
    MI.Click;

    //Sélectionner le port COM
    MI := TMenuItem(Main_Form.FindComponent('COM'
      + IntToStr(Integer(Main_Form.DCTool.Serial.ComPort))));
    MI.Click;

    //BBA IP
    //IpCfg_Form.eIP.Text := Main_Form.DCTool.BroadBand.IPAddress;

    //Alternate baudrate
    Main_Form.miAlternateBaudrate.Checked := Main_Form.DCTool.Serial.AlternateBaudrate;

    //*** Options ***
    Main_Form.miUseDumbTerminal.Checked := Main_Form.DCTool.Options.UseDumbTerminal;
    Main_Form.miAttachConsoleAndFileserver.Checked := Main_Form.DCTool.Options.AttachFileServer;
    Main_Form.miClearScreenBeforeDownload.Checked :=  Main_Form.DCTool.Options.ClrScrBeforeDownload;
    Main_Form.miFileInUseProtectionForUpload.Checked := Main_Form.DCTool.UploadOptions.FileInUseProtection;
  end;

  //Config CygWin
  Main_Form.DcToolCygWinCfg.Config := TCygConfig(FIni.ReadInteger('Cygwin', 'Config', 0));
  Main_Form.DcToolCygWinCfg.CygWinExternalPath := FIni.ReadString('Cygwin', 'CygWinExternalPath', '');

  //Config BinCheck
  Upload_Form.SetBinCheckCfg(TBinCheckMode(FIni.ReadInteger('BINCHECK', 'DetectionMode', 0)));

  //Chargement des options.
  SetDefaultWorkDir(FIni.ReadString('Options', 'WorkingDir', GetAppDir));
end;

constructor TSaveFile.Create;
begin
  try
    InitConfig;
    
    FIni := TIniFile.Create(GetConfigDir + CONFIG_FILE);
    FDCToolCfg := GetConfigDir + DCTOOL_CFG;
    FLogCfg := GetConfigDir + LOG_CFG;

    //msgbox(0, FIni.FileName, '', 0);
  except
    MsgBox(0, 'Exception in TSaveFile.Create()', 'Error', 16 + MB_SYSTEMMODAL);
  end;
end;

destructor TSaveFile.Destroy;
begin
  if Assigned(FIni) then FIni.Free;
  inherited;
end;

function TSaveFile.ReadBool(Section, Key: string ; Default : boolean): boolean;
begin
  Result := FIni.ReadBool(Section, Key, Default);
end;

function TSaveFile.ReadString(Section, Key: string ; Default : string): string;
begin
  Result := FIni.ReadString(Section, Key, Default);
end;

function TSaveFile.ReadInteger(Section, Key: string ; Default : integer): integer;
begin
  Result := FIni.ReadInteger(Section, Key, Default);
end;

//---ReadDcToolExes---
//Permet de lire la section contenant les infos pour les EXE DC-TOOL.
//ExternalBBA, ExternalSERIAL et ExternalUSB contiennent l'info qui sert à
//déterminer si le programme est interne ou externe.
//Si il est interne, alors la variable ExternalQQCH = FALSE. Sinon, si il est externe,
//ExternalQQCH = TRUE et le string correspondant, exeBBA, exeSerial ou exeUSB est
//différent de '' obligatoirement (enfin en gros, un executable devra être trouvé
//quand même!).
procedure TSaveFile.ReadDcToolExes(var ExternalBBA, ExternalSerial, ExternalUSB: boolean;
  var exeBBA, exeSerial, exeUSB: string);
begin
  //Interne (False) ou Externe (True) ?
  ExternalBBA := FIni.ReadBool('Executables', 'ExternalBBA', False);
  ExternalSerial := FIni.ReadBool('Executables', 'ExternalSerial', False);
  ExternalUSB := FIni.ReadBool('Executables', 'ExternalUSB', False);

  //Une chaine de caractère contenant l'EXE
  exeBBA := FIni.ReadString('Executables', 'CustomExeBBA', '');
  exeSerial := FIni.ReadString('Executables', 'CustomExeSerial', '');
  exeUSB := FIni.ReadString('Executables', 'CustomExeUSB', '');
end;

procedure TSaveFile.WriteDcToolExes(ExternalBBA, ExternalSerial, ExternalUSB: boolean;
  exeBBA, exeSerial, exeUSB: string);
begin
  FIni.WriteBool('Executables', 'ExternalBBA', ExternalBBA);
  FIni.WriteBool('Executables', 'ExternalSerial', ExternalSerial);
  FIni.WriteBool('Executables', 'ExternalUSB', ExternalUSB);

  //Une chaine de caractère contenant l'EXE va être enregistrée dans le fichier.
  FIni.WriteString('Executables', 'CustomExeBBA', exeBBA);
  FIni.WriteString('Executables', 'CustomExeSerial', exeSerial);
  FIni.WriteString('Executables', 'CustomExeUSB', exeUSB);
end;

procedure TSaveFile.WriteInteger(Section, Key: string; Value: integer);
begin
  FIni.WriteInteger(Section, Key, Value);
end;

procedure TSaveFile.WriteString(Section, Key, Value: string);
begin
  FIni.WriteString(Section, Key, Value);
end;

procedure TSaveFile.WriteBool(Section, Key: string; Value: boolean);
begin
  FIni.WriteBool(Section, Key, Value);
end;

procedure TSaveFile.LoadOptions;
begin
  Options_Form.rgUploadTabs.ItemIndex := FIni.ReadInteger('Options', 'UploadTabs', 0);
  Options_Form.rgDownloadTabs.ItemIndex := FIni.ReadInteger('Options', 'DownloadTabs', 0);
  Options_Form.cbxWorkDir.Text := FIni.ReadString('Options', 'WorkingDir', GetAppDir);
  Options_Form.cbxUploadClean.Checked := FIni.ReadBool('Options', 'UploadClean', True);
  Options_Form.cbxDownloadClean.Checked := FIni.ReadBool('Options', 'DownloadClean', False);
  Options_Form.cbxShowSplash.Checked := FIni.ReadBool('Options', 'ShowSplash', True);
end;

procedure TSaveFile.SaveOptions;
//var
//  i : integer;

begin
  FIni.WriteInteger('Options', 'UploadTabs', Options_Form.rgUploadTabs.ItemIndex);
  FIni.WriteInteger('Options', 'DownloadTabs', Options_Form.rgDownloadTabs.ItemIndex);
  FIni.WriteString('Options', 'WorkingDir', Options_Form.cbxWorkDir.Text);
  FIni.WriteBool('Options', 'UploadClean', Options_Form.cbxUploadClean.Checked);
  FIni.WriteBool('Options', 'DownloadClean', Options_Form.cbxDownloadClean.Checked);
  FIni.WriteBool('Options', 'ShowSplash', Options_Form.cbxShowSplash.Checked);
end;

procedure TSaveFile.LoadHightlight;
var
  i : integer;
  
begin
  for i := 0 to Main_Form.seOutputs.Highlighter.AttrCount - 1 do
  begin
    Main_Form.seOutputs.Highlighter.Attribute[i].Foreground :=
      FIni.ReadInteger('SynEdit', 'Foreground' + IntToStr(i),
        Main_Form.seOutputs.Highlighter.Attribute[i].Foreground);
    Main_Form.seOutputs.Highlighter.Attribute[i].Background :=
      FIni.ReadInteger('SynEdit', 'Background' + IntToStr(i),
        Main_Form.seOutputs.Highlighter.Attribute[i].Background);
    Main_Form.seOutputs.Highlighter.Attribute[i].IntegerStyle :=
      FIni.ReadInteger('SynEdit', 'Style' + IntToStr(i),
        Main_Form.seOutputs.Highlighter.Attribute[i].IntegerStyle);
  end;
end;

procedure TSaveFile.SaveHightlight;
var
  i : integer;
  
begin
  for i := 0 to Main_Form.seOutputs.Highlighter.AttrCount - 1 do
  begin
    FIni.WriteInteger('SynEdit', 'Foreground' + IntToStr(i),
      Main_Form.seOutputs.Highlighter.Attribute[i].Foreground);
    FIni.WriteInteger('SynEdit', 'Background' + IntToStr(i),
      Main_Form.seOutputs.Highlighter.Attribute[i].Background);
    FIni.WriteInteger('SynEdit', 'Style' + IntToStr(i),
      Main_Form.seOutputs.Highlighter.Attribute[i].IntegerStyle);
  end;
end;

end.
