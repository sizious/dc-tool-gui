unit history;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, u_history, JvBaseDlg,
  JvBrowseFolder, Menus, ImgList, JvComponent;

type
  THistories_Form = class(TForm)
    pcHistory: TPageControl;
    tsTargetFile: TTabSheet;
    tsPresets: TTabSheet;
    tsISO: TTabSheet;
    tsChroot: TTabSheet;
    tsWorkDir: TTabSheet;
    bDelete: TBitBtn;
    bClean: TBitBtn;
    lbTarget: TListBox;
    lbPresets: TListBox;
    lbISO: TListBox;
    lbChroot: TListBox;
    lbWorkDir: TListBox;
    bDeleteAll: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    bOK: TBitBtn;
    bAddEntry: TBitBtn;
    Bevel3: TBevel;
    bAppend: TBitBtn;
    bSave: TBitBtn;
    bRefresh: TBitBtn;
    Bevel4: TBevel;
    Bevel5: TBevel;
    StatusBar: TStatusBar;
    bCancel: TBitBtn;
    odf: TOpenDialog;
    odd: TJvBrowseForFolderDialog;
    pmHistory: TPopupMenu;
    Addentry1: TMenuItem;
    N1: TMenuItem;
    Deleteselected1: TMenuItem;
    Deleteall1: TMenuItem;
    N2: TMenuItem;
    Cleaninvalidentries1: TMenuItem;
    N3: TMenuItem;
    Appendentries1: TMenuItem;
    Saveentries1: TMenuItem;
    N4: TMenuItem;
    Refresh1: TMenuItem;
    ilHistory: TImageList;
    procedure tsTargetFileShow(Sender: TObject);
    procedure tsPresetsShow(Sender: TObject);
    procedure tsISOShow(Sender: TObject);
    procedure tsChrootShow(Sender: TObject);
    procedure tsWorkDirShow(Sender: TObject);
    procedure bCleanClick(Sender: TObject);
    procedure bRefreshClick(Sender: TObject);
    procedure lbTargetClick(Sender: TObject);
    procedure lbTargetKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bDeleteClick(Sender: TObject);
    procedure bDeleteAllClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bAddEntryClick(Sender: TObject);
    procedure bAppendClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbTargetContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { Déclarations privées }

    //Avoir la selection.
    SelectedHistory   : THistoryManager;
    SelectedListBox   : TListBox;

    //Modification des historiques ?
    HMTargetFileMod   : boolean;
    HMPresetsMod      : boolean;
    HMIsoRedirectMod  : boolean;
    HMChrootMod       : boolean;
    HMWorkingDirMod   : boolean;

    //Procedures.
    procedure ShowSelectedIndex(Sender : TObject);
    procedure ModifyHistoryState(State : boolean);
    procedure CheckHistoriesSaves(Prompt : boolean);
    procedure PromptForSaving(History : THistoryManager ;
      HistoryState : boolean ; Target: string);
    procedure AddNewFileHistoryEntry(TypeDlg, DefaultExtDlg,
      FilterDlg: string);
    procedure AddNewDirHistoryEntry(TypeDlg : string);
  public
    { Déclarations publiques }
  end;

var
  Histories_Form: THistories_Form;

implementation

uses histmgr, utils;

{HMTargetFile  : THistoryManager;
  HMPresets     : THistoryManager;
  HMIsoRedirect : THistoryManager;
  HMChroot      : THistoryManager;
  HMWorkingDir  : THistoryManager;}
  
{$R *.dfm}

procedure THistories_Form.tsTargetFileShow(Sender: TObject);
begin
  SelectedHistory := HMTargetFile;
  SelectedListBox := lbTarget;
  bRefresh.Click;
end;

procedure THistories_Form.tsPresetsShow(Sender: TObject);
begin
  SelectedHistory := HMPresets;
  SelectedListBox := lbPresets;
  bRefresh.Click;
end;

procedure THistories_Form.tsISOShow(Sender: TObject);
begin
  SelectedHistory := HMIsoRedirect;
  SelectedListBox := lbISO;
  bRefresh.Click;
end;

procedure THistories_Form.tsChrootShow(Sender: TObject);
begin
  SelectedHistory := HMChroot;
  SelectedListBox := lbChroot;
  bRefresh.Click;
end;

