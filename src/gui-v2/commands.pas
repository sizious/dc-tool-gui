unit commands;

interface

uses
  Windows, SysUtils, FileCtrl, Controls;

procedure UploadFileToDC;
procedure DownloadFileFromDC;

implementation

uses dctool_cfg, tools, main, progress, baudrate, address, utils, upload,
     download, setsize, u_hist, u_progress, u_filters, u_advanced,
     u_binchk, u_ctrls, dl_progress;

{---------------------------------------------< DEBUT DES PROCEDURES >------------------------------------------------------------------ }

{---------------------------------------------< UploadFileToDC >------------------------------------------------------------------ }

procedure UploadFileToDC;
var
  UpCommandLine : string;
  CmdMini : string;
  COMPort : string;
  Baudrate : string;

begin
  //COM Port
  COMPort := GetCOMPort;

  //Baudrate
  Baudrate := GetBaudrate;

{  //Test de validité
  if Upload_Form.Input_Edit.Text = '' then
  begin
    MsgBox(Upload_Form.Handle, InputPathEmpty, ErrorCaption, 48);
    Exit;
  end;

  if FileExists(Upload_Form.Input_Edit.Text) = False then
  begin
    MsgBox(Upload_Form.Handle, ErrorFileNotFound + WrapStr + '"' + Upload_Form.Input_Edit.Text + '".', ErrorCaption, 48);
    Exit;
  end;    } //TRONC COMMUM AVEC BBA

  //--Test...
  AddTreeNode(Upload_Form.Input_Edit.Text, True);
  
  //DCTOOL a utiliser
  if Dctool_Form.External_RadioButton.Checked = True then
    UpCommandLine := Dctool_Form.Location_Edit.Text
  else UpCommandLine := DCTOOL; //GetTempDir + 'DC-TOOL.EXE';

  //Executer ou pas?
  if Upload_Form.UpExecute.Checked = True then
    UpCommandLine := UpCommandLine + ' -x '
  else UpCommandLine := UpCommandLine + ' -u ';

  //Dossier temp
  SetCurrentDir(GetTempDir);

  //Command mini
  CmdMini := UpCommandLine + '"' + MinimizeName(Upload_Form.Input_Edit.Text,
    Upload_Form.FileName_Label.Canvas, 200) + '" -t ' + COMPort + ' -b '
      + SetBaudrate_Form.Baudrate.Text + ' -a ' + Address_Form.Address.Text
      + PutMiniAdvancedCommandLine;

  //Si BIN Check est utilisé
{  if IsBinModuleUsed = True then
  begin
    if GetUnscrambledFileName <> '' then
    begin
      CmdMini := UpCommandLine + '"' + MinimizeName(GetUnscrambledFileName,
        Upload_Form.FileName_Label.Canvas, 200) + '" -t ' + COMPort + ' -b '
          + SetBaudrate_Form.Baudrate.Text + ' -a ' + Address_Form.Address.Text
          + PutMiniAdvancedCommandLine;
    end;
  end; } //Si il est utilisé, on a unscramblé le fichier à la place de l'autre et renommé l'original.

  if Main_Form.ryalternate1152001.Checked = True then CmdMini := CmdMini + ' -e ';
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then CmdMini := CmdMini + ' -n ';
  if Main_Form.Usedumbterminalrather1.Checked = True then CmdMini := CmdMini + ' -p ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then CmdMini := CmdMini + ' -q ';

  //Reel command :
  UpCommandLine := UpCommandLine + '"' + Upload_Form.Input_Edit.Text + '" -t '
    + COMPort + ' -b ' + SetBaudrate_Form.Baudrate.Text + ' -a '
      + Address_Form.Address.Text + PutAdvancedCommandLine;

  //Si BIN Check est utilisé
{  if IsBinModuleUsed = True then
  begin
    if GetUnscrambledFileName <> '' then
    begin
      UpCommandLine := UpCommandLine + '"' + GetUnscrambledFileName + '" -t '
      + COMPort + ' -b ' + SetBaudrate_Form.Baudrate.Text + ' -a '
        + Address_Form.Address.Text + PutAdvancedCommandLine;
    end;
  end; }  //Si il est utilisé, on a unscramblé le fichier à la place de l'autre et renommé l'original.

  if Main_Form.ryalternate1152001.Checked = True then UpCommandLine := UpCommandLine + ' -e ';
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then UpCommandLine := UpCommandLine + ' -n ';
  if Main_Form.Usedumbterminalrather1.Checked = True then UpCommandLine := UpCommandLine + ' -p ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then UpCommandLine := UpCommandLine + ' -q ';

  Main_Form.UpDosCommand.CommandLine := UpCommandLine;
  Main_Form.UpDosCommand.Execute;

  //AddDebug(Main_Form.DosCommand.OutputLines.Text);
  //Input_Edit.Text := Main_Form.DosCommand.CommandLine;
  //ShowMessage(Main_Form.DosCommand.CommandLine);

  MaxProgress := ExtractFileSize(FileNameOp) div 8192; //Pour le MAX de la pbar

  //AddDebug(' ');
  AddDebug('CMD:> ' + CmdMini);
  AddToFiltered('CMD:> ' + CmdMini);
  
  AddDebug('STATE:> Sending upload command to DC-TOOL...');
  AddToFiltered('STATE:> Sending upload command to DC-TOOL...');

  if Upload_Form.UpExecute.Checked = True then AddDebug('STATE:> Upload and Execute in progress...')
  else AddDebug('STATE:> Upload in progress...');

  //Main_Form.ListBox.Items := Main_Form.DosCommand.OutputLines;

  Upload_Form.ModalResult := mrOK;
  if Upload_Form.Visible = True then Upload_Form.Close;

  WriteFileInHistory(Upload_Form.Input_Edit.Text);

  //Progress_Form.Height := 162;
  //Progress_Form.ShowModal;
  UpProgress_Form.Show;
  RestoreForm(UpProgress_Form);
  //Main_Form.Abortoperation1.Enabled := True;
  DisactiveControls;
