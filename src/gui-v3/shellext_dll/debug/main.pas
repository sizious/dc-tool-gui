unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses u_shellext_wrapper;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('IsImmediatePresetExec : ' + BoolToStr(IsImmediatePresetExec, True));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RegisterBinariesExts;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  RegisterBinariesMenu(pchar(application.exename), true);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  ShowMessage('IsImmediateBinariesExec : ' + BoolToStr(IsImmediateBinariesExec, True));
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  RegisterPresetsExts;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  UnregisterPresetsExts;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  RegisterPresetsMenu(pchar(application.exename), true);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  UnregisterPresetsMenu;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  UnregisterBinariesExts;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  UnregisterBinariesMenu;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  if IsBinariesExtRegistered then
    showmessage('true')
  else showmessage('false');
end;

end.
