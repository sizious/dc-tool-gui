unit download;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvBaseDlg, JvBrowseFolder, StdCtrls, Buttons, ComCtrls,
  JvComponent;
                    
type
  TDownload_Form = class(TForm)
    Bevel1: TBevel;
    pcDownload: TPageControl;
    tsFile: TTabSheet;
    Label1: TLabel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    bFile: TBitBtn;
    cbxTargetFile: TComboBox;
    tsPreset: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    GroupBox6: TGroupBox;
    bPresetOpen: TBitBtn;
    GroupBox7: TGroupBox;
    bPresetSave: TBitBtn;
    GroupBox8: TGroupBox;
    cbxPresets: TComboBox;
    tcWorkingdir: TTabSheet;
    Label4: TLabel;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    Bevel5: TBevel;
    bWorkdir: TBitBtn;
    cbxWorkdir: TComboBox;
    cbWorkdir: TCheckBox;
    tsOptions: TTabSheet;
    Label9: TLabel;
    Label10: TLabel;
    bDownload: TBitBtn;
    bCancel: TBitBtn;
    odWorkdir: TJvBrowseForFolderDialog;
    Shape1: TShape;
    Bevel7: TBevel;
    Image1: TImage;
    Label11: TLabel;
    Label14: TLabel;
    GroupBox3: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    BitBtn3: TBitBtn;
    odPresets: TOpenDialog;
    sdPresets: TSaveDialog;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    eSize: TEdit;
    GroupBox5: TGroupBox;
    eAddr: TEdit;
    bAddr: TBitBtn;
    bSize: TBitBtn;
    sdFile: TSaveDialog;
    procedure bDownloadClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure bPresetOpenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbWorkdirClick(Sender: TObject);
    procedure bWorkdirClick(Sender: TObject);
    procedure bPresetSaveClick(Sender: TObject);
    procedure bAddrClick(Sender: TObject);
    procedure bSizeClick(Sender: TObject);
    procedure bFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
    procedure LoadHistories;
    procedure SaveHistories;
    procedure CleanControls;
  public
    { Déclarations publiques }
    CmdLineFileLoad : boolean;
  end;

var
  Download_Form: TDownload_Form;

implementation

{$R *.dfm}

uses
  Utils, U_Preset, DCTool, HistMgr, options, main;
  
procedure TDownload_Form.bDownloadClick(Sender: TObject);
var
  CanDo : integer;

begin

  //Vérification si le fichier cible existe. Si oui, faut le remplacer ?
  if FileExists(cbxTargetFile.Text) then
  begin
    CanDo := MsgBox(Handle, 'The target file exists. Overwrite ?', 'Warning', 48
      + MB_YESNO);
    if CanDo = IDNO then Exit;
  end;

  //Vérification si le WorkDir est coché, si oui, on va vérifier le dossier.
  if cbWorkDir.Checked then
    if not CheckDirectory(Handle, cbxWorkdir.Text, 'working dir') then Exit;

  //taille valide ?
  try
    StrToInt(eSize.Text);
  except
    MsgBox(Handle, 'Invalid size !'
      + WrapStr + 'Aborted.', 'Warning', 48);
    Exit;
  end;

  //Taille <> de 0 ?
  if eSize.Text = '0' then
  begin
    MsgBox(Handle, 'Size can''t be 0.'
      + WrapStr + 'Please change the size'
        + ' now in "Options" tab.', 'Warning', 48);
    Exit;
  end;

  //Sauver les historiques.
  SaveHistories;

  ModalResult := mrOK;
end;

procedure TDownload_Form.BitBtn3Click(Sender: TObject);
begin
  if odPresets.Execute then
    cbxPresets.Text := odPresets.FileName;
end;

procedure TDownload_Form.bPresetOpenClick(Sender: TObject);
var
  Preset : TPreset;
  Res    : boolean;

begin
  if not FileExists(cbxPresets.Text) then
  begin
    MsgBox(Handle, 'Preset file not found. File : "' + ExtractFileName(cbxPresets.Text)
      + '".', 'Warning', 48);
    Exit;
  end;

  Res := LoadPreset(cbxPresets.Text, Preset);

  if Res then
    if (Preset.Operation = otDownload) then
      MsgBox(Handle, 'Preset loaded successfully.', 'Information', 64)
    else begin
      MsgBox(Handle, 'This preset isn''t for download operation. Aborted.', 'Warning', 48);
      Exit;
    end
  else begin
    MsgBox(Handle, 'Preset load failed !', 'Warning', 48);
    Exit;
  end;

  //Modifier tous les contrôles.
  cbxTargetFile.Text := Preset.TargetFile;
  cbWorkdir.Checked := Preset.WorkDirUse;
  cbxWorkdir.Text := Preset.WorkDir;
  eAddr.Text := Preset.Address;
  eSize.Text := Preset.OpDlSize;
