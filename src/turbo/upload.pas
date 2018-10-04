unit upload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, JvBaseDlg, JvBrowseFolder;

type
  TUpload_Form = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    eFile: TEdit;
    bFile: TBitBtn;
    Bevel1: TBevel;
    cbDoNotAttachConsole: TCheckBox;
    cbUseDumbTerminal: TCheckBox;
    cbDoNotClearScreen: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    gbChroot: TGroupBox;
    eChroot: TEdit;
    cbChroot: TCheckBox;
    bChroot: TBitBtn;
    gbISO: TGroupBox;
    eISO: TEdit;
    cbISO: TCheckBox;
    bISO: TBitBtn;
    odChroot: TJvBrowseForFolderDialog;
    odISO: TOpenDialog;
    odFile: TOpenDialog;
    TabSheet3: TTabSheet;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Button3: TButton;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bFileClick(Sender: TObject);
    procedure cbChrootClick(Sender: TObject);
    procedure cbISOClick(Sender: TObject);
    procedure bChrootClick(Sender: TObject);
    procedure bISOClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Upload_Form: TUpload_Form;

implementation

{$R *.dfm}

uses utils, config, main, commands, u_dctool_manager;

procedure TUpload_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if CancelBtn = True then DeleteAllFiles;
  Main_Form.Close;
end;

procedure TUpload_Form.bFileClick(Sender: TObject);
begin
  if odFile.Execute = True then
    eFile.Text := odFile.FileName;
end;

procedure TUpload_Form.cbChrootClick(Sender: TObject);
begin
  if cbChroot.Checked = True then
  begin
    bChroot.Enabled := True;
    eChroot.Enabled := True;
    eChroot.Color := clWindow;
  end else begin
    bChroot.Enabled := False;
    eChroot.Enabled := False;
    eChroot.Color := clBtnFace;
  end;
end;

procedure TUpload_Form.cbISOClick(Sender: TObject);
begin
  if cbISO.Checked = True then
  begin
    bISO.Enabled := True;
    eISO.Enabled := True;
    eISO.Color := clWindow;
  end else begin
    bISO.Enabled := False;
    eISO.Enabled := False;
    eISO.Color := clBtnFace;
  end;
end;

procedure TUpload_Form.bChrootClick(Sender: TObject);
begin
  if odChroot.Execute = True then
    eChroot.Text := odChroot.Directory;
end;

procedure TUpload_Form.bISOClick(Sender: TObject);
begin
  if odISO.Execute = True then
    eISO.Text := odISO.FileName;
end;

procedure TUpload_Form.FormActivate(Sender: TObject);
begin
//  eFile.SetFocus;
end;

procedure TUpload_Form.Button1Click(Sender: TObject);
begin
  CancelBtn := False;

  //Fichier introuvable
  if FileExists(eFile.Text) = False then
  begin
    MsgBox(Handle, 'File not found.' + WrapStr + 'File : "' + eFile.Text + '".', 'Warning', 48);
    Exit;
  end;

  WriteUploadConfig;
  StartUpload;
  //Application.Minimize;
end;

procedure TUpload_Form.Button2Click(Sender: TObject);
begin
  CancelBtn := True;
  Close;
end;

procedure TUpload_Form.Button3Click(Sender: TObject);
begin
  //MustRestart := True;
  Main_Form.ShowModal;
end;

end.
