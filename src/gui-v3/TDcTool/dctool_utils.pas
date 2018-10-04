unit dctool_utils;

interface

uses
  SysUtils;
  
function ValidIP(aIP : string) : boolean;
function GetRealPath(Path : string) : string;

implementation

//---GaucheNDroite---
function GaucheNDroite(substr: string; s: string;n:integer): string;
var
  i : integer;
  
begin
  S:=S+substr;
  for i:=1 to n do
  begin
    S:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
  end;
  result:=copy(s, 1, pos(substr, s)-1);
end;

//---ValidIP---
function ValidIP( aIP : string ) : Boolean;
{ Détermine si la string passée en paramètre est une adresse IP }
var
    iNb,
    iVal     : Integer;
    bOK : Boolean;
    sTmp,
    sTmpIP : string;

//---IsIPFormatted---
function IsIPFormatted(IP : string) : boolean;
begin
  Result := False;
  if Length(GaucheNDroite('.', aIP, 0)) > 3 then Exit;
  if Length(GaucheNDroite('.', aIP, 1)) > 3 then Exit;
  if Length(GaucheNDroite('.', aIP, 2)) > 3 then Exit;
  if Length(GaucheNDroite('.', aIP, 3)) > 3 then Exit;
  Result := True;
end;

begin
    bOK := True;

    //---Si c'est > 3 c'est pas une IP
    if IsIPFormatted(aIP) = False then
    begin
      //bOK := False;
      Result := False;
      Exit;
    end;

    iNb := 0;
    sTmpIP := aIP;
    repeat
    if Pos( '.', sTmpIP ) > 0 then
    begin
        { Récupération du premier nombre de la chaine sTmpIP }
        sTmp := Copy( sTmpIP, 1, Pos( '.', sTmpIP ) - 1 );
        { on enlève le nombre qui vient d'être lu par sTmp }
        sTmpIP := Copy( sTmpIP, Pos( '.', sTmpIP ) + 1, Length( sTmpIP ) );
    end
    else
    begin
        sTmp := sTmpIP; { Récupération du nombre restant dans la chaine sTmpIP }
        sTmpIP := ''; { Il n'y a plus rien à lire }
    end;

    { Vérification s'il s'agit d'un nombre }
    try
        iVal := StrToInt( sTmp );
        if (iVal > 255) or (iVal < 0) then { Si le nombre > 255 ou < 0, ce n'est pas une adresse IP }
        bOk := False
        else
        inc( iNb ); { Maintenir le compte de chiffres dans la chaine }
    except
        { Si on arrive à cette erreur, il ne s'agit pas d'un nombre }
        on E : EConvertError do bOK := False; 
    end;
    { Boucler jusqu'à ce qu'on passe au travers de la chaine ou qu'il y ait une erreur }
    until ( sTmpIP = '' ) or not bOK;

    { S'il n'y a pas 4 nombres, ce n'est pas une adresse IP }
    if iNb <> 4 then bOK := False;

    Result := bOK;
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

end.
