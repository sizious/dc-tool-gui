unit DcToolLogRichEdit;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, StdCtrls, ComCtrls, Graphics,
  Types, IniFiles;

const
  TagCaptions : array[0..2] of string = ('CMD:>', 'STATE:>', 'OUTPUT:>');
  
type
  TDcToolLogRichEdit = class;

  TTypeInfos = (tiCommand, tiState, tiLog);

  TAutoScroll = class(TPersistent)
  private
    FEnabled: boolean;
    FDoOnlyNotFocused: boolean;
  public
    constructor Create;
  published
    property Enabled : boolean read FEnabled write FEnabled default False;
    property DoOnlyNotFocused : boolean read FDoOnlyNotFocused write FDoOnlyNotFocused
      default True;
  end;

  TInitLog = class(TPersistent)
  private
    FRichEdit : TDcToolLogRichEdit;
    FLogTitle: string;
    FDescLines: TStringList;
    FEnabled: boolean;
    FInitFont: TFont;
    procedure SetDescLines(const Value: TStringList);
    procedure SetInitFont(const Value: TFont);
  public
    constructor Create(AOwner : TDcToolLogRichEdit);
    destructor Destroy; override;
    procedure DoInitLog;
  published
    property LogTitle : string read FLogTitle write FLogTitle;
    property DescLines : TStringList read FDescLines write SetDescLines;
    property Enabled : boolean read FEnabled write FEnabled;
    property InitFont : TFont read FInitFont write SetInitFont;
  end;

  TColorTypeInfos = class(TPersistent)
  private
    FRichEdit : TDcToolLogRichEdit;
    FTypeInfo : TTypeInfos;
    FShowTag: boolean;
    FEnabled: boolean;
    FFont: TFont;
    procedure SetFont(const Value: TFont);
  public
    constructor Create(TypeInfo : TTypeInfos ; RichEdit : TDcToolLogRichEdit);
    destructor Destroy; override;
    procedure AddNewEventLine(Text : string);
  published
    property Enabled : boolean read FEnabled write FEnabled default True;
    property Font : TFont read FFont write SetFont;
    property ShowTag : boolean read FShowTag write FShowTag default True;
  end;

  TLinesType = class(TPersistent)
  private
    FRichEdit : TDcToolLogRichEdit;
    FCommand: TColorTypeInfos;
    FState: TColorTypeInfos;
    FLog: TColorTypeInfos;
    procedure SetCommand(const Value: TColorTypeInfos);
    procedure SetLog(const Value: TColorTypeInfos);
    procedure SetState(const Value: TColorTypeInfos);
  public
    constructor Create(RichEdit : TDcToolLogRichEdit);
    destructor Destroy; override;
    procedure AddLine(Line : string);
  published
    property Command : TColorTypeInfos read FCommand write SetCommand;
    property State : TColorTypeInfos read FState write SetState;
    property Log : TColorTypeInfos read FLog write SetLog;
  end;

  TDcToolLogRichEdit = class(TRichEdit)
  private
    //FLinesTypeIndex : TList;
    FSaveAttributs : TTextAttributes;
    FLinesType: TLinesType;
    FInitLog: TInitLog;
    FOnChange: TNotifyEvent;
    FAutoScroll: TAutoScroll;
    FRestoreCaretAfterOperation: boolean;
    procedure SetLinesType(const Value: TLinesType);
    procedure SetInitLog(const Value: TInitLog);
    procedure ChangeAttributes(const Font : TFont);
    procedure RestoreAttributes;
    procedure SelfChange(Sender : TObject);
    function SaveFont(Ini : TIniFile ; Section : string ; Font : TFont) : boolean;
    function LoadFont(Ini : TIniFile ; Section : string ; var Font : TFont) : boolean;
    function SaveColorTypeInfos(Ini : TIniFile ; Section : string
              ; CTI : TColorTypeInfos) : boolean;
    function LoadColorTypeInfos(Ini : TIniFile ; Section : string
              ; var CTI : TColorTypeInfos) : boolean;
    { Déclarations privées }
  protected
    { Déclarations protégées }
    procedure Loaded; override;
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure SaveCfgToFile(const FileName : TFileName);
    function LoadCfgToFile(const FileName : TFileName) : boolean;
    //procedure UpdateFonts;
  published
    { Déclarations publiées }
    property LinesType : TLinesType read FLinesType write SetLinesType;
    property InitLog : TInitLog read FInitLog write SetInitLog;
    property AutoScroll : TAutoScroll read FAutoScroll write FAutoScroll;
    property RestoreCaretAfterOperation : boolean read FRestoreCaretAfterOperation
      write FRestoreCaretAfterOperation default False;
    
    //Evenements
    property OnChange : TNotifyEvent read FOnChange write FOnChange; 
  end;

