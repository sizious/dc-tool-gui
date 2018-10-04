unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TOptions_Form = class(TForm)
    GroupBox1: TGroupBox;
    cbAllowLongFileNames: TCheckBox;
    cbHideSplashForm: TCheckBox;
    cbDisableAutoExpandTree: TCheckBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbWarnIfAddressNotDefault: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Options_Form: TOptions_Form;

implementation

uses tools;

{$R *.dfm}

procedure TOptions_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ReadOptions;
end;

procedure TOptions_Form.BitBtn1Click(Sender: TObject);
begin
  WriteOptions;
end;

procedure TOptions_Form.FormShow(Sender: TObject);
begin
  ReadOptions;
end;

procedure TOptions_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
