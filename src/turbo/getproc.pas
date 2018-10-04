{
  Unité GetProcessId
  ==================

  Description : Unité permettant les opérations sur les fichiers en cours d'utilisation (éxécution),
                très pratique, dérivé de l'exemple mis sur Phidels.Com.
                Cela permet d'avoir des informations sur les fichiers, sans pour autant connaître leur
                handle fenêtre, leur classe ou leur texte (de fenêtre).
                Je pense (SiZiOUS) qu'il était nécessaire de finaliser le travail de Bernichi Maamoun,
                car son exemple est extrèment intéressant et utile.

  Procédures  : - GetProcInListBox          : Permet de vider une ListBox et d'assigner tous les process en cours.
                                              Et ceci de manière propre. Alors, calquez le modèle si vous avez besoin.
                - KillFileName              : Permet de tuer le process indiqué par FileName, mais seulement en mettant
                                              le nom de fichier (pas le chemin).
                - GetProcessList            : Très utile, elle liste tout les process en cours d'execution.
                - GetProcessId              : Tout est basé sur cette fonction. Elle permet de récupérer l'id du process.
                - KillProcessId             : Permet de killer une application avec son ID.
                - IsFileRunning             : Extension de GetProcessId. Permet de savoir avec une variable boolean si
                                              un fichier est en cours d'utilisation. A entrer sans chemin!
                - RefreshListBox            : Permet de rafraîchir le contenu d'une ListBox qui affiche les processus en cours.
                - GetProcessNameFromHandle  : Comme son nom l'indique, permet de récuperer le nom de chemin + l'executable
                                              grâce à l'Handle de la fenêtre de l'application cible.
                - GetProcessPathFromFileName: Celle la permet d'avoir le chemin à partir du nom du process (le nom du fichier).
                                              Exemple : Si vous tapez GetProcessPathFromFileName('Explorer.exe'), y a des chances
                                              que vous obtenez "C:\WINDOWS\". Et voila ;)
  Auteur      : Bernichi Maamoun

  E-mail      : mam@cyber.net.ma

  Source      : Phidels.Com [http://www.phidels.com]

  Infos       : Réécrite par [big_fury]SiZiOUS (http://www.sbibuilder.fr.st/) depuis l'exemple
                qu'il a fait sur Phidels.Com. Cette unité reprend simplement son exemple avec quelques
                fonctions améliorées, comme par exemple l'erreur de GetProcessId auquel il manquait un
                UpString | UpperCase.
                ZeuS-[SFX] pour GetProcessNameFromHandle.
}

unit getproc;

interface

uses
  StdCtrls, Tlhelp32, SysUtils, Windows, Classes;
  
//procedure GetProcInListBox(ListBox : TListBox);
function KillFileName(FileName : string) : boolean;
//function GetProcessList : TStringList;
//function GetProcessId(ProgName : string) : Cardinal;
//function KillProcessId(PId : Cardinal) : boolean;
function IsFileRunning(EXEName : string) : boolean;
//procedure RefreshListBox(ListBox : TListBox ; KeepSelect : boolean);
//function GetProcessNameFromHandle(Handle : HWND) : string;
//function GetProcessPathFromFileName(EXEName : string) : string;
function GetCurrentProcessCount : integer;

implementation

{----------------------------------------------< DEBUT DES PROCEDURES >----------------------------------------------------------------------------- }

{-----------------------------------------------< PROCEDURE UpString >----------------------------------------------------------------------------- }
//Equivalente a UpperCase

function UpString(Str: string): string;
var
  i : integer;
begin
  Result := '';
  for i := 1 to Length(Str) do
    Result := Result + UpCase(Str[i]);
end;

{----------------------------------------------< PROCEDURE GetProcessId >----------------------------------------------------------------------------- }


//fonction qui retourne l'id d'un process fournit en parametre
function GetProcessId(ProgName : string) : Cardinal;
var
  Snaph : THandle;
  Proc  : TProcessEntry32;
  PId   : Cardinal;
  
begin
  PId := 0;
  Proc.dwSize:=sizeof(Proc);
  Snaph := CreateToolHelp32SnapShot(TH32CS_SNAPALL, 0);  //recupere un capture de process
  Process32First(Snaph, Proc);  //premeir process de la list
  if UpString(ExtractFileName(Proc.szExeFile)) = UpString(ProgName) then  //test pour savoir si le process correspond
     PId := Proc.th32ProcessID // recupere l'id du process
  else begin
    while Process32Next(Snaph, Proc) do  //dans le cas contraire du test on continue à cherche le process en question
    begin
      if UpString(ExtractFileName(Proc.szExeFile)) = UpString(ProgName) then
        PId := Proc.th32ProcessID;
    end;
  end;
  CloseHandle(Snaph);
  Result := PId;
end;

{----------------------------------------------< PROCEDURE GetProcessList >----------------------------------------------------------------------------- }

//fonction qui marche comme GetProcessId, sauf que la elle retourne une liste de process
function GetProcessList : TStringList;
var
  Snaph : THandle;
  Proc  : TProcessEntry32;
  PList : TStringList;

begin
  PList := TStringList.Create();
  PList.Clear; 
  Proc.dwSize := SizeOf(Proc);
  Snaph := CreateToolHelp32SnapShot(TH32CS_SNAPALL, 0);
  Process32First(Snaph, Proc);
  PList.Add(ExtractFileName(proc.szExeFile));
  while Process32Next(Snaph, Proc) do
    PList.Add(ExtractFileName(Proc.szExeFile));
  Result := PList;
end;

{----------------------------------------------< PROCEDURE GetProcInListBox >----------------------------------------------------------------------------- }
{
procedure GetProcInListBox(ListBox : TListBox);
var
  TSL : TStringList;

begin
  ListBox.Clear;
  TSL := GetProcessList;
  try
    ListBox.Items.Assign(TSL);
  finally
    TSL.Free;
  end;
end;

{----------------------------------------------< PROCEDURE KillFileName >----------------------------------------------------------------------------- }

function KillFileName(FileName : string) : boolean;
var
  Proch : THandle;
  PId   : Cardinal;
  
begin
  PId := GetProcessId(FileName);
  Proch := OpenProcess(PROCESS_ALL_ACCESS, True, PId); //handle du process
  if not TerminateProcess(Proch, PId) then Result := False
  else Result := True;//terminer le process
end;

{----------------------------------------------< PROCEDURE KillProcessId >----------------------------------------------------------------------------- }
{
function KillProcessId(PId : Cardinal) : boolean;
var
  Proch : THandle;

begin
  Proch := OpenProcess(PROCESS_ALL_ACCESS, True, PId); //handle du process
  if not TerminateProcess(Proch, PId) then Result := False
  else Result := True;//terminer le process
end;

{----------------------------------------------< PROCEDURE IsFileRunning >----------------------------------------------------------------------------- }

function IsFileRunning(EXEName : string) : boolean;
begin
  if GetProcessId(EXEName) = 0 then Result := False
  else Result := True;
end;

{----------------------------------------------< PROCEDURE RefreshListBox >----------------------------------------------------------------------------- }
{
procedure RefreshListBox(ListBox : TListBox ; KeepSelect : boolean);
var
  Index : integer;

begin
  Index := ListBox.ItemIndex;
  GetProcInListBox(ListBox);
  if (Index >= 0) and (KeepSelect = True) = True then ListBox.ItemIndex := Index;
end;

{----------------------------------------------< Function GetProcessNameFromHandle >----------------------------------------------------------------------------- }
{
function GetProcessNameFromHandle(Handle : HWND) : string;
var 
  Pid : Longint;
  SnapShot : HWND;
  Module : TModuleEntry32;

begin 
  Result := ''; 
  if not IsWindow(Handle) then Exit; 
  GetWindowThreadProcessId(Handle, @Pid); // récupere le pid 
  Snapshot := CreateToolHelp32Snapshot(TH32CS_SNAPMODULE, Pid); // creer un snapshot sur le pid
  try
    //if Snapshot <> -1 then
    //begin
      Module.dwSize:=SizeOf(TModuleEntry32);
      if Module32First(Snapshot, Module) then Result := Module.szExePath; // recupere l'exe path
    //end;
  finally
    CloseHandle(Snapshot);
  end;
end;

{----------------------------------------------< Function GetProcessPathFromFileName >----------------------------------------------------------------------------- }
{
//fonction qui retourne le chemin d'un process fournit en parametre
function GetProcessPathFromFileName(EXEName : string) : string;
var
  PId   : Cardinal;
  SnapShot : HWND;
  Module : TModuleEntry32;

begin
  Result := '';
  //Recurperer l'ID du process
  PId := GetProcessId(EXEName);
  //Process inexistant
  if PId = 0 then Exit;
  //Recupere un capture de process
  SnapShot := CreateToolHelp32SnapShot(TH32CS_SNAPMODULE, Pid);
  //Recupere le path
  try
    Module.dwSize := SizeOf(TModuleEntry32);
    if Module32First(Snapshot, Module) then Result := ExtractFilePath(Module.szExePath);
  finally
    CloseHandle(Snapshot);
  end;
end;

{----------------------------------------< Function GetCurrentProcessCount >----------------------------------------------------------------------------- }

function GetCurrentProcessCount : integer;
begin
  Result := GetProcessList.Count;
end;

{----------------------------------------------< FIN DES PROCEDURES >----------------------------------------------------------------------------- }

end.