procedure Register;

implementation

USES DIALOGS;

procedure Register;
begin
  RegisterComponents('DC-TOOL GUI', [TDcToolLogRichEdit]);
end;

{ TDcToolLogRichEdit }

constructor TDcToolLogRichEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAutoScroll := TAutoScroll.Create;
  FLinesType := TLinesType.Create(Self);
  FInitLog := TInitLog.Create(Self);

  //FLinesTypeIndex := TList.Create;

  WordWrap := False;
  ReadOnly := True;
  ScrollBars := ssBoth;

  FRestoreCaretAfterOperation := False;

  inherited OnChange := SelfChange;
end;

destructor TDcToolLogRichEdit.Destroy;
begin
  FLinesType.Free;
  FInitLog.Free;
  FAutoScroll.Free;
  //FLinesTypeIndex.Free;
  
  inherited Destroy;
end;

procedure TDcToolLogRichEdit.Loaded;
begin
  inherited Loaded;

  //FInitLog.DoInitLog;
end;

procedure TDcToolLogRichEdit.SetInitLog(const Value: TInitLog);
begin
  FInitLog := Value;
end;

procedure TDcToolLogRichEdit.SetLinesType(const Value: TLinesType);
begin
  FLinesType := Value;
end;

procedure TDcToolLogRichEdit.SelfChange(Sender: TObject);
begin
  if FAutoScroll.FEnabled then
  begin
    //Si le mec veut que ça scrolle que si il est pas focused, alors on se tire ^^
    if FAutoScroll.FDoOnlyNotFocused then if Self.Focused then Exit;

    SendMessage(Self.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  end;

  //Vrai évènement
  if Assigned(FOnChange) then
    FOnChange(Sender);
end;

function TDcToolLogRichEdit.LoadCfgToFile(const FileName: TFileName): boolean;
var
  Ini : TIniFile;
  RFont : TFont;

begin
  Result := False;
  if not FileExists(FileName) then Exit;

  Ini := TIniFile.Create(FileName);
  try
    FAutoScroll.FEnabled := Ini.ReadBool('AutoScroll', 'Enabled', True);
    FAutoScroll.FDoOnlyNotFocused := Ini.ReadBool('AutoScroll', 'DoOnlyNotFocused', True);
    LoadColorTypeInfos(Ini, 'Command', FLinesType.FCommand);
    LoadColorTypeInfos(Ini, 'State', FLinesType.FState);
    LoadColorTypeInfos(Ini, 'Log', FLinesType.FLog);

    RFont := TFont.Create;
    try
      LoadFont(Ini, 'Font', RFont);
      Font := RFont; //charger la font principale
    finally
      RFont.Free;
    end;

    Result := True;
  finally
    Ini.Free;
  end;
end;

procedure TDcToolLogRichEdit.SaveCfgToFile(const FileName: TFileName);
var
  Ini : TIniFile;
  
begin
  Ini := TIniFile.Create(FileName);
  try
    Ini.WriteBool('AutoScroll', 'Enabled', FAutoScroll.FEnabled);
    Ini.WriteBool('AutoScroll', 'DoOnlyNotFocused', FAutoScroll.FDoOnlyNotFocused);
    SaveColorTypeInfos(Ini, 'Command', FLinesType.FCommand);
    SaveColorTypeInfos(Ini, 'State', FLinesType.FState);
    SaveColorTypeInfos(Ini, 'Log', FLinesType.FLog);

    SaveFont(Ini, 'Font', Font);
  finally
    Ini.Free;
  end;
end;

function TDcToolLogRichEdit.LoadFont(Ini: TIniFile ; Section : string ; var Font: TFont) : boolean;
var
  OK : boolean;

begin
  Result := False;
  if not Assigned(Ini) then Exit;

  Font.Charset := Ini.ReadInteger(Section, 'Charset', ANSI_CHARSET);
  Font.Color := StringToColor(Ini.ReadString(Section, 'Color', 'clWindowText'));
  Font.Height := Ini.ReadInteger(Section, 'Height', -11);
  Font.Name := Ini.ReadString(Section, 'Name', 'Tahoma');
  Font.Pitch := TFontPitch(Ini.ReadInteger(Section, 'Pitch', Integer(fpDefault)));
  Font.Size := Ini.ReadInteger(Section, 'Size', 8);
  
  OK := Ini.ReadBool(Section, 'Style.Bold', False);
  if OK then Font.Style := Font.Style + [fsBold];
  
  OK := Ini.ReadBool(Section, 'Style.Italic', False);
  if OK then Font.Style := Font.Style + [fsItalic];

  OK := Ini.ReadBool(Section, 'Style.Underline', False);
  if OK then Font.Style := Font.Style + [fsUnderline];

  OK := Ini.ReadBool(Section, 'Style.StrikeOut', False);
  if OK then Font.Style := Font.Style + [fsStrikeOut];

  Result := True;
end;

function TDcToolLogRichEdit.SaveFont(Ini: TIniFile ; Section : string ; Font: TFont) : boolean;
begin
  Result := False;
  if not Assigned(Ini) then Exit;

  Ini.WriteInteger(Section, 'Charset', Font.Charset);
  Ini.WriteString(Section, 'Color', ColorToString(Font.Color));
  Ini.WriteInteger(Section, 'Height', Font.Height);
  Ini.WriteString(Section, 'Name', Font.Name);
  Ini.WriteInteger(Section, 'Pitch', Integer(Font.Pitch));
  Ini.WriteInteger(Section, 'Size', Font.Size);
  Ini.WriteBool(Section, 'Style.Bold', fsBold in Font.Style);
  Ini.WriteBool(Section, 'Style.Italic', fsItalic in Font.Style);
  Ini.WriteBool(Section, 'Style.Underline', fsUnderline in Font.Style);
  Ini.WriteBool(Section, 'Style.StrikeOut', fsStrikeOut in Font.Style);
  Result := True;
end;

function TDcToolLogRichEdit.LoadColorTypeInfos(Ini: TIniFile;
  Section: string; var CTI: TColorTypeInfos): boolean;
begin
  Result := False;
  if not Assigned(Ini) then Exit;

  CTI.FTypeInfo := TTypeInfos(Ini.ReadInteger(Section, 'TypeInfo', 0));
  CTI.FShowTag := Ini.ReadBool(Section, 'ShowTag', True);
  CTI.FEnabled := Ini.ReadBool(Section, 'Enabled', True);
  LoadFont(Ini, Section, CTI.FFont);
  Result := True;
end;

function TDcToolLogRichEdit.SaveColorTypeInfos(Ini: TIniFile;
  Section: string; CTI: TColorTypeInfos): boolean;
begin
  Result := False;
  if not Assigned(Ini) then Exit;

  Ini.WriteInteger(Section, 'TypeInfo', Integer(CTI.FTypeInfo));
  Ini.WriteBool(Section, 'ShowTag', CTI.FShowTag);
  Ini.WriteBool(Section, 'Enabled', CTI.FEnabled);
  SaveFont(Ini, Section, CTI.FFont);
  Result := True;
end;

{procedure TDcToolLogRichEdit.UpdateFonts;
var
  i, decal,
  line, lt  : integer;
  LineType  : TTypeInfos;
  RightFont : TFont;
  CaretPos  : TPoint;

  SavedSelStart,
  SavedSelLength : integer;

begin
  SavedSelStart := SelStart;
  SavedSelLength := SelLength;

  if Self.FInitLog.Enabled then
  begin
    //changer le texte d'initlog

    //Première ligne (en gras par défaut)
    CaretPos.X := 0;
    CaretPos.Y := 0; //première ligne
    SetCaretPos(CaretPos);
    SelLength := Length(Self.Lines[0]);

    //Changer les attributs...
    SelAttributes.Assign(FInitLog.FInitFont);

    //Pour ne pas re-traiter encore les lignes du InitLog
    decal := Self.FInitLog.FDescLines.Count + 2
  end else decal := 0;

  RightFont := Font;

  for i := 0 to FLinesTypeIndex.Count - 1 do
  begin
    lt := Integer(FLinesTypeIndex.Items[i]);
    if lt = -1 then Continue; //c'est pas une ligne coloriée.

    LineType := TTypeInfos(lt);
    line := decal + i;

    //Selon le type de ligne (stocké dans le tableau TList) on va chosir
    //la Font à utiliser
    case LineType of
      tiCommand : RightFont := LinesType.Command.FFont;
      tiState   : RightFont := LinesType.State.FFont;
      tiLog     : RightFont := LinesType.Log.FFont;
    end;

    //Positionner le curseur au début de la ligne
    CaretPos.X := 0;
    CaretPos.Y := line;
    SetCaretPos(CaretPos);

    //Sélectionner la ligne
    SelLength := Length(Self.Lines[line]);

    //Changer les attributs
    SelAttributes.Assign(RightFont);
  end;

  SelStart := SavedSelStart;
  SelLength := SavedSelLength;
end;  }

{ TColorTypeInfos }

procedure TColorTypeInfos.AddNewEventLine(Text: string);
var
  SavedPoint, Point : TPoint;
  Line  : string;

begin
  if not FEnabled then Exit;

  SavedPoint := FRichEdit.GetCaretPos;

  Point.X := 0;
  Point.Y := FRichEdit.Lines.Count; //dernière line
  FRichEdit.SetCaretPos(Point);

  FRichEdit.ChangeAttributes(FFont);

  if Self.FShowTag then
    Line := TagCaptions[Integer(FTypeInfo)] + ' ' + Text
  else Line := Text;


  FRichEdit.Lines.Add(Line);
  //FRichEdit.FLinesTypeIndex.Add(Pointer(FTypeInfo));

  FRichEdit.RestoreAttributes;

  if FRichEdit.FRestoreCaretAfterOperation then
    FRichEdit.SetCaretPos(SavedPoint);
end;

procedure TDcToolLogRichEdit.ChangeAttributes(const Font : TFont);
begin
  SelLength := 0;

  FSaveAttributs := SelAttributes;

  with SelAttributes do
  begin
    Color := Font.Color;
    Size := Font.Size;
    Name := Font.Name;
    Style := Font.Style;
    Charset := Font.Charset;
  end;

end;

constructor TColorTypeInfos.Create(TypeInfo: TTypeInfos ; RichEdit : TDcToolLogRichEdit);
begin
  FTypeInfo := TypeInfo;
  FEnabled := True;
  FShowTag := True;
  FRichEdit := RichEdit;
  
  FFont := TFont.Create;

  case TypeInfo of
    tiCommand : FFont.Color := clGreen;
    tiState   : FFont.Color := clRed;
    tiLog     : FFont.Color := clBlue;
  end;

  FFont.Name := 'Tahoma';
end;

destructor TColorTypeInfos.Destroy;
begin
  FFont.Free;
  
  inherited Destroy;
end;

procedure TDcToolLogRichEdit.RestoreAttributes;
begin
  SelAttributes := FSaveAttributs;
end;

procedure TColorTypeInfos.SetFont(const Value: TFont);
begin
  if Assigned(FFont) then FFont.Assign(Value);
end;

{ TLinesType }

procedure TLinesType.AddLine(Line: string);
begin
  FRichEdit.Lines.Add(Line);
  //FRichEdit.FLinesTypeIndex.Add(Pointer(-1));
end;

constructor TLinesType.Create(RichEdit : TDcToolLogRichEdit);
begin
  FRichEdit := RichEdit;
  FCommand := TColorTypeInfos.Create(tiCommand, RichEdit);
  FState := TColorTypeInfos.Create(tiState, RichEdit);
  FLog := TColorTypeInfos.Create(tiLog, RichEdit);
end;

destructor TLinesType.Destroy;
begin
  FCommand.Free;
  FState.Free;
  FLog.Free;

  inherited Destroy;
end;

procedure TLinesType.SetCommand(const Value: TColorTypeInfos);
begin
  if Assigned(Value) then FCommand.Assign(Value);
  //FCommand := Value;
end;

procedure TLinesType.SetLog(const Value: TColorTypeInfos);
begin
  //FLog := Value;
  if Assigned(Value) then FLog.Assign(Value);
end;

procedure TLinesType.SetState(const Value: TColorTypeInfos);
begin
  //FState := Value;
  if Assigned(Value) then FState.Assign(Value);
end;

{ TInitLog }

constructor TInitLog.Create(AOwner : TDcToolLogRichEdit);
begin
  FEnabled := False;
  FRichEdit := AOwner;
  FDescLines := TStringList.Create;

  FInitFont := TFont.Create;
  FInitFont.Style := [fsBold];
  FInitFont.Name := 'Tahoma';
end;

destructor TInitLog.Destroy;
begin
  FDescLines.Free;
  FInitFont.Free;
  
  inherited Destroy;
end;

procedure TInitLog.DoInitLog;
begin
  FRichEdit.Clear;
  //FRichEdit.FLinesTypeIndex.Clear;

  //initialise
  if FEnabled then
  begin
    //Titre
    FRichEdit.ChangeAttributes(FInitFont);
    FRichEdit.Lines.Add(FLogTitle);
    FRichEdit.RestoreAttributes;

    //Description
    FRichEdit.Lines.Add(FDescLines.GetText);
  end;
end;

procedure TInitLog.SetDescLines(const Value: TStringList);
begin
  if Assigned(Value) then FDescLines.Assign(Value);
end;

procedure TInitLog.SetInitFont(const Value: TFont);
begin
  if Assigned(Value) then FInitFont.Assign(Value);
end;

{ TAutoScroll }

constructor TAutoScroll.Create;
begin
  FEnabled := False;
  FDoOnlyNotFocused := True;
end;

end.
