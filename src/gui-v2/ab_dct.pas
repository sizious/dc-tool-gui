unit ab_dct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, credits, XPMan, DXDraws, DXClass,
  RbDrawCore, RbButton;

type
  TAbout_Form = class(TForm)
    Bevel1: TBevel;
    Shape: TShape;
    ScrollingCredits: TScrollingCredits;
    Trad_Label: TLabel;
    XPManifest: TXPManifest;
    DXDraw: TDXDraw;
    DXTimer: TDXTimer;
    DXImageList: TDXImageList;
    Timer: TTimer;
    ClickHere_Button: TRbButton;
    RbStyleManager1: TRbStyleManager;
    Close_Button: TRbButton;
    Shape1: TShape;
    Panel: TPanel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DXTimerTimer(Sender: TObject; LagCount: Integer);
    procedure DXDrawInitialize(Sender: TObject);
    procedure DXDrawFinalize(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure RbButton2Click(Sender: TObject);
    procedure RbButton1Click(Sender: TObject);
  private
    { Déclarations privées }
    FAngle: Integer;
  public
    { Déclarations publiques }
  end;

var
  About_Form: TAbout_Form;

implementation

uses MiniFMOD, about;

{$R *.dfm}
{$R r-dash.RES} //musique

//---PlayMusic---
procedure PlayMusic;
begin
  About_Form.ScrollingCredits.Animate := True;
  XMPlayFromRes('MUSIC', 'XMMOD');
end;

//---StopMusic---
procedure StopMusic;
begin
  About_Form.ScrollingCredits.Animate := False;
  XMFree;
end;

procedure TAbout_Form.FormShow(Sender: TObject);
begin
  PlayMusic;
end;

procedure TAbout_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopMusic;
end;

procedure TAbout_Form.DXTimerTimer(Sender: TObject; LagCount: Integer);
begin
  if not DXDraw.CanDraw then Exit;
  DXDraw.Surface.Fill(0);     //                 X  Y  Wid Hgt pat. amp len ph
  DXImageList.Items[0].DrawWaveX(DXDraw.Surface, 0, 0, 337, 153, 0, 2, 50, FAngle*20);
  Inc(FAngle);
  DXDraw.Flip;
end;

procedure TAbout_Form.DXDrawInitialize(Sender: TObject);
begin
//  DXTimer.Enabled := True;
end;

procedure TAbout_Form.DXDrawFinalize(Sender: TObject);
begin
  DXTimer.Enabled := False;
end;

procedure TAbout_Form.TimerTimer(Sender: TObject);
begin
  if Panel.Visible = False then
    Panel.Visible := True
  else Panel.Visible := False;
end;

procedure TAbout_Form.RbButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TAbout_Form.RbButton1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
  //ShowMessage('Ripped');
end;

end.
