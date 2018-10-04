{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

Code template generated with SynGen.
The original code is: SynDcTool.pas, released 2005-10-02.
Description: Syntax Parser/Highlighter
The initial author of this file is SiZiOUS.
Copyright (c) 2005, all rights reserved.

Contributors to the SynEdit and mwEdit projects are listed in the
Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

-------------------------------------------------------------------------------}

unit SynDcTool;

{$I SynEdit.inc}

interface

uses
{$IFDEF SYN_CLX}
  QGraphics,
  QSynEditTypes,
  QSynEditHighlighter,
{$ELSE}
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
{$ENDIF}
  SysUtils,
  Classes;

type
  TtkTokenKind = (
    tkDevices,
    tkFailures,
    tkGeneralFailure,
    tkIdentifier,
    tkKey,
    tkNull,
    tkSpace,
    tkString,
    tkUnknown);

  TRangeState = (rsUnKnown, rsFailureComment, rsString);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of object;

const
  MaxKey = 224;

type
  TSynDcToolSyn = class(TSynCustomHighlighter)
  private
    fLineRef: string;
    fLine: PChar;
    fLineNumber: Integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    fRange: TRangeState;
    Run: LongInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    fTokenID: TtkTokenKind;
    fIdentFuncTable: array[0 .. MaxKey] of TIdentFuncTableFunc;
    fDevicesAttri: TSynHighlighterAttributes;
    fFailuresAttri: TSynHighlighterAttributes;
    fGeneralFailureAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: string): Boolean;
    function Func19: TtkTokenKind;
    function Func28: TtkTokenKind;
    function Func30: TtkTokenKind;
    function Func31: TtkTokenKind;
    function Func32: TtkTokenKind;
    function Func37: TtkTokenKind;
    function Func41: TtkTokenKind;
    function Func43: TtkTokenKind;
    function Func44: TtkTokenKind;
    function Func47: TtkTokenKind;
    function Func55: TtkTokenKind;
    function Func56: TtkTokenKind;
    function Func65: TtkTokenKind;
    function Func72: TtkTokenKind;
    function Func73: TtkTokenKind;
    function Func74: TtkTokenKind;
    function Func76: TtkTokenKind;
    function Func81: TtkTokenKind;
    function Func84: TtkTokenKind;
    function Func85: TtkTokenKind;
    function Func89: TtkTokenKind;
    function Func91: TtkTokenKind;
    function Func99: TtkTokenKind;
    function Func110: TtkTokenKind;
    function Func115: TtkTokenKind;
    function Func132: TtkTokenKind;
    function Func145: TtkTokenKind;
    function Func152: TtkTokenKind;
    function Func178: TtkTokenKind;
    function Func224: TtkTokenKind;
    procedure IdentProc;
    procedure UnknownProc;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure NullProc;
    procedure SpaceProc;
    procedure CRProc;
    procedure LFProc;
    procedure FailureCommentOpenProc;
    procedure FailureCommentProc;
    procedure StringOpenProc;
    procedure StringProc;
  protected
    function GetIdentChars: TSynIdentChars; override;
    function GetSampleSource: string; override;
    function IsFilterStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes; override;
    function GetEol: Boolean; override;
    function GetKeyWords: string;
    function GetTokenID: TtkTokenKind;
    procedure SetLine(NewValue: String; LineNumber: Integer); override;
    function GetToken: String; override;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;
  published
    property DevicesAttri: TSynHighlighterAttributes read fDevicesAttri write fDevicesAttri;
    property FailuresAttri: TSynHighlighterAttributes read fFailuresAttri write fFailuresAttri;
    property GeneralFailureAttri: TSynHighlighterAttributes read fGeneralFailureAttri write fGeneralFailureAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
  end;

implementation

