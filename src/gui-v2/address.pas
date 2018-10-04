unit address;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TAddress_Form = class(TForm)
    Address_Label: TLabel;
    PleaseSetTheNewAddressNowGroupBox: TGroupBox;
    Address: TLabeledEdit;
    DefBtn: TButton;
    OKButton: TBitBtn;
    Cancel_Button: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DefBtnClick(Sender: TObject);
    procedure AddressKeyPress(Sender: TObject; var Key: Char);
    procedure OKButtonClick(Sender: TObject);
    procedure Cancel_ButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Address_Form: TAddress_Form;
  Modified : boolean;
  
implementation

uses tools;

{$R *.dfm}

procedure TAddress_Form.FormActivate(Sender: TObject);
begin
  Address_Label.Caption := Address.Text;
  Address.SetFocus;
  Address.SelectAll;
end;

procedure TAddress_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ReadAddress;
  
  if Modified = False then
  begin
    Address.Text := Address_Label.Caption;
    ModalResult := mrCancel;
    Exit;
  end;

  Modified := False;
end;

procedure TAddress_Form.DefBtnClick(Sender: TObject);
begin
  Address.Text := DEFAULT_ADDRESS;
end;

procedure TAddress_Form.AddressKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    OKButton.Click;
  end;
end;

procedure TAddress_Form.OKButtonClick(Sender: TObject);
begin
  Modified := True;
  WriteAddress;
  ModalResult := mrOK;
end;

procedure TAddress_Form.Cancel_ButtonClick(Sender: TObject);
begin
  Address.Text := Address_Label.Caption;
end;

procedure TAddress_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
