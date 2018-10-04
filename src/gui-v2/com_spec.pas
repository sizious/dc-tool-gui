{
  Unit : com_spec
         Commandes spéciales, comme Rip de GD ou RIP de BIOS.
         Transformée en uniquement Dump du BIOS et de la FLASH.
}

//DUMP BIOS : dc-tool -d bios.bin -a 0x0 -s 0x200000
//IMPLEMENTER LA FENETRE BIOS... PUIS CORRIGER LES FONCTION SI DESSOUS.

unit com_spec;

interface

uses
  Windows, SysUtils, FileCtrl, Forms;

const
  BIOS_SIZE       : string  = '2097152';
  FLASH_SIZE      : string  = '131072';
  BIOS_ADDRESS    : string  = '0x0';
  FLASH_ADDRESS   : string  = '0x300000';
  BIOS_FILENAME   : string  = 'DC_BIOS.BIN';
  FLASH_FILENAME  : string  = 'DC_FLASH.BIN';
  CANVAS_LABEL    : integer = 280;

var
  SAVE_DIRECTORY : string = '';
  
//Procédures
procedure DumpBIOS(TargetFile, SetToDir : string);
procedure DumpFLASH(TargetFile, SetToDir : string);
procedure DumpBIOSandFlash(ToDirectory : string);

implementation

uses dctool_cfg, tools, main, progress, baudrate, address, utils, upload,
     download, setsize, u_hist, u_progress, bba, u_filters, u_advanced,
     u_ctrls, bios, dl_progress;

//FINALEMENT, CA SERA QUE POUR LE DOWNLOAD DU BIOS.

//---DownloadCommandSerial---
procedure DownloadCommandSerial(TargetFile, SetToDir, Address, Size : string);
  
var
  DlCommandLine : string;
  COMPort : string;
  Baudrate : string;
  
begin
  //COM Port
  COMPort := GetCOMPort;

  //Baudrate
  Baudrate := GetBaudrate;

  //DCTOOL a utiliser
  if Dctool_Form.External_RadioButton.Checked = True then
    DlCommandLine := Dctool_Form.Location_Edit.Text
  else DlCommandLine := DCTOOL;

  //Opération de download.
  DlCommandLine := DlCommandLine + ' -d ';

  //Mettre le dossier temp.
  SetCurrentDir(GetTempDir);

  //Vraie commande
  DlCommandLine := DlCommandLine + '"' + TargetFile + '" -t '
    + COMPort + ' -s ' + Size + ' -b ' + Baudrate + ' -a ' + Address;

  //Options réelles.
  if Main_Form.ryalternate1152001.Checked = True then DlCommandLine := DlCommandLine + ' -e ';
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then DlCommandLine := DlCommandLine + ' -n ';
  if Main_Form.Usedumbterminalrather1.Checked = True then DlCommandLine := DlCommandLine + ' -p ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then DlCommandLine := DlCommandLine + ' -q ';

  //ShowMessage(DlCommandLine);

  //Executer
  BIOS_Form.dcBIOS.CommandLine := DlCommandLine;
  //ShowMessage(DLCOMMANDLINE);
  BIOS_Form.dcBIOS.Execute;

  //Mettre le nom dans la boite de dialog.
  BIOS_Form.lSaveToDisplay.Caption := BIOS_Form.lSaveTo.Caption + ' ' + MinimizeName(GetBIOSFileName, BIOS_Form.lSaveToDisplay.Canvas, CANVAS_LABEL);

  //Dossier spécifié.
  SetCurrentDir(SetToDir);

  //Afficher la Progress Form...
  //Progress_Form.Height := 107;
  //Progress_Form.Show;
  //RestoreForm(Progress_Form);
{  DisactiveControls;
  if BIOS_Form.Visible = False then BIOS_Form.ShowModal; }
end;

//---DownloadCommandBBA---
procedure DownloadCommandBBA(TargetFile, SetToDir, Address, Size : string);
var
  DlCommandLine : string;

begin
  //Quel DC-TOOL utiliser...?
  if Dctool_Form.External_RadioButton.Checked = True then
    DlCommandLine := Dctool_Form.Location_Edit.Text
  else DlCommandLine := DCTOOLIP;

  //Opération de Download.
  DlCommandLine := DlCommandLine + ' -d ';

  //Mettre dans le dossier.
  SetCurrentDir(GetTempDir);

  //Vraie commande
  DlCommandLine := DlCommandLine + '"' + TargetFile + '" -t ' + ReadIP
    + ' -s ' + Size + ' -a ' + Address;

  //Options vraie commande.
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then
    DlCommandLine := DlCommandLine + ' -n ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then
    DlCommandLine := DlCommandLine + ' -q ';

  //Executer.
  BIOS_Form.dcBIOS.CommandLine := DlCommandLine;
  BIOS_Form.dcBIOS.Execute;

  //Mettre le nom dans la boite de dialog.
  BIOS_Form.lSaveToDisplay.Caption := BIOS_Form.lSaveTo.Caption + ' ' + MinimizeName(GetBIOSFileName, BIOS_Form.lSaveToDisplay.Canvas, CANVAS_LABEL);

  //Mettre dans le dossier.
  SetCurrentDir(SetToDir);
  
  //ShowMessage(DlCommandLine);

  //Afficher la progress form.
  //Progress_Form.Height := 107;
  //Progress_Form.Show;
  //RestoreForm(Progress_Form);
end;

