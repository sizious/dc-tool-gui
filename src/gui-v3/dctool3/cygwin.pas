unit cygwin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, JvComponent, JvBaseDlg,
  JvBrowseFolder;

type
  TCygwin_Form = class(TForm)
    rgCygwin: TRadioGroup;
    GroupBox1: TGroupBox;
    eLib: TEdit;
    bLib: TBitBtn;
    Bevel1: TBevel;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    odCyg: TJvBrowseForFolderDialog;
    Label1: TLabel;
    procedure rgCygwinClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bLibClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    procedure LoadWindowState;
    procedure SaveWindowState;
  end;

var
  Cygwin_Form: TCygwin_Form;

implementation

uses main, config, utils, u_dctool_wrapper;

{$R *.dfm}

procedure TCygwin_Form.rgCygwinClick(Sender: TObject);
begin
  eLib.Enabled := rgCygwin.ItemIndex = 2;
  bLib.Enabled := rgCygwin.ItemIndex = 2;
end;

procedure TCygwin_Form.bOKClick(Sender: TObject);
var
  Directory : string;

begin
  if rgCygwin.ItemIndex = 2 then
  begin
    Directory := GetRealPath(eLib.Text);

    if not DirectoryExists(Directory) then
    begin
      MsgBox(Handle, 'Error, directory not found.' + WrapStr
        + 'Directory : "' + Directory + '".', 'Warning', 48);
      Exit;
    end;

    if not FileExists(Directory + CYGWIN1_DLL) then
    begin
      MsgBox(Handle, 'Error, file "' + CYGWIN1_DLL + '" wasn''t found'
        + ' in this directory.', 'Warning', 48);
      Exit;
    end;

    if not FileExists(Directory + CYGINTL_DLL) then
    begin
      MsgBox(Handle, 'Error, file "' + CYGINTL_DLL + '" wasn''t found'
        + ' in this directory.', 'Warning', 48);
      Exit;
    end;
  end;

  ModalResult := mrOK;
end;

procedure TCygwin_Form.bLibClick(Sender: TObject);
begin
  with odCyg do
    if Execute then eLib.Text := GetRealPath(Directory);
end;

procedure TCygwin_Form.LoadWindowState;
begin
  rgCygwin.ItemIndex := SaveFile.ReadInteger('Cygwin', 'Config');
  eLib.Text := SaveFile.ReadString('Cygwin', 'CygWinExternalPath');
end;

procedure TCygwin_Form.SaveWindowState;
begin
  SaveFile.WriteInteger('Cygwin', 'Config', rgCygwin.ItemIndex);
  SaveFile.WriteString('Cygwin', 'CygWinExternalPath', eLib.Text);
end;

end.
