unit MultiSynPageControl;

interface

uses
  SysUtils, Classes, Controls, ComCtrls, SynEdit, SynBookMarkView, Contnrs;

type
  PHistoryTabs = ^THistoryTabs;
  THistoryTabs = packed record
    Caption : string[128];
    Count   : integer;
  end;

  THistoryTabsArray = class
  private
    FHistoryTabs : TList;
  public
    constructor Create;
    destructor Destroy; override;
    function Count : integer;
    function AddNewCaption(Caption : string) : boolean;
    function SearchCaption(Caption : string) : integer;
    function GetHistoryTabCount(Caption : string) : integer;
  end;

  TSynEditError = class(Exception);
  
  TAdvancedOptions = class(TPersistent)
  private
    FInitWithOneTab: boolean;
    FLookAtEmptySyns: boolean;
    FFirstTabName: string;
  public
    constructor Create;
  published
    property InitWithOneTab : boolean read FInitWithOneTab write FInitWithOneTab
      default False;
    property FirstTabName : string read FFirstTabName write FFirstTabName;
    property LookAtEmptySyns : boolean read FLookAtEmptySyns write FLookAtEmptySyns
      default False; 
  end;

  TMultiSynPageControl = class(TPageControl)
  private
    FHistoryCaption : THistoryTabsArray;
    FLastCompNumber : integer;
    FSynList : TObjectList;
    FSourceSynEdit: TSynEdit;
    FSynBookMarkView: TSynBookMarkView;
    FAdvancedOptions: TAdvancedOptions;
    FOnChange: TNotifyEvent;
    FOnClosePage: TNotifyEvent;
    FOnAddPage: TNotifyEvent;
    function GetSynEditName : string;
    function GetTabSheetName : string;
    procedure SelfChange(Sender : TObject);
    procedure SetSourceSynEdit(const Value: TSynEdit);
    procedure SetSynBookMarkView(const Value: TSynBookMarkView);
    { Déclarations privées }
  protected
    { Déclarations protégées }
    procedure Loaded; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function AddNewPage(TabCaption : string) : boolean;
    function ClosePage(Index: integer) : boolean;
    function GetCurrentSynEdit : TSynEdit;
    function GetLastSynEdit : TSynEdit;
    function GetSynEdit(Index : integer) : TSynEdit;
    function GetSynEditIndex(SynEdit : TSynEdit) : integer;
    procedure UpdateSynEdits;
    function SynCount : integer;
    function GetTabSheet(Index : integer) : TTabSheet;
    function AssignBookMarkView(ToSynEditIndex : integer) : boolean;
    function GetSynIndex(Caption : string ; ExactString : boolean = True) : integer;
    function GetSynListCaptions(var SL : TStringList) : boolean;
    function IsAlreadyExists(Caption : string) : boolean;
    function GetCaptionsCount(Caption : string) : integer;
    procedure CloseAllTabs;
    procedure CloseUselessTabs;
    function GetCurrentCaption : string;
  published
    { Déclarations publiées }
    property SourceSynEdit : TSynEdit read FSourceSynEdit write SetSourceSynEdit;
    property SynBookMarkView : TSynBookMarkView read FSynBookMarkView write SetSynBookMarkView;

    property AdvancedOptions : TAdvancedOptions read FAdvancedOptions write FAdvancedOptions;

    //Evenements
    property OnChange : TNotifyEvent read FOnChange write FOnChange;

    property OnAddPage : TNotifyEvent read FOnAddPage write FOnAddPage;
    property OnClosePage : TNotifyEvent read FOnClosePage write FOnClosePage;
  end;

procedure Register;

implementation

uses
  WINDOWS;

//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('DC-TOOL GUI', [TMultiSynPageControl]);
end;

//------------------------------------------------------------------------------

function Droite(substr: string; s: string): string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

function NbSousChaine(substr: string; s: string): integer;
begin
  result:=0;
  substr := UpperCase(substr);
  s := UpperCase(s);
  
  while pos(substr, s) <> 0 do
  begin
    S:=droite(substr, s);
    inc(result);
  end;
