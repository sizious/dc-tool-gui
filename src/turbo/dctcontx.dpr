program dctcontx;

uses
  IniFiles,
  SysUtils,
  Forms,
  main in 'main.pas' {Main_Form},
  upload in 'upload.pas' {Upload_Form},
  locations in 'locations.pas',
  options in 'options.pas',
  regshell in 'regshell.pas',
  regext in 'regext.pas',
  config in 'config.pas',
  utils in 'utils.pas',
  commands in 'commands.pas',
  u_binchk in 'u_binchk.pas',
  u_dctool_manager in 'u_dctool_manager.pas',
  getproc in 'getproc.pas',
  u_kill_dctool in 'u_kill_dctool.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(TUpload_Form, Upload_Form);
  //Init pour la config (config.ini)
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
  ReadConfig;
  ReadUploadConfig;

  //Si y'a un fichier de spécifié, on affiche la boite upload.
  if ParamCount <> 0 then
  begin
    DeleteAllFiles;
    ExtractAllDCTOOL; //Extraction des fichiers
    Application.ShowMainForm := False; //Ne pas afficher la config
    Upload_Form.eFile.Text := ParamStr(1); //passer le fichier en param
    Upload_Form.ShowModal; //afficher upload plutot
  end;
    
  Application.Run;
end.
