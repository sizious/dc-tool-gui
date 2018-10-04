program openhelp;

uses
  Windows,
  IniFiles,
  ShellApi,
  main in 'main.pas';

{$R icon.RES}
{$R versioninfo.res}

begin
  Ini := TIniFile.Create(GetAppDir + 'config.ini');
  ShellExecute(0, 'open', PChar(GetHelpFile), '', '', SW_SHOWNORMAL);
end.
