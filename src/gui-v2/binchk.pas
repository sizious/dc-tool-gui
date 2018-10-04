unit binchk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TBINCheck_Form = class(TForm)
    bOK: TBitBtn;
    bCancel: TBitBtn;
    gbBINCheckModuleConfiguration: TGroupBox;
    rbAskOnlyBeforeUnscrambling: TRadioButton;
    rbAskAlways: TRadioButton;
    rbDoNotAskAnyThing: TRadioButton;
    rbDoNotUseThis: TRadioButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bOKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  BINCheck_Form: TBINCheck_Form;

implementation

uses tools;

{$R *.dfm}

procedure TBINCheck_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ModalResult := mrCancel;
end;

procedure TBINCheck_Form.bOKClick(Sender: TObject);
begin
  WriteBINDetectConfig;
end;

procedure TBINCheck_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
