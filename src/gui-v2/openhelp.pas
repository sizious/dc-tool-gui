{
  Permet d'ouvrir le fichier d'aide associé à la langue.
}

unit openhelp;

interface

uses
  Windows, SysUtils, IniFiles, Forms;

function GetHelpFile : string;
  
implementation

uses main, tools;

//---CreateEnglishIni---
procedure CreateEnglishIni;
var
  F         : TextFile;
  AppDir    : string;
  HelpFile  : string;

begin
  AppDir := GetRealPath(ExtractFilePath(Application.ExeName));
  HelpFile := AppDir + 'help_eng.ini';
  if FileExists(HelpFile) = True then Exit;

  //Ecrire le fichier d'aide english (enfin le fichier de config).
  AssignFile(F, HelpFile);
  ReWrite(F);
  WriteLn(F, ';DC-TOOL GUI v2.0 series');
  WriteLn(F, ';ENGLISH HELP FILE');
  WriteLn(F, ';Write here the help filename');
  WriteLn(F, '');
  WriteLn(F, '[EnglishHelp]');
  WriteLn(F, 'FileName=readme.txt');
  CloseFile(F);
end;

//---GetHelpFile---
function GetHelpFile : string;
var
  LngDir  : string;
  LngFile : TIniFile;
  LangID  : string;
  HelpFile: string;
  AppDir  : string;

begin
  AppDir := GetRealPath(ExtractFilePath(Application.ExeName));

  if FileExists(AppDir + 'help_eng.ini') = False then
  begin
    Result := AppDir + 'readme.txt'; //Si le fichier help_eng.ini existe pas... on met readme.txt comme fichier d'aide.
    CreateEnglishIni; //On crée le fichier INI pour que l'utilisateur sait que c possible!
  end else begin

    LngFile := TIniFile.Create(AppDir + 'help_eng.ini');
    try
      HelpFile := LngFile.ReadString('EnglishHelp', 'FileName', 'readme.txt'); //sinon ce qui y'a à l'interieur.

      if FileExists(AppDir + HelpFile) = False then
      begin
        Result := AppDir + 'readme.txt';
      end else Result := AppDir + HelpFile;

    finally
      LngFile.Free;
    end;
  end;

  //Lire dans le INI le fichier d'aide...
  LangID := Ini.ReadString('Config', 'LangID', LangID);
  if UpperCase(LangID) = 'ENGLISH' then Exit; //Si c'est anglais, pas la peine d'aller + loin

  //Ouvrir le fichier voulu.
  LngDir := ExtractFilePath(Application.ExeName) + 'LANG\';
  LngFile := TIniFile.Create(LngDir + LangID);

  if FileExists(LngDir + LangID) = False then
  begin
    MsgBox(Main_Form.Handle, 'Damn! File "' + LngDir + LangID + '" not found !' + WrapStr + 'So the default help file will be opened.', 'OOPS!', 48);
    Ini.WriteString('Config', 'LangID', 'English');
    Exit;
  end;

  try
    HelpFile := LngFile.ReadString('Lang', 'HelpFile', '');
    if FileExists(LngDir + HelpFile) = True then Result := LngDir + HelpFile; 
  finally
    LngFile.Free;
  end;
end;

end.
