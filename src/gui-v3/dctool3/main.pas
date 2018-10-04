unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ComCtrls, StdCtrls, SynEdit, DCTool,
  SynEditHighlighter, ImgList, U_Config, ToolWin, XPMan, AppEvnts, XPMenu,
  SynBookMarkView, DcToolHistoryView, MultiSynPageControl, DcToolLogRichEdit,
  DcToolCygWinCfg, ShellApi, SynEditRegexSearch, SynEditMiscClasses,
  SynEditSearch, SynDcTool;

const
  MAIN_FORM_CAPTION : string = 'DC-TOOL GUI - Version 3.0 WIP - BETA 1 - (C)reated by [big_fury]SiZiOUS';
  WM_PARAMETRE = WM_USER + 1;
   
type
  TMain_Form = class(TForm)
    mmMain: TMainMenu;
    File1: TMenuItem;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    cbMain: TCoolBar;
    tbrMain: TToolBar;
    ToolButton1: TToolButton;
    tbUpload: TToolButton;
    Image5: TImage;
    sbMain: TStatusBar;
    HSplitter: TSplitter;
    pLeft: TPanel;
    pcMain: TPageControl;
    tsBookmarks: TTabSheet;
    tsHistory: TTabSheet;
    tsELF: TTabSheet;
    tvELF: TTreeView;
    VSplitter: TSplitter;
    DCTool: TDCTool;
    pBottom: TPanel;
    Image6: TImage;
    Image7: TImage;
    pbTransfer: TProgressBar;
    miUpload: TMenuItem;
    tbDownload: TToolButton;
    ToolButton4: TToolButton;
    miDownload: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Linktest1: TMenuItem;
    miSendACommand: TMenuItem;
    miReset: TMenuItem;
    miAbortOperation: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Edit1: TMenuItem;
    Linktype: TMenuItem;
    LinkType0: TMenuItem;
    LinkType1: TMenuItem;
    LinkType2: TMenuItem;
    N4: TMenuItem;
    Setdeviceport: TMenuItem;
    COM0: TMenuItem;
    COM1: TMenuItem;
    COM2: TMenuItem;
    COM3: TMenuItem;
    Setbaudrate: TMenuItem;
    Baudrate0: TMenuItem;
    Baudrate1: TMenuItem;
    Baudrate2: TMenuItem;
    Baudrate3: TMenuItem;
    Baudrate4: TMenuItem;
    Baudrate5: TMenuItem;
    Baudrate6: TMenuItem;
    Baudrate7: TMenuItem;
    Baudrate8: TMenuItem;
    N5: TMenuItem;
    SetBBAIP: TMenuItem;
    miAlternateBaudrate: TMenuItem;
    Debug1: TMenuItem;
    miCopyText: TMenuItem;
    miSelectAll: TMenuItem;
    N6: TMenuItem;
    miFindText: TMenuItem;
    N7: TMenuItem;
    miSaveLog: TMenuItem;
    miClearDebugLog: TMenuItem;
    miReexcuteLast: TMenuItem;
    Config1: TMenuItem;
    Wizardconfig1: TMenuItem;
    N10: TMenuItem;
    DCTOOLlocation1: TMenuItem;
    Cygwinlibraries1: TMenuItem;
    BINstatedetection1: TMenuItem;
    N11: TMenuItem;
    Options1: TMenuItem;
    N12: TMenuItem;
    Language1: TMenuItem;
    Help1: TMenuItem;
    Filters1: TMenuItem;
    Mainhelp1: TMenuItem;
    N13: TMenuItem;
    Submitbugsreport1: TMenuItem;
    Websites1: TMenuItem;
    DCTOOLGUI1: TMenuItem;
    DCTOOL1: TMenuItem;
    N14: TMenuItem;
    About1: TMenuItem;
    Configure1: TMenuItem;
    N15: TMenuItem;
    Viewfilteredoutputs1: TMenuItem;
    Highlighterconfig1: TMenuItem;
    ilMenu: TImageList;
    tbReexcuteLast: TToolButton;
    Historiesconfig1: TMenuItem;
    N16: TMenuItem;
    tPercent: TTimer;
    tbAbortOperation: TToolButton;
    ToolButton7: TToolButton;
    Options2: TMenuItem;
    miUseDumbTerminal: TMenuItem;
    N17: TMenuItem;
    miAttachConsoleAndFileserver: TMenuItem;
    miClearScreenBeforeDownload: TMenuItem;
    aeMain: TApplicationEvents;
    tbReset: TToolButton;
    N9: TMenuItem;
    miCloseAllTabs: TMenuItem;
    SynBookMarkView: TSynBookMarkView;
    pmBookMarks: TPopupMenu;
    miBmGoto: TMenuItem;
    N19: TMenuItem;
    miBmDelete: TMenuItem;
    miBmEnabled: TMenuItem;
    N20: TMenuItem;
    DcToolHistoryView: TDcToolHistoryView;
    ilHistoryView: TImageList;
    pmHistory: TPopupMenu;
    miHistReExecute: TMenuItem;
    N21: TMenuItem;
    Clearall1: TMenuItem;
    miHistDelete: TMenuItem;
    ilELF: TImageList;
    N22: TMenuItem;
    miFileInUseProtectionForUpload: TMenuItem;
    tbCopyText: TToolButton;
    tbSelectAll: TToolButton;
    ToolButton6: TToolButton;
    tbSearchText: TToolButton;
    ToolButton9: TToolButton;
    tbSaveFile: TToolButton;
    ToolButton11: TToolButton;
    tbClearDebug: TToolButton;
    ToolButton13: TToolButton;
    pmMultiSyn: TPopupMenu;
    pmCloseTab: TMenuItem;
    N23: TMenuItem;
    seOutputs: TSynEdit;
    multiSyn: TMultiSynPageControl;
    reLog: TDcToolLogRichEdit;
    DcToolCygWinCfg: TDcToolCygWinCfg;
    sdLog: TSaveDialog;
    sdSyn: TSaveDialog;
    miSeCopyText: TMenuItem;
    miSeSelectAll: TMenuItem;
    N18: TMenuItem;
    miSeSave: TMenuItem;
    tiUpdateApp: TTimer;
    N24: TMenuItem;
    Debug2: TMenuItem;
    N25: TMenuItem;
    miCloseUselessTabs: TMenuItem;
    miCloseCurrent: TMenuItem;
    N26: TMenuItem;
    SynEditSearch: TSynEditSearch;
    SynEditRegexSearch: TSynEditRegexSearch;
    miSearchForward: TMenuItem;
    miSearchBackward: TMenuItem;
    N27: TMenuItem;
    miOpenDir: TMenuItem;
    FindDialog: TFindDialog;
    ToolButton2: TToolButton;
    tbCloseCurrent: TToolButton;
    miSeFindText: TMenuItem;
    N8: TMenuItem;
    miSeSearchForward: TMenuItem;
    miSeSearchBackward: TMenuItem;
    tbSearchForward: TToolButton;
    tbSearchBackward: TToolButton;
    pmDebugLog: TPopupMenu;
    Copy1: TMenuItem;
    Selectall1: TMenuItem;
    N28: TMenuItem;
    Findtext1: TMenuItem;
    Searchforward1: TMenuItem;
    N29: TMenuItem;
    Save1: TMenuItem;
    XPMenu: TXPMenu;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure miUploadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DCToolNewDcToolLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure DCToolNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure DCToolDetectingFileFormat(Sender: TObject;
      FileInfo: TFileFormat);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Exit1Click(Sender: TObject);
    procedure DCToolStart(Sender: TObject; OperationType: TOperationType);
    procedure DCToolTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure Options1Click(Sender: TObject);
    procedure tPercentTimer(Sender: TObject);
    procedure DCToolProgressEnd(Sender: TObject);
    procedure DCToolProgressBegin(Sender: TObject; MaxSize: Integer);
    procedure miAbortOperationClick(Sender: TObject);
    procedure miResetClick(Sender: TObject);
    procedure Baudrate8Click(Sender: TObject);
    procedure miAlternateBaudrateClick(Sender: TObject);
    procedure DCToolCreateCommandLine(Sender: TObject;
      CommandLine: String);
    procedure LinkType0Click(Sender: TObject);
    procedure COM0Click(Sender: TObject);
    procedure SetBBAIPClick(Sender: TObject);
    procedure miCopyTextClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure aeMainException(Sender: TObject; E: Exception);
    procedure miAttachConsoleAndFileserverClick(Sender: TObject);
    procedure DCToolEndDcToolLines(Sender: TObject);
    procedure miDownloadClick(Sender: TObject);
    procedure Historiesconfig1Click(Sender: TObject);
    procedure miReexcuteLastClick(Sender: TObject);
    procedure DCToolReseting(Sender: TObject);
    procedure DCToolReseted(Sender: TObject);
    procedure aeMainHint(Sender: TObject);
    procedure Highlighterconfig1Click(Sender: TObject);
    procedure miBmGotoClick(Sender: TObject);
    procedure miBmEnabledClick(Sender: TObject);
    procedure SynBookMarkViewContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure miBmDeleteClick(Sender: TObject);
    procedure miHistReExecuteClick(Sender: TObject);
    procedure DcToolHistoryViewReReset(Sender: TObject;
      ReExecuteNode: TTreeNode);
    procedure DcToolHistoryViewReDownload(Sender: TObject;
      ReExecuteNode: TTreeNode);
    procedure DcToolHistoryViewReUpload(Sender: TObject;
      ReExecuteNode: TTreeNode; Execute: Boolean);
    procedure DcToolHistoryViewContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure miHistDeleteClick(Sender: TObject);
    procedure DCTOOLlocation1Click(Sender: TObject);
    procedure Cygwinlibraries1Click(Sender: TObject);
    procedure miCloseTabClick(Sender: TObject);
    procedure DCToolAborting(Sender: TObject);
    procedure DCToolAborted(Sender: TObject);
    procedure Mainhelp1Click(Sender: TObject);
    procedure BINstatedetection1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure miSaveLogClick(Sender: TObject);
    procedure miCloseAllTabsClick(Sender: TObject);
    procedure tiUpdateAppTimer(Sender: TObject);
    procedure miCloseUselessTabsClick(Sender: TObject);
    procedure multiSynContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure DCTOOLGUI1Click(Sender: TObject);
    procedure miFindTextClick(Sender: TObject);
    procedure miSearchForwardClick(Sender: TObject);
    procedure miSearchBackwardClick(Sender: TObject);
    procedure miSendACommandClick(Sender: TObject);
    procedure miOpenDirClick(Sender: TObject);
    procedure Clearall1Click(Sender: TObject);
    procedure miClearDebugLogClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure DCTOOL1Click(Sender: TObject);
    procedure Submitbugsreport1Click(Sender: TObject);
  private
    { Déclarations privées }
    FirstUploadExecute : boolean;
    FCurrentPath : string;
    FHL : TSynDcToolSyn;
    ApplicationIsQuitting : boolean;
    FirstRunCmdLine : boolean;

    procedure FreeSynEdit;
    procedure InitSynEdit;
    procedure InitProgressBar;
    //procedure InitDcToolLog; //il descend en public (voir remarque dans le FormCreate)
    procedure ChangeBaudrate(Sender : TMenuItem);
    procedure ChangeLinkType(Sender : TMenuItem);
    procedure ChangeComPort(Sender : TMenuItem);
  public
    { Déclarations publiques }
    procedure ChangeStateActionsMenuItems(State : boolean);
    procedure ChangeStatusText(TxtInfo : string);
    procedure GetParamList(var Msg : TMessage); message WM_PARAMETRE;
    procedure AddNewSynEditLogForUploadExecute;
    procedure InitDcToolLog;
  end;

