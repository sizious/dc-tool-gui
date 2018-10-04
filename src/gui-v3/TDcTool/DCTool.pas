unit DCTool;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ExtCtrls,
  ComCtrls, IniFiles, Progress, Switchs;

const
  CORE_VERSION    : string = '1.0';
  DOSCOMM_VERSION : string = '2.1.5';

  Bauds : array[0..8] of integer = (300, 1200, 2400, 4800, 9600, 19200, 38400,
    57600, 115200);

type
  TDosComm = class;
  TDCTool = class;

  TOperationType = (otUpload, otUploadExecute, otDownload, otReset);
  
  TDCToolExecutableError = class(Exception);
  TChRootDirectoryError = class(Exception);
  TIsoFileError = class(Exception);
  TFileInUseProtectionError = class(Exception);
  //TConstructorError = class(Exception);

  TInvalidIPError = class(Exception);
  
  //---BBACom---                
  TBBACom = class(TPersistent)
  private
    FDCTool : TDCTool;
    FIPAddress: string;
    FExecutable: TFileName;
    procedure SetIPAddress(const Value: string);
    procedure SetExecutable(const Value: TFileName);
    function GetCompleteLine(OperationType : TOperationType) : string;
  public
    constructor Create(DCTool : TDCTool);
    function IsValidIp : boolean;
  published
    property IPAddress : string read FIPAddress write SetIPAddress;
    property Executable : TFileName read FExecutable write SetExecutable;
  end;

  //---SerialCom---
  TComPort = (cpCOM1, cpCOM2, cpCOM3, cpCOM4);
  TBaudrate = (b300, b1200, b2400, b4800, b9600, b19200, b38400, b57600, b115200);

  TSerialCom = class(TPersistent)
  private
    FDCTool : TDCTool;
    FComPort : TComPort;
    FBaudrate : TBaudrate;
    FAlternateBaudrate: boolean;
    FExecutable: TFileName;
    procedure SetAlternateBaudrate(const Value: boolean);
    procedure SetBaudrate(const Value: TBaudrate);
    procedure SetComPort(const Value: TComPort);
    procedure SetExecutable(const Value: TFileName);
    function GetCompleteLine(OperationType : TOperationType) : string;
  public
    constructor Create(DCTool : TDCTool);
    function ComPortToStr(ComPort : TComPort) : string;
    function BaudrateToStr(Baudrate : TBaudrate) : string;
  published
     property ComPort : TComPort read FComPort write SetComPort;
     property Baudrate : TBaudrate read FBaudrate write SetBaudrate;
     property AlternateBaudrate : boolean read FAlternateBaudrate write SetAlternateBaudrate;
     property Executable : TFileName read FExecutable write SetExecutable;
  end;

  //---USBCom---
  TUSBCom = class(TPersistent)
  private
    FExecutable: TFileName;
    procedure SetExecutable(const Value: TFileName);
  public
    constructor Create;
  published
    property Executable : TFileName read FExecutable write SetExecutable;
  end;

  //---Upload---
  TUpload = class(TPersistent)
  private
    FRealDcToolFileName : TFileName; //pour la CopyProtection !

    FDCTool : TDCTool;
    FExecuteAfterUpload: boolean;
    FExecuteAddress: string;
    FFileInUseProtection: boolean;
    procedure SetExecuteAddress(const Value: string);
    procedure SetExecuteAfterUpload(const Value: boolean);
    function GetUploadConfig : string;
    function CreateFileInUseProtection : string;      //crÈer le fichier "file in use" protection
    procedure DeleteFileInUseProtection; //effacer le fichier "file in use" protection.
    function GetFileInUseProtectFile(FileName : TFileName) : string; //generer le nom de fichier pour "file in use" protection
  public
    constructor Create(DCTool : TDCTool);
    function GetDefaultAddress : string;
  published
    property ExecuteAddress : string read FExecuteAddress write SetExecuteAddress;
    property ExecuteAfterUpload : boolean read FExecuteAfterUpload write SetExecuteAfterUpload;
    property FileInUseProtection : boolean read FFileInUseProtection write FFileInUseProtection;
  end;

  //---Download---
  TDownload = class(TPersistent)
  private
    FDCTool : TDCTool;
    FDownSize: integer;
    FAddress: string;
    procedure SetDownSize(const Value: integer);
    function GetDownloadConfig : string;
    procedure SetAddress(const Value: string);
  public
    constructor Create(DCTool : TDCTool);
    function GetDefaultAddress : string;
    function GetDefaultDownloadSize : integer;
  published
    property FileSize : integer read FDownSize write SetDownSize;
    property Address : string read FAddress write SetAddress;
  end;

  //---Options---
  TOptions = class(TPersistent)
  private
    FDCTool : TDCTool;
    FAttachFileServer: boolean;
    FUseDumbTerminal: boolean;
    FClrScrBeforeDownload: boolean;
    procedure SetAttachFileServer(const Value: boolean);
    procedure SetClrScrBeforeDownload(const Value: boolean);
    procedure SetUseDumbTerminal(const Value: boolean);
    function GetOptions : string;
  public
    constructor Create(DCTool : TDCTool);
  published
    property UseDumbTerminal : boolean read FUseDumbTerminal write SetUseDumbTerminal;
    property AttachFileServer : boolean read FAttachFileServer write SetAttachFileServer;
    property ClrScrBeforeDownload : boolean read FClrScrBeforeDownload write SetClrScrBeforeDownload;
  end;

  //---ChRoot---
  TChRoot = class(TPersistent)
  private
    FEnabled: boolean;
    FChrootToPath: string;
    procedure SetChrootToPath(const Value: string);
    procedure SetEnabled(const Value: boolean);
    function GetCompleteLine : string;
  public
    constructor Create;
  published
    property Enabled : boolean read FEnabled write SetEnabled;
    property Path : string read FChrootToPath write SetChrootToPath;
  end;

  //---IsoRedirection---
  TIsoRedirection = class(TPersistent)
  private
    FEnabled: boolean;
    FIsoFile: string;
    procedure SetIsoFile(const Value: string);
    procedure SetEnabled(const Value: boolean);
    function GetCompleteLine : string;
  public
    constructor Create;
  published
    property Enabled : boolean read FEnabled write SetEnabled;
    property IsoFile : string read FIsoFile write SetIsoFile;
  end;

  TCreatePipeError = class(Exception); //exception raised when a pipe cannot be created
  TCreateProcessError = class(Exception); //exception raised when the process cannot be created
  TOutputType = (otEntireLine, otBeginningOfLine); //to know if the newline is finished.
  TReturnCode = (rcCRLF, rcLF);

  //---TProcessTimer---
  TProcessTimer = class(TTimer) //timer for stopping the process after XXX sec
  private
    FSinceBeginning: Integer;
    FSinceLastOutput: Integer;
    procedure MyTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Beginning; //call this at the beginning of a process
    procedure NewOutput; //call this when a new output is received
    procedure Ending; //call this when the process is terminated
    property SinceBeginning: Integer read FSinceBeginning;
    property SinceLastOutput: Integer read FSinceLastOutput;
  end;

  TNewLineEvent = procedure(Sender: TObject; NewLine: string; OutputType: TOutputType) of object;
    //  Ç±ÇÍ(Å´)ÇÕïsóvÇ≈ÇÕÇ»Ç¢Ç©ÅHÅB
  TTerminateEvent = procedure(Sender: TObject; ExitCode: LongWord) of object;

  TShowWindow = (swHIDE, swMAXIMIZE, swMINIMIZE, swRESTORE, swSHOW,
    swSHOWDEFAULT, swSHOWMAXIMIZED, swSHOWMINIMIZED, swSHOWMINNOACTIVE,
      swSHOWNA, swSHOWNOACTIVATE, swSHOWNORMAL);

  TCreationFlag = (fCREATE_DEFAULT_ERROR_MODE, fCREATE_NEW_CONSOLE,
    fCREATE_NEW_PROCESS_GROUP, fCREATE_SEPARATE_WOW_VDM, fCREATE_SHARED_WOW_VDM,
      fCREATE_SUSPENDED, fCREATE_UNICODE_ENVIRONMENT, fDEBUG_PROCESS,
        fDEBUG_ONLY_THIS_PROCESS, fDETACHED_PROCESS);

  TDosThreadStatus = ( dtsAllocatingMemory , dtsAllocateMemoryFail ,
                       dtsCreatingPipes    , dtsCreatePipesFail    ,
                       dtsCreatingProcess  , dtsCreateProcessFail  ,
                       dtsRunning          , dtsRunningError       ,
                       dtsSuccess,
                       dtsUserAborted,
                       dtsTimeOut );

  TFileFormat = (ffUnknow, ffELF, ffRAW);

  TFileFormatError = class(Exception);
  TFileNotFoundError = class(Exception);
  TInvalidTreeViewNode = class(Exception);

  TProgressInfo = class
  private
    FTransfertComplete : boolean; //permet de savoir qu'il n'y a plus de output de DC-TOOL
                                  //que de KOS.
    FWorkCount : integer;
    FWorkMax : integer;
    FRootNode : TTreeNode;
    FNowItIsKallistiOSOutputs : boolean;

    FDCTool : TDCTool;
    FSourceFile : string;
    FFileFormat : TFileFormat;
    FInProgress : boolean;
    FProgressBar : TProgressBar;
    FIsDownloading : boolean;
    function InProgress(NewLine : string) : boolean;
    function ContinueProgress(NewLine : string) : integer;
    function IsDetectingFormat(NewLine : string) : boolean;
    function GetFileFormat(NewLine : string) : TFileFormat;
    function IsDetectionElfSize(NewLine : string) : boolean;
    function GetElfSectionSize(NewLine : string) : integer;
    function IsDownloading(NewLine : string) : boolean;
    function GetDownloadSize(NewLine : string) : integer;
    function GetElfSectionName(NewLine: string) : string;
    function GetElfSectionLma(NewLine: string) : string;

    procedure InitElfTreeView;
    procedure AddNewSectionElfTreeView(NewLine : string);
    procedure ChangeIcon(Node: TTreeNode ; ImageIndex : integer);
  public
    constructor Create(DCTool : TDCTool);
    function ProcessLine(NewLine : string) : boolean;
  end;
  
  //---TDosThread---
  TDosThread = class(TThread) //the thread that is waiting for outputs through the pipe
  private
    FDCTool : TDCTool;
    FProgressInfo : TProgressInfo;
    FOwner: TDosComm;
    FCommandLine: string;
    FTimer: TProcessTimer;
    FMaxTimeAfterBeginning: Integer;
    FMaxTimeAfterLastOutput: Integer;
    FOnNewLine: TNewLineEvent;
    FOnTerminated: TTerminateEvent;
    FCreatePipeError: TCreatePipeError;
    FCreateProcessError: TCreateProcessError;
    FPriority: Integer;
    FShowWindow: TShowWindow;
    FCreationFlag: TCreationFlag;
    //
    FProcessInfo_SHARED: ^PROCESS_INFORMATION;
    FOutputStr: String;
    FOutputType: TOutputType;
    procedure FExecute;
  protected
    procedure Execute; override; //call this to create the process
    procedure AddString;
    procedure AddString_SHARED(Str: string; OutType: TOutputType);
  public
    InputLines_SHARED: TstringList;
    FLineBeginned: Boolean;
    FActive: Boolean;
    //constructor Create( AOwner: TDosComm );
    constructor Create(AOwner: TDosComm ; DCTool : TDCTool);
    destructor Destroy; override;
  end;

  //---TDosComm---
  TDosComm = class(TPersistent) //the component to put on a form
  private
    FDCTool : TDCTool;
    FTimer: TProcessTimer;
    FThread: TDosThread;
    FThreadStatus: TDosThreadStatus;
    FCommandLine: string;
    FLines_SHARED: TStringList;
    FInputLines_SHARED: TStringList;
    FOutputLines_SHARED: TStrings;
    FInputToOutput: Boolean;
    FOnNewLine: TNewLineEvent;
    FOnTerminated: TTerminateEvent;
    FMaxTimeAfterBeginning: Integer;
    FMaxTimeAfterLastOutput: Integer;
    FPriority: Integer; //[HIGH_PRIORITY_CLASS, IDLE_PRIORITY_CLASS,
                        // NORMAL_PRIORITY_CLASS, REALTIME_PRIORITY_CLASS]
    FShowWindow: TShowWindow;
    FCreationFlag: TCreationFlag;
    FExitCode: Integer;
    //
    //
    FProcessInfo_SHARED: PROCESS_INFORMATION;
    FReturnCode: TReturnCode;
    FOutputReturnCode: TReturnCode;
    FSync :TMultiReadExclusiveWriteSynchronizer;

    function GetPrompting:boolean;
    function GetActive:boolean;
    function GetSinceBeginning: Integer;
    function GetSinceLastOutput:integer;
    procedure SetOutputLines_SHARED(Value: TStrings);

    //Modification SiZiOUS
    procedure Execute; //the user call this to execute the command
    function Execute2: Integer; //the user call this to execute the command

    procedure Stop; //the user can stop the process with this method
  protected
    { DÈclarations protÈgÈes }
  public
    constructor Create(AOwner : TDCTool);
    destructor Destroy; override; //++ tk

    //procedure Execute; //the user call this to execute the command
    //function Execute2: Integer; //the user call this to execute the command

    //procedure Stop; //the user can stop the process with this method
    procedure SendLine(Value: string; Eol: Boolean); //add a line in the input pipe
    property OutputLines: TStrings read FOutputLines_SHARED write SetOutputLines_SHARED;
      //can be Lines_SHARED of a memo, a richedit, a listbox, ...
    property Lines: TStringList read FLines_SHARED;
       //if the user want to access all the outputs of a process, he can use this property
    property Priority: Integer read FPriority write FPriority; //priority of the process
    property Active: Boolean read GetActive;
    property Prompting:boolean read GetPrompting;
    property SinceBeginning: Integer read GetSinceBeginning;
    property SinceLastOutput:integer read GetSinceLastOutput;

    property ExitCode: Integer read FExitCode write FExitCode;
    //
    //
    property ProcessInfo:PROCESS_INFORMATION read FProcessInfo_SHARED;
    property ThreadStatus:TDosThreadStatus read FThreadStatus write FThreadStatus;
    property Sync: TMultiReadExclusiveWriteSynchronizer read FSync;

    function GetVersion : string;
  published
    //command to execute
    //property CommandLine: string read FCommandLine write FCommandLine;

    property InputToOutput: Boolean read FInputToOutput write FInputToOutput;
      //check it if you want that the inputs appear also in the outputs
    property MaxTimeAfterBeginning: Integer read FMaxTimeAfterBeginning
      write FMaxTimeAfterBeginning; //maximum time of execution
    property MaxTimeAfterLastOutput: Integer read FMaxTimeAfterLastOutput
      write FMaxTimeAfterLastOutput; //maximum time of execution without an output
    property ShowWindow : TShowWindow read FShowWindow write FShowWindow;
      // window type
    property CreationFlag : TCreationFlag read FCreationFlag write FCreationFlag;
      // window type
    property ReturnCode: TReturnCode read FReturnCode write FReturnCode;
    property OutputReturnCode: TReturnCode read FOutputReturnCode;

    //===EVENEMENTS===

    //event for each new line that is received through the pipe
    property OnNewLine: TNewLineEvent read FOnNewLine write FOnNewLine;
    //event for the end of the process (normally, time out or by user (DosCommand.Stop;))
    property OnTerminated: TTerminateEvent read FOnTerminated write FOnTerminated;
  end;
  
  TConnectionType = (ctSerial, ctBBA, ctUSB);

  TProgressBeginEvent = procedure(Sender: TObject; MaxSize : integer) of object;
  TProgressWorkEvent = procedure(Sender: TObject ; CurrentWork : integer) of object;
  TProgressEndEvent = procedure(Sender: TObject) of object;
  
  TIsDetectingFileFormatEvent = procedure(Sender: TObject ; FileInfo : TFileFormat) of object;
  TIsDetectingElfSizeEvent = procedure(Sender: TObject ; SectionName : string ;
    SectionLma : string ; SectionSize : integer) of object;
  TOnOnGetDownloadSizeEvent = procedure(Sender: TObject ; DownloadSize : integer) of object;

  TOnCreateCommandLineEvent = procedure(Sender: TObject ; CommandLine : string) of object;

  TStartEvent = procedure(Sender: TObject ; OperationType : TOperationType) of object;

  TEndDcToolLinesEvent = procedure(Sender: TObject) of object;

  TResetEvent = procedure(Sender: TObject) of object;
  
  //---TDCTool---
  TDCTool = class(TComponent)
  private
    FGetLastOperation : TOperationType; //avoir le type de la derniere operation (et donc celle en cours
                                        //si c'est en cours).

    FConnectionType : TConnectionType;
    FDosComm: TDosComm;
    FProgressBar: TProgressBar;
    FUploadOptions: TUpload;
    FDownloadOptions: TDownload;
    FIsoRedirection: TIsoRedirection;
    FChRoot: TChRoot;
    FOptions: TOptions;
    FSerial: TSerialCom;
    FBroadBand: TBBACom;
    FUSB: TUSBCom;
    FOnProgressBegin: TProgressBeginEvent;
    FFileName: TFileName;
    FOnProgressWork: TProgressWorkEvent;
    FOnDetectingFileFormat: TIsDetectingFileFormatEvent;
    FOnProgressEnd: TProgressEndEvent;
    FOnDetectingElfSize: TIsDetectingElfSizeEvent;
    FOnGetDownloadSize: TOnOnGetDownloadSizeEvent;
    FOnCreateCommandLine: TOnCreateCommandLineEvent;
    FShowTextProgress: boolean;
    FNewDcToolLine: TNewLineEvent;
    FElfTreeView: TTreeView;
    FOnStart: TStartEvent;
    FOnEndDcToolLines: TEndDcToolLinesEvent;
    FOnReseting: TResetEvent;
    FOnReseted: TResetEvent;
    FOnAborted: TNotifyEvent;
    FOnAborting: TNotifyEvent;
    FGetLastAborted : boolean;
    procedure SetConnectionType(const Value: TConnectionType);
    procedure SetDosComm(const Value: TDosComm);
    procedure SetProgressBar(const Value: TProgressBar);
    procedure SetUploadOptions(const Value: TUpload);
    procedure SetDownloadOptions(const Value: TDownload);
    procedure SetIsoRedirection(const Value: TIsoRedirection);
    procedure SetChRoot(const Value: TChRoot);
    procedure SetOptions(const Value: TOptions);
    procedure SetBroadBand(const Value: TBBACom);
    procedure SetUSB(const Value: TUSBCom);
    procedure SetSerial(const Value: TSerialCom);
    function ReadFOnNewLine: TNewLineEvent;
    procedure SetFOnNewLine(const Value: TNewLineEvent);
    function ReadFOnTerminated: TTerminateEvent;
    procedure SetFOnTerminated(const Value: TTerminateEvent);
    procedure SetFileName(const Value: TFileName);
    procedure KillAllDcTools;
    procedure SetElfTreeView(const Value: TTreeView);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Upload : boolean;
    function Download : boolean;
    procedure Abort;
    procedure Stop; //pareil que Abort
    function Reset : boolean;
    procedure SaveToFile(FileName : TFileName);
    procedure LoadFromFile(FileName : TFileName);
    function GetLastOperation : TOperationType;
    function IsActive : boolean;
    function IsLastAborted : boolean;
    function GetVersion : string;
  published
    //** PropriÈtÈs TPersistent **
    property DosComm : TDosComm read FDosComm write SetDosComm;
    property UploadOptions : TUpload read FUploadOptions write SetUploadOptions;
    property DownloadOptions : TDownload read FDownloadOptions write SetDownloadOptions;
    property IsoRedirection : TIsoRedirection read FIsoRedirection write SetIsoRedirection;
    property ChRoot : TChRoot read FChRoot write SetChRoot;
    property Options : TOptions read FOptions write SetOptions;
    property Serial : TSerialCom read FSerial write SetSerial;
    property BroadBand : TBBACom read FBroadBand write SetBroadBand;
    property USB : TUSBCom read FUSB write SetUSB;
                                                          
    //** PropriÈtÈs. **
    property FileName : TFileName read FFileName write SetFileName;
    property ConnectionType : TConnectionType read FConnectionType write SetConnectionType;
    property ProgressBar : TProgressBar read FProgressBar write SetProgressBar;
    property ElfTreeView : TTreeView read FElfTreeView write SetElfTreeView;
    property ShowTextProgress : boolean read FShowTextProgress write FShowTextProgress;

    //** EvËnements. **
    property OnNewLine: TNewLineEvent read ReadFOnNewLine write SetFOnNewLine;
    property OnNewDcToolLine: TNewLineEvent read FNewDcToolLine write FNewDcToolLine;
    property OnTerminated: TTerminateEvent read ReadFOnTerminated write SetFOnTerminated;

    property OnProgressBegin : TProgressBeginEvent read FOnProgressBegin write FOnProgressBegin;
    property OnProgressWork : TProgressWorkEvent read FOnProgressWork write FOnProgressWork;
    property OnProgressEnd : TProgressEndEvent read FOnProgressEnd write FOnProgressEnd;

    property OnDetectingFileFormat : TIsDetectingFileFormatEvent
      read FOnDetectingFileFormat write FOnDetectingFileFormat;
    property OnDetectingElfSize : TIsDetectingElfSizeEvent read FOnDetectingElfSize
      write FOnDetectingElfSize;

    property OnGetDownloadSize : TOnOnGetDownloadSizeEvent read FOnGetDownloadSize
      write FOnGetDownloadSize;

    property OnCreateCommandLine : TOnCreateCommandLineEvent read FOnCreateCommandLine
      write FOnCreateCommandLine;

    property OnStart : TStartEvent read FOnStart write FOnStart;

    property OnEndDcToolLines : TEndDcToolLinesEvent read FOnEndDcToolLines write
      FOnEndDcToolLines;

    property OnReseting : TResetEvent read FOnReseting write FOnReseting; //avant le reset
    property OnReseted : TResetEvent read FOnReseted write FOnReseted; //aprËs le reset

    property OnAborting : TNotifyEvent read FOnAborting write FOnAborting;
    property OnAborted : TNotifyEvent read FOnAborted write FOnAborted;
    //pour dÈclancher : if Assigned(FOnProgressBegin) then FOnProgressBegin(Self);
  end;

