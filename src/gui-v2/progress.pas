unit progress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Tools, ExtCtrls, ComCtrls, Buttons;

type
  TUpProgress_Form = class(TForm)
    Info_Label: TLabel;
    Wait: TImage;
    ProgressBar: TProgressBar;
    Stop_Button: TBitBtn;
    lFileName: TLabel;
    lSaveTo: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Stop_ButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  UpProgress_Form: TUpProgress_Form;
  //ProcessFinished : boolean = True;
  //StopClicked : boolean;
  
implementation

uses main, utils;

{$R *.dfm}

procedure TUpProgress_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  CanClose : integer;

begin
  //On se casse si le process est terminé avant de cliquer..
  if Main_Form.UpDosCommand.Active = False then
  begin
    PerformGeneralReset;
    Exit;
  end;

  CanClose := MsgBox(Handle, AbortOperation, WarningCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
  if CanClose = IDNO then
  begin
    Action := caNone;
    Exit;
  end;

  //Si la fenetre s'est fini avant la réponse...
  //if Progress_Form.Visible = False then
  if Main_Form.UpDosCommand.Active = False then
  begin
    AddDebug('STATE:> Process already finished, aborting impossible');
    //KillAllRunningDCTOOL;
    //ActiveControls;
    //if Visible = True then Progress_Form.Hide; //ModalResult := mrOK;
    //Main_Form.Reset1.Click;
    PerformGeneralReset;    //Cliquer sur RESET
    Exit;
  end; 

  //StopClicked := True;
  //AddDebug(' ');
  AddDebug('CMD:> DC-TOOL Abort');
  AddDebug('STATE:> Command aborted.');
  Main_Form.UpDosCommand.Stop;
  //if Visible = True then Progress_Form.Close;//ModalResult := mrOK; 
end;

procedure TUpProgress_Form.Stop_ButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TUpProgress_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
