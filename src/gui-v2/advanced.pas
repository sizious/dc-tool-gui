unit advanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, JvBaseDlg, JvBrowseFolder;

type
  TAdvanced_Form = class(TForm)
    gbChroot: TGroupBox;
    eChroot: TEdit;
    cbChroot: TCheckBox;
    bChroot: TBitBtn;
    JvBrowseForFolderDialog: TJvBrowseForFolderDialog;
    OpenDialog: TOpenDialog;
    gbISO: TGroupBox;
    eISO: TEdit;
    cbISO: TCheckBox;
    bISO: TBitBtn;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    procedure cbChrootClick(Sender: TObject);
    procedure cbISOClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bChrootClick(Sender: TObject);
    procedure bISOClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Advanced_Form: TAdvanced_Form;

implementation

uses utils, tools;

{$R *.dfm}

procedure TAdvanced_Form.cbChrootClick(Sender: TObject);
begin
  if cbChroot.Checked = True then
  begin
    bChroot.Enabled := True;
    eChroot.Color := clWindow;
    eChroot.Enabled := True;
  end else begin
    bChroot.Enabled := False;
    eChroot.Color := clBtnFace;
    eChroot.Enabled := False;
  end;
end;

procedure TAdvanced_Form.cbISOClick(Sender: TObject);
begin
  if cbISO.Checked = True then
  begin
    bISO.Enabled := True;
    eISO.Color := clWindow;
    eISO.Enabled := True;
  end else begin
    bISO.Enabled := False;
    eISO.Color := clBtnFace;
    eISO.Enabled := False;
  end;
end;

procedure TAdvanced_Form.bOKClick(Sender: TObject);
begin
  if cbChroot.Checked = True then
    if DirectoryExists(eChroot.Text) = False then
    begin
      MsgBox(Handle, InvalidPathPleaseVerifyTheDirectory, ErrorCaption, 48);
      ModalResult := mrNone;
      Exit;
    end;

  if cbISO.Checked = True then
    if FileExists(eISO.Text) = False then
    begin
      MsgBox(Handle, ErrorFileNotFound + WrapStr + '"' + eISO.Text + '".', ErrorCaption, 48);
      ModalResult := mrNone;
      Exit;
    end;

  WriteChRootState;
  WriteISOState;
end;

procedure TAdvanced_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ReadChRootState;
  ReadISOState;
end;

procedure TAdvanced_Form.bChrootClick(Sender: TObject);
begin
  if JvBrowseForFolderDialog.Execute = True then
    eChroot.Text := JvBrowseForFolderDialog.Directory;
end;

procedure TAdvanced_Form.bISOClick(Sender: TObject);
begin
  if OpenDialog.Execute = True then
    eISO.Text := OpenDialog.FileName;
end;

procedure TAdvanced_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
