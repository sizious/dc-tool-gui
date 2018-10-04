unit history;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, ImgList, XPMenu;

type
  THistory_Form = class(TForm)
    gbHistory: TGroupBox;
    lbHistory: TListBox;
    bDelete: TBitBtn;
    bDeleteAll: TBitBtn;
    bClose: TBitBtn;
    bClear: TBitBtn;
    PopupMenu: TPopupMenu;
    Delete1: TMenuItem;
    Deleteall1: TMenuItem;
    Clean1: TMenuItem;
    ImageList: TImageList;
    XPMenu: TXPMenu;
    N1: TMenuItem;
    procedure bDeleteAllClick(Sender: TObject);
    procedure bDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure bClearClick(Sender: TObject);
    procedure lbHistoryContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  History_Form: THistory_Form;

implementation

uses tools, utils, u_hist, upload, download;

{$R *.dfm}

//---ChercheExact_ListBox---
function ChercheExact_ListBox(Chaine : string ; ListBox : TListBox) : integer;
var
  Index : integer;
  CurrentItem : string;
  
begin
  Result := -1;
  Chaine := UpperCase(Chaine);

  for Index := 0 to ListBox.Items.Count - 1 do
  begin
    CurrentItem := UpperCase(ListBox.Items.Strings[Index]);
    //AddError(IntToStr(Index)  + ' WinText : ' + Chaine + ' Nb Sous Chaine : ' + IntToStr(NbSousChaine(Chaine, CurrentItem)));
    //AddError(Chaine + ' - ' + CurrentItem);
    if CurrentItem = Chaine then
    begin
      Result := Index;
      Exit;
    end;
  end;
end;

procedure THistory_Form.bDeleteAllClick(Sender: TObject);
var
  CanContinue : integer;

begin
  CanContinue := MsgBox(Handle, DoYouWantToDeleteAll, WarningCaption, MB_YESNO + 48 + MB_DEFBUTTON2);
  if CanContinue = IDNO then Exit;

  lbHistory.Clear; 
end;

procedure THistory_Form.bDeleteClick(Sender: TObject);
begin
  if (lbHistory.ItemIndex = -1) or (lbHistory.ItemIndex >= lbHistory.Count)
    or (lbHistory.Count = 0) then
    begin
      MsgBox(Handle, PleaseSelectAnItemBefore, WarningCaption, 48);
      Exit;
    end;

  lbHistory.DeleteSelected;
end;

procedure THistory_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveHistoryFile;
  LoadIntoComboBoxes;
end;

procedure THistory_Form.FormShow(Sender: TObject);
begin
  LoadHistoryFile;
end;

procedure THistory_Form.bClearClick(Sender: TObject);
var
  CanContinue, i, Index, Max : integer;
  StringList : TStringList;

begin
  CanContinue := MsgBox(Handle, DoYouWantToCleanInvalidFilenames, WarningCaption, MB_YESNO + 48 + MB_DEFBUTTON2);
  if CanContinue = IDNO then Exit;

  StringList := TStringList.Create;
  try
    Max := History_Form.lbHistory.Items.Count - 1;

    //Ajouter les fichiers introuvables
    for i := 0 to Max do
    begin
      if FileExists(lbHistory.Items.Strings[i]) = False then
        StringList.Add(lbHistory.Items.Strings[i])
      else StringList.Add('');
    end;

    //Les effacer!
    for i := 0 to Max do
    begin
      if StringList.Strings[i] <> '' then
      begin
        Index := ChercheExact_ListBox(StringList.Strings[i], lbHistory);
        if Index <> -1 then lbHistory.Items.Delete(Index);
      end;
    end;

  finally
    StringList.Free;
  end;
end;

procedure THistory_Form.lbHistoryContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  Point : TPoint;

begin
  //Avec MousePos de cette procedure, ca marche pas.
  //Pas compris pourquoi...

  //On prend les coordonnées du curseur de souris...
  GetCursorPos(Point);

  //Cette ensemble de procédure permet de simuler le click.
  //Un click gauche est constitué de deux clicks : quand le
  //bouton est en haut, et quand le bouton est en bas.
  Mouse_Event(MOUSEEVENTF_LEFTDOWN, Point.X, Point.Y, 0, 0);
  Mouse_Event(MOUSEEVENTF_LEFTUP, Point.X, Point.Y, 0, 0);

  //Permet "d'activer" la sélection. Sinon ca sélectionne pas.
  //En fait, ca rend la main a Windows.
  Application.ProcessMessages;

  //On déroule avec du code pour dérouler si seulement la
  //CheckBox est cochée. Vous pouvez enlever ca, et mettre
  //AutoPopup à True dans le PopupMenu.
  { if CheckBox.Checked = True then
    PopUpMenu.Popup(Point.X, Point.Y); }
end;

procedure THistory_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