procedure THistories_Form.tsWorkDirShow(Sender: TObject);
begin
  SelectedHistory := HMWorkingDir;
  SelectedListBox := lbWorkDir;
  bRefresh.Click;
end;

procedure THistories_Form.bCleanClick(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, 'Clean invalid entries ?', 'Confirmation', 32 + MB_YESNO);
  if CanDo = IDNO then Exit;
  
  if SelectedHistory <> nil then
  begin
    SelectedHistory.CleanInvalidEntries;
    ModifyHistoryState(True);
    bRefresh.Click;
  end;
end;

procedure THistories_Form.bRefreshClick(Sender: TObject);
var
  SL : TStringList;

begin
  SL := SelectedHistory.GetCompleteList;
  try
    SelectedListBox.Items := SL;
  finally
    SL.Free;
  end;
end;

procedure THistories_Form.ShowSelectedIndex(Sender : TObject);
var
  LB : TListBox;

begin
  LB := (Sender as TListBox);
  if LB.ItemIndex = -1 then Exit;
  StatusBar.SimpleText := LB.Items[LB.ItemIndex];
end;

procedure THistories_Form.lbTargetClick(Sender: TObject);
begin
  ShowSelectedIndex(Sender);
end;

procedure THistories_Form.lbTargetKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ShowSelectedIndex(Sender);
end;

procedure THistories_Form.bDeleteClick(Sender: TObject);
var
  CanDo,
  Index : integer;

begin
  Index := SelectedListBox.ItemIndex;

  if Index = -1 then
  begin
    MsgBox(Handle, 'Select a item in the list.', 'Warning', 48);
    Exit;
  end;

  CanDo := MsgBox(Handle, 'Delete the selected entry ?', 'Warning', 48
    + MB_YESNO + MB_DEFBUTTON2);
  if CanDo = IDNO then Exit;

  SelectedHistory.DeleteEntry(SelectedListBox.Items[Index]);
  ModifyHistoryState(True);
  bRefresh.Click;
end;

procedure THistories_Form.bDeleteAllClick(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, 'Delete all entries in this file ?', 'Warning', 48
    + MB_YESNO + MB_DEFBUTTON2);
  if CanDo = IDNO then Exit;

  SelectedHistory.Clear;
  ModifyHistoryState(True);
  bRefresh.Click;
end;

procedure THistories_Form.bSaveClick(Sender: TObject);
var
  CanDo : integer;

begin
  CanDo := MsgBox(Handle, 'Update the file ?', 'Question', 32
    + MB_YESNO);
  if CanDo = IDNO then Exit;

  SelectedHistory.SaveHistory;
  ModifyHistoryState(False);
  bRefresh.Click;
end;

procedure THistories_Form.FormCreate(Sender: TObject);
begin
  HMTargetFileMod   := False;
  HMPresetsMod      := False;
  HMIsoRedirectMod  := False;
  HMChrootMod       := False;
  HMWorkingDirMod   := False;
end;

procedure THistories_Form.ModifyHistoryState(State : boolean);
begin
  if SelectedHistory = HMTargetFile then HMTargetFileMod := State;
  if SelectedHistory = HMPresets then HMPresetsMod := State;
  if SelectedHistory = HMIsoRedirect then HMIsoRedirectMod := State;
  if SelectedHistory = HMChroot then HMChrootMod := State;
  if SelectedHistory = HMWorkingDir then HMWorkingDirMod := State;
end;

procedure THistories_Form.bAddEntryClick(Sender: TObject);
begin
  //C'est un BIN/ELF
  if (SelectedHistory = HMTargetFile) then
  begin
    AddNewFileHistoryEntry('binary',
      '', 'Executables (*.elf;*.bin)|*.elf;*.bin|All files (*.*)|*.*');
    Exit;
  end;

  //C'est un preset.
  if (SelectedHistory = HMPresets) then
  begin
    AddNewFileHistoryEntry('preset',
      'dgp', 'DC-TOOL GUI Presets (*.dgp)|*.dgp|All files (*.*)|*.*');
    Exit;
  end;

  //C'est un ISO
  if (SelectedHistory = HMIsoRedirect) then
  begin
    AddNewFileHistoryEntry('ISO9660',
      'iso', 'ISO9660 (*.iso)|*.iso|All files (*.*)|*.*');
    Exit;
  end;

  //C'est un Chroot
  if (SelectedHistory = HMChroot) then
  begin
    AddNewDirHistoryEntry('PC Root Path');
    Exit;
  end;

  //C'est un WorkDir
  if (SelectedHistory = HMWorkingDir) then
    AddNewDirHistoryEntry('Working Path');
