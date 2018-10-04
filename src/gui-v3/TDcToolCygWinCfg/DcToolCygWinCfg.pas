unit DcToolCygWinCfg;

interface

uses
  Windows, SysUtils, Classes, DcTool;

type
  TCygConfig = (ccInternal, ccSystem, ccExternal);

  TDcToolCygWinCfg = class;

  TCustomDcToolPaths = class(TPersistent)
  private
    FDcTool : TDcTool;
    FUSBDcToolPath: string;
    FBBADcToolPath: string;
    FSerialDcToolPath: string;
  public
    constructor Create(DcTool : TDcTool);
    function Update : boolean;
  published
    property BBADcToolPath : string read FBBADcToolPath write FBBADcToolPath;
    property SerialDcToolPath : string read FSerialDcToolPath write FSerialDcToolPath;
    property USBDcToolPath : string read FUSBDcToolPath write FUSBDcToolPath;
  end;

  TDcToolCygWinCfg = class(TComponent)
  private
    FConfig: TCygConfig;
    FInternalDcToolPath: string;
    FCygWinExternalPath: string;
    FCustomDcToolPaths: TCustomDcToolPaths;
    FDcTool: TDcTool;
    function GetRealPath(Path : string) : string;
    procedure Apply(DcToolPath : string);
    procedure SetDcTool(const Value: TDcTool);
    { Déclarations privées }
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ApplyConfig;
  published
    { Déclarations publiées }
    property Config : TCygConfig read FConfig write FConfig;
    property InternalDcToolPath : string read FInternalDcToolPath write FInternalDcToolPath;
    property CygWinExternalPath : string read FCygWinExternalPath write FCygWinExternalPath;

    property CustomDcToolPaths : TCustomDcToolPaths read FCustomDcToolPaths write
      FCustomDcToolPaths;

    property DcTool : TDcTool read FDcTool write SetDcTool;
  end;

procedure Register;

implementation

//présent dans DCTOOL.DLL et aussi dans u_dctool_wrapper.pas
const
  CYGWIN1_DLL     : string = 'CYGWIN1.DLL';
  CYGINTL_DLL     : string = 'CYGINTL.DLL';

//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('DC-TOOL GUI', [TDcToolCygWinCfg]);
end;

//------------------------------------------------------------------------------

{ TDcToolCygWinCfg }

//---GetRealPath---
//Corriger les defauts des paths... du genre "C:\\ACXC\\\\AAA\"...
function TDcToolCygWinCfg.GetRealPath(Path : string) : string;
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

procedure TDcToolCygWinCfg.ApplyConfig;
begin
  FCustomDcToolPaths.Update; //mettre les paths des dctools.
  
  Apply(FInternalDcToolPath);
  Apply(FCustomDcToolPaths.FBBADcToolPath);
  Apply(FCustomDcToolPaths.FSerialDcToolPath);
  Apply(FCustomDcToolPaths.FUSBDcToolPath);
end;

constructor TDcToolCygWinCfg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDcTool := nil;
  FCustomDcToolPaths := TCustomDcToolPaths.Create(FDcTool);
end;

destructor TDcToolCygWinCfg.Destroy;
begin
  FCustomDcToolPaths.Free;
  
  inherited Destroy;
end;

{ TCustomDcToolPaths }

constructor TCustomDcToolPaths.Create(DcTool: TDcTool);
begin
  FDcTool := DcTool;
end;

function TCustomDcToolPaths.Update : boolean;
begin
  Result := False;
  if not Assigned(FDcTool) then Exit;

  FBBADcToolPath := ExtractFilePath(FDcTool.BroadBand.Executable);
  FSerialDcToolPath := ExtractFilePath(FDcTool.Serial.Executable);
  FUSBDcToolPath := ExtractFilePath(FDcTool.USB.Executable);
  Result := True;
end;

procedure TDcToolCygWinCfg.SetDcTool(const Value: TDcTool);
begin
  FDcTool := Value;
  FCustomDcToolPaths.FDcTool := FDcTool;
end;

procedure TDcToolCygWinCfg.Apply(DcToolPath: string);
var
  TargetCygWin1,
  TargetCygIntl,
  s : string;

begin
  TargetCygWin1 := GetRealPath(DcToolPath) + CYGWIN1_DLL;
  TargetCygIntl := GetRealPath(DcToolPath) + CYGINTL_DLL;

  case FConfig of
    ccInternal  : begin
                    if FileExists(TargetCygWin1 + '.org') then
                    begin
                      //c'est pas une bonne DLL (pas l'interne)
                      if FileExists(TargetCygWin1) then DeleteFile(TargetCygWin1);
                      
                      RenameFile(TargetCygWin1 + '.org', TargetCygWin1);
                    end;

                    if FileExists(TargetCygIntl + '.org') then
                    begin
                      if FileExists(TargetCygIntl) then DeleteFile(TargetCygIntl);
                      
                      RenameFile(TargetCygIntl + '.org', TargetCygIntl);
                    end;
                  end;

    ccExternal  : begin
                    s := GetRealPath(FCygWinExternalPath) + CYGWIN1_DLL;
                    if FileExists(s) then
                    begin
                      if not FileExists(TargetCygWin1 + '.org') then
                        RenameFile(TargetCygWin1, TargetCygWin1 + '.org');

                      CopyFile(PChar(s), PChar(TargetCygWin1), False);
                    end;

                    s := GetRealPath(FCygWinExternalPath) + CYGINTL_DLL;
                    if FileExists(s) then
                    begin
                      if not FileExists(TargetCygIntl + '.org') then
                        RenameFile(TargetCygIntl, TargetCygIntl + '.org');
                        
                      CopyFile(PChar(s), PChar(TargetCygIntl), False);
                    end;

                  end;

    ccSystem    : begin

                    if FileExists(TargetCygWin1) then
                    begin

                      if not FileExists(TargetCygWin1 + '.org') then
                        RenameFile(TargetCygWin1, TargetCygWin1 + '.org')
                      else begin
                        //c'est une veille DLL de merde
                        DeleteFile(TargetCygWin1);
                      end;

                    end;

                    if FileExists(TargetCygIntl) then
                    begin

                      if not FileExists(TargetCygIntl + '.org') then
                        RenameFile(TargetCygIntl, TargetCygIntl + '.org')
                      else begin
                        DeleteFile(TargetCygIntl);
                      end;

                    end;

                  end;
  end;
end;

end.
 