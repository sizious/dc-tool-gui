unit tools;

interface

uses
  JvComCtrls, JvRichEdit, Classes, Windows, SysUtils, Forms, Controls, Graphics,
  ComCtrls, Dialogs, Messages;

const
  WrapStr         : string = #13 + #10;
  DEFAULT_ADDRESS : string = '0x8C010000';

var
  RestoredOneTime  : boolean = False;
  MinimizedOneTime : boolean = False;

procedure ExtractFile(Chemin, Ressource, Extension : string);
function GetTempDir: String;
procedure AddDebug(Msg : string);
function MsgBox(Handle : HWND ; Message, Caption : string ; Flags : integer) : integer;
procedure ReadConfig;
procedure WriteConfig;
procedure WriteCOM;
procedure ReadCOM;
procedure ConfigureApplication;
procedure WriteBaudRate;
procedure ReadBaudRate;
procedure WriteAddress;
procedure ReadAddress;
procedure WriteSize;
procedure ReadSize;
procedure PutHeader;
procedure AddTreeNode(FileName : string ; Upload : boolean);
procedure AddEndIndexOfCmd;
//function GetLastNode : TTreeNode;
function GetBaudrate : string;
function GetCOMPort : string;
procedure GotoLine(JvRichEdit : TJvRichEdit ; Index : integer);
function IsInString(Substr : string ; s : string) : boolean;
function ExtractStr(SubStrL, SubStrR, S : string) : string;
function GetRealPath(Path : string) : string;
//procedure DelLastLine;
//procedure AddNewOutput(Line : string);
function Droite(substr : string ; s: string) : string;
procedure ShowMessage(Message : string);
procedure MinimizeForm(Form : TForm);
procedure ReadLinkType;
procedure WriteLinkType;
procedure RestoreForm(Form : TForm);
procedure ReadSavedIP;
procedure WriteIP;
procedure AddBBATreeNode(FileName : string ; Upload : boolean);
function Gauche(substr: string; s: string) : string;
procedure PutFilteredHeader;
procedure ReadFilters;
procedure WriteFilters;
procedure ReadFilteredFormStyle;
procedure WriteFilteredFormStyle;
procedure PerformGeneralReset;
procedure WriteISOState;
procedure ReadISOState;
procedure WriteChRootState;
procedure ReadChRootState;
procedure ReadBINDetectConfig;
procedure WriteBINDetectConfig;
function ExtractFileSize(FileName : string) : integer;
function ReadWarningState(WarningType : string) : boolean;
procedure SaveWarningState(WarningType : string);
function IsStartAddressDefault : boolean;
procedure Delay(Delai : Double);
function IsFileInUse(FileName : string) : boolean;
function ShowWarningWin(MessageCaption : string) : integer;
function NbSousChaine(SubStr: string ; S : string) : integer;
procedure SaveRichEditTo(JvRichEdit : TJvRichEdit ; SaveDialog : TSaveDialog);
function DroiteDroite(substr : string ; s: string) : string;
procedure LoadCygwinConfig;
procedure SaveCygwinConfig;
procedure WriteOptions;
procedure ReadOptions;

implementation

uses setip, u_hist, r_colors, main, dctool_cfg, upload, download, setsize, baudrate,
     address, u_filters, filtered, bba, progress, u_kill_dctool, u_ctrls,
     advanced, binchk, warning, dl_progress, options, cygwin, u_dctool_manager,
     utils;

{ -------------------------------------< IsStartAddressDefault >----------------------------------------------------------- }

function IsStartAddressDefault : boolean;
begin
  if UpperCase(Address_Form.Address.Text) = UpperCase(DEFAULT_ADDRESS) then
    Result := True
  else Result := False;
end;

{ -------------------------------------< Delay >----------------------------------------------------------- }

procedure Delay(Delai : Double);
Var
  HeureDepart:TDateTime;

begin
  HeureDepart:=now;
  Delai:=delai/24/60/60/1000; //transforme les millisecondes en fractions de jours
  repeat
    Application.ProcessMessages; // rend la main à Windows pour ne pas blocquer les autres applications
  Until Now>HeureDepart+Delai;
end;

{ -------------------------------------< ShowMessage >----------------------------------------------------------- }

procedure ShowMessage(Message : string);
begin
  MsgBox(Application.Handle, Message, Application.Title, 0);
end;

{ -------------------------------------< Droite >----------------------------------------------------------- }

function Droite(substr : string ; s: string) : string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

{ -------------------------------------< Gauche >----------------------------------------------------------- }

function Gauche(substr: string; s: string) : string;
begin
  result:=copy(s, 1, pos(substr, s)-1);
end;

{ -------------------------------------< AddNewOutput >----------------------------------------------------------- }

