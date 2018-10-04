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

  Unité RegShell
  ==============

  Description : Unité permettant d'ajouter un élément au menu contextuel de Windows (en cliquant droit).
                Permet d'ajouter son application à une extension donnée. On peut spécifier le nom de
                l'application, la caption du menu contextuel, la commande à effectuer...
                Si l'extension n'est pas enregistrée sur le système, elle est automatiquement créee.
                Permet également d'enlever le menu contextuel créé grâce à la fonction, et plus
                généralement tout menu contextuel de Windows.

  Procédures  : - AddContextMenuItem        : Cette fonction ajoute le menu contextuel à Windows.
                                              FileExtension : Extension du fichier cible (sans le point)
                                              ApplicationName : Nom de votre application,
                                              ContextMenuItemCaption : Caption du menu contextuel,
                                              Command : Commande à effectuer lors de la click du menu contextuel.

                - RemoveContextMenuItem     : Retire le menu contextuel associé à une application et à une
                                              extension.
                                              FileExtension : Extension du fichier cible (sans le point)
                                              ApplicationName : Nom de votre application.

  Auteur      : [big_fury]SiZiOUS (pour les 2 fonctions principales).

  E-mail      : sizious@yahoo.fr

  URL         : http://www.sbibuilder.fr.st

  Remarques   : Un GRAND merci à DevelOpeR13 (http://www.dev-zone.com) pour l'exemple qui m'a mis
                sur la bonne voie, ainsi que les 3 fonctions utilisées ici, c'est à dire
                SetCreateKey, SetWriteString et GetDeleteKey.
                Librement inspiré de sa FAQ disponible à l'URL suivante :
                http://www.dev-zone.com/faq/bdr/fgbdr_index.php
                L'exemple traitant du sujet est disponible à l'URL suivante :
                http://www.phidels.com/php/index.php3?page=../php/pagetelechargementzip.php3&id=473

                Un grand merci à lui, également à tout le monde de Phidels.com.

  TO DO       : Il reste un élément inconnu : Comment ajouter une icône au menu contextuel, à l'image
                de WinZip, WinRAR, WinACE ou encore BitDefender. Je pensais qu'une clef DefaultIcon
                bien placée suffirai, je me suis trompé. Impossible d'en spécifier une.
}

unit regshell;

interface

uses
  Windows, Registry;

procedure AddContextMenuItem(FileExtension, ApplicationName, ContextMenuItemCaption, Command : string);
procedure RemoveContextMenuItem(FileExtension, ApplicationName : string);

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

//****FONCTIONS****

//---AddContextMenuItem---
procedure AddContextMenuItem(FileExtension, ApplicationName, ContextMenuItemCaption, Command : string);
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
      RG.OpenKey('.' + FileExtension, True); //Ouverture en la créant.
      //SetCreateKey(HKEY_CLASSES_ROOT, '', '.' + FileExtension);
      SetWriteString(HKEY_CLASSES_ROOT, '.' + FileExtension, '', FileExtension + 'file');
      ExtID := FileExtension + 'file';
    end else begin
      RG.OpenKey('.' + FileExtension, False); //Ouverture, on la crée pas.
      ExtID := RG.ReadString(''); //Lecture de la valeur pour trouver la bonne clef.

      //Update du 3/09 : Si .XXX existe mais pas la valeur chaine qui pointe, elle est crée.
      if ExtID = '' then
      begin
        ExtID := FileExtension + 'file';
        SetWriteString(HKEY_CLASSES_ROOT, '.' + FileExtension, '', ExtID);
      end;
    end;

    //Jusqu'a la ca va, on a récupéré l'id de l'extension (qui linke vers le bonne clef).
    //ShowMessage(ExtID);
    SetCreateKey(HKEY_CLASSES_ROOT, '', ExtID);
    SetCreateKey(HKEY_CLASSES_ROOT, ExtID, 'Shell');
    SetCreateKey(HKEY_CLASSES_ROOT, ExtID + '\Shell', ApplicationName);
    SetWriteString(HKEY_CLASSES_ROOT, ExtID + '\Shell\' + ApplicationName, '', ContextMenuItemCaption);
    SetCreateKey(HKEY_CLASSES_ROOT, ExtID + '\Shell\' + ApplicationName, 'Command');
    SetWriteString(HKEY_CLASSES_ROOT, ExtID + '\Shell\' + ApplicationName
      + '\Command', '', Command);
  finally
    RG.Free;
  end;
end;

//---RemoveContextMenuItem---
procedure RemoveContextMenuItem(FileExtension, ApplicationName : string);
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
      RG.OpenKey('.' + FileExtension, True); //Ouverture en la créant.
      //SetCreateKey(HKEY_CLASSES_ROOT, '', '.' + FileExtension);
      SetWriteString(HKEY_CLASSES_ROOT, '.' + FileExtension, '', FileExtension + 'file');
      ExtID := FileExtension + 'file';
    end else begin
      RG.OpenKey('.' + FileExtension, False); //Ouverture, on la crée pas.
      ExtID := RG.ReadString(''); //Lecture de la valeur pour trouver la bonne clef.
    end;
    //Jusqu'a la ca va, on a récupéré l'id de l'extension (qui linke vers le bonne clef).

    //Puis on efface le menu...
    GetDeleteKey(HKEY_CLASSES_ROOT, ExtID + '\Shell\' + ApplicationName, 'Command');
    GetDeleteKey(HKEY_CLASSES_ROOT, ExtID + '\Shell', ApplicationName);
  finally
    RG.Free;
  end;
end;

end.