procedure Register;

//==============================================================================
implementation
//==============================================================================

uses
  GetProc, dctool_utils;
  
type
  TCharBuffer = array[0..MaxInt - 1] of Char;

const
  ShowWindowValues : array [0..11] of Integer = (SW_HIDE, SW_MAXIMIZE,
    SW_MINIMIZE, SW_RESTORE, SW_SHOW, SW_SHOWDEFAULT, SW_SHOWMAXIMIZED,
      SW_SHOWMINIMIZED, SW_SHOWMINNOACTIVE, SW_SHOWNA, SW_SHOWNOACTIVATE,
        SW_SHOWNORMAL);

  CreationFlagValues : array [0..9] of Integer = (CREATE_DEFAULT_ERROR_MODE,
    CREATE_NEW_CONSOLE, CREATE_NEW_PROCESS_GROUP, CREATE_SEPARATE_WOW_VDM,
      CREATE_SHARED_WOW_VDM, CREATE_SUSPENDED, CREATE_UNICODE_ENVIRONMENT,
        DEBUG_PROCESS, DEBUG_ONLY_THIS_PROCESS, DETACHED_PROCESS);

  DEF_UPLOAD_ADDRESS    : string = '0x8C010000';
  DEF_DOWNLOAD_ADDRESS  : string = '0x8C010000';
  DEF_DOWNLOAD_SIZE     : integer = 1024;

