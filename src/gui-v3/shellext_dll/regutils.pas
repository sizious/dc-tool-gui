unit regutils;

interface

uses
  Windows, Registry;
  
function GetExtensionID(var RG : TRegistry ; Extension : string ; Create : boolean) : string;
function GetRealExt(var Extension : string) : string;

implementation

//------------------------------------------------------------------------------

function GetRealExt(var Extension : string) : string;
begin
  if Extension[1] = '.' then
    Result := Copy(Extension, 2, Length(Extension) - 1)
  else Result := Extension;
end;

//------------------------------------------------------------------------------

function GetExtensionID(var RG : TRegistry ; Extension : string ; Create : boolean) : string;
begin
  Result := '';
  if not Assigned(RG) then Exit;

  RG.RootKey := HKEY_CLASSES_ROOT;

  //Ouverture de la clef ".xxx", création s'il n'existe pas
  if not RG.OpenKey('.' + Extension, Create) then Exit;

  Result := RG.ReadString(''); //lire la valeur par défaut, qui contient l'ID de l'extension
  if Result = '' then //il est vide donc l'extension n'existe pas
  begin
    Result := Extension + 'file'; //création de l'ExtID
    RG.WriteString('', Result);   //ecriture dans le registre
  end;
  RG.CloseKey; //on retourne à la clef précédente (HKEY_CLASSES_ROOT)
end;

//------------------------------------------------------------------------------

end.
