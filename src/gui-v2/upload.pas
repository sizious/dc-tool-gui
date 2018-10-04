unit upload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FileCtrl;

type
  TUpload_Form = class(TForm)
    FileInfo_GroupBox: TGroupBox;
    Input_Label: TLabel;
    Input_OpenDialog: TOpenDialog;
    UpExecute: TCheckBox;
    FileName_Label: TLabel;
    Input_Edit: TComboBox;
    InputFile_SpeedButton: TBitBtn;
    OK: TBitBtn;
    Cancel: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure InputFile_SpeedButtonClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Upload_Form: TUpload_Form;

implementation

uses u_hist, bba, bba_commands, dctool_cfg, tools, main, progress, baudrate,
     address, utils, commands, u_ctrls, u_kill_dctool, u_binchk, options;

{$R *.dfm}

procedure TUpload_Form.FormShow(Sender: TObject);
begin
  LoadIntoComboBoxes;
end;

procedure TUpload_Form.InputFile_SpeedButtonClick(Sender: TObject);
begin
  if Input_OpenDialog.Execute = True then
    Input_Edit.Text := Input_OpenDialog.FileName;
end;

procedure TUpload_Form.BitBtn1Click(Sender: TObject);
var
  CanDo : integer;

begin
  FileNameOp := Upload_Form.Input_Edit.Text;
  //ProcessFinished := False;

  //AddDebug(' ');

  //Test de validité (si y'a rien, chib!)
  if Upload_Form.Input_Edit.Text = '' then
  begin
    MsgBox(Upload_Form.Handle, InputPathEmpty, ErrorCaption, 48);
    Exit;
  end;

  //Fichier existe?
  if FileExists(Upload_Form.Input_Edit.Text) = False then
  begin
    MsgBox(Upload_Form.Handle, ErrorFileNotFound + WrapStr + '"' + Upload_Form.Input_Edit.Text + '".', ErrorCaption, 48);
    Exit;
  end;

  //Fichier scrambled? (si c'est un BIN...)
{  if IsFileScrambled(PChar(FileNameOp)) = True then
    ShowMessage('Error'); }
  if DroiteDroite('.', UpperCase(FileNameOp)) = 'BIN' then
    if IsBinCorrect(Handle, FileNameOp) = False then Exit;

  //Verification de l'address du début !
  if Options_Form.cbWarnIfAddressNotDefault.Checked = False then
  begin
    if IsStartAddressDefault = False then
    begin
      CanDo := MsgBox(Handle, WarningAddressIsNotTheDefaultAddress + WrapStr + DoYouWantToContinueAnyway, ErrorCaption, 48 + MB_OKCANCEL + MB_DEFBUTTON2);
      if CanDo = IDCANCEL then Exit;
    end;
  end;

  //Mettre le nom du BIN dans la fenetre.
  UpProgress_Form.lFileName.Caption := UpProgress_Form.lSaveTo.Caption
    + ' ' + MinimizeName(FileNameOp, UpProgress_Form.lFileName.Canvas, 100);

  //----< START !>----
  DisactiveControls;    //Désactivation des controles
  KillAllRunningDCTOOL; //Kill toutes les applis

  //Et on execute l'opération... ici l'upload
  //en fonction du mode de connexion
  if GetConnectionMethod = LINK_TYPE_SERIAL then
    UploadFileToDC
  else UploadFileToDCWithBBA;
end;

procedure TUpload_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