//---DumpBIOS---
procedure DumpBIOS(TargetFile, SetToDir : string);
begin
  if GetConnectionMethod = LINK_TYPE_BBA then
    DownloadCommandBBA(TargetFile, SetToDir, BIOS_ADDRESS, BIOS_SIZE)
  else DownloadCommandSerial(TargetFile, SetToDir, BIOS_ADDRESS, BIOS_SIZE);
end;

//-------DumpFLASH-------
procedure DumpFLASH(TargetFile, SetToDir : string);
{ var
   i             : integer; }
   
//***DumpFlashWithSerial***
procedure DumpFlashWithSerial(TargetFile, SetToDir : string);
var
  DlCommandLine : string;
  COMPort       : string;
  Baudrate      : string;
  
begin
  //COM Port
  COMPort := GetCOMPort;

  //Baudrate
  Baudrate := GetBaudrate;
  
  //Quel DC-TOOL utiliser...?
  if Dctool_Form.External_RadioButton.Checked = True then
    DlCommandLine := Dctool_Form.Location_Edit.Text
  else DlCommandLine := DCTOOL;

  //Opération de Download.
  DlCommandLine := DlCommandLine + ' -d ';

  //Mettre dans le dossier.
  SetCurrentDir(GetTempDir);

  //Vraie commande
  DlCommandLine := DlCommandLine + '"' + TargetFile + '" -t '
    + COMPort + ' -s ' + FLASH_SIZE + ' -b ' + Baudrate + ' -a ' + FLASH_ADDRESS;

  //Options réelles.
  if Main_Form.ryalternate1152001.Checked = True then DlCommandLine := DlCommandLine + ' -e ';
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then DlCommandLine := DlCommandLine + ' -n ';
  if Main_Form.Usedumbterminalrather1.Checked = True then DlCommandLine := DlCommandLine + ' -p ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then DlCommandLine := DlCommandLine + ' -q ';

  //Executer.
  BIOS_Form.dcFLASH.CommandLine := DlCommandLine;
  BIOS_Form.dcFLASH.Execute;
  Application.ProcessMessages;
  
  //Mettre le nom dans la boite de dialog.
  BIOS_Form.lSaveToDisplay.Caption := BIOS_Form.lSaveTo.Caption + ' ' + MinimizeName(GetFLASHFileName, BIOS_Form.lSaveToDisplay.Canvas, CANVAS_LABEL);

  //Mettre dans le dossier.
  SetCurrentDir(SetToDir);
end;

//***DumpFlashWithBBA***
procedure DumpFlashWithBBA(TargetFile, SetToDir : string);
var
  DlCommandLine : string;

begin
  //Quel DC-TOOL utiliser...?
  if Dctool_Form.External_RadioButton.Checked = True then
    DlCommandLine := Dctool_Form.Location_Edit.Text
  else DlCommandLine := DCTOOLIP;

  //Opération de Download.
  DlCommandLine := DlCommandLine + ' -d ';

  //Mettre dans le dossier.
  SetCurrentDir(GetTempDir);

  //Vraie commande
  DlCommandLine := DlCommandLine + '"' + TargetFile + '" -t ' + ReadIP
    + ' -s ' + FLASH_SIZE + ' -a ' + FLASH_ADDRESS;

  //Options vraie commande.
  if Main_Form.Dontattachconsoleandfileserver1.Checked = True then
    DlCommandLine := DlCommandLine + ' -n ';
  if Main_Form.Dontclearscreenbeforedownload1.Checked = True then
    DlCommandLine := DlCommandLine + ' -q ';

  //Executer.
  BIOS_Form.dcFLASH.CommandLine := DlCommandLine;
  BIOS_Form.dcFLASH.Execute;
  Application.ProcessMessages;

  //Mettre le nom dans la boite de dialog.
  BIOS_Form.lSaveToDisplay.Caption := BIOS_Form.lSaveTo.Caption + ' ' + MinimizeName(GetFLASHFileName, BIOS_Form.lSaveToDisplay.Canvas, CANVAS_LABEL);

  //Mettre dans le dossier.
  SetCurrentDir(SetToDir);
end;

//***MAIN***
begin
{  i := -100000;
  repeat
    Application.ProcessMessages;
    i := i + 1;
    if BIOS_Form.dcBIOS.Active = False then break;
  until i = 0; }

  if GetConnectionMethod = LINK_TYPE_BBA then
    DumpFlashWithBBA(TargetFile, SetToDir)
  else DumpFlashWithSerial(TargetFile, SetToDir);
end;

//---DumpBIOSandFlash---
procedure DumpBIOSandFlash(ToDirectory : string);
var
  CanDo : integer;

begin
  SAVE_DIRECTORY := GetRealPath(ToDirectory);

  //Le fichier BIOS existe?
  if FileExists(SAVE_DIRECTORY + BIOS_FILENAME) = True then
  begin
    CanDo := MsgBox(BIOS_Form.Handle, TheBiosFilenameExistsInThisDirectory
      + WrapStr + OverwriteIt, WarningCaption, 48 + MB_YESNO + MB_DEFBUTTON2);
    if CanDo = IDNO then Exit;
  end;

  //Le fichier FLASH existe?
  if FileExists(SAVE_DIRECTORY + FLASH_FILENAME) = True then
  begin
    CanDo := MsgBox(BIOS_Form.Handle, TheFlashFilenameExistsInThisDirectory
      + WrapStr + OverwriteIt, WarningCaption, 48 + MB_YESNO + MB_DEFBUTTON2);
    if CanDo = IDNO then Exit;
  end;

  if BIOS_Form.Visible = False then BIOS_Form.ShowModal;
end;

end.
