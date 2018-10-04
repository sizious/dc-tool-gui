unit DcToolHistoryView;

interface

uses
  SysUtils, Classes, Controls, ComCtrls, DcTool;

type
  TDcToolAssignError = class(Exception);

  TExecutableType = (etUpload, etUploadExecute, etDownload, etReset, etNone);

  TReExecuteEvent = procedure(Sender : TObject ; ReExecuteNode : TTreeNode) of object;
  TReExecuteUploadEvent = procedure(Sender : TObject ; ReExecuteNode : TTreeNode
      ; Execute : boolean) of object;
  TGetInfosEvent = procedure(Sender : TObject ; TreeNode : TTreeNode) of object;
  TGetInfosWithErrorEvent = procedure(Sender : TObject ; TreeNode : TTreeNode
      ; Success : boolean) of object;

  TDcToolHistoryView = class(TTreeView)
  private
    FDCTool: TDCTool;
    FParentNode : TTreeNode;
    FAddConnectionType: boolean;
    FOnReReset: TReExecuteEvent;
    FOnReDownload: TReExecuteEvent;
    FOnReUpload: TReExecuteUploadEvent;
    FDoReExecuteActions: boolean;
    FOnGetFileName: TGetInfosWithErrorEvent;
    FOnGetIsoFile: TGetInfosWithErrorEvent;
    FOnGetIsoState: TGetInfosEvent;
    FOnGetChrootState: TGetInfosEvent;
    FOnGetChrootPath: TGetInfosWithErrorEvent;
    FOnGetAddress: TGetInfosEvent;
    FOnGetUploadExecute: TGetInfosEvent;
    FOnGetDownloadSize: TGetInfosWithErrorEvent;
    FOnGetWorkingDir: TGetInfosWithErrorEvent;
    FAutoExpandInfosItems: boolean;
    FAutoExpandRecursive: boolean;
    
    procedure SetDCTool(const Value: TDCTool);

    function AddTreeItem(ParentNode : TTreeNode
        ; Caption : string ; ImageIndex : integer) : TTreeNode;
    procedure AddUploadHistory;
    procedure AddLinkInfos(SubParentNode : TTreeNode);
    procedure AddSerialInfos(SubParentNode : TTreeNode);
    procedure AddUSBInfos(SubParentNode: TTreeNode);
    procedure AddBBAInfos(SubParentNode: TTreeNode);
    function BoolToCaption(Bool: Boolean): string;
    procedure AddDownloadHistory;
    procedure AddResetHistory;
    procedure AddEnabledTreeItem(ParentNode : TTreeNode ; Caption : string
        ; State : boolean ; CustomImg : integer = -1);
    procedure SetUpForUpload(Node: TTreeNode; Execute: boolean);
    procedure SetUpForDownload(Node: TTreeNode);
    procedure SetUpForReset(Node: TTreeNode);
    function Droite(SubStr : string ; S : string) : string;
    { Déclarations privées }
  protected
    { Déclarations protégées }
  public
    { Déclarations publiques }
    constructor Create(AOwner : TComponent); override;
    procedure AddNewHistoryNode;
    function GetNodeState(Node: TTreeNode): TExecutableType;
    procedure ReExecuteNode(Node : TTreeNode);
  published
    { Déclarations publiées }
    property DCTool : TDCTool read FDCTool write SetDCTool;
    property AddConnectionType : boolean read FAddConnectionType write
      FAddConnectionType default False;
    property DoReExecuteActions : boolean read FDoReExecuteActions write
      FDoReExecuteActions default True;
    property AutoExpandInfosItems : boolean read FAutoExpandInfosItems write
      FAutoExpandInfosItems default True;
    property AutoExpandRecursive : boolean read FAutoExpandRecursive write
      FAutoExpandRecursive default False;

    //Evenements
    property OnReReset : TReExecuteEvent read FOnReReset write FOnReReset;
    property OnReUpload : TReExecuteUploadEvent read FOnReUpload write FOnReUpload;
    property OnReDownload : TReExecuteEvent read FOnReDownload write FOnReDownload;

    property OnGetFileName : TGetInfosWithErrorEvent read FOnGetFileName write FOnGetFileName;
    property OnGetIsoState : TGetInfosEvent read FOnGetIsoState write FOnGetIsoState;
    property OnGetIsoFile : TGetInfosWithErrorEvent read FOnGetIsoFile write FOnGetIsoFile;
    property OnGetChrootState : TGetInfosEvent read FOnGetChrootState write FOnGetChrootState;
    property OnGetChrootPath : TGetInfosWithErrorEvent read FOnGetChrootPath write FOnGetChrootPath;
    property OnGetAddress : TGetInfosEvent read FOnGetAddress write FOnGetAddress;
    property OnGetDownloadSize : TGetInfosWithErrorEvent read FOnGetDownloadSize write FOnGetDownloadSize;
    property OnGetUploadExecute : TGetInfosEvent read FOnGetUploadExecute write FOnGetUploadExecute;
    property OnGetWorkingDir : TGetInfosWithErrorEvent read FOnGetWorkingDir write FOnGetWorkingDir; 
  end;