end;

//------------------------------------------------------------------------------

{ TMultiSynPageControl }

function TMultiSynPageControl.AddNewPage(TabCaption : string) : boolean;
var
  Fiche       : TTabSheet;
  SE          : TSynEdit;
  SynName     : string;
  ExecNumber  : integer;

begin
  Result := True;

  //Non assigné on s'en va.
  if not Assigned(FSourceSynEdit) then
  begin
    raise TSynEditError.Create('Please assign a TSynEdit before using this method.');
    Exit;
  end;

  //Récuperer le nom du nouvel SynEdit qui va être créé.
  SynName := GetSynEditName;

  //Ajouter un numéro si c'est pas la première execution.
  ExecNumber := GetCaptionsCount(TabCaption);
  if ExecNumber > 0 then  //pour le premier on met pas de numéro...
    TabCaption := TabCaption + ' [' + IntToStr(ExecNumber + 1) + ']';

  //Créer la fiche (le TabSheet)
  Fiche := TTabSheet.Create(Self.Parent); //ICI!!!! CE BUG D'ENCULE EST RESOLU
  try
    Fiche.PageControl := Self; //on va assigner la fiche à notre PageControl
    Fiche.Visible := True;
    Fiche.Name := GetTabSheetName; //Nous allons récuperer le nom du nouveau TabSheet
    Fiche.Caption := TabCaption; //variable en parametre
    Fiche.Parent := Self; //le parent sera le PageControl...

    //Création du SynEdit
    SE := TSynEdit.Create(Fiche);
    try
      SE.Left := 0;
      SE.Top := 0;
      SE.Height := Fiche.Height;
      SE.Width := Fiche.Width; //previent un bug d'affichage (minime) de SE.Align = alClient

      SE.Align := alClient;
      SE.Name := SynName; //affectation du nom au nouveau SynEdit
      SE.Text := ''; //enlever les lignes (car le SynEdit affichera son nom).
      SE.Parent := Fiche; //le parent, c'est le TabSheet
      //Fiche.Caption := SE.Name;

      //Ajouter le nouveau SynEdit dans la liste.
      FSynList.Add(SE);
      FLastCompNumber := FLastCompNumber + 1; //incrementation du nb de TabSheets

      //Sélectionner la dernière page du TPageControl
      ActivePageIndex := PageCount - 1;

      //Assigner et activer le bookmark
      if Assigned(FSynBookMarkView) then
        AssignBookMarkView(ActivePageIndex);

      //UPDATE!!!
      UpdateSynEdits;

      //VISIBLE
      //SE.DoubleBuffered := True;

      //SE.Align := alClient;
      SE.Visible := True;

      //Ajouter la caption dans le tableau, permettant de compter le nombre de fois
      //qu'apparait cette caption.
      FHistoryCaption.AddNewCaption(TabCaption);

      //evenements
      if Assigned(FOnAddPage) then
        FOnAddPage(Self);

      Sleep(100);

      SE.Update;
    except
      Result := False;
    end;

  except
    Result := False;
  end;

end;

function TMultiSynPageControl.AssignBookMarkView(
  ToSynEditIndex: integer): boolean;
var
  SE : TSynEdit;

begin
  Result := False;
  if not Assigned(FSynBookMarkView) then Exit;

  SE := GetSynEdit(ToSynEditIndex);

  if not Assigned(SE) then
  begin
    FSynBookMarkView.Enabled := False;
    FSynBookMarkView.Active := False;
    FSynBookMarkView.SynEdit := nil;
    FSynBookMarkView.ClearItems;
    Exit;
  end;

  FSynBookMarkView.Enabled := True;
  FSynBookMarkView.SynEdit := SE;
  FSynBookMarkView.Active := True;
  Result := FSynBookMarkView.UpdateBookMarks;
end;