{procedure AddNewOutput(Line : string);

//---Droite----
function Droite(substr : string ; s: string) : string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

var
  CurrentLine, Tmp : string;
  LastIndex : integer;

begin
  SetTextAttribut(Main_Form.mOutput, clBlue);
  
  LastIndex := Main_Form.mOutput.Lines.Count - 1;
  CurrentLine := 'OUTPUT:> ' + Main_Form.mOutput.Lines.Strings[LastIndex];
  Tmp := Droite(CurrentLine, Line);
  Main_Form.mOutput.Lines[LastIndex] := CurrentLine + Tmp;
  //Main_Form.mOutput.Lines.   (PChar(CurrentLine + Tmp));
  //Main_Form.mOutput.Lines.Strings[Main_Form.mOutput.Lines.Count - 1] := Main_Form.mOutput.Lines.Strings[Main_Form.mOutput.Lines.Count - 1] + Tmp;
end; }

{ procedure AddNewOutput(Line : string);
var
  //CharsToWrite : string;
  LastIndex   : integer;
  //TextWritted : string;

begin
  //Main_Form.mOutput.Lines.Add('');
  //ShowMessage('Line : ' + Line);

  //Bon ca c'est pour le texte en bleu
  SetTextAttribut(Main_Form.mOutput, clBlue);

  //On récupère l'indice de la dernière ligne...
  LastIndex := Main_Form.mOutput.Lines.Count - 1;
  //ShowMessage('LastIndex : ' + IntToStr(LastIndex));

  //...puis le texte dans la dernière ligne (celui qu'on a déjà)
  //TextWritted := Main_Form.mOutput.Lines.Strings[Main_Form.mOutput.Lines.Count - 1];
  //ShowMessage('TextWritted : ' + TextWritted);

  //Comparons maintenant ce qu'il y'a de nouveau
  //CharsToWrite := Droite(TextWritted, Line);
  //ShowMessage('Voici ce qui a de nouveau entre' + WrapStr +  'la ligne recue et le contenu du RichEdit : ' + CharsToWrite);
  
  //Ajoutons maintenant ce qui y'a de nouveaux SEULEMENT!
  //Main_Form.mOutput.Lines[LastIndex] := TextWritted + CharsToWrite;
  Main_Form.mOutput.Lines[LastIndex] := Line;
  //ShowMessage('Maintenant y''a ca : ' + Main_Form.mOutput.Lines[LastIndex]);  
end;  }

{-------------------------------------< DelLastLine >----------------------------------------------------------- }

{ procedure DelLastLine;
begin
  Main_Form.mOutput.Lines.Delete(Main_Form.mOutput.Lines.Count - 1);
end; }

{-------------------------------------< GetRealPath >----------------------------------------------------------- }

{function GetRealPath(Path : string) : string;
var
  Dir : string;

begin
  Dir := Path;
  if Path = '' then exit;
  while Path[length(Path)] = '\' do
  begin
    //MsgBox(0, 'Path : ' + Path, 'ERROR', 0);
    Path := Copy(Path, 1, length(Path) - 1);
  end;
  if Path = '' then
  begin
    Result := Dir;
    exit;
  end;
  Result := Path + '\';
end; }  //Cette fonction enlevait les \ en trop A LA FIN du path.

//Celle ci, de Rabusier, corrige TOUT les \ du paths.
function GetRealPath(Path : string) : string;
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

{-------------------------------------< MSGBOX >----------------------------------------------------------- }

function MsgBox(Handle : HWND ; Message, Caption : string ; Flags : integer) : integer;
begin
  Result := MessageBoxA(Handle, PChar(Message), PChar(Caption), Flags);
end;

{-------------------------------------< EXTRACTFILE >----------------------------------------------------------- }

procedure ExtractFile(Chemin, Ressource, Extension :string);
var
 StrNomFichier : string;
 ResourceStream : TResourceStream;
 FichierStream  : TFileStream;

begin
    StrNomFichier := Chemin + '\' + Ressource + '.' + Extension;
    ResourceStream := TResourceStream.Create(hInstance, Ressource, RT_RCDATA);

    try
      FichierStream := TFileStream.Create(StrNomFichier, fmCreate);
      try
        FichierStream.CopyFrom(ResourceStream, 0);
      finally
        FichierStream.Free;
      end;
    finally
      ResourceStream.Free;
    end;
end;

{-------------------------------------< GETTEMPDIR >----------------------------------------------------------- }

function GetTempDir: String;
var
  Dossier: array[0..MAX_PATH] of Char;

begin
  Result := '';
  if GetTempPath(SizeOf(Dossier), Dossier)<>0 then Result := StrPas(Dossier);
end;

{-------------------------------------< NbSousChaine >----------------------------------------------------------- }

function NbSousChaine(SubStr: string ; S : string) : integer;
begin
  result:=0;
  while pos(substr,s)<>0 do
  begin
    S:=droite(substr,s);
    inc(result);
  end;
end;

{-------------------------------------< IsInString >----------------------------------------------------------- }