procedure Register;

implementation

uSES DIALOGS;

const
  UPLOAD_IMG    : integer = 0;
  DOWNLOAD_IMG  : integer = 1;
  RESET_IMG     : integer = 2;
  DATETIME_IMG  : integer = 3;
  DATE_IMG      : integer = 4;
  TIME_IMG      : integer = 5;
  CONFIG_IMG    : integer = 6;
  CONNECTSEC_IMG: integer = 7;
  CTYPE_IMG     : integer = 8;
  BAUDRATE_IMG  : integer = 9;
  COMPORT_IMG   : integer = 10;
  IP_IMG        : integer = 11;
  ISOSECT_IMG   : integer = 12;
  ISOFILE_IMG   : integer = 13;
  ENABLED_Y_IMG : integer = 14;
  ENABLED_N_IMG : integer = 15;
  CHROOT_IMG    : integer = 16;
  CHROOTPATH_IMG: integer = 17;
  ADDR_IMG      : integer = 18;
  WORKDIR_IMG   : integer = 19;
  SIZE_IMG      : integer = 20;
  APPPATH_IMG   : integer = 21;
  RUN_IMG       : integer = 22;

procedure Register;
begin
  RegisterComponents('DC-TOOL GUI', [TDcToolHistoryView]);
end;

{ TDcToolHistoryView }

function TDcToolHistoryView.Droite(substr: string; s: string): string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

//----AddTreeItem----
function TDcToolHistoryView.AddTreeItem(ParentNode : TTreeNode
        ; Caption : string ; ImageIndex : integer) : TTreeNode;
var
  Node : TTreeNode;

begin
  Node := Items.AddChild(ParentNode, Caption);
  Node.ImageIndex := ImageIndex;
  Node.SelectedIndex := ImageIndex;

  Result := Node;
end;

procedure TDcToolHistoryView.AddNewHistoryNode;
var
  SubParentNode : TTreeNode;
  
begin
  if not Assigned(FDCTool) then
  begin
    raise TDcToolAssignError.Create('You must assign a TDcTool before using this method.');
    Exit;
  end;

  case FDCTool.GetLastOperation of
    otUpload        : AddUploadHistory;
    otUploadExecute : AddUploadHistory;
    otDownload      : AddDownloadHistory;
    otReset         : AddResetHistory;
  end;

  //Date & Time
  SubParentNode := AddTreeItem(FParentNode, 'Date/Time', DATETIME_IMG);
  AddTreeItem(SubParentNode, DateToStr(Date), DATE_IMG);
  AddTreeItem(SubParentNode, TimeToStr(Now), TIME_IMG);

  //Bloc Start
  //AddTreeItem(CurrNode, 'Block Start (' + IntToStr(OutP.Lines.Count) + ')', 5);

  if FAutoExpandInfosItems then
    FParentNode.Expand(FAutoExpandRecursive);
    
  Refresh;
end;

