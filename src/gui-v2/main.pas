{
  DC-TOOL GUI v2.0 (ancien v1.2)
  
  Reste a traduire les Open Dialogs et tout ca...
}

{
  Pour activer le GD Ripper :
  ---------------------------
  
  1. Activer le menu correspondant (dégriser)
  2. Definir le symbole ci-dessous, dans main.pas & dctoolgui.dpr
  3. Changer la caption en "SPECIAL" pour se souvenir!
  4. Mettre le nom à qui c'est destiné quelque part.
     - Dans la version info.
     - Et egalement dans le fichier (en hexa...).
}

//{$DEFINE SPECIAL_RIP_GD}

unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, XPMan, Menus, DosCommand, ComCtrls, ExtCtrls, tools, idGlobal, ShellApi,
  XPMenu, ImgList, IniFiles, JvRichEd, JvRichEdit, JvComCtrls,
  TFlatHintUnit, AppEvnts;

type
  TMain_Form = class(TForm)
    XPManifest: TXPManifest;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Upload1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Downloadto1: TMenuItem;
    N2: TMenuItem;
    Edit1: TMenuItem;
    Help1: TMenuItem;
    Setadressesto1: TMenuItem;
    Setsizeto1: TMenuItem;
    N3: TMenuItem;
    Setdeviceport1: TMenuItem;
    COM1: TMenuItem;
    COM2: TMenuItem;
    COM3: TMenuItem;
    COM4: TMenuItem;
    Usebautrate1: TMenuItem;
    Options1: TMenuItem;
    ryalternate1152001: TMenuItem;
    Dontattachconsoleandfileserver1: TMenuItem;
    Usedumbterminalrather1: TMenuItem;
    Dontclearscreenbeforedownload1: TMenuItem;
    MainHelp1: TMenuItem;
    About1: TMenuItem;
    UpDosCommand: TDosCommand;
    StatusBar: TStatusBar;
    Config1: TMenuItem;
    Configuration1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    N4: TMenuItem;
    N5: TMenuItem;
    Submitbugsreport1: TMenuItem;
    Websites1: TMenuItem;
    DCTOOLGUI1: TMenuItem;
    DCTOOL1: TMenuItem;
    N6: TMenuItem;
    CygwinDLLs1: TMenuItem;
    PopupMenu: TPopupMenu;
    Savetofile1: TMenuItem;
    SaveDialog: TSaveDialog;
    N7: TMenuItem;
    Cleardebuglog1: TMenuItem;
    XPMenu: TXPMenu;
    Bevel1: TBevel;
    ImageList: TImageList;
    Language1: TMenuItem;
    Splitter: TSplitter;
    twFiles: TJvTreeView;
    pmTree: TPopupMenu;
    Gotoline1: TMenuItem;
    N8: TMenuItem;
    FlatHint: TFlatHint;
    ApplicationEvents: TApplicationEvents;
    Abortoperation1: TMenuItem;
    N9: TMenuItem;
    Copyselectedtext1: TMenuItem;
    History1: TMenuItem;
    mOutput: TJvRichEdit;
    lbSave: TListBox;
    Cleardebuglog2: TMenuItem;
    N10: TMenuItem;
    Reexecute1: TMenuItem;
    N11: TMenuItem;
    Saveoutputas1: TMenuItem;
    N12: TMenuItem;
    Linktype1: TMenuItem;
    Serial1: TMenuItem;
    BroadbandAdapter1: TMenuItem;
    N13: TMenuItem;
    SetcommunicationIPto1: TMenuItem;
    N14: TMenuItem;
    Reset1: TMenuItem;
    Selectall1: TMenuItem;
    Configwizard1: TMenuItem;
    N15: TMenuItem;
    FindDialog: TFindDialog;
    Foundtext1: TMenuItem;
    Findtext1: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    Filters1: TMenuItem;
    Viewfilteredoutputs1: TMenuItem;
    Enablefilters1: TMenuItem;
    Debugview1: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    Copyselectedte1: TMenuItem;
    Selectall2: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    Cleardebug1: TMenuItem;
    Filters3: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    Advanced1: TMenuItem;
    N27: TMenuItem;
    BINstatedetection1: TMenuItem;
    N28: TMenuItem;
    DumpDreamcastBIOS1: TMenuItem;
    N29: TMenuItem;
    DownDosCommand: TDosCommand;
    Options2: TMenuItem;
    DumpDreamcastGD1: TMenuItem;
    N30: TMenuItem;
    DumpDreamcastVMU1: TMenuItem;
    N31: TMenuItem;
    Linktest1: TMenuItem;
    DeleteFLASH1: TMenuItem;
    N32: TMenuItem;
    Sendacommand1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Upload1Click(Sender: TObject);
    procedure Configuration1Click(Sender: TObject);
    procedure UpDosCommandNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure About1Click(Sender: TObject);
    procedure COM1Click(Sender: TObject);
    procedure COM2Click(Sender: TObject);
    procedure COM3Click(Sender: TObject);
    procedure COM4Click(Sender: TObject);
    procedure Downloadto1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Setsizeto1Click(Sender: TObject);
    procedure Setadressesto1Click(Sender: TObject);
    procedure Usebautrate1Click(Sender: TObject);
    procedure ryalternate1152001Click(Sender: TObject);
    procedure Dontattachconsoleandfileserver1Click(Sender: TObject);
    procedure Usedumbterminalrather1Click(Sender: TObject);
    procedure Dontclearscreenbeforedownload1Click(Sender: TObject);
    procedure MainHelp1Click(Sender: TObject);
    procedure Submitbugsreport1Click(Sender: TObject);
    procedure DCTOOLGUI1Click(Sender: TObject);
    procedure DCTOOL1Click(Sender: TObject);
    procedure CygwinDLLs1Click(Sender: TObject);
    procedure Savetofile1Click(Sender: TObject);
    procedure Cleardebuglog1Click(Sender: TObject);
    procedure Language1Click(Sender: TObject);
    procedure Gotoline1Click(Sender: TObject);
    procedure mOutputChange(Sender: TObject);
    procedure twFilesContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure Abortoperation1Click(Sender: TObject);
    procedure Copyselectedtext1Click(Sender: TObject);
    procedure History1Click(Sender: TObject);
    procedure UpDosCommandTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure Cleardebuglog2Click(Sender: TObject);
    procedure Reexecute1Click(Sender: TObject);
    procedure SetcommunicationIPto1Click(Sender: TObject);
    procedure Serial1Click(Sender: TObject);
    procedure BroadbandAdapter1Click(Sender: TObject);
    procedure Reset1Click(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Configwizard1Click(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure Foundtext1Click(Sender: TObject);
    procedure Filters1Click(Sender: TObject);
    procedure Viewfilteredoutputs1Click(Sender: TObject);
    procedure Enablefilters1Click(Sender: TObject);
    procedure Advanced1Click(Sender: TObject);
    procedure BINstatedetection1Click(Sender: TObject);
    procedure DumpDreamcastBIOS1Click(Sender: TObject);
    procedure DownDosCommandTerminated(Sender: TObject;
      ExitCode: Cardinal);
    procedure DownDosCommandNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure Options2Click(Sender: TObject);
    procedure DumpDreamcastGD1Click(Sender: TObject);
    procedure DumpDreamcastVMU1Click(Sender: TObject);
    procedure Linktest1Click(Sender: TObject);
    procedure DeleteFLASH1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Sendacommand1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
    procedure DisplayHint(Sender : TObject);
  public
    { Déclarations publiques }
  end;

var
  Main_Form       : TMain_Form;
  InputPath       : string;
  ChooseLang      : boolean   = True;
  Ini             : TIniFile;
  ParentNode      : TTreeNode = nil;
  FileNameOp      : string    = '';
  DCTOOLIP        : string    = '';
  DCTOOL          : string    = '';
  ShowWizard      : boolean   = False;
  IsQuitting      : boolean   = False;

implementation      

uses r_colors, dctool_cfg, about, upload, progress, download, setsize, address,
  baudrate, lang, utils, ab_dct, history, u_progress, re_execute, setip, bba,
  wizard, filters, u_filters, filtered, advanced, u_ctrls, u_dctool_manager,
  u_kill_dctool, binchk, u_advanced, com_spec, bios, warning, dl_progress,
  u_progress_dl, options, cygwin, gd_ripper, linktest, delflash, openhelp,
  sendcmd;

{$R *.dfm}

procedure TMain_Form.DisplayHint(Sender : TObject);
begin
  if Main_Form.Active = True then
    Main_Form.StatusBar.SimpleText := GetLongHint(Application.Hint);
end;

procedure TMain_Form.FormCreate(Sender: TObject);
begin
  Application.Title := Main_Form.Caption;
  Application.OnHint := DisplayHint;
  InProgress := False;

  PutHeader;
  
 {  AddDebug(Application.Title);
  AddDebug('For SERIAL version only');
  AddDebug('Date : ' + DateToStr(Date) + ' - Time : ' + TimeToStr(Time));
  AddDebug(''); }

  //Ini : langue detection.
  if FileExists(ExtractFilePath(Application.ExeName) + 'config.ini') = False then
    ShowWizard := True;

  //emplacement du fichier des filtres.
  FiltersINI := GetRealPath(ExtractFilePath(Application.ExeName)) + 'filters.flt';

  //Extraire tout le nécessaire à DC-TOOL.
  ExtractAllDCTOOL;

  //Rechoisir la langue
  if ParamCount <> 0 then
  begin
    if LowerCase(ParamStr(1)) = '/chooselang' then
      Ini.WriteString('Config', 'LangID', '');
  end;

  //Permet de limiter le contenu du RichEdit à 2Gb au lieu de 64Kb
  mOutput.MaxLength := $7FFFFFF0;

  //Fermer tous les DC-TOOLs...
  KillAllRunningDCTOOL;

  //Effacer le Splash dans Temp...
  //DeleteSplashScreen; //Plutot dans le OnClose.
end;

procedure TMain_Form.Upload1Click(Sender: TObject);
begin
  Upload_Form.ShowModal;
end;

procedure TMain_Form.Configuration1Click(Sender: TObject);
begin
  Dctool_Form.ShowModal;
  ReadConfig;
end;

procedure TMain_Form.UpDosCommandNewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);

var
  ProgressBar : TProgressBar;

begin
  //MustMinimize := False;
  if NewLine = '' then Exit;
  ProgressBar := UpProgress_Form.ProgressBar;
  
  //ShowMessage('MaxProgress : ' + IntToStr(MaxProgress) + ' - File : ' + FileNameOp);
  
  //Si c'est déjà en progress, on execute la progression en fonction du nb de C
  if InProgress = True then
  begin
    PerformProgress(NewLine, ProgressBar); //execute progression
    if IsProgressCompleted(NewLine, ProgressBar) = True then
      InProgress := False else NewLine := ''; //si fini on met InProgress à false, sinon on n'ajoute pas le texte
    Exit;
  end;

  //Un progress à lancer?
  if IsInProgress(NewLine) = True then
  begin
    InProgress := True;  //oui

    if UpProgress_Form.WindowState = wsMinimized then RestoreForm(UpProgress_Form);

    //HasProgress := True;
    InitProgressBar(ProgressBar);    //initialisation (remise à 0, puis max = 68)
    PerformProgress(NewLine, ProgressBar); //rajouter le nb de carrés necessaires

    //ShowMessage('IN PROGRESS');

    NewLine := '';
    Exit;       //se casser (pas ajouter le texte!)
  end;

  //m.Lines.Add(edit1.Text);

  //Cacher la boite
  //if MustMinimize = True then MinimizeForm(UpProgress_Form);


  if InProgress = False then
    if ProgressBar.Position = ProgressBar.Max then
      if UpProgress_Form.WindowState = wsNormal then MinimizeForm(UpProgress_Form);
    
  //AFFICHER LE TEXTE
  if OutputType = otEntireLine then  //si ligne entière
  begin

    //Seulement si option activée on va filtrer les sorties indésirables
    if EnableFilters1.Checked = True then
    begin
      if IsInFilterList(NewLine) = True then //Ligne filtrée!
      begin
        NewLine := '';
        Exit;
      end;
    end;

    AddDebug('OUTPUT:> ' + NewLine); //Si ligne pas filtrée, on ajoute.

    //if HasProgress = True then MustMinimize := True;
  end;

  NewLine := '';   //effacer le buffer

    //DelLastLine;

  { if OutputType <> otEntireLine then
  begin
    Main_Form.mOutput.Lines[Main_Form.mOutput.Lines.Count - 1] := '';
    AddNewOutput('OUTPUT:> ' + NewLine);
  end else AddDebug('OUTPUT:> ' + NewLine); }

  //if OutputType = otEntireLine then
  //begin
    //DelLastLine;
    //AddDebug('OUTPUT:> ' + NewLine);
  //end else AddNewOutput('OUTPUT:> ' + NewLine);
end;

procedure TMain_Form.FormClose(Sender: TObject; var Action: TCloseAction);
var
  CanDo : integer;

begin
  if UpDosCommand.Active = True then
  begin
    CanDo := MsgBox(UpProgress_Form.Handle, ThereAreCurrentlyAProcessDoYouWantToAbortIt, QuestionCaption, 32 + MB_DEFBUTTON2 + MB_YESNO);
    if CanDo = IDNO then
    begin
      Action := caNone;
      Exit;
    end;
  end;

  if DownDosCommand.Active = True then
  begin
    CanDo := MsgBox(DownProgress_Form.Handle, ThereAreCurrentlyAProcessDoYouWantToAbortIt, QuestionCaption, 32 + MB_DEFBUTTON2 + MB_YESNO);
    if CanDo = IDNO then
    begin
      Action := caNone;
      Exit;
    end;
  end;

  IsQuitting := True;
  DeleteAllDCTOOL;
  DeleteSplashScreen;
end;

procedure TMain_Form.About1Click(Sender: TObject);
begin
  About_Form.ShowModal;
end;

procedure TMain_Form.COM1Click(Sender: TObject);
begin
  COM1.Checked := True;
  COM2.Checked := False;
  COM3.Checked := False;
  COM4.Checked := False;
  WriteCOM;
end;

procedure TMain_Form.COM2Click(Sender: TObject);
begin
  COM1.Checked := False;
  COM2.Checked := True;
  COM3.Checked := False;
  COM4.Checked := False;
  WriteCOM;
end;

procedure TMain_Form.COM3Click(Sender: TObject);
begin
  COM1.Checked := False;
  COM2.Checked := False;
  COM3.Checked := True;
  COM4.Checked := False;
  WriteCOM;
end;

procedure TMain_Form.COM4Click(Sender: TObject);
begin
  COM1.Checked := False;
  COM2.Checked := False;
  COM3.Checked := False;
  COM4.Checked := True;
  WriteCOM;
end;

procedure TMain_Form.Downloadto1Click(Sender: TObject);
begin
  Download_Form.ShowModal;
end;

procedure TMain_Form.Exit1Click(Sender: TObject);
begin
  Main_Form.Close;
  //Halt(0);
end;

procedure TMain_Form.Setsizeto1Click(Sender: TObject);
begin
  SetSize_Form.ShowModal;
end;

procedure TMain_Form.Setadressesto1Click(Sender: TObject);
begin
  Address_Form.ShowModal;
end;

procedure TMain_Form.Usebautrate1Click(Sender: TObject);
begin
  SetBaudrate_Form.ShowModal;
end;

procedure TMain_Form.ryalternate1152001Click(Sender: TObject);
begin
  if ryalternate1152001.Checked = False then
  begin
    SetBaudrate_Form.Baudrate_Label.Caption := IntToStr(SetBaudrate_Form.Baudrate.ItemIndex); 
    SetBaudrate_Form.Baudrate.ItemIndex := 8;
    ryalternate1152001.Checked := True;
  end else
  begin
    SetBaudrate_Form.Baudrate.ItemIndex := StrToInt(SetBaudrate_Form.Baudrate_Label.Caption);
    ryalternate1152001.Checked := False;
  end;

  WriteConfig;
end;

procedure TMain_Form.Dontattachconsoleandfileserver1Click(Sender: TObject);
begin
  if Dontattachconsoleandfileserver1.Checked = False then
    Dontattachconsoleandfileserver1.Checked := True
  else Dontattachconsoleandfileserver1.Checked := False;

  WriteConfig;
end;

procedure TMain_Form.Usedumbterminalrather1Click(Sender: TObject);
begin
  if Usedumbterminalrather1.Checked = False then
    Usedumbterminalrather1.Checked := True
  else Usedumbterminalrather1.Checked := False;

  WriteConfig;
end;

procedure TMain_Form.Dontclearscreenbeforedownload1Click(Sender: TObject);
begin
  if Dontclearscreenbeforedownload1.Checked = False then
    Dontclearscreenbeforedownload1.Checked := True
  else Dontclearscreenbeforedownload1.Checked := False;

  WriteConfig;
end;

procedure TMain_Form.MainHelp1Click(Sender: TObject);
begin
  //WinExec(PChar('Notepad readme.txt'), SW_SHOWNORMAL);
  if FileExists(GetHelpFile) = False then
  begin
    MsgBox(Handle, 'Error : Help file not found.' + WrapStr + 'File name : "' + GetHelpFile + '".', 'Error', 48);
    Exit;
  end;

  ShellExecute(Handle, 'open', PChar(GetHelpFile), '', '', SW_SHOWNORMAL);
end;

procedure TMain_Form.Submitbugsreport1Click(Sender: TObject);
begin
  ShellExecute(handle,'Open',  'mailto:sizious@yahoo.fr?subject=DC-TOOL GUI Bug Report&body=Bugs found in DC-TOOL GUI :','', '',SW_SHOWNORMAL);
end;

procedure TMain_Form.DCTOOLGUI1Click(Sender: TObject);
begin
  ShellExecute(handle,'Open', 'http://www.sbibuilder.fr.st/', '', '', SW_SHOWNORMAL);
end;

procedure TMain_Form.DCTOOL1Click(Sender: TObject);
begin
    ShellExecute(handle,'Open', 'http://adk.napalm-x.com/dc/', '', '', SW_SHOWNORMAL);
end;

procedure TMain_Form.CygwinDLLs1Click(Sender: TObject);
begin
{  if Cygwin_Form.ShowModal = mrOK then
    SaveCygwinConfig;

  LoadCygwinConfig; }  //DELPHI PLANTE PUTAIN!
  
  try
    Cygwin_Form := TCygwin_Form.Create(Self);
    TranslateCygwinDialog;
    LoadCygwinConfig;
    Cygwin_Form.ShowModal;
  finally
    if Cygwin_Form.ModalResult = mrOK then
    begin
      SaveCygwinConfig;
      LoadCygwinConfig;
    end else LoadCygwinConfig;
  end;  

  ExtractAllDCTOOL;
end;

procedure TMain_Form.Savetofile1Click(Sender: TObject);
begin
  SaveRichEditTo(mOutput, SaveDialog);
  
 { if SaveDialog.Execute = True then
  begin
    if SaveDialog.FilterIndex = 1 then
      mOutput.Lines.SaveToFile(SaveDialog.FileName)
    else begin
      lbSave.Items := mOutput.Lines;
      lbSave.Items.SaveToFile(SaveDialog.FileName);
    end;
  end; }
end;

procedure TMain_Form.Cleardebuglog1Click(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, AreYouSureToDeleteOutputs, WarningCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
  if CanDo = IDNO then Exit;

  PutHeader;
end;

procedure TMain_Form.Language1Click(Sender: TObject);
var
  CanContinue : integer;

begin
  CanContinue := MsgBox(Handle, 'The application must be restarted. It will be closed now. Proceed?', 'Question', 32 + MB_YESNO + MB_DEFBUTTON2);
  if CanContinue = IDNO then Exit;
  
  if FileExists(ExtractFilePath(Application.ExeName) + 'lang.exe') = False then
  begin
    MsgBox(Handle, 'Error : File "' + ExtractFilePath(Application.ExeName) + 'lang.exe' + '" not found!' + WrapStr + 'Aborted', 'Error', 16);
    Exit;
  end;

  WinExec(PChar('lang'), SW_SHOWNORMAL);
  Application.Terminate;
end;

procedure TMain_Form.Gotoline1Click(Sender: TObject);
var
  Line : integer;
  CurrentNode : TTreeNode;
  CNodeText   : string;

begin
  //ShowMessage(IntToStr(Mouse.CursorPos.X));
  //CurrentNode := twFiles.GetNodeAt(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  CurrentNode := twFiles.Selected;
  if CurrentNode = nil then
  begin
    //ShowMessage('OK');
    GotoLine1.Enabled := False;
    Exit;
  end;

  //ShowMessage('OK');
  CNodeText := UpperCase(CurrentNode.Text);
  CNodeText := ExtractStr('(', ')', CNodeText);
  Line := StrToInt(CNodeText);
  //ShowMessage(IntToStr(Line));
  GotoLine(mOutput, Line);
end;

procedure TMain_Form.mOutputChange(Sender: TObject);
begin
// SendMessage(mOutput.Handle, WM_VSCROLL, SB_BOTTOM, 0);
// Pas la peine...
end;

procedure TMain_Form.twFilesContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  CurrentNode : TTreeNode;
  //CNodeText   : string;

begin
  CurrentNode := twFiles.GetNodeAt(MousePos.X, MousePos.Y);
  if CurrentNode = nil then
  begin
    GotoLine1.Enabled := False;
    Exit;
  end;

  {CNodeText := UpperCase(CurrentNode.Text);

  if IsInString('BLOCK', CNodeText) = True then
    GotoLine1.Enabled := True
  else GotoLine1.Enabled := False; }

  //if GetConnectionMethod = LINK_TYPE_SERIAL then
  //begin
    //GOTO LINE
  if CurrentNode.ImageIndex = 20 then
    GotoLine1.Enabled := True
  else GotoLine1.Enabled := False;

  //RE-EXECUTE
  if (UpDosCommand.Active = False) and (DownDosCommand.Active = False) then //SI IL Y'A PAS DE TRANSFERT!
  begin
    if (CurrentNode.ImageIndex = 2) or
      (CurrentNode.ImageIndex = 3) then
      Reexecute1.Enabled := True
    else Reexecute1.Enabled := False;
  end;

  //end;

{  if GetConnectionMethod = LINK_TYPE_BBA then
  begin
    ShowMessage('Not implemented for BBA... Be patient :)');
  end; }
end;

procedure TMain_Form.ApplicationEventsException(Sender: TObject;
  E: Exception);
var
  CanContinue : integer;

begin
  CanContinue := MsgBox(Handle, 'Fatal Error : ' + E.Message + WrapStr
    + 'This fatal error was made by DC-TOOL or DC-TOOL-IP and it was transmitted to DC-TOOL GUI.'
     + WrapStr + 'Do you want to shut down DC-TOOL GUI (recommanded) ?', 'Fatal Error', 16 + MB_YESNO);
  if CanContinue = IDNO then Exit;
  Halt(1);
  //killfilename
  //DELETE EXES
end;

procedure TMain_Form.Abortoperation1Click(Sender: TObject);
begin
  if UpDosCommand.Active = True then
    UpProgress_Form.Stop_Button.Click
  else DownProgress_Form.Stop_Button.Click;
end;

procedure TMain_Form.Copyselectedtext1Click(Sender: TObject);
begin
  //Clipboard.SetTextBuf(PChar(mOutput.SelText));
  mOutput.CopyToClipboard;
end;

procedure TMain_Form.History1Click(Sender: TObject);
begin
  History_Form.ShowModal;
end;

procedure TMain_Form.UpDosCommandTerminated(Sender: TObject;
  ExitCode: Cardinal);
var
  State : string;

begin
  if IsQuitting = True then Exit; //On se tire, car on quitte l'appli!
  //si l'objet est détruit on se barre!
  if UpProgress_Form = nil then Exit;
  //if DownProgress_Form = nil then Exit;
  if Main_Form = nil then Exit;

  FileNameOp := '';
  State := 'STATE:> Upload processus completed on ' + DateToStr(Date) + ' - ' + TimeToStr(Now) + ', Exit Code : ' + IntToStr(ExitCode);
  AddDebug(State);
  AddDebug(' ');
  AddToFiltered(State);
  AddToFiltered(' ');

  //ProcessFinished := True;
  if UpProgress_Form <> nil then
  begin
    if UpProgress_Form.Visible = True then
    begin //Progress_Form.ModalResult := mrOK;
      //Progress_Form.Left := 4096;
      //Progress_Form.Top := 4096;
      UpProgress_Form.ProgressBar.Position := 0;
      UpProgress_Form.Hide;   //CLOSE FAIT TOUT BUGGER!
    end;
  end;


  AddEndIndexOfCmd;    //Node à la fin!
  //Progress_Form.Stop_Button.Enabled := True;
  ActiveControls;

  //Effacer le nom du fichier.
  UpProgress_Form.lFileName.Caption := UpProgress_Form.lSaveTo.Caption;

  //AddDebug('KUF KUF');
  //ListBox.Items.Add('OUTPUT:' + DosCommand.OutputLines.GetText);
  //ListBox.Items.Add('OUTPUT:>' + DosCommand.OutputLines.GetText);
end;

procedure TMain_Form.Cleardebuglog2Click(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, AreYouSureToDeleteOutputs, WarningCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
  if CanDo = IDNO then Exit;
  
  PutHeader;
end;

procedure TMain_Form.Reexecute1Click(Sender: TObject);
const
  opUpload    : integer = 0;
  opDownload  : integer = 1;
  
var
  Node      : TTreeNode;
  Operation : integer;

begin
  Node := Main_Form.twFiles.Selected;

  //if (Node = nil) or (Node.ImageIndex <> 2)
  //  or (Node.ImageIndex <> 3) then
  if Node.ImageIndex = 2 then
    Operation := opDownload
  else Operation := opUpload;

  if Node = nil then
  begin
    MsgBox(Main_Form.Handle, PleaseSelectANode, ErrorCaption, 48);
    Exit;
  end;

  if Operation = opDownload then
  begin
    //if GetConnectionMethod = LINK_TYPE_SERIAL then
      ReExecuteDownload(Node)
    //else ShowMessage('Not implemented in BBA now... please be patient :)');
  end else begin
    //if GetConnectionMethod = LINK_TYPE_SERIAL then
      ReExecuteUpload(Node)
    //else ShowMessage('Not implemented in BBA now... please be patient :)');
  end;
end;

procedure TMain_Form.SetcommunicationIPto1Click(Sender: TObject);
begin
  if IP_Form.ShowModal = mrOK then
    WriteIP;

  ReadSavedIP;
end;

procedure TMain_Form.Serial1Click(Sender: TObject);
begin
  EnableSerial;
end;

procedure TMain_Form.BroadbandAdapter1Click(Sender: TObject);
begin
  EnableBBA;
end;

procedure TMain_Form.Reset1Click(Sender: TObject);
var
  CanContinue : integer;
  WinHandle   : HWND;

begin
  if UpDosCommand.Active = True then WinHandle := UpProgress_Form.Handle
    else WinHandle := DownProgress_Form.Handle;

  CanContinue := MsgBox(WinHandle, AreYouSureToResetDCTOOL, QuestionCaption, 48 + MB_YESNO + MB_DEFBUTTON2);
  if CanContinue = IDNO then Exit;

  PerformGeneralReset;
end;

procedure TMain_Form.Selectall1Click(Sender: TObject);
begin
  mOutput.SelectAll;
end;

procedure TMain_Form.Configwizard1Click(Sender: TObject);
begin
  Wizard_Form.ShowModal;
end;

procedure TMain_Form.FindDialogFind(Sender: TObject);
var
  FoundAt         : LongInt;
  StartPos, ToEnd : Integer;

begin
  with mOutput do
  begin
    {commence la recherche après la sélection en cours s'il y en a une }
    {sinon, commence au début du texte }
    if SelLength <> 0 then
      StartPos := SelStart + SelLength
    else StartPos := 0;

    {ToEnd indique la longueur entre StartPos et la fin du texte du contrôle éditeur de texte enrichi }
    ToEnd := Length(Text) - StartPos;

    //FindDialog1.Options
    //if FindDialog1.Options = [frMatchCase];

    FoundAt := FindText(FindDialog.FindText, StartPos, ToEnd, []);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart  := FoundAt;
      SelLength := Length(FindDialog.FindText);
    end else MsgBox(FindDialog.Handle, TextNotFoundOrAllOccurencesFound, InformationCaption, 64);
  end;
end;

procedure TMain_Form.Foundtext1Click(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TMain_Form.Filters1Click(Sender: TObject);
begin
  Filters_Form.ShowModal;
end;

procedure TMain_Form.Viewfilteredoutputs1Click(Sender: TObject);
begin
  Filtered_Form.Show;
end;

procedure TMain_Form.Enablefilters1Click(Sender: TObject);
begin
  if EnableFilters1.Checked = False then
    EnableFilters1.Checked := True
  else EnableFilters1.Checked := False;

  WriteFilters;
end;

procedure TMain_Form.Advanced1Click(Sender: TObject);
begin
  Advanced_Form.ShowModal;
end;

procedure TMain_Form.BINstatedetection1Click(Sender: TObject);
begin
{  if BINCheck_Form.ShowModal = mrOK then
    WriteBINDetectConfig;

  ReadBINDetectConfig; }
  try 
    BINCheck_Form := TBINCheck_Form.Create(Self);
    ReadBINDetectConfig;
    TranslateBinCheckDialog;
    BINCheck_Form.ShowModal;
  finally
    if BINCheck_Form.ModalResult = mrOK then
    begin
      WriteBINDetectConfig;
      ReadBINDetectConfig;
    end else ReadBINDetectConfig;
  end;
end;

procedure TMain_Form.DumpDreamcastBIOS1Click(Sender: TObject);

//***GoDumpBIOS***
procedure GoDumpBIOS;
begin
  DisactiveControls;
  if BIOS_Form.sdBIOS.Execute = True then
    DumpBIOSandFlash(BIOS_Form.sdBIOS.Directory)
  else ActiveControls;
end;

//***MAIN***
begin
  if ReadWarningState('WarningBIOS') = False then
  begin
    if ShowWarningWin(WarningBIOSMessage) = mrOK then
    begin
      SaveWarningState('WarningBIOS');
      GoDumpBIOS;
    end;
  end else GoDumpBIOS;
end;

procedure TMain_Form.DownDosCommandTerminated(Sender: TObject;
  ExitCode: Cardinal);
var
  State : string;

begin
  if IsQuitting = True then Exit; //On se tire.
  //si l'objet est détruit on se barre!
  if DownProgress_Form = nil then Exit;
  //if DownProgress_Form = nil then Exit;
  if Main_Form = nil then Exit;

  FileNameOp := '';
  State := 'STATE:> Download processus completed on ' + DateToStr(Date) + ' - ' + TimeToStr(Now) + ', Exit Code : ' + IntToStr(ExitCode);
  AddDebug(State);
  AddDebug(' ');
  AddToFiltered(State);
  AddToFiltered(' ');

  //ProcessFinished := True;
  if DownProgress_Form <> nil then
  begin
    if DownProgress_Form.Visible = True then
    begin //Progress_Form.ModalResult := mrOK;
      DownProgress_Form.ProgressBar.Position := 0;
      DownProgress_Form.Hide;   //CLOSE FAIT TOUT BUGGER!
    end;
  end;

  AddEndIndexOfCmd;    //Node à la fin!
  ActiveControls;

  //Effacer le nom du fichier.
  DownProgress_Form.lFileName.Caption := DownProgress_Form.lSaveTo.Caption;
end;

procedure TMain_Form.DownDosCommandNewLine(Sender: TObject;
  NewLine: String; OutputType: TOutputType);
var
  ProgressBar : TProgressBar;

begin
  if NewLine = '' then Exit;
  ProgressBar := DownProgress_Form.ProgressBar;

  //Si c'est déjà en progress, on execute la progression en fonction du nb de C
  if InProgress = True then
  begin
    DlPerformProgress(NewLine, ProgressBar); //execute progression
    if DlIsProgressCompleted(NewLine, ProgressBar) = True then
      DlInProgress := False else NewLine := ''; //si fini on met InProgress à false, sinon on n'ajoute pas le texte
    Exit;
  end;

  //Un progress à lancer?
  if DlIsInProgress(NewLine) = True then
  begin
    DlInProgress := True;  //oui
    DlInitProgressBar(ProgressBar, StrToInt(SetSize_Form.Size.Text));    //initialisation (remise à 0, puis max = 68)
    DlPerformProgress(NewLine, ProgressBar); //rajouter le nb de carrés necessaires


    NewLine := '';
    Exit;       //se casser (pas ajouter le texte!)
  end;

  //AFFICHER LE TEXTE
  if OutputType = otEntireLine then  //si ligne entière
  begin

    //Seulement si option activée on va filtrer les sorties indésirables
    if EnableFilters1.Checked = True then
    begin
      if IsInFilterList(NewLine) = True then //Ligne filtrée!
      begin
        NewLine := '';
        Exit;
      end;
    end;

    AddDebug('OUTPUT:> ' + NewLine); //Si ligne pas filtrée, on ajoute.
  end;

  NewLine := '';   //effacer le buffer
end;

procedure TMain_Form.Options2Click(Sender: TObject);
begin
  Options_Form.ShowModal;
end;

procedure TMain_Form.DumpDreamcastGD1Click(Sender: TObject);
begin
  //Fonction désactivée... A cause de tous les problèmes que j'ai eu.

  {$IFDEF SPECIAL_RIP_GD}

  //Faut recréer le GD Ripper, il faut aller dans dctoolgui.dpr et enlever les
  //commentaires devant la CreateForm. Enlever aussi la MsgBox et le Exit d'avant.

  //Edit du 04/01/05 à 22:10 : Definir le symbole SPECIAL_RIP_GD pour activer le GD Ripper.
  //Il faut changer le nom de la caption en SPECIAL et activer le menu (le degriser).

  //Démarrage du GD Ripper.
  if ReadWarningState('WarningGD') = False then
  begin
    if ShowWarningWin(WarningGDRipMessage) = mrOK then
    begin
      SaveWarningState('WarningGD');
      RipGD_Form.ShowModal;
    end;
  end else RipGD_Form.ShowModal;

  {$ELSE}

    MsgBox(Handle, Removed, ErrorCaption, 48);
    Exit;

  {$ENDIF}
end;

procedure TMain_Form.DumpDreamcastVMU1Click(Sender: TObject);
begin
  MsgBox(Handle, Removed, ErrorCaption, 48);
end;

procedure TMain_Form.Linktest1Click(Sender: TObject);
begin
  LinkTest_Form.ShowModal;
end;

procedure TMain_Form.DeleteFLASH1Click(Sender: TObject);
begin
  DelFlash_Form.ShowModal;
end;

procedure TMain_Form.FormActivate(Sender: TObject);
begin
  Application.OnHint := DisplayHint;
end;

procedure TMain_Form.Sendacommand1Click(Sender: TObject);
begin
  SendCmd_Form.ShowModal;
end;

procedure TMain_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.


