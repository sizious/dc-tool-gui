unit aboutprg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RVStyle, RVScroll, RichView, StdCtrls, GIFImage,
  pngimage, jpeg, ShellApi;

type
  TAbout_Form = class(TForm)
    RVStyle: TRVStyle;
    tScrollingText: TTimer;
    Image4: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    RichView: TRichView;
    tRunningSonic: TTimer;
    Image5: TImage;
    Bevel1: TBevel;
    pClose: TPanel;
    imSonicRunning: TImage;
    imTailsRunning: TImage;
    Image6: TImage;
    pSiZ: TPanel;
    procedure tScrollingTextTimer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure tRunningSonicTimer(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure pCloseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pCloseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pCloseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pCloseClick(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pSiZClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    procedure InitScrollingCredits;
    procedure DoScroll;

    procedure InitAnim;
    procedure RunAnim;

    procedure InitButtonsAnim;
    procedure RunButtonsAnim;
  public
    { Déclarations publiques }
  end;

var
  About_Form: TAbout_Form;

implementation

uses
  MiniFMOD, about;
  
{$R *.dfm}
{$R MUSIC.RES}

const
  SONIC_SPEED : integer = 4;
  TAILS_SPEED : integer = 2;

procedure TAbout_Form.InitScrollingCredits;
const crlf:String = chr(13)+chr(10);
begin
  with RichView do begin
     AddTextFromNewLine(
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+
        ' ', rvsNormal);

     AddCenterLine ('DC-TOOL GUI 3', rvsHeading);

     AddTextFromNewLine(crlf+' '+crlf+' ', rvsNormal);
     //AddTextFromNewLine('Yep', rvsSubheading);

     AddTextFromNewLine('©reated in 2002-2005' + crlf +
      'by [big_fury]SiZiOUS' + crlf + 'http://sbibuilder.shorturl.com/'+crlf+' ', rvsNormal);
     AddTextFromNewLine('"What ? Huh ? Dreamcast dead ? Are you talking to me ? ^^"'
      +crlf+' '+crlf+' ', rvsNormal);

     AddTextFromNewLine(
        'This''s the new version of DC-TOOL GUI !'+crlf+
        'I hope you think it useful for your Dreamcast developpements.'
        +crlf + ' ' + crlf + ' ', rvsNormal);

     AddTextFromNewLine('Alpha testers :', rvsSubheading);
     AddTextFromNewLine('JMD, dcprogfr, speud, Ron, Omer, Rom1, mixman'+ crlf + ' ', rvsNormal);

     AddTextFromNewLine('Greetings go to :', 6);
     AddTextFromNewLine(crlf+ ' ', rvsNormal);

     AddTextFromNewLine('Thanks to ADK for the original DC-TOOL.' + crlf+' ', rvsNormal);
     
     AddTextFromNewLine('Logo creators :', rvsSubheading);
     AddTextFromNewLine('hieronymus for the draw and Djizeuss for the colorization.'+
      ' SevLila je compte sur toi ^^'+crlf+' ', rvsNormal);
      
     AddTextFromNewLine('French Dreamcast Scene : ', rvsSubheading);
     AddTextFromNewLine('Including DCReload, DC-FRANCE...', rvsNormal);
     AddTextFromNewLine('JMD, L@ Cible, dcprogfr, erwan, diwee, oggy,' +
      ' Pingouindream, Christluu, patbier, Poche, telliam, ' +
      'olivier, cédric, speud, Deadly-Skies, Semicolo, mixman, evilcyril, '+
      ' yoann007, shikigami, lekteur, Sakuragi, escargot, Man-Jimaru, Kurdy, edd,'
      + ' hieronymus, Djizeuss, Venom, SevLila, Codex, bendermike, MexNin,'
      + ' yngwie, Kirkrum, sekk, Rom1, Radigo, GroSeb, Omer, everyone...'+ crlf+' ', rvsNormal);

     AddTextFromNewLine('International Dreamcast Scene : ', rvsSubheading);
     AddTextFromNewLine('BlackAura, quzar, Rand Linden, Segata Sanshiro, ShadowofBob,'
     + ' Mikey242, qatmix, Wraggster, greay, impetus, az_bont, The Kron, kRYPT_, Porto,'
     + ' Fackue/LyingWake, Curtiss Grymala, Ian Michael, Max Scharl, Marcus,'
     + ' Metafox, Darksaviour69, Christuserloeser, scherzo, rmedtx, warmtoe,'
     + ' bucanero, burnerO, DCGrendel, Pavlik, c99koder, M@jk, DCDayDreamer, BlueCrab,'
     + ' ptr.exe, Mekanaizer, Phantom, a128, GPF, atani, WHurricane16, OneThirty8,'
     + ' I.M. Weasel, Arquiero, Ender ... i hope i forgot nobody ... :)' +crlf+' ', rvsNormal);

     AddTextFromNewLine('Spanish Dreamcast Scene : ', rvsSubheading);
     AddTextFromNewLine('Ron, Kupra, KorteX, LTK666, Belavi, timofonic, D4rkbit, josemci, Chui, Fox68k...'
      +crlf+' ', rvsNormal);

     AddTextFromNewLine('Delphi Programming : ', rvsSubheading);
     AddTextFromNewLine('Michel, JROD, Vector, Sephiroth Lune, ReMix, DevelOpeR13,'+
     ' Shai, DooMeeR, tourlourou, Shon, firejocker, jobe, ZeuS-[SFX], elran, Kitsune,'
     + ' SindromX, nobs, JohnFullspeed, magicvinni, tode, Columbo, jinh, rguef, '
     + 'Lepidosteus, nicknack, Moniteur, Bill, renou, systmd, outch... tous ceux'
     + ' que j''ai oublié !', rvsNormal);
     AddTextFromNewLine('Delphiprog, Nix, Bestiol... de Delphi-FR.'+crlf+' ', rvsNormal);

     AddTextFromNewLine('Special Thanks to Rabusier and Broadc4st.'+crlf+' ', rvsNormal);
     AddTextFromNewLine('Anyway, SORRY if you aren''t here.'+crlf+' ', rvsNormal);

     AddTextFromNewLine('Greetings to MaxX, the original DosCommand component creator.', rvsNormal);
     AddTextFromNewLine('This app use GifImage, SynEdit, PngImage, Jedi-VCL, and some others stuffs.',
      rvsNormal);
     AddTextFromNewLine('Many thanks to all for your greats components.'+crlf+' ', rvsNormal);

     AddTextFromNewLine('And thank you for using this program.'+crlf+' ', rvsNormal);

     AddTextFromNewLine('See ya''', rvsNormal);
     AddTextFromNewLine('[big_fury]SiZiOUS, aka SiZ!', rvsNormal);
     AddTextFromNewLine('http://sbibuilder.shorturl.com/'+crlf+' '+crlf+' '
     +crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' ', rvsNormal);

     AddTextFromNewLine('AND REMEMBER : DREAMCAST IS NOT DEAD!', 7);
     AddTextFromNewLine('...IT''S ALIVE AND KICKIN.', 7);

     AddTextFromNewLine(
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf, rvsNormal);

     AddTextFromNewLine('...Yeah, I put Space Harrier music with Sonic characters. '
     + ' And then ? :P', rvsNormal);
     AddTextFromNewLine('Thanks to frederic hahn for his cool music. :)', rvsNormal);
     AddTextFromNewLine(
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf, rvsNormal);

     AddTextFromNewLine('Are you there yet ? ^^''', rvsNormal);
     AddTextFromNewLine(
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf, rvsNormal);
     AddTextFromNewLine('Really cool music, heh ? :)', rvsNormal);
     AddTextFromNewLine('WOOHOO! See you in next release, i hope, Dreamcast is far my'
      + ' favorite system, YEAH! :)', rvsNormal);

     AddTextFromNewLine(
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+
        ' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+' '+crlf+
        ' ', rvsNormal);
     VSmallStep := 1;        
     Format;
  end;
end;

procedure TAbout_Form.tScrollingTextTimer(Sender: TObject);
begin
  DoScroll;
end;

procedure TAbout_Form.DoScroll;
begin
  if RichView.VScrollPos<>RichView.VScrollMax then
    RichView.VScrollPos := RichView.VScrollPos+1
  else
    RichView.VScrollPos := 0;
end;

procedure TAbout_Form.Image1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://www.dreamcast-scene.com/', '', '', SW_SHOWNORMAL);
end;

procedure TAbout_Form.Image2Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://synedit.sourceforge.net/', '', '', SW_SHOWNORMAL);
end;

procedure TAbout_Form.Image3Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://www.borland.com/us/products/delphi/index.html', '', '', SW_SHOWNORMAL);
end;

procedure TAbout_Form.InitAnim;
begin
  imSonicRunning.Left := -50;
  imTailsRunning.Left := -150;
  tRunningSonic.Enabled := True;
end;

procedure TAbout_Form.RunAnim;
begin
  with imSonicRunning do
    if Left < Self.Width then Left := Left + SONIC_SPEED;

  with imTailsRunning do
  begin
    Left := Left + TAILS_SPEED;
    if Left > Self.Width then
    begin
      tRunningSonic.Enabled := False;
      RunButtonsAnim;
    end;
  end;   
end;

procedure TAbout_Form.tRunningSonicTimer(Sender: TObject);
begin
  RunAnim;
end;

procedure TAbout_Form.Image5Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://www.phidels.com/', '', '', SW_SHOWNORMAL);
end;

procedure TAbout_Form.pCloseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TPanel).BevelOuter := bvLowered;
end;

procedure TAbout_Form.pCloseMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TPanel).BevelOuter := bvRaised;
end;