constructor TDcToolHistoryView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ReadOnly := True;
  FAddConnectionType := False;
  FDoReExecuteActions := True;
  FParentNode := nil;
  FAutoExpandRecursive := False;
  FAutoExpandInfosItems := True;
  FDCTool := nil;
end;

procedure TDcToolHistoryView.SetDCTool(const Value: TDCTool);
begin
  FDCTool := Value;
end;

procedure TDcToolHistoryView.AddUploadHistory;
var
  SubParentNode,
  AnotherNode : TTreeNode;

begin
  FParentNode := Items.Add(nil, ExtractFileName(FDCTool.FileName));
  FParentNode.Selected := True;
  FParentNode.ImageIndex := UPLOAD_IMG;  //Icône :)
  FParentNode.SelectedIndex := UPLOAD_IMG;

  //Informations
  SubParentNode := AddTreeItem(FParentNode, 'Config', CONFIG_IMG);

  //Ajouter les infos de connection.
  if FAddConnectionType then
    AddLinkInfos(SubParentNode);

  //ISO CDFS Redirection
  AnotherNode := AddTreeItem(SubParentNode, 'ISO Redirection', ISOSECT_IMG);
  AddEnabledTreeItem(AnotherNode, 'Enabled : ', FDCTool.IsoRedirection.Enabled);
  AddTreeItem(AnotherNode, 'Path : ' + FDCTool.IsoRedirection.IsoFile, ISOFILE_IMG);

  //ChRoot
  AnotherNode := AddTreeItem(SubParentNode, 'PC Root Path', CHROOT_IMG);
  AddEnabledTreeItem(AnotherNode, 'Enabled : ', FDCTool.ChRoot.Enabled);
  AddTreeItem(AnotherNode, 'Path : ' + FDCTool.ChRoot.Path, CHROOTPATH_IMG);
  
  //Ajouter les infos sur l'upload lui même
  AddTreeItem(SubParentNode, 'Address : ' + FDCTool.UploadOptions.ExecuteAddress, ADDR_IMG);
  AddTreeItem(SubParentNode, 'App path : ' + ExtractFilePath(FDCTool.FileName), APPPATH_IMG);
  AddEnabledTreeItem(SubParentNode, 'Execute : ', FDCTool.UploadOptions.ExecuteAfterUpload, RUN_IMG);
  AddTreeItem(SubParentNode, 'Working Path : ' + GetCurrentDir, WORKDIR_IMG);

  //Ajouter si c'est executable dans la première node (parent).
  FParentNode.Data := Pointer(FDCTool.UploadOptions.ExecuteAfterUpload);
end;

procedure TDcToolHistoryView.AddLinkInfos(SubParentNode : TTreeNode);
var
  Node : TTreeNode;

begin
  Node := AddTreeItem(SubParentNode, 'Connection Type', CONNECTSEC_IMG);

  case FDCTool.ConnectionType of
    ctSerial  : AddSerialInfos(Node);
    ctBBA     : AddBBAInfos(Node);
    ctUSB     : AddUSBInfos(Node);
  end;
end;

procedure TDcToolHistoryView.AddSerialInfos(SubParentNode : TTreeNode);
var
  S : string;
  
begin
  AddTreeItem(SubParentNode, 'Type : Serial', CTYPE_IMG);
  S := FDCTool.Serial.BaudrateToStr(FDCTool.Serial.Baudrate);
  AddTreeItem(SubParentNode, 'Baudrate : ' + S + ' bauds', BAUDRATE_IMG); //Baudrate.
  S := FDCTool.Serial.ComPortToStr(FDCTool.Serial.ComPort);
  AddTreeItem(SubParentNode, 'COM Port : ' + S, COMPORT_IMG);     //Com Port
end;

procedure TDcToolHistoryView.AddUSBInfos(SubParentNode : TTreeNode);
begin
  AddTreeItem(SubParentNode, 'Connection Type : USB', CTYPE_IMG);
end;

