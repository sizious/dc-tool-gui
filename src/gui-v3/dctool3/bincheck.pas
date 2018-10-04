unit bincheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TBinCheck_Form = class(TForm)
    bOK: TBitBtn;
    bCancel: TBitBtn;
    rgBinCheck: TRadioGroup;
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  BinCheck_Form: TBinCheck_Form;

implementation

{$R *.dfm}

end.
