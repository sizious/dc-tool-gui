unit upload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, JvBaseDlg, JvBrowseFolder,
  U_History, DCTool, JvComponent, U_dctool_binchk, U_Preset;

type
  TUpload_Form = class(TForm)
    pcUpload: TPageControl;
    tsFile: TTabSheet;
    tsIso: TTabSheet;
    tsChroot: TTabSheet;
    tcWorkingdir: TTabSheet;
    Bevel1: TBevel;
    bUpload: TBitBtn;
    bCancel: TBitBtn;
    GroupBox1: TGroupBox;
    bFile: TBitBtn;
    cbExecute: TCheckBox;
    Bevel2: TBevel;
    GroupBox2: TGroupBox;
    bChroot: TBitBtn;
    GroupBox3: TGroupBox;
    bIso: TBitBtn;
    GroupBox4: TGroupBox;
    bWorkdir: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cbxTargetFile: TComboBox;
    cbxIso: TComboBox;
    cbxChroot: TComboBox;
    cbxWorkdir: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Bevel3: TBevel;
    cbIso: TCheckBox;
    Bevel4: TBevel;
    cbChroot: TCheckBox;
    Bevel5: TBevel;
    cbWorkdir: TCheckBox;
    odFile: TOpenDialog;
    odIso: TOpenDialog;
    odChroot: TJvBrowseForFolderDialog;
    odWorkdir: TJvBrowseForFolderDialog;
    tsOptions: TTabSheet;
    Label9: TLabel;
    GroupBox5: TGroupBox;
    eAddr: TEdit;
    Label10: TLabel;
    bAddr: TBitBtn;
    Bevel6: TBevel;
    cbAddr: TCheckBox;
    tsPreset: TTabSheet;
    GroupBox6: TGroupBox;
    bPresetOpen: TBitBtn;
    Label12: TLabel;
    Label13: TLabel;
    GroupBox7: TGroupBox;
    bPresetSave: TBitBtn;
    GroupBox8: TGroupBox;
    cbxPresets: TComboBox;
    GroupBox9: TGroupBox;
    cbDisBinChk: TCheckBox;
    GroupBox10: TGroupBox;
    cbDisableCopyProtection: TCheckBox;
    Shape1: TShape;
    Bevel7: TBevel;
    Image1: TImage;
    Label11: TLabel;
    Label14: TLabel;
    sdPresets: TSaveDialog;
    bOpenPreset: TBitBtn;
    odPresets: TOpenDialog;
    procedure bCancelClick(Sender: TObject);
    procedure cbIsoClick(Sender: TObject);
    procedure cbChrootClick(Sender: TObject);
    procedure cbWorkdirClick(Sender: TObject);
    procedure bIsoClick(Sender: TObject);
    procedure bFileClick(Sender: TObject);
    procedure bChrootClick(Sender: TObject);
    procedure bWorkdirClick(Sender: TObject);
    procedure bAddrClick(Sender: TObject);
    procedure cbAddrClick(Sender: TObject);
    procedure bUploadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bPresetSaveClick(Sender: TObject);
    procedure bOpenPresetClick(Sender: TObject);
    procedure bPresetOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
    //Gestion des historiques
    procedure LoadHistories;   //juste pour cette form.
    procedure SaveHistories;
  public
    { Déclarations publiques }
    CmdLineFileLoad : boolean;
    
    //interet de ça plutot que la variable normale ?
    //eviter de modifier n'importe comment la variable
    //faire une copie de la variable.
    function GetBinCheckCfg : TBinCheckMode;
    procedure SetBinCheckCfg(NewMode : TBinCheckMode);
    procedure CleanControls;
    function ApplyPreset(FileName : string ; var Preset : TPreset) : TApplyPresetResult;
  end;

var
  Upload_Form: TUpload_Form;

implementation

{$R *.dfm}

uses
  Main, Utils, HistMgr, options;

var
  DetectionModeSelected : TBinCheckMode = bmAskIfNeeded;

//------------------------------------------------------------------------------

procedure TUpload_Form.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TUpload_Form.cbIsoClick(Sender: TObject);
begin
  bIso.Enabled := cbIso.Checked;
  cbxIso.Enabled := cbIso.Checked;
end;

procedure TUpload_Form.cbChrootClick(Sender: TObject);
begin
  cbxChroot.Enabled := cbChroot.Checked;
  bChroot.Enabled := cbChroot.Checked;
end;

procedure TUpload_Form.cbWorkdirClick(Sender: TObject);
begin
  cbxWorkdir.Enabled := cbWorkdir.Checked;
  bWorkdir.Enabled := cbWorkdir.Checked;
