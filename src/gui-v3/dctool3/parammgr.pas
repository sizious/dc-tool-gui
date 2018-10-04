unit parammgr;

interface

uses
  Windows, SysUtils, IniFiles, DCTool, Forms;

const
  ATOM_BUFFER : integer = 256;
  //en minuscule car en bas y'a un LowerCase
  ELF_EXT     : string = '.elf';  //sh-elf
  BIN_EXT     : string = '.bin';  //raw bin
  DPU_EXT     : string = '.dpu';  //dc-tool preset upload
  DPD_EXT     : string = '.dpd';  //dc-tool preset download
    
type
  TParamType = (ptInvalid, ptPresetUpload, ptPresetDownload, ptBinaryUpload,
                ptBinaryDownload);

  TParamEntry = record
    FileName  : string;
    Operation : TParamType;
    Size      : string;
    Address   : string;
    NoExec    : boolean;
    Prompt    : boolean;
  end;

  TParamSwap = record
    FileName  : string;
    Switchs   : string;
  end;

function GetParamsList : TParamSwap;
function HasParams : boolean;
function IdentifyParamType(var pSwap : TParamSwap ; var peResult : TParamEntry) : boolean;
function GetAtom(NumAtom : Atom) : string;
function RunBinary(Params : TParamEntry) : boolean;
function ExecuteFromCmdLine(pSwap : TParamSwap) : boolean;

implementation

uses utils, u_preset, main, config, upload, download;

//------------------------------------------------------------------------------

function GetParamsList : TParamSwap;
var
  i   : integer;

begin
  //le premier param contient toujours un nom de fichier.
  //il faut faire attention au guillemets.
  Result.FileName := ExpandFileName(ParamStr(1));
  Result.Switchs := '';

  for i := 2 to ParamCount do
    Result.Switchs := Result.Switchs + ParamStr(i) + ' ';

  //Virer l'espace ajouté à la fin (on en a pas besoin du dernier).
  if Length(Result.Switchs) <> 0 then
    Result.Switchs := Copy(Result.Switchs, 0, Length(Result.Switchs) - 1);
end;

//------------------------------------------------------------------------------

function HasParams : boolean;
begin
  Result := ParamStr(1) <> '';
end;

//------------------------------------------------------------------------------

function IdentifyParamType(var pSwap : TParamSwap ; var peResult : TParamEntry) : boolean;
const
  PARAM_LIST : array[0..5] of string = ('', '/noexec', '/d', '/a', '/s', '/prompt');

type
  TParamList = (plUnknow, plNoExec, plDownload, plAddress, plSize, plPrompt);

var
  Max, i, j : integer;
  CurrParam,
  Ext : string;
  ParamType : TParamList;

  GetAddress,
  GetSize,
  IsDownload,
  ExtOK : boolean;

  Handle : HWND;

  Operation : TOperationType;

