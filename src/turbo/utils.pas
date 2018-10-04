unit utils;

interface

uses
  Windows, SysUtils;

const
  BBA_LINK_TYPE     : Word = $00;
  SERIAL_LINK_TYPE  : Word = $FF;
  SERIAL_DCTOOL_EXE : string = 'DC-TOOL.EXE';
  BBA_DCTOOL_EXE    : string = 'DC-TOOL-IP.EXE';
  WrapStr           : string = #13 + #10;
  
function MsgBox(Handle : HWND ; Message, Caption : string ; Flags : integer) : integer;
function GetLinkType : Word;
function GetComPort : string;
function GetBaudrate : string;
function GetIP : string;
function GetRealPath(Path : string) : string;
function GetTempDir: String;
function IsInternalUsed : boolean;
function GetDctoolEXEFile : string;
function GetAdvancedOptions : string;
function GetMiscOptions : string;
function GetCommuncationSettings : string;
function GetFileToUpload : string;
function DroiteDroite(substr: string; s: string): string;
function Droite(substr : string ; s: string) : string;
function ValidIP(aIP : string) : boolean;

implementation

uses main, upload;

//---ValidIP---
function ValidIP(aIP : string) : boolean;
{ Détermine si la string passée en paramètre est une adresse IP }
var
    iNb,
    iVal     : Integer;
    bOK : Boolean;
    sTmp,
    sTmpIP : string;

//---GaucheNDroite---
function GaucheNDroite(substr: string; s: string;n:integer): string;
var i:integer;
begin
  S:=S+substr;
  for i:=1 to n do
  begin
    S:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
  end;
  result:=copy(s, 1, pos(substr, s)-1);
end;

//---IsIPFormatted---
function IsIPFormatted(IP : string) : boolean;
begin
  Result := False;
  if Length(GaucheNDroite('.', aIP, 0)) > 3 then Exit;
  if Length(GaucheNDroite('.', aIP, 1)) > 3 then Exit;
  if Length(GaucheNDroite('.', aIP, 2)) > 3 then Exit;
  if Length(GaucheNDroite('.', aIP, 3)) > 3 then Exit;
  Result := True;
end;

