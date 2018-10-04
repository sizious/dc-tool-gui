unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TSplashScreen_Form = class(TForm)
    BackGround_Image: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  SplashScreen_Form: TSplashScreen_Form;
  SSHandle : HWND = 0;
  
implementation

{$R *.dfm}

uses tools, u_dctool_manager;

//----BmpToForm------------------------------------------------------------------------
procedure BmpToForm(BMP : TImage; CouleurTransparente : TColor);
var
    i, j, debutY : Integer;
    rgn, rgn1 : HRGN;

begin
rgn := CreateRectRgn(0, 0, 0, 0);
for i := 0 to bmp.Width-1 do
  begin
    j := 0;
    while j < bmp.Height-1 do
      begin
       if bmp.Canvas.Pixels[i, j] <> CouleurTransparente then
        begin
         debutY := j;
         while (bmp.Canvas.Pixels[i, j] <> CouleurTransparente)
                and (j < bmp.Height) do
          inc(j);
         rgn1 := CreateRectRgn(i, debutY, i+1, j);
         CombineRgn(rgn, rgn, rgn1, RGN_OR);
         DeleteObject(rgn1);
        end;
      inc(j);
      end;
  end;
  //Showmessage(inttostr(splashscreen_form.handle));
  //Showmessage(inttostr(SSHandle));
  SetWindowRgn(SSHandle, rgn, true);  ///BUG
end;

procedure TSplashScreen_Form.FormCreate(Sender: TObject);
var
  SplashFile : string;

begin
  SplashFile := GetTempDir + 'DCTOOL.BMP';
  ExtractSplashScreen;

  if FileExists(SplashFile) = True then
    BackGround_Image.Picture.LoadFromFile(SplashFile);
  BackGround_Image.AutoSize := True;
end;

procedure TSplashScreen_Form.FormActivate(Sender: TObject);
begin
  BmpToForm(BackGround_Image, BackGround_Image.Canvas.Pixels[1, 1]);
end;

end.