begin
  Handle := Main_Form.Handle;
  
  Result := False;

  peResult.FileName := pSwap.FileName;
  peResult.Operation := ptInvalid;
  peResult.Size := IntToStr(Main_Form.DCTool.DownloadOptions.GetDefaultDownloadSize);
  peResult.Address := Main_Form.DCTool.UploadOptions.GetDefaultAddress;
  peResult.NoExec := False;
  peResult.Prompt := False;

  GetAddress := False;
  GetSize := False;
  IsDownload := False;
  ExtOK := False;

  //showmessage('switchs : ' + pSwap.Switchs + ' ' + inttostr(length(pSwap.Switchs)));

  //On va commencer la recherche
  Max := NbSousChaine(' ', pSwap.Switchs);
  for i := 0 to Max do
  begin
    CurrParam := GaucheNDroite(' ', pSwap.Switchs, i);
    if Length(CurrParam) = 0 then Continue; //passer au suivant

    if GetAddress then
    begin
      peResult.Address := CurrParam;
      GetAddress := False;
      Continue;
    end;

    if GetSize then
    begin
      peResult.Size := CurrParam;
      GetSize := False;
      Continue;
    end;
                      
    //Identification de la nature du paramètre.
    if CurrParam[1] = '/' then
    begin
      ParamType := plUnknow;
      for j := Low(PARAM_LIST) to High(PARAM_LIST) do
        if LowerCase(CurrParam) = LowerCase(PARAM_LIST[j]) then
        begin
          ParamType := TParamList(j);
          Break;
        end;

      //dans ParamType on a maintenant la nature du paramètre, encore faut-t-il
      //savoir quoi faire... un petit "case...of" s'impose.

      //showmessage(IntToStr(integer(paramtype)) + ' - ' + currparam);

      case ParamType of
        plNoExec      : peResult.NoExec := True;
        plDownload    : IsDownload := True; //pour ensuite déterminer le TParamType
        plAddress     : GetAddress := True;
        plSize        : GetSize := True;
        plPrompt      : peResult.Prompt := True;
        plUnknow      : //un param inconnu a été détecté.
                        begin
                          MsgBox(Handle, 'Invalid switch detected : "' + CurrParam + '".'
                            + WrapStr + 'Please go to the help to get the parameters list.',
                              'Invalid parameter', 48);
                          Exit; //stop.
                        end;
      end;
    end;

  end;

  //Ici on va détecter l'opération à effectuer.
  //Pour les switchs voir le fichier texte dans le dossier rsrc.
  //Pour le fichier (un atom rien que pour lui) :
  //  - Lire l'extension.
  //      * Si c'est ".bin", ".elf", pas de problème, on traite comme ça.
  //        Je vais pas m'amuser à ouvrir l'ELF pour voir l'header, sinon j'ai pas fini.
  //      * Si c'est dpu ou dpd (DC-TOOL PRESET UPLOAD / DC-TOOL PRESET DOWNLOAD)
  //        On va ouvrir le fichier avec un TIniFile pour voir chopper l'opération.
  //        A vrai dire, on s'en fout de l'extension, si le mec a un fichier dpu avec
  //        Download dedant on va faire DOWNLOAD.
  //  - Vérifier les paramètres.
  //      * Ca va mieux en le disant. On va prendre des params par défaut.
  Ext := LowerCase(ExtractFileExt(pSwap.FileName));

  //C'est un binaire
  if (Ext = ELF_EXT) or (Ext = BIN_EXT) then
  begin
    ExtOK := True;
    
    Result := True;
    
    if IsDownload then //c'est un download (switch /d trouvé)
      peResult.Operation := ptBinaryDownload
    else peResult.Operation := ptBinaryUpload;

    //Exit;
  end;

  if (Ext = DPD_EXT) or (Ext = DPU_EXT) then
  begin
    ExtOK := True;

    if IsPreset(pSwap.FileName, Operation) then
      begin

        if (Operation = otUpload) or (Operation = otUploadExecute) then
          peResult.Operation := ptPresetUpload
        else peResult.Operation := ptPresetDownload;

        Result := True;
      end
    else peResult.Operation := ptInvalid;

    //Exit;
  end;

  //showmessage(ext + ' result : ' + booltostr(result, true));

  if not ExtOK then
  begin
    MsgBox(Handle, 'Extension not recognized (' + Ext + ').', 'Error', 48);
    Exit;
  end;

  //test du fichier
  if not FileExists(peResult.FileName) then
  begin
    MsgBox(Handle, 'Sorry, the file "' + peResult.FileName + '" wasn''t found.', 'Error', 48);
    Result := False;
    Exit;
  end;
  
  //d'autres test eventuels... (taille download, config adresse)
end;

//------------------------------------------------------------------------------

function GetAtom(NumAtom : Atom) : string;
var
  ParamLine : PChar;

begin
  GetMem(ParamLine, ATOM_BUFFER);
  ParamLine[0] := #0; //prévient un bug de Windows parce que quand les chaines
                      //sont vide, il n'y a pas de #0, ce qui fait qu'il lit
                      //n'IMPORTE NAWAK!!!! (ce gros con)

  GlobalGetAtomName(NumAtom, ParamLine, ATOM_BUFFER);
  GlobalDeleteAtom(NumAtom);
  Result := StrPas(ParamLine);
  FreeMem(ParamLine);
end;

//==============================================================================

procedure AddStateLog(Text : string);
begin
  Main_Form.reLog.LinesType.State.AddNewEventLine(Text);
end;

//==============================================================================

function RunBinary(Params : TParamEntry) : boolean;
var
  DCTool : TDCTool;

begin
  Result := False;
  DCTool := Main_Form.DCTool;
  if not FileExists(Params.FileName) then Exit;

  DCTool.FileName := Params.FileName;
  DCTool.DownloadOptions.FileSize := StrToInt(Params.Size);

  //Dossier de travail de Windows
  SetCurrentDir(GetDefaultWorkDir);

  DCTool.UploadOptions.ExecuteAfterUpload := not Params.NoExec;

  DCTool.IsoRedirection.Enabled := False;
  DCTool.ChRoot.Enabled := False;

  DCTool.UploadOptions.ExecuteAddress := Params.Address;
  DCTool.DownloadOptions.Address := Params.Address;

  //Execution
  case Params.Operation of
    ptBinaryUpload    : //begin
                          //if DCTool.UploadOptions.ExecuteAfterUpload then
                            //Main_Form.AddNewSynEditLogForUploadExecute;
                          Result := DCTool.Upload;
                        //end;
    ptBinaryDownload  : Result := DCTool.Download;
    else Exit;
  end;

