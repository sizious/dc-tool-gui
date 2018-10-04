unit u_wizard;

interface

uses
  Windows, SysUtils;

const
  SERIAL_IS_SELECTED  : Word = $0000;
  BBA_IS_SELECTED     : Word = $FFFF;
    
procedure ResetWizard;
procedure InitControls;
procedure ApplyConfigToDCTOOLGUI;

implementation

uses wizard, setip, baudrate, setsize, tools, main;

//---ResetWizard---
procedure ResetWizard;
begin
  Wizard_Form.prChoice.Visible := False;
  Wizard_Form.prSerial.Visible := False;
  Wizard_Form.prBBA.Visible := False;
  Wizard_Form.prFinish.Visible := False;
  Wizard_Form.ntChoice.Visible := False;
  Wizard_Form.ntSerial.Visible := False;
  Wizard_Form.ntBBA.Visible := False;
  Wizard_Form.ntFinish.Visible := False;
  Wizard_Form.Serial_Panel.Visible := False;
  Wizard_Form.BBA_Panel.Visible := False;
  Wizard_Form.Finish_Panel.Visible := False;
  Wizard_Form.Choice_Panel.Visible := False;
  Wizard_Form.img.Picture := Wizard_Form.img1.Picture;
  Wizard_Form.P1_Next.SetFocus;
end;

//---InitCOMPort---
procedure InitCOMPort;
begin
  if UpperCase(GetCOMPort) = 'COM1' then
  begin
    //SHOWMESSAGE('CHECKED : COM1');
    Wizard_Form.rbCOM1.Checked := True;
    Wizard_Form.rbCOM2.Checked := False;
    Wizard_Form.rbCOM3.Checked := False;
    Wizard_Form.rbCOM4.Checked := False;
    Exit;
  end;

  if UpperCase(GetCOMPort) = 'COM2' then
  begin
    //SHOWMESSAGE('CHECKED : COM2');
    Wizard_Form.rbCOM2.Checked := True;
    Wizard_Form.rbCOM1.Checked := False;
    Wizard_Form.rbCOM3.Checked := False;
    Wizard_Form.rbCOM4.Checked := False;
    Exit;
  end;

  if UpperCase(GetCOMPort) = 'COM3' then
  begin
    //SHOWMESSAGE('CHECKED : COM3');
    Wizard_Form.rbCOM3.Checked := True;
    Wizard_Form.rbCOM1.Checked := False;
    Wizard_Form.rbCOM4.Checked := False;
    Wizard_Form.rbCOM2.Checked := False;
    Exit;
  end;

  if UpperCase(GetCOMPort) = 'COM4' then
  begin
    //SHOWMESSAGE('CHECKED : COM4');
    Wizard_Form.rbCOM4.Checked := True;
    Wizard_Form.rbCOM1.Checked := False;
    Wizard_Form.rbCOM2.Checked := False;
    Wizard_Form.rbCOM3.Checked := False;
    Exit;
  end;
end;

//---InitBaudrate---
procedure InitBaudrate;
begin
  Wizard_Form.Baudrate.ItemIndex := SetBaudrate_Form.Baudrate.ItemIndex;
  Wizard_Form.cbAlternate.Checked := Main_Form.ryalternate1152001.Checked;
end;

//---GetLinkTypeCurrentlyUsed---
function GetLinkTypeCurrentlyUsed : Word;
begin
  if Main_Form.Serial1.Checked = True then
    Result := SERIAL_IS_SELECTED
  else Result := BBA_IS_SELECTED;
end;

//---InitControls---
procedure InitControls;
begin
  Wizard_Form.eIP.Text := IP_Form.eIP.Text;
  InitCOMPort;
  InitBaudrate;
  if GetLinkTypeCurrentlyUsed = SERIAL_IS_SELECTED then
  begin
    Wizard_Form.rbSerial.Checked := True;
    Wizard_Form.rbBBA.Checked := False;
  end else begin
    Wizard_Form.rbSerial.Checked := False;
    Wizard_Form.rbBBA.Checked := True;
  end;
end;

//---ApplyCOMPort---
procedure ApplyCOMPort;
begin
  if Wizard_Form.rbCOM1.Checked = True then
  begin
    Main_Form.COM1.Click;
    Exit;
  end;

  if Wizard_Form.rbCOM2.Checked = True then
  begin
    Main_Form.COM2.Click;
    Exit;
  end;

  if Wizard_Form.rbCOM3.Checked = True then
  begin
    Main_Form.COM3.Click;
    Exit;
  end;

  if Wizard_Form.rbCOM4.Checked = True then
  begin
    Main_Form.COM4.Click;
    Exit;
  end;
end;

//---ApplyLinkType---
procedure ApplyLinkType;
begin
  if Wizard_Form.rbSerial.Checked = True then
    Main_Form.Serial1.Click
  else Main_Form.BroadbandAdapter1.Click;
end;
 
//---ApplyConfigToDCTOOLGUI---
procedure ApplyConfigToDCTOOLGUI;
begin
  IP_Form.eIP.Text := Wizard_Form.eIP.Text;
  WriteIP; //IP
  ApplyCOMPort;
  WriteCOM;   //Port COM
  SetBaudrate_Form.Baudrate.ItemIndex := Wizard_Form.Baudrate.ItemIndex;
  WriteBaudrate; //Baudrate
  ApplyLinkType;
  WriteLinkType; //Type de liaison
  Main_Form.ryalternate1152001.Checked := Wizard_Form.cbAlternate.Checked;
  WriteConfig; //Alternate Baudrate (+ les autres options).
end;

end.