//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('DC-TOOL GUI', [TDCTool]);
end;

//------------------------------------------------------------------------------

procedure ShowException(Message : string);
begin
  MessageBoxA(0, PChar(Message), 'TDCTool Exception', MB_SYSTEMMODAL);
end;

//==============================================================================

{ TBBACom }

constructor TBBACom.Create(DCTool : TDCTool);
begin
  try
    FIPAddress := '000.000.000.000';
    FDCTool := DCTool;
  except
    ShowException('Exception in TBBACom.Create.');
    //raise TConstructorError.Create('Exception in TBBACom.Create.');
  end;
end;

//------------------------------------------------------------------------------

function TBBACom.GetCompleteLine(OperationType : TOperationType) : string;
var
  FileAndPort,
  UploadCfg,
  DownloadCfg : string;

begin
  //'dc-tool -d DUMMY.BIN -s 0x20000 -t COM1 -b 115200 -a 0x8C010000 -e';

  //Le fichier exite ?
  if not FileExists(Executable) then
  begin
    raise TDCToolExecutableError.Create('File not found "' + Executable + '".');
    Exit;
  end;

  Result := '"' + Executable + '"';

  if OperationType = otReset then
    FileAndPort := DEVICE_PORT + ' ' + FIPAddress //pas besoin du fichier.
  else FileAndPort := ' "' + FDCTool.FileName + '"' + DEVICE_PORT + ' ' + FIPAddress;

  //Invalid ip ?
  if not ValidIP(IPAddress) then
  begin
    //oui... *BIIIIM* !!!! :p
    raise TInvalidIPError.Create('Invalid IP : "' + FIPAddress + '".');
    Exit;
  end;

  UploadCfg := FDCTool.UploadOptions.GetUploadConfig + ' ';
  DownloadCfg := FDCTool.DownloadOptions.GetDownloadConfig;

  case OperationType of
    otUpload        : Result := Result + UPLOAD_SW + FileAndPort + UploadCfg;
    otUploadExecute : Result := Result + UPLOAD_EXECUTE + FileAndPort + UploadCfg;
    otDownload      : Result := Result + DOWNLOAD_SW + FileAndPort + DownloadCfg;
    otReset         : Result := Result + RESET_DC_TOOL + FileAndPort;
  end;

  Result := Result + FDCTool.Options.GetOptions;
end;

//------------------------------------------------------------------------------

function TBBACom.IsValidIp: boolean;
begin
  Result := ValidIP(IPAddress);
end;

//------------------------------------------------------------------------------

procedure TBBACom.SetExecutable(const Value: TFileName);
begin
  {if Length(Value) = 0 then
  begin
    FExecutable := '';
    Exit;
  end; 

  if not FileExists(Value) then
  begin
    raise TDCToolExecutableError.Create('File not found "' + Value + '".');
    Exit;
  end;  }

  FExecutable := Value;
end;

//------------------------------------------------------------------------------

procedure TBBACom.SetIPAddress(const Value: string);
begin
  FIPAddress := Value;
end;

{ TChRoot }

constructor TChRoot.Create;
begin
  try
    FEnabled := False;
  except
    //raise TConstructorError.Create('Exception in TChRoot.Create.');
    ShowException('Exception in TChRoot.Create.');
  end;
end;

//------------------------------------------------------------------------------

function TChRoot.GetCompleteLine: string;
begin
  Result := '';

  //Si c'est enabled on veut traiter Áa
  if Enabled then
  begin

    if not DirectoryExists(Path) then
    begin
      raise TChRootDirectoryError.Create('Directory not found "' + Path + '".');
      Exit;
    end;

    //le dossier exite ?
    if DirectoryExists(Path) then
      Result := CHROOT_TO_PATH + ' "' + Path + '"'; //ok

  end;

end;

//------------------------------------------------------------------------------

procedure TChRoot.SetChrootToPath(const Value: string);
begin
{  if Length(Value) = 0 then
  begin
    FChrootToPath := '';
    Exit;
  end;

  if not DirectoryExists(Value) then
  begin
    raise TChRootDirectoryError.Create('Directory not found "' + Value + '".');
    Exit;
  end;  }

  FChrootToPath := Value;
end;

//------------------------------------------------------------------------------

procedure TChRoot.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

//------------------------------------------------------------------------------

{ TDownload }

constructor TDownload.Create(DCTool: TDCTool);
begin
  try
    FDCTool := DCTool;
    FAddress := GetDefaultAddress;
  except
    //raise TConstructorError.Create('Exception in TDownload.Create.');
    ShowException('Exception in TDownload.Create.');
  end;
end;

//------------------------------------------------------------------------------

function TDownload.GetDefaultAddress: string;
begin
  Result := DEF_DOWNLOAD_ADDRESS;
end;

//------------------------------------------------------------------------------

function TDownload.GetDefaultDownloadSize: integer;
begin
  Result := DEF_DOWNLOAD_SIZE;
end;

//------------------------------------------------------------------------------

function TDownload.GetDownloadConfig: string;
begin
  Result := DOWNLOAD_SIZE + ' ' + IntToStr(Self.FileSize)
    + ADDRESS_SW + ' ' + Address;
end;

//------------------------------------------------------------------------------

procedure TDownload.SetAddress(const Value: string);
begin
  FAddress := Value;
end;

//------------------------------------------------------------------------------

procedure TDownload.SetDownSize(const Value: integer);
begin
  FDownSize := Value;
end;

//------------------------------------------------------------------------------

{ TSerialCom }

function TSerialCom.BaudrateToStr(Baudrate: TBaudrate): string;
var
  numarray : integer;

begin
  numarray := Ord(Baudrate);
  Result := IntToStr(Bauds[numarray]);
end;

//------------------------------------------------------------------------------

function TSerialCom.ComPortToStr(ComPort: TComPort): string;
var
  numport : integer;

begin
  numport := Ord(ComPort);
  Result := 'COM' + IntToStr(numport + 1);
end;

//------------------------------------------------------------------------------

constructor TSerialCom.Create(DCTool : TDCTool);
begin
  try
    FComPort := cpCOM1;
    FBaudrate := b57600;
    FDCTool := DCTool;
  except
    //raise TConstructorError.Create('Exception in TSerialCom.Create.');
    ShowException('Exception in TSerialCom.Create.');
  end;
end;

//------------------------------------------------------------------------------

function TSerialCom.GetCompleteLine(OperationType: TOperationType): string;
var
  FileAndPort,
  UploadCfg,
  DownloadCfg : string;

begin
  //'dc-tool -d DUMMY.BIN -s 0x20000 -t COM1 -b 115200 -a 0x8C010000 -e';

  //Le fichier exite ?
  if not FileExists(Executable) then
  begin
    raise TDCToolExecutableError.Create('File not found "' + Executable + '".');
    Exit;
  end;

  Result := '"' + Executable + '"';
    
  FileAndPort := ' "' + FDCTool.FileName + '"' + DEVICE_PORT + ' ' + ComPortToStr(ComPort)
    + BAUDRATE_SW + ' ' + BaudrateToStr(Baudrate);

  //Si le baudrate alternÈ est activÈ (et bien sur si c'est 115200) alors
  //on rajoute le switch. 
  if (AlternateBaudrate) and (Baudrate = b115200) then
    FileAndPort := FileAndPort + ALTERNATE_BAUD; 

  UploadCfg := FDCTool.UploadOptions.GetUploadConfig + ' ';
  DownloadCfg := FDCTool.DownloadOptions.GetDownloadConfig;

  case OperationType of
    otUpload        : Result := Result + UPLOAD_SW + FileAndPort + UploadCfg;
    otUploadExecute : Result := Result + UPLOAD_EXECUTE + FileAndPort + UploadCfg;
    otDownload      : Result := Result + DOWNLOAD_SW + FileAndPort + DownloadCfg;
    otReset         : Result := Result + RESET_DC_TOOL + FileAndPort;
  end;

  Result := Result + FDCTool.Options.GetOptions;
end;

//------------------------------------------------------------------------------

procedure TSerialCom.SetAlternateBaudrate(const Value: boolean);
begin
  FAlternateBaudrate := Value;
end;

//------------------------------------------------------------------------------

procedure TSerialCom.SetBaudrate(const Value: TBaudrate);
begin
  FBaudrate := Value;
end;

//------------------------------------------------------------------------------

procedure TSerialCom.SetComPort(const Value: TComPort);
begin
  FComPort := Value;
end;

//------------------------------------------------------------------------------

procedure TSerialCom.SetExecutable(const Value: TFileName);
begin
  { if Length(Value) = 0 then
  begin
    FExecutable := '';
    Exit;
  end;
  
  if not FileExists(Value) then
  begin
    raise TDCToolExecutableError.Create('File not found "' + Value + '".');
    Exit;
  end;  }
  
  FExecutable := Value;
end;

//------------------------------------------------------------------------------

{ TUpload }

function TUpload.GetFileInUseProtectFile(FileName : TFileName) : string;
begin
  Result := GetRealPath(ExtractFilePath(FileName)) + '~' + ExtractFileName(FileName);
end;

//------------------------------------------------------------------------------

procedure TUpload.DeleteFileInUseProtection;
var
  NewFile : string;

begin
  //Protection "File in use" pour l'upload, idÈe de JMD.
  if not FDCTool.UploadOptions.FFileInUseProtection then
  begin
    raise TFileInUseProtectionError.Create('Hey! You shouldn''t be here if the'
      + ' the UploadOptions.FileInUseProtection isn''t setup to TRUE!!!');
    Exit;
  end;

  NewFile := GetFileInUseProtectFile(FDCTool.FileName);
  if FileExists(NewFile) then DeleteFile(NewFile);

  //la suite est d'origine de DC-TOOL GUI 3
{  if (FDCTool.GetLastOperation = otUpload) or
    (FDCTool.GetLastOperation = otUploadExecute) then
    begin

      if Upload_Form.cbCopyProtect.Checked then
      begin
        //if FileExists(FDCTool.FileName) then DeleteFile(FDCTool.FileName);
        //DCTool.FileName := Upload_Form.cbxTargetFile.Text;
          //ceci pour la fonction "re-execute..." car le fichier est effacÈ
          //‡ la fin! (on remet le vrai fichier !)
      end;

      //Ceci efface le fichier temporaire transmit ‡ la fin du transfert.
      //pourquoi cela ? parce qu'on la crÈe avec la copy protection,
      //en plus, uniquement pour l'upload & upload execute (que Áa m'efface
      //pas le fichier que je viens de download ou lors d'un reset, par
      //exemple !!!)
    end;   }
end;

//------------------------------------------------------------------------------

function TUpload.CreateFileInUseProtection : string;
var
  NewFile : string; //NewFile contiendra le fichier qui servira ‡ "file in use" protect.
  OK      : boolean;

