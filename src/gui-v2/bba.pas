unit bba;

interface

uses
  Windows, SysUtils, ShellApi;

const
  LINK_TYPE_BBA     : Word = $FA;
  LINK_TYPE_SERIAL  : Word = $FF;

procedure EnableBBA;
procedure EnableSerial;
function GetConnectionMethod : Word;
function PerformBBAReset : boolean;
function ReadIP : string;
function ValidIP(aIP : string) : boolean;

implementation

uses main, tools, setip, ext_track;

//---EnableBBA---
procedure EnableBBA;
begin
  Main_Form.Setdeviceport1.Enabled := False;
  Main_Form.Usebautrate1.Enabled := False;
  Main_Form.ryalternate1152001.Enabled := False;
  Main_Form.Usedumbterminalrather1.Enabled := False;
  Main_Form.SetcommunicationIPto1.Enabled := True;
  Main_Form.Serial1.Checked := False;
  Main_Form.BroadbandAdapter1.Checked := True;
  WriteLinkType;
end;

//---EnableSerial---
procedure EnableSerial;
begin
  Main_Form.Setdeviceport1.Enabled := True;
  Main_Form.Usebautrate1.Enabled := True;
  Main_Form.ryalternate1152001.Enabled := True;
  Main_Form.Usedumbterminalrather1.Enabled := True;
  Main_Form.SetcommunicationIPto1.Enabled := False;
  Main_Form.Serial1.Checked := True;
  Main_Form.BroadbandAdapter1.Checked := False;
  WriteLinkType;
end;

//---GetConnectionMethod---
function GetConnectionMethod : Word;
begin
  if Main_Form.Serial1.Checked = True then
    Result := LINK_TYPE_SERIAL
  else Result := LINK_TYPE_BBA;
end;

//---PerformBBAReset---
function PerformBBAReset : boolean;
begin
  Result := False;
  if not FileExists(DCTOOLIP) then Exit;
  ShellExecute(Main_Form.Handle, 'open', 'DCTOOLIP', '-r', PChar(GetTempDir), SW_HIDE);
  Result := True;
end;

//---ReadIP---
function ReadIP : string;
begin
  Result := IP_Form.eIP.Text;
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
      bOK := False;
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

end.
