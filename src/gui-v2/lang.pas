unit lang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TLang_Form = class(TForm)
    GroupBox1: TGroupBox;
    Lang: TComboBox;
    LangFileName: TListBox;
    Icon: TImage;
    bOK: TBitBtn;
    Bevel1: TBevel;
    mInfos: TMemo;
    BitBtn1: TBitBtn;
    lAuthor: TLabel;
    lVersion: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure bOKClick(Sender: TObject);
    procedure LangChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Lang_Form: TLang_Form;

implementation

uses main, utils, u_lang, tools;

var
  SureToCancel : boolean = True;

{$R *.dfm}

procedure TLang_Form.FormClose(Sender: TObject; var Action: TCloseAction);
var
  CanDo : integer;

begin
  if SureToCancel = True then
  begin
    CanDo := MsgBox(Handle, 'Sure to cancel and set the language to English ?', 'Warning', 48 + MB_YESNO + MB_DEFBUTTON2);

    if CanDo = IDNO then
    begin
      Action := caNone;
      Exit;
    end;

    MsgBox(Handle, 'You can re-choose the language in the Config > Language menu.', 'Information', 64);
    Lang.ItemIndex := 0;
    bOK.Click;
  end;
end;

procedure TLang_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TLang_Form.bOKClick(Sender: TObject);
var
  LangID : string;

begin
  SureToCancel := False;
  LangID := Lang_Form.LangFileName.Items.Strings[Lang_Form.Lang.ItemIndex];
  Ini.WriteString('Config', 'LangID', LangID);

  if UpperCase(LangID) = 'ENGLISH' then
  begin
    LoadEnglish;
    Exit;
  end;

  LoadLang(LangID);
end;

procedure TLang_Form.LangChange(Sender: TObject);
begin
  ReadTradInfos; //Lire les infos de traduction...
end;

procedure TLang_Form.FormCreate(Sender: TObject);
begin
  SetTradInfoToEnglish;
  SureToCancel := True;
end;

procedure TLang_Form.BitBtn1Click(Sender: TObject);
begin
  SureToCancel := True;
end;

end.
