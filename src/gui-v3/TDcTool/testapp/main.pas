unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dctool, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    DCTool1: TDCTool;
    Memo1: TMemo;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    procedure DCTool1NewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DCTool1NewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
begin
  if outputtype = otentireline then
    memo1.Lines.Add(newline);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  dctool1.DosComm.Execute;
end;

end.
