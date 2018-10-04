{
  Unit Re_Execute : RE-EXECUTE PopUp Menu Command
  For DC-TOOL GUI v1.2
  by [big_fury]SiZiOUS
  Date : 22/05/04, Sunday
  Time : 23:25:48

  Updated : Date : 26/05/04, Wed
            Time : 20:13:46


  Description : Implemente le menu 'Ré-executer' dans la TreeView (et que ca!)
                Sauvegarde des paramètres avant chaque opération,
                lancement de la commande en obtenant les anciens parametres
                utilisé, puis restitution des vrais parametres.

                Tout est géré! Rien n'est changé ;)

  Update      : Tout est géré pour la ré-execution BBA :)

}

unit re_execute;

interface

uses
  Windows, SysUtils, ComCtrls;

//ParentNode sert à récuperer les informations sur les parametres utilisés.
//C'est la première node à chaque fois.
procedure ReExecuteDownload(ParentNode : TTreeNode);
procedure ReExecuteUpload(ParentNode : TTreeNode);

implementation

uses main, tools, utils, upload, download, setsize, baudrate, address, bba,
     setip;

//Constante 'types'.
const
  opUpload      : integer = 0;
  opDownload    : integer = 1;

//Variables pour la sauvegarde.
var
  Size          : string  = '';
  Address       : string  = '';
  FileName      : string  = '';
  ComPort       : string  = '';
  Baudrate      : integer = 0;
  ConnectMethod : Word = $FF;  //SERIAL
  IP            : string  = '0.0.0.0';
  
//---GetFileNameToProcess---
function GetUsedFileNameToProcess(ParentNode : TTreeNode) : string;
var
  ConfigNode, PathNode : TTreeNode;
  Path, FileName : string;

begin
  Result := '';

  ConfigNode := ParentNode.GetFirstChild;
  PathNode := ConfigNode.Item[1];
  if PathNode = nil then Exit;

  Path := Droite(': ', PathNode.Text);
  FileName := GetRealPath(Path) + ParentNode.Text;
  //Ici on a le nom a réutiliser.
  Result := FileName;
end;

//--GetAddress---
function GetUsedAddress(ParentNode : TTreeNode) : string;
var
  ConfigNode, InfoNode : TTreeNode;

begin
  Result := '';
  ConfigNode := ParentNode.GetFirstChild;
  InfoNode := ConfigNode.Item[0];
  if InfoNode = nil then Exit;

  Result := Droite(': ', InfoNode.Text);
end;

//--GetBaudrate---
function GetUsedBaudrate(ParentNode : TTreeNode) : integer;
var
  ConfigNode, InfoNode : TTreeNode;

begin
  Result := 115200;
  ConfigNode := ParentNode.GetFirstChild;
  InfoNode := ConfigNode.Item[2];
  if InfoNode = nil then Exit;
  Result := StrToInt(ExtractStr(': ', ' ', InfoNode.Text));
end;

//--GetComPort---
function GetUsedCOMPort(ParentNode : TTreeNode) : string;
var
  ConfigNode, InfoNode : TTreeNode;

begin
  Result := '';
  ConfigNode := ParentNode.GetFirstChild;
  if ConfigNode = nil then Exit;
  
  InfoNode := ConfigNode.Item[3];
  if InfoNode = nil then Exit;

  Result := Droite(': ', InfoNode.Text);
end;

//--GetUsedSize---
function GetUsedSize(ParentNode : TTreeNode) : string;
var
  ConfigNode, InfoNode : TTreeNode;

begin
  Result := '';
  ConfigNode := ParentNode.GetFirstChild;
  if ConfigNode.Count <> 5 then Exit;

  InfoNode := ConfigNode.Item[4];
  if InfoNode = nil then Exit;

  Result := ExtractStr(': ', ' ', InfoNode.Text);
end;

//--GetUsedIP---
function GetUsedIP(ParentNode : TTreeNode) : string;
var
  ConfigNode, InfoNode : TTreeNode;

begin
  Result := '';
  ConfigNode := ParentNode.GetFirstChild;
  if ConfigNode.Count < 3 then Exit;
  
  InfoNode := ConfigNode.Item[2];
  if InfoNode = nil then Exit;

  Result := Droite('IP : ', InfoNode.Text);
end;

//---SaveCurrentSettings---
procedure SaveCurrentSettings(Operation : integer);
begin
  if GetConnectionMethod = LINK_TYPE_SERIAL then
    ConnectMethod := LINK_TYPE_SERIAL
  else ConnectMethod := LINK_TYPE_BBA;

  //DetectLinkType(
    
  Baudrate := SetBaudrate_Form.Baudrate.ItemIndex;
  Address := Address_Form.Address.Text;
  ComPort := GetCOMPort;
  if Operation = opDownload then FileName := Download_Form.Output_Edit.Text
    else FileName := Upload_Form.Input_Edit.Text;

  Size := SetSize_Form.Size.Text;
  IP := IP_Form.eIP.Text;
end;

//---ConvertStringToPortCOM---
procedure ConvertStringToPortCOM(COMPort : string);
begin
  if UpperCase(COMPort) = 'COM1' then Main_Form.COM1.Click;
  if UpperCase(COMPort) = 'COM2' then Main_Form.COM2.Click;
  if UpperCase(COMPort) = 'COM3' then Main_Form.COM3.Click;
  if UpperCase(COMPort) = 'COM4' then Main_Form.COM4.Click;
