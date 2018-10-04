unit addbox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TAdd_Form = class(TForm)
    gbQuestion: TGroupBox;
    eResp: TEdit;
    bAccept: TBitBtn;
    bAbort: TBitBtn;
    procedure bAcceptClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Add_Form: TAdd_Form;

implementation

uses tools, utils, u_filters;

{$R *.dfm}

procedure TAdd_Form.bAcceptClick(Sender: TObject);
begin
  if Length(eResp.Text) = 0 then
  begin
    MsgBox(Handle, CantBeEmpty, ErrorCaption, 48);
    ModalResult := mrNone;
    Exit;
  end;
end;

procedure TAdd_Form.FormShow(Sender: TObject);
begin
  eResp.SetFocus;
  if Editing = True then Exit;
  eResp.Clear;
end;

procedure TAdd_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