function IsInString(Substr : string ; s : string) : boolean;
begin
  if NbSousChaine(SubStr, S) > 0 then
    Result := True
  else Result := False;
end; 

{-------------------------------------< ADDDEBUG >----------------------------------------------------------- }

procedure AddDebug(Msg : string);
begin
  //if Main_Form.Visible = True then
  //  GotoLine(Main_Form.mOutput, Main_Form.mOutput.Lines.Count - 1);
    
  if Msg = ' ' then Main_Form.mOutput.Lines.Add('')
  else begin
    if IsInString('CMD:>', Msg) then SetTextAttribut(Main_Form.mOutput, clGreen);
    if IsInString('OUTPUT:>', Msg) then SetTextAttribut(Main_Form.mOutput, clBlue);
    if IsInString('STATE:>', Msg) then SetTextAttribut(Main_Form.mOutput, clRed);
    Main_Form.mOutput.Lines.Add(Msg);
  end;
  //Main_Form.mOutput.ItemIndex := Main_Form.AHListBox.Count - 1;
end;

{--------------------------------------< WriteConfig >----------------------------------------------------------- }

procedure WriteConfig;
begin
  //MODE CONNEXION
  Ini.WriteBool('Config', 'External', Dctool_Form.External_RadioButton.Checked);
  Ini.WriteBool('Config', 'Internal', Dctool_Form.Internal_RadioButton.Checked);
  Ini.WriteString('Config', 'Location', Dctool_Form.Location_Edit.Text);
  Ini.WriteBool('Config', 'ExternalSerial', Dctool_Form.Serial_RadioButton.Checked);
  Ini.WriteBool('Config', 'ExternalBBA', Dctool_Form.BBA_RadioButton.Checked);

  //Choix des options
  Ini.WriteBool('Config', 'TryAlternate115200', Main_Form.ryalternate1152001.Checked);
  Ini.WriteBool('Config', 'DontAttachConsoleFileServer', Main_Form.Dontattachconsoleandfileserver1.Checked);
  Ini.WriteBool('Config', 'UseDumbTerminal', Main_Form.Usedumbterminalrather1.Checked);
  Ini.WriteBool('Config', 'DontClearScreenBeforeDownload', Main_Form.Dontclearscreenbeforedownload1.Checked);
end;

{--------------------------------------< ReadConfig >----------------------------------------------------------- }

procedure ReadConfig;
begin
  //MODE CONNEXION
  Dctool_Form.External_RadioButton.Checked  := Ini.ReadBool('Config', 'External', False);
  Dctool_Form.Internal_RadioButton.Checked := Ini.ReadBool('Config', 'Internal', True);
  Dctool_Form.Location_Edit.Text := Ini.ReadString('Config', 'Location', '');
  Dctool_Form.Serial_RadioButton.Checked := Ini.ReadBool('Config', 'ExternalSerial', True);
  Dctool_Form.BBA_RadioButton.Checked := Ini.ReadBool('Config', 'ExternalBBA', False);

  if Dctool_Form.External_RadioButton.Checked = True then
    if Dctool_Form.BBA_RadioButton.Checked = True then
      Main_Form.BroadbandAdapter1.Click
    else Main_Form.Serial1.Click;

  //Choix des options
  Main_Form.ryalternate1152001.Checked := Ini.ReadBool('Config', 'TryAlternate115200', False);
  Main_Form.Dontattachconsoleandfileserver1.Checked := Ini.ReadBool('Config', 'DontAttachConsoleFileServer', False);
  Main_Form.Usedumbterminalrather1.Checked := Ini.ReadBool('Config', 'UseDumbTerminal', False);
  Main_Form.Dontclearscreenbeforedownload1.Checked := Ini.ReadBool('Config', 'DontClearScreenBeforeDownload', False);
end;

{--------------------------------------< WriteCOM >----------------------------------------------------------- }

procedure WriteCOM;
begin
  Ini.WriteBool('Config', 'COM1', Main_Form.COM1.Checked);
  Ini.WriteBool('Config', 'COM2', Main_Form.COM2.Checked);
  Ini.WriteBool('Config', 'COM3', Main_Form.COM3.Checked);
  Ini.WriteBool('Config', 'COM4', Main_Form.COM4.Checked);
end;

{--------------------------------------< ReadCOM >----------------------------------------------------------- }

procedure ReadCOM;
begin
  Main_Form.COM1.Checked := Ini.ReadBool('Config', 'COM1', True);
  Main_Form.COM2.Checked := Ini.ReadBool('Config', 'COM2', False);
  Main_Form.COM3.Checked := Ini.ReadBool('Config', 'COM3', False);
  Main_Form.COM4.Checked := Ini.ReadBool('Config', 'COM4', False);
end;

{--------------------------------------< WriteBaudRate >----------------------------------------------------------- }

procedure WriteBaudRate;
begin
  Ini.WriteInteger('Config', 'Baudrate', SetBaudrate_Form.Baudrate.ItemIndex);
