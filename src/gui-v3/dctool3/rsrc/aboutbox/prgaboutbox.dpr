program prgaboutbox;

uses
  Forms,
  aboutbox in 'aboutbox.pas' {AboutBox_Form},
  MiniFMOD in 'MiniFMOD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAboutBox_Form, AboutBox_Form);
  Application.Run;
end.
