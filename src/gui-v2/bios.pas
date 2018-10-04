unit bios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, JvRichEdit, DosCommand,
  FileCtrl, JvBaseDlg, JvBrowseFolder, Menus, XPMenu;

type
  TBIOS_Form = class(TForm)
    Image1: TImage;
    lDumpingBIOS: TLabel;
    pbBIOS: TProgressBar;
    bCancel: TBitBtn;
    Bevel1: TBevel;
    bLog: TBitBtn;
    rdBIOS: TJvRichEdit;
    dcBIOS: TDosCommand;
    lStatusCaption: TLabel;
    lStatus: TLabel;
    lSaveToDisplay: TLabel;
    lSaveTo: TLabel;
    sdBIOS: TJvBrowseForFolderDialog;
    pbMAX: TProgressBar;
    lCurrent: TLabel;
    lOverall: TLabel;
    dcFLASH: TDosCommand;
    StartTimer: TTimer;
    SaveDialog: TSaveDialog;
    PopupMenu: TPopupMenu;
    Save1: TMenuItem;
    XPMenu: TXPMenu;
    N1: TMenuItem;
    Selectall1: TMenuItem;
    Copyline1: TMenuItem;
    procedure bLogClick(Sender: TObject);
    procedure dcBIOSNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dcFLASHTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure dcFLASHNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure dcBIOSTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure StartTimerTimer(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Copyline1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  BIOS_Form: TBIOS_Form;

function GetFLASHFileName : string;
function GetBIOSFileName : string;

implementation

uses main, tools, u_ctrls, u_progress_dl, r_colors, com_spec, u_kill_dctool,
     utils;

var
  PrevPos     : integer = 0;
  IsCanceled  : boolean = False;

{$R *.dfm}

//---SetToInProgress---
procedure SetToInProgress;
begin
  BIOS_Form.lStatus.Font.Color := $000080FF;
  BIOS_Form.lStatus.Caption := BiosInProgress;
end;

//---SetToFailed---
procedure SetToFailed;
begin
  BIOS_Form.lStatus.Font.Color := clRed;
  BIOS_Form.lStatus.Caption := BiosFailed;
end;

//---SetToSuccess---
procedure SetToSuccess;
begin
  BIOS_Form.lStatus.Font.Color := clGreen;
  BIOS_Form.lStatus.Caption := BiosSuccess;
end;

//---GetBIOSFileName---
function GetBIOSFileName : string;
begin
  Result := ExtractStr('-d "', '"', BIOS_Form.dcBIOS.CommandLine);
end;

//---GetFLASHFileName---
function GetFLASHFileName : string;
begin
  Result := ExtractStr('-d "', '"', BIOS_Form.dcFLASH.CommandLine);
end;

//---AddBIOSDebug---
procedure AddBIOSDebug(Msg : string);
begin
  AddFormattedText(Msg, BIOS_Form.rdBIOS, clBlue);
end;

procedure TBIOS_Form.bLogClick(Sender: TObject);
begin
  if bLog.Caption = ShowLogBtn then //'&Show log >>'
  begin
    bLog.Caption := HideLogBtn; //'&Hide log <<'
    BIOS_Form.Height := 338;
  end else begin
    bLog.Caption := ShowLogBtn; //'&Show log >>'
    BIOS_Form.Height := 208;
  end;
end;

procedure TBIOS_Form.dcBIOSNewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
var
  ProgressBar : TProgressBar;
  Step : integer;

begin
  if NewLine = '' then Exit;
  ProgressBar := pbBIOS;
  Application.ProcessMessages;

  //Si c'est déjà en progress, on execute la progression en fonction du nb de C
  if DlInProgress = True then
  begin
    Application.ProcessMessages;
    Step := DlPerformProgress(NewLine, ProgressBar); //execute progression
    Application.ProcessMessages;
    pbMAX.Position := pbMAX.Position + Step; //Pour la MAX
    if DlIsProgressCompleted(NewLine, ProgressBar) = True then
      DlInProgress := False else NewLine := ''; //si fini on met InProgress à false, sinon on n'ajoute pas le texte
    Application.ProcessMessages;
    Exit;
  end;

  Application.ProcessMessages;

  //Un progress à lancer?
  if DlIsInProgress(NewLine) = True then
  begin
    Application.ProcessMessages;
    DlInProgress := True;  //oui
    DlInitProgressBar(pbBIOS, StrToInt(BIOS_SIZE));    //initialisation (remise à 0, puis max = 68)
    Step := DlPerformProgress(NewLine, pbBIOS); //rajouter le nb de carrés necessaires
    Application.ProcessMessages;
    pbMAX.Position := pbMAX.Position + Step; //Pour la MAX
    //ShowMessage('IN PROGRESS');

    NewLine := '';
    Exit;       //se casser (pas ajouter le texte!)
  end;

  //Afficher le texte.
  if OutputType = otEntireLine then
    AddBIOSDebug(NewLine);

  Application.ProcessMessages;
  NewLine := '';
end;

procedure TBIOS_Form.FormShow(Sender: TObject);
begin
  rdBIOS.Clear;
  pbBIOS.Position := 0;
  pbMAX.Position := 0;

  IsCanceled := False;

  SetToInProgress;
  lSaveToDisplay.Caption := '';
  lSaveToDisplay.Caption := lSaveTo.Caption + ' ' + MinimizeName(GetBIOSFileName, lSaveToDisplay.Canvas, 280);
  AddFormattedText('Starting dumping Dreamcast BIOS...', rdBIOS, clGreen);
  StartTimer.Enabled := True;
end;

procedure TBIOS_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.ProcessMessages;

  if ModalResult = mrCancel then
  begin
    KillAllRunningDCTOOL;
    Exit;
  end;
  
  Application.ProcessMessages;
  bCancel.Click;
{  if (dcBIOS.Active = False) and (dcFLASH.Active = False) then
  begin
    ActiveControls;
    Exit;
  end;

  Application.ProcessMessages;
  CanDo := MsgBox(Handle, 'Are you sure to stop dumping BIOS?', 'Question', 48 + MB_YESNO + MB_DEFBUTTON2);
  if CanDo = IDNO then
  begin
    Action := caNone;
    Exit;
  end;

  dcBIOS.Stop;
  dcFLASH.Stop;
  ActiveControls; }
end;

procedure TBIOS_Form.dcFLASHTerminated(Sender: TObject;
  ExitCode: Cardinal);
begin
  AddFormattedText('Dumping FLASH Processus completed on ' + DateToStr(Date) + ' - ' + TimeToStr(Now) + ', Exit Code : ' + IntToStr(ExitCode), rdBIOS, clRed);
  if (ExtractFileSize(GetBIOSFileName) = StrToInt(BIOS_SIZE)) then
  begin
    if (ExtractFileSize(GetFLASHFileName) = StrToInt(FLASH_SIZE)) = True then
    begin
      SetToSuccess;
      //ProgressTimer.Enabled := False;
      MsgBox(Handle, DumpingDreamcastBIOSoperationCompleted, InformationCaption, 64);
      Close;
      //Exit;
    end;
  end else SetToFailed;

  ActiveControls;
end;

procedure TBIOS_Form.dcFLASHNewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
var
  ProgressBar : TProgressBar;
  Step : integer;

begin
  if NewLine = '' then Exit;
  ProgressBar := pbBIOS;

  //Si c'est déjà en progress, on execute la progression en fonction du nb de C
  if DlInProgress = True then
  begin
    Step := DlPerformProgress(NewLine, ProgressBar); //execute progression
    Application.ProcessMessages;
    pbMAX.Position := pbMAX.Position + Step; //Pour la MAX
    Application.ProcessMessages;

    if DlIsProgressCompleted(NewLine, ProgressBar) = True then
      DlInProgress := False else NewLine := ''; //si fini on met InProgress à false, sinon on n'ajoute pas le texte
    Application.ProcessMessages;
    Exit;
  end;

  //Un progress à lancer?
  if DlIsInProgress(NewLine) = True then
  begin
    DlInProgress := True;  //oui
    Application.ProcessMessages;
    DlInitProgressBar(pbBIOS, StrToInt(FLASH_SIZE));    //initialisation (remise à 0, puis max = 68)
    Application.ProcessMessages;
    Step := DlPerformProgress(NewLine, pbBIOS); //rajouter le nb de carrés necessaires
    pbMAX.Position := pbMAX.Position + Step; //Pour la MAX
    Application.ProcessMessages;

    //ShowMessage('IN PROGRESS');

    NewLine := '';
    Exit;       //se casser (pas ajouter le texte!)
  end;

  //Afficher le texte.
  if OutputType = otEntireLine then
    AddBIOSDebug(NewLine);

  Application.ProcessMessages;
  NewLine := '';
end;

procedure TBIOS_Form.dcBIOSTerminated(Sender: TObject; ExitCode: Cardinal);
begin
  AddFormattedText('Dumping BIOS Processus completed on ' + DateToStr(Date) + ' - ' + TimeToStr(Now) + ', Exit Code : ' + IntToStr(ExitCode), rdBIOS, clRed);
end;

procedure TBIOS_Form.StartTimerTimer(Sender: TObject);
const
  TimeOut : Extended = 99999999999;

var
  Time : integer;

begin
  StartTimer.Enabled := False;
  DisactiveControls;
  if IsCanceled = True then Exit; //Annulé

  //Lancer le download du bios
  DumpBIOS(GetRealPath(SAVE_DIRECTORY) + BIOS_FILENAME, SAVE_DIRECTORY);
  Application.ProcessMessages;

  //Attendre que le download du BIOS soit fini.
  Time := 0;
  repeat
    Application.ProcessMessages;

    if IsCanceled = True then Exit; //Annulé

    if BIOS_Form.dcBIOS.Active = False then Break;
    Time := Time + 1;
  until Time = TimeOut;

  //Lancer le download du flash
  pbBIOS.Position := 0;
  AddFormattedText('Starting dumping Dreamcast FLASH...', rdBIOS, clGreen);
  Application.ProcessMessages;
  DumpFLASH(GetRealPath(SAVE_DIRECTORY) + FLASH_FILENAME, SAVE_DIRECTORY);
end;

procedure TBIOS_Form.bCancelClick(Sender: TObject);
var
  CanDo : integer;

begin
  if (dcBIOS.Active = False) and (dcFLASH.Active = False) then
  begin
    ActiveControls;
    KillAllRunningDCTOOL;
    Exit;
  end;    

  Application.ProcessMessages;
  CanDo := MsgBox(Handle, AreYouSureToStopDumpingYourBIOS, QuestionCaption, 48 + MB_YESNO + MB_DEFBUTTON2);
  if CanDo = IDNO then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  IsCanceled := True;
  dcBIOS.Stop;
  dcFLASH.Stop;
  ActiveControls;
  KillAllRunningDCTOOL;
  MsgBox(Handle, PleaseInsertTheDCLOADDiscAndRebootConsole, InformationCaption, 64);
  ModalResult := mrCancel;
end;

procedure TBIOS_Form.Save1Click(Sender: TObject);
begin
  SaveRichEditTo(rdBIOS, SaveDialog);
end;

procedure TBIOS_Form.Selectall1Click(Sender: TObject);
begin
  rdBIOS.SelectAll;
end;

procedure TBIOS_Form.Copyline1Click(Sender: TObject);
begin
  rdBIOS.CopyToClipboard;
end;

procedure TBIOS_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
