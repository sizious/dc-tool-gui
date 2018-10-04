unit download;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl;

type
  TDownload_Form = class(TForm)
    FileName_Label: TLabel;
    FileInfo_GroupBox: TGroupBox;
    Input_Label: TLabel;
    SaveDialog: TSaveDialog;
    Output_Edit: TComboBox;
    InputFile_SpeedButton: TBitBtn;
    SetSizeBtn: TBitBtn;
    OK: TBitBtn;
    Cancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure InputFile_SpeedButtonClick(Sender: TObject);
    procedure SetSizeBtnClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Download_Form: TDownload_Form;

implementation

uses u_hist, bba, bba_commands, main, dctool_cfg, progress, tools, setsize,
     baudrate, address, utils, commands, u_ctrls, u_kill_dctool,
  dl_progress;

{$R *.dfm}

procedure TDownload_Form.FormShow(Sender: TObject);
begin
  LoadIntoComboBoxes;
end;

procedure TDownload_Form.InputFile_SpeedButtonClick(Sender: TObject);
begin
  if SaveDialog.Execute = True then
    Output_Edit.Text := SaveDialog.FileName;
end;

procedure TDownload_Form.SetSizeBtnClick(Sender: TObject);
begin
  SetSize_Form.ShowModal;
end;

procedure TDownload_Form.OKClick(Sender: TObject);
var
  Rep : integer;
  
begin
  FileNameOp := Download_Form.Output_Edit.Text;
  //ProcessFinished := False;

  // ---- TEST DE VALIDITE ----
  // Si il est vide...
  if Download_Form.Output_Edit.Text = '' then
  begin
    MsgBox(Download_Form.Handle, InputPathEmpty, ErrorCaption, 48);
    Exit;
  end;

  //...Si la taille du fichier voulu est de 0...
  if StrToInt(SetSize_Form.Size.Text) = 0 then
  begin
    MsgBox(Download_Form.Handle, SizeCantBeZero, ErrorCaption, 48);
    Exit;
  end;

  //Si le fichier spécifié existe déjà, on va demander si il on l'ecrase!
  if FileExists(Download_Form.Output_Edit.Text) = True then
  begin
    Rep := MsgBox(Download_Form.Handle, FileExistsDoYouWantToReplaceIt + WrapStr + '"' + Download_Form.Output_Edit.Text + '".', ErrorCaption, MB_YESNO + MB_DEFBUTTON2 + 48);
    if Rep = IDNO then Exit;
  end;

  //Mettre le nom du BIN dans la fenetre.
  DownProgress_Form.lFileName.Caption := DownProgress_Form.lSaveTo.Caption
    + ' ' + MinimizeName(FileNameOp, DownProgress_Form.lFileName.Canvas, 100);

  //----< START !>---------
  DisactiveControls;
  KillAllRunningDCTOOL;

  //Execution du download, en fonction du type de connexion...
  if GetConnectionMethod = LINK_TYPE_SERIAL then
    DownloadFileFromDC
  else DownloadFileFromDCWithBBA;
end;

procedure TDownload_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