procedure TAbout_Form.pCloseMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  (Sender as TPanel).Font.Color := clBlue;
end;

procedure TAbout_Form.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  pClose.Font.Color := clBlack;
  pSiZ.Font.Color := clBlack;
end;

procedure TAbout_Form.pCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TAbout_Form.RunButtonsAnim;
begin
  with pClose do
    while Left <> 496 do
    begin
      Application.ProcessMessages;
      Left := Left - 1;
      Application.ProcessMessages;
    end;
    
  with pSiZ do
    while Top <> 472 do
    begin
      Application.ProcessMessages;
      Top := Top - 1;
      Application.ProcessMessages;
    end;
end;

procedure TAbout_Form.InitButtonsAnim;
begin
  pClose.Left := 620;
  pSiZ.Top := 600;
end;

procedure TAbout_Form.Image6Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://dctop.free.fr/in.php?id=57', '', '', SW_SHOWNORMAL);
end;

procedure TAbout_Form.FormShow(Sender: TObject);
begin
  InitScrollingCredits;
  InitButtonsAnim;
  InitAnim;
  XMPlay;
end;

procedure TAbout_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  XMFree;
end;

procedure TAbout_Form.pSiZClick(Sender: TObject);
begin
  pSiZ.BevelOuter := bvRaised;
  pSiZ.Font.Color := clBlack;
  AboutBox := TAboutBox.Create(Application);
  try
    AboutBox.ShowModal;
  finally
    AboutBox.Free;
  end;
end;

procedure TAbout_Form.FormCreate(Sender: TObject);
begin
  XMLoadFromRes('SPACE', 'MUSIC');
end;

end.
