unit excptlog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls;

type
  TExcept_Form = class(TForm)
    GroupBox1: TGroupBox;
    reExcept: TRichEdit;
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    bOK: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    sbExcept: TStatusBar;
    procedure bOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Except_Form: TExcept_Form;

implementation

{$R *.dfm}

uses
  Utils;
  
procedure TExcept_Form.bOKClick(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, 'So, what do you want to do, now ?' + WrapStr
    + 'Do you want to quit this crappy app, or ignore this error and continue ?'
      + WrapStr + WrapStr + '''Yes'' exit the app and ''No'' return to the app.',
        'DC-TOOL GUI - Exception Handler', 48 + MB_YESNO + MB_SYSTEMMODAL);

  if CanDo = IDYes then Halt(255);
end;

procedure TExcept_Form.FormShow(Sender: TObject);
begin
  MessageBeep(16);
  sbExcept.SimpleText := IntToStr(reExcept.Lines.Count) + ' exception(s)';
end;

end.
