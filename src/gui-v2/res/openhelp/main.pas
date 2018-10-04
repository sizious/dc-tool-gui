unit main;

interface

uses
  Windows, SysUtils, IniFiles;

var
  Ini : TIniFile;
    
function GetHelpFile : string;
function GetAppDir : string;

implementation

const
  WrapStr : string = #13 + #10;

//---MsgBox---
function MsgBox(Handle : HWND ; Message, Caption : string ; Flags : integer) : integer;
begin
  Result := MessageBoxA(Handle, PChar(Message), PChar(Caption), Flags);
end;
  
//---GetRealPath---
function GetRealPath(Path : string) : string;
var
  i : integer;
  LastCharWasSeparator : Boolean;

begin
  Result := '';
  LastCharWasSeparator := False;

  Path := Path + '\';

  for i := 1 to Length(Path) do
  begin
    if Path[i] = '\' then
    begin
      if not LastCharWasSeparator then
      begin
        Result := Result + Path[i];
        LastCharWasSeparator := True;
      end
    end
    else
    begin
       LastCharWasSeparator := False;
       Result := Result + Path[i];
    end;
  end;
end;

//---GetAppDir---
function GetAppDir : string;
begin
  Result := GetRealPath(ExtractFilePath(ParamStr(0)));
end;

//---CreateEnglishIni---
procedure CreateEnglishIni;
var
  F         : TextFile;
  AppDir    : string;
  HelpFile  : string;

begin
  AppDir := GetRealPath(ExtractFilePath(ParamStr(0)));
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

begin
  if FileExists(GetAppDir + 'help_eng.ini') = False then
  begin
    Result := GetAppDir + 'readme.txt'; //Si le fichier help_eng.ini existe pas... on met readme.txt comme fichier d'aide.
    CreateEnglishIni; //On crée le fichier INI pour que l'utilisateur sait que c possible!
  end else begin
    
    LngFile := TIniFile.Create(GetAppDir + 'help_eng.ini');
    try
      HelpFile := LngFile.ReadString('EnglishHelp', 'FileName', 'readme.txt'); //sinon ce qui y'a à l'interieur.

      if FileExists(GetAppDir + HelpFile) = False then
      begin
        Result := GetAppDir + 'readme.txt';
      end else Result := GetAppDir + HelpFile;

    finally
      LngFile.Free;
    end;
  end;

  //Lire dans le INI le fichier d'aide...
  LangID := Ini.ReadString('Config', 'LangID', LangID);
  if FileExists(Ini.FileName) = False then Exit; //pas de fichier INI
  if UpperCase(LangID) = 'ENGLISH' then Exit; //Si c'est anglais, pas la peine d'aller + loin

  //Ouvrir le fichier voulu.
  LngDir := GetRealPath(ExtractFilePath(ParamStr(0)) + 'LANG');
  LngFile := TIniFile.Create(LngDir + LangID);

  if FileExists(LngDir + LangID) = False then
  begin
    MsgBox(0, 'Damn! File "' + LngDir + LangID + '" not found !' + WrapStr + 'So the default help file will be opened.', 'OOPS!', 48);
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
