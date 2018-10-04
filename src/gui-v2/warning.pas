unit warning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IcoGrab, StdCtrls, Buttons;

type
  TWarning_Form = class(TForm)
    IconGrabber: TIconGrabber;
    cbDontAskAgain: TCheckBox;
    Text: TLabel;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Warning_Form: TWarning_Form;

implementation

{$R *.dfm}

uses tools;

procedure TWarning_Form.FormShow(Sender: TObject);
begin
  cbDontAskAgain.Checked := ReadWarningState('WarningBIOS');
  MessageBeep(48);
end;

procedure TWarning_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