function TMultiSynPageControl.ClosePage(Index: integer) : boolean;
var
  SE : TSynEdit;
  TS : TTabSheet;

begin
  Result := False;
  if (Index < 0) or (Index >= FSynList.Count) then Exit;
  SE := (FSynList.Items[Index] as TSynEdit);
  if not Assigned(SE) then Exit;

  TS := SE.Parent as TTabSheet;

  FSynList.Delete(Index);
  TS.Free;

  //sélection page
  if (PageCount > 1) and (Index = PageCount) then
    ActivePageIndex := Index - 1;
  
  //Update bookmarks
  AssignBookMarkView(ActivePageIndex);

  //evenement
  if Assigned(FOnClosePage) then
    FOnClosePage(Self);
end;

constructor TMultiSynPageControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
  FSourceSynEdit := nil;
  FSynBookMarkView := nil;
  FSynList := TObjectList.Create;
  FAdvancedOptions := TAdvancedOptions.Create;
  FLastCompNumber := 0;

  FHistoryCaption := THistoryTabsArray.Create; //Tableau qui contiendra l'historique des captions

  inherited OnChange := SelfChange;
end;

destructor TMultiSynPageControl.Destroy;
begin
  if Assigned(FSynList) then FreeAndNil(FSynList);
  if Assigned(FAdvancedOptions) then FreeAndNil(FAdvancedOptions);

  FHistoryCaption.Free; //Détruire le tableau qui contient l'historique des captions

  inherited Destroy;
end;

function TMultiSynPageControl.GetCaptionsCount(Caption: string): integer;
begin
  Result := FHistoryCaption.GetHistoryTabCount(Caption);

  //Bah oui, parce que les captions comportent aussi le numéro maintenant !
  //donc un test basic = n'est plus possible. En effet
  //"asserthnd.elf" <> "asserthnd.elf [1]" !

  //Nouveau problème : si le mec ferme une caption le calcul est foireux.
  //comblé avec THistoryTabsArray qui retiens vraiment le nombre de fois
  //que le caption a apparu.
end;

function TMultiSynPageControl.GetCurrentSynEdit: TSynEdit;
begin
  Result := GetSynEdit(ActivePageIndex);
end;

function TMultiSynPageControl.GetLastSynEdit: TSynEdit;
var
  i, index : integer;

begin
  if FAdvancedOptions.FLookAtEmptySyns then
  begin
    index := -1;

    for i := 0 to FSynList.Count - 1 do
      if Length(GetSynEdit(i).Lines.GetText) = 0 then
      begin
        index := i;
        Break;
      end;

    if index = -1 then
      Result := GetSynEdit(Tabs.Count - 1)
    else Result := GetSynEdit(Index);

    Exit;
  end;

  Result := GetSynEdit(Tabs.Count - 1);
end;

function TMultiSynPageControl.GetSynEdit(Index: integer): TSynEdit;
begin
  Result := nil;
  if not Assigned(FSynList) then Exit;
  
  if (Index < 0) or (Index >= FSynList.Count) then Exit;
  Result := (FSynList.Items[Index] as TSynEdit);
end;

function TMultiSynPageControl.GetSynEditName: string;
begin
  //Ce nom trop standard ('SynEdit') peut causer des problèmes.
  Result := 'IEditorSynEdit' + IntToStr(FLastCompNumber);
end;

function TMultiSynPageControl.GetSynIndex(Caption: string ; ExactString : boolean = True): integer;
var
  SE  : TSynEdit;
  i   : integer;
  str : string;

begin
  Result := -1;

  for i := 0 to FSynList.Count - 1 do
  begin
    SE := GetSynEdit(i);

    str := (SE.Parent as TTabSheet).Caption;

    if ExactString then
    begin
      //Recherche exacte
      if UpperCase(str) = UpperCase(Caption) then
      begin
        Result := i;
        Break;
      end;

    end else begin

      //Recherche en enlevant les numéros et tout le merdier (NbSousChaine)
      if NbSousChaine(Caption, str) > 0 then //la chaine existe
      begin
        Result := i;
        Break;
      end;

    end;

  end;