end;

{---------------------------------------------< DownloadFileFromDC >------------------------------------------------------------------ }

procedure DownloadFileFromDC;
var
  DlCommandLine : string;
  CmdMini : string;
  COMPort : string;
//  Rep     : integer;

begin
  if Main_Form.COM1.Checked = True then COMPort := 'COM1'
  else if Main_Form.COM2.Checked = True then COMPort := 'COM2'
  else if Main_Form.COM3.Checked = True then COMPort := 'COM3'
  else if Main_Form.COM4.Checked = True then COMPort := 'COM4';

{  if Download_Form.Output_Edit.Text = '' then
  begin
    MsgBox(Download_Form.Handle, InputPathEmpty, ErrorCaption, 48);
    Exit;
  end;

  if StrToInt(SetSize_Form.Size.Text) = 0 then
  begin
    MsgBox(Download_Form.Handle, SizeCantBeZero, ErrorCaption, 48);
    Exit;
  end;

  if FileExists(Download_Form.Output_Edit.Text) = True then
  begin
    Rep := MsgBox(Download_Form.Handle, FileExistsDoYouWantToReplaceIt + WrapStr + '"' + Download_Form.Output_Edit.Text + '".', ErrorCaption, MB_YESNO + MB_DEFBUTTON2 + 48);
    if Rep = IDNO then Exit;
  end; } //TRONC COMMUM

  if Dctool_Form.External_RadioButton.Checked = True then
    DlCommandLine := Dctool_Form.Location_Edit.Text
  else begin
    //ExtractFile(GetTempDir, 'DCTOOL', 'EXE');
    DlCommandLine := DCTOOL; //GetTempDir + 'DC-TOOL.EXE';
  end;

  DlCommandLine := DlCommandLine + ' -d ';

  SetCurrentDir(GetTempDir);
  //showmessage(getcurrentdir);

  //Petite commande
  CmdMini := DlCommandLine + '"' + MinimizeName(Download_Form.Output_Edit.Text,
    Download_Form.FileName_Label.Canvas, 200) + '" -t ' + COMPort + ' -s '
      + SetSize_Form.Size.Text  + ' -b ' + SetBaudrate_Form.Baudrate.Text + ' -a '
        + Address_Form.Address.Text + PutMiniAdvancedCommandLine;
        
  if Main_Form.ryalternate1152001.Checked = True then CmdMini := CmdMini + ' -e ';
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then CmdMini := CmdMini + ' -n ';
  if Main_Form.Usedumbterminalrather1.Checked = True then CmdMini := CmdMini + ' -p ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then CmdMini := CmdMini + ' -q ';

  //Vraie commande
  DlCommandLine := DlCommandLine + '"' + Download_Form.Output_Edit.Text + '" -t '
    + COMPort + ' -s ' + SetSize_Form.Size.Text + ' -b ' + SetBaudrate_Form.Baudrate.Text
      + ' -a ' + Address_Form.Address.Text + PutAdvancedCommandLine;

  if Main_Form.ryalternate1152001.Checked = True then DlCommandLine := DlCommandLine + ' -e ';
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then DlCommandLine := DlCommandLine + ' -n ';
  if Main_Form.Usedumbterminalrather1.Checked = True then DlCommandLine := DlCommandLine + ' -p ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then DlCommandLine := DlCommandLine + ' -q ';
  //showmessage(dlcommandline);

  AddTreeNode(Download_Form.Output_Edit.Text, False); //Tree View!

  Main_Form.DownDosCommand.CommandLine := DlCommandLine;
  Main_Form.DownDosCommand.Execute;

//  MaxProgress := ExtractFileSize(FileNameOp) div 8192; //Pour le MAX de la pbar

  //AddDebug(' ');
  AddDebug('CMD:> ' + CmdMini);
  AddToFiltered('CMD:> ' + CmdMini);

  AddDebug('STATE:> Sending download command to DC-TOOL...');
  AddToFiltered('STATE:> Sending download command to DC-TOOL...');

  Download_Form.ModalResult := mrOK;
  if Download_Form.Visible = True then Download_Form.Close;

  WriteFileInHistory(Download_Form.Output_Edit.Text);

  //Progress_Form.Height := 107;

  //Progress_Form.ShowModal;
  DownProgress_Form.Show;
  RestoreForm(DownProgress_Form);
  
  //Main_Form.Abortoperation1.Enabled := True;
  DisactiveControls;
end;

{---------------------------------------------< FIN DES PROCEDURES >------------------------------------------------------------------ }

end.
