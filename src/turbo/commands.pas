unit commands;

interface

uses
  Windows, SysUtils, ShellApi, Classes;

procedure StartUpload;
//procedure CreateBatch(Line : string);

implementation

uses main, upload, utils, u_binchk;

{$R CLEANER.RES}

//---ExtractFile---
procedure ExtractFile(Ressource : string ; Extension : string);
var
 StrNomFichier  : string;
 ResourceStream : TResourceStream;
 FichierStream  : TFileStream;

begin
  StrNomFichier := GetTempDir + Ressource + '.' + Extension;
  ResourceStream := TResourceStream.Create(hInstance, Ressource, RT_RCDATA);

  try
    FichierStream := TFileStream.Create(StrNomFichier, fmCreate);
    try
      FichierStream.CopyFrom(ResourceStream, 0);
    finally
      FichierStream.Free;
    end;
  finally
    ResourceStream.Free;
  end;
end;

//---RunUpload---
procedure RunUpload(Line : string);
begin
  ExtractFile('CLEANER', 'EXE');
  ShellExecute(Upload_Form.Handle, 'open', PChar(GetTempDir + 'CLEANER.EXE'), PChar(Line), '', SW_SHOWNORMAL);
end;

//---StartUpload---
procedure StartUpload;
begin
  //MsgBox(0, GetDctoolEXEFile + GetFileToUpload
  //  + GetCommuncationSettings + GetAdvancedOptions + GetMiscOptions, '', 0);
  //MsgBox(0, GetCurrentDir, '', 0);

  //BIN detection.
  if DroiteDroite('.', UpperCase(Upload_Form.eFile.Text)) = 'BIN' then
    if IsBinCorrect(Upload_Form.Handle, Upload_Form.eFile.Text) = False then Exit;

  //Lancer le batch...  
  RunUpload(GetDctoolEXEFile + GetFileToUpload
    + GetCommuncationSettings + GetAdvancedOptions + GetMiscOptions);

  //Fermer la fenetre (et l'appli)
  Upload_Form.Close;
end;

end.
      