end;

procedure THistories_Form.bAppendClick(Sender: TObject);
var
  nb : integer;

begin
  with odf do //opendialog
  begin
    Filter := 'History files (*.dhf)|*.dhf|All files (*.*)|*.*';
    DefaultExt := 'dhf';
    Title := 'Select history file to append to "' + SelectedHistory.Name + '" file :';

    if Execute then
    begin
      nb := SelectedHistory.AppendHistory(odf.FileName);

      if nb <> 0 then
      begin
        ModifyHistoryState(True);
        MsgBox(Handle, IntToStr(nb) + ' items appened.', 'Information', 64);
        bRefresh.Click;
        Exit;
      end else MsgBox(Handle, 'Nothing was added.', 'Information', 64);
      
    end;

  end;
end;

procedure THistories_Form.bCancelClick(Sender: TObject);
begin
  //CheckHistoriesSaves(True);
  ModalResult := mrCancel;
end;

//---CheckHistoriesSaves---
//Cette fonction moche permet de sauvegarder tous les historiques non sauvés.
//Si Prompt est à false, on va tout sauvegarder si ca été modifié.
//Les valeurs booleans du style "HMTargetFileMod" permettent de le savoir.
procedure THistories_Form.CheckHistoriesSaves(Prompt : boolean);
begin
  if not Prompt then
  begin
    //Sauver tout ce qui a été modifié si besoin (afin de limiter les accès au
    //disque).
    if HMTargetFileMod then HMTargetFile.SaveHistory;
    if HMPresetsMod  then HMPresets.SaveHistory;
    if HMIsoRedirectMod then HMIsoRedirect.SaveHistory;
    if HMChrootMod then HMChroot.SaveHistory;
    if HMWorkingDirMod then HMWorkingDir.SaveHistory;
  end else begin
    //Nous allons demander pour chaque historique.
    PromptForSaving(HMTargetFile, HMTargetFileMod, 'Target File');
    PromptForSaving(HMPresets, HMPresetsMod, 'Presets');
    PromptForSaving(HMIsoRedirect, HMIsoRedirectMod, 'ISO Redirection');
    PromptForSaving(HMChroot, HMChrootMod, 'PC Root Path');
    PromptForSaving(HMWorkingDir, HMWorkingDirMod, 'Working Directory');
  end;
end;

procedure THistories_Form.PromptForSaving(History : THistoryManager ;
  HistoryState : boolean ; Target: string);
var
  CanDo : integer;

begin
  if HistoryState then
  begin
    CanDo := MsgBox(Handle, 'Do you want to save ''' + Target
      + ''' history ?', 'Warning', 32 + MB_YESNO);

    if CanDo = IDYES then
      History.SaveHistory
    else History.LoadHistory; //sinon nous allons le charger du disque.

  end;
end;

procedure THistories_Form.bOKClick(Sender: TObject);
begin
  CheckHistoriesSaves(False);
  ModalResult := mrOK;
end;

procedure THistories_Form.FormShow(Sender: TObject);
begin
  bRefresh.Click;
end;

procedure THistories_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult = mrCancel then
    CheckHistoriesSaves(True);
end;

procedure THistories_Form.AddNewFileHistoryEntry(TypeDlg, DefaultExtDlg,
  FilterDlg: string);
begin
  with odf do //opendialog
  begin
    Filter := FilterDlg;
    DefaultExt := DefaultExtDlg;
    Title := 'Select the new ' + TypeDlg + ' to add :';

    if Filter <> '' then FilterIndex := 0; //le remettre sur le premier

    if Execute then
    begin
      SelectedHistory.AddEntry(FileName);
      ModifyHistoryState(True);
      bRefresh.Click;
    end;

  end;

end;

procedure THistories_Form.AddNewDirHistoryEntry(TypeDlg: string);
begin
  with odd do //openfolder
  begin
    Title := 'Select the new ' + TypeDlg + ' to add :';

    if Execute then
    begin
      SelectedHistory.AddEntry(Directory);
      ModifyHistoryState(True);
      bRefresh.Click;
    end;

  end;
end;

procedure THistories_Form.lbTargetContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  SimulateLeftClick;
end;

end.