end;

{--------------------------------------< ReadBaudRate >----------------------------------------------------------- }

procedure ReadBaudRate;
begin
  SetBaudrate_Form.Baudrate.ItemIndex := Ini.ReadInteger('Config', 'Baudrate', 7);
end;

{--------------------------------------< ReadAddress >----------------------------------------------------------- }

procedure ReadAddress;
begin
  Address_Form.Address.Text := Ini.ReadString('Config', 'Address', '0x8C010000');
end;

{--------------------------------------< ReadAddress >----------------------------------------------------------- }

procedure WriteAddress;
begin
  Ini.WriteString('Config', 'Address', Address_Form.Address.Text);
end;

{--------------------------------------< ReadAddress >----------------------------------------------------------- }

procedure ReadSize;
begin
  SetSize_Form.Size.Text := Ini.ReadString('Config', 'Size', '0');
end;

{--------------------------------------< ReadAddress >----------------------------------------------------------- }

procedure WriteSize;
begin
  Ini.WriteString('Config', 'Size', SetSize_Form.Size.Text);
end;

{--------------------------------------< ConfigureApplication >----------------------------------------------------------- }

procedure ConfigureApplication;
begin
  //ICI est chargée toute la config au démarrage du programme !
  ReadCOM;
  ReadConfig;
  ReadBaudRate;
  ReadAddress;
  ReadSize;
  ReadLinkType;
  ReadSavedIP;
  LoadList;
  ReadFilters;
  LoadHistoryFile;
  ReadFilteredFormStyle;
  ReadChRootState;
  ReadISOState;
  ReadBINDetectConfig;
  ReadOptions;
  LoadCygwinConfig;
  ConfigureApplicationLanguage; //Configurer la langue (dans utils).
end;

{--------------------------------------< WriteLinkType >----------------------------------------------------------- }

procedure WriteLinkType;
begin
  Ini.WriteBool('Config', 'SerialLinkType', Main_Form.Serial1.Checked);
  Ini.WriteBool('Config', 'BBALinkType', Main_Form.BroadbandAdapter1.Checked);
end;

{--------------------------------------< ReadLinkType >----------------------------------------------------------- }

procedure ReadLinkType;
begin
  Main_Form.Serial1.Checked := Ini.ReadBool('Config', 'SerialLinkType', True);
  Main_Form.BroadbandAdapter1.Checked := Ini.ReadBool('Config', 'BBALinkType', False);
  if Main_Form.Serial1.Checked = True then
    Main_Form.Serial1.Click
  else Main_Form.BroadbandAdapter1.Click;
end;

{-----------------------------------< PutFilteredHeader >----------------------------------------------------------- }

procedure PutFilteredHeader;
begin
  Filtered_Form.mFiltered.Clear; //Filtered
  AddFormattedText(Application.Title, Filtered_Form.mFiltered, clBlack, 8, 'Tahoma', [fsBold], 0);
  AddFormattedText('Only filtered outputs', Filtered_Form.mFiltered, clPurple);
  AddToFiltered(' ');
end;

{--------------------------------------< PutHeader >----------------------------------------------------------- }

procedure PutHeader;
begin
  Main_Form.mOutput.Clear;

  Main_Form.twFiles.Items.Clear;

  //Filtered mémo
  if Filtered_Form <> nil then
    PutFilteredHeader;

  //Normal mémo
  AddFormattedText(Application.Title, Main_Form.mOutput, clBlack, 8, 'Tahoma', [fsBold], 0);
  //AddFormattedText('For SERIAL version only', Main_Form.mOutput, clBlack, 8, 'Tahoma', [fsBold], 0);
  //AddDebug(Application.Title);
  AddDebug('Broadband Adapter and Serial Cable version');
  //AddDebug('For SERIAL version only');
  AddDebug('See about box for credits, thanks.');
  AddDebug('Date : ' + DateToStr(Date) + ' - Time : ' + TimeToStr(Time));
  AddDebug('');
end;

{--------------------------------------< AddEndOfCmd >----------------------------------------------------------- }

procedure AddEndIndexOfCmd;

//---GetLastNode----
{ function GetLastNode : TTreeNode;
begin
  Result := nil;
  if Main_Form.twFiles.Items.Count = 0 then Exit;
  //Result := Main_Form.twFiles.Items.Item[Main_Form.twFiles.Items.Count - 1];
  Result := Main_Form.twFiles.Selected;
end; }

//----SetIcon----
procedure SetIcon(Node : TTreeNode ; Index : integer);
begin
  Node.ImageIndex := Index;
  Node.SelectedIndex := Index;
end;

//---Main---
var
  Tw    : TJvTreeView;
  OutP  : TJvRichEdit;
  Node  : TTreeNode;