end;

//------------------------------------------------------------------------------

function ExecuteFromCmdLine(pSwap : TParamSwap) : boolean;
var
  DCTool  : TDCTool;
  Handle  : HWND;
  pParsed : TParamEntry;
  Res     : TApplyPresetResult;
  Preset  : TPreset;
  
begin
  Result := False;
  DCTool := Main_Form.DCTool;
  Handle := Application.Handle;

  //Traitement des paramètres.
  if DCTool.IsActive then
  begin
    MsgBox(Handle, 'A process''s currently running.' + WrapStr
      + 'Please stop it before doing another operation.', 'Hey guy, fatal error',
        MB_SYSTEMMODAL + 16);
    Exit;
  end;

  //Y'a déjà un fichier lancé
  if (Upload_Form.Showing) or (Download_Form.Showing) then
  begin
    MsgBox(Handle, 'Please go to the application window because you have already '
      + 'launched an operation.', 'Please be more patient...',
        MB_SYSTEMMODAL + MB_ICONERROR);
    Exit;
  end;

  //OK c'est bon on lance le scan en analysant la ligne de commande
  if not IdentifyParamType(pSwap, pParsed) then Exit;
  Result := True;                                                                          

  //Permet d'éviter que les contrôles de la fiche ne s'efface en s'ouvrant.
  Upload_Form.CmdLineFileLoad := True;
  Download_Form.CmdLineFileLoad := True;

  SetWindowFocus(Main_Form.Handle);

  //On va commencer le lancement :
    
  if pParsed.Prompt then
  begin
    //OUVERTURE DE LA BOITE DE DIALOGUE...

    case pParsed.Operation of
      ptPresetUpload    : begin
                            AddStateLog('Loading upload preset "' + pSwap.FileName + '"...');
                            Upload_Form.cbxPresets.Text := pParsed.FileName;
                            Upload_Form.eAddr.Text := pParsed.Address;
                            Upload_Form.cbExecute.Checked := not pParsed.NoExec;

                            Res := Upload_Form.ApplyPreset(pSwap.FileName, Preset);
                            case Res of
                              aprOK           : begin
                                                  AddStateLog('Preset loaded successfully.');
                                                  Main_Form.miUpload.Click;
                                                end;
                              aprFileNotFound : AddStateLog('ERROR : Preset file not found. File : "'
                                                + Preset.TargetFile + '".');
                              aprInvalidPreset: AddStateLog('ERROR : This preset isn''t for upload operation.'
                                                + 'Aborted.');
                              aprIsNotPreset  : AddStateLog('ERROR : Preset load failed !');
                            end;
                            
                          end;

      ptPresetDownload  : begin
                            AddStateLog('Loading download preset "' + pSwap.FileName + '"...');
                            Download_Form.cbxPresets.Text := pParsed.FileName;
                            Download_Form.bPresetOpen.Click;
                            Main_Form.miDownload.Click;
                          end;

      ptBinaryUpload    : begin
                            AddStateLog('Loading single binary [upload] "' + pSwap.FileName + '"...');
                            Upload_Form.cbxTargetFile.Text := pParsed.FileName;
                            Upload_Form.eAddr.Text := pParsed.Address;
                            Upload_Form.cbExecute.Checked := not pParsed.NoExec;
                            Main_Form.miUpload.Click;
                          end;

     ptBinaryDownload  : begin
                            AddStateLog('Loading single preset [download] "' + pSwap.FileName + '"...');
                            Download_Form.cbxTargetFile.Text := pParsed.FileName;
                            Download_Form.eAddr.Text := pParsed.Address;
                            Download_Form.eSize.Text := pParsed.Size;
                            Main_Form.miDownload.Click;
                          end;
    end;

  end else begin
    //Pas de boite de dialogue à ouvrir
    
    if pParsed.Operation = ptInvalid then Exit;
      
    if (pParsed.Operation = ptPresetUpload)
      or (pParsed.Operation = ptPresetDownload) then
          RunPreset(pParsed.FileName, pParsed.NoExec)
      else RunBinary(pParsed);

  end;


end;

end.
