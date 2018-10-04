{
  Unit : ext_track
  By   : [big_fury]SiZiOUS
  For  : DC-TOOL GUI v1.2
  Notes: Permet d'extraire toutes les informations du fichier track.txt créé par
         DreamRip de BERO puis de les ajouter ensuite à un TreeView et un ListView.
         Beaucoup plus simple à lire que dans le debug du DC-TOOL GUI !

         Fonction a peu près terminée & opérationnelle le 30/06/2004 à 13:48 !
}

unit ext_track;

interface

uses
  Windows, SysUtils, Classes, ComCtrls, Dialogs, Forms, JvRichEdit;

const
  TRACKLIST_FILENAME : string = 'TRACKLST.DAT';
  SESSION_CONST      : string = 'SESSION';
  ORIGINAL_TRACKLIST : string = 'TRACK.TXT';
  AUDIO_TRACK_TYPE   : string = 'AUDIO';
  DATA_TRACK_TYPE    : string = 'DATA';
  TEMP_TRACKLIST     : string = 'TRACKLST.TMP';

function ReadGameName(FileName : string) : string;
procedure ReadTrackList(ListView : TListView ; TreeView : TTreeView);
function GetSelectedDir : string;
function CorrectLine(SubStr, Str : string) : string;
function NbSousChaine(substr: string; s: string): integer;
function GetTrackName(NewLine : string) : string;
procedure InitTrackRip(TrackName : string);
function GetLastRichEditLine(RichEdit : TJvRichEdit) : string;
function GaucheNDroite(substr: string; s: string;n:integer): string;

implementation

uses tools, gd_ripper;

var
  CurrentNode : TTreeNode = nil;
  
{ Structure du fichier texte :

VIRTUA TENNIS

no type   start   size    MB
session 1
 1 DATA       0    600    1M
 2 AUDIO    600   5950   13M
session 2
 3 DATA   45000 504150 1032M

}

//---GetLastRichEditLine---
function GetLastRichEditLine(RichEdit : TJvRichEdit) : string;
begin
  Result := '';
  if RichEdit.Lines.Count = 0 then Exit;
  Result := RichEdit.Lines.Strings[RichEdit.Lines.Count - 1];
end;

//---InitTrackRip---
procedure InitTrackRip(TrackName : string);
const
  TRACK     : string = 'TRACK';

var
  TrackNumber : integer;
  ListView    : TListView;
  TrackSize   : string;

begin
  TrackName := UpperCase(TrackName); //Tout traiter en MAJ
  ListView := RipGD_Form.ListView;
  
  if NbSousChaine(TRACK, TrackName) <= 0 then Exit; //Si pas 'Track' dans NewLine, on n'a rien à faire ici!

  TrackNumber := StrToInt(ExtractStr(TRACK, '.', TrackName)) - 1; //Recupere le numéro de piste (-1 car l'item n°1 est le 0!)
  if ListView.Items.Item[TrackNumber] = nil then Exit; //Si l'item existe pas, on se tire.

  TrackSize := ListView.Items.Item[TrackNumber].SubItems.Strings[4];
  RipGD_Form.lSize.Caption := '0/' + TrackSize; //Initialise la caption du champ 'Size'.

  Application.Title := 'Ripping GD [' + RipGD_Form.lTrackName.Caption + '] - '
    + '0/' + TrackSize + ' - ' + IntToStr(RipGD_Form.Gauge.Progress) + '%';
end;

//---GetTrackName---
{ Role : Cette fonction permet d'extraire le nom de fichier dans la ligne
         interceptée par le DosCommand.
         Cas de figure : pour 'track03.iso', aucun problème : pas d'init.
         Mais pour apres, on a pas 'track04.raw', mais
         'track04.raw       0/39M 0%'.
         L'initialisation se fait au même endroit !
         On va donc filtrer la ligne pour ne retenir que le track04.raw.

}
function GetTrackName(NewLine : string) : string;
const
  RAW_TRACK : string = 'RAW';
  ISO_TRACK : string = 'ISO';
  EMPTY     : string = '';
  TRACK     : string = 'TRACK';