var
  Main_Form: TMain_Form;

implementation

uses
  Upload, Options, Utils, ipcfg, excptlog, download, history,
  highlights, dct_loc, u_dctool_wrapper, cygwin, Config, bincheck,
  parammgr, u_preset, u_search, u_dctool_binchk, aboutprg;

{$R *.dfm}

//------------------------------------------------------------------------------

procedure TMain_Form.FormCreate(Sender: TObject);
begin
  pcMain.ActivePageIndex := 0;
  FirstUploadExecute := True;
  FCurrentPath := GetCurrentDir; //garder la path original
  FirstRunCmdLine := True;
  
  Main_Form.Caption := MAIN_FORM_CAPTION;
  Application.Title := Main_Form.Caption;

  sbMain.Panels[3].Text := ''; //panel du 100%

  Self.tsELF.TabVisible := False; //à l'execution on veut pas ça!
  //seulement si un elf est uploadé.

  //InitDcToolLog; ->
  //Etant donné que le CreateForm se produit avant ConfigureApplication, le titre
  //du log perd ses attributs. Il faut donc déplacer cela ailleurs.
  InitProgressBar;
  InitSynEdit;

  //Va servir pour éviter de mettre des trucs "aborted" dans le log
  //à la sortie de l'application.
  ApplicationIsQuitting := False;