end;

function TMultiSynPageControl.GetSynListCaptions(var SL: TStringList): boolean;
var
  i   : integer;
  SE  : TSynEdit;

begin
  Result := False;
  if not Assigned(SL) then Exit;

  for i := 0 to FSynList.Count - 1 do
  begin
    SE := GetSynEdit(i);
    if not Assigned(SE) then Continue;  //nouveau truc que j'ai appris qui passe
                                        //à l'iteration suivante

    SL.Add((SE.Parent as TTabSheet).Caption);
  end;

  Result := True;
end;

function TMultiSynPageControl.GetTabSheet(Index: integer): TTabSheet;
var
  SE : TSynEdit;
  
begin
  Result := nil;

  SE := GetSynEdit(Index);
  if Assigned(SE) then
    Result := (SE.Parent as TTabSheet);
end;

function TMultiSynPageControl.GetTabSheetName : string;
begin
  //Ce nom trop standard ('TabSheet') peut être une source de problèmes.
  Result := 'IEditorTabSheet' + IntToStr(FLastCompNumber);
//  showmessage(result);
end;

function TMultiSynPageControl.IsAlreadyExists(Caption: string): boolean;
begin
  if GetSynIndex(Caption) = -1 then
    Result := False
  else Result := True;
end;

procedure TMultiSynPageControl.Loaded;
begin
  inherited Loaded;

  if FAdvancedOptions.FInitWithOneTab then
    AddNewPage(FAdvancedOptions.FFirstTabName);
end;

procedure TMultiSynPageControl.SelfChange(Sender: TObject);
var
  SE : TSynEdit;

begin
  SE := GetSynEdit(ActivePageIndex);
  if Assigned(SE) then
    AssignBookMarkView(ActivePageIndex);

  if Assigned(FOnChange) then
    FOnChange(Sender);
end;

function TMultiSynPageControl.SynCount: integer;
begin
  Result := FSynList.Count;
end;

procedure TMultiSynPageControl.UpdateSynEdits;
var
  i   : integer;
  SE  : TSynEdit;
  
begin
  if not Assigned(FSourceSynEdit) then
  begin
    raise TSynEditError.Create('Please assign a TSynEdit before using this method.');
    Exit;
  end;

  for i := 0 to FSynList.Count - 1 do
  begin
    SE := (FSynList.Items[i] as TSynEdit);

    SE.Color := FSourceSynEdit.Color;
    SE.ActiveLineColor := FSourceSynEdit.ActiveLineColor;
    SE.Enabled := FSourceSynEdit.Enabled;
    SE.PopupMenu := FSourceSynEdit.PopupMenu;
    SE.Highlighter := FSourceSynEdit.Highlighter;
    SE.ReadOnly := FSourceSynEdit.ReadOnly;
    SE.SearchEngine := FSourceSynEdit.SearchEngine;
    SE.Options := FSourceSynEdit.Options;
    //SE.SelectedColor.Background := FSourceSynEdit.SelectedColor.Background;
    //SE.SelectedColor.Foreground := FSourceSynEdit.SelectedColor.Foreground;
    //SE.Gutter := FSourceSynEdit.Gutter;
    //SE.Font := FSourceSynEdit.Font;
    SE.Gutter.Assign(FSourceSynEdit.Gutter);
    //SE.Gutter.Visible := FSourceSynEdit.Gutter.Visible;
    SE.SelectedColor.Assign(FSourceSynEdit.SelectedColor);
    SE.RightEdge := FSourceSynEdit.RightEdge;
    SE.RightEdgeColor := FSourceSynEdit.RightEdgeColor;
    SE.Font.Assign(FSourceSynEdit.Font);
  end;
end;

procedure TMultiSynPageControl.SetSourceSynEdit(const Value: TSynEdit);
begin
  FSourceSynEdit := Value;
