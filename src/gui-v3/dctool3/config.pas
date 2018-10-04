unit config;

interface

uses
  SysUtils, IniFiles, U_config;

var
  SaveFile : TSaveFile;

procedure ConfigureApplication;
procedure ExitApplication;
function GetConfigDir : string;
function GetDefaultWorkDir : string;
function SetDefaultWorkDir(Path : string) : boolean;
function IsSplashEnabled : boolean;

implementation

uses histmgr, U_dctool_wrapper, Utils, main;

var
  CurrentPath : string;

function IsSplashEnabled : boolean;
var
  Ini : TIniFile;

begin
  Ini := TIniFile.Create(GetConfigDir + CONFIG_FILE);
  try
    Result := Ini.ReadBool('Options', 'ShowSplash', True);
  finally
    Ini.Free;
  end;
end;

procedure OpenSaveFile;
begin
  if Assigned(SaveFile) then Exit;
  SaveFile := TSaveFile.Create;
end;

procedure CloseSaveFile;
begin
  SaveFile.Free;
end;

//---ConfigureApplication---
procedure ConfigureApplication;
begin
  //Ouvrir le fichier config.ini
  OpenSaveFile;

  //Extraire les binaires...
  ExtractAllFiles;

  //Lire la config...
  SaveFile.LoadConfig;

  //Historiques (ouvrir les historiques)
  //Ca fait beaucoup en m�moire, mais bon... plutot que d'eviter des access
  //disques trop fr�quent vaut mieux l'avoir en m�moire une fois pour toute.
  //�a fait quand m�me 5 historiques � gerer...
  CreateHistories;

  //On va initialiser le debug log de la Main_Form maintenant.
  Main_Form.InitDcToolLog;
end;

//---ExitApplication---
procedure ExitApplication;
begin
  //Sauvegarde de la config de l'utilisateur.
  //Ecrire le fichier de sauvegarde
  SaveFile.SaveConfig;

  //Detruire les Historiques (en sauvegardant avant bien �videment, automatique)...
  DestroyHistories;

  //D�truire les binaires...
  DeleteAllFiles;

  //Fermer le fichier config.ini
  CloseSaveFile;

  //msgbox(0, 'Yeh', '', 0);
end;

//---GetConfigDir---
//Avoir le dossier de config de l'application.
function GetConfigDir : string;
begin
  Result := GetRealPath(GetAppDir + CONFIG_DIR);
end;

function GetDefaultWorkDir : string;
begin
  Result := CurrentPath;//GetAppDir;  //pour le moment.
end;

function SetDefaultWorkDir(Path : string) : boolean;
begin
  Result := DirectoryExists(Path);
  if Result then CurrentPath := Path;
end;

end.