end;

//------------------------------------------------------------------------------

//Coloration Syntaxique.
procedure TMain_Form.FreeSynEdit;
begin
  if Assigned(FHL) then FreeAndNil(FHL);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.InitSynEdit;
var
  SE : TSynEdit;

begin
  FHL := TSynDcToolSyn.Create(Self);
  seOutputs.Highlighter := FHL;

  multiSyn.AddNewPage('Welcome');
  SE := multiSyn.GetLastSynEdit;

  if Assigned(SE.Highlighter) then
    SE.Lines.SetText(PChar(SE.Highlighter.SampleSource));
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miUploadClick(Sender: TObject);
var
  CanDo   : integer;
  //Target  : string;
  Current,
  Saved : boolean;
  
begin
  //Afficher la feuille.
  //Upload_Form.SetFocus;
  CanDo := Upload_Form.ShowModal;
  if CanDo = mrCancel then Exit;

  //seOutputs.Clear;  //option !

  DCTool.FileName := Upload_Form.cbxTargetFile.Text;

  //Copy Protection
  Saved := DCTool.UploadOptions.FileInUseProtection;
  if not Upload_Form.cbDisableCopyProtection.Checked then
      Current := Main_Form.miFileInUseProtectionForUpload.Checked
  else Current := False; //ça désactive automatiquement car le mec le veut !
  DCTool.UploadOptions.FileInUseProtection := Current;

  //Execute Address
  if Upload_Form.cbAddr.Checked then
    DCTool.UploadOptions.ExecuteAddress := Upload_Form.eAddr.Text
  else DCTool.UploadOptions.ExecuteAddress := DCTool.UploadOptions.GetDefaultAddress;

  //ISO Redirection
  if Upload_Form.cbIso.Checked then
  begin
    DCTool.IsoRedirection.Enabled := True;
    DCTool.IsoRedirection.IsoFile := Upload_Form.cbxIso.Text;
  end else DCTool.IsoRedirection.Enabled := False;

  //Chroot to Path
  if Upload_Form.cbChroot.Checked then
  begin
    DCTool.ChRoot.Enabled := True;
    DCTool.ChRoot.Path := Upload_Form.cbxChroot.Text;
  end else DCTool.ChRoot.Enabled := False;

  //Dossier de travail de Windows
  if Upload_Form.cbWorkdir.Checked then
  begin
    SetCurrentDir(Upload_Form.cbxWorkdir.Text);
  end else SetCurrentDir(GetDefaultWorkDir);

  Main_Form.DCTool.UploadOptions.ExecuteAfterUpload :=
    Upload_Form.cbExecute.Checked;

  //AddNewSynEditLogForUploadExecute;

  //go !
  DCTool.Upload;
  DCTool.UploadOptions.FileInUseProtection := Saved;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.FormDestroy(Sender: TObject);
begin
  FreeSynEdit;
  ExitApplication;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.InitProgressBar;
const
  PANEL_INDEX : integer = 2;

var
  i, Size : integer;

begin
  sbMain.Panels[PANEL_INDEX].Text := '';
  
  //pour que le ProgressBar se place sur le StatuBar
  pbTransfer.Parent := sbMain;

  // le placement de la ProgressBar se fait maintenant par rapport au StatusBar
  Size := 0;

  for i := 0 to PANEL_INDEX - 1 do
    Size := Size + sbMain.Panels[i].Width;

  pbTransfer.SetBounds(Size + 2, 2,
    sbMain.Panels[PANEL_INDEX].Width - 6, sbMain.Height - 3);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolNewDcToolLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
begin
  if ApplicationIsQuitting then Exit;
  
  if OutputType = otEntireLine then
  begin
    if NewLine = '' then Exit;
    
    reLog.LinesType.Log.AddNewEventLine(NewLine);
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolNewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
var
  CurrSyn : TSynEdit;

begin
  //SHOWMESSAGE('IL SEMBLERAIS QUE LA CREATION NE S''EFFECTUE PAS CORRECTEMENT...');
  //EXIT;
  
  if ApplicationIsQuitting then Exit;

  CurrSyn := multiSyn.GetLastSynEdit;

  if OutputType = otEntireLine then
    CurrSyn.Lines.Add(NewLine);

  if not CurrSyn.Focused then
    SendMessage(CurrSyn.Handle, WM_VSCROLL, SB_BOTTOM, 0);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.InitDcToolLog;
