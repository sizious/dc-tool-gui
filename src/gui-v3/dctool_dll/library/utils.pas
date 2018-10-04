unit utils;

interface

uses
  Windows, SysUtils, Classes;

function GetTempDir: string;
procedure ExtractFile(Ressource : string ; const FileName : string);
function GetRealPath(Path : string) : string;
procedure DeleteDir(TheFolder : string);

implementation

//---GetRealPath---
//Corriger les defauts des paths... du genre "C:\\ACXC\\\\AAA\"...
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

//---GetTempDir---
function GetTempDir: string;
var
  Dossier : array[0..MAX_PATH] of Char;

begin
  Result := '';
  if GetTempPath(SizeOf(Dossier), Dossier) <> 0 then Result := StrPas(Dossier);
  Result := GetRealPath(Result);
end;

//---ExtractFile---
procedure ExtractFile(Ressource : string ; const FileName : string);
var
  ResourceStream : TResourceStream;
  FichierStream  : TFileStream;

begin
  ResourceStream := TResourceStream.Create(hInstance, Ressource, RT_RCDATA);
  try

    FichierStream := TFileStream.Create(FileName, fmCreate);
    try
      FichierStream.CopyFrom(ResourceStream, 0);
    finally
      FichierStream.Free;
    end;

  finally
    ResourceStream.Free;
  end;
end;

//---DeleteDir---
procedure DeleteDir(TheFolder : string);
var
  aResult : Integer;
  aSearchRec : TSearchRec;

begin
  if TheFolder = '' then Exit;
  if TheFolder[Length(TheFolder)] <> '\' then TheFolder := TheFolder + '\';
  aResult := FindFirst(TheFolder + '*.*', faAnyFile, aSearchRec);
  while aResult=0 do
  begin
    if ((aSearchRec.Attr and faDirectory)<=0) then
    begin
      try
        if (FileGetAttr(TheFolder+aSearchRec.Name) and faReadOnly) > 0 then FileSetAttr(TheFolder+aSearchRec.Name, FileGetAttr(TheFolder+aSearchRec.Name) xor faReadOnly);
        //if FileGetAttr(TheFolder) > 0 then FileSetAttr(TheFolder, faAnyFile);
        DeleteFile(TheFolder+aSearchRec.Name)
      except
      end;
    end
    else
    begin
      try
        if aSearchRec.Name[1]<>'.' then   // pas le repertoire '.' et '..'sinon on tourne en rond
        begin
          DeleteDir(TheFolder+aSearchRec.Name); // vide les sous-repertoires de facon recursive
          RemoveDir(TheFolder+aSearchRec.Name);
        end;
      except // exception silencieuse si ne peut détrure le fichier car il est en cours d'utilisation : sera détruit la fois prochaine....
      end;
    end;
    aResult:=FindNext(aSearchRec);
  end;
  FindClose(aSearchRec); // libération de aSearchRec
  if DirectoryExists(TheFolder) = True then RemoveDir(TheFolder);
end;

end.
