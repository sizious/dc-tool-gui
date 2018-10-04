unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, JvBaseDlg, JvBrowseFolder,
  IniFiles, XPMan;

type
  TMain_Form = class(TForm)
    pcMain: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    rbSerial: TRadioButton;
    rbBBA: TRadioButton;
    tsSerial: TTabSheet;
    gbChooseBaudrate: TGroupBox;
    lbauds: TLabel;
    eBaudrate: TComboBox;
    cbAlternate: TCheckBox;
    gbChooseCOM: TGroupBox;
    rbCOM1: TRadioButton;
    rbCOM2: TRadioButton;
    rbCOM3: TRadioButton;
    rbCOM4: TRadioButton;
    tsBBA: TTabSheet;
    GroupBox2: TGroupBox;
    eIP: TEdit;
    TabSheet4: TTabSheet;
    GroupBox3: TGroupBox;
    rbAskOnlyIfScrambled: TRadioButton;
    rbAlwaysConfirmDetectionResult: TRadioButton;
    rbUnscrambleWithoutPrompt: TRadioButton;
    rbDontUseThisModule: TRadioButton;
    TabSheet5: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox5: TGroupBox;
    lDCTOOL: TLabel;
    eDCTOOL: TEdit;
    eCYGWIN: TEdit;
    lCYGWIN: TLabel;
    rbInternal: TRadioButton;
    rbExternal: TRadioButton;
    Bevel1: TBevel;
    bDCTOOL: TBitBtn;
    bCYGWIN: TBitBtn;
    pLoc: TPanel;
    rbLocSerial: TRadioButton;
    rbLocBBA: TRadioButton;
    bOK: TButton;
    bCancel: TButton;
    odDCTOOL: TOpenDialog;
    Label1: TLabel;
    odCYGWIN: TJvBrowseForFolderDialog;
    GroupBox4: TGroupBox;
    cbContextMenu: TCheckBox;
    cbFileType: TCheckBox;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    XPManifest: TXPManifest;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Image1: TImage;
    Label5: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    procedure rbSerialClick(Sender: TObject);
    procedure rbBBAClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbInternalClick(Sender: TObject);
    procedure rbExternalClick(Sender: TObject);
    procedure rbLocSerialClick(Sender: TObject);
    procedure rbLocBBAClick(Sender: TObject);
    procedure bDCTOOLClick(Sender: TObject);
    procedure bCYGWINClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Main_Form   : TMain_Form;
  Ini         : TIniFile;
  CancelBtn   : boolean = False;
  //MustRestart : boolean = False;

implementation

uses locations, options, upload, config, utils, u_dctool_manager;

{$R *.dfm}
{$R icons.RES}

procedure TMain_Form.rbSerialClick(Sender: TObject);
begin
  tsBBA.TabVisible := False;
  tsSerial.TabVisible := True;
end;

procedure TMain_Form.rbBBAClick(Sender: TObject);
begin
  tsBBA.TabVisible := True;
  tsSerial.TabVisible := False;
end;

procedure TMain_Form.FormCreate(Sender: TObject);
begin
  Application.Title := Main_Form.Caption;
  //MustRestart := False;
end;

procedure TMain_Form.rbInternalClick(Sender: TObject);
begin
  EnableInternalLocs;
end;

procedure TMain_Form.rbExternalClick(Sender: TObject);
begin
  EnableExternalLocs;
end;

procedure TMain_Form.rbLocSerialClick(Sender: TObject);
begin
  Main_Form.rbSerial.Checked := True;
end;

procedure TMain_Form.rbLocBBAClick(Sender: TObject);
begin
  Main_Form.rbBBA.Checked := True;
end;

procedure TMain_Form.bDCTOOLClick(Sender: TObject);
begin
  if odDCTOOL.Execute = True then
    eDCTOOL.Text := odDCTOOL.FileName;
end;

procedure TMain_Form.bCYGWINClick(Sender: TObject);
begin
  if odCYGWIN.Execute = True then
    eCYGWIN.Text := odCYGWIN.Directory;
end;

procedure TMain_Form.bCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TMain_Form.bOKClick(Sender: TObject);
begin
  //if MustRestart = True then
  //  MsgBox(Handle, 'You must restart the application for changes take effect.', 'Information', 64);

  //Verification si DC-TOOL externe est présent si activé
  if Main_Form.eDCTOOL.Enabled = True then
    //if Main_Form.eDCTOOL.Text <> '' then
      if FileExists(Main_Form.eDCTOOL.Text) = False then
      begin
        MsgBox(Handle, 'DC-TOOL program not found.' + WrapStr + 'File : "' + Main_Form.eDCTOOL.Text + '".', 'Warning', 48);
        Exit;
      end;

  //Vérification si le dossier contenant les DLL est présent si activé
  //Si vide, alors on utilise la distribution Cygwin
  if Main_Form.eCYGWIN.Enabled = True then
    if Main_Form.eCYGWIN.Text <> '' then
      if FileExists(Main_Form.eCYGWIN.Text) = False then
      begin
        MsgBox(Handle, 'CYGWIN libraries not found.' + WrapStr + 'File : "' + Main_Form.eCYGWIN.Text + '".', 'Warning', 48);
        Exit;
      end;

  //IP Valide ? (car on doit la rentrer manuellement).
  if Main_Form.rbBBA.Checked = True then
    if ValidIP(eIP.Text) = False then
    begin
      MsgBox(Handle, 'IP not valid.', 'Warning', 48);
      Exit;
    end;
      
  if Upload_Form.Showing = False then
    MsgBox(Handle, 'Configuration saved.', 'Information', 64);

  WriteConfig;
  Close;
end;

procedure TMain_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //DeleteAllDCTOOL;
  if Upload_Form.Showing = True then Exit;
  
  Application.Terminate;
  Halt(0);
end;

end.