begin
    bOK := True;

    //---Si c'est > 3 c'est pas une IP
    if IsIPFormatted(aIP) = False then
    begin
      bOK := False;
      Exit;
    end;

    iNb := 0;
    sTmpIP := aIP;
    repeat
    if Pos( '.', sTmpIP ) > 0 then
    begin
        { Récupération du premier nombre de la chaine sTmpIP }
        sTmp := Copy( sTmpIP, 1, Pos( '.', sTmpIP ) - 1 );
        { on enlève le nombre qui vient d'être lu par sTmp }
        sTmpIP := Copy( sTmpIP, Pos( '.', sTmpIP ) + 1, Length( sTmpIP ) );
    end
    else
    begin
        sTmp := sTmpIP; { Récupération du nombre restant dans la chaine sTmpIP }
        sTmpIP := ''; { Il n'y a plus rien à lire }
    end;

    { Vérification s'il s'agit d'un nombre }
    try
        iVal := StrToInt( sTmp );
        if (iVal > 255) or (iVal < 0) then { Si le nombre > 255 ou < 0, ce n'est pas une adresse IP }
        bOk := False
        else
        inc( iNb ); { Maintenir le compte de chiffres dans la chaine }
    except
        { Si on arrive à cette erreur, il ne s'agit pas d'un nombre }
        on E : EConvertError do bOK := False; 
    end;
    { Boucler jusqu'à ce qu'on passe au travers de la chaine ou qu'il y ait une erreur }
    until ( sTmpIP = '' ) or not bOK;

    { S'il n'y a pas 4 nombres, ce n'est pas une adresse IP }
    if iNb <> 4 then bOK := False;

    Result := bOK;
end;

//---Droite---
function Droite(substr : string ; s: string) : string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

//---DroiteDroite---
function DroiteDroite(substr: string; s: string): string;
begin
  Repeat
    S:=droite(substr,s);
  until pos(substr,s)=0;
  result:=S;
end;

//---MsgBox---
function MsgBox(Handle : HWND ; Message, Caption : string ; Flags : integer) : integer;
begin
  Result := MessageBoxA(Handle, PChar(Message), PChar(Caption), Flags);
end;

//---GetLinkType---
function GetLinkType : Word;
begin
  if Main_Form.rbSerial.Checked = True then
    Result := SERIAL_LINK_TYPE
  else Result := BBA_LINK_TYPE;
end;

//---GetRealPath---
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

//******* COMMUNICATION MANAGER ********

//---GetComPort---
function GetComPort : string;
begin
  if Main_Form.rbCOM1.Checked = True then Result := ' -t COM1';
  if Main_Form.rbCOM2.Checked = True then Result := ' -t COM2';
  if Main_Form.rbCOM3.Checked = True then Result := ' -t COM3';
  if Main_Form.rbCOM4.Checked = True then Result := ' -t COM4';
end;

//---GetBaudrate---
function GetBaudrate : string;
begin
  Result := ' -b ' + Main_Form.eBaudrate.Text;
  if Main_Form.cbAlternate.Checked = True then Result := Result + ' -e';
end;

//---GetIP---
function GetIP : string;
begin
  Result := ' -t ' + Main_Form.eIP.Text;
end;

//---GetCommuncationSettings---
function GetCommuncationSettings : string;
begin

  if GetLinkType = SERIAL_LINK_TYPE then
    Result := GetComPort + GetBaudrate
  else Result := GetIP;

end;

//******* DC-TOOL EXE MANAGER ********

//---GetTempDir---
function GetTempDir: String;
var
  Dossier: array[0..MAX_PATH] of Char;

begin
  Result := '';
  if GetTempPath(SizeOf(Dossier), Dossier)<>0 then Result := StrPas(Dossier);
end;

//---IsInternalUsed---
function IsInternalUsed : boolean;
begin
  if Main_Form.rbInternal.Checked = True then
    Result := True
  else Result := False;
end;

//---GetDctoolEXEFile---
function GetDctoolEXEFile : string;
begin
  if IsInternalUsed = True then
  begin

    //DC-TOOL interne. On regarde le mode (donc le EXE).
    if GetLinkType = SERIAL_LINK_TYPE then
      Result := GetTempDir + SERIAL_DCTOOL_EXE
    else Result := GetTempDir + BBA_DCTOOL_EXE;

    //On sait qu'il est interne. Vu qu'il l'est, on va mettre le dossier Temp
    //de Windows comme dossier de travail, vu que tout est extrait dedant!
    SetCurrentDir(GetTempDir);

  end else begin

    //DC-TOOL externe...
    Result := '"' + Main_Form.eDCTOOL.Text + '"';

    //Cygwin installé, ou DLL seulement?
    //Si installé, on va faire SetCurrentDir le dossier de DC-TOOL.
    //Sinon, on va faire le dossier de Cygwin!
    if DirectoryExists(Main_Form.eCYGWIN.Text) = True then
      SetCurrentDir(Main_Form.eCYGWIN.Text)
    else SetCurrentDir(ExtractFilePath(Main_Form.eDCTOOL.Text));

    //Pas besoin de se servir de GetLinkType, c'est inclu dans le nom de fichier
    //(donc le Serial et BBA/LAN option dans 'Location' ne sert à rien...
    //...en tout cas pour TURBO DC-TOOL GUI.

  end;
end;

//******* ADVANCED OPTIONS MANAGER ********

//---IsAdvancedChRootOptionSelected---
function IsAdvancedChRootOptionSelected : boolean;
begin
  Result := False;

  //Si le dossier existe pas, on décoche l'option
  if Upload_Form.cbChroot.Checked = True then
  begin
    if DirectoryExists(Upload_Form.eChroot.Text) = False then
    begin
      Upload_Form.cbChroot.Checked := False;
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
  if Upload_Form.cbISO.Checked = True then
  begin
    if FileExists(Upload_Form.eISO.Text) = False then
    begin
      Upload_Form.cbISO.Checked := False;
      Exit;
    end;

    Result := True;
  end;
end;

//---GetAdvancedOptions---
function GetAdvancedOptions : string;
begin
  Result := '';

  //Si ChRoot sélectionné
  if IsAdvancedChRootOptionSelected = True then
    if DirectoryExists(Upload_Form.eChroot.Text) = True then
      Result := Result + ' -c "' + Upload_Form.eChroot.Text + '"';

  //Si ISO sélectionné
  if IsAdvancedISOOptionSelected = True then
    if FileExists(Upload_Form.eISO.Text) = True then
      Result := Result + ' -i "' + Upload_Form.eISO.Text + '"';
end;

//---GetMiscOptions---
function GetMiscOptions : string;
var
  CommandLine : string;

begin
  CommandLine := '';
  if Upload_Form.cbDoNotAttachConsole.Checked = True then
    CommandLine := CommandLine + ' -n';

  if Upload_Form.cbDoNotClearScreen.Checked = True then
    CommandLine := CommandLine + ' -q';

  if Upload_Form.cbUseDumbTerminal.Enabled = True then
    if Upload_Form.cbUseDumbTerminal.Checked = True then
      CommandLine := CommandLine + ' -p';

  Result := CommandLine;
end;

//******* UPLOAD FILE MANAGER ********

//---GetFileToUpload---
function GetFileToUpload : string;
begin
  Result := ' -x "' + Upload_Form.eFile.Text + '"';
end;

end.
