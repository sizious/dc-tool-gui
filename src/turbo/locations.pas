unit locations;

interface

procedure EnableExternalLocs;
procedure EnableInternalLocs;

implementation

uses main;

procedure EnableExternalLocs;
begin
  Main_Form.lDCTOOL.Enabled := True;
  Main_Form.lCYGWIN.Enabled := True;
  //Main_Form.lCYGINTL.Enabled := True;
  Main_Form.eDCTOOL.Enabled := True;
  Main_Form.eCYGWIN.Enabled := True;
  //Main_Form.eCYGINTL.Enabled := True;
  Main_Form.bDCTOOL.Enabled := True;
  Main_Form.bCYGWIN.Enabled := True;
  //Main_Form.bCYGINTL.Enabled := True;
  Main_Form.rbLocSerial.Enabled := True;
  Main_Form.rbLocBBA.Enabled := True;

  Main_Form.rbLocSerial.Checked := True; //Click pour activer sur la page 2
  Main_Form.rbSerial.Checked := True;
end;

procedure EnableInternalLocs;
begin
  Main_Form.lDCTOOL.Enabled := False;
  Main_Form.lCYGWIN.Enabled := False;
  //Main_Form.lCYGINTL.Enabled := False;
  Main_Form.eDCTOOL.Enabled := False;
  Main_Form.eCYGWIN.Enabled := False;
  //Main_Form.eCYGINTL.Enabled := False;
  Main_Form.bDCTOOL.Enabled := False;
  Main_Form.bCYGWIN.Enabled := False;
  //Main_Form.bCYGINTL.Enabled := False;
  Main_Form.rbLocSerial.Enabled := False;
  Main_Form.rbLocBBA.Enabled := False;
end;

end.