end;

//---LoadHistories---
//Charger les historiques dans les ComboBoxs.
procedure TDownload_Form.LoadHistories;
begin
  //Charger la liste des fichiers de toutes les combos.
  LoadHistoryToCombo(Handle, HMTargetFile, cbxTargetFile);
  LoadHistoryToCombo(Handle, HMPresets, cbxPresets);
  LoadHistoryToCombo(Handle, HMWorkingDir, cbxWorkdir);
end;

//---SaveHistories---
//Sauvegarder les historiques dans les ComboBoxs.
procedure TDownload_Form.SaveHistories;
begin
  //Sauver la liste des fichiers de toutes les combos.
  SaveHistoryToCombo(Handle, HMTargetFile, cbxTargetFile);
  SaveHistoryToCombo(Handle, HMPresets, cbxPresets);
  SaveHistoryToCombo(Handle, HMWorkingDir, cbxWorkdir);
end;

procedure TDownload_Form.FormShow(Sender: TObject);
begin
  if not CmdLineFileLoad then
    //effacer tous les controles..
    if not Options_Form.cbxDownloadClean.Checked then
      CleanControls;

  //Sélectionner la bonne page
  case Options_Form.rgDownloadTabs.ItemIndex of
    0 : pcDownload.ActivePageIndex := 0;
    1 : pcDownload.ActivePageIndex := 1;
  end;

  LoadHistories;

  //Activer la fiche (pour que lorsqu'on clique dans l'exploreur ça active l'application).
  SetWindowFocus(Handle);
end;

procedure TDownload_Form.cbWorkdirClick(Sender: TObject);
begin
  cbxWorkdir.Enabled := cbWorkdir.Checked;
  bWorkdir.Enabled := cbWorkdir.Checked;
end;

procedure TDownload_Form.bWorkdirClick(Sender: TObject);
begin
  if odWorkdir.Execute then
    cbxWorkdir.Text := odWorkdir.Directory;
end;

procedure TDownload_Form.bPresetSaveClick(Sender: TObject);
var
  Preset : TPreset;

begin
  if sdPresets.Execute then
  begin
    //Le preset est commum aux deux opérations pour pas me casser les couilles...
    
    Preset.Operation := otDownload;
    Preset.TargetFile := cbxTargetFile.Text;
    Preset.WorkDirUse := cbWorkdir.Checked;
    Preset.WorkDir := cbxWorkdir.Text;
    Preset.Address := eAddr.Text;
    Preset.OpDlSize := eSize.Text;

    if SavePreset(sdPresets.FileName, Preset) then
      MsgBox(Handle, 'Preset saved as "' + ExtractFileName(sdPresets.FileName) + '".',
        'Information', 64)
    else
      MsgBox(Handle, 'Preset save failed !', 'Warning', 48);
    
  end;

end;

procedure TDownload_Form.CleanControls;
begin
  Self.cbxTargetFile.Clear;
  Self.cbxPresets.Clear;
  Self.cbWorkdir.Checked := False;
  Self.cbxWorkdir.Clear;
  Self.bAddr.Click;
  Self.bSize.Click;
end;

procedure TDownload_Form.bAddrClick(Sender: TObject);
begin
  eAddr.Text := Main_Form.DCTool.DownloadOptions.GetDefaultAddress;
end;

procedure TDownload_Form.bSizeClick(Sender: TObject);
begin
  eSize.Text := IntToStr(Main_Form.DCTool.DownloadOptions.GetDefaultDownloadSize);
end;

procedure TDownload_Form.bFileClick(Sender: TObject);
begin
  if sdFile.Execute then
    cbxTargetFile.Text := sdFile.FileName;
end;

procedure TDownload_Form.FormCreate(Sender: TObject);
begin
  CmdLineFileLoad := False;
end;

procedure TDownload_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CmdLineFileLoad := False;
end;

end.