end;

procedure TUpload_Form.bIsoClick(Sender: TObject);
begin
  if odIso.Execute then
    cbxIso.Text := odIso.FileName;
end;

procedure TUpload_Form.bFileClick(Sender: TObject);
begin
  if odFile.Execute then
    cbxTargetFile.Text := odFile.FileName;
end;

procedure TUpload_Form.bChrootClick(Sender: TObject);
begin
  if odChroot.Execute then
    cbxChroot.Text := odChroot.Directory;
end;

procedure TUpload_Form.bWorkdirClick(Sender: TObject);
begin
  if odWorkdir.Execute then
    cbxWorkdir.Text := odWorkdir.Directory;
end;

procedure TUpload_Form.bAddrClick(Sender: TObject);
begin
  eAddr.Text := Main_Form.DCTool.UploadOptions.GetDefaultAddress;
end;

procedure TUpload_Form.cbAddrClick(Sender: TObject);
begin
  eAddr.Enabled := cbAddr.Checked;
  bAddr.Enabled := cbAddr.Checked;
end;

procedure TUpload_Form.bUploadClick(Sender: TObject);
var
  Target : string;

begin
  Target := cbxTargetFile.Text;

  if not CheckFileName(Handle, Target, 'target upload') then Exit;

  if cbIso.Checked then
    if not CheckFileName(Handle, cbxIso.Text, 'ISO9660 redirection') then Exit;

  if cbChroot.Checked then
    if not CheckDirectory(Handle, cbxChroot.Text, 'chroot') then Exit;

  if cbWorkDir.Checked then
    if not CheckDirectory(Handle, cbxWorkdir.Text, 'working dir') then Exit;

  //Sauver les historiques
  SaveHistories;

  //On va verifier si le BIN est unscrambled.
  if LowerCase(ExtractFileExt(Target)) = '.bin' then
    if not DoBinCheckSequence(DetectionModeSelected, Handle, Target) then Exit;
    
  ModalResult := mrOK;
end;

procedure TUpload_Form.FormShow(Sender: TObject);
begin
  if not CmdLineFileLoad then
  begin
    //effacer tous les controles..
    if not Options_Form.cbxUploadClean.Checked then
      Upload_Form.CleanControls;
  end;
    
  //Sélectionner la bonne page
  case Options_Form.rgUploadTabs.ItemIndex of
    0 : pcUpload.ActivePageIndex := 0;
    1 : pcUpload.ActivePageIndex := 1;
  end;

  //Si le mec n'a pas coché FileInUse on va désactiver l'option "Désactiver FileInUse".
  cbDisableCopyProtection.Enabled := Main_Form.miFileInUseProtectionForUpload.Checked;

  LoadHistories;

  //Activer la fiche (pour que lorsqu'on clique dans l'exploreur ça active l'application)
  SetWindowFocus(Handle);
end;

//------------------------------------------------------------------------------

//---LoadHistories---
//Charger les historiques dans les ComboBoxs.
procedure TUpload_Form.LoadHistories;
begin
  //Charger la liste des fichiers de toutes les combos.
  LoadHistoryToCombo(Handle, HMTargetFile, cbxTargetFile);
  LoadHistoryToCombo(Handle, HMPresets, cbxPresets);
  LoadHistoryToCombo(Handle, HMIsoRedirect, cbxISO);
  LoadHistoryToCombo(Handle, HMChroot, cbxChroot);
  LoadHistoryToCombo(Handle, HMWorkingDir, cbxWorkdir);
end;

//---SaveHistories---
//Sauvegarder les historiques dans les ComboBoxs.
procedure TUpload_Form.SaveHistories;
begin
  //Sauver la liste des fichiers de toutes les combos.
  SaveHistoryToCombo(Handle, HMTargetFile, cbxTargetFile);
  SaveHistoryToCombo(Handle, HMPresets, cbxPresets);
  SaveHistoryToCombo(Handle, HMIsoRedirect, cbxISO);
  SaveHistoryToCombo(Handle, HMChroot, cbxChroot);
  SaveHistoryToCombo(Handle, HMWorkingDir, cbxWorkdir);
end;

procedure TUpload_Form.bPresetSaveClick(Sender: TObject);
var
  Preset : TPreset;
  Opt    : TOperationType;