begin
  reLog.InitLog.Enabled := True;
  reLog.InitLog.LogTitle := Application.Title;
  reLog.InitLog.DescLines.Add('Broadband Adapter and Serial Cable supported - Axlen''USB'
   + ' Cable prepared to implement');
  reLog.InitLog.DescLines.Add('See about box for credits, thanks.');

  reLog.InitLog.DoInitLog;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolDetectingFileFormat(Sender: TObject;
  FileInfo: TFileFormat);
var
  Index : integer;

begin
  Index := pcMain.ActivePageIndex;

  if FileInfo = ffELF then
    tsELF.TabVisible := True
  else tsELF.TabVisible := False;

  pcMain.ActivePageIndex := Index;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  ApplicationIsQuitting := True;
  DCTool.Stop;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.Exit1Click(Sender: TObject);
begin
  Close;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolStart(Sender: TObject;
  OperationType: TOperationType);
begin
  ChangeStateActionsMenuItems(False);

  tsELF.TabVisible := False;
  
  case OperationType of
    otDownload      : ChangeStatusText('Downloading...');
    otUpload        : ChangeStatusText('Uploading without execute...');
    otUploadExecute : begin
                        ChangeStatusText('Uploading...');
                        AddNewSynEditLogForUploadExecute;
                      end;
    otReset         : ChangeStatusText('Reseting...');
  end;

  //Ajouter une node dans l'historique.
  DcToolHistoryView.AddNewHistoryNode;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolTerminated(Sender: TObject; ExitCode: Cardinal);
var
  Line : string;

begin
  if ApplicationIsQuitting then Exit;

  ChangeStatusText('Idle...');
  pbTransfer.Position := 0;
  sbMain.Panels[3].Text := '';

  //message de fin...
  case DCTool.GetLastOperation of
    otUpload        : Line := 'Upload without execute';
    otUploadExecute : Line := 'Upload';
    otDownload      : Line := 'Download';
    otReset         : Line := 'Reseting';
  end;

  if Line <> '' then
  begin
    Line := Line + ' processus completed on ' + DateToStr(Date) + ' - '
      + TimeToStr(Time) + ', Exit Code : ' + IntToStr(ExitCode);

    reLog.LinesType.State.AddNewEventLine(Line);
  end;

  //ligne de fin (séparation)...
  reLog.Lines.Add('');

  //Remettre le dossier original CurrentDir
  SetCurrentDir(FCurrentPath);

  //Attendre un peu...
  Application.ProcessMessages;

  //Réactivation
  ChangeStateActionsMenuItems(True);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.Options1Click(Sender: TObject);
var
  mr : TModalResult;

begin
  with Options_Form do
  begin
    SaveFile.LoadOptions;

    mr := ShowModal;
    if mr = mrCancel then Exit;

    SaveFile.SaveOptions;
  end;
end;
 
//------------------------------------------------------------------------------

procedure TMain_Form.tPercentTimer(Sender: TObject);
begin
  sbMain.Panels[3].Text := IntToStr(GivePercent(pbTransfer.Position,
    pbTransfer.Max)) + '%';
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolProgressEnd(Sender: TObject);
begin
  sbMain.Panels[3].Text := '100%';
  tPercent.Enabled := False;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolProgressBegin(Sender: TObject;
  MaxSize: Integer);
begin
  tPercent.Enabled := True;
end;
 
//------------------------------------------------------------------------------

procedure TMain_Form.ChangeStateActionsMenuItems(State : boolean);
begin
  Self.miUpload.Enabled := State;
  Self.miDownload.Enabled := State;
  Self.Config1.Enabled := State;
  Self.Linktest1.Enabled := State;
  Self.Edit1.Enabled := State;
  Self.Configure1.Enabled := State;
  Self.miReexcuteLast.Enabled := State;
  Self.miSendACommand.Enabled := State;
  Self.Options2.Enabled := State;
  tbUpload.Enabled := State;
  tbDownload.Enabled := State;
  tbReexcuteLast.Enabled := State;

  Self.miAbortOperation.Enabled := not State;
  tbAbortOperation.Enabled := not State;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miAbortOperationClick(Sender: TObject);
begin
  DCTool.Abort;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miResetClick(Sender: TObject);
var
  CanDo : integer;

begin
  if DCTool.DosComm.Active then
  begin

    CanDo := MsgBox(Handle, 'Are you sure to reset DC-TOOL GUI ?'
      + WrapStr + 'The current process''ll be killed.', 'Warning',
        48 + MB_YESNO + MB_DEFBUTTON2);
    if CanDo = IDNO then Exit;

  end else begin

    CanDo := MsgBox(Handle, 'Are you sure to reset DC-TOOL GUI ?',
      'Question', 32 + MB_YESNO);
    if CanDo = IDNO then Exit;
  end;
  
  DCTool.Reset;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.ChangeBaudrate(Sender: TMenuItem);
var
  i : integer;

begin
  for i := 0 to Integer(High(TBaudrate)) do
    (Self.FindComponent('Baudrate' + IntToStr(i)) as TMenuItem).Checked := False;

  Sender.Checked := True;
  DCTool.Serial.Baudrate := TBaudrate(Sender.Tag);

  //Activer l'alternate si c'est 115200...
  if DCTool.ConnectionType = ctSerial then

    if TBaudrate(Sender.Tag) = b115200 then
      miAlternateBaudrate.Enabled := True
    else miAlternateBaudrate.Enabled := False;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.Baudrate8Click(Sender: TObject);
begin
  ChangeBaudrate(Sender as TMenuItem);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miAlternateBaudrateClick(Sender: TObject);
var
  Menu : TMenuItem;

