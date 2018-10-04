unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Buttons, JvBaseDlg, JvBrowseFolder,
  JvComponent;

type
  TOptions_Form = class(TForm)
    pcOptions: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    rgUploadTabs: TRadioGroup;
    rgDownloadTabs: TRadioGroup;
    RadioGroup1: TRadioGroup;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    cbxWorkDir: TComboBox;
    bWorkDir: TBitBtn;
    od: TJvBrowseForFolderDialog;
    Label1: TLabel;
    cbxUploadClean: TCheckBox;
    GroupBox3: TGroupBox;
    cbRegisterBinariesMenus: TCheckBox;
    cbRegisterBinariesExts: TCheckBox;
    cbxDownloadClean: TCheckBox;
    cbRegisterPresetsExts: TCheckBox;
    cbRegisterPresetsMenus: TCheckBox;
    cbxShowSplash: TCheckBox;
    cbBinExec: TCheckBox;
    cbPrtExec: TCheckBox;
    procedure bWorkDirClick(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbRegisterBinariesMenusClick(Sender: TObject);
    procedure cbRegisterBinariesExtsClick(Sender: TObject);
    procedure cbRegisterPresetsExtsClick(Sender: TObject);
    procedure cbRegisterPresetsMenusClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure UpdateForm;
    procedure ApplyShellConfig;
  end;

var
  Options_Form: TOptions_Form;

implementation

{$R *.dfm}

uses
  HistMgr, Utils, u_shellext_wrapper;

procedure TOptions_Form.bWorkDirClick(Sender: TObject);
begin
  with od do
    if Execute then cbxWorkDir.Text := Directory;
end;

procedure TOptions_Form.TabSheet2Show(Sender: TObject);
var
  SL : TStringList;

begin
  SL := HMWorkingDir.GetCompleteList;
  try
    cbxWorkDir.Items := SL;
  finally
    SL.Free;
  end;
end;

procedure TOptions_Form.FormCreate(Sender: TObject);
begin
  //path à mettre à jour.
  if Length(cbxWorkDir.Text) = 0 then
    cbxWorkDir.Text := GetAppDir;
end;

procedure TOptions_Form.FormShow(Sender: TObject);
begin
  pcOptions.ActivePageIndex := 0;
  UpdateForm;  
end;

procedure TOptions_Form.UpdateForm;
begin
  cbRegisterBinariesExts.Checked := IsBinariesExtRegistered;
  cbRegisterPresetsExts.Checked := IsPresetsExtRegistered;
  cbRegisterBinariesMenus.Checked := IsBinariesMenuRegistered;
  cbRegisterPresetsMenus.Checked := IsPresetsMenuRegistered;
  cbBinExec.Checked := IsImmediateBinariesExec;
  cbPrtExec.Checked := IsImmediatePresetExec;
end;

procedure TOptions_Form.ApplyShellConfig;
var
  CanDo : integer;

begin
  if (IsBinariesExtRegistered <> cbRegisterBinariesExts.Checked) then
    if cbRegisterBinariesExts.Checked then
    begin
      CanDo := MsgBox(Handle, 'Are you sure to register the "BIN" and "ELF" extensions ?',
        'Confirm registration', MB_ICONQUESTION + MB_YESNO);
      if CanDo = IDYES then RegisterBinariesExts;
    end else begin
      CanDo := MsgBox(Handle, 'Destroy "BIN" and "ELF" extensions ?',
        'Confirm unregistration', MB_ICONQUESTION + MB_YESNO);
      if CanDo = IDYES then UnregisterBinariesExts;
    end;

  if (IsBinariesMenuRegistered <> cbRegisterBinariesMenus.Checked)
    or (IsImmediateBinariesExec <> cbBinExec.Checked) then
      begin
        if cbRegisterBinariesMenus.Checked then
          RegisterBinariesMenu(PChar(Application.ExeName), cbBinExec.Checked)
        else UnregisterBinariesMenu;
      end;

  if IsPresetsExtRegistered <> cbRegisterPresetsExts.Checked then
    if cbRegisterPresetsExts.Checked then
    begin
      CanDo := MsgBox(Handle, 'Are you sure to register the "DPU" and "DPD" extensions ?',
          'Confirm registration', MB_ICONQUESTION + MB_YESNO);
      if CanDo = IDYES then RegisterPresetsExts;
    end else begin
      CanDo := MsgBox(Handle, 'Destroy "DPU" and "DPD" extensions ?',
        'Confirm unregistration', MB_ICONQUESTION + MB_YESNO);
      if CanDo = IDYES then UnregisterPresetsExts;
    end;

  if (IsPresetsMenuRegistered <> cbRegisterPresetsMenus.Checked)
    or (IsImmediatePresetExec <> cbPrtExec.Checked) then
      if cbRegisterPresetsMenus.Checked then
        RegisterPresetsMenu(PChar(Application.ExeName), cbPrtExec.Checked)
      else UnregisterPresetsMenu;
end;

procedure TOptions_Form.cbRegisterBinariesMenusClick(Sender: TObject);
begin
  cbBinExec.Enabled := cbRegisterBinariesMenus.Checked;
end;

procedure TOptions_Form.cbRegisterBinariesExtsClick(Sender: TObject);
begin
{  cbRegisterBinariesMenus.Enabled := cbRegisterBinariesExts.Checked;
  cbBinExec.Enabled := cbRegisterBinariesExts.Checked
    and cbRegisterBinariesMenus.Checked; }
end;

procedure TOptions_Form.cbRegisterPresetsExtsClick(Sender: TObject);
begin
{  cbRegisterPresetsMenus.Enabled := cbRegisterPresetsExts.Checked;
  cbPrtExec.Enabled := cbRegisterPresetsExts.Checked and
    cbRegisterPresetsMenus.Checked; }
end;

procedure TOptions_Form.cbRegisterPresetsMenusClick(Sender: TObject);
begin
  cbPrtExec.Enabled := cbRegisterPresetsMenus.Checked;
end;

procedure TOptions_Form.BitBtn1Click(Sender: TObject);
begin
  ApplyShellConfig;
end;

end.
