unit dctool_cfg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TDctool_Form = class(TForm)
    DCTOOL_GroupBox: TGroupBox;
    Internal_RadioButton: TRadioButton;
    External_RadioButton: TRadioButton;
    Location_Edit: TEdit;
    Location_Label: TLabel;
    Info_Label: TLabel;
    OpenDialog: TOpenDialog;
    Cancel: TBitBtn;
    GroupBox1: TGroupBox;
    Serial_RadioButton: TRadioButton;
    BBA_RadioButton: TRadioButton;
    OK: TBitBtn;
    Browse_SpeedButton: TBitBtn;
    procedure External_RadioButtonClick(Sender: TObject);
    procedure Internal_RadioButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Dctool_Form: TDctool_Form;
  
implementation

uses main, tools, utils;

{$R *.dfm}

procedure TDctool_Form.External_RadioButtonClick(Sender: TObject);
begin
  Location_Edit.Enabled := True;
  Location_Label.Enabled := True;
  Browse_SpeedButton.Enabled := True;
  Serial_RadioButton.Enabled := True;
  BBA_RadioButton.Enabled := True;
end;

procedure TDctool_Form.Internal_RadioButtonClick(Sender: TObject);
begin
  Location_Edit.Enabled := False;
  Location_Label.Enabled := False;
  Browse_SpeedButton.Enabled := False;
  Serial_RadioButton.Enabled := False;
  BBA_RadioButton.Enabled := False;
end;

procedure TDctool_Form.FormCreate(Sender: TObject);
begin
  ReadConfig;
end;

procedure TDctool_Form.FormActivate(Sender: TObject);
begin
  ReadConfig;
end;

procedure TDctool_Form.OKClick(Sender: TObject);
begin
  if External_RadioButton.Checked = True then
  begin

    if Location_Edit.Text = '' then
    begin
      MsgBox(Handle, PleaseSpecifyTheFile, ErrorCaption, 48);
      ModalResult := mrNone;
      Exit;
    end;

    if FileExists(Location_Edit.Text) = False then
    begin
      MsgBox(Handle, ErrorFileNotFound + WrapStr + '"' + Location_Edit.Text + '".', ErrorCaption, 48);
      ModalResult := mrNone;
      Exit;
    end;

  end;

  WriteConfig;
end;

procedure TDctool_Form.BitBtn1Click(Sender: TObject);
begin
  if OpenDialog.Execute = True then
    Location_Edit.Text := OpenDialog.FileName;
end;

procedure TDctool_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
