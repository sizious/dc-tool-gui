unit cygwin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TCygwin_Form = class(TForm)
    gbCygwin: TGroupBox;
    Info_Label: TLabel;
    rbInternal: TRadioButton;
    rbExternal: TRadioButton;
    OK: TBitBtn;
    Cancel: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Cygwin_Form: TCygwin_Form;

implementation

uses tools, utils;

{$R *.dfm}

procedure TCygwin_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LoadCygwinConfig;
end;

procedure TCygwin_Form.FormShow(Sender: TObject);
begin
  LoadCygwinConfig;
end;

procedure TCygwin_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