begin
  Result := EMPTY; //Resultat vide.
  NewLine := UpperCase(NewLine); //Tout traiter en MAJ

  //Si pas 'Track' dans NewLine, on n'a rien à faire ici!
  if NbSousChaine(TRACK, NewLine) <= 0 then Exit;

  //si la piste n'est ni ISO, ni RAW, on s'arrache ! (y'a un problème, ca n'arrive
  //pas normalement).
  if NbSousChaine(RAW_TRACK, NewLine) <= 0 then //Y'a pas RAW?...
    if NbSousChaine(ISO_TRACK, NewLine) <= 0 then //...y'a pas ISO?...
    begin
      Result := '<unavailable>';  //...Y'a rien alors!
      Exit;
    end;

  if NbSousChaine(RAW_TRACK, NewLine) > 0 then //Y'a RAW.
    Result := LowerCase('track' + Droite(TRACK, Gauche(RAW_TRACK, NewLine) + 'raw')) //C'est donc un piste RAW!
  else Result := LowerCase('track' + Droite(TRACK, Gauche(ISO_TRACK, NewLine) + 'iso')); //Bah sinon, c'est ISO!
end;

//---GetNumberLine---
//Savoir le nombre de lignes dans le fichier.
function GetNumberLine(FileName : string) : integer;
var
  F : TextFile;
  i : integer;

begin
  Result := 0;
  i := 0;

  if FileExists(FileName) = False then Exit;
  AssignFile(F, FileName);
  Reset(F);

  //for j := 1 to 3 do ReadLn(F); , j

  while not EOF(F) do
  begin
    ReadLn(F);
    i := i + 1;
  end;

  Result := i;
  CloseFile(F);
end;

//---GetSelectedDir---
function GetSelectedDir : string;
begin
  Result := GetRealPath(RipGD_Form.ePath.Text);
end;

//CorrectLine
//RABUSIER
function CorrectLine(SubStr, Str : string) : string;
var
  i : integer;
  LastCharWasSeparator : Boolean;

begin
  Result := '';
  LastCharWasSeparator := False;

  for i := 1 to Length(Str) do
  begin
    if Str[i] = SubStr then
    begin
      if not LastCharWasSeparator then
      begin
        Result := Result + Str[i];
        LastCharWasSeparator := True;
      end
    end
    else
    begin
       LastCharWasSeparator := False;
       Result := Result + Str[i];
    end;
  end;
end;

//---ConvertFileUnixToWindows---
function ConvertFileUnixToWindows(Source, Target : string) : boolean;
var
  FileName      : TStringList;
  F, T          : TextFile;
  Line, Tp, Tp2 : string;
  i             : integer;

begin
  Result := False;
  Tp  := GetTempDir + 'CORRECT1.DCT'; //Correction
  Tp2 := GetTempDir + 'CORRECT2.DCT'; //Correction 2 (avec les espaces).

  //Verification des fichiers.
  if FileExists(Source) = False then Exit;
  if FileExists(Target) = True then Exit;
  if FileExists(Tp) = True then DeleteFile(Tp);   //Peu probable, mais on c jamais
  if FileExists(Tp2) = True then DeleteFile(Tp2); //une autre appli peut creer ces fichiers.

  //On l'ouvre une première fois pour convertir le fichier Unix Vers Windows tel quel.
  FileName := TStringList.Create;
  FileName.LoadFromFile(Source); //La source.
  FileName.SaveToFile(Tp);  //Vers 'Correct.dct'.
  FileName.Free; //Voilà, c'est fait.

  //Ouvrir pour l'edition à partir de la piste 10 (faut mettre un espace devant).
  //Finalement, on en met partout, devant toutes les lignes, on corrigera après.
  //Ceci au cas ou y'aurai plusieurs session (moi je me limitait à la 2, mais si y'en à 3?)
  //Meme si c'est peu probable... je le fait quand meme.
  AssignFile(F, Tp);  //Assignation du fichier Tp (temp) = 'Correct1.dct'.
  AssignFile(T, Tp2); //assignation du fichier tp2 'correct2.dct'

  FileMode := fmOpenReadWrite;
  ReSet(F); //On ouvre en lecture Tp (correct1.dct)
  ReWrite(T); //Ouvre en ecriture TP2 (correct2.dct)

  //Placons ceci ici pour eviter les espaces inutiles.
  for i := 1 to 3 do
  begin
    ReadLn(F, Line);
    WriteLn(T, Line);
  end;

  while not EOF(F) do //jusqu'a la fin du fichier correct1.dct...
  begin
    ReadLn(F, Line);    //...on va lire...
    if NbSousChaine(SESSION_CONST, UpperCase(Line)) > 0 then //...si c'est 'session' on met pas d'espace.
      WriteLn(T, Line) //pas d'espace si 'session' dans la ligne.
    else WriteLn(T, ' ' + Line); //...puis recopier dans correct2.dct avec un espace devant la ligne lue!
  end;

  //Fermons les deux fichiers (sinon tjs en utilisation (Err I/O 32...)
  CloseFile(F);
  CloseFile(T);

  //Finalement on le 'converti' que la.
  FileName := TStringList.Create; //Recreons un StringList
  FileName.LoadFromFile(Tp2); //Chargons le fichier 'corrigé et déjà converti'
  //FileName.Text := StringReplace(FileName.Text, #10, #10+#13, [rfReplaceAll]);
  //FileName.Text := StringReplace(FileName.Text, ' ', '|', [rfReplaceAll]);
  FileName.Text := CorrectLine(' ', FileName.Text); //Corrigons les espaces
  FileName.SaveToFile(Target); //Sauvegardons le fichier final dans target
  FileName.Free; //puis detruisons le StringList.

  //Effacons les fichiers inutiles!
  if FileExists(Tp) = True then DeleteFile(Tp);   //correct1.dct
  if FileExists(Tp2) = True then DeleteFile(Tp2); //correct2.dct

  if FileExists(Target) = False then Exit;  //Si le fichier Target resultat de tout ce bordel n'existe pas, on a foiré!

  Result := True;