end;

//---ConvertStringToBaudrate---
function ConvertStringToBaudrate(Baudrate : integer) : integer;
begin
  Result := 8;
  case Baudrate of
    300 : Result := 0;
    1200 : Result := 1;
    2400 : Result := 2;
    4800 : Result := 3;
    9600 : Result := 4;
    19200 : Result := 5;
    38400 : Result := 6;
    57600 : Result := 7;
    115200 : Result := 8;
  end;
end;

//---LoadCurrentSettings---
procedure LoadCurrentSettings(Operation : integer);
begin
  SetBaudrate_Form.Baudrate.ItemIndex := Baudrate;
  Address_Form.Address.Text := Address;
  ConvertStringToPortCOM(ComPort);

  if Operation = opDownload then Download_Form.Output_Edit.Text := FileName
    else Upload_Form.Input_Edit.Text := FileName;   

  SetSize_Form.Size.Text := Size;
  IP_Form.eIP.Text := IP;   

  if ConnectMethod = LINK_TYPE_SERIAL then
    Main_Form.Serial1.Click
  else Main_Form.BroadbandAdapter1.Click;
end;

//---SetNewSettings---
procedure SetNewSettings(Operation, NewBaudrate : integer ; NewFileName,
  NewComPort, NewAddress, NewSize : string);
  
begin
  SetSize_Form.Size.Text := NewSize;
  SetBaudrate_Form.Baudrate.ItemIndex := NewBaudrate;
  Address_Form.Address.Text := NewAddress;
  ConvertStringToPortCOM(NewComPort);

  if Operation = opUpload then
  begin
    Upload_Form.Input_Edit.Text := NewFileName;
    Upload_Form.OK.Click;
  end else begin
    Download_Form.Output_Edit.Text := NewFileName;
    Download_Form.OK.Click;
  end;
end;

//---SetNewBBASettings---
procedure SetNewBBASettings(Operation : integer ; NewFileName,
  NewIP, NewAddress, NewSize : string);

begin
  SetSize_Form.Size.Text := NewSize;
  IP_Form.eIP.Text := NewIP;
  Address_Form.Address.Text := NewAddress;
  //ConvertStringToPortCOM(NewComPort);

  if Operation = opUpload then
  begin
    Upload_Form.Input_Edit.Text := NewFileName;
    Upload_Form.OK.Click;
  end else begin
    Download_Form.Output_Edit.Text := NewFileName;
    Download_Form.OK.Click;
  end;
end;

//---DetectLinkType---
function DetectLinkType(ParentNode : TTreeNode) : Word;
var
  ConfigNode, InfoNode : TTreeNode;

begin
  Result := LINK_TYPE_SERIAL;
  ConfigNode := ParentNode.GetFirstChild;
  if ConfigNode.Count < 3 then Exit;
  //howMessage('OK');
  InfoNode := ConfigNode.Item[2];
  if InfoNode = nil then Exit;
  //ShowMessage('OK');
  //ShowMessage(Gauche(' :', InfoNode.Text));

  if UpperCase(Gauche(' :', InfoNode.Text)) = 'IP' then
    Result := LINK_TYPE_BBA;
end;

//----ReExecuteDownload----
procedure ReExecuteDownload(ParentNode : TTreeNode);

//***ExecuteSerialDownload***
procedure ExecuteSerialDownload;
begin
  Main_Form.Serial1.Click;
  SetNewSettings(opDownload, ConvertStringToBaudrate(GetUsedBaudrate(ParentNode)),
    GetUsedFileNameToProcess(ParentNode), GetUsedComPort(ParentNode),
      GetUsedAddress(ParentNode), GetUsedSize(ParentNode))
end;

//***ExecuteBBADownload***$
procedure ExecuteBBADownload;
begin
  Main_Form.BroadbandAdapter1.Click;
  SetNewBBASettings(opDownload, GetUsedFileNameToProcess(ParentNode),
    GetUsedIP(ParentNode), GetUsedAddress(ParentNode), GetUsedSize(ParentNode));
end;

begin
  SaveCurrentSettings(opUpload);

  if DetectLinkType(ParentNode) = LINK_TYPE_SERIAL then
    ExecuteSerialDownload
  else ExecuteBBADownload;

  LoadCurrentSettings(opUpload);
end;

//----ReExecuteUpload----
procedure ReExecuteUpload(ParentNode : TTreeNode);

//***ExecuteSerialUpload***
procedure ExecuteSerialUpload;
begin
  Main_Form.Serial1.Click;
  SetNewSettings(opUpload, ConvertStringToBaudrate(GetUsedBaudrate(ParentNode)),
    GetUsedFileNameToProcess(ParentNode), GetUsedComPort(ParentNode),
      GetUsedAddress(ParentNode), GetUsedSize(ParentNode));
end;

//***ExecuteBBAUpload***
procedure ExecuteBBAUpload;
begin
  Main_Form.BroadbandAdapter1.Click;
  SetNewBBASettings(opUpload, GetUsedFileNameToProcess(ParentNode),
    GetUsedIP(ParentNode), GetUsedAddress(ParentNode), GetUsedSize(ParentNode));
end;


begin
  SaveCurrentSettings(opDownload);

  if DetectLinkType(ParentNode) = LINK_TYPE_SERIAL then
    ExecuteSerialUpload
  else ExecuteBBAUpload;
  
  LoadCurrentSettings(opDownload);
end;

end.
