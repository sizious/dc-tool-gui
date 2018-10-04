{
    :: H I S T O R Y  M A N A G E R ::
               - USAGE -
            For DC-TOOL GUI 3

    Unité utilisant la classe définie dans u_history.pas.

    Author  : SiZiOUS
    Version : 3.0
    Date    : 09-06-05 /  16h52

    Notes   : Je précise car là, y'a 3 fichiers history :p
              Donc pour résumer :
              - u_history.pas : definition de la classe THistoryManager.
              - histmgr       : utilisation de la classe THistoryManager.
              - history       : C'est la Form THistory_Form...
}

unit histmgr;

interface

uses
  Windows, SysUtils, Classes, StdCtrls, U_History;

const
  TARGET_FILE : string = 'target.dhf';
  PRESET_FILE : string = 'presets.dhf';
  ISO_FILE    : string = 'isos.dhf';
  CHROOT_FILE : string = 'chroot.dhf';
  WORKD_FILE  : string = 'workdir.dhf';

var
  HMTargetFile  : THistoryManager;
  HMPresets     : THistoryManager;
  HMIsoRedirect : THistoryManager;
  HMChroot      : THistoryManager;
  HMWorkingDir  : THistoryManager;

procedure CreateHistories;
procedure DestroyHistories;
procedure LoadHistoryToCombo(Handle : HWND ; History: THistoryManager ;
                              TargetCbBox : TComboBox);
procedure SaveHistoryToCombo(Handle : HWND ; History: THistoryManager ;
                              TargetCbBox: TComboBox);

implementation

uses utils, Config;

//Charger tous les historiques, au démarrage de l'application.
procedure CreateHistories;
begin
  HMTargetFile := THistoryManager.Create(GetConfigDir + TARGET_FILE, htFiles);
  HMPresets := THistoryManager.Create(GetConfigDir + PRESET_FILE, htFiles);
  HMIsoRedirect := THistoryManager.Create(GetConfigDir + ISO_FILE, htFiles);
  HMChroot := THistoryManager.Create(GetConfigDir + CHROOT_FILE, htDirs);
  HMWorkingDir := THistoryManager.Create(GetConfigDir + WORKD_FILE, htDirs);
end;

//Sauvegarder tous les historiques... à faire lorsqu'on quitte l'application.
procedure DestroyHistories;
begin
  if Assigned(HMTargetFile) then HMTargetFile.Free;
  if Assigned(HMPresets) then HMPresets.Free;
  if Assigned(HMIsoRedirect) then HMIsoRedirect.Free;
  if Assigned(HMChroot) then HMChroot.Free;
  if Assigned(HMWorkingDir) then HMWorkingDir.Free;
end;

//---LoadHistory---
//Charger l'historique ciblé, et le mettre dans la combobox voulue.
procedure LoadHistoryToCombo(Handle : HWND ; History: THistoryManager ; TargetCbBox : TComboBox);
var
  TempList : TStringList;

begin

  TempList := History.GetCompleteList;
  try
    TargetCbBox.Items := TempList;
    TempList.Free;
  except
    MsgBox(Handle, 'Error when loading ''' + History.Name + ''' history.', 'Error', 48);
  end;

end;

//---SaveHistory---
//Sauver l'élément entré dans la combobox puis sauvegarder sur disque.
procedure SaveHistoryToCombo(Handle : HWND ; History: THistoryManager; TargetCbBox: TComboBox);
begin

  try
    //a sauver que si la combo est enabled : fichier utilisé.
    if TargetCbBox.Enabled then
      History.AddEntry(TargetCbBox.Text);
      
    History.SaveHistory;
  except
    MsgBox(Handle, 'Error when loading ''' + History.Name + ''' history.', 'Error', 48);
  end;
  
end;

end.
