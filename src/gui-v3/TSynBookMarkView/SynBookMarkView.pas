unit SynBookMarkView;

interface

uses
  SysUtils, Classes, Controls, ComCtrls, SynEdit;

const
  MAX_SYN_BOOK_MARKS  : integer = 10;
  VERSION             : string  = '1.0';

type
  TSynEditError = class(Exception);

  TItemChangeEvent = procedure(Sender: TObject; Item: TListItem;
    Change: TItemChange) of object;

  TSynBookState = array[0..9] of boolean;

  TSynBookMarkView = class(TListView)
  private
    FSynBookState : TSynBookState;
    
    FSynEdit: TSynEdit;
    FUseOnlyOneImage: boolean;
    FOnChange: TItemChangeEvent;
    FActive: boolean;
    FOnDblClick: TNotifyEvent;
    FAddCaptions: boolean;
    procedure SetSynEdit(const Value: TSynEdit);

    procedure AddColumn(NewCaption : string ; NewWidth : integer);
    procedure AddNewItem(NewCaption : string);
    procedure InitListView;
    procedure SelfChange(Sender: TObject ; Item : TListItem
              ; Change : TItemChange);  //va remplacer OnChange original.
    procedure SelfDblClick(Sender: TObject);


    { Déclarations privées }
  protected
    { Déclarations protégées }
    procedure Loaded; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent); override;

    function GotoBookMark(Index : integer) : boolean;
    function GotoSelected : boolean;
    function ChangeBookMark(Index : integer ; State : boolean) : boolean;
    function ChangeSelected(State : boolean) : boolean;
    function UpdateBookMarks : boolean;
    function GetVersion : string;
    procedure ClearItems;
  published
    { Déclarations publiées }
    property SynEdit : TSynEdit read FSynEdit write SetSynEdit;
    property UseOnlyOneImage : boolean read FUseOnlyOneImage write FUseOnlyOneImage
      default False;
    property Active : boolean read FActive write FActive;
    property AddCaptions : boolean read FAddCaptions write FAddCaptions
      default True;

    //Evènements
    property OnChange : TItemChangeEvent read FOnChange write FOnChange; //on va surcharger cet évènement
    property OnDblClick : TNotifyEvent read FOnDblClick write FOnDblClick;
  end;

procedure Register;

implementation

USES DIALOGS;

procedure Register;
begin
  RegisterComponents('DC-TOOL GUI', [TSynBookMarkView]);
end;

{ TSynBookMarkView }

procedure TSynBookMarkView.AddColumn(NewCaption: string; NewWidth: integer);
var
  Item : TListColumn;

begin
  Item := Columns.Add;
  Item.Caption := NewCaption;
  Item.Width := NewWidth;
end;

procedure TSynBookMarkView.AddNewItem(NewCaption : string);
var
  Item : TListItem;

begin
  Item := Items.Add;

  if not FAddCaptions then NewCaption := ''; //virer la caption si le mec veut pas.

  Item.Caption := NewCaption;
  Item.SubItems.Add('');

  //Image.
  if Assigned(SmallImages) then
  begin
    if FUseOnlyOneImage then
    begin

      if SmallImages.Count > 0 then
        Item.ImageIndex := 0 //une seule image

    end else begin

      if Items.Count < SmallImages.Count then
        Item.ImageIndex := Items.Count - 1;

    end;
  end;

end;

function TSynBookMarkView.ChangeBookMark(Index: integer; State: boolean) : boolean;
var
  Item : TListItem;
  
begin
  Result := False;
  if not FActive then Exit;

  //Assigned...
  if FActive and (not Assigned(FSynEdit)) then
  begin
    raise TSynEditError.Create('You must assign a SynEdit before activating this'
      + ' component.');
    Exit;
  end;

  if (Index < 0) or (Index >= Items.Count) then Exit; //c'est impossible...

  if Assigned(Items[Index]) then
    Item := Items[Index] //ok on a notre item
  else Exit; //sinon on sort...

  Item.Checked := State;
end;

function TSynBookMarkView.ChangeSelected(State: boolean): boolean;
begin
  Result := False;

  if Assigned(Selected) then
    Result := ChangeBookMark(Selected.Index, State);  
end;

procedure TSynBookMarkView.ClearItems;
var
  i : integer;
  
begin
  for i := 0 to MAX_SYN_BOOK_MARKS - 1 do
  begin
    Items[i].SubItems[0] := '';
    Items[i].Checked := False;
    FSynBookState[i] := False;
  end;
end;

constructor TSynBookMarkView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FOnChange := nil;
  FOnDblClick := nil;

  FAddCaptions := True;
  FActive := False;
  FUseOnlyOneImage := False;

  inherited OnChange := SelfChange; //Surcharge de l'évènement OnChange.
  inherited OnDblClick := SelfDblClick;

  InitListView;
end;

function TSynBookMarkView.GetVersion: string;
begin
  Result := VERSION;
end;

function TSynBookMarkView.GotoBookMark(Index : integer) : boolean;
var
  Item : TListItem;
  
