unit setip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, Buttons;

type
  TIP_Form = class(TForm)
    PleaseSetTheNewAddressNowGroupBox: TGroupBox;
    DefBtn: TButton;
    EnterIPAdress: TLabel;
    eIP: TEdit;
    OKButton: TBitBtn;
    Cancel_Button: TBitBtn;
    procedure DefBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  IP_Form: TIP_Form;

implementation

uses bba, tools, utils;

{$R *.dfm}

procedure TIP_Form.DefBtnClick(Sender: TObject);
begin
  eIP.Text := '000.000.000.000';
end;

procedure TIP_Form.FormShow(Sender: TObject);
begin
  eIP.SetFocus;
end;

procedure TIP_Form.BitBtn1Click(Sender: TObject);
begin
  if not ValidIP(eIP.Text) then
  begin
    MsgBox(Handle, IPAddressMustBeValidFormat0000To255255255255, ErrorCaption, 48);
    Exit;
  end;

  ModalResult := mrOK;
end;

procedure TIP_Form.FormActivate(Sender: TObject);
begin
  eIP.SetFocus;
  eIP.SelectAll;
end;

procedure TIP_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
