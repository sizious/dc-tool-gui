{
  Unit U_Ctrls : Permet de désactiver/activer les controls pendant un transfert
  For DC-TOOL GUI v1.2
  by [big_fury]SiZiOUS
}

unit u_ctrls;

interface

procedure ActiveControls;
procedure DisactiveControls;

implementation

uses main, filtered, tools, u_dctool_manager;

//---ActiveControls---
procedure ActiveControls;
begin
  if Main_Form = nil then Exit;
  Main_Form.Edit1.Enabled := True;
  Main_Form.Options1.Enabled := True;
  Main_Form.Config1.Enabled := True;
  Main_Form.Upload1.Enabled := True;
  Main_Form.Downloadto1.Enabled := True;
  Main_Form.Abortoperation1.Enabled := False;
  Main_Form.Filters1.Enabled := True;
  Main_Form.Reexecute1.Enabled := True;
  Main_Form.Cleardebuglog1.Enabled := True; //Pour le menu click droit
  Main_Form.Cleardebuglog2.Enabled := True; //Haut du menu
  Main_Form.Cleardebug1.Enabled := True; //Dans le menu sur la tree View!
  Filtered_Form.Clearthislist1.Enabled := True;
  Filtered_Form.Clear1.Enabled := True;
  Filtered_Form.Deletealloutputs1.Enabled := True;
  Filtered_Form.Deletealloutputs2.Enabled := True;
  Main_Form.DumpDreamcastBIOS1.Enabled := True;
  //Main_Form.CygwinDLLs1.Enabled := True;
  Main_Form.Linktest1.Enabled := True;
  //Main_Form.DumpDreamcastGD1.Enabled := True;
  //Main_Form.DumpDreamcastVMU1.Enabled := True;
  Main_Form.DeleteFLASH1.Enabled := True;
  Main_Form.Sendacommand1.Enabled := True;
end;

//---DisactiveControls---
procedure DisactiveControls;
begin
  if Main_Form = nil then Exit;

  //Preparer DC-TOOL au transfert!
  //PrepareDCTOOL;

  //Desactiver tout!
  Main_Form.Edit1.Enabled := False;
  Main_Form.Options1.Enabled := False;
  Main_Form.Config1.Enabled := False;
  Main_Form.Upload1.Enabled := False;
  Main_Form.Downloadto1.Enabled := False;
  Main_Form.Abortoperation1.Enabled := True;
  Main_Form.Filters1.Enabled := False;
  Main_Form.Reexecute1.Enabled := False;
  Main_Form.Cleardebuglog1.Enabled := False; //Pour le menu click droit
  Main_Form.Cleardebuglog2.Enabled := False; //Haut du menu
  Main_Form.Cleardebug1.Enabled := False; //Dans le menu sur la tree View!
  Filtered_Form.Clearthislist1.Enabled := False;
  Filtered_Form.Clear1.Enabled := False;
  Filtered_Form.Deletealloutputs1.Enabled := False;
  Filtered_Form.Deletealloutputs2.Enabled := False;
  Main_Form.DumpDreamcastBIOS1.Enabled := False;
  //Main_Form.DumpDreamcastGD1.Enabled := False;
  //Main_Form.DumpDreamcastVMU1.Enabled := False;
  Main_Form.Linktest1.Enabled := False;
  //Main_Form.CygwinDLLs1.Enabled := False;
  Main_Form.DeleteFLASH1.Enabled := False;
  Main_Form.Sendacommand1.Enabled := False;

  //Pour eviter qu'il réduise plein de fois. Ca peut bloquer la fenetre.
  RestoredOneTime  := False;
  MinimizedOneTime := False;
end;

end.