begin
  Result := False;
  if not FActive then Exit;

  //Assigned...
  if FActive and (not Assigned(FSynEdit)) then
  begin
    raise TSynEditError.Create('You must assign a SynEdit before activating this'
      + ' component.');
    Exit;
  end;

  if (Index < 0) or (Index >= Items.Count) then Exit; //c'est impossible...

  if Assigned(Items[Index]) then
    Item := Items[Index] //ok on a notre item
  else Exit; //sinon on sort...

  if Item.Checked and FSynBookState[Index] then
  begin
    FSynEdit.GotoBookMark(Index);
    Result := True;
  end;
  
end;

function TSynBookMarkView.GotoSelected: boolean;
begin
  Result := False;

  if Assigned(Selected) then
    Result := GotoBookMark(Selected.Index);
end;

procedure TSynBookMarkView.InitListView;
var
  i : integer;

begin
  ReadOnly := True;

  //Pour les colonnes
  AddColumn('#', 50);
  //Column[0].AutoSize := True;
  AddColumn('Location', 70);
  Column[1].AutoSize := True; //pour que la colonne location prenne toute la place
  ViewStyle := vsReport;

  //Pour les éléments.
  Checkboxes := True;
  GridLines := True;
  RowSelect := True;
  ColumnClick := False;

  //Pour le tableau de boolean représentant l'état des bookmarks.
  for i := 0 to High(FSynBookState) do
    FSynBookState[i] := False;
end;

procedure TSynBookMarkView.Loaded;
var
  i : integer;
  
begin
  inherited;

  Items.Clear;  //ne marche pas en design time.

  if Items.Count = 0 then //pour éviter un bug qui remplit plusieurs fois la ListView.
    for i := 0 to MAX_SYN_BOOK_MARKS - 1 do
      AddNewItem('#' + IntToStr(i));
end;

procedure TSynBookMarkView.SelfChange(Sender: TObject ; Item : TListItem ; Change : TItemChange);
var
  Ind : integer;

begin
  if FActive and Assigned(Item) then
  begin

    Ind := Item.Index;

    //Vérification du composant SynEdit...
    if not Assigned(FSynEdit) then
    begin
      raise TSynEditError.Create('You must assign a SynEdit before activating this'
        + ' component.');
      Exit;
    end;

    //OK on continue... Assigned & Active
    if Item.Checked and (not FSynBookState[Ind]) then
      begin
        //La case à cocher est checked, et dans le tableau c'est à false...
        FSynEdit.SetBookMark(Ind, FSynEdit.CaretX, FSynEdit.CaretY);
        FSynBookState[Ind] := True;

        Item.SubItems[0] := 'X : ' + IntToStr(FSynEdit.CaretX) + ' ; Y : '
          + IntToStr(FSynEdit.CaretY);
      end

    else

      if not Item.Checked and (FSynBookState[Ind]) then
      begin
        //La case à cocher est unckecked, et dans le tableau c'est coché...
        FSynEdit.ClearBookMark(Ind);
        FSynBookState[Ind] := False;

        Item.SubItems[0] := '';
      end;
        
  end;


  //On active le vrai évènement OnChange.
  if Assigned(FOnChange) then
    FOnChange(Self, Item, Change); //Si l'utilisateur du composant a rajouté un
                                   //événement OnChange, on le déclenche
end;

procedure TSynBookMarkView.SelfDblClick(Sender: TObject);
var
  Ind : integer;

begin
  //ShowMessage('OnDblClick modifié');

  //Assigné...
  if Assigned(Selected) then
  begin

    //Vérification du composant SynEdit...
    if FActive and (not Assigned(FSynEdit)) then
      begin
        raise TSynEditError.Create('You must assign a SynEdit before activating this'
          + ' component.');
        Exit;
      end

    else

      if FActive and Assigned(FSynEdit) then
      begin
        //---OK---
        Ind := Selected.Index;

        if Selected.Checked and FSynBookState[Ind] then
          FSynEdit.GotoBookMark(Ind);
      end;

  end;
  
  //Evènement original.
  if Assigned(FOnDblClick) then FOnDblClick(Self);
end;

procedure TSynBookMarkView.SetSynEdit(const Value: TSynEdit);
begin
  FSynEdit := Value;
end;

function TSynBookMarkView.UpdateBookMarks: boolean;
var
  i, X, Y : integer;

begin
  Result := False;
  if not FActive then Exit;

  for i := 0 to MAX_SYN_BOOK_MARKS - 1 do
  begin

    if FSynEdit.IsBookmark(i) then
    begin
      FSynEdit.GetBookMark(i, X, Y);
      FSynBookState[i] := True;
      Self.Items[i].SubItems[0] := 'X : ' + IntToStr(X) + ' ; Y : ' + IntToStr(Y);
      Self.Items[i].Checked := True;
    end else begin
      FSynBookState[i] := False;
      Self.Items[i].SubItems[0] := '';
      Self.Items[i].Checked := False;
    end;

  end;

  Result := True;
  Refresh;
end;

end.
