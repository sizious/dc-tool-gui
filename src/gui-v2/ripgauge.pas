{
  Unit : RipGauge
         Permet de gérer pendant le download d'un Track (Rip GD).
}

unit ripgauge;

interface

uses
  Windows, SysUtils, Gauges, Classes;

const
  DREAMRIP_INIT     : string = 'DreamRip 2.01 by BERO';
  TRACK_INIT        : string = 'track';
  PERCENT_CONST     : string = '%';
                                                   //Pour simuler : 
  CDROM_INIT_ERROR  : string = 'cdrom init error'; //ouvrir le lecteur de la Dreamcast, cliquer sur 'Start RIP' (avec le clapet ouvert).
  IP_READ_ERROR     : string = 'ip read error'; //tres simple, a essayer avec le CD DC-LOAD.
  NOT_GD_ERROR      : string = 'not GD'; //Mettre un jeu gravé dans la Dreamcast.
  TOC_READ_ERROR    : string = 'toc read error'; //Faut un GD defecteux : jamais essayé.
  CDROM_READ_ERROR  : string = 'read err';  //faire un track03.iso en lecture seule. selectionner le dossier avec ce track03.iso. impossible d'ecrire dessus : on va generer cette erreur.
  TRACK_OPEN_ERROR  : string = 'open err'; //tres simple : lancer le rip normal avec un GD. Puis ouvrir le clapet du CD pendant l'operation ! (ca va meme quitter dreamrip pour essayer un autre GD!)
  NO_ERROR          : string = ''; //lol ! ;)

  //NORMAL_STATE  : string = 'no';
  
var
  IsRipping  : boolean = False;
  //IsErronous : boolean = False;
  LastError  : string  = '';

function IsDreamRipRunning(CurrentLine : string) : boolean;
function IsRippingTrack(CurrentLine : string ; Gauge : TGauge) : boolean;
function PerformProgressAndGiveSize(CurrentLine : string ; Gauge : TGauge) : string;
function DreamHaveRipError(CurrentLine : string) : boolean;
procedure ShowRightDreamRipError(Handle : HWND);

implementation

uses ext_track, tools, utils;

{
//---Droite---
function Droite(substr: string; s: string): string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

//---Gauche---
function gauche(substr: string; s: string): string;
begin
  result:=copy(s, 1, pos(substr, s)-1);
end;

//---ExtractStr---
function ExtractStr(SubStrL, SubStrR, S : string) : string; 
//Utilise Droite & Gauche de Michel
var
  Tmp : string;

begin
  Tmp := Droite(SubStrL, S);
  Result := Gauche(SubStrR, Tmp);
end; }

//---GetLastDreamRipError---
function GetLastDreamRipError : string;
begin
  Result := LastError;
end;

//---ShowRightDreamRipError---
procedure ShowRightDreamRipError(Handle : HWND);
begin
  if GetLastDreamRipError = NO_ERROR then Exit;
  if GetLastDreamRipError = CDROM_INIT_ERROR then MsgBox(Handle, 'CD-ROM initialisation error.', ErrorCaption, 48);
  if GetLastDreamRipError = IP_READ_ERROR then MsgBox(Handle, 'IP.BIN read error.', ErrorCaption, 48);
  if GetLastDreamRipError = NOT_GD_ERROR then MsgBox(Handle, 'The media inserted in the Dreamcast isn''t a GD-ROM.', ErrorCaption, 48);
  if GetLastDreamRipError = TOC_READ_ERROR then MsgBox(Handle, 'TOC read error.', ErrorCaption, 48);
  if GetLastDreamRipError = CDROM_READ_ERROR then MsgBox(Handle, 'CD-ROM read error.', ErrorCaption, 48);
  if GetLastDreamRipError = TRACK_OPEN_ERROR then MsgBox(Handle, 'Track open error.', ErrorCaption, 48);
end;

//---DreamHaveRipError---
function DreamHaveRipError(CurrentLine : string) : boolean;
var
  StringList  : TStringList;
  i           : integer;
  CurrentItem : string;

begin
  Result := False;

  StringList := TStringList.Create;
  try
    StringList.Add(CDROM_INIT_ERROR);
    StringList.Add(IP_READ_ERROR);
    StringList.Add(NOT_GD_ERROR);
    StringList.Add(TOC_READ_ERROR);
    StringList.Add(CDROM_READ_ERROR);
    StringList.Add(TRACK_OPEN_ERROR);

    for i := 0 to StringList.Count - 1 do
    begin
      CurrentItem := StringList.Strings[i];
      //ShowMessage(CurrentItem);
      if UpperCase(CurrentItem) = UpperCase(CurrentLine) then
      begin
        LastError := CurrentItem;
        //ShowMessage('RESULT := TRUE');
        Result := True;
        Break;
      end;
    end;
  finally
    StringList.Free;
  end;
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
end;

//---IsDreamRipRunning---
 function IsDreamRipRunning(CurrentLine : string) : boolean;
begin
  Result := False;
  if CurrentLine = DREAMRIP_INIT then Result := True;
end;

//---IsRippingTrack---
function IsRippingTrack(CurrentLine : string ; Gauge : TGauge) : boolean;
begin
  Result := False;
  if NbSousChaine(TRACK_INIT, CurrentLine) > 0 then
  begin
    Result := True;
    Gauge.Progress := 0;
  end;
end;

//---PerformProgressAndGiveSize---
function PerformProgressAndGiveSize(CurrentLine : string ; Gauge : TGauge) : string;
var
  ExtractedLine : string;

begin
  Result := '';
  if NbSousChaine(PERCENT_CONST, CurrentLine) > 0 then
  begin
    ExtractedLine := Droite(' ', CorrectLine(' ', CurrentLine));
    //ShowMessage('Droite('' '', CorrectLine('' '', CurrentLine) = ' + ExtractedLine);
    Gauge.Progress := StrToInt(ExtractStr(' ', PERCENT_CONST, ExtractedLine));
    //ShowMessage('Gauge.Progress = ' + ExtractStr(' ', PERCENT_CONST, ExtractedLine));
    Result := ExtractStr(' ', ' ', CorrectLine(' ', CurrentLine));
    //ShowMessage('Result = ' + Result);
  end;
end;

{
DreamRip 2.01 by BERO
VIRTUA TENNIS
no type   start   size    MB
session 1
 1 DATA       0    600    1M
 2 AUDIO    600   5950   13M
session 2
 3 DATA   45000 504150 1032M
track03.iso
    0/1032M 0%
    1/1032M 0%
    2/1032M 0%
    3/1032M 0%
    4/1032M 0%
    5/1032M 0%
    6/1032M 0%
    7/1032M 0%
    8/1032M 0%
    9/1032M 0%
   10/1032M 0%
   11/1032M 1%
   12/1032M 1%
   13/1032M 1%
   14/1032M 1%
   15/1032M 1%
   16/1032M 1%
   17/1032M 1%
   18/1032M 1%
   19/1032M 1%
   20/1032M 1%
   21/1032M 2%
   22/1032M 2%
   23/1032M 2%
}

end.