procedure TDcToolHistoryView.AddBBAInfos(SubParentNode : TTreeNode);
begin
  AddTreeItem(SubParentNode, 'Connection Type : Broadband Adapter', CTYPE_IMG);
  AddTreeItem(SubParentNode, 'IP : ' + DCTool.BroadBand.IPAddress, IP_IMG);
end;

function TDcToolHistoryView.BoolToCaption(Bool: Boolean) : string;
begin
  if Bool then
    Result := 'Yes'
  else Result := 'No';
end;

procedure TDcToolHistoryView.ReExecuteNode(Node: TTreeNode);
var
  Status : TExecutableType;

begin
  if not Assigned(Node) then Exit;

  if not Assigned(FDCTool) then
  begin
    raise TDcToolAssignError.Create('You must assign a TDCTool component before'
      + ' using this function.');
    Exit;
  end;

  Status := GetNodeState(Node);

  case Status of
    etNone          : Exit;
    etUpload        : SetUpForUpload(Node, False);
    etUploadExecute : SetUpForUpload(Node, True);
    etDownload      : SetUpForDownload(Node);
    etReset         : SetUpForReset(Node);
  end;

end;

procedure TDcToolHistoryView.SetUpForUpload(Node : TTreeNode ; Execute : boolean);
var
  ConfigNode,              //node fixe "Config".
  WorkingNode : TTreeNode; //node qui va récuperer les valeurs pour DCTOOL
  S : string;              //variable permettant de stocker une string... général quoi.
  OK : boolean;            //boolean qui permet de stocker un état... comme s : string quoi..          

begin
  ConfigNode := Node.GetNext;  //Nous avons la node 'Config'.

  if not FAddConnectionType then
    WorkingNode := ConfigNode.GetNext
  else begin
    //Si y'a ConnectionType, c'est la node suivante... Car elle est placée
    //au début de "Config".
    WorkingNode := ConfigNode.GetNext;
    WorkingNode := WorkingNode.GetNextSibling;
  end;

  //---[ISO]--------------------------------------------------------------------

  //Nous avons la node ISO Redirection.
  WorkingNode := WorkingNode.GetNext; //Nous allons récuperer si c'est enabled ou pas.
  //SHOWMESSAGE(WorkingNode.Text);

  //etat pour iso
  FDCTool.IsoRedirection.Enabled := Boolean(WorkingNode.Data);
  if Assigned(FOnGetIsoState) then
    FOnGetIsoState(Self, WorkingNode); //évènement

  //récuperation du fichier iso
  WorkingNode := WorkingNode.GetNext; //Le fichier pour l'ISO.
  S := Droite(': ', WorkingNode.Text);   //extrait le fichier
  OK := FileExists(S);  //on va vérifier si le fichier ISO existe.

  if OK then
     FDCTool.IsoRedirection.IsoFile := S //le fichier existe, on touche pas à enabled pour l'iSO...
  else FDCTool.IsoRedirection.Enabled := False; //erreur, pas d'iso dispo

  if Assigned(FOnGetIsoFile) then
    FOnGetIsoFile(Self, WorkingNode, OK);  //évènement, error!

  //---[CHROOT]-----------------------------------------------------------------

  //Nous avons la node PC Root Path = Chroot.
  WorkingNode := WorkingNode.GetNext; //node [+]---PC Root Path
  WorkingNode := WorkingNode.GetNext; //Activer le chroot.

  FDCTool.ChRoot.Enabled := Boolean(WorkingNode.Data);
  if Assigned(FOnGetChrootState) then
    FOnGetChrootState(Self, WorkingNode);

  WorkingNode := WorkingNode.GetNext; //Avoir le path pour le Chroot
  S := Droite(': ', WorkingNode.Text);

  OK := DirectoryExists(S); //vérification si le dossier pour chroot existe.
  
  if OK then
      FDCTool.ChRoot.Path := S //ok on met le dossier pour Chroot.
  else FDCTool.ChRoot.Enabled := False; //erreur on désactive le Chroot le dossier n'existe pas

  if Assigned(FOnGetChrootPath) then
    FOnGetChrootPath(Self, WorkingNode, OK);
    
  //---[ADDRESS]----------------------------------------------------------------

  WorkingNode := WorkingNode.GetNext;  //address
  //SHOWMESSAGE(WorkingNode.Text);
  FDCTool.UploadOptions.ExecuteAddress := Droite(': ', WorkingNode.Text);
  if Assigned(FOnGetAddress) then
    FOnGetAddress(Self, WorkingNode);

  //---[FILENAME]---------------------------------------------------------------

  WorkingNode := WorkingNode.GetNext;//app path
  S := Droite(': ', WorkingNode.Text);

  OK := DirectoryExists(S);
  if OK then
    FDCTool.FileName := S + Node.Text;
  if Assigned(FOnGetFileName) then
    FOnGetFileName(Self, WorkingNode, OK);

  //---[EXECUTE]----------------------------------------------------------------

  WorkingNode := WorkingNode.GetNext;  //execute
  FDCTool.UploadOptions.ExecuteAfterUpload := Boolean(WorkingNode.Data);
  if Assigned(FOnGetUploadExecute) then
    FOnGetUploadExecute(Self, WorkingNode);

  //---[WORKDIR]----------------------------------------------------------------

  WorkingNode := WorkingNode.GetNext; //workdir
  //SHOWMESSAGE(WorkingNode.Text);
  S := Droite(': ', WorkingNode.Text);
  OK := DirectoryExists(S);

  if OK then
    SetCurrentDir(S);

  if Assigned(FOnGetWorkingDir) then
    FOnGetWorkingDir(Self, WorkingNode, OK);

  //---[FINAL...]---------------------------------------------------------------

  if Assigned(FOnReUpload) then
    FOnReUpload(Self, Node, Execute); //Declanchement de l'évènement

  //Si le mec veut que ce compo execute l'action... (moi je veux pas dans mon
  //prog, je vais me servir de l'évènement).
  if FDoReExecuteActions then
    FDCTool.Upload;
