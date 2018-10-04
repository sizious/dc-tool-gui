{
  Unit : u_binchk
  By   : [big_fury]SiZiOUS
  For  : DC-TOOL GUI v1.2
  Notes: Permet de g�rer les BIN Scrambled (car ils ne marchent pas avec DC-LOAD).

         * Dans CHAQUES fonction correspondante � un radio button,
           Chaque result = False arr�te la proc�dure en cours !
         * Result = True CONTINUE la proc�dure!
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

uses binchk, utils, tools, main;

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
  if BinCheck_Form.rbDoNotUseThis.Checked = True then Exit;
  Result := True;
end;

{ //---ResetUnscrambledFileName---
//Effacer le nom du BIN.
procedure ResetUnscrambledFileName;
begin
  UNSCRAMBLED_BIN_LOCATION := '';
end;

//---GetUnscrambledFileName---
//Avoir le nom du Bin unscrambled.
function GetUnscrambledFileName : string;
begin
  Result := UNSCRAMBLED_BIN_LOCATION;
end;

//---SetUnscrambledBIN---
procedure SetUnscrambledBIN(FileName : string);
begin
  UNSCRAMBLED_BIN_LOCATION := FileName;
end;   }

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
  Ext := Droite('.', Source); //On met pas DroiteDroite, parce que sinon le fichier existe d�j�. (au cas ou).
  TargetFile := ChangeFileExt(Source, '.Scrambled.' + Ext);
  RenameFile(Source, TargetFile);

  if UnscrambleFile(PChar(TargetFile), PChar(Source)) = False then
  begin
    //SetUnscrambledBIN(Destination)
  //else begin
    MsgBox(Handle, ErrorWhenUnscramblingTheBINAborted, ErrorCaption, 48);
    Result := False;
    Exit;
  end;
  
end;

//---AskOnlyBeforeUnscrambling---
function AskOnlyBeforeUnscrambling(Handle : HWND ; FileName : string) : boolean;
{
  Bon alors cette fonction est chelou :
  D�j�, si on fait IsFileScrambled(PChar(FileName)) = False, ca plante. (il dit tout SCRAMBLED).
  On est oblig� de faire 'True'.
  Apres, impossible d'afficher avec ShowMessage la valeur de IsFileScrambled, et ceci meme avec
  une variable interm�diaire!

  Donc la, la fonction marche, mais chelousement :)
}

var
  CanDo           : integer;

begin
  Result := True; //Le BIN est consid�r� comme correct !

  //Le BIN EST SCRAMBLED ON DOIT LE CONVERTIR
  if IsFileScrambled(PChar(FileName)) = True then
  begin
    Result := False; //Le BIN est consid�r� comme incorrect !

    //Unscrambler le bin...
    CanDo := MsgBox(Handle, TheBinIsScrambledUnscrambleIt, QuestionCaption, 32 + MB_YESNO);
    if CanDo = IDNO then
    begin
      CanDo := MsgBox(Handle, UploadAnyway, ErrorCaption, 48 + MB_YESNO + MB_DEFBUTTON2);
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
  CanDo := MsgBox(Handle, UploadThisScrambledFileNotRecommended + WrapStr
    + WarningDCLOADCanCrashAfterExecutingThisFile, WarningCaption, 48 + MB_YESNO + MB_DEFBUTTON2);
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

    CanDo :=  MsgBox(Handle, TheBinWasDetected + ' ' + Scrambled + WrapStr + YouMustUnscrambleIt + ' ' + DoYouAgree, QuestionCaption, 32 + MB_YESNOCANCEL);
    if CanDo = IDCANCEL then
    begin
      Result := False;
      Exit; //annul�
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

    CanDo :=  MsgBox(Handle, TheBinWasDetected + ' ' + Unscrambled + WrapStr + TheFileIsCorrect + ' ' + DoYouAgree, QuestionCaption, 32 + MB_YESNOCANCEL);
    if CanDo = IDCANCEL then
    begin
      Result := False;   //Chaque result = false arr�te la proc�dure !
      Exit; //annul� (on fait rien).
    end;

    case CanDo of
      IDYES    : Exit; //L'utilisateur clique sur OUI, il reconnait que le BIN est UNSCRAMBLED. (OK!)
      IDNO     : begin //L'utilisateur clique sur NON, il va unscrambler un BIN dit comme scrambl�. (Quel t�tu!)
                    CanDo := MsgBox(Handle, AreYouSureToUnscrambleTheFileAndRenameThisFileasScrambledBin + WrapStr + WarningThisIsNotRecommendedClickOnTheNoButtonToUploadTheFile, ErrorCaption, 48 + MB_DEFBUTTON2 + MB_YESNOCANCEL);

                    if CanDo = IDCANCEL then //Il a annul� ! donc on ne fait rien !
                    begin
                      Result := False;
                      Exit; //annul� (on fait rien).
                    end;

                    if CanDo = IDNO then Exit; //Derni�re chance, il a r�pondu non : oui j'ai toujours raison :)
                    if UnscrambleBIN(Handle, FileName) = False then Exit; //Bah il est t�tu cet utilisateur ! bon bah on unscramble quand m�me ! du coup le fichier unscrambl� sera marqu� comme scrambled,
                 end; //et le v�ritable fichier d'origine sera surement scrambled lui par contre!

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
  if Ini.ReadBool('BIN Check Module', 'DoNotUseThis', False) = True then Exit;

  //AddDebug('STATE:> BIN Check Module Detection : Detection in progress...');
  
  //Si le BIN est scrambl�, on demande de le descrambler.
  //if BinCheck_Form.rbAskOnlyBeforeUnscrambling.Checked = True then
  if Ini.ReadBool('BIN Check Module', 'AskOnlyBeforeUnscrambling', True) = True then
    Result := AskOnlyBeforeUnscrambling(Handle, FileName);

  //On demande la confirmation de la detection.
  //if BinCheck_Form.rbAskAlways.Checked = True then
  if Ini.ReadBool('BIN Check Module', 'AskAlways', False) = True then
    Result := AskAlways(Handle, FileName);

  //On demande jamais et on unscramble automatiquement.
  //if BinCheck_Form.rbDoNotAskAnyThing.Checked = True then
  if Ini.ReadBool('BIN Check Module', 'DoNotAskAnyThing', False) = True then
    Result := DoNotAskAnyThing(Handle, FileName);
end;

end.
