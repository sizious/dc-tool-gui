{
   [big_fury]
  888888888    8888  888888888888  8888     888888888     8888      8888   888888888
8888888888888  8888  888888888888  8888   8888888888888   8888      8888 8888888888888
8888     8888              88888         8888       8888  8888      8888 8888     8888
888888888      8888      888888    8888 8888         8888 8888      8888 888888888
  8888888888   8888     88888      8888 8888         8888 8888      8888   88888888888
       888888  8888   88888        8888 8888         8888 8888      8888         888888
8888      8888 8888  88888         8888  8888       8888  8888      8888 8888      8888
8888888888888  8888 88888888888888 8888   8888888888888    888888888888  8888888888888
  8888888888   8888 88888888888888 8888     888888888       8888888888     8888888888

  Projet      : DC-TOOL GUI v3.0
  Date        : 17/05/05 à 23h31

  Description : Partie du composant TDCTool, gérant la progression d'un transfert :
                - Upload ELF (Max = Section par section, parsé par la fonction ProcessLine)
                - Upload RAW BIN (Max = Taille du fichier traitée)
                - Download. (Max = Parsé par ProcessLine, une seule fois).

                Permet également l'implémentation des évènements.

  Autheur     : [big_fury]SiZiOUS

  Web         : http://sbibuilder.shorturl.com/

  Notes       : Merci Phidels, et surtout, Max Collomb pour TDosCommand.
}

//------------------------------------------------------------------------------

unit progress;

interface

uses
  SysUtils;
  
const
  //Gérer le début d'un progress.
  PG_DW_TAG               : string = 'recv_data: ';
  PG_UP_TAG               : string = 'send_data: ';
  TAG_SIZE                : integer = 11; //longueur des chaines du dessus (même taille).

  //Gérer le format du fichier.
  FILE_FORMAT             : string = 'File format is ';
  FILE_FORMAT_END         : string = ', start ';

  //Avoir la désignation, renvoyée dans l'évènement.. tjs pour le format du fichier.
  RAW_BIN                 : string = 'raw binary';
  ELF                     : string = 'elf32-shl';

  //Avoir la taille de la section ELF (ProgressBar.Max).
  SECTION_TAG             : string = 'Section ';
  SECTION_LMA_TAG         : string = ', lma ';
  PRG_MAX_ELF_TAG         : string = ', size ';
 
  //Chaque "C" (Compressed) ou "U" (Uncompressed) valent 8 bytes.
  STEP_VALUE              : integer = 8;

  //Les différents ratio pour diviser par la taille total ProgressBar.Max / RATIO
  ELF_SECTION_SIZE_RATIO  : integer = 1024;
  BIN_SECTION_SIZE_RATIO  : integer = 1024;
  DOWNLOAD_RATIO          : integer = 1024;

  //Détection et extraction de la taille à downloader.
  DOWNLOAD_TAG            : string = 'Download ';
  DOWNLOAD_END_TAG        : string = ' bytes at ';

  END_DCTOOL_OUTPUTS                  : string = '--';
  EXECUTING_STR                       : string = 'Sending execute command';

function Droite(substr : string ; s : string) : string;
function gauche(substr: string; s: string): string;
function ExtractStr(SubStrL, SubStrR, S : string) : string;
function IsInStartString(SubStr, S : string) : boolean;
function IsInString(SubStr, S : string) : boolean;
function GetFileSize(FileName : string) : integer;

implementation

//===[:: Utilitaires ::]========================================================

function NbSousChaine(substr: string; s: string): integer;
begin
  result:=0;
  while pos(substr,s)<>0 do
  begin
    S:=droite(substr,s);
    inc(result);
  end;
end;

//---IsInString---
//Cette fonction va vraiment comparer avec tout S (et non pas seulement le début).
function IsInString(SubStr, S : string) : boolean;
begin
  Result := False;
  if NbSousChaine(UpperCase(SubStr), UpperCase(S)) > 0 then Result := True;
end;

//---Droite---
function Droite(substr : string ; s : string) : string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

function gauche(substr: string; s: string): string;
begin
  result:=copy(s, 1, pos(substr, s)-1);
end;

function ExtractStr(SubStrL, SubStrR, S : string) : string;
var
  Tmp : string;

begin
  Tmp := Droite(SubStrL, S);
  Result := Gauche(SubStrR, Tmp);
end;

//---IsInStartString---
//Cette fonction verifie à partir du DEBUT de S.
//Exemple : S := "Section is already set"
//Si SubStr = "Nice!", la fonction va comparer avec "Secti" (5 chars).
//Et va donc renvoyer false.
function IsInStartString(SubStr, S : string) : boolean;
var
  Line : string;

begin
  Result := False;
  Line := LowerCase(Copy(S, 0, Length(SubStr)));
  if Line = LowerCase(SubStr) then Result := True;
end;

function GetFileSize(FileName : string) : integer;
var
  F : file of Byte;

begin
  Result := 0;
  if FileExists(FileName) = False then Exit;
  AssignFile(F, FileName);
  {$I+}
  Reset(F);
  {$I-}
  if IOResult <> 0 then Exit;

  Result := FileSize(F);
  CloseFile(F);
end;

end.