begin
  Menu := (Sender as TMenuItem);

  Menu.Checked := not Menu.Checked;
  DCTool.Serial.AlternateBaudrate := Menu.Checked;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolCreateCommandLine(Sender: TObject;
  CommandLine: String);
begin
  reLog.LinesType.Command.AddNewEventLine(CommandLine);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.ChangeLinkType(Sender: TMenuItem);
var
  i : integer;

begin
  for i := 0 to Integer(High(TConnectionType)) do   //FindComponent = bricolage !!! :pp
    (Self.FindComponent('LinkType' + IntToStr(i)) as TMenuItem).Checked := False;

  Sender.Checked := True;
  DCTool.ConnectionType := TConnectionType(Sender.Tag);

  //activer ou désactiver l'IP en fonction de la ConnectionType
  if DCTool.ConnectionType = ctBBA then
  begin
    SetBBAIP.Enabled := True;
    miAlternateBaudrate.Enabled := not SetBBAIP.Enabled;
  end else begin
    SetBBAIP.Enabled := False;

    if DCTool.Serial.Baudrate = b115200 then
      miAlternateBaudrate.Enabled := not SetBBAIP.Enabled;
  end;

  //activer en fonction de l'état de BBA IP.
  Setdeviceport.Enabled := not SetBBAIP.Enabled;
  Setbaudrate.Enabled := not SetBBAIP.Enabled;

  miUseDumbTerminal.Enabled := DCTool.ConnectionType = ctSerial;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.LinkType0Click(Sender: TObject);
begin
  ChangeLinkType(Sender as TMenuItem);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.ChangeComPort(Sender: TMenuItem);
var
  i : integer;

begin
  for i := 0 to Integer(High(TComPort)) do
    (Self.FindComponent('COM' + IntToStr(i)) as TMenuItem).Checked := False;

  Sender.Checked := True;
  DCTool.Serial.ComPort := TComPort(Sender.Tag);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.COM0Click(Sender: TObject);
begin
  ChangeComPort(Sender as TMenuItem);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.SetBBAIPClick(Sender: TObject);
var
  ModalResult : TModalResult;
  IPCfg_Form  : TIPCfg_Form;

begin
  {ModalResult := IPCfg_Form.ShowModal;
  if ModalResult = mrCancel then Exit; }

  //Créee dynamiquement, inutile de l'avoir tout le temps en mémoire.
  IPCfg_Form := TIPCfg_Form.Create(Application);
  try
    IpCfg_Form.eIP.Text := Main_Form.DCTool.BroadBand.IPAddress;
    
    ModalResult := IPCfg_Form.ShowModal;
    if ModalResult = mrCancel then Exit;
    
    DCTool.BroadBand.IPAddress := IPCfg_Form.eIP.Text;
  finally
    IPCfg_Form.Free;
  end;
  
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miCopyTextClick(Sender: TObject);
var
  Cmp : TComponent;

begin
  Cmp := Self.ActiveControl;

  if not Assigned(Cmp) or not (Cmp is TComponent) then Exit;

  if (Cmp is TRichEdit) then
    (Cmp as TRichEdit).CopyToClipboard;

  if (Cmp is TSynEdit) then
    (Cmp as TSynEdit).CopyToClipboard;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miSelectAllClick(Sender: TObject);
var
  Cmp : TComponent;

begin
  Cmp := Self.ActiveControl;
  if not Assigned(Cmp) or not (Cmp is TComponent) then Exit;

  if (Cmp is TRichEdit) then
    (Cmp as TRichEdit).SelectAll;

  if (Cmp is TSynEdit) then
    (Cmp as TSynEdit).SelectAll;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.aeMainException(Sender: TObject; E: Exception);
begin
  Except_Form.reExcept.Lines.Add(DateToStr(Date) + ' | ' + TimeToStr(Time)
    + ' [' + Sender.ClassName + '] : ' + E.Message);
  //Except_Form.ShowModal;
  //Except_Form.Show;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.ChangeStatusText(TxtInfo: string);
begin
  sbMain.Panels[1].Text := TxtInfo;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miAttachConsoleAndFileserverClick(Sender: TObject);
var
  MI : TMenuItem;

begin
  MI := (Sender as TMenuItem);

  MI.Checked := not MI.Checked;

  //Activer la bonne propriété..
  case MI.Tag of
    0 : DCTool.Options.UseDumbTerminal := MI.Checked;
    1 : DCTool.Options.AttachFileServer := MI.Checked;
    2 : DCTool.Options.ClrScrBeforeDownload := MI.Checked;
    3 : DCTool.UploadOptions.FileInUseProtection := MI.Checked;
  end;

