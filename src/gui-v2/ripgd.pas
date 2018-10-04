{
  Unit : ext_track
  By   : [big_fury]SiZiOUS
  For  : DC-TOOL GUI v1.2
  Notes: Upload de DreamRip v2.01 by BERO.

         Fonction a peu près terminée & opérationnelle le 30/06/2004 à 13:48 !
}

unit ripgd;

interface

uses
  Windows, SysUtils;

procedure DoUploadCommand(ProgramFile, SetToDir : string);

implementation

uses dctool_cfg, tools, main, progress, baudrate, address, utils, upload,
     download, setsize, u_hist, u_progress, bba, u_filters, u_advanced,
     u_ctrls, gd_ripper;
     
{ ------------------------------< DoUploadCommand >----------------------------}

procedure DoUploadCommand(ProgramFile, SetToDir : string);

//**************UploadCommandSerial**************
procedure UploadCommandSerial(ProgramFile, CurrentDir : string);
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

  //Executer.
  RipGD_Form.dcRIP.CommandLine := UpCommandLine;
  RipGD_Form.dcRIP.Execute;

  //Dossier spécifié.
  SetCurrentDir(CurrentDir);

  //Progress MAX...
  MaxProgress := ExtractFileSize(ProgramFile) div 8192; //Pour le MAX de la pbar

  //Affiche la progression
  //Progress_Form.Height := 162;
  //UpProgress_Form.Show;
  //RestoreForm(UpProgress_Form);
  DisactiveControls;
end;

//**************UploadCommandBBA**************
procedure UploadCommandBBA(ProgramFile, SetToDir : string);
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
  RipGD_Form.dcRIP.CommandLine := UpCommandLine;
  RipGD_Form.dcRIP.Execute;

  //Dossier spécifié.
  SetCurrentDir(SetToDir);

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
    UploadCommandBBA(ProgramFile, SetToDir)
  else UploadCommandSerial(ProgramFile, SetToDir);
end;

end.