begin
  Tw := Main_Form.twFiles;
  OutP := Main_Form.mOutput;
  Node := Tw.Items.AddChild(ParentNode, 'Block End (' + IntToStr(OutP.Lines.Count - 2) + ')');
  //SetIcon(Node, 20);

  //Ouvrir le node
  if Ini.ReadBool('Options', 'DisableAutoExpandTree', False) = False then //option!   
    Node.Parent.Expand(False);

  SetIcon(Node, 20);
  Tw.Refresh;
end;

{--------------------------------------< GetCOMPort >----------------------------------------------------------- }

function GetCOMPort : string;
begin
  if Main_Form.COM1.Checked = True then Result := 'COM1'
  else if Main_Form.COM2.Checked = True then Result := 'COM2'
  else if Main_Form.COM3.Checked = True then Result := 'COM3'
  else if Main_Form.COM4.Checked = True then Result := 'COM4';
end;

{--------------------------------------< GetBaudrate >----------------------------------------------------------- }

function GetBaudrate : string;
begin
  case SetBaudrate_Form.Baudrate.ItemIndex of
    0 : Result := '300';
    1 : Result := '1200';
    2 : Result := '2400';
    3 : Result := '4800';
    4 : Result := '9600';
    5 : Result := '19200';
    6 : Result := '38400';
    7 : Result := '57600';
    8 : Result := '115200';
  end;
end;

{--------------------------------------< GotoLine >----------------------------------------------------------- }

{
FACON Vector
procedure GotoLineCol(AMemo: TCustomMemo; Line: Integer; Col: Integer = 0);
begin
SendMessage(AMemo.Handle, WM_VSCROLL, SB_TOP, 0);
SendMessage(AMemo.Handle, EM_LINESCROLL, Col, Line);
end;
}

{
FACON ReMix
procedure GotoLine(JvRichEdit : TJvRichEdit ; Index : integer);
var 
  i : integer; 

begin 
  SendMessage(JvRichEdit.Handle, WM_VSCROLL, SB_TOP, 0);

  for i := 0 to Index do 
    SendMessage(JvRichEdit.Handle, WM_VSCROLL, SB_LINEDOWN, 0); 
end; }

procedure GotoLine(JvRichEdit : TJvRichEdit ; Index : integer);
begin
  with JvRichEdit do 
  begin
    SelStart := Perform(EM_LINEINDEX, Index, 0); // + 3; // le +3 veut dire char num 3
    Perform(EM_SCROLLCARET, 0, 0); 
    SetFocus;
  end;
end;

{--------------------------------------< AddTreeNode >----------------------------------------------------------- }

procedure AddTreeNode(FileName : string ; Upload : boolean);

//----SetIcon----
procedure SetIcon(Node : TTreeNode ; Index : integer);
begin
  Node.ImageIndex := Index;
  Node.SelectedIndex := Index;
end;

//----Main-------
var
  Tw                      : TJvTreeView;
  OutP                    : TJvRichEdit;
  OptionNode, DateTime,
  AddNode, AppPathNode,
  BaudrateNode, COMPort,
  Size, DateIcon, TimeIcon,
  AddBlock                : TTreeNode;

begin
  Tw := Main_Form.twFiles;
  OutP := Main_Form.mOutput;

  ParentNode := Tw.Items.Add(nil, ExtractFileName(FileName));
  ParentNode.Selected := True;

  //Icône :)
  if Upload = True then
    SetIcon(ParentNode, 3)
  else SetIcon(ParentNode, 2);

  //Informations
  OptionNode := Tw.Items.AddChild(ParentNode, 'Config');
  SetIcon(OptionNode, 1);
  
  AddNode := Tw.Items.AddChild(OptionNode, 'Address : ' + Address_Form.Address.Text);
  SetIcon(AddNode, 11);
  AppPathNode := Tw.Items.AddChild(OptionNode, 'App Path : ' + ExtractFilePath(FileName));
  SetIcon(AppPathNode, 16);
  BaudrateNode := Tw.Items.AddChild(OptionNode, 'Baudrate : ' + GetBaudrate + ' bauds');
  SetIcon(BaudrateNode, 5);
  COMPort := Tw.Items.AddChild(OptionNode, 'COM Port : ' + GetCOMPort);
  SetIcon(COMPort, 4);
  if Upload = False then
  begin
    Size := Tw.Items.AddChild(OptionNode, 'Size : ' + SetSize_Form.Size.Text + ' bytes');
    SetIcon(Size, 6);
  end;

  DateTime := Tw.Items.AddChild(ParentNode, 'Date/Time');
  SetIcon(DateTime, 17);
  DateIcon := Tw.Items.AddChild(DateTime, DateToStr(Date));
  SetIcon(DateIcon, 19);
  TimeIcon := Tw.Items.AddChild(DateTime, TimeToStr(Now));
  SetIcon(TimeIcon, 19);

  //Bloc Start
  AddBlock := Tw.Items.AddChild(ParentNode, 'Block Start (' + IntToStr(OutP.Lines.Count) + ')');
  SetIcon(AddBlock, 20);

  Tw.Refresh;