end;

procedure TMultiSynPageControl.SetSynBookMarkView(
  const Value: TSynBookMarkView);
begin
  FSynBookMarkView := Value;
end;

procedure TMultiSynPageControl.CloseAllTabs;
var
  i : integer;
  
begin
  //faut partir de la fin parce que le SynCount change à chaque fois.
  for i := SynCount - 1 downto 0 do
    ClosePage(i);
end;

//Ferme toutes les tabs sauf le dernier (celui en cours, quoi).
//A NE PAS CONFONDRE AVEC GetCurrentSyn, qui contient le SynEdit
//SELECTIONNE PAR L'UTILISATEUR.
procedure TMultiSynPageControl.CloseUselessTabs;
var
  i : integer;
  
begin 
  for i := SynCount - 1 downto 0 do
    if GetSynEdit(i) <> GetLastSynEdit then ClosePage(i);
end;

function TMultiSynPageControl.GetSynEditIndex(SynEdit: TSynEdit): integer;
var
  i : integer;

begin
  Result := -1;
  
  for i := 0 to SynCount - 1 do
    if GetSynEdit(i) = SynEdit then
    begin
      Result := i;
      Break;
    end;
end;

function TMultiSynPageControl.GetCurrentCaption: string;
var
  SE : TSynEdit;

begin
  Result := '';
  SE := GetCurrentSynEdit;
  if not Assigned(SE) then Exit;
  Result := (SE.Parent as TTabSheet).Caption;
end;

{ TAdvancedOptions }

constructor TAdvancedOptions.Create;
begin
  FInitWithOneTab := False;
  FLookAtEmptySyns := False;
end;

{ THistoryTabsArray }

function THistoryTabsArray.AddNewCaption(Caption: string): boolean;
var
  Item  : PHistoryTabs;
  Index : integer;

begin
  Result := True;
  Index := SearchCaption(Caption);

  try

    if Index = -1 then
    begin
      //On crée le nouveau item.
      Item := New(PHistoryTabs);
      Item^.Caption := Caption;
      Item^.Count := 1;
      FHistoryTabs.Add(Item);
    end else begin
      //L'item est déjà dans le tableau alors on va ajouter +1
      Inc(PHistoryTabs(FHistoryTabs[Index])^.Count);
    end;

  except
    Result := False;
  end;
end;

function THistoryTabsArray.Count: integer;
begin
  Result := FHistoryTabs.Count;
end;

constructor THistoryTabsArray.Create;
begin
  FHistoryTabs := TList.Create;
end;

destructor THistoryTabsArray.Destroy;
var
   i : integer;
   Item : PHistoryTabs;

begin
  //Détruire les structures pointées par le tableau.
  for i := 0 to FHistoryTabs.Count - 1 do
  begin
    Item := PHistoryTabs(FHistoryTabs[i]);
    Dispose(Item);
  end;

  //Détruire le tableau lui même.
  FHistoryTabs.Free;
  inherited Destroy;
end;

function THistoryTabsArray.GetHistoryTabCount(Caption: string): integer;
var
  i : integer;

begin
  Result := 0;

  i := SearchCaption(Caption);
  if i = -1 then Exit;

  Result := PHistoryTabs(FHistoryTabs[i]).Count;
end;

function THistoryTabsArray.SearchCaption(Caption: string): integer;
var
  i       : integer;
  CurrTab : string;

begin
  Result := -1;

  for i := 0 to FHistoryTabs.Count - 1 do
  begin
    CurrTab := PHistoryTabs(FHistoryTabs[i]).Caption;

    //Explication : C'est CurrTab qui a des caractères en trop (du genre
    //"asserthnd.elf [2]"). Caption est toujours clean (vu c'est ce qu'on cherche,
    //on le rentre nous même).
    if NbSousChaine(CurrTab, Caption) > 0 then   //et oui, il y'est :)
    begin
      Result := i;
      Break;
    end;
  end;
  
end;

end.
