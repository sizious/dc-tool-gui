{
  Unit U_Advanced : Gère les options avancées, en les mettant toutes dans la
                    commande PutAdvancedCommandLine.
                    C'est à dire que PutAdvancedCommandLine va contenir toutes
                    les informations lorsque des options avancées sont sélectionnées.

                    Exemple : si cbChRoot est sélectionnée, PutAdvancedCommandLine
                    va contenir : ' -c "<contenu du edit Chroot>".

  For DC-TOOL GUI v1.2
  by [big_fury]SiZiOUS
}

unit u_advanced;

interface

uses
  Windows, SysUtils, FileCtrl;

function PutAdvancedCommandLine : string;
function PutMiniAdvancedCommandLine : string;

implementation

uses main, advanced, upload;

//---IsAdvancedChRootOptionSelected---
function IsAdvancedChRootOptionSelected : boolean;
begin
  Result := False;

  //Si le dossier existe pas, on décoche l'option
  if Advanced_Form.cbChroot.Checked = True then
  begin
    if DirectoryExists(Advanced_Form.eChroot.Text) = False then
    begin
      Advanced_Form.cbChroot.Checked := False;
      Exit;
    end;

    Result := True;
  end;
end;

//---IsAdvancedISOOptionSelected---
function IsAdvancedISOOptionSelected : boolean;
begin
  Result := False;

  //Si le fichier existe pas, on decoche l'option
  if Advanced_Form.cbISO.Checked = True then
  begin
    if FileExists(Advanced_Form.eISO.Text) = False then
    begin
      Advanced_Form.cbISO.Checked := False;
      Exit;
    end;

    Result := True;
  end;
end;

//---PutAdvancedCommandLine---
function PutAdvancedCommandLine : string;
begin
  Result := '';

  //Si ChRoot sélectionné
  if IsAdvancedChRootOptionSelected = True then
    if DirectoryExists(Advanced_Form.eChroot.Text) = True then
      Result := Result + ' -c "' + Advanced_Form.eChroot.Text + '"';

  //Si ISO sélectionné
  if IsAdvancedISOOptionSelected = True then
    if FileExists(Advanced_Form.eISO.Text) = True then
      Result := Result + ' -i "' + Advanced_Form.eISO.Text + '"';
end;

//---PutMiniAdvancedCommandLine---
function PutMiniAdvancedCommandLine : string;
begin
  Result := '';

  //Si ChRoot sélectionné
  if IsAdvancedChRootOptionSelected = True then
    if DirectoryExists(Advanced_Form.eChroot.Text) = True then
      Result := Result + ' -c "' + MinimizeName(Advanced_Form.eChroot.Text,
        Upload_Form.FileName_Label.Canvas, 200) + '"';



  //Si ISO sélectionné
  if IsAdvancedISOOptionSelected = True then
    if FileExists(Advanced_Form.eISO.Text) = True then
      Result := Result + ' -i "' + MinimizeName(Advanced_Form.eISO.Text,
        Upload_Form.FileName_Label.Canvas, 200) + '"';
end;

end.
