unit dl_progress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TDownProgress_Form = class(TForm)
    Info_Label: TLabel;
    Wait: TImage;
    ProgressBar: TProgressBar;
    Stop_Button: TBitBtn;
    lFileName: TLabel;
    lSaveTo: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    procedure Stop_ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  DownProgress_Form: TDownProgress_Form;

implementation

uses main, utils, tools;

{$R *.dfm}

procedure TDownProgress_Form.Stop_ButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TDownProgress_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  CanClose : integer;

begin
  //On se casse si le process est terminé avant de cliquer..
  if Main_Form.DownDosCommand.Active = False then
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
  if Main_Form.DownDosCommand.Active = False then
  begin
    AddDebug('STATE:> Process already finished, aborting impossible');
    PerformGeneralReset;    //Cliquer sur RESET
    Exit;
  end; 

  AddDebug('CMD:> DC-TOOL Abort');
  AddDebug('STATE:> Command aborted.');
  Main_Form.DownDosCommand.Stop;
end;

procedure TDownProgress_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
