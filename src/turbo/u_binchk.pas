{
  Unit : u_binchk
  By   : [big_fury]SiZiOUS
  For  : DC-TOOL GUI v1.2
  Notes: Permet de gérer les BIN Scrambled (car ils ne marchent pas avec DC-LOAD).

         * Dans CHAQUES fonction correspondante à un radio button,
           Chaque result = False arrête la procédure en cours !
         * Result = True CONTINUE la procédure!
}

unit u_binchk;

interface

uses
  Windows, SysUtils;

function IsBinCorrect(Handle : HWND ; FileName : string) : boolean;
{ function GetUnscrambledFileName : string;
procedure ResetUnscrambledFileName; }
function IsBinModuleUsed : boolean;

implementation

uses utils, main;

var
  UNSCRAMBLED_BIN_LOCATION : string = '';
  
function IsFileScrambled(FileName : PChar) : boolean ; stdcall; external 'bincheck.dll';
function ScrambleFile(Source, Destination : PChar) : boolean ; stdcall ; external 'bincheck.dll';
function UnscrambleFile(Source, Destination : PChar) : boolean ; stdcall ; external 'bincheck.dll';

//---IsBinModuleUsed---
//Cette fonction permet de savoir si on utilise l'unit.
function IsBinModuleUsed : boolean;
begin
  Result := False;
  if Main_Form.rbDontUseThisModule.Checked = True then Exit;
  Result := True;
end;

//---UnscrambleBIN---
//Cette fonction renomme le file d'origine, et l'unscramble puis le remplace.
function UnscrambleBIN(Handle : HWND ; Source : string) : boolean;
var
  Ext, TargetFile : string;

begin
  Result := True;
  //ResetUnscrambledFileName;
  //if FileExists(Destination) = True then DeleteFile(Destination);

  //Finalement on va renommer le fichier... moins prise de tete.
  Ext := Droite('.', Source); //On met pas DroiteDroite, parce que sinon le fichier existe déjà. (au cas ou).
  TargetFile := ChangeFileExt(Source, '.Scrambled.' + Ext);
  RenameFile(Source, TargetFile);

  if UnscrambleFile(PChar(TargetFile), PChar(Source)) = False then
  begin
    //SetUnscrambledBIN(Destination)
  //else begin
    MsgBox(Handle, 'Error when unscrambling the BIN. Aborted.', 'Error', 48);
    Result := False;
    Exit;
  end;
  
end;

//---AskOnlyBeforeUnscrambling---
function AskOnlyBeforeUnscrambling(Handle : HWND ; FileName : string) : boolean;
{
  Bon alors cette fonction est chelou :
  Déjà, si on fait IsFileScrambled(PChar(FileName)) = False, ca plante. (il dit tout SCRAMBLED).
  On est obligé de faire 'True'.
  Apres, impossible d'afficher avec ShowMessage la valeur de IsFileScrambled, et ceci meme avec
  une variable intermédiaire!

  Donc la, la fonction marche, mais chelousement :)
}

var
  CanDo           : integer;

begin
  Result := True; //Le BIN est considéré comme correct !

  //Le BIN EST SCRAMBLED ON DOIT LE CONVERTIR
  if IsFileScrambled(PChar(FileName)) = True then
  begin
    Result := False; //Le BIN est considéré comme incorrect !

    //Unscrambler le bin...
    CanDo := MsgBox(Handle, 'The BIN is scrambled. Unscramble it ?', 'Question', 32 + MB_YESNO);
    if CanDo = IDNO then
    begin
      CanDo := MsgBox(Handle, 'Upload anyway ?', 'Error', 48 + MB_YESNO + MB_DEFBUTTON2);
      if CanDo = IDNO then Exit
      else begin
        Result := True;  //BIN Correct
        Exit;
      end;
    end;

    if UnscrambleBIN(Handle, FileName) = False then Exit;
    Result := True;  //BIN correct!
  end;

  //ShowMessage(BoolToStr(IsFileScrambled(PChar(FileName)))); //Et voila un beau access violation...
end;

//---AskAlways---
function AskAlways(Handle : HWND ; FileName : string) : boolean;

//***UPLOAD IT***
function PromptUploadIt : boolean;
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, 'Upload this scrambled file isn''t recommended. Continue ?' + WrapStr
    + 'Warning : DC-LOAD can crash after executing this file.', 'Warning', 48 + MB_YESNO + MB_DEFBUTTON2);
  if CanDo = IDNO then
  begin
    Result := False;
    Exit;
  end;

  Result := True;
