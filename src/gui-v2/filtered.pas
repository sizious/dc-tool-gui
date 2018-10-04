unit filtered;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, JvRichEdit, ExtCtrls, Menus, XPMenu, ImgList;

type
  TFiltered_Form = class(TForm)
    mFiltered: TJvRichEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Saveas1: TMenuItem;
    N1: TMenuItem;
    Close1: TMenuItem;
    Clear1: TMenuItem;
    N2: TMenuItem;
    Deletealloutputs1: TMenuItem;
    Search1: TMenuItem;
    XPMenu: TXPMenu;
    ImageList: TImageList;
    SaveDialog: TSaveDialog;
    PopupMenu: TPopupMenu;
    Saveas2: TMenuItem;
    N3: TMenuItem;
    Copyselectedtext1: TMenuItem;
    Selectall1: TMenuItem;
    Copyselectedtext2: TMenuItem;
    Selectall2: TMenuItem;
    N4: TMenuItem;
    Clearthislist1: TMenuItem;
    Deletealloutputs2: TMenuItem;
    Search2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Options1: TMenuItem;
    Showmainwindow1: TMenuItem;
    Showmainform1: TMenuItem;
    N9: TMenuItem;
    FindDialog: TFindDialog;
    N10: TMenuItem;
    Stayontop1: TMenuItem;
    procedure Saveas1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Deletealloutputs1Click(Sender: TObject);
    procedure Copyselectedtext1Click(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Showmainwindow1Click(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure Search2Click(Sender: TObject);
    procedure Stayontop1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Déclarations privées }
    procedure DisplayHint(Sender : TObject);
  public
    { Déclarations publiques }
  end;

var
  Filtered_Form: TFiltered_Form;

implementation

uses main, r_colors, u_filters, utils, tools;

{$R *.dfm}

procedure TFiltered_Form.DisplayHint(Sender : TObject);
begin
  if Filtered_Form.Active = True then
    Filtered_Form.StatusBar.SimpleText := GetLongHint(Application.Hint);
end;

procedure TFiltered_Form.Saveas1Click(Sender: TObject);
begin
  if SaveDialog.Execute = True then
  begin
    if SaveDialog.FilterIndex = 1 then
      mFiltered.Lines.SaveToFile(SaveDialog.FileName)
    else begin
      Main_Form.lbSave.Items := mFiltered.Lines;
      Main_Form.lbSave.Items.SaveToFile(SaveDialog.FileName);
    end;
  end;
end;

procedure TFiltered_Form.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TFiltered_Form.FormCreate(Sender: TObject);
begin
  PutFilteredHeader;
end;

procedure TFiltered_Form.Clear1Click(Sender: TObject);
var
  CanContinue : integer;

begin
  CanContinue := MsgBox(Handle, AreYouSureToClearTheList, QuestionCaption, 32 + MB_YESNO + MB_DEFBUTTON2);
  if CanContinue = IDNO then Exit;

  PutFilteredHeader;
end;

procedure TFiltered_Form.Deletealloutputs1Click(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, AreYouSureToDeleteOutputs, WarningCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
  if CanDo = IDNO then Exit;
  
  PutHeader;
end;

procedure TFiltered_Form.Copyselectedtext1Click(Sender: TObject);
begin
  //Clipboard.SetTextBuf(PChar(mFiltered.SelText));
  mFiltered.CopyToClipboard;
end;

procedure TFiltered_Form.Selectall1Click(Sender: TObject);
begin
  mFiltered.SelectAll;
end;

procedure TFiltered_Form.Showmainwindow1Click(Sender: TObject);
begin
  Main_Form.SetFocus;
end;

procedure TFiltered_Form.FindDialogFind(Sender: TObject);
var
  FoundAt         : LongInt;
  StartPos, ToEnd : Integer;

begin
  with mFiltered do
  begin
    {commence la recherche après la sélection en cours s'il y en a une }
    {sinon, commence au début du texte }
    if SelLength <> 0 then
      StartPos := SelStart + SelLength
    else StartPos := 0;

    {ToEnd indique la longueur entre StartPos et la fin du texte du contrôle éditeur de texte enrichi }
    ToEnd := Length(Text) - StartPos;

    //FindDialog1.Options
    //if FindDialog1.Options = [frMatchCase];

    FoundAt := FindText(FindDialog.FindText, StartPos, ToEnd, []);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart  := FoundAt;
      SelLength := Length(FindDialog.FindText);
    end else MsgBox(FindDialog.Handle, TextNotFoundOrAllOccurencesFound, InformationCaption, 64);
  end;
end;

procedure TFiltered_Form.Search2Click(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TFiltered_Form.Stayontop1Click(Sender: TObject);
begin
  if StayOnTop1.Checked = False then
  begin
    StayOnTop1.Checked := True;
    Filtered_Form.FormStyle := fsStayOnTop;
    WriteFilteredFormStyle;
  end else begin
    StayOnTop1.Checked := False;
    Filtered_Form.FormStyle := fsNormal;
    WriteFilteredFormStyle;
  end;
end;

procedure TFiltered_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TFiltered_Form.FormActivate(Sender: TObject);
begin
  Application.OnHint := DisplayHint;
end;

end.
