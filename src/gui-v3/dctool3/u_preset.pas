unit u_preset;

interface

uses
  Windows, SysUtils, DCTool, IniFiles, Forms;

type
  TApplyPresetResult = (aprOK, aprFileNotFound, aprInvalidPreset, aprIsNotPreset);
  
  TPreset = record
    Operation   : TOperationType;
    TargetFile  : string;   //fichier cible.
    IsoUse      : boolean;  //Upload : utiliser le iso ?
    IsoFile     : string;   //Upload : fichier iso à utiliser
    ChrootUse   : boolean;  //Upload : utiliser le chroot?
    ChrootDir   : string;   //Upload : dossier pour le chroot
    WorkDirUse  : boolean;  //dossier windows à changer?
    WorkDir     : string;   //dossier windows à proprement parler
    //UploadExec  : boolean;  //Upload : executer  [-> DANS TOperationType !!!]
    //* Options
    UseAddress  : boolean;  //Changer l'adresse
    Address     : string;   //Addresse proprement dite.
    OpFileInUse : boolean;  //Upload : Protection "Fichier en utilisation".
    OpDisBinChk : boolean;  //Upload : Désactiver le bin check
    OpDlSize    : string;   //Download : Changer la taille de download.
  end;

function LoadPreset(const FileName : string ; var TargetPreset : TPreset) : boolean;
function SavePreset(const FileName : string ; const PresetToWrite : TPreset) : boolean;
function IsPreset(const FileName : string ; var Operation : TOperationType) : boolean;
function RunPreset(const FileName : string ; NoUpExec : boolean) : boolean;

implementation

uses
  Main, config, u_dctool_binchk, upload, utils;

//------------------------------------------------------------------------------

//---LoadPreset---
function LoadPreset(const FileName : string ; var TargetPreset : TPreset) : boolean;
var
  Ini : TIniFile;

begin
  Result := False;
  if not FileExists(FileName) then Exit;

  Ini := TIniFile.Create(FileName);
  try

    //Preset invalide.
    if Ini.ReadString('Preset', 'Soft', '') <> 'DC-TOOL GUI' then Exit;

    //C'est bon.
    TargetPreset.Operation := TOperationType(Ini.ReadInteger('Preset', 'OperationType', 0));
    TargetPreset.TargetFile := Ini.ReadString('Preset', 'TargetFile', '');
    TargetPreset.IsoUse := Ini.ReadBool('Preset', 'IsoUse', False);
    TargetPreset.IsoFile := Ini.ReadString('Preset', 'IsoFile', '');
    TargetPreset.ChrootUse := Ini.ReadBool('Preset', 'ChrootUse', False);
    TargetPreset.ChrootDir := Ini.ReadString('Preset', 'ChrootDir', '');
    TargetPreset.WorkDirUse := Ini.ReadBool('Preset', 'WorkDirUse', False);
    //TargetPreset.UploadExec := Ini.ReadBool('Preset', 'UploadExec', True);
    TargetPreset.UseAddress := Ini.ReadBool('Preset', 'UseAddress', False);

    if (TargetPreset.Operation = otUpload)
      or (TargetPreset.Operation = otUploadExecute) then
              TargetPreset.Address := Ini.ReadString('Preset', 'Address',
                  Main_Form.DCTool.UploadOptions.GetDefaultAddress) //address upload & uploadexecute

    else if (TargetPreset.Operation = otDownload) then
      TargetPreset.Address := Main_Form.DCTool.DownloadOptions.GetDefaultAddress; //address download

    TargetPreset.OpFileInUse := Ini.ReadBool('Preset', 'OpFileInUse', True);
    TargetPreset.OpDisBinChk := Ini.ReadBool('Preset', 'OpDisBinChk', False);
    TargetPreset.OpDlSize := Ini.ReadString('Preset', 'OpDlSize', '0');
    Result := True;
  finally
    Ini.Free;
  end;
end;

//------------------------------------------------------------------------------

//---SavePreset---
function SavePreset(const FileName : string ; const PresetToWrite : TPreset) : boolean;
var
  Ini : TIniFile;
  