begin
  if sdPresets.Execute then
  begin
    //Le preset est commum aux deux opérations pour pas me casser les couilles...

    if cbExecute.Checked then
      Opt := otUploadExecute
    else Opt := otUpload;

    Preset.Operation := Opt;
    Preset.TargetFile := cbxTargetFile.Text;
    Preset.IsoUse := cbIso.Checked;
    Preset.IsoFile := cbxIso.Text;
    Preset.ChrootUse := cbChroot.Checked;
    Preset.ChrootDir := cbxChroot.Text;
    Preset.WorkDirUse := cbWorkdir.Checked;
    Preset.WorkDir := cbxWorkdir.Text;
    //Preset.UploadExec := cbExecute.Checked;
    Preset.UseAddress := cbAddr.Checked;
    Preset.Address := eAddr.Text;
    //if not cbDisableCopyProtection.Checked then
    //  Bool := Main_Form.miFileInUseProtectionForUpload.Checked
    //else Bool := False; //ça désactive!
    Preset.OpFileInUse := cbDisableCopyProtection.Checked;
    Preset.OpDisBinChk := cbDisBinChk.Checked;
    //Preset.OpDlSize := '0';

    if SavePreset(sdPresets.FileName, Preset) then
      MsgBox(Handle, 'Preset saved as "' + ExtractFileName(sdPresets.FileName) + '".',
        'Information', 64)
    else
      MsgBox(Handle, 'Preset save failed !', 'Warning', 48);
    
  end;
end;

procedure TUpload_Form.bOpenPresetClick(Sender: TObject);
begin
  if odPresets.Execute then
    cbxPresets.Text := odPresets.FileName;
end;

procedure TUpload_Form.bPresetOpenClick(Sender: TObject);
var
  Res    : TApplyPresetResult;
  Preset : TPreset;
  
begin
  Res := ApplyPreset(cbxPresets.Text, Preset);

  case Res of
    aprOK           : MsgBox(Handle, 'Preset loaded successfully.', 'Information', 64);
    aprFileNotFound : MsgBox(Handle, 'Preset file not found. File : "'
                      + ExtractFileName(Preset.TargetFile) + '".', 'Warning', 48);
    aprInvalidPreset: MsgBox(Handle, 'This preset isn''t for upload operation.'
                      + 'Aborted.', 'Warning', 48);
    aprIsNotPreset  : MsgBox(Handle, 'Preset load failed !', 'Warning', 48);
  end;
end;

procedure TUpload_Form.CleanControls;
begin
  cbxTargetFile.Clear;
  cbIso.Checked := False;
  cbxIso.Clear;
  cbChroot.Checked := False;
  cbxChroot.Clear;
  cbWorkdir.Checked := False;
  cbxWorkdir.Clear;
  cbExecute.Checked := True;
  cbAddr.Checked := False;
  eAddr.Text := Main_Form.DCTool.UploadOptions.GetDefaultAddress;
  cbDisableCopyProtection.Checked := False;
  cbDisBinChk.Checked := False;
end;

procedure TUpload_Form.SetBinCheckCfg(NewMode: TBinCheckMode);
begin
  DetectionModeSelected := NewMode;
end;

function TUpload_Form.GetBinCheckCfg: TBinCheckMode;
begin
  Result := DetectionModeSelected;
end;

procedure TUpload_Form.FormCreate(Sender: TObject);
begin
  CmdLineFileLoad := False;
end;

procedure TUpload_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CmdLineFileLoad := False;
end;

function TUpload_Form.ApplyPreset(FileName : string ; var Preset : TPreset) : TApplyPresetResult;
var
  OK : boolean;

begin
  Result := aprIsNotPreset;
  OK := LoadPreset(FileName, Preset);
  if not OK then Exit;

  Result := aprFileNotFound;
  if not FileExists(Preset.TargetFile) then Exit;

  Result := aprInvalidPreset;
  case Preset.Operation of
    otUpload        : cbExecute.Checked := False;
    otUploadExecute : cbExecute.Checked := True;
    else Exit; //invalide.
  end;

  //Modifier tous les contrôles.
  cbxTargetFile.Text := Preset.TargetFile;
  cbIso.Checked := Preset.IsoUse;
  cbxIso.Text := Preset.IsoFile;
  cbChroot.Checked := Preset.ChrootUse;
  cbxChroot.Text := Preset.ChrootDir;
  cbWorkdir.Checked := Preset.WorkDirUse;
  cbxWorkdir.Text := Preset.WorkDir;
  //cbExecute.Checked := Preset.UploadExec;
  cbAddr.Checked := Preset.UseAddress;
  eAddr.Text := Preset.Address;
  cbDisableCopyProtection.Checked := Preset.OpFileInUse;
  cbDisBinChk.Checked := Preset.OpDisBinChk;


  Result := aprOK;
end;

end.
