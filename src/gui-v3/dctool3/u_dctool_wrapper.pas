{
        : :  D C - T O O L  G U I  3  : :

               DCTOOL.DLL Wrapper
                   25/06/05
                  by SiZiOUS
}

unit u_dctool_wrapper;

interface

uses
  Windows, SysUtils;
  
const
  DC_TOOL_PATH    : string = 'DCTOOL_BIN';

  DCTOOL_SERIAL   : string = 'DC-TOOL.EXE';
  DCTOOL_BBA      : string = 'DC-TOOL-IP.EXE';
  DCTOOL_USB      : string = 'DC-TOOL.EXE';
  CYGWIN1_DLL     : string = 'CYGWIN1.DLL';
  CYGINTL_DLL     : string = 'CYGINTL.DLL';
  
type
  TDcToolFile = (dfBBA, dfSerial, dfUSB, dfCygWin1, dfCygIntl);

procedure ExtractAllFiles; stdcall ; external 'dctool.dll';
procedure DeleteAllFiles; stdcall ; external 'dctool.dll';
function GetCompleteFileName(TheFile : TDcToolFile) : string;
function GetDcToolPath : string;

implementation

uses
  Utils;

//---GetTempDir---
function GetTempDir: string;
var
  Dossier : array[0..MAX_PATH] of Char;

begin
  Result := '';
  if GetTempPath(SizeOf(Dossier), Dossier) <> 0 then Result := StrPas(Dossier);
  Result := GetRealPath(Result);
end;

//---GetDcToolPath---
function GetDcToolPath : string;
begin
  Result := GetRealPath(GetTempDir + '\' + DC_TOOL_PATH);
end;

//---GetCompleteFileName---
function GetCompleteFileName(TheFile : TDcToolFile) : string;
var
  FileName : string;

begin
  case TheFile of
    dfBBA     : FileName := DCTOOL_BBA;
    dfSerial  : FileName := DCTOOL_SERIAL;
    dfUSB     : FileName := DCTOOL_USB;
    dfCygWin1 : FileName := CYGWIN1_DLL;
    dfCygIntl : FileName := CYGINTL_DLL;
  end;

  Result := GetDcToolPath + FileName;
end;

end.
