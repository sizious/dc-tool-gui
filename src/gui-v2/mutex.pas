{
  Mutex : Permet de savoir si l'application est déjà lancé, car le compo de Michel
          bug avec DC-TOOL GUI.
}

unit mutex;

interface

uses
  Windows, SysUtils;

function IsApplicationRunning(ClassName : string ; ApplicationNameInCaption, AuthorInCaption : string) : boolean;
function EnumWindowsCallback(hWnd: HWND; lParam: LPARAM): BOOL ; stdcall;

implementation

uses tools, progress;

var
  NumFenetre : integer;
  TabClass   : array[0..1000] of string;
  TabTexte   : array[0..1000] of string;
  TabHandle  : array[0..1000] of HWND;

//---Droite---
{ function droite(substr: string; s: string): string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

//---NbSousChaine---
function NbSousChaine(substr: string; s: string): integer;
begin
  result:=0;
  while pos(substr,s)<>0 do
  begin
    S:=droite(substr,s);
    inc(result);
  end;
end;  }

//---EnumWindowsCallback---
function EnumWindowsCallback(hWnd: HWND; lParam: LPARAM): BOOL;
Var
  Texte:array[0..250]of Char;
  Classe:array[0..250]of Char;
    
begin
  inc(numFenetre);
  GetWindowText(hWnd,Texte,SizeOf(Texte));
  GetClassName(hWnd,Classe,SizeOf(Classe));
  tabHandle[numFenetre]:=hWnd;
  tabTexte[numFenetre]:=string(Texte);
  tabClass[numFenetre]:=string(Classe);
  if numFenetre < 1000 then result:=true else result:=false;// pour que l'énumération ne s'arrète pas; pour que EnumWindows continue à appeler EnumWindowsCallback pour les autres fenêtres
end;

//---IsApplicationRunning---
function IsApplicationRunning(ClassName : string ; ApplicationNameInCaption, AuthorInCaption : string) : boolean;
var
  i : Word;

begin
  // EnumWindows va appeler EnumWindowsCallback pour chaque fenetre présente
  NumFenetre := -1;
  Result := False;
  EnumWindows(@EnumWindowsCallback, 0);

  for i := 0 to numFenetre do
  begin
    //showmessage(tabClass[i]);
    if UpperCase(tabClass[i]) = UpperCase(ClassName) then
    begin
      //ShowMessage(tabClass[i]);
      if NbSousChaine(UpperCase(ApplicationNameInCaption), UpperCase(tabTexte[i])) > 0 then
        if NbSousChaine(UpperCase(AuthorInCaption), UpperCase(tabTexte[i])) > 0 then
          Result := True;
    end; //if uppercase
  end; //for i := 0
end;

end.
