unit u_hist;

interface

uses
  Windows, SysUtils, Controls, StdCtrls, Forms, Dialogs;

const
  HistoryFileName : string = 'history.ini';

procedure WriteFileInHistory(FileName : string);
procedure LoadItemsFromHistoryInto(ComboBox : TComboBox);
procedure LoadHistoryFile;
procedure SaveHistoryFile;
function ChercheExact_ListBox(Chaine : string ; ListBox : TListBox) : integer;
procedure LoadIntoComboBoxes;

implementation

uses main, upload, download, history, tools;

{---------------------------------------------< LoadIntoComboBoxes >------------------------------------------------------------------ }

procedure LoadIntoComboBoxes;
begin
  LoadItemsFromHistoryInto(Upload_Form.Input_Edit);
  LoadItemsFromHistoryInto(Download_Form.Output_Edit);
end;

{---------------------------------------------< SaveHistoryFile >------------------------------------------------------------------ }

procedure SaveHistoryFile;
var
  HistoryFile : string;
  
begin
  HistoryFile := GetRealPath(ExtractFilePath(Application.ExeName)) + HistoryFileName;
  History_Form.lbHistory.Items.SaveToFile(HistoryFile);
end;

{---------------------------------------------< LoadHistoryFile >------------------------------------------------------------------ }

procedure LoadHistoryFile;
var
  HistoryFile : string;

begin
  HistoryFile := GetRealPath(ExtractFilePath(Application.ExeName)) + HistoryFileName;
  if FileExists(HistoryFile) = False then Exit;

  History_Form.lbHistory.Items.LoadFromFile(HistoryFile);
  LoadItemsFromHistoryInto(Upload_Form.Input_Edit);
  LoadItemsFromHistoryInto(Download_Form.Output_Edit);
end;

{---------------------------------------------< LoadItemsFromHistoryInto >------------------------------------------------------------------ }

procedure LoadItemsFromHistoryInto(ComboBox : TComboBox);
begin
  ComboBox.Items := History_Form.lbHistory.Items;
end;

{---------------------------------------------< WriteFileInHistory >------------------------------------------------------------------ }

procedure WriteFileInHistory(FileName : string);
begin
  //ShowMessage(FileName);
  if ChercheExact_ListBox(FileName, History_Form.lbHistory) = -1 then
  begin
    History_Form.lbHistory.Items.Add(FileName);
    SaveHistoryFile;
  end;
end;

{---------------------------------------------< ChercheExact_ListBox >------------------------------------------------------------------ }

function ChercheExact_ListBox(Chaine : string ; ListBox : TListBox) : integer;
var
  Index : integer;
  CurrentItem : string;

begin
  Result := -1;
  Chaine := UpperCase(Chaine);

  for Index := 0 to ListBox.Items.Count - 1 do
  begin
    CurrentItem := UpperCase(ListBox.Items.Strings[Index]);
    //AddError(IntToStr(Index)  + ' WinText : ' + Chaine + ' Nb Sous Chaine : ' + IntToStr(NbSousChaine(Chaine, CurrentItem)));
    //AddError(Chaine + ' - ' + CurrentItem);
    if CurrentItem = Chaine then
    begin
      Result := Index;
      Exit;
    end;
  end;
end;

{---------------------------------------------< FIN DES PROCEDURES >------------------------------------------------------------------ }

end.
