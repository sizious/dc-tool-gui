unit baudrate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Tools, Buttons;

type
  TSetBaudrate_Form = class(TForm)
    Baudrate_Label: TLabel;
    SetBaudrateToGroupBox: TGroupBox;
    Baudrate: TComboBox;
    SetBaudrateTo: TLabel;
    Baud_Label: TLabel;
    OKButton: TBitBtn;
    Cancel_Button: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  SetBaudrate_Form: TSetBaudrate_Form;
  Modified : boolean;
  
implementation

uses utils;

{$R *.dfm}

procedure TSetBaudrate_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ReadBaudRate;
  if Modified = False then
  begin
    Baudrate.ItemIndex := StrToInt(Baudrate_Label.Caption);
    ModalResult := mrCancel;
    Exit;
  end;

  Modified := False;
end;

procedure TSetBaudrate_Form.FormActivate(Sender: TObject);
begin
  ReadBaudRate;
  Baudrate_Label.Caption := IntToStr(Baudrate.ItemIndex);
  Baudrate.SetFocus;
end;

procedure TSetBaudrate_Form.FormCreate(Sender: TObject);
begin
//  Baudrate_Label.Caption := Baudrate.Text;
end;

procedure TSetBaudrate_Form.OKButtonClick(Sender: TObject);
begin
  try
    StrToInt(Baudrate.Text);
  except
    on EConvertError do
    begin
      MsgBox(Handle, BaudrateIsIncorrect + WrapStr + '"' + Baudrate.Text + '" .', ErrorCaption, 48);
      Baudrate.SetFocus;
      Exit;
    end;
  end;

  Modified := True;
  WriteBaudRate;
  ModalResult := mrOK;
end;

procedure TSetBaudrate_Form.BitBtn2Click(Sender: TObject);
begin
  Baudrate.ItemIndex := StrToInt(Baudrate_Label.Caption);
end;

procedure TSetBaudrate_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
