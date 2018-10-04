unit delflash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DosCommand, StdCtrls, Buttons, ComCtrls, JvRichEdit, ExtCtrls,
  XPMenu, Menus;

type
  TDelFlash_Form = class(TForm)
    gbOutput: TGroupBox;
    mTest: TJvRichEdit;
    bBegin: TBitBtn;
    bCancel: TBitBtn;
    dcTest: TDosCommand;
    Image1: TImage;
    Bevel1: TBevel;
    lDelFlashTitle: TLabel;
    Label1: TLabel;
    PopupMenu: TPopupMenu;
    Copyline1: TMenuItem;
    Selectall1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    XPMenu: TXPMenu;
    procedure dcTestNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure dcTestTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure bBeginClick(Sender: TObject);
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
  DelFlash_Form: TDelFlash_Form;

implementation

{$R *.dfm}

uses utils, tools, u_progress, r_colors, u_dctool_manager, u_ctrls, u_linktest,
     u_kill_dctool, bios;

const
  DELFLASH_FINISH : string = 'Sending execute command';

var
  Success : boolean = False;
  
//---AddDebug---
procedure AddDebug(Msg : string);
begin
  AddFormattedText(Msg, DelFlash_Form.mTest, clBlue);
  //LinkTest_Form.mTest.Lines.Add(Msg);
end;

//---AddErrorText---
procedure AddErrorText(Msg : string);
begin
  AddFormattedText(Msg, DelFlash_Form.mTest, clRed);
end;

//---AddGreenText---
procedure AddGreenText(Msg : string);
begin
  AddFormattedText(Msg, DelFlash_Form.mTest, clGreen);
end;

//---StopTest---
procedure StopTest;
begin
  DelFlash_Form.dcTest.Stop;
  KillAllRunningDCTOOL;
end;

procedure TDelFlash_Form.dcTestNewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
begin
  if NewLine = '' then Exit;
  if NbSousChaine(MinProgress, NewLine) > 0 then Exit; //Delete Flash est trop petit pour une progress bar..

  //AFFICHER LE TEXTE
  if OutputType = otEntireLine then  //si ligne entière
    AddDebug('OUTPUT:> ' + NewLine); //Si ligne pas filtrée, on ajoute.

  if NbSousChaine(UpperCase(DELFLASH_FINISH), UpperCase(NewLine)) > 0 then
  begin
    dcTEST.Stop;
    Success := True;
  end;

  NewLine := '';   //effacer le buffer
end;

procedure TDelFlash_Form.dcTestTerminated(Sender: TObject;
  ExitCode: Cardinal);
begin
  AddErrorText('STATE:> Deleting FLASH processus completed on ' + DateToStr(Date) + ' - ' + TimeToStr(Now) + ', Exit Code : ' + IntToStr(ExitCode));

  bBegin.Enabled := True;
  DeleteDelFlash;
  ActiveControls;

  if Success = True then MsgBox(Handle, PleaseRebootYourDreamcastNowIfYouMustSetTheDateTimeTheFLASHResetIsCompleted, InformationCaption, 64);
end;

procedure TDelFlash_Form.bBeginClick(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, WarningResetingYourFLASHMemoryEraseAllDatasYourISPSettingsWithDreamkey
    + WrapStr + DateTimeAndLanguageSelectionYourDreamcastIsSetAsFactoryVMUIsNotDeleted
      + WrapStr + DoYouWantToContinueAnyway, WarningCaption, 16 + MB_YESNO + MB_DEFBUTTON2);

  if CanDo = IDNO then Exit;
  
  MsgBox(Handle, WhenTheUploadIsFinishedTheScreensBorderShouldBecomeRedThenGreen
    + WrapStr + ItIsRedWhileErasingTheFlashAndTurnGreenWhenItsDone + WrapStr
      + ItsVeryQuickItTakesApproxMidSecond, InformationCaption, 64);


  AddGreenText('CMD:> Deleting the FLASH memory...');
  ExtractDelFlash;
  bBegin.Enabled := False;
  DisactiveControls;
  UploadTestProgram(dcTEST, GetTempDir + 'DELFLASH.BIN');
end;

procedure TDelFlash_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  CanDo : integer;

begin
  if dcTest.Active = True then
  begin
    CanDo := MsgBox(Handle, AreYouSureToCancelTheFLASHReset, ErrorCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
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

procedure TDelFlash_Form.FormShow(Sender: TObject);
begin
  Success := False;
  mTest.Clear;
end;

procedure TDelFlash_Form.Copyline1Click(Sender: TObject);
begin
  mTest.CopyToClipboard;
end;

procedure TDelFlash_Form.Selectall1Click(Sender: TObject);
begin
  mTest.SelectAll;
end;

procedure TDelFlash_Form.Save1Click(Sender: TObject);
begin
  SaveRichEditTo(mTest, BIOS_Form.SaveDialog);
end;

procedure TDelFlash_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
