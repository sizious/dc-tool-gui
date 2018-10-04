unit wizard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, XPMan, Mask, jpeg;

type
  TWizard_Form = class(TForm)
    Bevel1: TBevel;
    P1_Prev: TBitBtn;
    P1_Next: TBitBtn;
    BitBtn4: TBitBtn;
    img: TImage;
    Bevel2: TBevel;
    XPManifest: TXPManifest;
    Start_Panel: TPanel;
    lHelloTitle: TLabel;
    lHelloTip1: TLabel;
    Choice_Panel: TPanel;
    lLinkTypeTitle: TLabel;
    lLinkTypeTip1: TLabel;
    gbLinkType: TGroupBox;
    rbSerial: TRadioButton;
    rbBBA: TRadioButton;
    rbNothing: TRadioButton;
    Serial_Panel: TPanel;
    lSerialTitle: TLabel;
    lSerialTip1: TLabel;
    BBA_Panel: TPanel;
    lBBATitle: TLabel;
    lBBATip1: TLabel;
    Finish_Panel: TPanel;
    lFinishedTitle: TLabel;
    lFinishedTip1: TLabel;
    prChoice: TBitBtn;
    ntChoice: TBitBtn;
    prSerial: TBitBtn;
    ntSerial: TBitBtn;
    prBBA: TBitBtn;
    ntBBA: TBitBtn;
    prFinish: TBitBtn;
    ntFinish: TBitBtn;
    lHelloTip2: TLabel;
    lSerialTip2: TLabel;
    gbChooseBaudrate: TGroupBox;
    gbChooseCOM: TGroupBox;
    rbCOM1: TRadioButton;
    rbCOM2: TRadioButton;
    rbCOM3: TRadioButton;
    rbCOM4: TRadioButton;
    lBBATip2: TLabel;
    gbEnterIP: TGroupBox;
    lForInfoPort31313: TLabel;
    lFinishedTip2: TLabel;
    Baudrate: TComboBox;
    lbauds: TLabel;
    eIP: TMaskEdit;
    img1: TImage;
    img2: TImage;
    imgBBA: TImage;
    imgSERIAL: TImage;
    imgFinal: TImage;
    cbAlternate: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure P1_NextClick(Sender: TObject);
    procedure prChoiceClick(Sender: TObject);
    procedure ntChoiceClick(Sender: TObject);
    procedure prSerialClick(Sender: TObject);
    procedure prBBAClick(Sender: TObject);
    procedure ntSerialClick(Sender: TObject);
    procedure prFinishClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ntFinishClick(Sender: TObject);
    procedure ntBBAClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

const
  SERIAL_IS_SELECTED  : Word = $0000;
  BBA_IS_SELECTED     : Word = $FFFF;
  
var
  Wizard_Form         : TWizard_Form;
  GetSelected         : Word = $0000;
  
implementation

uses tools, utils, main, u_wizard, bba;

{$R *.dfm}

//SetSelection
procedure SetSelection(Selection : Word);
begin
  GetSelected := Selection;
end;

procedure TWizard_Form.FormCreate(Sender: TObject);
var 
  i : integer;

begin
  //A appeller dans le OnCreate de la fiche.
  //Empecher les TPanels de devenir transparents avec un XPManifest sur D7
  //Contribution de Martin Strohal postée sur www.tipps.delphi-source.de
  for i:=0 to ComponentCount - 1 do
    if Components[i] is TPanel then (Components[i] as TPanel).ParentBackground := False;
end;

procedure TWizard_Form.P1_NextClick(Sender: TObject);
begin
  Choice_Panel.Visible := True;
  prChoice.Visible := True;
  ntChoice.Visible := True;
  img.Picture := img2.Picture;
end;

procedure TWizard_Form.prChoiceClick(Sender: TObject);
begin
  Choice_Panel.Visible := False;
  prChoice.Visible := False;
  ntChoice.Visible := False;
  img.Picture := img1.Picture;
end;

