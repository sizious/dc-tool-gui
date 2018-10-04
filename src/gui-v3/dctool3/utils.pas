unit utils;

interface

uses
  Windows, SysUtils, Messages, Forms;

const
  WrapStr : string = #13 + #10;
  CONFIG_DIR  : string = 'Config';

function MsgBox(Handle : HWND ; Message, Caption : string ; Flags : integer) : integer;
function GivePercent(Current, Max : integer) : integer;
function GetAppDir : string;
function GetRealPath(Path : string) : string;
procedure SimulateLeftClick;
function CheckDirectory(Handle : HWND ; Dir, FunctionName : string): boolean;
function CheckFileName(Handle : HWND ; FName, FunctionName : string): boolean;
function droite(substr: string; s: string): string;
function NbSousChaine(substr: string; s: string): integer;
function GaucheNDroite(substr: string; s: string;n:integer): string;
procedure SetWindowFocus(Handle : HWND);

implementation

uses
  Main;

procedure SetWindowFocus(Handle : HWND);
begin
  Application.Restore;
  Main_Form.SetFocus;
  SetWindowPos(Main_Form.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);   //la fiche se place en avant
  SetWindowPos(Main_Form.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE); //la fiche ne se place en avant
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);   //la fiche se place en avant
  SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE); //la fiche ne se place en avant
  //SendMessage(Handle, WM_SETFOCUS, 0, 0);
  SetForegroundWindow(Handle);
end;

//---MsgBox---
//Programmation de l'API MessageBoxA.
function MsgBox(Handle : HWND ; Message, Caption : string ; Flags : integer) : integer;
begin
  Result := MessageBoxA(Handle, PChar(Message), PChar(Caption), Flags);
end;

//---GivePercent---
//Avoir le pourcentage d'une valeur Current en fonction de Max. (pr la pbar transfert)
function GivePercent(Current, Max : integer) : integer;
begin
  Result := (Current * 100) div Max;
end;

//---GetAppDir---
//Avoir le dossier de l'application.
function GetAppDir : string;
begin
  Result := GetRealPath(ExtractFilePath(Application.ExeName));
end;

//---GetRealPath---
//Corriger les defauts des paths... du genre "C:\\ACXC\\\\AAA\"...
function GetRealPath(Path : string) : string;
var
  i : integer;
  LastCharWasSeparator : Boolean;

begin
  Result := '';
  LastCharWasSeparator := False;

  Path := Path + '\';

  for i := 1 to Length(Path) do
  begin
    if Path[i] = '\' then
    begin
      if not LastCharWasSeparator then
      begin
        Result := Result + Path[i];
        LastCharWasSeparator := True;
      end
    end
    else
    begin
       LastCharWasSeparator := False;
       Result := Result + Path[i];
    end;
  end;
end;

procedure SimulateLeftClick;
var
  Point : TPoint;

begin
  //On prend les coordonn�es du curseur de souris...
  GetCursorPos(Point);

  //Cette ensemble de proc�dure permet de simuler le click.
  //Un click gauche est constitu� de deux clicks : quand le
  //bouton est en haut, et quand le bouton est en bas.
  Mouse_Event(MOUSEEVENTF_LEFTDOWN, Point.X, Point.Y, 0, 0);
  Mouse_Event(MOUSEEVENTF_LEFTUP, Point.X, Point.Y, 0, 0);

  //Permet "d'activer" la s�lection. Sinon ca s�lectionne pas.
  //En fait, ca rend la main a Windows.
  Application.ProcessMessages;

  //On d�roule avec du code pour d�rouler si seulement la
  //CheckBox est coch�e. Vous pouvez enlever ca, et mettre
  //AutoPopup � True dans le PopupMenu.
  //PopUpMenu.Popup(Point.X, Point.Y);
end;

//------------------------------------------------------------------------------

function CheckDirectory(Handle : HWND ; Dir, FunctionName : string): boolean;
begin
  Result := True;
  
  if not DirectoryExists(Dir) then
    begin
      MsgBox(Handle, 'Warning, directory for ' + FunctionName
        + ' function not found.' + WrapStr + 'Name : "'
          + Dir + '".', 'Warning', 48);
      Result := False;
    end;
end;

function CheckFileName(Handle : HWND ; FName, FunctionName : string): boolean;
begin
  Result := True;

  if not FileExists(FName) then
    begin
      MsgBox(Handle, 'Warning, file for ' + FunctionName + ' function not found.'
        + WrapStr + 'File : "' + FName + '".', 'Warning', 48);
      Result := False;
    end;
end;

//------------------------------------------------------------------------------

//---droite---
function droite(substr: string; s: string): string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

//renvoie le nombre de fois que la sous chaine substr est pr�sente dans la chaine S
function NbSousChaine(substr: string; s: string): integer;
begin
  result:=0;
  while pos(substr,s)<>0 do
  begin
    S:=droite(substr,s);
    inc(result);
  end;
end;

function GaucheNDroite(substr: string; s: string;n:integer): string;
{==============================================================================}
{ renvoie ce qui est � gauche de la droite de la n ieme sous chaine substr     }
{ de la chaine S                                                               }
{ ex : GaucheNDroite('\','c:machin\truc\essai.exe',1) renvoie 'truc'           }
{ Permet d'extraire un � un les �l�ments d'une chaine s�par�s par un s�parateur}
{==============================================================================}
var i:integer;
begin
  S:=S+substr;
  for i:=1 to n do
  begin
    S:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
  end;
  result:=copy(s, 1, pos(substr, s)-1);
end;

end.
