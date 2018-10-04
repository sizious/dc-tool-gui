unit filters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, XPMenu, ImgList;

type
  TFilters_Form = class(TForm)
    GroupBox1: TGroupBox;
    lbFilters: TListBox;
    bAdd: TBitBtn;
    bDel: TBitBtn;
    bDelAll: TBitBtn;
    bLoad: TBitBtn;
    Bevel1: TBevel;
    bSave: TBitBtn;
    Bevel2: TBevel;
    bAppend: TBitBtn;
    bClose: TBitBtn;
    bEdit: TBitBtn;
    Bevel3: TBevel;
    bApply: TBitBtn;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PopupMenu: TPopupMenu;
    Additem1: TMenuItem;
    Edititem1: TMenuItem;
    N1: TMenuItem;
    Deleteitem1: TMenuItem;
    Deleteallitems1: TMenuItem;
    N2: TMenuItem;
    Loadfromfile1: TMenuItem;
    Appendfromfile1: TMenuItem;
    Savelistas1: TMenuItem;
    XPMenu: TXPMenu;
    ImageList: TImageList;
    Label1: TLabel;
    procedure bAddClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bDelClick(Sender: TObject);
    procedure bDelAllClick(Sender: TObject);
    procedure bLoadClick(Sender: TObject);
    procedure bAppendClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure bApplyClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbFiltersContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Filters_Form: TFilters_Form;
  Modified    : boolean = False;
  
implementation

uses u_filters, tools, utils;

{$R *.dfm}

procedure TFilters_Form.bAddClick(Sender: TObject);
begin
  Modified := True;
  AddKeyWord(AddANewItem, EnterTheStringHere);
end;

procedure TFilters_Form.bEditClick(Sender: TObject);
begin
  Modified := True;
  EditKeyWord(EditCurrentItem, PleaseEnterTheCorrectedItemHere);
end;

procedure TFilters_Form.bDelClick(Sender: TObject);
begin
  Modified := True;
  DeleteKeyWord;
end;

procedure TFilters_Form.bDelAllClick(Sender: TObject);
begin
  Modified := True;
  DeleteAllKeyWords;
end;

procedure TFilters_Form.bLoadClick(Sender: TObject);
begin
  Modified := True;
  LoadKeyWordsFrom;
end;

procedure TFilters_Form.bAppendClick(Sender: TObject);
begin
  Modified := True;
  AppendKeyWords;
end;

procedure TFilters_Form.bSaveClick(Sender: TObject);
begin
  SaveKeyWordsTo;
end;

procedure TFilters_Form.bApplyClick(Sender: TObject);
begin
  SaveList;
end;

procedure TFilters_Form.FormShow(Sender: TObject);
begin
  Modified := False;
end;

procedure TFilters_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);

var
  CanClose : integer;

begin
  if (Modified = True) and (ModalResult = mrCancel) then
  begin

    CanClose := MsgBox(Handle, CloseWithoutSavingChanges, QuestionCaption, 32 + MB_YESNO + MB_DEFBUTTON2);
    if CanClose = IDNO then
    begin
      ModalResult := mrNone;
      Exit;
    end;

  end;

  LoadList;
end;

procedure TFilters_Form.lbFiltersContextPopup(Sender: TObject;
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

procedure TFilters_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