end;

//---GetCorrectTrackListFile---
function GetCorrectTrackListFile(OldTrackListFile : string) : string;
var
  FileName, DestFile : string;

begin
  Result := '';
  FileName := GetTempDir + TRACKLIST_FILENAME;
  DestFile := GetTempDir + TEMP_TRACKLIST;

  if FileExists(DestFile) = True then DeleteFile(DestFile); //Le fichier à convertir
  CopyFile(PChar(OldTrackListFile), PChar(DestFile), False); //copie du fichier OldTrackListFile vers le fichier DestFile
  if FileExists(FileName) = True then DeleteFile(FileName); //effacer la cible, résultant d'une vielle conversion
  ConvertFileUnixToWindows(DestFile, FileName); //Convertir le fichier TEMP_TRACKLIST (=OldTrackListFile, mais pas en ReadOnly)
  if FileExists(FileName) = True then Result := FileName; //Si le fichier TRACKLIST_FILENAME existe, c'est que c'est okay
  if FileExists(DestFile) = True then DeleteFile(DestFile); //Effacer le Destfile, il sert plus à rien.
end;

//---ReadLine---
function ReadLine(FileName : string ; LineNumber : integer) : string;
var
  F         : TextFile;
  Line      : string;
  i         : integer;

begin
  Result := '';
  if FileExists(FileName) = False then Exit;
  AssignFile(F, FileName);
  Reset(F);

  for i := 1 to LineNumber do
  begin
    ReadLn(F, Line);
    //ShowMessage('function ReadLine : ' + Line + ' - LineNumber : ' + IntToStr(i));
  end;

  Result := Line;
  CloseFile(F);
end;

//---ReadGameName---
//Permet d'avoir le nom du jeu rippé !!!
function ReadGameName(FileName : string) : string;
var
  TempFile  : string;
  
begin
  TempFile := GetCorrectTrackListFile(FileName);
  Result := ReadLine(TempFile, 1)
end;

//---GaucheNDroite---
function GaucheNDroite(substr: string; s: string;n:integer): string;
var i:integer;
begin
  S:=S+substr;
  for i:=1 to n do
  begin
    S:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
  end;
  result:=copy(s, 1, pos(substr, s)-1);
end;

//---Droite---
function Droite(substr: string; s: string): string;
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
end;

//---IsNewSession---
function IsNewSession(Line : string) : boolean;
begin
  Result := False;
  if NbSousChaine(SESSION_CONST, UpperCase(Line)) > 0 then Result := True;
end;

//---GetSessionNumber---
function GetSessionNumber(Line : string) : string;
begin
  Result := Droite(SESSION_CONST, UpperCase(Line));
end;

//---ReadTrackList---
procedure ReadTrackList(ListView : TListView ; TreeView : TTreeView);
var
  TrackList      : string;
  TrackTotal     : integer;
  i              : integer;
  CurrentLine    : string;
  Start          : boolean;
  CurrentSession : string;

//*PutNewSessionItem*
procedure PutNewSessionItem(TreeView : TTreeView);
var
  SessionID : string;

begin
  SessionID := GetSessionNumber(CurrentLine);
  CurrentNode := TreeView.Items.Add(nil, 'Session ' + SessionID);
  CurrentSession := 'Session ' + SessionID;

  //Icone
  CurrentNode.ImageIndex := 2;
  CurrentNode.SelectedIndex := 2;
end;

//*IsFirstSession*
function IsFirstSession(Line : string) : boolean;
begin
  Result := False;
  if UpperCase(Line) = 'SESSION 1' then Result := True;
