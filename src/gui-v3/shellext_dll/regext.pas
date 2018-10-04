{
   [big_fury]
   888888888     8888   888888888888   8888       888888888      8888      8888     888888888   
 8888888888888   8888   888888888888   8888     8888888888888    8888      8888   8888888888888
 8888     8888                88888            8888       8888   8888      8888   8888     8888 
 888888888       8888       888888     8888   8888         8888  8888      8888   888888888     
   8888888888    8888      88888       8888   8888         8888  8888      8888     88888888888 
        888888   8888    88888         8888   8888         8888  8888      8888           888888
 8888      8888  8888   88888          8888    8888       8888   8888      8888   8888      8888
 8888888888888   8888  88888888888888  8888     8888888888888     888888888888    8888888888888 
   8888888888    8888  88888888888888  8888       888888888        8888888888       8888888888  

  Unité RegExt
  ============

  Description : Unité permettant d'enregistrer des types de fichiers, et de les effacer.
                Bridé pour les EXE, DLL, BAT et les COM.
                On peut specifier une icône associé au type de fichier ainsi qu'une
                description. Par contre on ne peut pas spécifier d'application par défaut...
                ... pas la peine.

  Procédures  : - CreateExtension           : Cette fonction crée une nouvelle extension. On peut spécifier
                                              une description et une icone.

                - DeleteExtension           : Permet d'effacer une extension enregistré du systeme.
                                              ATTENTION, DANGER !
                                              NE FONCTIONNE PAS POUR LES EXE, DLL, BAT et COM.

  Auteur      : [big_fury]SiZiOUS (pour les 2 fonctions principales).

  E-mail      : sizious@yahoo.fr

  URL         : http://www.sbibuilder.fr.st

  Remarques   : Un GRAND merci à DevelOpeR13 (http://www.dev-zone.com) pour les
                3 fonctions utilisées ici, c'est à dire SetCreateKey,
                SetWriteString et GetDeleteKey.

                Un grand merci à lui, également à tout le monde de Phidels.com.
}

unit regext;

interface

uses
  Windows, SysUtils, Registry;

function CreateExtension(FileExtension, FileDescription, IconFileName : string) : boolean;
function DeleteExtension(FileExtension : string) : boolean;
function IsAlreadySet(FileExtension : string ; FileDescription : string) : boolean;

implementation

uses RegUtils;

//------------------------------------------------------------------------------

//---IsAlreadySet---
function IsAlreadySet(FileExtension : string ; FileDescription : string) : boolean;
var
  RG : TRegistry;
  ExtID : string;

begin
  Result := False;

  RG := TRegistry.Create;
  try
    ExtID := '';
    RG.RootKey := HKEY_CLASSES_ROOT;

    //***Recuperation de l'ID de l'extension.
    ExtID := GetExtensionID(RG, FileExtension, False);
    if ExtID = '' then Exit;

    if not RG.OpenKey(ExtID, False) then Exit;
    Result := LowerCase(FileDescription) = LowerCase(RG.ReadString(''));
  finally
    RG.Free;
  end;
end;

//------------------------------------------------------------------------------

//---CreateExtension---
function CreateExtension(FileExtension, FileDescription, IconFileName : string) : boolean;
var
  RG : TRegistry;
  ExtID : string;

begin
  Result := False;
  if FileExtension = '' then Exit;
  
  FileExtension := GetRealExt(FileExtension);

  RG := TRegistry.Create;
  try
    ExtID := '';
    RG.RootKey := HKEY_CLASSES_ROOT;

    //***Recuperation de l'ID de l'extension.
    ExtID := GetExtensionID(RG, FileExtension, True);
    if ExtID = '' then Exit;

    if not RG.OpenKey(ExtID, True) then Exit;
    RG.WriteString('', FileDescription);
    if not RG.OpenKey('DefaultIcon', True) then Exit;
    RG.WriteString('', IconFileName);
    Result := True;
  finally
    RG.Free;
  end;
end;

//------------------------------------------------------------------------------

//---DeleteExtension---
function DeleteExtension(FileExtension : string) : boolean;
const
  DenyExt : array[0..11] of string = (  'EXE', 'DLL', 'COM', 'BAT', 'CMD', 'SCR',
                                        'PIF', 'LNK', 'VXD', 'SYS', 'OCX', '386');
var
  RG : TRegistry;
  ExtID : string;
  i : integer;

begin
  Result := False;
  if FileExtension = '' then Exit;

  FileExtension := GetRealExt(FileExtension);

  //Extension non autorisés (system)
  for i := 0 to High(DenyExt) do
    if UpperCase(DenyExt[i]) = UpperCase(FileExtension) then Exit;

  RG := TRegistry.Create;
  try
    ExtID := '';
    RG.RootKey := HKEY_CLASSES_ROOT;

    //***Recuperation de l'ID de l'extension.
    ExtID := GetExtensionID(RG, FileExtension, True);
    if ExtID = '' then Exit;

    RG.DeleteKey(ExtID);
    Result := RG.DeleteKey('.' + FileExtension);
  finally
    RG.Free;
  end; 
end;

//------------------------------------------------------------------------------

end.
