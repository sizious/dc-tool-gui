unit u_dctool_filenames;

interface

type
  TDcToolFile = (dfBBA, dfSerial, dfUSB, dfCygWin1, dfCygIntl);
  
function GetCompleteFileName(TheFile : TDcToolFile) : string;
function GetDcToolPath : string;

implementation

uses
  Utils;

const
  DC_TOOL_PATH    : string = 'DCTOOL_BIN';

  DCTOOL_SERIAL   : string = 'DC-TOOL.EXE';
  DCTOOL_BBA      : string = 'DC-TOOL-IP.EXE';
  DCTOOL_USB      : string = 'DC-TOOL.EXE';
  CYGWIN1_DLL     : string = 'CYGWIN1.DLL';
  CYGINTL_DLL     : string = 'CYGINTL.DLL';

function GetDcToolPath : string;
begin
  Result := GetRealPath(GetTempDir + '\' + DC_TOOL_PATH);
end;

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
