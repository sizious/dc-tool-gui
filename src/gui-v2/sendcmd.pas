unit sendcmd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, JvRichEdit, ExtCtrls, XPMenu,
  Menus, DosCommand;

type
  TSendCmd_Form = class(TForm)
    gbCommand: TGroupBox;
    bBegin: TBitBtn;
    bCancel: TBitBtn;
    eCmd: TEdit;
    gbType: TGroupBox;
    Serial_RadioButton: TRadioButton;
    BBA_RadioButton: TRadioButton;
    gbOutput: TGroupBox;
    Bevel: TBevel;
    mTest: TJvRichEdit;
    dcTest: TDosCommand;
    PopupMenu: TPopupMenu;
    Copyline1: TMenuItem;
    Selectall1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    XPMenu: TXPMenu;
    cbConsole: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dcTestTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure dcTestNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure bBeginClick(Sender: TObject);
    procedure eCmdKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Copyline1Click(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  SendCmd_Form: TSendCmd_Form;

implementation

{$R *.dfm}

uses utils, tools, r_colors, u_kill_dctool, u_ctrls, u_progress, main,
  bios;

var
  InProgress : boolean = False;

//---AddDebug---
procedure AddDebug(Msg : string);
begin
  AddFormattedText(Msg, SendCmd_Form.mTest, clBlue);
  //LinkTest_Form.mTest.Lines.Add(Msg);
end;

//---AddErrorText---
procedure AddErrorText(Msg : string);
begin
  AddFormattedText(Msg, SendCmd_Form.mTest, clRed);
end;

//---AddGreenText---
procedure AddGreenText(Msg : string);
begin
  AddFormattedText(Msg, SendCmd_Form.mTest, clGreen);
end;

//---StopTest---
procedure StopTest;
begin
  SendCmd_Form.dcTest.Stop;
  KillAllRunningDCTOOL;
end;

procedure TSendCmd_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  CanDo : integer;

begin
  if dcTest.Active = True then
  begin
    CanDo := MsgBox(Handle, AreYouSureToCancel, ErrorCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
    if CanDo = IDNO then
    begin
      Action := caNone;
      Exit;
    end;

    if dcTest.Active = False then Exit;
    StopTest;
    MsgBox(Handle, PleaseInsertTheDCLOADDiscAndRebootConsole, InformationCaption, 64);
    //MsgBox(Handle, 'Please insert the DC-LOAD disc in the Dreamcast and reboot the console.', 'Information', 64);
  end;
end;

procedure TSendCmd_Form.dcTestTerminated(Sender: TObject;
  ExitCode: Cardinal);
begin
  AddErrorText('STATE:> Processus completed on ' + DateToStr(Date) + ' - ' + TimeToStr(Now) + ', Exit Code : ' + IntToStr(ExitCode));
  bBegin.Enabled := True;
  //DeleteDelFlash;
  ActiveControls;
end;

procedure TSendCmd_Form.dcTestNewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
begin
  if NewLine = '' then Exit;

  //On ne prend pas de progress bar...
  if NbSousChaine(MinProgress, NewLine) > 0 then
  begin
    if InProgress = False then
    begin
      AddErrorText('STATE:> Operation in progress... please wait...');
      InProgress := True;
    end;
    Exit;
  end;

  //AFFICHER LE TEXTE
  if OutputType = otEntireLine then  //si ligne entière
    AddDebug('OUTPUT:> ' + NewLine); //Si ligne pas filtrée, on ajoute.

  NewLine := '';   //effacer le buffer
end;

procedure TSendCmd_Form.bBeginClick(Sender: TObject);
begin
  if BBA_RadioButton.Checked = True then
    dcTEST.CommandLine := DCTOOLIP + ' ' + eCmd.Text
  else dcTEST.CommandLine := DCTOOL + ' ' + eCmd.Text;

  if cbConsole.Checked = True then
    dcTEST.ShowWindow := swSHOW
  else dcTEST.ShowWindow := swHIDE;

  //ExtractDelFlash;
  bBegin.Enabled := False;
  DisactiveControls;
  //UploadTestProgram(dcTEST, GetTempDir + 'DELFLASH.BIN');
  InProgress := False;

  AddGreenText('CMD:> ' + dcTEST.CommandLine);
  dcTEST.Execute;
end;

procedure TSendCmd_Form.eCmdKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    bBegin.Click;
  end;
end;

procedure TSendCmd_Form.FormActivate(Sender: TObject);
begin
  eCmd.SetFocus;
  eCmd.SelectAll;
  mTest.Clear;
end;

procedure TSendCmd_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TSendCmd_Form.Copyline1Click(Sender: TObject);
begin
  mTest.CopyToClipboard;
end;

procedure TSendCmd_Form.Selectall1Click(Sender: TObject);
begin
  mTest.SelectAll;
end;

procedure TSendCmd_Form.Save1Click(Sender: TObject);
begin
  SaveRichEditTo(mTest, BIOS_Form.SaveDialog);
end;

end.
