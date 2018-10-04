unit dct_loc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TDcToolLoc_Form = class(TForm)
    GroupBox2: TGroupBox;
    bBBA: TBitBtn;
    eBBA: TEdit;
    GroupBox3: TGroupBox;
    bSerial: TBitBtn;
    eSerial: TEdit;
    GroupBox4: TGroupBox;
    bUSB: TBitBtn;
    eUSB: TEdit;
    Bevel1: TBevel;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    odDcTool: TOpenDialog;
    cbBBA: TCheckBox;
    cbSerial: TCheckBox;
    cbUSB: TCheckBox;
    Label1: TLabel;
    procedure bBBAClick(Sender: TObject);
    procedure bSerialClick(Sender: TObject);
    procedure bUSBClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure cbBBAClick(Sender: TObject);
    procedure cbSerialClick(Sender: TObject);
    procedure cbUSBClick(Sender: TObject);
  private
    { Déclarations privées }
    function CheckExecutable(FileName : TFileName) : boolean;
  public
    { Déclarations publiques }
    procedure LoadWindowState;
    procedure SaveWindowState;
  end;

var
  DcToolLoc_Form: TDcToolLoc_Form;

implementation

{$R *.dfm}

uses
  Main, Utils, config, U_dctool_wrapper;

procedure TDcToolLoc_Form.bBBAClick(Sender: TObject);
begin
  if odDcTool.Execute then
    eBBA.Text := odDcTool.FileName;
end;

procedure TDcToolLoc_Form.bSerialClick(Sender: TObject);
begin
  if odDcTool.Execute then
    eSerial.Text := odDcTool.FileName;
end;

procedure TDcToolLoc_Form.bUSBClick(Sender: TObject);
begin
  if odDcTool.Execute then
    eUSB.Text := odDcTool.FileName;
end;

function TDcToolLoc_Form.CheckExecutable(FileName: TFileName): boolean;
begin
  Result := FileExists(FileName);
  if not Result then MsgBox(Handle, 'File not found.'
    + WrapStr + 'File : "' + FileName + '".', 'Warning', 48);
end;

procedure TDcToolLoc_Form.bOKClick(Sender: TObject);
begin
  if cbBBA.Checked then
    if not CheckExecutable(eBBA.Text) then Exit;

  if cbSerial.Checked then
    if not CheckExecutable(eSerial.Text) then Exit;

  if cbUSB.Checked then
    if not CheckExecutable(eUSB.Text) then Exit;

  ModalResult := mrOK;
end;

procedure TDcToolLoc_Form.cbBBAClick(Sender: TObject);
begin
  eBBA.Enabled := cbBBA.Checked;
  bBBA.Enabled := cbBBA.Checked;
end;

procedure TDcToolLoc_Form.cbSerialClick(Sender: TObject);
begin
  eSerial.Enabled := cbSerial.Checked;
  bSerial.Enabled := cbSerial.Checked;
end;

procedure TDcToolLoc_Form.cbUSBClick(Sender: TObject);
begin
  eUSB.Enabled := cbUSB.Checked;
  bUSB.Enabled := cbUSB.Checked;
end;

procedure TDcToolLoc_Form.LoadWindowState;
var
  BbaInternal,
  SerialInternal,
  UsbInternal : boolean;

  BbaExe,
  SerialExe,
  UsbExe : string;

begin
  //On va mettre à jour la fenêtre
  SaveFile.ReadDcToolExes(BbaInternal, SerialInternal,
    UsbInternal, BbaExe, SerialExe, UsbExe);  //lire la config dans le config.ini

  //mise à jour des controles.
  cbBBA.Checked := BbaInternal;
  cbSerial.Checked := SerialInternal;
  cbUSB.Checked := UsbInternal;
  eBBA.Text := BbaExe;
  eSerial.Text :=  SerialExe;
  eUSB.Text := UsbExe;
end;

procedure TDcToolLoc_Form.SaveWindowState;
begin
  with Main_Form do
  begin

    if cbBBA.Checked then
      DCTool.BroadBand.Executable := eBBA.Text
    else DCTool.BroadBand.Executable := GetCompleteFileName(dfBBA);

    if cbSerial.Checked then
      DCTool.Serial.Executable := eSerial.Text
    else DCTool.Serial.Executable := GetCompleteFileName(dfSerial);

    if cbUSB.Checked then
      DCTool.USB.Executable := eUSB.Text
    else DCTool.USB.Executable := GetCompleteFileName(dfUSB);

  end;

  //sauvegarder la config du driver.
  //SF.SaveConfig;

  SaveFile.WriteDcToolExes(cbBBA.Checked, cbSerial.Checked,
    cbUSB.Checked, eBBA.Text, eSerial.Text, eUSB.Text);
end;


end.