end;

{----------------------------------------< ExtractStr >----------------------------------------------------------- }

function ExtractStr(SubStrL, SubStrR, S : string) : string;

function droite(substr: string; s: string): string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;
 
function gauche(substr: string; s: string): string; 
begin
  result:=copy(s, 1, pos(substr, s)-1);
end;

//Utilise Droite & Gauche de Michel
var
  Tmp : string;

begin
  Tmp := Droite(SubStrL, S);
  Result := Gauche(SubStrR, Tmp);
end;

{----------------------------------------< MinimizeForm >----------------------------------------------------------- }

procedure MinimizeForm(Form : TForm);
begin
  if MinimizedOneTime = True then Exit;
  PostMessage(Form.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  MinimizedOneTime := True;
end;

{----------------------------------------< RestoreForm >----------------------------------------------------------- }

procedure RestoreForm(Form : TForm);
begin
  if RestoredOneTime = True then Exit;
  PostMessage(Form.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
  RestoredOneTime := True;
end;

{----------------------------------------< WriteIP >----------------------------------------------------------- }

procedure WriteIP;
begin
  Ini.WriteString('Config', 'IP', IP_Form.eIP.Text);
end;

{----------------------------------------< ReadIP >----------------------------------------------------------- }

procedure ReadSavedIP;
begin
  IP_Form.eIP.Text := Ini.ReadString('Config', 'IP', '000.000.000.000');
end;

{--------------------------------------< AddBBATreeNode >----------------------------------------------------------- }

procedure AddBBATreeNode(FileName : string ; Upload : boolean);

//----SetIcon----
procedure SetIcon(Node : TTreeNode ; Index : integer);
begin
  Node.ImageIndex := Index;
  Node.SelectedIndex := Index;
end;

//----Main-------
var
  Tw                      : TJvTreeView;
  OutP                    : TJvRichEdit;
  OptionNode, DateTime,
  AddNode, AppPathNode,
  IPNode, Size, DateIcon,
  TimeIcon, AddBlock      : TTreeNode;

begin
  Tw := Main_Form.twFiles;
  OutP := Main_Form.mOutput;

  ParentNode := Tw.Items.Add(nil, ExtractFileName(FileName));
  ParentNode.Selected := True;

  //Icône :)
  if Upload = True then
    SetIcon(ParentNode, 3)
  else SetIcon(ParentNode, 2);

  //Informations
  OptionNode := Tw.Items.AddChild(ParentNode, 'Config');
  SetIcon(OptionNode, 1);
  
  AddNode := Tw.Items.AddChild(OptionNode, 'Address : ' + Address_Form.Address.Text);
  SetIcon(AddNode, 11);
  AppPathNode := Tw.Items.AddChild(OptionNode, 'App Path : ' + ExtractFilePath(FileName));
  SetIcon(AppPathNode, 16);

  //BaudrateNode := Tw.Items.AddChild(OptionNode, 'Baudrate : ' + GetBaudrate + ' bauds');
  //SetIcon(BaudrateNode, 5);
  //COMPort := Tw.Items.AddChild(OptionNode, 'COM Port : ' + GetCOMPort);
  //SetIcon(COMPort, 4);.
  IPNode := Tw.Items.AddChild(OptionNode, 'IP : ' + IP_Form.eIP.Text);
  SetIcon(IPNode, 25);
  
  if Upload = False then
  begin
    Size := Tw.Items.AddChild(OptionNode, 'Size : ' + SetSize_Form.Size.Text + ' bytes');
    SetIcon(Size, 6);
  end;

  DateTime := Tw.Items.AddChild(ParentNode, 'Date/Time');
  SetIcon(DateTime, 17);
  DateIcon := Tw.Items.AddChild(DateTime, DateToStr(Date));
  SetIcon(DateIcon, 19);
  TimeIcon := Tw.Items.AddChild(DateTime, TimeToStr(Now));
  SetIcon(TimeIcon, 19);

  //Bloc Start
  AddBlock := Tw.Items.AddChild(ParentNode, 'Block Start (' + IntToStr(OutP.Lines.Count) + ')');
  SetIcon(AddBlock, 20);
end;

{----------------------------------------< WriteFilters >----------------------------------------------------------- }

procedure WriteFilters;
begin
  Ini.WriteBool('Config', 'EnableFilters', Main_Form.Enablefilters1.Checked);
end;

{----------------------------------------< ReadFilters >----------------------------------------------------------- }

procedure ReadFilters;
begin
  Main_Form.Enablefilters1.Checked := Ini.ReadBool('Config', 'EnableFilters', False);
end;

{-----------------------------------< WriteFilteredFormStyle >----------------------------------------------------------- }

procedure WriteFilteredFormStyle;
begin
  Ini.WriteBool('Config', 'FilteredFormStyle', Filtered_Form.Stayontop1.Checked);
end;

{-----------------------------------< ReadFilteredFormStyle >----------------------------------------------------------- }

procedure ReadFilteredFormStyle;
var
  MustClick : boolean;

begin
  //Filtered_Form.Stayontop1.Checked
  MustClick := Ini.ReadBool('Config', 'FilteredFormStyle', False);

  if MustClick = True then
    Filtered_Form.Stayontop1.Click;
end;

{-----------------------------------< PerformGeneralReset >----------------------------------------------------------- }

procedure PerformGeneralReset;
begin
  AddDebug('CMD:> Performing DC-TOOL reset on ' + DateToStr(Date) + ', ' + TimeToStr(Time));

  //UPLOADING
  if Main_Form.UpDosCommand.Active = True then
  begin
    AddDebug('STATE:> Process in progress, stopping running process...');
    Main_Form.UpDosCommand.Stop;
  end;

  //Sending BBA reset
  if GetConnectionMethod = LINK_TYPE_BBA then
  begin
    AddDebug('STATE:> Sending Reset command to DC-TOOL-IP...');

    if PerformBBAReset = True then
      AddDebug('STATE:> Function return OK.')
    else AddDebug('STATE:> Function return error.');
  end else AddDebug('STATE:> Function return OK.');

  //Cacher la fenetre d'upload
  if UpProgress_Form.Visible = True then
    UpProgress_Form.Hide;

  //Cacher la fenetre de download
  if DownProgress_Form.Visible = True then
    DownProgress_Form.Hide;

  //DOWNLOADING
  if Main_Form.DownDosCommand.Active = True then
  begin
    AddDebug('STATE:> Process in progress, stopping running process...');
    Main_Form.DownDosCommand.Stop;
  end;

  //On tue tout!
  KillAllRunningDCTOOL;
  ActiveControls;
  ExtractAllDCTOOL;
  
  AddDebug(' ');
end;

{-----------------------------------< WriteISOState >----------------------------------------------------------- }

procedure WriteISOState;
begin
  Ini.WriteBool('Config', 'ISOState', Advanced_Form.cbISO.Checked);
  Ini.WriteString('Config', 'ISOStateFile', Advanced_Form.eISO.Text);
end;

{-----------------------------------< ReadISOState >----------------------------------------------------------- }
           
procedure ReadISOState;
begin
  Advanced_Form.cbISO.Checked := Ini.ReadBool('Config', 'ISOState', False);
  Advanced_Form.eISO.Text := Ini.ReadString('Config', 'ISOStateFile', '');
end;

{-----------------------------------< WriteChRootState >----------------------------------------------------------- }

procedure WriteChRootState;
begin
  Ini.WriteBool('Config', 'ChRootState', Advanced_Form.cbChRoot.Checked);
  Ini.WriteString('Config', 'ChRootStatePath', Advanced_Form.eChRoot.Text);
end;

{-----------------------------------< ReadChRootState >----------------------------------------------------------- }

procedure ReadChRootState;
begin
  Advanced_Form.cbChRoot.Checked := Ini.ReadBool('Config', 'ChRootState', False);
  Advanced_Form.eChRoot.Text := Ini.ReadString('Config', 'ChRootStatePath', '');
end;

{-----------------------------------< ReadBINDetectConfig >----------------------------------------------------------- }

procedure ReadBINDetectConfig;
begin
  BinCheck_Form.rbAskOnlyBeforeUnscrambling.Checked := Ini.ReadBool('BIN Check Module', 'AskOnlyBeforeUnscrambling', True);
  BinCheck_Form.rbAskAlways.Checked := Ini.ReadBool('BIN Check Module', 'AskAlways', False);
  BinCheck_Form.rbDoNotAskAnyThing.Checked := Ini.ReadBool('BIN Check Module', 'DoNotAskAnyThing', False);
  BinCheck_Form.rbDoNotUseThis.Checked := Ini.ReadBool('BIN Check Module', 'DoNotUseThis', False);
end;

{-----------------------------------< WriteBINDetectConfig >----------------------------------------------------------- }

procedure WriteBINDetectConfig;
begin
  Ini.WriteBool('BIN Check Module', 'AskOnlyBeforeUnscrambling', BinCheck_Form.rbAskOnlyBeforeUnscrambling.Checked);
  Ini.WriteBool('BIN Check Module', 'AskAlways', BinCheck_Form.rbAskAlways.Checked);
  Ini.WriteBool('BIN Check Module', 'DoNotAskAnyThing', BinCheck_Form.rbDoNotAskAnyThing.Checked);
  Ini.WriteBool('BIN Check Module', 'DoNotUseThis', BinCheck_Form.rbDoNotUseThis.Checked);
end;

{-----------------------------------< ExtractFileSize >----------------------------------------------------------- }

function ExtractFileSize(FileName : string) : integer;
var
  F : file of Byte;

begin
  Result := 0;
  if FileExists(FileName) = False then Exit;
  AssignFile(F, FileName);
  Reset(F);
  Result := FileSize(F);
  CloseFile(F);
end;

{-----------------------------------< SaveWarningState >----------------------------------------------------------- }

procedure SaveWarningState(WarningType : string);
begin
  Ini.WriteBool('Config', WarningType, Warning_Form.cbDontAskAgain.Checked);
end;

{-----------------------------------< ReadWarningState >----------------------------------------------------------- }

function ReadWarningState(WarningType : string) : boolean;
begin
  Result := Ini.ReadBool('Config', WarningType, False);
  //Original : WarningBIOS
end;

{-----------------------------------< IsFileInUse >----------------------------------------------------------- }

//Permet de savoir si le fichier n'est pas utilisé.
function IsFileInUse(FileName : string) : boolean;
var
  F : File;

begin
  Result := False;
  AssignFile(F, FileName);                               
  {$I-} Reset(F, 1);{$I+}
  CloseFile(F);
  
  if IOResult = 0 then Exit;
  Result := False;
end;

{-----------------------------------< ShowWarningWin >----------------------------------------------------------- }

function ShowWarningWin(MessageCaption : string) : integer;
begin
  Warning_Form.Text.Caption := MessageCaption;
  Result := Warning_Form.ShowModal;
end;

{-----------------------------------< SaveRichEditTo >----------------------------------------------------------- }

procedure SaveRichEditTo(JvRichEdit : TJvRichEdit ; SaveDialog : TSaveDialog);
var
  StringList : TStringList;
  
begin
  if SaveDialog.Execute = True then
  begin

    //Sauvegarder vers RTF.
    if SaveDialog.FilterIndex = 1 then
      JvRichEdit.Lines.SaveToFile(SaveDialog.FileName)

    else begin

      //Sauvegarder vers txt.
      StringList := TStringList.Create;
      try
        StringList.SetText(JvRichEdit.Lines.GetText);
        StringList.SaveToFile(SaveDialog.FileName);
      finally
        StringList.Free;
      end;

    end;
  end;
end;

{-----------------------------------< ReadShowSplash >----------------------------------------------------------- }

procedure ReadOptions;
begin
  Options_Form.cbHideSplashForm.Checked := Ini.ReadBool('Options', 'HideSplash', False);
  Options_Form.cbAllowLongFileNames.Checked := Ini.ReadBool('Options', 'AllowLongFileNames', False);
  Options_Form.cbDisableAutoExpandTree.Checked := Ini.ReadBool('Options', 'DisableAutoExpandTree', False);
  Options_Form.cbWarnIfAddressNotDefault.Checked := Ini.ReadBool('Options', 'WarnIfAddressNotDefault', False);
end;

{-----------------------------------< ReadShowSplash >----------------------------------------------------------- }

procedure WriteOptions;
begin
  Ini.WriteBool('Options', 'HideSplash', Options_Form.cbHideSplashForm.Checked);
  Ini.WriteBool('Options', 'AllowLongFileNames', Options_Form.cbAllowLongFileNames.Checked);
  Ini.WriteBool('Options', 'DisableAutoExpandTree', Options_Form.cbDisableAutoExpandTree.Checked);
  Ini.WriteBool('Options', 'WarnIfAddressNotDefault', Options_Form.cbWarnIfAddressNotDefault.Checked);
end;

{-----------------------------------< droiteDroite >----------------------------------------------------------- }

function DroiteDroite(substr: string; s: string): string;
begin
  Repeat
    S:=droite(substr,s);
  until pos(substr,s)=0;
  result:=S;
end;

{-----------------------------------< SaveCygwinConfig >----------------------------------------------------------- }

procedure SaveCygwinConfig;
begin
  Ini.WriteBool('Cygwin', 'Internal', Cygwin_Form.rbInternal.Checked);
  Ini.WriteBool('Cygwin', 'External', Cygwin_Form.rbExternal.Checked);
end;

{-----------------------------------< ReadCygwinConfig >----------------------------------------------------------- }

procedure LoadCygwinConfig;
var
  MustCheck : boolean;

begin
  //Cygwin_Form.rbInternal.Checked := Ini.ReadBool('Config', 'CygwinInternal', True);
  //Cygwin_Form.rbExternal.Checked := Ini.ReadBool('Config', 'CygwinExternal', False);
  MustCheck := Ini.ReadBool('Cygwin', 'Internal', True);

  if MustCheck = True then
  begin
    Cygwin_Form.rbExternal.Checked := False;
    Cygwin_Form.rbInternal.Checked := True;
  end else begin
    Cygwin_Form.rbInternal.Checked := False;
    Cygwin_Form.rbExternal.Checked := True;
  end;
end;

{----------------------------------------< FIN >----------------------------------------------------------- }

end.
