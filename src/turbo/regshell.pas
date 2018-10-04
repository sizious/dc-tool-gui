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

  Unit� RegShell
  ==============

  Description : Unit� permettant d'ajouter un �l�ment au menu contextuel de Windows (en cliquant droit).
                Permet d'ajouter son application � une extension donn�e. On peut sp�cifier le nom de
                l'application, la caption du menu contextuel, la commande � effectuer...
                Si l'extension n'est pas enregistr�e sur le syst�me, elle est automatiquement cr�ee.
                Permet �galement d'enlever le menu contextuel cr�� gr�ce � la fonction, et plus
                g�n�ralement tout menu contextuel de Windows.

  Proc�dures  : - AddContextMenuItem        : Cette fonction ajoute le menu contextuel � Windows.
                                              FileExtension : Extension du fichier cible (sans le point)
                                              ApplicationName : Nom de votre application,
                                              ContextMenuItemCaption : Caption du menu contextuel,
                                              Command : Commande � effectuer lors de la click du menu contextuel.

                - RemoveContextMenuItem     : Retire le menu contextuel associ� � une application et � une
                                              extension.
                                              FileExtension : Extension du fichier cible (sans le point)
                                              ApplicationName : Nom de votre application.

  Auteur      : [big_fury]SiZiOUS (pour les 2 fonctions principales).

  E-mail      : sizious@yahoo.fr

  URL         : http://www.sbibuilder.fr.st

  Remarques   : Un GRAND merci � DevelOpeR13 (http://www.dev-zone.com) pour l'exemple qui m'a mis
                sur la bonne voie, ainsi que les 3 fonctions utilis�es ici, c'est � dire
                SetCreateKey, SetWriteString et GetDeleteKey.
                Librement inspir� de sa FAQ disponible � l'URL suivante :
                http://www.dev-zone.com/faq/bdr/fgbdr_index.php
                L'exemple traitant du sujet est disponible � l'URL suivante :
                http://www.phidels.com/php/index.php3?page=../php/pagetelechargementzip.php3&id=473

                Un grand merci � lui, �galement � tout le monde de Phidels.com.

  TO DO       : Il reste un �l�ment inconnu : Comment ajouter une ic�ne au menu contextuel, � l'image
                de WinZip, WinRAR, WinACE ou encore BitDefender. Je pensais qu'une clef DefaultIcon
                bien plac�e suffirai, je me suis tromp�. Impossible d'en sp�cifier une.
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
      RG.OpenKey('.' + FileExtension, True); //Ouverture en la cr�ant.
      //SetCreateKey(HKEY_CLASSES_ROOT, '', '.' + FileExtension);
      SetWriteString(HKEY_CLASSES_ROOT, '.' + FileExtension, '', FileExtension + 'file');
      ExtID := FileExtension + 'file';
    end else begin
      RG.OpenKey('.' + FileExtension, False); //Ouverture, on la cr�e pas.
      ExtID := RG.ReadString(''); //Lecture de la valeur pour trouver la bonne clef.

      //Update du 3/09 : Si .XXX existe mais pas la valeur chaine qui pointe, elle est cr�e.
      if ExtID = '' then
      begin
        ExtID := FileExtension + 'file';
        SetWriteString(HKEY_CLASSES_ROOT, '.' + FileExtension, '', ExtID);
      end;
    end;

    //Jusqu'a la ca va, on a r�cup�r� l'id de l'extension (qui linke vers le bonne clef).
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
      RG.OpenKey('.' + FileExtension, True); //Ouverture en la cr�ant.
      //SetCreateKey(HKEY_CLASSES_ROOT, '', '.' + FileExtension);
      SetWriteString(HKEY_CLASSES_ROOT, '.' + FileExtension, '', FileExtension + 'file');
      ExtID := FileExtension + 'file';
    end else begin
      RG.OpenKey('.' + FileExtension, False); //Ouverture, on la cr�e pas.
      ExtID := RG.ReadString(''); //Lecture de la valeur pour trouver la bonne clef.
    end;
    //Jusqu'a la ca va, on a r�cup�r� l'id de l'extension (qui linke vers le bonne clef).

    //Puis on efface le menu...
    GetDeleteKey(HKEY_CLASSES_ROOT, ExtID + '\Shell\' + ApplicationName, 'Command');
    GetDeleteKey(HKEY_CLASSES_ROOT, ExtID + '\Shell', ApplicationName);
  finally
    RG.Free;
  end;
end;

end.