end;

//***MAIN***
var
  CanDo : integer;
  //Target: string;
  
begin
  Result := True; //BIN correct !
  //Target := GetTempDir + ExtractFileName(FileName);

  if IsFileScrambled(PChar(FileName)) = True then  //BIN SCRAMBLED
  begin

    CanDo :=  MsgBox(Handle, 'The BIN was detected : SCRAMBLED.' + WrapStr + 'You must unscramble it.' + ' ' + 'Do you agree ?', 'Question', 32 + MB_YESNOCANCEL);
    if CanDo = IDCANCEL then
    begin
      Result := False;
      Exit; //annulé
    end;

    case CanDo of
      IDYES    : if UnscrambleBIN(Handle, FileName) = False then Exit;
      IDNO     : if PromptUploadIt = False then
                 begin
                   Result := False;
                   Exit;
                 end;
    end;

  end else begin  //BIN UNSCRAMBLED

    CanDo :=  MsgBox(Handle, 'The BIN was detected : UNSCRAMBLED.' + WrapStr + 'The file is correct.' + ' ' + 'Do you agree ?', 'Question', 32 + MB_YESNOCANCEL);
    if CanDo = IDCANCEL then
    begin
      Result := False;   //Chaque result = false arrête la procédure !
      Exit; //annulé (on fait rien).
    end;

    case CanDo of
      IDYES    : Exit; //L'utilisateur clique sur OUI, il reconnait que le BIN est UNSCRAMBLED. (OK!)
      IDNO     : begin //L'utilisateur clique sur NON, il va unscrambler un BIN dit comme scramblé. (Quel tétu!)
                    CanDo := MsgBox(Handle, 'Are you sure to unscramble the file and rename this file as scrambled file ?' + WrapStr + 'Warning : This isn''t recommended. Click on the No button to upload the file.', 'Error', 48 + MB_DEFBUTTON2 + MB_YESNOCANCEL);

                    if CanDo = IDCANCEL then //Il a annulé ! donc on ne fait rien !
                    begin
                      Result := False;
                      Exit; //annulé (on fait rien).
                    end;

                    if CanDo = IDNO then Exit; //Dernière chance, il a répondu non : oui j'ai toujours raison :)
                    if UnscrambleBIN(Handle, FileName) = False then Exit; //Bah il est tétu cet utilisateur ! bon bah on unscramble quand même ! du coup le fichier unscramblé sera marqué comme scrambled,
                 end; //et le véritable fichier d'origine sera surement scrambled lui par contre!

    end;
    
  end;
end;

//DoNotAskAnyThing
function DoNotAskAnyThing(Handle : HWND ; FileName : string) : boolean;
//var
  //Target : string;

begin
  Result := True;
  if IsFileScrambled(PChar(FileName)) = True then
    Result := UnscrambleBIN(Handle, FileName);
end;

//---CheckTheBIN---
function IsBinCorrect(Handle : HWND ; FileName : string) : boolean;
begin
  Result := True;

{  if IsFileScrambled(PChar(FileName)) = True then
    ShowMessage('SCRAMBLED')
  else ShowMessage('UNSCRAMBLED'); } 

  //On se casse si on veut pas utiliser ce module...
  //if BinCheck_Form.rbDoNotUseThis.Checked = True then Exit;
  if Ini.ReadBool('BIN Detection', 'DontUseThisModule', False) = True then Exit;

  //AddDebug('STATE:> BIN Check Module Detection : Detection in progress...');
  
  //Si le BIN est scramblé, on demande de le descrambler.
  //if BinCheck_Form.rbAskOnlyBeforeUnscrambling.Checked = True then
  if Ini.ReadBool('BIN Detection', 'AskOnlyIfScrambled', True) = True then
    Result := AskOnlyBeforeUnscrambling(Handle, FileName);

  //On demande la confirmation de la detection.
  //if BinCheck_Form.rbAskAlways.Checked = True then
  if Ini.ReadBool('BIN Detection', 'AlwaysConfirmDetectionResult', False) = True then
    Result := AskAlways(Handle, FileName);

  //On demande jamais et on unscramble automatiquement.
  //if BinCheck_Form.rbDoNotAskAnyThing.Checked = True then
  if Ini.ReadBool('BIN Detection', 'UnscrambleWithoutPrompt', False) = True then
    Result := DoNotAskAnyThing(Handle, FileName);
end;

end.