end;

procedure TDcToolHistoryView.SetUpForDownload(Node : TTreeNode);
var
  ConfigNode,              //node fixe "Config".
  WorkingNode : TTreeNode; //node qui va récuperer les valeurs pour DCTOOL
  S : string;              //variable permettant de stocker une string... général quoi.
  i : integer;             //pareil que S mais pour les entiers.
  OK : boolean;            //pareil que i mais boolean

begin
  ConfigNode := Node.GetNext;  //Nous avons la node 'Config'.

  if not FAddConnectionType then
    WorkingNode := ConfigNode.GetNext
  else begin
    //Si y'a ConnectionType, c'est la node suivante... Car elle est placée
    //au début de "Config".
    WorkingNode := ConfigNode.GetNext;
    WorkingNode := WorkingNode.GetNextSibling;
  end;

  //---[ADDRESS]----------------------------------------------------------------
  
  FDCTool.DownloadOptions.Address := Droite(': ', WorkingNode.Text); //address
  if Assigned(FOnGetAddress) then
    FOnGetAddress(Self, WorkingNode);

  //---[FILENAME]---------------------------------------------------------------

  WorkingNode := WorkingNode.GetNext;//app path
  S := Droite(': ', WorkingNode.Text);
  OK := DirectoryExists(S);

  if OK then
    FDCTool.FileName := S + Node.Text;
  if Assigned(FOnGetFileName) then
    FOnGetFileName(Self, WorkingNode, OK);

  //---[SIZE]-------------------------------------------------------------------

  WorkingNode := ConfigNode.GetNext; //size
  i := Integer(WorkingNode.Data);
  if i > 0 then
    begin
      FDCTool.DownloadOptions.FileSize := i;
      OK := True;
    end
  else
    OK := False;

  if Assigned(FOnGetDownloadSize) then
    FOnGetDownloadSize(Self, WorkingNode, OK);

  //---[WORKDIR]----------------------------------------------------------------

  WorkingNode := WorkingNode.GetNext; //workdir
  S := Droite(': ', WorkingNode.Text);
  OK := DirectoryExists(S);

  if OK then
    SetCurrentDir(S);
  if Assigned(FOnGetWorkingDir) then
    FOnGetWorkingDir(Self, WorkingNode, OK);

  //---[FINAL...]---------------------------------------------------------------

  if Assigned(FOnReDownload) then
    FOnReDownload(Self, Node); //Declanchement de l'évènement

  //Si le mec veut que ce compo execute l'action... (moi je veux pas dans mon
  //prog, je vais me servir de l'évènement).
  if FDoReExecuteActions then
    FDCTool.Download;
