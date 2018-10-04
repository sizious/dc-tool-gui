unit linktest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DosCommand, ComCtrls, JvRichEdit, ExtCtrls,
  Menus, XPMenu;

type
  TLinkTest_Form = class(TForm)
    bBegin: TBitBtn;
    bCancel: TBitBtn;
    dcTest: TDosCommand;
    gbOutput: TGroupBox;
    mTest: TJvRichEdit;
    ProgressBar: TProgressBar;
    Bevel1: TBevel;
    Image1: TImage;
    lzeropercent: TLabel;
    lhunderd: TLabel;
    lDreamcastPCLinkTester: TLabel;
    PopupMenu: TPopupMenu;
    Copyline1: TMenuItem;
    Selectall1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    XPMenu: TXPMenu;
    procedure dcTestNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure bBeginClick(Sender: TObject);
    procedure dcTestTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Copyline1Click(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  LinkTest_Form: TLinkTest_Form;

implementation

{$R *.dfm}

uses u_progress, u_linktest, r_colors, tools, u_dctool_manager, u_kill_dctool,
     utils, u_ctrls, bios;

const
  ELF_LINK_TEST    : string = 'DC-TOOL GUI - by [big_fury]SiZiOUS';
  ELF_TEST_SUCCESS : string = 'Your link is correctly set and active.';

var
  LinkCorrect : boolean = False;

//---AddDebug---
procedure AddDebug(Msg : string);
begin
  AddFormattedText(Msg, LinkTest_Form.mTest, clBlue);
  //LinkTest_Form.mTest.Lines.Add(Msg);
end;

//---AddErrorText---
procedure AddErrorText(Msg : string);
begin
  AddFormattedText(Msg, LinkTest_Form.mTest, clRed);
end;

//---AddGreenText---
procedure AddGreenText(Msg : string);
begin
  AddFormattedText(Msg, LinkTest_Form.mTest, clGreen);
end;

//---AddGreenBoldText---
procedure AddGreenBoldText(Msg : string);
begin
  LinkCorrect := True;
  AddFormattedText('OUTPUT:> ' + Msg, LinkTest_Form.mTest, clGreen, 8, 'Tahoma', [fsBold]);
end;

//---StopTest---
procedure StopTest;
begin
  LinkTest_Form.dcTest.Stop;
  KillAllRunningDCTOOL;
end;

procedure TLinkTest_Form.dcTestNewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
var
  ProgressBar : TProgressBar;

begin
  if NewLine = '' then Exit;
  ProgressBar := LinkTest_Form.ProgressBar;

  //Text du ELF (presentation)
  if UpperCase(NewLine) = UpperCase(ELF_LINK_TEST) then
  begin
    AddGreenBoldText(NewLine);
    NewLine := '';
    Exit;
  end;

  //Text du ELF (resultat)
  if UpperCase(NewLine) = UpperCase(ELF_TEST_SUCCESS) then
  begin
    AddGreenBoldText(NewLine);
    NewLine := '';
    Exit;
  end;

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
    InitProgressBar(ProgressBar);    //initialisation (remise à 0, puis max = 68)
    PerformProgress(NewLine, ProgressBar); //rajouter le nb de carrés necessaires


    NewLine := '';
    Exit;       //se casser (pas ajouter le texte!)
  end;

  //AFFICHER LE TEXTE
  if OutputType = otEntireLine then  //si ligne entière
    AddDebug('OUTPUT:> ' + NewLine); //Si ligne pas filtrée, on ajoute.

  NewLine := '';   //effacer le buffer
end;

procedure TLinkTest_Form.bBeginClick(Sender: TObject);
begin
  AddGreenText('CMD:> Starting the link test...');
  ExtractLinkTest;
  LinkCorrect := False;
  bBegin.Enabled := False;
  DisactiveControls;
  UploadTestProgram(dcTEST, GetTempDir + 'LINKTEST.ELF');
end;

procedure TLinkTest_Form.dcTestTerminated(Sender: TObject;
  ExitCode: Cardinal);
begin
  AddErrorText('STATE:> Link test processus completed on ' + DateToStr(Date) + ' - ' + TimeToStr(Now) + ', Exit Code : ' + IntToStr(ExitCode));

  bBegin.Enabled := True;
  DeleteLinkTest;
  ActiveControls;

  if LinkCorrect = True then
  begin
    MsgBox(Handle, YourLinkIsCorrectlySetAndActive, InformationCaption, 64);
    LinkCorrect := False;
    //Close;
  end;
end;

procedure TLinkTest_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  CanDo : integer;

begin
  if dcTest.Active = True then
  begin
    CanDo := MsgBox(Handle, AreYouSureToCancelTheLinkTest, ErrorCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
    if CanDo = IDNO then
    begin
      Action := caNone;
      Exit;
    end;

    StopTest;
    MsgBox(Handle, PleaseInsertTheDCLOADDiscAndRebootConsole, InformationCaption, 64);
    //MsgBox(Handle, 'Please insert the DC-LOAD disc in the Dreamcast and reboot the console.', 'Information', 64);
  end;
end;

procedure TLinkTest_Form.FormShow(Sender: TObject);
begin
  ProgressBar.Position := 0;
  mTest.Clear;
end;

procedure TLinkTest_Form.Copyline1Click(Sender: TObject);
begin
  mTest.CopyToClipboard;
end;

procedure TLinkTest_Form.Selectall1Click(Sender: TObject);
begin
  mTest.SelectAll;
end;

procedure TLinkTest_Form.Save1Click(Sender: TObject);
begin
  SaveRichEditTo(mTest, BIOS_Form.SaveDialog);
end;

procedure TLinkTest_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
