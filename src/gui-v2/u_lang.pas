{
  DC-TOOL GUI v1.2 -> 2.0
  Permet de lire les infos de traductions des fichiers sélectionnés.
}

unit u_lang;

interface

uses
  Windows, SysUtils, Forms, IniFiles;

procedure ReadTradInfos;
procedure SetTradInfoToEnglish;

implementation

uses tools, utils, lang;

//---SetTradInfoToEnglish---
procedure SetTradInfoToEnglish;
begin
  Lang_Form.lAuthor.Caption := 'Poor english version by :';
  Lang_Form.lVersion.Caption := '[big_fury]SiZiOUS... ;)';
  Lang_Form.mInfos.Clear;
  Lang_Form.mInfos.Lines.Add('Regards to Andrew Kieschnick!');
  Lang_Form.mInfos.Lines.Add('Remember : Dreamcast IS NOT dead...');
  Lang_Form.mInfos.Lines.Add('...Alive and kickin :p');
end;

//---ReadTradInfos---
procedure ReadTradInfos;
var
  LngFile       : TIniFile;
  SelectedFile,
  LngDir        : string;
  Index         : integer;

begin
  //Ouvrir le fichier voulu.
  LngDir := GetRealPath(ExtractFilePath(Application.ExeName) + 'LANG');
  Index := Lang_Form.Lang.ItemIndex;
  SelectedFile := Lang_Form.LangFileName.Items.Strings[Index];

  if Index = 0 then
  begin
    SetTradInfoToEnglish;
    Exit; //ENGLISH SELECT!
  end;

  LngFile := TIniFile.Create(LngDir + SelectedFile);

  if FileExists(LngDir + SelectedFile) = False then
  begin
    MsgBox(Lang_Form.Handle, 'Error when reading "' + LngDir + SelectedFile + '".', 'OOPS!', 48);
    Exit;
  end;

  Lang_Form.mInfos.Clear;
  Lang_Form.lAuthor.Caption := 'Author : ' + LngFile.ReadString('Lang', 'Author', 'Not specified');
  Lang_Form.lVersion.Caption := 'Version : ' +  LngFile.ReadString('Lang', 'Version', 'Not specified');
  Lang_Form.mInfos.Lines.Add(LngFile.ReadString('Lang', 'Comment', ''));
end;

end.
