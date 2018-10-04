{
    :: H I S T O R Y  M A N A G E R ::
             - DEFINITION -
            For DC-TOOL GUI 3

    Unité définissant la classe définie dans u_history.pas.

    Author  : SiZiOUS
    Version : 3.0
    Date    : 09-06-05 /  17h34

    Notes   : Programmation de la classe THistoryManager.
              Permet d'implementer la gestion d'historiques pour une combobox
              ou tout objet liste.
}

unit u_history;

interface

uses
  Windows, SysUtils, Classes;

type
  THistoryError = class(Exception);
  THistoryType  = (htFiles, htDirs); //l'historique va comporter quoi ? des fichiers ou des dossiers?

  THistoryManager = class
  private
    FHistoryType  : THistoryType;
    FFileName     : string;
    FHistory      : TStringList;
  public
    constructor Create(const FileName : TFileName ; HistoryType : THistoryType);
    destructor Destroy; override;

    function SearchInHistory(const FileName : TFileName) : integer;
    procedure Clear;
    procedure CleanInvalidEntries;
    procedure AddEntry(const FileName : TFileName);
    procedure DeleteEntry(const FileName : TFileName);
    function GetItem(Index : integer) : string;
    function Count : integer;
    function GetCompleteList : TStringList;
    procedure LoadHistory;
    procedure SaveHistory;
    function Name : string;
    function AppendHistory(const FileName : TFileName) : integer;
  end;

implementation

uses
  Utils;

{ THistoryManager }

//------------------------------------------------------------------------------

//---Create---
//Constructeur de la classe THistoryManager.
//Charge le fichier passé en paramètre si il existe.
constructor THistoryManager.Create(const FileName : TFileName
  ; HistoryType : THistoryType);
begin

  FHistory := TStringList.Create;
  try

    //Vérification du dossier du fichier indiqué.
    if not DirectoryExists(ExtractFilePath(FileName)) then
      ForceDirectories(ExtractFilePath(FileName));

    FFileName := FileName;

    FHistoryType := HistoryType;
    
    //On va vérifier si le fichier existe. Si oui, on charge le fichier.
    if FileExists(FileName) then
      LoadHistory;

  except
    raise THistoryError.Create('Error in THistoryManager.Create().');
  end;
end;

//---Destroy---
//Destructeur de la classe THistoryManager.
//Sauvegarde de l'historique bien sur avant tout destruction.
destructor THistoryManager.Destroy;
begin
  //Sauvegarde avant destruction...
  SaveHistory;
  
  if Assigned(FHistory) then FHistory.Free;
  
  inherited;
end;

//------------------------------------------------------------------------------

//---AddEntry---
//Ajouter une entrée si elle n'existe pas déjà.
procedure THistoryManager.AddEntry(const FileName: TFileName);
begin
  if FileName = '' then Exit;
  
  if SearchInHistory(FileName) = -1 then
    FHistory.Add(FileName);
end;

//---DeleteEntry---
//Effacer une entrée si elle existe.
procedure THistoryManager.DeleteEntry(const FileName: TFileName);
var
  i : integer;

begin
  if FileName = '' then Exit;
  
  i := SearchInHistory(FileName);
  if i <> -1 then
    FHistory.Delete(i);
end;

//---GetCompleteList---
//Cette fonction renvoie tout le contenu de l'historique.
//Attention elle crée une TStringList, à freeyer après utilisation.
function THistoryManager.GetCompleteList: TStringList;
var
  i   : integer;
  CS  : TStringList;

begin
  CS := TStringList.Create;
  try

    for i := 0 to FHistory.Count - 1 do
      CS.Add(FHistory.Strings[i]);

    Result := CS;

  except
    raise THistoryError.Create('Error in THistoryManager.GetCompleteList().');
  end;
end;

//---Count---
//Renvoie le nombre d'élèments présent dans l'historique.
function THistoryManager.Count: integer;
begin
  Result := FHistory.Count;
end;

//---GetItem---
//Avoir un seul élèment de la liste.
function THistoryManager.GetItem(Index: integer): string;
begin
  if (Index < 0) or (Index >= FHistory.Count) then
  begin
    raise THistoryError.Create('Error in THistoryManager.GetItem(Index: integer).');
    Exit;
  end;

  Result := FHistory.Strings[Index];
end;

//---SearchInHistory---
//Fonction permettant de rechercher dans la liste la position du fichier passé
//en paramètre.
function THistoryManager.SearchInHistory(const FileName: TFileName): integer;
var
  i, Index  : integer;
  OK        : boolean;

begin
  Index := -1;
  OK := False;
  
  for i := 0 to FHistory.Count - 1 do
    if UpperCase(FHistory.Strings[i]) = UpperCase(FileName) then
    begin
      //trouvé on a son indice dans Index.
      Index := i;
      OK := True;
      break;
    end;

  //Pas trouvé.
  if not OK then
    Result := -1
  else Result := Index;
end;

//---LoadHistory---
//Charger l'historique en mémoire, avec le nom du fichier passé au constructor.
procedure THistoryManager.LoadHistory;
begin
  if FileExists(FFileName) then
    FHistory.LoadFromFile(FFileName);
end;

//---SaveHistory---
//Sauver l'historique en mémoire, avec le nom du fichier passé au constructor.
procedure THistoryManager.SaveHistory;
begin
  FHistory.SaveToFile(FFileName);
end;

//---CleanInvalidEntries---
//Permet d'effacer tous les fichiers invalides présent dans l'historiques,
//qui n'existent plus quoi.
procedure THistoryManager.CleanInvalidEntries;
var
  i : integer;

begin
  //on part du bas car quand on delete les indexs changent ! si on traite
  //a partir du bas, pas de problèmes, comme on a déjà traité l'index en dessous...

  if FHistoryType = htFiles then
  begin

    for i := FHistory.Count - 1 downto 0 do
      if not FileExists(FHistory.Strings[i]) then       //fichiers !
        FHistory.Delete(i);

  end else begin

    for i := FHistory.Count - 1 downto 0 do
      if not DirectoryExists(FHistory.Strings[i]) then //dossier ! (htDirs)
        FHistory.Delete(i);

  end;

end;

//---Clear---
//Effacer l'historique.
procedure THistoryManager.Clear;
begin
  FHistory.Clear;  
end;

//---Name---
//Renvoie le nom de l'historique, en fait c'est le nom du fichier.
//Si vous passez "C:\CONFIG\SALUT.INI", cette fonction renvoie "SALUT".
function THistoryManager.Name: string;
begin
  Result := ChangeFileExt(ExtractFileName(FFileName), '');
end;

function THistoryManager.AppendHistory(const FileName: TFileName): integer;
var
  SL  : TStringList;
  i   : integer;

begin
  Result := 0;
  SL := TStringList.Create;
  try
    SL.LoadFromFile(FileName);
    
    for i := 0 to SL.Count - 1 do
    begin
      if SearchInHistory(SL[i]) = -1 then //nouveau !
      begin
        AddEntry(SL[i]);
        Result := Result + 1;               //incrémenter.
      end;
    end;
    
  finally
    SL.Free;
  end;
end;

end.