procedure TWizard_Form.ntChoiceClick(Sender: TObject);
begin
  if rbNothing.Checked = True then
  begin
    MsgBox(Handle, ThisIsAJoke, InformationCaption, 64);
    Exit;
  end;

  if rbBBA.Checked = True then
    GetSelected := BBA_IS_SELECTED
  else GetSelected := SERIAL_IS_SELECTED;

  if GetSelected = SERIAL_IS_SELECTED then
  begin
    prSerial.Visible := True;
    ntSerial.Visible := True;
    Serial_Panel.Visible := True;
    prBBA.Visible := False;
    ntBBA.Visible := False;
    BBA_Panel.Visible := False;
    img.Picture := imgSERIAL.Picture;
  end else begin
    prBBA.Visible := True;
    ntBBA.Visible := True;
    BBA_Panel.Visible := True;
    prSerial.Visible := False;
    ntSerial.Visible := False;
    Serial_Panel.Visible := False;
    img.Picture := imgBBA.Picture;
  end;
end;

procedure TWizard_Form.prSerialClick(Sender: TObject);
begin
  prSerial.Visible := False;
  ntSerial.Visible := False;
  Serial_Panel.Visible := False;
  img.Picture := img2.Picture;
end;

procedure TWizard_Form.prBBAClick(Sender: TObject);
begin
  prBBA.Visible := False;
  ntBBA.Visible := False;
  BBA_Panel.Visible := False;
  img.Picture := img2.Picture;
end;

procedure TWizard_Form.ntSerialClick(Sender: TObject);
begin
  prSerial.Visible := False;
  ntSerial.Visible := False;
  Serial_Panel.Visible := False;
  prBBA.Visible := False;
  ntBBA.Visible := False;
  BBA_Panel.Visible := False;

  ntFinish.Visible := True;
  prFinish.Visible := True;
  Finish_Panel.Visible := True;
  img.Picture := imgFinal.Picture;
end;

procedure TWizard_Form.prFinishClick(Sender: TObject);
begin
  ntFinish.Visible := False;
  prFinish.Visible := False;
  Finish_Panel.Visible := False;

  if GetSelected = SERIAL_IS_SELECTED then
  begin
    prSerial.Visible := True;
    ntSerial.Visible := True;
    Serial_Panel.Visible := True;
    prBBA.Visible := False;
    ntBBA.Visible := False;
    BBA_Panel.Visible := False;
    img.Picture := imgSERIAL.Picture;
  end else begin
    prBBA.Visible := True;
    ntBBA.Visible := True;
    BBA_Panel.Visible := True;
    prSerial.Visible := False;
    ntSerial.Visible := False;
    Serial_Panel.Visible := False;
    img.Picture := imgBBA.Picture;
  end;
end;

procedure TWizard_Form.BitBtn4Click(Sender: TObject);
begin
  Close;
end;

procedure TWizard_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);

var
  CanContinue : integer;

begin
  if ModalResult = mrOK then Exit;
  
  CanContinue := MsgBox(Handle, AreYouSureToCloseTheDialogWizard, QuestionCaption, 32 + MB_YESNO + MB_DEFBUTTON2);
  if CanContinue = IDNO then
  begin
    Action := caNone;
    Exit;
  end;
end;

procedure TWizard_Form.FormShow(Sender: TObject);
begin
  ResetWizard;
  InitControls;
end;

procedure TWizard_Form.ntFinishClick(Sender: TObject);
begin
  ApplyConfigToDCTOOLGUI;
  Wizard_Form.ModalResult := mrOK;
end;

procedure TWizard_Form.ntBBAClick(Sender: TObject);
begin
  if ValidIP(eIP.Text) = False then
  begin
    MsgBox(Handle, IPAddressMustBeValidFormat0000To255255255255, ErrorCaption, 48); //'IP address must be valid. Format : ''0.0.0.0'' to ''255.255.255.255''.'
    Exit;
  end;

  prSerial.Visible := False;
  ntSerial.Visible := False;
  Serial_Panel.Visible := False;
  prBBA.Visible := False;
  ntBBA.Visible := False;
  BBA_Panel.Visible := False;

  ntFinish.Visible := True;
  prFinish.Visible := True;
  Finish_Panel.Visible := True;
  img.Picture := imgFinal.Picture;
end;

procedure TWizard_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