end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolEndDcToolLines(Sender: TObject);
begin
  if DCTool.GetLastOperation = otUploadExecute then
    ChangeStatusText('Executing...');  
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miDownloadClick(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := Download_Form.ShowModal;
  if CanDo = mrCancel then Exit;

  //mettre le fichier
  with Download_Form do
  begin
    DCTool.FileName := cbxTargetFile.Text;

    //mettre l'adresse & la taille
    DCTool.DownloadOptions.FileSize := StrToIntDef(eSize.Text,
      Main_Form.DCTool.DownloadOptions.GetDefaultDownloadSize);
      
    DCTool.DownloadOptions.Address := eAddr.Text;

    //changer de dir
    if cbWorkdir.Checked then
      SetCurrentDir(cbxWorkDir.Text)
    else SetCurrentDir(GetDefaultWorkDir);
  end;

  //Go !
  DCTool.Download;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.Historiesconfig1Click(Sender: TObject);
var
  Histories_Form : THistories_Form;

begin
  //Créee dynamiquement, inutile de l'avoir tout le temps en mémoire.
  Histories_Form := THistories_Form.Create(Application);
  try
    Histories_Form.ShowModal;
  finally
    Histories_Form.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miReexcuteLastClick(Sender: TObject);
var
  LastOp : TOperationType;

begin
  LastOp := DCTool.GetLastOperation;

  //Dossier de travail de Windows (upload)
  if (LastOp = otUpload) or (LastOp = otUploadExecute) then
  begin
    if Upload_Form.cbWorkdir.Checked then
    begin
      SetCurrentDir(Upload_Form.cbxWorkdir.Text);
    end else SetCurrentDir(GetDefaultWorkDir);
  end;

  //Dossier de travail de Windows (download)
  if (LastOp = otDownload) then
  begin
    if Download_Form.cbWorkdir.Checked then
    begin
      SetCurrentDir(Download_Form.cbxWorkdir.Text);
    end else SetCurrentDir(GetDefaultWorkDir);
  end;

  //Re-executer
  case LastOp of
    otUpload        : DCTool.Upload;
    otUploadExecute : begin
                        //Si c'est upload alors on va ajouter une nouvelle page
                        //AddNewSynEditLogForUploadExecute;
                        DCTool.Upload;
                      end;
    otDownload      : DCTool.Download;
    otReset         : miReset.Click //DCTool.Reset; (confirmation)
  end;

end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolReseting(Sender: TObject);
begin
  reLog.LinesType.Command.AddNewEventLine('Performing DC-TOOL reset on '
    + DateToStr(Date) + ', ' + TimeToStr(Time) + '...');
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolReseted(Sender: TObject);
begin
  reLog.LinesType.State.AddNewEventLine('Function return OK.');
end;

//------------------------------------------------------------------------------

procedure TMain_Form.aeMainHint(Sender: TObject);
begin
  sbMain.Panels[sbMain.Panels.Count - 1].Text := Application.Hint;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.Highlighterconfig1Click(Sender: TObject);
var
  mr : TModalResult;

begin
  with Highlights_Form do
  begin
    LoadWindowState;

    mr := ShowModal;
    if mr = mrCancel then
    begin
      SaveFile.LoadHightlight;
      Exit;
    end;

    SaveFile.SaveHightlight;
    //SaveWindowState; //les msgbox sont affichés alors que la fenêtre est visibile
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miBmGotoClick(Sender: TObject);
begin
  SynBookMarkView.GotoSelected;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miBmEnabledClick(Sender: TObject);
begin
  miBmEnabled.Checked := not miBmEnabled.Checked;
  SynBookMarkView.ChangeSelected(miBmEnabled.Checked);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.SynBookMarkViewContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  Item : TListItem;

begin
  if not Assigned(SynBookMarkView.Selected) then
  begin
    miBmGoto.Enabled := False;
    miBmEnabled.Checked := False;
    miBmEnabled.Enabled := False;
    Exit;
  end;

  Item := SynBookMarkView.Selected;

  miBmEnabled.Enabled := True;
  miBmGoto.Enabled := Item.Checked;
  miBmEnabled.Checked := Item.Checked;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miBmDeleteClick(Sender: TObject);
var
  i : integer;

begin
  i := MsgBox(Handle, 'OK to clear all bookmarks ?', 'Question', 32 + MB_YESNO
    + MB_DEFBUTTON2);
  if i = IDNO then Exit;
  
  for i := 0 to SynBookMarkView.Items.Count - 1 do
    SynBookMarkView.ChangeBookMark(i, False);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miHistReExecuteClick(Sender: TObject);
var
  Node : TTreeNode;

begin
  Node := DcToolHistoryView.Selected;
  if not Assigned(Node) then Exit;

  //C'est une node valide?
  //etNone est défini dans DcToolHistoryView.pas.
  if DcToolHistoryView.GetNodeState(Node) <> etNone then
    DcToolHistoryView.ReExecuteNode(Node); //oui
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DcToolHistoryViewReReset(Sender: TObject;
  ReExecuteNode: TTreeNode);
begin
  miReset.Click;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DcToolHistoryViewReDownload(Sender: TObject;
  ReExecuteNode: TTreeNode);
begin
  DCTool.Download;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DcToolHistoryViewReUpload(Sender: TObject;
  ReExecuteNode: TTreeNode; Execute: Boolean);
begin
  //Nouvelle tab !
  //if Execute then
    //AddNewSynEditLogForUploadExecute;
    
  DCTool.Upload;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DcToolHistoryViewContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  Node : TTreeNode;
  OK   : boolean;

begin
  Node := DcToolHistoryView.GetNodeAt(MousePos.X, MousePos.Y); //récuperer la node sous la souris.

  OK := Assigned(Node);  //est-telle assignée?
  miHistReExecute.Enabled := OK; //si oui, les deux items seront enabled.
  miHistDelete.Enabled := OK;
  miOpenDir.Enabled := OK;

  if not OK then Exit;  //sinon, on s'arrête là (et les items sont enabled).

  OK := not (DcToolHistoryView.GetNodeState(Node) = etNone);  //la node est TOUT sauf etNone (non executable)

  miHistDelete.Enabled := OK; //si la node n'est pas etNone alors ça sera true, sinon false

  miHistReExecute.Enabled := OK and (not DCTool.DosComm.Active); //condition d'avant ET execution en cours ?

  miOpenDir.Enabled := (not (DcToolHistoryView.GetNodeState(Node) = etNone)) and
    (not (DcToolHistoryView.GetNodeState(Node) = etReset));
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miHistDeleteClick(Sender: TObject);
var
  CanDo : integer;
  Node  : TTreeNode;

begin
  Node := DcToolHistoryView.Selected;
  if not Assigned(Node) then Exit;  //sécurité... normalement impossible car elle
                                    //est désactivée dans le OnContextPopup.

  CanDo := MsgBox(Handle, 'Are you sure to delete this history event ?', 'Question',
    32 + MB_YESNO);
  if CanDo = IDNO then Exit;

  Node.Delete;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCTOOLlocation1Click(Sender: TObject);
var
  DCToolLoc_Form : TDcToolLoc_Form;
  MR : TModalResult;

begin
  DCToolLoc_Form := TDcToolLoc_Form.Create(Application);
  try

    with DCToolLoc_Form do
    begin
      DCToolLoc_Form.LoadWindowState; //on va charger la config du ini
      //et modifier l'état des controls en fonction du ini.

      MR := ShowModal;

      if MR = mrOK then
        DCToolLoc_Form.SaveWindowState; //sauvegarde des parametres et modif
        //du TDCTool de la Main_Form.
    end;

  finally
    DcToolLoc_Form.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.Cygwinlibraries1Click(Sender: TObject);
var
  Cygwin_Form : TCygwin_Form;
  mr : TModalResult;

begin
  Cygwin_Form := TCygwin_Form.Create(Application);
  try
    Cygwin_Form.LoadWindowState;
  
    mr := Cygwin_Form.ShowModal;
    if mr = mrCancel then Exit;

    DcToolCygWinCfg.Config := TCygConfig(Cygwin_Form.rgCygwin.ItemIndex);
    DcToolCygWinCfg.CygWinExternalPath := Cygwin_Form.eLib.Text;
    
    DcToolCygWinCfg.ApplyConfig;

    Cygwin_Form.SaveWindowState;
  finally
    Cygwin_Form.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miCloseTabClick(Sender: TObject);
begin
  multiSyn.ClosePage(multiSyn.ActivePageIndex);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.AddNewSynEditLogForUploadExecute;
var
  ExecName : string;
  WelcomeIndex : integer;

begin
  //*** Ajouter une tab si c'est un Upload Execute ***
  if DCTool.UploadOptions.ExecuteAfterUpload then
  begin
    //Virer la fiche WELCOME si elle est présente.
    if FirstUploadExecute then
    begin
      FirstUploadExecute := False;
      WelcomeIndex := multiSyn.GetSynIndex('Welcome', True);
      if WelcomeIndex <> -1 then
        multiSyn.ClosePage(WelcomeIndex);
    end;

    //Faire la nouvelle fiche.
    ExecName := ExtractFileName(DCTool.FileName);

    //Ajouter la page.
    try
      if not Main_Form.multiSyn.AddNewPage(ExecName) then
        MsgBox(Handle, 'SynEdit creation problem... damn it !', 'Error', 16);
    except
      //MsgBox(Handle, 'Ho merde ce logiciel de merde qui me casse les couilles...',
      //  'Erreur de merde...', 16);
      //Exit;
    end;
    
    Application.ProcessMessages;
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolAborting(Sender: TObject);
begin
  //empeche d'afficher ça à la fermeture de l'application
  if not ApplicationIsQuitting then
    reLog.LinesType.Command.AddNewEventLine('Aborting request by user...');
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCToolAborted(Sender: TObject);
begin
  //empeche d'afficher ça à la fermeture de l'application
  if not ApplicationIsQuitting then
    reLog.LinesType.State.AddNewEventLine('Operation aborted.');
end;

//------------------------------------------------------------------------------

procedure TMain_Form.Mainhelp1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(GetRealPath(GetAppDir + '\Help\') + 'todo.chm'), '', '', SW_SHOWNORMAL);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.BINstatedetection1Click(Sender: TObject);
var
  BinCheck_Form : TBinCheck_Form;
  mr : TModalResult;

begin
  BinCheck_Form := TBinCheck_Form.Create(Application);
  try
    with BinCheck_Form do
    begin
      rgBinCheck.ItemIndex := Integer(Upload_Form.GetBinCheckCfg);
      
      mr := ShowModal;
      if mr = mrCancel then Exit;

      Upload_Form.SetBinCheckCfg(TBinCheckMode(rgBinCheck.ItemIndex));

      //Sauvegarde
      SaveFile.WriteInteger('BINCHECK', 'DetectionMode', rgBinCheck.ItemIndex);
    end;
  finally
    BinCheck_Form.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.GetParamList(var Msg: TMessage);
var
  pSwap   : TParamSwap;

begin
  pSwap.FileName := GetAtom(Msg.LParam);
  pSwap.Switchs := GetAtom(Msg.WParam);

  ExecuteFromCmdLine(pSwap);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.FormActivate(Sender: TObject);
var
  pSwap : TParamSwap;

begin
  if FirstRunCmdLine then
  begin
    FirstRunCmdLine := False;

    //Paramètres au premier lancement ?
    if HasParams then
    begin
      pSwap := GetParamsList;
      ExecuteFromCmdLine(pSwap);
    end;
  end;

end;

//------------------------------------------------------------------------------

procedure TMain_Form.About1Click(Sender: TObject);
begin
  About_Form := TAbout_Form.Create(Application);
  try
    About_Form.ShowModal;
  finally
    About_Form.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miSaveLogClick(Sender: TObject);
var
  Cmp : TComponent;

begin
  Cmp := Self.ActiveControl;
  if not Assigned(Cmp) or not (Cmp is TComponent) then Exit;

  if (Cmp is TRichEdit) then
  begin
    with sdLog do
    begin
      FilterIndex := 1;
      if not Execute then Exit;
      reLog.PlainText := not (FilterIndex = 1);
      (Cmp as TRichEdit).Lines.SaveToFile(FileName);
    end;
  end;

  if (Cmp is TSynEdit) then
  begin
    with sdSyn do
    begin
      FilterIndex := 1;
      if not Execute then Exit;
      (Cmp as TSynEdit).Lines.SaveToFile(FileName);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miCloseAllTabsClick(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, 'Are you sure to close all tabs ?', 'Warning',
    48 + MB_YESNO + MB_DEFBUTTON2);
  if CanDO = IDNO then Exit;
  
  multiSyn.CloseAllTabs;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.tiUpdateAppTimer(Sender: TObject);
var
  Cmp : TComponent;
  OK : boolean;
  tabname : string;
  SE : TSynEdit;

begin
  if ApplicationIsQuitting then Exit;
  
  //Caption et Enabled du menu "miCloseCurrent" qui permet de fermer
  //le tab selectionné
  SE := multiSyn.GetCurrentSynEdit;
  tabname := multiSyn.GetCurrentCaption;
  miCloseCurrent.Caption := '&Close ' + tabname;
  if DCTool.DosComm.Active then
    miCloseCurrent.Enabled := not (SE = multiSyn.GetLastSynEdit)
  else miCloseCurrent.Enabled := Assigned(SE);
  tbCloseCurrent.Enabled := miCloseCurrent.Enabled;

  miCloseAllTabs.Enabled := not (multiSyn.PageCount = 0) and not DcTool.IsActive;
  miCloseUselessTabs.Enabled := multiSyn.PageCount > 1;

  Cmp := Self.ActiveControl;
  if Cmp is TComponent then
  begin
    Cmp := Cmp as TComponent;
    OK := (Cmp is TRichEdit) or (Cmp is TSynEdit);

    miSaveLog.Enabled := OK;
    miCopyText.Enabled := OK;
    miSelectAll.Enabled := OK;
    miFindText.Enabled := OK;
    miSearchForward.Enabled := OK;
    miSearchBackward.Enabled := (Cmp is TSynEdit);
    miSeFindText.Enabled := OK;
    miSeSearchForward.Enabled := OK;
    miSeSearchBackward.Enabled := miSearchBackward.Enabled;
    tbSearchForward.Enabled := OK;
    tbSearchBackward.Enabled := miSearchBackward.Enabled;

    //Les boutons
    tbCopyText.Enabled := OK;
    tbSelectAll.Enabled := OK;
    tbSearchText.Enabled := OK;
    tbSaveFile.Enabled := OK;
    //tbClearDebug.Enabled := OK;

    //clef
    miSeCopyText.Enabled := OK;
    miSeSelectAll.Enabled := OK;
    miSeSave.Enabled := OK;
  end;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miCloseUselessTabsClick(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, 'Close all tabs except the last ?', 'Warning',
    48 + MB_YESNO + MB_DEFBUTTON2);
  if CanDO = IDNO then Exit;

  multiSyn.CloseUselessTabs;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.multiSynContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  pmCloseTab.Enabled := miCloseCurrent.Enabled;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.DCTOOLGUI1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://sbibuilder.shorturl.com/', '', '', SW_SHOWNORMAL);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miFindTextClick(Sender: TObject);
begin
  RunSearch;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miSearchForwardClick(Sender: TObject);
begin
  SearchForward;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miSearchBackwardClick(Sender: TObject);
begin
  SearchBackward;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miSendACommandClick(Sender: TObject);
begin
  MsgBox(Handle, 'Sorry, not avialable yet...', 'Hey hey alpha version :p', MB_ICONWARNING);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miOpenDirClick(Sender: TObject);
var
  CurrNode : TTreeNode;
  AppPath : string;

begin
  CurrNode := DcToolHistoryView.Selected;
  CurrNode := CurrNode.GetNext;

  AppPath := Droite(': ', CurrNode.Item[4].Text);
  if not DirectoryExists(AppPath) then
    MsgBox(Handle, 'Directory was deleted...', 'Awww...', MB_ICONERROR)
  else ShellExecute(Handle, 'open', PChar(AppPath), '', '', SW_SHOWNORMAL);
end;

//------------------------------------------------------------------------------

procedure TMain_Form.Clearall1Click(Sender: TObject);
var
  i : integer;

begin
  i := MsgBox(Handle, 'OK to clear all history events ?', 'Question', 32 + MB_YESNO
    + MB_DEFBUTTON2);
  if i = IDNO then Exit;

  DcToolHistoryView.Items.Clear;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.miClearDebugLogClick(Sender: TObject);
var
  i : integer;

begin
  i := MsgBox(Handle, 'OK to clear the debug log ?', 'Question', 32 + MB_YESNO
    + MB_DEFBUTTON2);
  if i = IDNO then Exit;

  Self.reLog.InitLog.DoInitLog;
end;

//------------------------------------------------------------------------------

procedure TMain_Form.FormShow(Sender: TObject);
begin
  SaveFile.LoadHightlight;
end;
       
//------------------------------------------------------------------------------

procedure TMain_Form.FindDialogFind(Sender: TObject);
var
  FoundAt : LongInt;
  StartPos,
  ToEnd : Integer;

begin
  with reLog do
  begin
    FindDialog.CloseDialog;
    
    {commence la recherche après la sélection en cours s'il y en a une }
    {sinon,commence au début du texte }
    if SelLength <> 0 then

    StartPos := SelStart + SelLength
    else StartPos := 0;

    { ToEnd indique la longueur entre StartPos et la fin du texte du
     contrôle éditeur de texte enrichi }
    ToEnd := Length(Text) - StartPos;

    FoundAt := FindText(FindDialog.FindText, StartPos, ToEnd,
      FindOptionsToSearchTypes(FindDialog.Options));
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(FindDialog.FindText);
    end else MessageBeep(MB_ICONINFORMATION);
  end;
end;
      
//------------------------------------------------------------------------------

procedure TMain_Form.DCTOOL1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://adk.napalm-x.com/dc/', '', '', SW_SHOWNORMAL);
end;

procedure TMain_Form.Submitbugsreport1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'mailto:sizious@yahoo.fr?subject=[DC-TOOL GUI 3]'
    + ' I found a bug...&body=Write your bugs report here...',
    '', '', SW_SHOWNORMAL);
end;

end.
