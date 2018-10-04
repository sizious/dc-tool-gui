unit u_linktest;

interface

uses
  Windows, SysUtils, DosCommand;

procedure UploadTestProgram(DosCommand : TDosCommand ; ProgramFile : string);

implementation

uses linktest, tools, dctool_cfg, main, u_progress, u_ctrls, bba;
     
{ ------------------------------< DoUploadCommand >----------------------------}

procedure UploadTestProgram(DosCommand : TDosCommand ; ProgramFile : string);

//**************UploadCommandSerial**************
procedure UploadCommandSerial(ProgramFile : string);
var
  UpCommandLine : string;
  COMPort : string;
  Baudrate : string;

begin
  //COM Port
  COMPort := GetCOMPort;

  //Baudrate
  Baudrate := GetBaudrate;

  //DCTOOL a utiliser
  if DCTOOL_Form.External_RadioButton.Checked = True then
    UpCommandLine := DCTOOL_Form.Location_Edit.Text
  else UpCommandLine := DCTOOL;

  //Executer le fichier.
  UpCommandLine := UpCommandLine + ' -x ';

  //Dossier spécifié.
  SetCurrentDir(GetTempDir);

  //Reel command :
  UpCommandLine := UpCommandLine + '"' + ProgramFile + '" -t ' + COMPort + ' -b '
    + Baudrate + ' -a ' + DEFAULT_ADDRESS;

  //Options de transfert    
  if Main_Form.ryalternate1152001.Checked = True then UpCommandLine := UpCommandLine + ' -e ';
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then UpCommandLine := UpCommandLine + ' -n ';
  if Main_Form.Usedumbterminalrather1.Checked = True then UpCommandLine := UpCommandLine + ' -p ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then UpCommandLine := UpCommandLine + ' -q ';

  //Progress MAX...
  MaxProgress := ExtractFileSize(ProgramFile) div 8192; //Pour le MAX de la pbar

  //Executer.
  DosCommand.CommandLine := UpCommandLine;
  DosCommand.Execute;

  //Dossier spécifié.
  //SetCurrentDir(CurrentDir);

  //Affiche la progression
  //Progress_Form.Height := 162;
  //UpProgress_Form.Show;
  //RestoreForm(UpProgress_Form);
  DisactiveControls;
end;

//**************UploadCommandBBA**************
procedure UploadCommandBBA(ProgramFile : string);
var
  UpCommandLine : string;

begin
  //DCTOOL a utiliser
  if DCTOOL_Form.External_RadioButton.Checked = True then
    UpCommandLine := DCTOOL_Form.Location_Edit.Text
  else UpCommandLine := DCTOOLIP;

  //Executer le fichier.
  UpCommandLine := UpCommandLine + ' -x ';

  //Dossier temp
  SetCurrentDir(GetTempDir);

  //Reel command :
  UpCommandLine := UpCommandLine + '"' + ProgramFile + '" -t ' + ReadIP + ' -a '
    + DEFAULT_ADDRESS;

  //Options reelles
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then UpCommandLine := UpCommandLine + ' -n ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then UpCommandLine := UpCommandLine + ' -q ';

  //Executer.
  DosCommand.CommandLine := UpCommandLine;
  DosCommand.Execute;

  //Dossier spécifié.
  //SetCurrentDir(SetToDir);

  //Maximum de la progress bar...
  MaxProgress := ExtractFileSize(ProgramFile) div 8192; //Pour le MAX de la pbar

  //Afficher la progress bar...
  //DownProgress_Form.Height := 162;
  //DownProgress_Form.Show;
  //RestoreForm(DownProgress_Form);
  DisactiveControls;
end;

//*****************MAIN FUNCTION*****************
begin
  if GetConnectionMethod = LINK_TYPE_BBA then
    UploadCommandBBA(ProgramFile)
  else UploadCommandSerial(ProgramFile);
end;

end.