end;

procedure TDcToolHistoryView.SetUpForReset(Node : TTreeNode);
begin
  if Assigned(FOnReReset) then
    FOnReReset(Self, Node);

  if FDoReExecuteActions then
    FDCTool.Reset;  
end;

procedure TDcToolHistoryView.AddDownloadHistory;
var
  SubParentNode : TTreeNode;

begin
  FParentNode := Items.Add(nil, ExtractFileName(FDCTool.FileName));
  FParentNode.Selected := True;
  FParentNode.ImageIndex := DOWNLOAD_IMG;  //Icône :)
  FParentNode.SelectedIndex := DOWNLOAD_IMG;

  //Informations             
  SubParentNode := AddTreeItem(FParentNode, 'Config', CONFIG_IMG);

  //Ajouter les infos de connection.
  if FAddConnectionType then
    AddLinkInfos(SubParentNode);

  //Download lui même
  AddTreeItem(SubParentNode, 'Address : ' + FDCTool.DownloadOptions.Address, ADDR_IMG);
  AddTreeItem(SubParentNode, 'App path : ' + ExtractFilePath(FDCTool.FileName), APPPATH_IMG);
  AddTreeItem(SubParentNode, 'Size : ' + IntToStr(FDCTool.DownloadOptions.FileSize) + ' bytes', SIZE_IMG);
  SubParentNode.Data := Pointer(FDCTool.DownloadOptions.FileSize); //la taille dans le data
  AddTreeItem(SubParentNode, 'Working Path : ' + GetCurrentDir, WORKDIR_IMG);
end;

procedure TDcToolHistoryView.AddResetHistory;
var
  SubParentNode : TTreeNode;
  
begin
  FParentNode := Items.Add(nil, 'Reset');
  FParentNode.Selected := True;
  FParentNode.ImageIndex := RESET_IMG;  //Icône :)
  FParentNode.SelectedIndex := RESET_IMG;

  //Informations
  if FAddConnectionType then
  begin
    SubParentNode := AddTreeItem(FParentNode, 'Config', CONFIG_IMG);

    //Ajouter les infos de connection.
    AddLinkInfos(SubParentNode);
  end;
end;

function TDcToolHistoryView.GetNodeState(Node: TTreeNode): TExecutableType;
var
  ind : integer;

begin
  ind := Node.ImageIndex;

  {UPLOAD_IMG    : integer = 0;
  DOWNLOAD_IMG  : integer = 1;
  RESET_IMG     : integer = 2;}

  Result := etNone;

  case ind of
    0 : if Boolean(Node.Data) then
          Result := etUploadExecute
        else Result := etUpload;   //upload... Dans le Data on a stocké si c'était executable.

    1 : Result := etDownload;     //download.
    2 : Result := etReset;        //reset
  end;

end;

procedure TDcToolHistoryView.AddEnabledTreeItem(ParentNode: TTreeNode ;
    Caption : string ; State: boolean ; CustomImg : integer);
var
  S : string;
  StateImg : integer;
  CurrNode : TTreeNode;

begin
  S := Caption + BoolToCaption(State);

  if CustomImg = -1 then
  begin
    if State then
      StateImg := ENABLED_Y_IMG
    else StateImg := ENABLED_N_IMG;
  end else StateImg := CustomImg;

  CurrNode := AddTreeItem(ParentNode, S, StateImg);
  CurrNode.Data := Pointer(State); //stocker True ou False selon ce qui est spécifié.
end;

end.
