program test;

uses
  Forms,
  main in 'main.pas' {Form1},
  u_shellext_wrapper in 'u_shellext_wrapper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
