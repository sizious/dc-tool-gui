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

  Unit� RegExt
  ============

  Description : Unit� permettant d'enregistrer des types de fichiers, et de les effacer.
                Brid� pour les EXE, DLL, BAT et les COM.
                On peut specifier une ic�ne associ� au type de fichier ainsi qu'une
                description. Par contre on ne peut pas sp�cifier d'application par d�faut...
                ... pas la peine.

  Proc�dures  : - CreateExtension           : Cette fonction cr�e une nouvelle extension. On peut sp�cifier
                                              une description et une icone.

                - DeleteExtension           : Permet d'effacer une extension enregistr� du systeme.
                                              ATTENTION, DANGER !
                                              NE FONCTIONNE PAS POUR LES EXE, DLL, BAT et COM.

  Auteur      : [big_fury]SiZiOUS (pour les 2 fonctions principales).

  E-mail      : sizious@yahoo.fr

  URL         : http://www.sbibuilder.fr.st

  Remarques   : Un GRAND merci � DevelOpeR13 (http://www.dev-zone.com) pour les
                3 fonctions utilis�es ici, c'est � dire SetCreateKey,
                SetWriteString et GetDeleteKey.

                Un grand merci � lui, �galement � tout le monde de Phidels.com.
}

unit regext;

interface

uses
  Windows, SysUtils, Registry;

procedure CreateExtension(FileExtension, FileDescription, IconFileName : string);
function DeleteExtension(FileExtension : string) : boolean;

implementation

//---SetCreateKey---
procedure SetCreateKey(SelectRootKey: HKEY; SelectKey: string; NewKey: string);
begin
  with TRegistry.Create do
    begin
      try
        RootKey := SelectRootKey;
        OpenKey(SelectKey, True);
        if not KeyExists(NewKey) then
          CreateKey(NewKey);
      finally
       Free;
      end;
    end;
end;

//---SetWriteString---
procedure SetWriteString(SelectRootKey: HKEY; SelectKey: string; NewValueName: string; Value: string);
begin
  with TRegistry.Create do
    begin
      try
        RootKey := SelectRootKey;
        OpenKey(SelectKey, True);
        WriteString(NewValueName, Value);
      finally
       Free;
      end;
    end;
end;

//---GetDeleteKey---
function GetDeleteKey(SelectRootKey: HKEY; SelectKey: string; Key: string): Boolean;
begin
  with TRegistry.Create do
    begin
      try
        RootKey := SelectRootKey;
        OpenKey(SelectKey, True);
        Result := DeleteKey(Key);
      finally
       Free;
      end;
    end;
end;

//***FONCTIONS***

//---CreateExtension---
procedure CreateExtension(FileExtension, FileDescription, IconFileName : string);
var
  RG : TRegistry;
  ExtID : string;

begin
  RG := TRegistry.Create;
  try
    ExtID := '';
    RG.RootKey := HKEY_CLASSES_ROOT;

    //***Recuperation de l'ID de l'extension.
    //La clef '.XXX' n'existe pas.
    if RG.KeyExists('.' + FileExtension) = False then
    begin
      RG.OpenKey('.' + FileExtension, True); //Ouverture en la cr�ant.
      //SetCreateKey(HKEY_CLASSES_ROOT, '', '.' + FileExtension);
      SetWriteString(HKEY_CLASSES_ROOT, '.' + FileExtension, '', FileExtension + 'file');
      ExtID := FileExtension + 'file';
    end else begin
      RG.OpenKey('.' + FileExtension, False); //Ouverture, on la cr�e pas.
      ExtID := RG.ReadString(''); //Lecture de la valeur pour trouver la bonne clef.
    end;

    //Jusqu'a la ca va, on a r�cup�r� l'id de l'extension (qui linke vers le bonne clef).
    //ShowMessage(ExtID);

    SetCreateKey(HKEY_CLASSES_ROOT, '', ExtID);
    SetWriteString(HKEY_CLASSES_ROOT, ExtID, '', FileDescription);
    SetCreateKey(HKEY_CLASSES_ROOT, ExtID, 'DefaultIcon');
    SetWriteString(HKEY_CLASSES_ROOT, ExtID + '\DefaultIcon', '', IconFileName);
  finally
    RG.Free;
  end;
end;

//---DeleteExtension---
function DeleteExtension(FileExtension : string) : boolean;
var
  RG : TRegistry;
  ExtID : string;

begin
  Result := False;

  //Extension non autoris�s (system)
  if UpperCase(FileExtension) = 'EXE' then Exit;
  if UpperCase(FileExtension) = 'DLL' then Exit;
  if UpperCase(FileExtension) = 'COM' then Exit;
  if UpperCase(FileExtension) = 'BAT' then Exit;

  RG := TRegistry.Create;
  try
    ExtID := '';
    RG.RootKey := HKEY_CLASSES_ROOT;

    //***Recuperation de l'ID de l'extension.
    //La clef '.XXX' n'existe pas.
    if RG.KeyExists('.' + FileExtension) = False then
    begin
      RG.OpenKey('.' + FileExtension, True); //Ouverture en la cr�ant.
      //SetCreateKey(HKEY_CLASSES_ROOT, '', '.' + FileExtension);
      SetWriteString(HKEY_CLASSES_ROOT, '.' + FileExtension, '', FileExtension + 'file');
      ExtID := FileExtension + 'file';
    end else begin
      RG.OpenKey('.' + FileExtension, False); //Ouverture, on la cr�e pas.
      ExtID := RG.ReadString(''); //Lecture de la valeur pour trouver la bonne clef.
    end;

    //Jusqu'a la ca va, on a r�cup�r� l'id de l'extension (qui linke vers le bonne clef).
    //ShowMessage(ExtID);

    //Effacer le '.xxx' & le 'xxxFILE'
    if GetDeleteKey(HKEY_CLASSES_ROOT, '', ExtID) = True then
      if GetDeleteKey(HKEY_CLASSES_ROOT, '', '.' + FileExtension) = True then
        Result := True
    else Result := False;

  finally
    RG.Free;
  end;
end;

end.
