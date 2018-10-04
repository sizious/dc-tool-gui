{
    :: D C - T O O L  G U I::

    Version 3.0
    11/07/05

    BINCHECK.DLL module implementation.
}

unit u_dctool_binchk;

interface

uses
  Windows, SysUtils, DCTool;

const wrapstr = #13 + #10;

type
  TBinCheckMode = (bmAskIfNeeded, bmAskAlways, bmAskNever, bmDisable);

function DoBinCheckSequence(Mode : TBinCheckMode ; MsgBoxHwd : HWND
  ; DcToolTarget : string) : boolean;

implementation

type
  TBinOperationType = (otScramble, otUnscramble);

var
  FFileName : string = '';

function IsFileScrambled(FileName : PChar) : boolean ; stdcall; external 'bincheck.dll';
function ScrambleFile(Source, Destination : PChar) : boolean ; stdcall ; external 'bincheck.dll';
function UnscrambleFile(Source, Destination : PChar) : boolean ; stdcall ; external 'bincheck.dll';

function GenerateRenamedFileName(ScrambleText : string): string;
begin
  Result := ChangeFileExt(FFileName, '.' + ScrambleText + '.bin');
end;

function GetOriginalFile(Operation : TBinOperationType) : string;
var
  opstr : string;

begin
  //Pourquoi l'inverse ?
  //Tout simplement parce que lorsque le fichier est scrambled et que cette fonction
  //est appellée, c'est pour l'unscrambler. Donc c'est l'inverse des flags.
  //Si le mec appelle Scramble et que le fichier d'origine etait déjà scrambled,
  //bah il est con... et on s'en fout. (en fait c'est ma fonction IsScrambled
  //qui doit appeller ça...).
  case Operation of
    otScramble    : opstr := 'unscrambled';
    otUnscramble  : opstr := 'scrambled';
  end;

  opstr := GenerateRenamedFileName(opstr);
  if FileExists(opstr) then DeleteFile(opstr); //un vieux fichier qu'on a généré... on le vire
  RenameFile(FFileName, opstr); //on va renommer le fichier original
  Result := opstr;  //renvoie le nom du fichier original renommé.
end;

function IsScrambled : boolean;
begin
  Result := IsFileScrambled(PChar(FFileName));
end;

function Scramble : boolean;
begin
  Result := ScrambleFile(PChar(GetOriginalFile(otScramble)), PChar(FFileName));
end;

function Unscramble : boolean;
begin
  Result := UnscrambleFile(PChar(GetOriginalFile(otUnscramble)), PChar(FFileName));
end;

function msgbox(handle : hwnd ; msg, caption : string ; flags : integer) : integer;
begin
  result := messageboxa(handle, pchar(msg), pchar(caption), flags);
end;

//------------------------------------------------------------------------------

function AskUnscrambled(MsgBoxHwd : HWND) : boolean;
var
  rep : integer;
  
begin
  Result := False; //false veut dire on arrête tout
  
  rep := MsgBox(MsgBoxHwd, 'The BIN was detected : UNSCRAMBLED.'
          + WrapStr + 'The file''s correct. Do you agree ?', 'BIN Check module',
            32 + MB_YESNOCANCEL);

  //Choix multiple
  case rep of
    IDCANCEL  : Exit; //ok on sort (annulé)

    IDYES     : begin
                  Result := True;
                  Exit; //on sort et on continue le processus normal...
                end;
    IDNO      : begin //nouvelle question...
                  rep := MsgBox(MsgBoxHwd, 'Are you sure to unscramble the file'
                          + ' and rename the original to ''.scrambled.bin'' ?' + WrapStr
                          + 'WARNING : This isn''t recommended ! If you click '
                          + 'the ''No'' button it''ll continue the process.',
                          'BIN Check module | Warning', 48 + MB_YESNOCANCEL);

                  case rep of
                    IDCANCEL  : Exit; //annulé...
                    IDNO      : begin
                                  Result := True; //procédure normale...
                                  Exit;
                                end;
                    IDYES     : begin
                                  Unscramble;
                                  Result := True;
                                  Exit;
                                end;
                  end;
                end;
    end;
end;

//------------------------------------------------------------------------------

function AskScrambled(MsgBoxHwd : HWND) : boolean;
var
  rep : integer;

begin
  Result := False;

  rep := MsgBox(MsgBoxHwd, 'The BIN was detected : SCRAMBLED.'
          + WrapStr + 'You must unscramble it. Do you agree ?', 'BIN Check module',
            32 + MB_YESNOCANCEL);

  //Choix multiple
  case rep of
    IDCANCEL  : Exit; //ok on sort (annulé)

    IDYES     : begin
                  Unscramble;
                  Result := True;
                  Exit; //on sort et on continue le processus normal...
                end;
    IDNO      : begin //nouvelle question...
                  rep := MsgBox(MsgBoxHwd, 'Upload this ''scrambled'' file'
                          + ' (not recommended) ?' + WrapStr + 'WARNING : '
                          + 'DC-LOAD can crash after executing this file.',
                          'BIN Check module | Warning', 48 + MB_YESNO);

                  case rep of
                    IDNO      : Exit; //annulé

                    IDYES     : begin
                                  Result := True;
                                  Exit;
                                end;
                  end;
                end;
    end;
end;

function AskAlways(MsgBoxHwd : HWND ; Scrambled : boolean) : boolean;
begin
  if Scrambled then
    Result := AskScrambled(MsgBoxHwd)
  else Result := AskUnscrambled(MsgBoxHwd);
end;

//------------------------------------------------------------------------------

function DoBinCheckSequence(Mode : TBinCheckMode ;
  MsgBoxHwd : HWND ; DcToolTarget : string) : boolean;
var
  Scrambled : boolean;
  rep : integer;

begin
  Result := True; //par défaut c'est OK

  if Mode = bmDisable then Exit; //on veut pas du Bin Check
  Result := False;

  FFileName := DcToolTarget;

  Scrambled := IsScrambled;  //Vérifions...

  if Mode = bmAskAlways then
  begin
    Result := AskAlways(MsgboxHwd, Scrambled);
    Exit;
  end;

  if Scrambled then
    begin
      if Mode = bmAskIfNeeded then
      begin
        rep := MsgBox(MsgBoxHwd, 'The BIN is scrambled. Unscramble it ?',
          'Bin Check module', 32 + MB_YESNOCANCEL);

        case rep of
          IDCANCEL  : Exit;
          IDNO      : begin
                        rep := MsgBox(MsgBoxHwd, 'Upload anyway ?',
                        'BIN Check module | Warning', 48 + MB_YESNO);
                        if rep = IDNO then Exit;
                        Result := True;
                        Exit;
                      end;
        end;
      end;

      //IDYES ou BinCheck.Mode = bmAskNever
      Unscramble;
      Result := True;
    end

  else

    Result := True; //bah oui quand même si le bin est unscrambled !

end;

end.
