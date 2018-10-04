unit u_search;

interface

uses
  Windows, SysUtils, Controls, SynEditTypes, SynEditMiscProcs, SynEdit, ComCtrls,
  Types, Dialogs;

type
  TSearchType = (stFirstSearch, stForward, stBackward);
  
function RunSearch : boolean;
function SearchForward : boolean;
function SearchBackward : boolean;
function FindOptionsToSearchTypes(Options : TFindOptions) : TSearchTypes;

implementation

uses
  dlgSearchText, Main, Utils;

  // options - to be saved to the registry
var
  fSearchFromCaret : boolean;
  
  gbSearchBackwards: boolean;
  gbSearchCaseSensitive: boolean;
  gbSearchFromCaret: boolean;
  gbSearchSelectionOnly: boolean;
  gbSearchTextAtCaret: boolean;
  gbSearchWholeWords: boolean;
  gbSearchRegex: boolean;

  gsSearchText: string;
  gsSearchTextHistory: string;
  gsReplaceText: string;
//  gsReplaceTextHistory: string;

//resourcestring
//  STextNotFound = 'Text not found';

{ TSearchReplaceDemoForm }

procedure DoSearchText(SynEditor : TSynEdit ; ABackwards: boolean);
var
  Options: TSynSearchOptions;
  //SynEditor : TSynEdit;

begin
  //SynEditor := Main_Form.seOutputs;
  
  //Statusbar.SimpleText := '';

  {if AReplace then
    Options := [ssoPrompt, ssoReplace, ssoReplaceAll]
  else }
  Options := [];
  
  if ABackwards then
    Include(Options, ssoBackwards);
  if gbSearchCaseSensitive then
    Include(Options, ssoMatchCase);
  if not fSearchFromCaret then
    Include(Options, ssoEntireScope);
  if gbSearchSelectionOnly then
    Include(Options, ssoSelectedOnly);
  if gbSearchWholeWords then
    Include(Options, ssoWholeWord);
  if gbSearchRegex then
    SynEditor.SearchEngine := Main_Form.SynEditRegexSearch
  else
    SynEditor.SearchEngine := Main_Form.SynEditSearch;
  if SynEditor.SearchReplace(gsSearchText, gsReplaceText, Options) = 0 then
  begin
    MessageBeep(MB_ICONASTERISK);

    //Statusbar.SimpleText := STextNotFound;

    if ssoBackwards in Options then
      SynEditor.BlockEnd := SynEditor.BlockBegin
    else
      SynEditor.BlockBegin := SynEditor.BlockEnd;
    SynEditor.CaretXY := SynEditor.BlockBegin;
  end;

  //if ConfirmReplaceDialog <> nil then
  //  ConfirmReplaceDialog.Free;
end;

procedure ShowSynSearchDialog(SynEditor : TSynEdit);
var
  dlg: TTextSearchDialog;


begin
  //SynEditor := Main_Form.seOutputs;

  //Statusbar.SimpleText := '';

  //if AReplace then
    //dlg := TTextReplaceDialog.Create(Self)
  //else

  dlg := TTextSearchDialog.Create(Main_Form);

  with dlg do try
    // assign search options
    SearchBackwards := gbSearchBackwards;
    SearchCaseSensitive := gbSearchCaseSensitive;
    SearchFromCursor := gbSearchFromCaret;
    SearchInSelectionOnly := gbSearchSelectionOnly;
    // start with last search text
    SearchText := gsSearchText;
    if gbSearchTextAtCaret then begin
      // if something is selected search for that text
      if SynEditor.SelAvail and (SynEditor.BlockBegin.Line = SynEditor.BlockEnd.Line)
      then
        SearchText := SynEditor.SelText
      else
        SearchText := SynEditor.GetWordAtRowCol(SynEditor.CaretXY);
    end;
    SearchTextHistory := gsSearchTextHistory;
    {if AReplace then with dlg as TTextReplaceDialog do begin
      ReplaceText := gsReplaceText;
      ReplaceTextHistory := gsReplaceTextHistory;
    end; }
    SearchWholeWords := gbSearchWholeWords;
    if ShowModal = mrOK then begin
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gbSearchRegex := SearchRegularExpression;
      gsSearchText := SearchText;
      gsSearchTextHistory := SearchTextHistory;
      {if AReplace then with dlg as TTextReplaceDialog do begin
        gsReplaceText := ReplaceText;
        gsReplaceTextHistory := ReplaceTextHistory;
      end; }
      fSearchFromCaret := gbSearchFromCaret;
      if gsSearchText <> '' then begin
        DoSearchText(SynEditor, gbSearchBackwards);
        fSearchFromCaret := TRUE;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

//------------------------------------------------------------------------------

function DoRightSearch(SearchType : TSearchType) : boolean;
var
  SE : TSynEdit;
//  RE : TRichEdit;
  Curr : TWinControl;

begin
  Result := False;
  Curr := Main_Form.ActiveControl;
  if not Assigned(Curr) then Exit;

  if Curr is TSynEdit then
  begin
    //faire la recherche dans le synedit.
    SE := Curr as TSynEdit;

    case SearchType of
      stFirstSearch : ShowSynSearchDialog(SE);
      stForward     : DoSearchText(SE, False);
      stBackward    : DoSearchText(SE, True);
    end;

    Result := True;
    Exit;
  end;

  if Curr is TRichEdit then
  begin
    //faire la recherche dans le richedit.
    //RE := Curr as TRichEdit;
    case SearchType of
      stFirstSearch : begin
                        //Main_Form.FindDialog.Position := Point(RE.Left + RE.Width, RE.Top);
                        Main_Form.FindDialog.Execute;
                      end;
      stForward     : Main_Form.FindDialogFind(Main_Form);
      //stBackward    :
    end;

    Result := True;
    Exit;
  end;
end;

function RunSearch : boolean;
begin
  Result := DoRightSearch(stFirstSearch);
end;

function SearchForward : boolean;
begin
  Result := DoRightSearch(stForward);
end;

function SearchBackward : boolean;
begin
  Result := DoRightSearch(stBackward);
end;

function FindOptionsToSearchTypes(Options : TFindOptions) : TSearchTypes;
begin
  Result := [];
  
  if frWholeWord in Options then
    Result := [stWholeWord];
  if frMatchCase in Options then
    Result := [stMatchCase];
end;

end.