begin
  Result := True;

  //Si le fichier existe et que ce n'est pas un preset et bien on dégage. [MERDE...]
  //if FileExists(FileName) then
  //  if Ini.ReadString('Preset', 'Soft', '') <> 'DC-TOOL GUI' then Exit;

  Ini := TIniFile.Create(FileName);
  try
    Ini.WriteString('Preset', 'Soft', 'DC-TOOL GUI');
    Ini.WriteInteger('Preset', 'OperationType', Integer(PresetToWrite.Operation));

    Ini.WriteString('Preset', 'TargetFile', PresetToWrite.TargetFile);

    Ini.WriteBool('Preset', 'WorkDirUse', PresetToWrite.WorkDirUse);
    Ini.WriteString('Preset', 'WorkDir', PresetToWrite.WorkDir);

    Ini.WriteString('Preset', 'Address', PresetToWrite.Address);


    if PresetToWrite.Operation = otDownload then
    begin
      //Uniquement Download

      Ini.WriteString('Preset', 'OpDlSize', PresetToWrite.OpDlSize);

    end else begin
      //Upload & UploadExecute (& Reset... même si ça sert à rien)

      Ini.WriteBool('Preset', 'IsoUse', PresetToWrite.IsoUse);
      Ini.WriteString('Preset', 'IsoFile', PresetToWrite.IsoFile);

      Ini.WriteBool('Preset', 'ChrootUse', PresetToWrite.ChrootUse);
      Ini.WriteString('Preset', 'ChrootDir', PresetToWrite.ChrootDir);

      //Ini.WriteBool('Preset', 'UploadExec', PresetToWrite.UploadExec);
      Ini.WriteBool('Preset', 'UseAddress', PresetToWrite.UseAddress);
      Ini.WriteBool('Preset', 'OpFileInUse', PresetToWrite.OpFileInUse);
      Ini.WriteBool('Preset', 'OpDisBinChk', PresetToWrite.OpDisBinChk);
    end;

    Ini.Free;
  except
    Result := False;
  end;
end;

//------------------------------------------------------------------------------

function IsPreset(const FileName : string ; var Operation : TOperationType) : boolean;
var
  Ini : TIniFile;
  OpType : integer;

begin
  Result := False;
  if not FileExists(FileName) then Exit;

  Ini := TIniFile.Create(FileName);
  try
    OpType := Ini.ReadInteger('Preset', 'OperationType', -1);
    Result := not (OpType = -1);

    if Result then Operation := TOperationType(OpType); 
  finally
    Ini.Free;
  end;
end;

//------------------------------------------------------------------------------

function RunPreset(const FileName : string ; NoUpExec : boolean) : boolean;
var
  DCTool  : TDCTool;
  Prt     : TPreset;
  Run     : boolean;

begin
  Result := False;
  DCTool := Main_Form.DCTool;
  if not LoadPreset(FileName, Prt) then Exit;

  if not FileExists(Prt.TargetFile) then
  begin
    MsgBox(Application.Handle, 'Target file not found.' + WrapStr
      + 'File : "' + Prt.TargetFile + '".', 'Error', 48);
    Exit;
  end;

  DCTool.FileName := Prt.TargetFile;
  DCTool.IsoRedirection.Enabled := Prt.IsoUse;
  DCTool.IsoRedirection.IsoFile := Prt.IsoFile;
  DCTool.ChRoot.Enabled := Prt.ChrootUse;
  DCTool.ChRoot.Path := Prt.ChrootDir;

  if NoUpExec then
     DCTool.UploadOptions.ExecuteAfterUpload := False
  else begin
    Run := (Prt.Operation = otUploadExecute);
    DCTool.UploadOptions.ExecuteAfterUpload := Run;
  end;

  //Mettre l'addresse. On sait pas quelle est l'opération pour l'instant, alors
  //on va mettre dans les deux !
  if Prt.UseAddress then
  begin
    DCTool.UploadOptions.ExecuteAddress := Prt.Address;
    DCTool.DownloadOptions.Address := Prt.Address;
  end else begin
    DCTool.UploadOptions.ExecuteAddress := DCTool.UploadOptions.GetDefaultAddress;
    DCTool.DownloadOptions.Address := DCTool.DownloadOptions.GetDefaultAddress;
  end;

  DCTool.UploadOptions.FileInUseProtection := Prt.OpFileInUse;

  DCTool.DownloadOptions.FileSize := StrToInt(Prt.OpDlSize);

  //Dossier de travail de Windows
  if Prt.WorkDirUse then
  begin
    SetCurrentDir(Prt.WorkDir);
  end else SetCurrentDir(GetDefaultWorkDir);

  case Prt.Operation of
    otUpload        : Result := DCTool.Upload;

    otUploadExecute : begin
                        //On va verifier si le BIN est unscrambled.
                        if not Prt.OpDisBinChk then
                          if LowerCase(ExtractFileExt(DCTool.FileName)) = '.bin' then
                            if not DoBinCheckSequence(Upload_Form.GetBinCheckCfg,
                              Main_Form.Handle, DCTool.FileName) then Exit;

                        //Main_Form.AddNewSynEditLogForUploadExecute;
                        Result := DCTool.Upload;
                      end;

    otDownload      : Result := DCTool.Download;
  end;

  //RECHARGER LA VRAI CONFIG !!!!
  SaveFile.LoadConfig;
end;

end.
