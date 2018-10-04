program cleaner;

uses
  Windows,
  SysUtils,
  ShellApi,
  utils in 'utils.pas',
  u_kill_dctool in 'u_kill_dctool.pas',
  getproc in 'getproc.pas';

var
  Line : string;
  //i    : integer;
  
begin
  { if RunAndWait(ParamStr(1)) = False then
    MessageBoxA(0, 'Error when running the application.' + #13 + #10 + 'Aborted.', 'Fatal error', 16); }

  Line := Droite(' ', CmdLine);

  {for i := 2 to ParamCount do
    Line := Line + ' ' + ParamStr(i); }
  //ShowMessage(Line);

  CreateBatch(Line);
  
  KillAllRunningDCTOOL;
  DeleteAllFiles;
  CreateBatchDeleteFile;
  Sleep(1000);
  ShellExecute(0, 'open', PChar(GetTempDir + 'eraser.bat'), '', '', SW_HIDE);
  DeleteEXE;
end.