end;

//*GetTrackNumber*
function GetTrackNumber(Line : string) : string;
begin
  Result := GaucheNDroite(' ', Line, 1);
end;

//*GetTrackType*
function GetTrackType(Line : string) : string;
begin
  Result := GaucheNDroite(' ', Line, 2);
  //ShowMessage('GetTrackType : ' + Result);
end;

//*GetTrackStart*
function GetTrackStart(Line : string) : string;
begin
  Result := GaucheNDroite(' ', Line, 3);
end;

//*GetTrackSize*
function GetTrackSize(Line : string) : string;
begin
  Result := GaucheNDroite(' ', Line, 4);
end;

//*GetTrackMB*
function GetTrackMB(Line : string) : string;
begin
  //ShowMessage('GetTrackMB : ' + Line);
  Result := GaucheNDroite(' ', Line, 5);
  //ShowMessage('GetTrackMB : ' + Result);
end;

//*AddElements*
procedure AddElements(ListView : TListView ; TreeView : TTreeView ; CurrentLine : string);
var
  ListItem: TListItem;
  Node    : TTreeNode;

begin
  //ShowMessage(CurrentLine);   //CurrentNode = ParentNode representant la Session.
  Node := TreeView.Items.AddChild(CurrentNode, GetTrackNumber(CurrentLine) + ' : ' +
    GetTrackType(CurrentLine)); //Ajouter dans l'arbre la nouvelle piste.

  //Pour l'icône en fonction de data ou audio.
  if GetTrackType(CurrentLine) = AUDIO_TRACK_TYPE then
  begin
    Node.ImageIndex := 1;
    Node.SelectedIndex := 1;
  end else begin
    Node.ImageIndex := 0;
    Node.SelectedIndex := 0;
  end;

  with ListView do
  begin
     ListItem := Items.Add;
     ListItem.Caption := GetTrackNumber(CurrentLine); //Session Number (1) par ex..
     ListItem.SubItems.Add(CurrentSession); //Session ID (Session 1).. par ex
     ListItem.SubItems.Add(GetTrackType(CurrentLine)); //Get Track Type (AUDIO, DATA...)
     ListItem.SubItems.Add(GetTrackStart(CurrentLine)); //Get Track Start...
     ListItem.SubItems.Add(GetTrackSize(CurrentLine)); //GetTrackSize...
     ListItem.SubItems.Add(GetTrackMB(CurrentLine)); //Get Track MB..

     //Icone ne fait pas terrible.
   {  if GetTrackType(CurrentLine) = DATA_TRACK_TYPE then
       ListItem.ImageIndex := 0
     else ListItem.ImageIndex := 1; }
  end;
end;

//**MAIN**
begin
  TrackList := GetCorrectTrackListFile(GetSelectedDir + ORIGINAL_TRACKLIST);
  TrackTotal := GetNumberLine(TrackList); //inclus aussi les infos 'session 1' et tout
  Start := False;  //si start pas à true, on a pas atteint 'Session 1'
  CurrentSession := '';
  CurrentNode := nil;
  //showmessage(inttostr(TrackTotal));

  //Démarrer
  for i := 0 to TrackTotal do
  begin
    CurrentLine := ReadLine(TrackList, i);

    if IsNewSession(CurrentLine) = True then    //session trouvée !
    begin
      if IsFirstSession(CurrentLine) = True then Start := True; //première session trouvée!
      PutNewSessionItem(TreeView); //Ajouter la nouvelle session dans l'arbre!
    end else begin
      if Start = True then //Start veut dire qu'on peut commencer à ajouter (on a trouvé 'Session 1')
        AddElements(ListView, TreeView, CurrentLine); //Remplir le TreeView et le ListView.
    end; //end of IsNewSession
    
  end;

  // Ouvrir la dernière node, vu qu'elle est finie.
  //if CurrentNode <> nil then CurrentNode.Expand(True);
  DeleteFile(GetTempDir + TRACKLIST_FILENAME); //Effacer le fichier 'converti' une fois fini.
end;

{VIRTUA TENNIS

no type   start   size    MB
session 1
 1 DATA       0    600    1M
 2 AUDIO    600   5950   13M
session 2
 3 DATA   45000 504150 1032M }

{--------------------< TOUT CELA SERT POUR LES DEUX FONCTIONS AVANT ------------ }
{ C'est à dire ReadGameName et ReadTrackList }

//Maitenant je vais tacher de faire le reste pour gerer la progression du rippage.
//Mais dans une autre unit !

end.
