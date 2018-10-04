unit u_filters;

interface

uses
  Windows, SysUtils, Controls, Graphics;

var
  FiltersINI : string;
  Editing    : boolean = False;
  
procedure AddKeyWord(Caption, Question : string);
procedure EditKeyWord(Caption, Question : string);
function CheckIfSelected : boolean;
procedure DeleteKeyWord;
procedure DeleteAllKeyWords;
procedure LoadKeyWordsFrom;
procedure AppendKeyWords;
procedure SaveKeyWordsTo;
procedure SaveList;
procedure LoadList;
function IsInFilterList(NewLine : string) : boolean;
procedure AddToFiltered(Msg : string);

implementation

uses tools, main, sh_listb, filters, addbox, utils, filtered, r_colors;

//---AddKeyWord---
procedure AddKeyWord(Caption, Question : string);
var
  CanContinue : integer;

begin
  Editing := False;

  Add_Form.Caption := Caption;
  Add_Form.gbQuestion.Caption := ' ' + Question + ' ';

  CanContinue := Add_Form.ShowModal;
  if CanContinue = mrCancel then Exit;
  if Length(Add_Form.eResp.Text) = 0 then Exit;

  Filters_Form.lbFilters.Items.Add(Add_Form.eResp.Text);
end;

//---CheckIfSelected---
function CheckIfSelected : boolean;
begin
  Result := True;
  if (Filters_Form.lbFilters.ItemIndex = -1) or (Filters_Form.lbFilters.Count = 0) or
    (Filters_Form.lbFilters.ItemIndex >= Filters_Form.lbFilters.Count) then Result := False;

  if Result = False then MsgBox(Filters_Form.Handle, PleaseSelectAItem, ErrorCaption, 48);
end;

//---EditKeyWord---
procedure EditKeyWord(Caption, Question : string);
var
  CanContinue : integer;
  
begin
  Editing := True;
  if CheckIfSelected = False then Exit;

  Add_Form.Caption := Caption;
  Add_Form.gbQuestion.Caption := ' ' + Question + ' ';

  Add_Form.eResp.Text := Filters_Form.lbFilters.Items.Strings[Filters_Form.lbFilters.ItemIndex];
  Add_Form.eResp.SelectAll;
  
  CanContinue := Add_Form.ShowModal;
  if CanContinue = mrCancel then Exit;
  if Length(Add_Form.eResp.Text) = 0 then Exit;

  //Filters_Form.lbFilters.Items.Add(Add_Form.eResp.Text);
  Filters_Form.lbFilters.Items.Strings[Filters_Form.lbFilters.ItemIndex] := Add_Form.eResp.Text;
end;

//---DeleteKeyWord---
procedure DeleteKeyWord;
var
  CanContinue : integer;
  
begin
  Editing := False;
  if CheckIfSelected = False then Exit;

  CanContinue := MsgBox(Filters_Form.Handle, AreYouSureToDeleteThisKeyword, WarningCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
  if CanContinue = IDNO then Exit;

  Filters_Form.lbFilters.DeleteSelected;
end;

//---DeleteAllKeyWords---
procedure DeleteAllKeyWords;
var
  CanContinue : integer;
  
begin
  Editing := False;

  CanContinue := MsgBox(Filters_Form.Handle, AreYouSureToDeleteAllFilters, WarningCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
  if CanContinue = IDNO then Exit;

  Filters_Form.lbFilters.Clear;
end;

//---LoadKeyWordsFrom---
procedure LoadKeyWordsFrom;
var
  CanContinue : integer;

begin
  Editing := False;

  CanContinue := MsgBox(Filters_Form.Handle, AreYouSureToRemplaceAllFilters, WarningCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
  if CanContinue = IDNO then Exit;

  if Filters_Form.OpenDialog.Execute = False then Exit;

  Filters_Form.lbFilters.Items.LoadFromFile(Filters_Form.OpenDialog.FileName);
end;

//---AppendKeyWords---
procedure AppendKeyWords;
var
  F : TextFile;
  Line : string;
  Compteur : integer;

begin
  Editing := False;
  Compteur := 0;
  if Filters_Form.OpenDialog.Execute = False then Exit;
  
  { if FileExists(Filters_Form.OpenDialog.FileName) = False then
  begin
    MsgBox(Main_Form.Handle, 'Fichier "' + FileName + '" non trouvé...', 'Erreur conne :D', 48);
    Exit;
  end; }

  AssignFile(F, Filters_Form.OpenDialog.FileName);
  FileMode := 0;
  Reset(F);

  while not EOF(F) do
  begin
    ReadLn(F, Line);
    //if Cherche_ListBox(Line, Main_Form.BanListBox) = -1 then
    if ChercheExact_ListBox(Line, Filters_Form.lbFilters) = -1 then
    begin
      Filters_Form.lbFilters.Items.Add(Line);
      Compteur := Compteur + 1;
    end;
  end;

  CloseFile(F);

  if Compteur = 0 then
  begin
    MsgBox(Filters_Form.Handle, NothingWasAddedToTheListBecauseThereIsNothingToAdd, InformationCaption, 48);
    Exit;
  end;

  MsgBox(Filters_Form.Handle, ThereIs + ' ' + IntToStr(Compteur) + ' ' + ItemsAdded, InformationCaption, 64);
end;

//---SaveKeyWordsTo---
procedure SaveKeyWordsTo;
begin
  Editing := False;
  if Filters_Form.SaveDialog.Execute = False then Exit;

  Filters_Form.lbFilters.Items.SaveToFile(Filters_Form.SaveDialog.FileName);
end;

//---SaveList---
procedure SaveList;
begin
  Filters_Form.lbFilters.Items.SaveToFile(FiltersIni);
end;

//---LoadList---
procedure LoadList;
begin
  if FileExists(FiltersIni) = False then Exit;
  Filters_Form.lbFilters.Items.LoadFromFile(FiltersIni);
end;

//---IsInFilterList---
function IsInFilterList(NewLine : string) : boolean;
begin
  Result := False;
  if MotClef_ListBox(NewLine, Filters_Form.lbFilters) <> -1 then Result := True;

  if Result = True then AddToFiltered('OUTPUT:> ' + NewLine)
end;

//---AddToFiltered---
procedure AddToFiltered(Msg : string);
begin
  //if Main_Form.Visible = True then
  //  GotoLine(Main_Form.mOutput, Main_Form.mOutput.Lines.Count - 1);
  if Filtered_Form.mFiltered = nil then Exit; //Si l'objet détruit on se barre!
    
  if Msg = ' ' then Filtered_Form.mFiltered.Lines.Add('')
  else begin
    if IsInString('CMD:>', Msg) then SetTextAttribut(Filtered_Form.mFiltered, clGreen);
    if IsInString('OUTPUT:>', Msg) then SetTextAttribut(Filtered_Form.mFiltered, clBlue, 8, 'Tahoma', [fsBold]);
    if IsInString('STATE:>', Msg) then SetTextAttribut(Filtered_Form.mFiltered, clRed);
    Filtered_Form.mFiltered.Lines.Add(Msg);
  end;
  //Main_Form.mOutput.ItemIndex := Main_Form.AHListBox.Count - 1;
end;

end.