uses
{$IFDEF SYN_CLX}
  QSynEditStrConst;
{$ELSE}
  SynEditStrConst;
{$ENDIF}

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_FilterDCTOOLGUI = 'All files (*.*)|*.*';
  SYNS_LangDCTOOLGUI = 'DC-TOOL GUI';
  SYNS_AttrDevices = 'Devices';
  SYNS_AttrFailures = 'Failures';
  SYNS_AttrGeneralFailure = 'GeneralFailure';

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable : array[#0..#255] of Integer;

procedure MakeIdentTable;
var
  I, J: Char;
begin
  for I := #0 to #255 do
  begin
    case I of
      '_', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
    else
      Identifiers[I] := False;
    end;
    J := UpCase(I);
    case I in ['_', 'A'..'Z', 'a'..'z'] of
      True: mHashTable[I] := Ord(J) - 64
    else
      mHashTable[I] := 0;
    end;
  end;
end;

procedure TSynDcToolSyn.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do
  begin
    pF^ := AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[19] := Func19;
  fIdentFuncTable[28] := Func28;
  fIdentFuncTable[30] := Func30;
  fIdentFuncTable[31] := Func31;
  fIdentFuncTable[32] := Func32;
  fIdentFuncTable[37] := Func37;
  fIdentFuncTable[41] := Func41;
  fIdentFuncTable[43] := Func43;
  fIdentFuncTable[44] := Func44;
  fIdentFuncTable[47] := Func47;
  fIdentFuncTable[55] := Func55;
  fIdentFuncTable[56] := Func56;
  fIdentFuncTable[65] := Func65;
  fIdentFuncTable[72] := Func72;
  fIdentFuncTable[73] := Func73;
  fIdentFuncTable[74] := Func74;
  fIdentFuncTable[76] := Func76;
  fIdentFuncTable[81] := Func81;
  fIdentFuncTable[84] := Func84;
  fIdentFuncTable[85] := Func85;
  fIdentFuncTable[89] := Func89;
  fIdentFuncTable[91] := Func91;
  fIdentFuncTable[99] := Func99;
  fIdentFuncTable[110] := Func110;
  fIdentFuncTable[115] := Func115;
  fIdentFuncTable[132] := Func132;
  fIdentFuncTable[145] := Func145;
  fIdentFuncTable[152] := Func152;
  fIdentFuncTable[178] := Func178;
  fIdentFuncTable[224] := Func224;
end;

function TSynDcToolSyn.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;

function TSynDcToolSyn.KeyComp(const aKey: String): Boolean;
var
  I: Integer;
  Temp: PChar;
begin
  Temp := fToIdent;
  if Length(aKey) = fStringLen then
  begin
    Result := True;
    for i := 1 to fStringLen do
    begin
      if mHashTable[Temp^] <> mHashTable[aKey[i]] then
      begin
        Result := False;
        break;
      end;
      inc(Temp);
    end;
  end
  else
    Result := False;
end;

function TSynDcToolSyn.Func19: TtkTokenKind;
begin
  if KeyComp('LCD') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func28: TtkTokenKind;
begin
  if KeyComp('fail') then Result := tkFailures else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func30: TtkTokenKind;
begin
  if KeyComp('arch') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func31: TtkTokenKind;
begin
  if KeyComp('Pack') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func32: TtkTokenKind;
begin
  if KeyComp('cdfs') then Result := tkKey else
    if KeyComp('thd') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func37: TtkTokenKind;
begin
  if KeyComp('failed') then Result := tkFailures else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func41: TtkTokenKind;
begin
  if KeyComp('err') then Result := tkFailures else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func43: TtkTokenKind;
begin
  if KeyComp('panic') then Result := tkFailures else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func44: TtkTokenKind;
begin
  if KeyComp('Clock') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func47: TtkTokenKind;
begin
  if KeyComp('fails') then Result := tkFailures else
    if KeyComp('maple') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func55: TtkTokenKind;
begin
  if KeyComp('loader') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func56: TtkTokenKind;
begin
  if KeyComp('pvr') then Result := tkKey else
    if KeyComp('VMU') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func65: TtkTokenKind;
begin
  if KeyComp('kernel') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func72: TtkTokenKind;
begin
  if KeyComp('failure') then Result := tkFailures else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func73: TtkTokenKind;
begin
  if KeyComp('Mouse') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func74: TtkTokenKind;
begin
  if KeyComp('error') then Result := tkFailures else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func76: TtkTokenKind;
begin
  if KeyComp('Puru') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func81: TtkTokenKind;
begin
  if KeyComp('Keyboard') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func84: TtkTokenKind;
begin
  if KeyComp('Dreamcast') then Result := tkDevices else
    if KeyComp('Visual') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func85: TtkTokenKind;
begin
  if KeyComp('erreur') then Result := tkFailures else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func89: TtkTokenKind;
begin
  if KeyComp('Memory') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func91: TtkTokenKind;
begin
  if KeyComp('JumpPack') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func99: TtkTokenKind;
begin
  if KeyComp('fs_iso9660') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func110: TtkTokenKind;
begin
  if KeyComp('Vibration') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func115: TtkTokenKind;
begin
  if KeyComp('MemoryCard') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func132: TtkTokenKind;
begin
  if KeyComp('Controller') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func145: TtkTokenKind;
begin
  if KeyComp('fs_romdisk') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func152: TtkTokenKind;
begin
  if KeyComp('PuruPuru') then Result := tkDevices else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func178: TtkTokenKind;
begin
  if KeyComp('vid_set_mode') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.Func224: TtkTokenKind;
begin
  if KeyComp('pvr_wait_ready') then Result := tkKey else Result := tkIdentifier;
end;

function TSynDcToolSyn.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynDcToolSyn.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey <= MaxKey then
    Result := fIdentFuncTable[HashKey]
  else
    Result := tkIdentifier;
end;

procedure TSynDcToolSyn.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      #0: fProcTable[I] := NullProc;
      #10: fProcTable[I] := LFProc;
      #13: fProcTable[I] := CRProc;
      '*': fProcTable[I] := FailureCommentOpenProc;
      '"': fProcTable[I] := StringOpenProc;
      #1..#9,
      #11,
      #12,
      #14..#32 : fProcTable[I] := SpaceProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := IdentProc;
    else
      fProcTable[I] := UnknownProc;
    end;
end;

procedure TSynDcToolSyn.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    inc(Run);
  until not (fLine[Run] in [#1..#32]);
end;

procedure TSynDcToolSyn.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynDcToolSyn.CRProc;
begin
  fTokenID := tkSpace;
  inc(Run);
  if fLine[Run] = #10 then
    inc(Run);
end;

procedure TSynDcToolSyn.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynDcToolSyn.FailureCommentOpenProc;
begin
  Inc(Run);
  if (fLine[Run] = '*') and
     (fLine[Run + 1] = '*') then
  begin
    fRange := rsFailureComment;
    FailureCommentProc;
    fTokenID := tkGeneralFailure;
  end
  else
    fTokenID := tkIdentifier;
end;

procedure TSynDcToolSyn.FailureCommentProc;
begin
  fTokenID := tkGeneralFailure;
  repeat
    if (fLine[Run] = '*') and
       (fLine[Run + 1] = '*') and
       (fLine[Run + 2] = '*') then
    begin
      Inc(Run, 3);
      fRange := rsUnKnown;
      Break;
    end;
    if not (fLine[Run] in [#0, #10, #13]) then
      Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynDcToolSyn.StringOpenProc;
begin
  Inc(Run);
  fRange := rsString;
  StringProc;
  fTokenID := tkString;
end;

procedure TSynDcToolSyn.StringProc;
begin
  fTokenID := tkString;
  repeat
    if (fLine[Run] = '"') then
    begin
      Inc(Run, 1);
      fRange := rsUnKnown;
      Break;
    end;
    if not (fLine[Run] in [#0, #10, #13]) then
      Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

constructor TSynDcToolSyn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fDevicesAttri := TSynHighLighterAttributes.Create(SYNS_AttrDevices);
  fDevicesAttri.Foreground := clGreen;
  fDevicesAttri.Background := clWhite;
  AddAttribute(fDevicesAttri);

  fFailuresAttri := TSynHighLighterAttributes.Create(SYNS_AttrFailures);
  fFailuresAttri.Style := [fsBold];
  fFailuresAttri.Foreground := clRed;
  fFailuresAttri.Background := clWhite;
  AddAttribute(fFailuresAttri);

  fGeneralFailureAttri := TSynHighLighterAttributes.Create(SYNS_AttrGeneralFailure);
  fGeneralFailureAttri.Style := [fsBold];
  fGeneralFailureAttri.Foreground := clWhite;
  fGeneralFailureAttri.Background := clRed;
  AddAttribute(fGeneralFailureAttri);

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrRegister);
  fIdentifierAttri.Foreground := clBlack;
  fIdentifierAttri.Background := clWhite;
  AddAttribute(fIdentifierAttri);

  fKeyAttri := TSynHighLighterAttributes.Create(SYNS_AttrText);
  fKeyAttri.Style := [fsBold];
  fKeyAttri.Foreground := clBlue;
  fKeyAttri.Background := clWhite;
  AddAttribute(fKeyAttri);

  fSpaceAttri := TSynHighLighterAttributes.Create(SYNS_AttrSpace);
  fSpaceAttri.Foreground := clWhite;
  fSpaceAttri.Background := clWhite;
  AddAttribute(fSpaceAttri);

  fStringAttri := TSynHighLighterAttributes.Create(SYNS_AttrString);
  fStringAttri.Foreground := clPurple;
  fStringAttri.Background := clWhite;
  AddAttribute(fStringAttri);

  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fDefaultFilter := SYNS_FilterDCTOOLGUI;
  fRange := rsUnknown;
end;

procedure TSynDcToolSyn.SetLine(NewValue: String; LineNumber: Integer);
begin
  fLineRef := NewValue;
  fLine := PChar(fLineRef);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynDcToolSyn.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do
    Inc(Run);
end;

procedure TSynDcToolSyn.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynDcToolSyn.Next;
begin
  fTokenPos := Run;
//  case fRange of
//  else
//    begin
      fRange := rsUnknown;
      fProcTable[fLine[Run]];
 //   end;
//  end;
end;

function TSynDcToolSyn.GetDefaultAttribute(Index: integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_IDENTIFIER : Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD    : Result := fKeyAttri;
    SYN_ATTR_STRING     : Result := fStringAttri;
    SYN_ATTR_WHITESPACE : Result := fSpaceAttri;
  else
    Result := nil;
  end;
end;

function TSynDcToolSyn.GetEol: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TSynDcToolSyn.GetKeyWords: string;
begin
  Result := 
    'arch,cdfs,Clock,Controller,Dreamcast,err,erreur,error,fail,failed,fai' +
    'ls,failure,fs_iso9660,fs_romdisk,JumpPack,kernel,Keyboard,LCD,loader,m' +
    'aple,Memory,MemoryCard,Mouse,Pack,panic,Puru,PuruPuru,pvr,pvr_wait_rea' +
    'dy,thd,Vibration,vid_set_mode,Visual,VMU';
end;

function TSynDcToolSyn.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TSynDcToolSyn.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynDcToolSyn.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkDevices: Result := fDevicesAttri;
    tkFailures: Result := fFailuresAttri;
    tkGeneralFailure: Result := fGeneralFailureAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
//    tkUnknown: Result := fSymbolAttri;
  else
    Result := nil;
  end;
end;

function TSynDcToolSyn.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynDcToolSyn.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TSynDcToolSyn.GetIdentChars: TSynIdentChars;
begin
  Result := ['_', 'a'..'z', 'A'..'Z'];
end;

function TSynDcToolSyn.GetSampleSource: string;
begin
  Result := 'DC-TOOL GUI 3 SERIES - by [big_fury]SiZiOUS'#13#10 +
            #13#10 +
            '"Dreamcast REFUSES to DIE"'#13#10 +
            #13#10 +
            'This highlighter is used with DC-TOOL GUI to recognize '#13#10 +
            'KallistiOS features and debugs log.'#13#10 +
            #13#10 +
            'Some Examples... :'#13#10 +
            'arch: *** Powered by SynEdit. ***'#13#10 +
            'maple: *** ASSERTION FAILURE ***'#13#10 +
            #13#10 +
            'Enjoy,'#13#10 +
            'SiZ!'#13#10 +
            #13#10 +
            'Some useful links :'#13#10 +
            'http://sbibuilder.shorturl.com/'#13#10 +
            'http://www.dc-france.com/'#13#10 +
            'http://www.dreamcast-scene.com/'#13#10 +
            'http://www.dciberia.net/'#13#10 +
            'http://www.dcemulation.com/'#13#10 +
            'http://www.dcemu.co.uk/';
end;

function TSynDcToolSyn.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterDCTOOLGUI;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynDcToolSyn.GetLanguageName: string;
begin
  Result := SYNS_LangDCTOOLGUI;
end;

procedure TSynDcToolSyn.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynDcToolSyn.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynDcToolSyn.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynDcToolSyn);
{$ENDIF}
end.
