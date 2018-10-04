unit setsize;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TSetSize_Form = class(TForm)
    SetTheSizeNowGroupBox: TGroupBox;
    Size_Label: TLabel;
    Label1: TLabel;
    Size: TEdit;
    Label2: TLabel;
    OKButton: TBitBtn;
    Cancel_Button: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SizeKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  SetSize_Form: TSetSize_Form;
  Modified : boolean;
  
implementation

{$R *.dfm}

uses Tools, utils;

procedure TSetSize_Form.FormActivate(Sender: TObject);
begin
  Size_Label.Caption := Size.Text;
  Size.SetFocus;
  Size.SelectAll;   
end;

procedure TSetSize_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Modified = False then
  begin
    Size.Text := Size_Label.Caption;
    ModalResult := mrCancel;
    Exit;
  end;

  ReadSize;
  Modified := False;
end;

procedure TSetSize_Form.SizeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    OKButton.Click;
  end;
end;

procedure TSetSize_Form.BitBtn1Click(Sender: TObject);
begin
  try
    StrToInt(Size.Text);
  except
    on EConvertError do
    begin
      MsgBox(Handle, SizeIsIncorrect + WrapStr + '"' + Size.Text + '".', ErrorCaption, 48);
      Size.SetFocus;
      Exit;
    end;
  end;

  WriteSize;
  Modified := True;
  ModalResult := mrOK;
end;

procedure TSetSize_Form.BitBtn2Click(Sender: TObject);
begin
  Size.Text := Size_Label.Caption;
end;

procedure TSetSize_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