begin
  Result := '';
  
  //if not Upload_Form.cbCopyProtect.Checked then
  //  DCTool.FileName := Target
  //else begin
  NewFile := GetFileInUseProtectFile(FDCTool.FileName);

  OK := CopyFile(PChar(FDCTool.FileName), PChar(NewFile), False);

  if not OK then
  begin
    raise TFileInUseProtectionError.Create('Error when using the "file in use" protection.'
      + #13 + #10 + 'The original file''ll be used instead.');
    Exit;
    //DCTool.FileName := Target;
  end

  else Result := NewFile;
  //else DCTool.FileName := NewFile;

  //end;  

end;

//------------------------------------------------------------------------------

constructor TUpload.Create(DCTool : TDCTool);
begin
  try
    FDCTool := DCTool;
    FExecuteAddress := GetDefaultAddress;
    FExecuteAfterUpload := True;
    FRealDcToolFileName := '';
    FFileInUseProtection := False;
  except
    //raise TConstructorError.Create('Exception in TUpload.Create.');
    ShowException('Exception in TUpload.Create.');
  end;
end;
 
//------------------------------------------------------------------------------

function TUpload.GetUploadConfig: string;
begin
  Result := ADDRESS_SW + ' ' + ExecuteAddress + FDCTool.ChRoot.GetCompleteLine
    + FDCTool.IsoRedirection.GetCompleteLine;
end;

//------------------------------------------------------------------------------

procedure TUpload.SetExecuteAddress(const Value: string);
begin
  FExecuteAddress := Value;
end;

//------------------------------------------------------------------------------

procedure TUpload.SetExecuteAfterUpload(const Value: boolean);
begin
  FExecuteAfterUpload := Value;
end;

//===[:: TProcessTimer ::]======================================================

constructor TProcessTimer.Create(AOwner: TComponent);
begin
  try
    inherited Create(AOwner);
    Enabled := False; //timer is off
    OnTimer := MyTimer;
  except
    //raise TConstructorError.Create('Exception in TProcessTimer.Create.');
    ShowException('Exception in TProcessTimer.Create.');
  end;
end;

//------------------------------------------------------------------------------

procedure TProcessTimer.MyTimer(Sender: TObject);
begin
  Inc(FSinceBeginning);
  Inc(FSinceLastOutput);
end;

//------------------------------------------------------------------------------

procedure TProcessTimer.Beginning;
begin
  Interval := 1000; //time is in sec
  FSinceBeginning := 0; //this is the beginning
  FSinceLastOutput := 0;
  Enabled := True; //set the timer on
end;

//------------------------------------------------------------------------------

procedure TProcessTimer.NewOutput;
begin
  FSinceLastOutput := 0; //a new output has been caught
end;
 
//------------------------------------------------------------------------------

procedure TProcessTimer.Ending;
begin
  Enabled := False; //set the timer off
end;

//------------------------------------------------------------------------------

{ TOptions }

constructor TOptions.Create(DCTool : TDCTool);
begin
  try
    FAttachFileServer := True;
    FUseDumbTerminal := False;
    FClrScrBeforeDownload := True;
    FDCTool := DCTool;
  except
    //raise TConstructorError.Create('Exception in TOptions.Create.');
    ShowException('Exception in TOptions.Create.');
  end;
end;

//------------------------------------------------------------------------------

function TOptions.GetOptions: string;
begin
  Result := '';

  if not AttachFileServer then
    Result := Result + DONT_ATTACH_CONSOLE_AND_FILESERVER;

  if not ClrScrBeforeDownload then
    Result := Result + DONT_CLEAR_SCREEN_BEFORE_DOWNLOAD;

  //Le Dumb Terminal n'est pas accessible pour le BBA.
  if (FDCTool.ConnectionType <> ctBBA) then
    if UseDumbTerminal then
      Result := Result + USE_DUMB_TERMINAL;
    
end;

//------------------------------------------------------------------------------

procedure TOptions.SetAttachFileServer(const Value: boolean);
begin
  FAttachFileServer := Value;
end;

//------------------------------------------------------------------------------

procedure TOptions.SetClrScrBeforeDownload(const Value: boolean);
begin
  FClrScrBeforeDownload := Value;
end;

//------------------------------------------------------------------------------

procedure TOptions.SetUseDumbTerminal(const Value: boolean);
begin
  FUseDumbTerminal := Value;
end;

//===[:: TDosThread ::]=========================================================

procedure TDosThread.FExecute;
const
  MaxBufSize = 1024;
  
var
  pBuf          : ^TCharBuffer; //i/o buffer
  iBufSize      : Cardinal;
  app_spawn     : PChar;
  si            : STARTUPINFO;
  sa            : PSECURITYATTRIBUTES; //security information for pipes
  sd            : PSECURITY_DESCRIPTOR;
  pi            : PROCESS_INFORMATION;
  newstdin,
  newstdout,
  read_stdout,
  write_stdin   : THandle; //pipe handles
  Exit_Code     : LongWord; //process exit code
  bread         : LongWord; //bytes read
  avail         : LongWord; //bytes available
  Str, Last     : string;
  //PStr: PChar;
  I, II         : LongWord;
  eol, EndCR    : boolean; // tk

begin //FExecute

  //messageboxa(0, pchar(CommandLine), '', 0);

  //For free self
  try
    FOwner.ThreadStatus := dtsAllocatingMemory;
    GetMem(sa, SizeOf(SECURITY_ATTRIBUTES));

    //initialize security descriptor (Windows NT)
    if (Win32Platform = VER_PLATFORM_WIN32_NT) then
    begin
      GetMem(sd, sizeof(SECURITY_DESCRIPTOR));
      InitializeSecurityDescriptor(sd, SECURITY_DESCRIPTOR_REVISION);
      SetSecurityDescriptorDacl(sd, true, nil, false);
      sa.lpSecurityDescriptor := sd;
    end else begin
      sa.lpSecurityDescriptor := nil;
      sd := nil;
    end;

    sa.nLength := sizeof(SECURITY_ATTRIBUTES);
    sa.bInheritHandle := true; //allow inheritable handles
    iBufSize := MaxBufSize;
    pBuf := AllocMem(iBufSize); // Reserve and init Buffer

    //---[:: Memory allocated ::]-----------------------------------------------
    try

      FOwner.ThreadStatus := dtsCreatingPipes;
      if not (CreatePipe(newstdin, write_stdin, sa, 0)) then //create stdin pipe
      begin
        raise FCreatePipeError;
        Exit;
      end;

      if not (CreatePipe(read_stdout, newstdout, sa, 0)) then //create stdout pipe
      begin
        CloseHandle(newstdin);
        CloseHandle(write_stdin);
        raise FCreateProcessError;  //  êÊÇ… raise ÇµÇƒÇÕÇ»ÇÁÇ»Ç¢ÅB
        Exit;
      end;

      //---[:: Handles for pipes ::]--------------------------------------------
      try

        FOwner.ThreadStatus := dtsCreatingProcess;
        GetStartupInfo(si); //set startupinfo for the spawned process
           {  The dwFlags member tells CreateProcess how to make the process.
              STARTF_USESTDHANDLES validates the hStd* members. STARTF_USESHOWWINDOW
              validates the wShowWindow member. }
        si.dwFlags := STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
        si.wShowWindow := ShowWindowValues[Ord(FShowWindow)]; //SW_SHOW; //SW_HIDE; //SW_SHOWMINIMIZED;
        si.hStdOutput := newstdout;
        si.hStdError := newstdout; //set the new handles for the child process
        si.hStdInput := newstdin;
        app_spawn := PChar(FCommandLine);

        //spawn the child process

        //New(
        //messageboxa(0, pchar(FCommandLine + #13 + #10 + app_spawn), '', 0);

    //Flags : {CREATE_NEW_CONSOLE}{DETACHED_PROCESS}
    if not (CreateProcess(nil, app_spawn, nil, nil, TRUE,
      CreationFlagValues[Ord(FCreationFlag)] or FPriority, nil, nil, si, pi)) then
    begin
          //  ó·äOÇéÛÇØéÊÇÈèÍèäÇ™ñ≥Ç¢ÅB
          //  ÉXÉåÉbÉhÇÃ exitcode Ç…ì¸ÇÍÇÈÇ◊Ç´ÅHÅB
      FCreateProcessError := TCreateProcessError.Create(string(app_spawn)
        + ' doesn''t exist.' + #13 + #10
        + 'This''s a really boring error, you shouldn''t have it... !');
      raise FCreateProcessError;
      Exit;
    end;

    FTimer.Beginning; //turn the timer on
    Exit_Code := STILL_ACTIVE;
    try /// handles of process

      FOwner.ThreadStatus := dtsRunning;
      Last := ''; // Buffer to save last output without finished with CRLF
      FLineBeginned := False;
      EndCR := False;

      repeat //main program loop
              //  ê∂Ç´ÇƒÇ¢ÇÍÇŒ STILL_ACTIVE éÄÇÒÇ≈Ç¢ÇÍÇŒèIóπÉRÅ[ÉhÇ™ÇΩÇæÇøÇ…ï‘ÇÈÅB
              //  éÄÇÒÇ≈Ç¢ÇƒÇ‡ÉpÉCÉvÇÃÉfÅ[É^ÇÕóLå¯ÅB
        GetExitCodeProcess(pi.hProcess, Exit_Code); //while the process is running
              //  èoóÕÉpÉCÉvÇ©ÇÁ pBuf Ç…éÊÇËçûÇﬁÅB
        PeekNamedPipe(read_stdout, pBuf, iBufSize, @bread, @avail, nil);
        //check to see if there is any data to read from stdout
              //  èoóÕÇ™Ç†ÇÍÇŒ
        if (bread <> 0) then begin
          if (iBufSize < avail) then begin // If BufferSize too small then rezize
            iBufSize := avail;
            ReallocMem(pBuf, iBufSize);
          end;
          FillChar(pBuf^, iBufSize, #0); //empty the buffer
          ReadFile(read_stdout, pBuf^, iBufSize, bread, nil); //read the stdout pipe
          Str := Last; //take the begin of the line (if exists)

          i := 0;
          while ((i < bread) and not (Terminated)) do
          begin
            case pBuf^[i] of
              #0: Inc(i);
              #10, #13:
                begin
                  Inc(i);
                  if not (EndCR and (pBuf^[i - 1] = #10)) then
                  begin
                    if (i < bread) and (pBuf^[i - 1] = #13) and (pBuf^[i] = #10) then
                    begin
                      Inc(i);
                      FOwner.FOutputReturnCode := rcCRLF;
                      //Str := Str + #13#10;
                    end
                    else
                    begin
                      FOwner.FOutputReturnCode := rcLF;
                      //Str := Str + #10;
                    end;
                    //so we don't test the #10 on the next step of the loop
                    //FTimer.NewOutput; //a new ouput has been caught
                    AddString_SHARED(Str, otEntireLine);
                    Str := '';
                  end;
                end;
            else
              begin
                Str := Str + pBuf^[i]; //add a character
                Inc(i);
              end;
            end;
          end;
          EndCR := (pBuf^[i - 1] = #13);
          Last := Str; // no CRLF found in the rest, maybe in the next output
          if (Last <> '') then begin
            AddString_SHARED(Last, otBeginningOfLine);
          end;
              //  èoóÕÇ™ñ≥Ç¢èÍçáÅB
        end
        else
        begin
        //send Lines in input (if exist)
          //FOwner.sync.beginWrite ;
          try
            while ((InputLines_SHARED.Count > 0) and not (Terminated)) do
            begin
                //	enough size?
              II := Length(InputLines_SHARED[0]);
              if (iBufSize < II) then
                iBufSize := II;
              FillChar(pBuf^, iBufSize, #0); //clear the buffer
              eol := (Pos(#13#10, InputLines_SHARED[0]) = II - 1) or (Pos(#10, InputLines_SHARED[0]) = II);
              for I := 0 to II - 1 do
                pBuf^[I]:=InputLines_SHARED[0][I + 1];
              WriteFile(write_stdin, pBuf^, II, bread, nil); //send it to stdin
              if FOwner.FInputToOutput then //if we have to output the inputs
              begin
                if FLineBeginned then
                  Last := Last + InputLines_SHARED[0]
                else
                  Last := InputLines_SHARED[0];
                if eol then
                begin
                  AddString_SHARED(Last, otEntireLine);
                  Last := '';
                end
                else
                  AddString_SHARED(Last, otBeginningOfLine);
              end;
              InputLines_SHARED.Delete(0); //delete the line that has been send
            end;
          finally
            //FOwner.sync.EndWrite ;
          end;
        end;

        Sleep(1); // Give other processes a chance
        //Application.ProcessMessages;

        if Exit_Code <> STILL_ACTIVE then begin
          FOwner.ThreadStatus := dtsSuccess;
          FOwner.FExitCode := Exit_Code;
          //ReturnValue := Exit_Code;
          break;
        end;

        if Terminated then begin //the user has decided to stop the process
          FOwner.ThreadStatus := dtsUserAborted;
          break;
        end;

        if ((FMaxTimeAfterBeginning < FTimer.FSinceBeginning)
        and (FMaxTimeAfterBeginning > 0)) //time out
        or ((FMaxTimeAfterLastOutput < FTimer.FSinceLastOutput)
        and (FMaxTimeAfterLastOutput > 0))
        then begin
          FOwner.ThreadStatus := dtsTimeOut;
          break;
        end;

      until (Exit_Code <> STILL_ACTIVE); //process terminated (normally)

      if (Last <> '') then // If not empty flush last output
        AddString_SHARED(Last, otBeginningOfLine);

    finally /// handles of process
      if (Exit_Code = STILL_ACTIVE) then
        TerminateProcess(pi.hProcess, 0);
      FTimer.Ending; //turn the timer off
      CloseHandle(pi.hThread);
      CloseHandle(pi.hProcess);
    end;

    finally /// handles for pipes
      CloseHandle(newstdin); //clean stuff up
      CloseHandle(newstdout);
      CloseHandle(read_stdout);
      CloseHandle(write_stdin);
    end;

    finally /// memory(1)
      FreeMem(pBuf);
      if (Win32Platform = VER_PLATFORM_WIN32_NT) then
        FreeMem(sd);
      FreeMem(sa);
    end;

    finally /// free self
      if Assigned(FOnTerminated) then
        FOnTerminated(FOwner, Exit_Code);
      case FOwner.ThreadStatus of
      dtsAllocatingMemory:
        begin
          FOwner.ThreadStatus := dtsAllocateMemoryFail ;
          FOwner.FExitCode := GetLastError;
        end;
      dtsCreatingPipes:
        begin
          FOwner.ThreadStatus := dtsCreatePipesFail ;
          FOwner.FExitCode := GetLastError;
        end;
      dtsCreatingProcess:
        begin
          FOwner.ThreadStatus := dtsCreateProcessFail ;
          FOwner.FExitCode := GetLastError;
        end;
      dtsRunning:
        begin
          FOwner.ThreadStatus := dtsRunningError ;
          FOwner.FExitCode := GetLastError;
        end;
      end;
      FreeOnTerminate := true;
      FActive := False;
      terminate;
    end;

    //messageboxa(0, pchar(FCommandLine + #13 + #10 + app_spawn), '', 0);
end;

//------------------------------------------------------------------------------

procedure TDosThread.Execute;
begin
  try
    FExecute;
  except
    on E: TCreatePipeError do Application.ShowException(E);
    on E: TCreateProcessError do Application.ShowException(E);
  end;
end;

//------------------------------------------------------------------------------

procedure TDosThread.AddString_SHARED(Str: string; OutType: TOutputType);
begin
  try
    FOwner.Lines.Add(str);  // ??
    FTimer.NewOutput; //a new ouput has been caught
    FOutputStr := Str;
    FOutputType := OutType;
    Synchronize(AddString);
  except
  end;
end;

//------------------------------------------------------------------------------

procedure TDosThread.AddString;
var
  PrgInf : boolean;

begin
    if Assigned(FOwner.OutputLines) then
    begin
      FOwner.OutputLines.BeginUpdate;
      try
        if FOwner.OutputLines.Count = 0 then
        begin
          if (FOutputType = otEntireLine) then
            FOwner.OutputLines.Add(FOutputStr)
          else
            FOwner.OutputLines.Text := FOutputStr;
        end
        else
        begin
          // change the way to add by last addstring type
          if FLineBeginned then
            FOwner.OutputLines[FOwner.OutputLines.Count - 1] := FOutputStr
          else
            FOwner.OutputLines.Add(FOutputStr);
        end;
      finally
        FOwner.OutputLines.EndUpdate;
      end;
    end;
    FLineBeginned := (FOutputType = otBeginningOfLine);

    //--------------------------------------------------------------------------

    //Analyser la sortie du TDosCommand.
    PrgInf := FProgressInfo.ProcessLine(FOutputStr);

    //Si c'est un progress, et qu'on en veut pas, on sort.
    if PrgInf and not FDCTool.FShowTextProgress then Exit;

    //On le fait dÈj‡ pour activer FTransfertComplete, mais Áa "foire" car ca
    //affiche aussi les "--". Donc on les vires avec Áa.
    if IsInStartString(END_DCTOOL_OUTPUTS, FOutputStr) then
    begin
      FProgressInfo.FNowItIsKallistiOSOutputs := True;
      Exit;
    end;

    //Si le transfert n'est pas terminÈ (et donc que DC-TOOL n'a pas fini d'afficher
    //son merdier) on va dÈclancher l'ÈnËnement normal. Sinon OnNewDcToolLine.
    if FProgressInfo.FNowItIsKallistiOSOutputs then
    begin
      if Assigned(FOnNewLine) then
        FOnNewLine(FOwner, FOutputStr, FOutputType); //DÈclancher un ÈvËnement OnNewLine.
    end else begin
      if Assigned(FDCTool.FNewDCToolLine) then
        FDCTool.FNewDcToolLine(FDCTool, FOutputStr, FOutputType);
    end;
end;

//------------------------------------------------------------------------------

constructor TDosThread.Create(AOwner: TDosComm ; DCTool : TDCTool);
begin
  FDCTool := DCTool;
  FProgressInfo := TProgressInfo.Create(DCTool);

  FOwner := AOwner;
  //FCommandline := FOwner.CommandLine;   // copy.  not shared;
  FCommandLine := FOwner.FCommandLine; //accessible dans la partie privÈe de TDosComm

  //messageboxa(0, pchar(FCommandLine), '', 0);
  //messageboxa(0, pchar(FOwner.FCommandLine), '', 0);
  
  InputLines_SHARED := FOwner.FInputLines_SHARED;
  InputLines_SHARED.Clear;
  //FInputToOutput := FOwner.InputToOutput;
  FOnNewLine := FOwner.FOnNewLine;
  FOnTerminated := FOwner.FOnTerminated;
  FTimer := FOwner.FTimer;  // can access private!!
  FMaxTimeAfterBeginning := FOwner.FMaxTimeAfterBeginning;
  FMaxTimeAfterLastOutput := FOwner.FMaxTimeAfterLastOutput;
  FPriority := FOwner.FPriority;
  FShowWindow := FOwner.FShowWindow;
  FCreationFlag := FOwner.FCreationFlag;
  FLineBeginned := False;
  FProcessInfo_SHARED := @FOwner.FProcessInfo_SHARED;
  FActive := True;
  
  inherited Create(False);  //  ÇΩÇæÇøÇ…é¿çsÅB
end;

//------------------------------------------------------------------------------

destructor TDosThread.Destroy;
begin
  if Assigned(FProgressInfo) then FreeAndNil(FProgressInfo);
end;

//===[:: TDosComm ::]===========================================================

constructor TDosComm.Create(AOwner : TDCTool);
begin
  //inherited;

  try
    FLines_SHARED := TStringList.Create;
    FLines_SHARED.Clear;
    FInputLines_SHARED := TStringList.Create;
    FInputLines_SHARED.Clear;
    FSync := TMultiReadExclusiveWriteSynchronizer.Create;

    FCommandLine := '';
    FTimer := nil;
    FMaxTimeAfterBeginning := 0;
    FMaxTimeAfterLastOutput := 0;
    FPriority := NORMAL_PRIORITY_CLASS;
    FShowWindow := swHide;
    FCreationFlag := fCREATE_NEW_CONSOLE;
    FDCTool := AOwner;
  except
    //raise TConstructorError.Create('Exception in TDosComm.Create.');
    ShowException('Exception in TDosComm.Create.');
  end;
end;

//------------------------------------------------------------------------------

procedure TDosComm.SetOutputLines_SHARED(Value: TStrings);
begin
  Sync.beginWrite ; try
  if (FOutputLines_SHARED <> Value) then begin
    FOutputLines_SHARED := Value;
  end;
  finally Sync.EndWrite ; end;
end;

//------------------------------------------------------------------------------

procedure TDosComm.Execute;
begin
  if (FCommandLine <> '') then
  begin
    //Ajout DC-TOOL GUI 3 : Permet de rÈinitialiser la procÈdure d'output.
    //FDCTool.FTransfertComplete := False;
    //FDCTool.FGetLastAborted := False; //permet d'enlever le flag "dernier aborted".
    //EDIT : (26/07/05 ‡ 12h59 : On dÈplace ceci dans le constructeur de TProgressInfo).

    Stop;
    if (FTimer = nil) then //create the timer (first call to execute)
      FTimer := TProcessTimer.Create(nil);
    FLines_SHARED.Clear; //clear old outputs
    //FThread := TDosThread.Create(Self);
    FThread := TDosThread.Create(Self, FDCTool);
  end;
end;

    //
    //  WaitFor Ç≈ÇÕêeÉXÉåÉbÉhÇ™é~Ç‹Ç¡ÇƒÇµÇ‹Ç§ÅH
    //  
    //  Apollo Ç≈ÇÕãNìÆíÜÇ…[Çò]Ç≈èIóπÇµÇƒÇ‡ÅAmainloop ÇèIóπÇµÇ»Ç¢ÅB
    //  
    //

//------------------------------------------------------------------------------

function TDosComm.Execute2: Integer;
begin
  Execute;

  while Self.Active do
  begin
    Application.ProcessMessages;
    Sleep(50); //pour Èviter les 100% du proc !
  end;

  Result := FExitCode;
end;

//------------------------------------------------------------------------------

procedure TDosComm.Stop;
begin
  if (FThread <> nil) then
  begin
    FThread.FreeOnTerminate := true;
    FThread.Terminate; //terminate the process
    FThread := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TDosComm.SendLine(Value: string; Eol: Boolean);
//const
  //EolCh: array[Boolean] of Char = (' ', '_');
//var
  //i, sp, L: Integer;
  //Str: String;
begin
//  Sync.BeginWrite ;
  try
    if (FThread <> nil) then
    begin
      if Eol then
      begin
        if FReturnCode = rcCRLF then
          Value := Value + #13#10
        else
          Value := Value + #10;
      end;
{      L := Length(Value);
      i := 1;
      sp := i;
      while i <= L do
      begin
        case Value[i] of
        #13:
          begin
            if (i < L) and (Value[i + 1] = #10) then
              Inc(i);
            Str := Copy(Value, sp, i - sp + 1);
            FInputLines_SHARED.Add(Str);
            Inc(i);
            sp := i;
          end;
        #10:
          begin
            Str := Copy(Value, sp, i - sp + 1);
            FInputLines_SHARED.Add(Str);
            Inc(i);
            sp := i;
          end;
        else
          Inc(i);
        end;
      end;
      Str := Copy(Value, sp, i - sp + 1);
      FInputLines_SHARED.Add(Str);
}
      FInputLines_SHARED.Add(Value);
      //FThread.InputLines_SHARED.Add(EolCh[Eol] + Value);
    end;
  finally
  end;
end;

//------------------------------------------------------------------------------

destructor TDosComm.Destroy;
begin
  if FThread <> nil then Stop;
  if FTimer <> nil then FTimer.free;
  FSync.Free;
  FInputLines_SHARED.free;
  FLines_SHARED.free;
  inherited;
end;

//------------------------------------------------------------------------------

function TDosComm.GetPrompting:boolean;
begin
  //result := Active ; // and ( FTimer.FSinceLastOutput > 3 );
  result := Active and (( FTimer.FSinceLastOutput > 3 ) or FThread.FLineBeginned);
end;

//------------------------------------------------------------------------------

function TDosComm.GetActive:boolean;
begin
  result := ( FThread <> nil ) and ( FThread.FActive ) and (not FThread.Terminated);
end;

//------------------------------------------------------------------------------

function TDosComm.GetSinceLastOutput:integer;
begin
  result := -1;
  if GetActive then result := FTimer.FSinceLastOutput;
end;

//------------------------------------------------------------------------------

function TDosComm.GetSinceBeginning:integer;
begin
  result := -1;
  if GetActive then result := FTimer.FSinceBeginning;
end;

//===[:: TProgressInfo ::]======================================================

procedure TProgressInfo.AddNewSectionElfTreeView(NewLine : string);
var
  RootChildNode, CurrNode : TTreeNode;
  
begin
  RootChildNode := FDCTool.FElfTreeView.Items.AddChild(FRootNode, GetElfSectionName(NewLine));
  ChangeIcon(RootChildNode, ELF_SECTION_NODE);
  
  CurrNode := FDCTool.FElfTreeView.Items.AddChild(RootChildNode,
    GetElfSectionLma(NewLine));
  ChangeIcon(CurrNode, ELF_LMA_NODE);

  CurrNode := FDCTool.FElfTreeView.Items.AddChild(RootChildNode,
    IntToStr(GetElfSectionSize(NewLine)));

  ChangeIcon(CurrNode, ELF_SIZE_NODE);
end;

//------------------------------------------------------------------------------

procedure TProgressInfo.ChangeIcon(Node: TTreeNode ; ImageIndex : integer);
begin
  if Assigned(FDCTool.FElfTreeView.Images) then
  begin

    //index invalide.
    if (ImageIndex < 0) or (ImageIndex > (FDCTool.FElfTreeView.Images.Count - 1)) then
      Exit;

    //node invalide
    if Node = nil then
    begin
      raise TInvalidTreeViewNode.Create('Invalid specified ElfTreeView node.');
      Exit;
    end;

    Node.ImageIndex := ImageIndex;
    Node.SelectedIndex := ImageIndex;

  end;

end;

//------------------------------------------------------------------------------

function TProgressInfo.ContinueProgress(NewLine: string) : integer;
var
  NewPrg : string;
  MustBeAdded : integer;

begin
  NewPrg := Copy(NewLine, TAG_SIZE + 1, Length(NewLine) - (TAG_SIZE));

  MustBeAdded := (Length(NewPrg) * STEP_VALUE) - FWorkCount;

  FWorkCount := FWorkCount + (MustBeAdded);

  if Assigned(FProgressBar) then
    FProgressBar.Position := FWorkCount;

  Result := MustBeAdded;
end;

//------------------------------------------------------------------------------

constructor TProgressInfo.Create(DCTool : TDCTool);
begin
  try
    FDCTool := DCTool;
    FInProgress := False;
    FIsDownloading := False;
    FNowItIsKallistiOSOutputs := False;
    FTransfertComplete := False;
    FDCTool.FGetLastAborted := False; //permet d'enlever le flag "dernier aborted".

    //Si la barre de progression est assignÈe...
    if Assigned(FDCTool.FProgressBar) then
      FProgressBar := FDCTool.FProgressBar;
    
    FFileFormat := ffUnknow;
    FSourceFile := FDCTool.FileName;
  except
    //raise TConstructorError.Create('Exception in TProgressInfo.Create.');
    ShowException('Exception in TProgressInfo.Create.');
  end;
end;

//------------------------------------------------------------------------------

function TProgressInfo.GetDownloadSize(NewLine: string): integer;
var
  Detect : string;

begin
  Detect := LowerCase(ExtractStr(DOWNLOAD_TAG, DOWNLOAD_END_TAG, NewLine));
  Result := StrToIntDef(Detect, 0);
end;

//------------------------------------------------------------------------------

function TProgressInfo.GetElfSectionLma(NewLine: string): string;
begin
  Result := ExtractStr(SECTION_LMA_TAG, PRG_MAX_ELF_TAG, NewLine);  
end;

//------------------------------------------------------------------------------

function TProgressInfo.GetElfSectionName(NewLine: string): string;
begin
  Result := ExtractStr(SECTION_TAG, SECTION_LMA_TAG, NewLine);
end;

//------------------------------------------------------------------------------

function TProgressInfo.GetElfSectionSize(NewLine: string): integer;
begin
  FWorkCount := 0;

  if Assigned(FProgressBar) then
    FProgressBar.Position := FWorkCount; //nouveau max.

  Result := StrToIntDef(Droite(PRG_MAX_ELF_TAG, NewLine), 0);

  //if Result <= STEP_VALUE then Result := (Result * STEP_VALUE);
end;

//------------------------------------------------------------------------------

function TProgressInfo.GetFileFormat(NewLine: string): TFileFormat;
var
  Detect : string;

begin
  Result := ffUnknow;
  
  Detect := LowerCase(ExtractStr(FILE_FORMAT, FILE_FORMAT_END, NewLine));

  if IsInStartString(RAW_BIN, Detect) then
    Result := ffRAW;

  if IsInStartString(ELF, Detect) then
    Result := ffELF;

  //ShowMessage('GetFileFormat : ' + Detect);
end;

//------------------------------------------------------------------------------

procedure TProgressInfo.InitElfTreeView;
var
  FN : TFileName;

begin
  //Pour l'arbre.  
  if Assigned(FDCTool.FElfTreeView) then
  begin
    FDCTool.FElfTreeView.Items.Clear;
    
    if FDCTool.FElfTreeView.Items.Count = 0 then //0 donc on peut ajouter le nom du fichier.
    begin
      FN := ExtractFileName(FDCTool.FileName);

      //on vire le '~' de la copyprotection ajout du 24/06/05
      if FDCTool.UploadOptions.FFileInUseProtection then
        if FN[1] = '~' then FN := Copy(FN, 2, Length(FN) - 1);

      FRootNode := FDCTool.FElfTreeView.Items.Add(nil, FN);
      ChangeIcon(FRootNode, ELF_ROOT_NODE);
    end;

  end;

end;

//------------------------------------------------------------------------------

function TProgressInfo.InProgress(NewLine : string) : boolean;
begin
  Result := False;
  if IsInStartString(PG_UP_TAG, NewLine) or IsInStartString(PG_DW_TAG, NewLine) then
    Result := True;
end;

//------------------------------------------------------------------------------

function TProgressInfo.IsDetectingFormat(NewLine: string): boolean;
begin
  Result := IsInStartString(FILE_FORMAT, NewLine);
end;

//------------------------------------------------------------------------------

function TProgressInfo.IsDetectionElfSize(NewLine: string): boolean;
var
  OK : boolean;

begin
  OK := IsInStartString(SECTION_TAG, NewLine);

  if OK then
    OK := IsInString(SECTION_LMA_TAG, NewLine);

  if OK then
    OK := IsInString(PRG_MAX_ELF_TAG, NewLine);

  Result := OK;
end;

//------------------------------------------------------------------------------

function TProgressInfo.IsDownloading(NewLine: string): boolean;
begin
  Result := IsInStartString(DOWNLOAD_TAG, NewLine);
end;

//------------------------------------------------------------------------------

//---ProcessLine---
function TProgressInfo.ProcessLine(NewLine: string) : boolean;
var
  CurrProgress  : boolean;

begin
  Result := False;
  
  //Nous avons que des sorties de KOS. Ca sera re-initialisÈ au prochain transfert !
  if FTransfertComplete then Exit;

  //----------------------------------------------------------------------------

  //C'est la fin des sorties de DC-TOOL ?!
  if Pos(UpperCase(EXECUTING_STR), UpperCase(NewLine)) <> 0 then
  begin
    //messageboxa(0, 'fini', '', 0);

    //On signale au Driver que nous avons maintenant que des sorties de KOS!
    FTransfertComplete := True;
    FProgressBar.Position := FProgressBar.Max;

    //DÈclanchement pour dire "c'est fini".
    if Assigned(FDCTool.FOnProgressEnd) then
      FDCTool.FOnProgressEnd(Self);

    //DÈclancher l'ÈvËnement...
    if Assigned(FDCTool.FOnEndDcToolLines) then
      FDCTool.FOnEndDcToolLines(FDCTool);
  end;

  //PETIT PROBLEME.
  //Le problËme, c'est que DC-TOOL GUI peut lancer des applications katana.
  //C'est pas un problËme en soi, mais le truc c'est que comme c'est KOS qui
  //envoie les "--" ‡ DC-TOOL GUI, avec un executable KATANA Áa restera bloquÈ
  //sur "Upload". Il faut donc le detecter avant. (notamment la ligne "executing...")

  //----------------------------------------------------------------------------

  CurrProgress := InProgress(NewLine);

  //Pas de progress...
  if not CurrProgress and not FInProgress then
  begin

    //*****PARTIE UPLOAD*****
    
    //...on dÈtecte le format ?
    if IsDetectingFormat(NewLine) then
    begin
      //Si on dÈtecte le format du fichier, c'est que c'est bien un upload.
      FIsDownloading := False;

      //oui et on va l'avoir!
      FFileFormat := GetFileFormat(NewLine);

      //DÈclanchement de l'ÈvËnement.
      if Assigned(FDCTool.FOnDetectingFileFormat) then
        FDCTool.FOnDetectingFileFormat(Self, FFileFormat);

      //Initialiser l'arbre si c'est un ELF.
      if FFileFormat = ffELF then InitElfTreeView;

      Exit;
    end;

    //On est toujours pas en transfert. Mais par contre, nous avons le format.
    if IsDetectionElfSize(NewLine) then
    begin
      FWorkMax := GetElfSectionSize(NewLine);

      //Evenement OnDetectingElfSize
      if Assigned(FDCTool.FOnDetectingElfSize) then
        FDCTool.FOnDetectingElfSize(Self, GetElfSectionName(NewLine),
          GetElfSectionLma(NewLine), FWorkMax);

      //Pour l'arbre.
      AddNewSectionElfTreeView(NewLine);
      
      if Assigned(FProgressBar) then
        FProgressBar.Max := FWorkMax;

      Exit;
    end;

    //*****PARTIE DOWNLOAD*****
    if IsDownloading(NewLine) then
    begin
      FWorkMax := GetDownloadSize(NewLine);
      FIsDownloading := True;

      //DÈclanchement d'ÈvËnement
      if Assigned(FDCTool.FOnGetDownloadSize) then
        FDCTool.FOnGetDownloadSize(Self, FWorkMax);

      if Assigned(FProgressBar) then
        FProgressBar.Max := FWorkMax;

      Exit;
    end;
    
    //*** C'est rien d'autre!
    Exit;
  end;

  //Si un transfert est dÈtectÈ, et qu'il Ètait pas dÈj‡ avant..
  if CurrProgress and not FInProgress then
    begin
      //Initialisation du transfert

      //---- Pour le Maximum de la ProgressBar ----

      if FIsDownloading then
      begin

        //***Downloading.
        FWorkMax := FWorkMax div DOWNLOAD_RATIO;

        if Assigned(FProgressBar) then
          FProgressBar.Max := FWorkMax

      end else begin
        //***Uploading.
        
        //Si le format est ELF on a eu la taille avant. Avec un BIN c'est la taille
        //du fichier.
        case FFileFormat of
          ffELF : begin
                    if FWorkMax >= ELF_SECTION_SIZE_RATIO then
                      FWorkMax := FWorkMax div ELF_SECTION_SIZE_RATIO
                  end;

          ffRAW : FWorkMax := (GetFileSize(FSourceFile)) div BIN_SECTION_SIZE_RATIO;

          ffUnknow :  begin
                        raise TFileFormatError.Create('Error, file format of "' +
                          FSourceFile + '" unknow, or download operation synchronizing failed.');
                        Exit;
                      end;
        end;

        //Changer la valeur si la progressbar est assignÈe.
        if Assigned(FProgressBar) then
          FProgressBar.Max := FWorkMax;

        //Nous allons voir si le fichier existe ou pas avant d'Ítre uploadÈ (d'ou la
        //vÈrification pour savoir si c'est pas un download).
        if not FileExists(FSourceFile) then
        begin
          //Si le fichier n'existe pas pour un upload, erreur! si c'est Unknow on s'est dÈj‡
          //arrÍtÈ au dessus.
          raise TFileNotFoundError.Create('File to upload doesn''t exists ("' + FSourceFile + '").');
          Exit;
        end;

      end;

      FInProgress := True;

      //DÈclacher l'ÈvËnement permettant de signaler le dÈbut d'un transfert.
      if Assigned(FDCTool.FOnProgressBegin) then
        FDCTool.FOnProgressBegin(Self, FWorkMax);

      //C'est un progress;
      ContinueProgress(NewLine);
      Result := True;
    end

  else

    //Un transfert est dÈtectÈ, mais il Ètait dÈj‡ avant.
    if CurrProgress and FInProgress then
      begin
        FWorkCount := ContinueProgress(NewLine);

        //DÈclancher l'ÈvÈnËment OnProgressWork.
        if Assigned(FDCTool.FOnProgressWork) then
          FDCTool.FOnProgressWork(Self, FWorkCount);

        //C'est un progress
        Result := True;
      end

    else

      begin
        //*** Fin du Transfert ***

        FInProgress := False;
        FIsDownloading := False;

        FWorkCount := FWorkMax;

        if Assigned(FProgressBar) then
          FProgressBar.Position := FWorkMax;

        //DÈclanchement pour dire "c'est fini".
        if Assigned(FDCTool.FOnProgressEnd) then
          FDCTool.FOnProgressEnd(Self);

        //On a fini le transfert... mais par une ligne de "Section" ?
        if IsDetectionElfSize(NewLine) then
        begin

          FWorkMax := GetElfSectionSize(NewLine);

          if Assigned(FProgressBar) then
            FProgressBar.Max := FWorkMax;

          //Pour l'arbre.
          AddNewSectionElfTreeView(NewLine);

          //DÈclanchement
          if Assigned(FDCTool.FOnDetectingElfSize) then
            FDCTool.FOnDetectingElfSize(Self, GetElfSectionName(NewLine),
              GetElfSectionLma(NewLine), FWorkMax);

          Exit;
        end;
        
      end;

end;

//===[:: TDCTool ::]============================================================

{ TDCTool }

constructor TDCTool.Create(AOwner: TComponent);
begin
  inherited;           

  try
    FConnectionType := ctSerial;
    FDosComm := TDosComm.Create(Self);
    FProgressBar := nil;
    FUploadOptions := TUpload.Create(Self);
    FDownloadOptions := TDownload.Create(Self);
    FIsoRedirection := TIsoRedirection.Create;
    FChRoot := TChRoot.Create;
    FOptions := TOptions.Create(Self);
    FSerial := TSerialCom.Create(Self);
    FBroadBand := TBBACom.Create(Self);
    FUSB := TUSBCom.Create;

    //FTransfertComplete := False;
    FGetLastAborted := False;

    FOnProgressBegin := nil;
  except
    //raise TConstructorError.Create('Exception in TDCTool.Create.');
    ShowException('Exception in TDCTool.Create.');
  end;
end;

//------------------------------------------------------------------------------

destructor TDCTool.Destroy;
begin
  //killer tous les dc-tools
  KillAllDcTools;
  
  //peter toutes les propriÈtÈs TPersistent...
  if Assigned(FDosComm) then FreeAndNil(FDosComm);
  if Assigned(FUploadOptions) then FreeAndNil(FUploadOptions);
  if Assigned(FDownloadOptions) then FreeAndNil(FDownloadOptions);
  if Assigned(FIsoRedirection) then FreeAndNil(FIsoRedirection);
  if Assigned(FChRoot) then FreeAndNil(FChRoot);
  if Assigned(FOptions) then FreeAndNil(FOptions);
  if Assigned(FSerial) then FreeAndNil(FSerial);
  if Assigned(FBroadBand) then FreeAndNil(FBroadBand);
  if Assigned(FUSB) then FreeAndNil(FUSB);

  //messageboxa(0, '','',0);
  
  inherited;
end;

//------------------------------------------------------------------------------

function TDCTool.Download : boolean;
var
  Line      : string;
  DCExitCode  : integer;

begin
  FGetLastOperation := otDownload;

  Result := False;

  //Indiquer le dÈbut
  if Assigned(FOnStart) then
      FOnStart(Self, otDownload);

  //Line := 'dc-tool -d DUMMY.BIN -s 0x20000 -t COM1 -b 115200 -a 0x8C010000 -e';

  case FConnectionType of
    ctSerial  : Line := Serial.GetCompleteLine(FGetLastOperation);

    ctBBA     : Line := BroadBand.GetCompleteLine(FGetLastOperation);

    ctUSB     : Line := USB.FExecutable; //non pris en compte.
  end;

  //DÈclancher l'ÈvÈnement "crÈation d'une nouvelle ligne".
  if Assigned(FOnCreateCommandLine) then
    FOnCreateCommandLine(Self, Line);

  if Line = '' then Exit;

  Self.FDosComm.FCommandLine := Line;
  DCExitCode := Self.FDosComm.Execute2;

  //OK no problem
  if DCExitCode = 0 then Result := True;
end;

//------------------------------------------------------------------------------

function TDCTool.Upload : boolean;
var
  Line        : string;
  DCExitCode  : integer;

begin
  Result := False;

  //messagebox(0, pchar(FileName), '', 0);

  //VÈrifier le fichier.
  if not FileExists(FileName) then
  begin
    raise TFileNotFoundError.Create('File not found "' + FileName + '".');
    Exit;
  end;

  //Choisir le type d'upload (executer ou pas?)
  if UploadOptions.ExecuteAfterUpload then
    FGetLastOperation := otUploadExecute
  else FGetLastOperation := otUpload;

  //Indiquer le dÈbut
  if Assigned(FOnStart) then
  begin
    //if UploadOptions.ExecuteAfterUpload then
    //  FOnStart(Self, otUploadExecute)        //executer ‡ la fin
    //else FOnStart(Self, otUpload);            //pas executer ‡ la fin
    FOnStart(Self, FGetLastOperation);
  end;

  //Ajout du 23 juin (2005 :p) ‡ 23h35 (ouais Áa va Ítre dans l'histoire ^^) :
  //L'option "File in Use Protection" va Ítre finalement Ítre intÈgrÈe dans
  //TDCTool. Car je me suis dit, finalement, Áa peut servir ‡ d'autres...
  //C'est donc une option de Upload. Donc -> UploadOption ^^.
  if UploadOptions.FFileInUseProtection then
  begin
    Line := UploadOptions.CreateFileInUseProtection;  //ceci va copier FDCTool.FileName vers un fichier avec "~" devant.
    UploadOptions.FRealDcToolFileName := FileName; //on stocke le nom du fichier original
    FileName := Line; //on met le nom de fichier "temporaire".
  end;
    
  //ne pas oublier, tout se fait dans GetCompleteLine, chaque class possËde
  //une mÈthode privÈe GetCompleteLine pour pouvoir avoir le moins de code
  //possible dans une fonction.
  //Si par exemple Áa foire dans la iso redirection, bah faudra regarder dans
  //la class TIsoRedirection...
  case FConnectionType of
    ctSerial  : Line := Serial.GetCompleteLine(FGetLastOperation);

    ctBBA     : Line := BroadBand.GetCompleteLine(FGetLastOperation);

    ctUSB     : Line := USB.FExecutable; //non pris en compte. (pour le moment)
  end;

  //DÈclancher l'ÈvÈnement "crÈation d'une nouvelle ligne".
  if Assigned(FOnCreateCommandLine) then
    FOnCreateCommandLine(Self, Line);

  if Line = '' then Exit;

  Self.FDosComm.FCommandLine := Line;
  DCExitCode := Self.FDosComm.Execute2;

  //OK no problem
  if DCExitCode = 0 then Result := True;

  //Effacer le fichier si nÈcessaire...
  if UploadOptions.FFileInUseProtection then
  begin
    FileName := UploadOptions.FRealDcToolFileName;    //restitution du fichier original
    UploadOptions.DeleteFileInUseProtection;  //effacer le fichier temporaire (cette fonction
  end;                                        //rÈcupËre le nom du fichier temp en fct du nom
end;                                          //original).

//------------------------------------------------------------------------------

function TDCTool.ReadFOnNewLine: TNewLineEvent;
begin
  Result := DosComm.OnNewLine;
end;

//------------------------------------------------------------------------------

function TDCTool.ReadFOnTerminated: TTerminateEvent;
begin
  Result := DosComm.OnTerminated;
end;

//------------------------------------------------------------------------------

function TDCTool.Reset: boolean;
var
  DCExitCode : integer;

begin
  Result := False;

  FGetLastOperation := otReset;
  
  //Indiquer le dÈbut
  if Assigned(FOnStart) then
      FOnStart(Self, otReset);

  //assigner OnReseting si nÈcessaire.
  if Assigned(OnReseting) then
    OnReseting(Self);

  //Killer DC-TOOL & stopper TDosCommand
  Abort;

  //FGetLastAborted := Self.IsActive; //oui si y'avait un transfert non sinon

  //messageboxa(0, 'reset ‡ faire', 'err', 0);
  if ConnectionType = ctBBA then
  begin
    Self.FDosComm.FCommandLine := BroadBand.GetCompleteLine(FGetLastOperation); //reset.
    DCExitCode := Self.FDosComm.Execute2;

    //OK no problem
    if DCExitCode = 0 then Result := True;
  end
    else Result := True; //si c'est Serial ou USB, y'a rien ‡ faire... le dÈclanchement
    //de l'ÈvËnement OnTerminated va tout rÈparer dans le client...

  //assigner OnReseting si nÈcessaire.
  if Assigned(OnReseted) then
    OnReseted(Self);

  //assigner terminate si c'est nÈcessaire
  if Assigned(DosComm.FOnTerminated) then
    DosComm.FOnTerminated(DosComm, 0);
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetBroadBand(const Value: TBBACom);
begin
  FBroadBand := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetChRoot(const Value: TChRoot);
begin
  FChRoot := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetConnectionType(const Value: TConnectionType);
begin
  FConnectionType := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetDosComm(const Value: TDosComm);
begin
  FDosComm := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetDownloadOptions(const Value: TDownload);
begin
  FDownloadOptions := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetFOnNewLine(const Value: TNewLineEvent);
begin
  DosComm.OnNewLine := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetFOnTerminated(const Value: TTerminateEvent);
begin
  DosComm.OnTerminated := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetIsoRedirection(const Value: TIsoRedirection);
begin
  FIsoRedirection := Value;
end;
 
//------------------------------------------------------------------------------

procedure TDCTool.SetOptions(const Value: TOptions);
begin
  FOptions := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetProgressBar(const Value: TProgressBar);
begin
  FProgressBar := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetSerial(const Value: TSerialCom);
begin
  FSerial := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetUploadOptions(const Value: TUpload);
begin
  FUploadOptions := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetUSB(const Value: TUSBCom);
begin
  FUSB := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.Abort;
begin
  FGetLastAborted := True; //pour la fonction

  //dÈclanchement de l'ÈvËnement...
  if FGetLastOperation <> otReset then
    if Assigned(FOnAborting) then
      FOnAborting(Self);

  Self.FDosComm.Stop;

  //killer tous les dc-tools
  KillAllDcTools;

  //fin de l'abort...
  if FGetLastOperation <> otReset then  //bah oui on veut pas pour RESET y'a son propre evenement
    if Assigned(FOnAborted) then
      FOnAborted(Self);
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetFileName(const Value: TFileName);
begin
  { if Length(Value) = 0 then
  begin
    FFileName := '';
    Exit;
  end;

  if not FileExists(Value) then
  begin
    raise TFileNotFoundError.Create('File not found "' + Value + '".');
    Exit;
  end;  }

  FFileName := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.Stop;
begin
  Abort;
end;
 
//------------------------------------------------------------------------------

procedure TDCTool.KillAllDcTools;
begin
  //Tuer tous les fichiers car souvent la fonction Stop de TDosCommand
  //foire.
  KillFileName(ExtractFileName(Serial.Executable));
  KillFileName(ExtractFileName(USB.Executable));
  KillFileName(ExtractFileName(BroadBand.Executable));
end;

//------------------------------------------------------------------------------

procedure TDCTool.SetElfTreeView(const Value: TTreeView);
begin
  FElfTreeView := Value;
end;

//------------------------------------------------------------------------------

procedure TDCTool.SaveToFile(FileName: TFileName);
var
  Ini : TIniFile;

begin
  Ini := TIniFile.Create(FileName);
  try
    Ini.WriteString('Driver', 'Version', CORE_VERSION);
    Ini.WriteString('Driver', 'Author', '[big_fury]SiZiOUS');

    //Connection type.
    Ini.WriteInteger('Driver', 'ConnectionType', Integer(FConnectionType));

    //Serial config
    Ini.WriteString('Serial', 'Executable', Serial.FExecutable);
    Ini.WriteInteger('Serial', 'ComPort', Integer(FSerial.FComPort));
    Ini.WriteInteger('Serial', 'Baudrate', Integer(FSerial.FBaudrate));
    Ini.WriteBool('Serial', 'AlternateBaudrate', FSerial.FAlternateBaudrate);

    //BBA config
    Ini.WriteString('BroadBand', 'Executable', FBroadBand.FExecutable);
    Ini.WriteString('BroadBand', 'IPAddress', FBroadBand.FIPAddress);

    //USB config
    Ini.WriteString('USB', 'Executable', FUSB.FExecutable);

    //Options
    Ini.WriteBool('Options', 'AttachFileServer', FOptions.FAttachFileServer);
    Ini.WriteBool('Options', 'UseDumbTerminal', FOptions.FUseDumbTerminal);
    Ini.WriteBool('Options', 'ClrScrBeforeDownload', FOptions.FClrScrBeforeDownload);

    //Options de DC-TOOL
    Ini.WriteBool('Options', 'ShowTextProgress', ShowTextProgress);

    //Options de DosComm
    Ini.WriteString('DosComm', 'Version', DOSCOMM_VERSION);
    Ini.WriteString('DosComm', 'Author', 'MaxX');
    Ini.WriteInteger('DosComm', 'CreationFlag', Integer(FDosComm.FCreationFlag));
    Ini.WriteInteger('DosComm', 'ShowWindow', Integer(FDosComm.FShowWindow));
    Ini.WriteInteger('DosComm', 'MaxTimeAfterBeginning', FDosComm.FMaxTimeAfterBeginning);
    Ini.WriteInteger('DosComm', 'MaxTimeAfterLastOutput', FDosComm.FMaxTimeAfterLastOutput);
    Ini.WriteBool('DosComm', 'InputToOutput', FDosComm.FInputToOutput);
    Ini.WriteInteger('DosComm', 'ReturnCode', Integer(FDosComm.FReturnCode));

    Ini.WriteBool('UploadOptions', 'FileInUseProtection', FUploadOptions.FFileInUseProtection);
  finally
    Ini.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TDCTool.LoadFromFile(FileName: TFileName);
var
  Ini     : TIniFile;
  readval : integer;

begin
  Ini := TIniFile.Create(FileName);
  try
    //par dÈfaut, DCTool garde ses valeurs qu'il avait avant.
    //je gËre pas les versions car on s'en fout... c'est juste pour l'utilisateur.
    //c'est une info quoi.
    
    //Connection type.
    readval := Ini.ReadInteger('Driver', 'ConnectionType', Integer(ConnectionType));
    FConnectionType := TConnectionType(readval);

    //Serial config
    FSerial.Executable := Ini.ReadString('Serial', 'Executable', Serial.Executable);

    readval := Ini.ReadInteger('Serial', 'ComPort', Integer(Serial.ComPort));
    FSerial.ComPort := TComPort(readval);

    readval := Ini.ReadInteger('Serial', 'Baudrate', Integer(Serial.Baudrate));
    FSerial.Baudrate := TBaudrate(readval);

    FSerial.AlternateBaudrate := Ini.ReadBool('Serial', 'AlternateBaudrate',
      FSerial.AlternateBaudrate);

    //BBA config
    FBroadBand.Executable := Ini.ReadString('BroadBand', 'Executable',
      FBroadBand.Executable);

    FBroadBand.IPAddress := Ini.ReadString('BroadBand', 'IPAddress',
      FBroadBand.IPAddress);

    //USB config
    FUSB.Executable := Ini.ReadString('USB', 'Executable', USB.Executable);

    //Options
    FOptions.FAttachFileServer := Ini.ReadBool('Options', 'AttachFileServer',
      FOptions.FAttachFileServer);
    FOptions.FUseDumbTerminal := Ini.ReadBool('Options', 'UseDumbTerminal',
      FOptions.FUseDumbTerminal);
    FOptions.FClrScrBeforeDownload := Ini.ReadBool('Options', 'ClrScrBeforeDownload',
      FOptions.FClrScrBeforeDownload);

    //Options de DC-TOOL
    FShowTextProgress := Ini.ReadBool('Options', 'ShowTextProgress', ShowTextProgress);

    //Options de DosComm
    FDosComm.FCreationFlag := TCreationFlag(Ini.ReadInteger('DosComm', 'CreationFlag',
      Integer(FDosComm.FCreationFlag)));

    FDosComm.FShowWindow := TShowWindow(Ini.ReadInteger('DosComm', 'ShowWindow',
      Integer(FDosComm.FShowWindow)));
      
    FDosComm.FMaxTimeAfterBeginning := Ini.ReadInteger('DosComm', 'MaxTimeAfterBeginning',
      FDosComm.FMaxTimeAfterBeginning);

    FDosComm.FMaxTimeAfterLastOutput := Ini.ReadInteger('DosComm', 'MaxTimeAfterLastOutput',
      FDosComm.FMaxTimeAfterLastOutput);

    FDosComm.FInputToOutput := Ini.ReadBool('DosComm', 'InputToOutput',
      DosComm.FInputToOutput);

    FDosComm.FReturnCode := TReturnCode(Ini.ReadInteger('DosComm', 'ReturnCode',
      Integer(FDosComm.FReturnCode)));

    FUploadOptions.FFileInUseProtection := Ini.ReadBool('UploadOptions',
      'FileInUseProtection', True);
  finally
    Ini.Free;
  end;
end;

//------------------------------------------------------------------------------

function TDCTool.GetLastOperation: TOperationType;
begin
  Result := FGetLastOperation;
end;

//------------------------------------------------------------------------------

function TDCTool.GetVersion: string;
begin
  Result := CORE_VERSION;
end;

//------------------------------------------------------------------------------

function TUpload.GetDefaultAddress: string;
begin
  Result := DEF_UPLOAD_ADDRESS;
  
end;

//------------------------------------------------------------------------------

function TDCTool.IsActive: boolean;
begin
  Result := FDosComm.Active;
end;

//------------------------------------------------------------------------------

function TDCTool.IsLastAborted: boolean;
begin
  Result := FGetLastAborted;
end;

//------------------------------------------------------------------------------

{ TIsoRedirection }

constructor TIsoRedirection.Create;
begin
  try
    FEnabled := False;
  except
    //raise TConstructorError.Create('Exception in TIsoRedirection.Create.');
    ShowException('Exception in TIsoRedirection.Create.');
  end;
end;

//------------------------------------------------------------------------------

function TIsoRedirection.GetCompleteLine: string;
begin
  Result := '';

  //Si c'est activÈ seulement
  if Enabled then
  begin

    if not FileExists(IsoFile) then
    begin
      raise TIsoFileError.Create('ISO file not found "' + IsoFile + '".');
      Exit;
    end;

    if FileExists(IsoFile) then //fichier existe ?
      Result := ENABLE_CDFS_REDIRECTION + ' "' + IsoFile + '"'; //ok

  end;
end;

//------------------------------------------------------------------------------

procedure TIsoRedirection.SetIsoFile(const Value: string);
begin
  {if Length(Value) = 0 then
  begin
    FIsoFile := '';
    Exit;
  end;

  if not DirectoryExists(Value) then
  begin
    raise TIsoFileError.Create('ISO file not found "' + Value + '".');
    Exit;
  end; }
  
  FIsoFile := Value;
end;
 
//------------------------------------------------------------------------------

procedure TIsoRedirection.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

//------------------------------------------------------------------------------

{ TUSBCom }

constructor TUSBCom.Create;
begin
  try
    //rien..  
  except
    //raise TConstructorError.Create('Exception in TDCTool.Create.');
    ShowException('Exception in TDCTool.Create.');
  end;
end;

//------------------------------------------------------------------------------

procedure TUSBCom.SetExecutable(const Value: TFileName);
begin
  { if Length(Value) = 0 then
  begin
    FExecutable := '';
    Exit;
  end;
  
  if not FileExists(Value) then
  begin
    raise TDCToolExecutableError.Create('File not found "' + Value + '".');
    Exit;
  end;   }
  
  FExecutable := Value;
end;

//------------------------------------------------------------------------------

function TDosComm.GetVersion: string;
begin
  Result := DOSCOMM_VERSION;
end;

//------------------------------------------------------------------------------

end.

