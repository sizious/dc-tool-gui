{
  Unit Utils : Lang
  For DC-TOOL GUI v1.2
  by [big_fury]SiZiOUS
  
}

unit utils;

interface

uses
  Windows, StdCtrls, SysUtils, Forms, FileCtrl, idGlobal, Dialogs, Classes, ShellApi,
  lang, IniFiles, Graphics, ExtCtrls;

const
  Attributs : integer = FaDirectory + faHidden + faSysFile;
  WrapStr : string = #13 + #10;

var
  LngFile : TIniFile;

  InformationCaption, ErrorCaption,
  PleaseSpecifyTheFile, ErrorFileNotFound,
  InputPathEmpty, SizeIsIncorrect,
  BaudrateIsIncorrect, FileExistsDoYouWantToReplaceIt,
  SizeCantBeZero, WarningBIOSMessage, WarningGDRipMessage, ShowLogBtn,
  HideLogBtn, AreYouSureToStopDumpingYourBIOS, QuestionCaption,
  PleaseInsertTheDCLOADDiscAndRebootConsole, BiosInProgress, BiosFailed,
  BiosSuccess, YourLinkIsCorrectlySetAndActive,
  AreYouSureToCancelTheLinkTest, AreYouSureToResetDCTOOL,
  TextNotFoundOrAllOccurencesFound, Removed, PleaseSelectANode,
  WarningCaption, AreYouSureToDeleteOutputs,
  ThereAreCurrentlyAProcessDoYouWantToAbortIt,
  IPAddressMustBeValidFormat0000To255255255255,
  CloseWithoutSavingChanges, AddANewItem, EnterTheStringHere,
  EditCurrentItem, PleaseEnterTheCorrectedItemHere, CantBeEmpty,
  PleaseSelectAItem, AreYouSureToDeleteThisKeyword, AreYouSureToDeleteAllFilters,
  AreYouSureToRemplaceAllFilters,
  NothingWasAddedToTheListBecauseThereIsNothingToAdd,
  ThereIs, ItemsAdded, AreYouSureToClearTheList,
  InvalidPathPleaseVerifyTheDirectory,
  AreYouSureToCloseTheDialogWizard, ThisIsAJoke, DoYouWantToDeleteAll,
  PleaseSelectAnItemBefore, DoYouWantToCleanInvalidFilenames,
  AbortOperation, TheBiosFilenameExistsInThisDirectory,
  TheFlashFilenameExistsInThisDirectory, OverwriteIt,
  DumpingDreamcastBIOSoperationCompleted,
  WarningAddressIsNotTheDefaultAddress, DoYouWantToContinueAnyway,
  ErrorWhenUnscramblingTheBINAborted, TheBinIsScrambledUnscrambleIt,
  UploadAnyWay, UploadThisScrambledFileNotRecommended,
  WarningDCLOADCanCrashAfterExecutingThisFile, TheBinWasDetected,
  Scrambled, Unscrambled, YouMustUnscrambleIt, DoYouAgree,
  TheFileIsCorrect,
  AreYouSureToUnscrambleTheFileAndRenameThisFileasScrambledBin,
  WarningThisIsNotRecommendedClickOnTheNoButtonToUploadTheFile,
  PleaseRebootYourDreamcastNowIfYouMustSetTheDateTimeTheFLASHResetIsCompleted,
  WarningResetingYourFLASHMemoryEraseAllDatasYourISPSettingsWithDreamkey,
  DateTimeAndLanguageSelectionYourDreamcastIsSetAsFactoryVMUIsNotDeleted,
  ItIsRedWhileErasingTheFlashAndTurnGreenWhenItsDone,
  WhenTheUploadIsFinishedTheScreensBorderShouldBecomeRedThenGreen,
  ItsVeryQuickItTakesApproxMidSecond, AreYouSureToCancelTheFLASHReset,
  AreYouSureToCancel : string;

procedure ScruteLangFile;
procedure LoadLang(LangID : string);
procedure LoadEnglish;
procedure ConfigureApplicationLanguage;
procedure TranslateCygwinDialog;
procedure TranslateBinCheckDialog;

implementation

uses ab_dct, progress, main, tools, upload, download, setsize, baudrate,
     address, dctool_cfg, warning, bios, linktest, setip, filters, addbox,
     filtered, advanced, wizard, cygwin, binchk, options, history, dl_progress,
     delflash, sendcmd;

{-------------------------------< DEBUT DES PROCEDURES >-------------------------------------------------------------------------------------------------- }

{-------------------------------< PROCEDURE ScruteLangFile >------------------------------------------------------------------------------------------------------------------ }

procedure ScruteLangFile;
var
  FichierTrouve, Dossier, Filtre, LangName : string;
  Resultat, Attributs : integer;
  SearchRec     : TSearchRec;

begin
  //Definition des variables...
  Dossier := ExtractFilePath(Application.ExeName) + 'lang';
  Attributs := faAnyFile;
  Filtre := '*.lng';

  if Dossier[length(Dossier)] = '\' then Dossier := Copy(Dossier,1,length(Dossier)-1);

  Resultat := FindFirst(Dossier + '\' + filtre, Attributs, SearchRec);
  //Size := 0;

  while Resultat = 0 do
  begin
    Application.ProcessMessages; // rend la main à windows pour qu'il traite les autres applications (évite que l'application garde trop longtemps la main)
    if ((SearchRec.Attr and faDirectory) <= 0) then // On a trouvé un Fichier (et non un dossier)
    begin
      FichierTrouve := Dossier + '\' + SearchRec.Name;
      //Size := StrToInt(Main_Form.Size_LabeledEdit.Text) + StrToInt(FichierSize(FichierTrouve, False));
      //Showmessage(FichierTrouve + ' : ' + inttostr(size));
      //Main_Form.Size_LabeledEdit.Text := IntToStr(Size);
      //Main_Form.FileFound_ListBox.Items.Add(Droite('\', Droite(Main_Form.Root_Edit.Text, FichierTrouve)));// j'ajoute le Dossier trouvé dans le Memo2
      //Lang_Form.Lang.Items.Add(Gauche('.', SearchRec.Name));

      //Ouvre le fichier
      LngFile := TIniFile.Create(FichierTrouve);

      //Ajoute le nom du fichier a la liste
      Lang_Form.LangFileName.Items.Add(SearchRec.Name);

      //Regarde le nom de la langue
      LangName := LngFile.ReadString('LANG', 'LangName', LangName);

      //Ajoute le nom de la langue
      Lang_Form.Lang.Items.Add(LangName);

      //Ferme le fichier et detruit la memoire alloué au fichier.
      LngFile.Free;
    end;
    Resultat:=FindNext(SearchRec);
  end;
  FindClose(SearchRec);// libération de la mémoire
end;

{-------------------------------< PROCEDURE GetTradInfos >------------------------------------------------------------------------------------------------------------------ }

function GetTradInfos(LangID : string) : string;
var
  Error, LngDir : string;
  
begin
  Error := '<Error>';
  Result := '';
  
  //Ouvrir le fichier voulu.
  LngDir := ExtractFilePath(Application.ExeName) + 'LANG\';
  LngFile := TIniFile.Create(LngDir + LangID);

  if FileExists(LngDir + LangID) = False then
  begin
    MsgBox(Main_Form.Handle, 'Damn! File "' + LngDir + LangID + '" not found !' + WrapStr + 'So the default language (English of course) will be used.', 'OOPS!', 48);
    LoadEnglish;
    Ini.WriteString('Config', 'LangID', 'English');
    Exit;
  end;

  Result := 'Translation by ' + LngFile.ReadString('Lang', 'Author', Error) + ' | Version : v' + LngFile.ReadString('Lang', 'Version', Error) + '...'; 
end;

{-------------------------------< PROCEDURE LoadLang >------------------------------------------------------------------------------------------------------------------ }

procedure LoadLang(LangID : string);
var
  LngDir, Error, OKBtn, CancelBtn, DefaultBtn, CloseBtn, AbortBtn, ApplyBtn,
  AcceptBtn, NextBtn, PrevBtn, FinishBtn : string;

begin
  Error := '<Error>';

  //Ouvrir le fichier voulu.
  LngDir := ExtractFilePath(Application.ExeName) + 'LANG\';
  LngFile := TIniFile.Create(LngDir + LangID);

  if FileExists(LngDir + LangID) = False then
  begin
    MsgBox(Main_Form.Handle, 'Damn! File "' + LngDir + LangID + '" not found !' + WrapStr + 'So the default language (English of course) will be used.', 'OOPS!', 48);
    LoadEnglish;
    Ini.WriteString('Config', 'LangID', 'English');
    Exit;
  end;

  //C'est parti !

  //Boutons
  OKBtn       := LngFile.ReadString('Buttons', 'OK', Error);
  CancelBtn   := LngFile.ReadString('Buttons', 'Cancel', Error);
  DefaultBtn  := LngFile.ReadString('Buttons', 'Default', Error);
  CloseBtn    := LngFile.ReadString('Buttons', 'Close', Error);
  ShowLogBtn  := LngFile.ReadString('Buttons', 'ShowLog', Error);
  HideLogBtn  := LngFile.ReadString('Buttons', 'HideLog', Error);
  AbortBtn    := LngFile.ReadString('Buttons', 'Abort', Error);
  ApplyBtn    := LngFile.ReadString('Buttons', 'Apply', Error);
  AcceptBtn   := LngFile.ReadString('Buttons', 'Accept', Error);
  NextBtn     := LngFile.ReadString('Buttons', 'Next', Error);
  PrevBtn     := LngFile.ReadString('Buttons', 'Previous', Error);
  FinishBtn   := LngFile.ReadString('Buttons', 'Finish', Error);

  // ---< MAIN FORM >---

  //----MENU--------

  //----Fichier-----
  Main_Form.File1.Caption := LngFile.ReadString('FileMenu', 'File', Error);
  Main_Form.Upload1.Caption := LngFile.ReadString('FileMenu', 'UploadFrom', Error);
  Main_Form.Downloadto1.Caption := LngFile.ReadString('FileMenu', 'DownloadTo', Error);
  Main_Form.DumpDreamcastBIOS1.Caption := LngFile.ReadString('FileMenu', 'DumpDreamcastBIOS', Error);
  Main_Form.DumpDreamcastGD1.Caption := LngFile.ReadString('FileMenu', 'DumpDreamcastGD', Error);
  Main_Form.DumpDreamcastVMU1.Caption := LngFile.ReadString('FileMenu', 'DumpDreamcastVMU', Error);
  Main_Form.LinkTest1.Caption := LngFile.ReadString('FileMenu', 'LinkTest', Error);
  Main_Form.DeleteFLASH1.Caption := LngFile.ReadString('FileMenu', 'DelFlashRom', Error);
  Main_Form.Sendacommand1.Caption := LngFile.ReadString('FileMenu', 'SendACommand', Error);
  Main_Form.Reset1.Caption := LngFile.ReadString('FileMenu', 'ResetDCTOOL', Error);
  Main_Form.Abortoperation1.Caption := LngFile.ReadString('FileMenu', 'AbortCurrentOperation', Error);
  Main_Form.Exit1.Caption := LngFile.ReadString('FileMenu', 'QuitProgram', Error);
  //Hints
  Main_Form.Upload1.Hint := LngFile.ReadString('FileMenuHints', 'UploadAFileToDreamcastYouCanAlsoExecuteThisFile', Error);
  Main_Form.Downloadto1.Hint := LngFile.ReadString('FileMenuHints', 'DownloadAFileFromTheDreamcast', Error);
  Main_Form.DumpDreamcastBIOS1.Hint := LngFile.ReadString('FileMenuHints', 'DumpDreamcastBIOSHint', Error);
  Main_Form.DumpDreamcastGD1.Hint := LngFile.ReadString('FileMenuHints', 'DumpDreamcastGDHint', Error);
  Main_Form.DumpDreamcastVMU1.Hint := LngFile.ReadString('FileMenuHints', 'DumpDreamcastVMUHint', Error);
  Main_Form.LinkTest1.Hint := LngFile.ReadString('FileMenuHints', 'LinkTestHint', Error);
  Main_Form.DeleteFLASH1.Hint := LngFile.ReadString('FileMenuHints', 'DelFlashRomHint', Error);
  Main_Form.Sendacommand1.Hint := LngFile.ReadString('FileMenuHints', 'SendACommandHint', Error);
  Main_Form.Reset1.Hint := LngFile.ReadString('FileMenuHints', 'ResetDCTOOLHint', Error);
  Main_Form.Abortoperation1.Hint := LngFile.ReadString('FileMenuHints', 'AbortCurrentOperationHint', Error);
  Main_Form.Exit1.Hint := LngFile.ReadString('FileMenuHints', 'ExitThisProgram', Error);

  //----Edition------
  Main_Form.Edit1.Caption := LngFile.ReadString('EditMenu', 'Edit', Error);
  Main_Form.Setadressesto1.Caption := LngFile.ReadString('EditMenu', 'SetAddressesTo', Error);
  Main_Form.Setsizeto1.Caption := LngFile.ReadString('EditMenu', 'SetSizeTo', Error);
  Main_Form.Linktype1.Caption := LngFile.ReadString('EditMenu', 'SetLinkType', Error);
  Main_Form.Serial1.Caption := LngFile.ReadString('EditMenu', 'Serial', Error);
  Main_Form.BroadbandAdapter1.Caption := LngFile.ReadString('EditMenu', 'BroadBand', Error);
  Main_Form.Setdeviceport1.Caption := LngFile.ReadString('EditMenu', 'SetDevicePortTo', Error);
  Main_Form.Usebautrate1.Caption := LngFile.ReadString('EditMenu', 'SetBaudrateTo', Error);
  Main_Form.SetcommunicationIPto1.Caption := LngFile.ReadString('EditMenu', 'SetCommunicationIPTo', Error);
  //Hints
  Main_Form.Setadressesto1.Hint := LngFile.ReadString('EditMenuHints', 'SetAdressesToDefaultIs0x8C010000', Error);
  Main_Form.Setsizeto1.Hint := LngFile.ReadString('EditMenuHints', 'SetSizeToSpecifiedValueForDownloadCommand', Error);
  Main_Form.Linktype1.Hint := LngFile.ReadString('EditMenuHints', 'SetLinkTypeHint', Error);
  Main_Form.Serial1.Hint := LngFile.ReadString('EditMenuHints', 'SerialHint', Error);
  Main_Form.BroadbandAdapter1.Hint := LngFile.ReadString('EditMenuHints', 'BroadbandAdapterHint', Error);
  Main_Form.Setdeviceport1.Hint := LngFile.ReadString('EditMenuHints', 'UseDeviceToCommunicateWithTheDreamcastDefaultCOM1', Error);
  Main_Form.Usebautrate1.Hint := LngFile.ReadString('EditMenuHints', 'SetBaudrateDefaultIs57600', Error);
  Main_Form.SetcommunicationIPto1.Hint := LngFile.ReadString('EditMenuHints', 'SetCommunicationIPToHint', Error);

  //----Debug----
  Main_Form.Debugview1.Caption := LngFile.ReadString('DebugMenu', 'Debug', Error);
  Main_Form.Copyselectedtext1.Caption := LngFile.ReadString('DebugMenu', 'CopySelectedText', Error);
  Main_Form.Copyselectedte1.Caption := Main_Form.Copyselectedtext1.Caption;
  Main_Form.Selectall1.Caption := LngFile.ReadString('DebugMenu', 'SelectAll', Error);
  Main_Form.Selectall2.Caption := Main_Form.Selectall1.Caption;
  Main_Form.Findtext1.Caption := LngFile.ReadString('DebugMenu', 'FindText', Error);
  Main_Form.Saveoutputas1.Caption := LngFile.ReadString('DebugMenu', 'SaveOutputsAs', Error);
  Main_Form.Savetofile1.Caption := Main_Form.Saveoutputas1.Caption;
  Main_Form.Cleardebuglog1.Caption := LngFile.ReadString('DebugMenu', 'ClearDebugLog', Error);
  Main_Form.Cleardebuglog2.Caption := Main_Form.Cleardebuglog1.Caption;
  Main_Form.SaveDialog.Title := LngFile.ReadString('DebugMenu', 'SaveDialogTitle', Error);
  Main_Form.SaveDialog.Filter := LngFile.ReadString('DebugMenu', 'SaveDialogFilter', Error);
  Main_Form.Foundtext1.Caption := Main_Form.Findtext1.Caption;
  Main_Form.Cleardebug1.Caption := Main_Form.Cleardebuglog1.Caption;
  Main_Form.Gotoline1.Caption := LngFile.ReadString('DebugMenu', 'GotoLine', Error);
  Main_Form.Reexecute1.Caption := LngFile.ReadString('DebugMenu', 'ReExecute', Error);
  //Hints
  Main_Form.Copyselectedtext1.Hint := LngFile.ReadString('DebugMenuHints', 'CopySelectedTextHint', Error);
  Main_Form.Copyselectedte1.Hint := Main_Form.Copyselectedtext1.Hint;
  Main_Form.Selectall1.Hint := LngFile.ReadString('DebugMenuHints', 'SelectAllHint', Error);
  Main_Form.Selectall2.Hint := Main_Form.Selectall1.Hint;
  Main_Form.Findtext1.Hint := LngFile.ReadString('DebugMenuHints', 'FindTextHint', Error);
  Main_Form.Saveoutputas1.Hint := LngFile.ReadString('DebugMenuHints', 'SaveOutputsAsHint', Error);
  Main_Form.Savetofile1.Hint := Main_Form.Saveoutputas1.Hint;
  Main_Form.Cleardebuglog1.Hint := LngFile.ReadString('DebugMenuHints', 'ClearDebugLogHint', Error);
  Main_Form.Cleardebuglog2.Hint := Main_Form.Cleardebuglog1.Hint;
  Main_Form.Foundtext1.Hint := Main_Form.Findtext1.Hint;
  Main_Form.Cleardebug1.Hint := Main_Form.Cleardebuglog1.Hint;
  Main_Form.Gotoline1.Hint := LngFile.ReadString('DebugMenuHints', 'GotoLineHint', Error);
  Main_Form.Reexecute1.Hint := LngFile.ReadString('DebugMenuHints', 'ReExecuteHint', Error);

  //----Filters----
  Main_Form.Filters3.Caption := LngFile.ReadString('FiltersMenu', 'Filters', Error);
  Main_Form.Enablefilters1.Caption := LngFile.ReadString('FiltersMenu', 'EnableFilters', Error);
  Main_Form.Filters1.Caption := LngFile.ReadString('FiltersMenu', 'ConfigureFilters', Error);
  Main_Form.Viewfilteredoutputs1.Caption := LngFile.ReadString('FiltersMenu', 'ViewFilteredOutputs', Error);
  //Hints
  Main_Form.Enablefilters1.Hint := LngFile.ReadString('FiltersMenuHints', 'EnableFiltersHint', Error);
  Main_Form.Filters1.Hint := LngFile.ReadString('FiltersMenuHints', 'ConfigureFiltersHint', Error);
  Main_Form.Viewfilteredoutputs1.Hint := LngFile.ReadString('FiltersMenuHints', 'ViewFilteredOutputsHint', Error);

  //----Options----
  Main_Form.Options1.Caption := LngFile.ReadString('OptionsMenu', 'Options', Error);
  Main_Form.ryalternate1152001.Caption := LngFile.ReadString('OptionsMenu', 'TryAlternateBaudrateTo115200', Error);
  Main_Form.Dontattachconsoleandfileserver1.Caption := LngFile.ReadString('OptionsMenu', 'DontAttachConsoleAndFileserver', Error);
  Main_Form.Usedumbterminalrather1.Caption := LngFile.ReadString('OptionsMenu', 'UseDumbTerminalRatherThanConsoleFileserver', Error);
  Main_Form.Dontclearscreenbeforedownload1.Caption := LngFile.ReadString('OptionsMenu', 'DontClearScreenBeforeDownload', Error);
  Main_Form.Advanced1.Caption := LngFile.ReadString('OptionsMenu', 'Advanced', Error);
  //Hints
  Main_Form.ryalternate1152001.Hint := LngFile.ReadString('OptionsMenuHints', 'TryAlternateBaudrateTo115200AndChangeBaudrateTo115200', Error);
  Main_Form.Dontattachconsoleandfileserver1.Hint := LngFile.ReadString('OptionsMenuHints', 'DontAttachConsoleAndFileserverOptionHint', Error);
  Main_Form.Usedumbterminalrather1.Hint := LngFile.ReadString('OptionsMenuHints', 'UseDumbTerminalRatherThanConsoleFileserverOptionHint', Error);
  Main_Form.Dontclearscreenbeforedownload1.Hint := LngFile.ReadString('OptionsMenuHints', 'DontClearScreenBeforeDownloadOptionHint', Error);
  Main_Form.Advanced1.Hint := LngFile.ReadString('OptionsMenuHints', 'AdvancedHint', Error);

  //----Config----
  Main_Form.Config1.Caption := LngFile.ReadString('ConfigMenu', 'Configuration', Error);
  Main_Form.Configwizard1.Caption := LngFile.ReadString('ConfigMenu', 'ConfigurationWizard', Error);
  Main_Form.Configuration1.Caption := LngFile.ReadString('ConfigMenu', 'ConfigurationOfDCToolGUI', Error);
  Main_Form.CygwinDLLs1.Caption := LngFile.ReadString('ConfigMenu', 'CygwinDLL', Error);
  Main_Form.BINstatedetection1.Caption := LngFile.ReadString('ConfigMenu', 'BINStateDetection', Error);
  Main_Form.Options2.Caption := LngFile.ReadString('ConfigMenu', 'Options', Error);
  Main_Form.History1.Caption := LngFile.ReadString('ConfigMenu', 'History', Error);

  //Hints
  Main_Form.Configwizard1.Hint := LngFile.ReadString('ConfigMenuHints', 'ConfigurationWizardHint', Error);
  Main_Form.Configuration1.Hint := LngFile.ReadString('ConfigMenuHints', 'ConfigurationOfDCToolGUIHint', Error);
  Main_Form.CygwinDLLs1.Hint := LngFile.ReadString('ConfigMenuHints', 'CygWinDLLsHint', Error);
  Main_Form.BINstatedetection1.Hint := LngFile.ReadString('ConfigMenuHints', 'BINStateDetectionHint', Error);
  Main_Form.Options2.Hint := LngFile.ReadString('ConfigMenuHints', 'OptionsHint', Error);
  Main_Form.History1.Hint := LngFile.ReadString('ConfigMenuHints', 'HistoryHint', Error);

  //----Help----
  Main_Form.Help1.Caption := LngFile.ReadString('HelpMenu', 'Help', Error);
  Main_Form.MainHelp1.Caption := LngFile.ReadString('HelpMenu', 'MainHelp', Error);
  Main_Form.Submitbugsreport1.Caption := LngFile.ReadString('HelpMenu', 'SubmitDCToolGUIBugs', Error);
  Main_Form.Websites1.Caption := LngFile.ReadString('HelpMenu', 'Websites', Error);
  Main_Form.About1.Caption := LngFile.ReadString('HelpMenu', 'About', Error);
  //Hints
  Main_Form.MainHelp1.Hint := LngFile.ReadString('HelpMenuHint', 'DisplayMainHelp', Error);
  Main_Form.Submitbugsreport1.Hint := LngFile.ReadString('HelpMenuHint', 'SubmitDCToolGUIBugsToAuthor', Error);
  Main_Form.Websites1.Hint := LngFile.ReadString('HelpMenuHint', 'VisitWebsites', Error);
  Main_Form.About1.Hint := LngFile.ReadString('HelpMenuHint', 'AboutThisProgram', Error);
  Main_Form.DCTOOL1.Hint := LngFile.ReadString('HelpMenuHint', 'OfficialDCToolWebsite', Error);
  Main_Form.DCTOOLGUI1.Hint := LngFile.ReadString('HelpMenuHint', 'DCToolGUIWebsite', Error);

  // ---< UPLOAD FORM >---
  Upload_Form.Caption := LngFile.ReadString('UploadWindow', 'Title', Error);
  Upload_Form.Cancel.Caption := CancelBtn;
  Upload_Form.OK.Caption := LngFile.ReadString('UploadWindow', 'UploadButton', Error);
  Upload_Form.FileInfo_GroupBox.Caption := ' ' + LngFile.ReadString('UploadWindow', 'ParametersGroupBox', Error) + ' ';
  Upload_Form.Input_Label.Caption := LngFile.ReadString('UploadWindow', 'InputFileLabel', Error);
  Upload_Form.UpExecute.Caption := LngFile.ReadString('UploadWindow', 'UploadAndExecuteCheckBox', Error);
  Upload_Form.Input_OpenDialog.Title := LngFile.ReadString('UploadWindow', 'InputOpenDialogTitle', Error);
  Upload_Form.Input_OpenDialog.Filter := LngFile.ReadString('UploadWindow', 'InputOpenDialogFilter', Error);

  // ---< DOWNLOAD FORM >---
  Download_Form.Caption := LngFile.ReadString('DownloadWindow', 'Title', Error);
  Download_Form.OK.Caption := LngFile.ReadString('DownloadWindow', 'DownloadButton', Error);
  Download_Form.Cancel.Caption := CancelBtn;
  Download_Form.FileInfo_GroupBox.Caption := ' ' + LngFile.ReadString('UploadWindow', 'ParametersGroupBox', Error) + ' ';
  Download_Form.SetSizeBtn.Caption := LngFile.ReadString('DownloadWindow', 'SetSizeButton', Error);
  Download_Form.Input_Label.Caption := LngFile.ReadString('DownloadWindow', 'OutputFile', Error);
  Download_Form.SaveDialog.Title := LngFile.ReadString('DownloadWindow', 'OutputSaveDialogTitle', Error);
  Download_Form.SaveDialog.Filter := LngFile.ReadString('DownloadWindow', 'OutputSaveDialogFilter', Error);

  // ---< WARNING WINDOW >---
  Warning_Form.Caption := LngFile.ReadString('DisclaimerWindow', 'WarningDisclaimer', Error);
  Warning_Form.bOK.Caption := LngFile.ReadString('DisclaimerWindow', 'IAgree', Error);
  Warning_Form.bCancel.Caption := LngFile.ReadString('DisclaimerWindow', 'IDisagree', Error);
  Warning_Form.cbDontAskAgain.Caption := LngFile.ReadString('DisclaimerWindow', 'DontAskItAgain', Error);

  // ---< DUMPING BIOS >---
  BIOS_Form.Caption := LngFile.ReadString('DumpDreamcastBIOS', 'DumpingBIOSTitle', Error);
  BIOS_Form.bCancel.Caption := CancelBtn;
  BIOS_Form.lSaveTo.Caption := LngFile.ReadString('DumpDreamcastBIOS', 'SaveTo', Error);
  BIOS_Form.lDumpingBIOS.Caption := LngFile.ReadString('DumpDreamcastBIOS', 'DumpingDreamcastBIOSPleaseWait', Error);
  BIOS_Form.lStatusCaption.Caption := LngFile.ReadString('DumpDreamcastBIOS', 'Status', Error);
  BIOS_Form.lCurrent.Caption := LngFile.ReadString('DumpDreamcastBIOS', 'Current', Error);
  BIOS_Form.lOverAll.Caption := LngFile.ReadString('DumpDreamcastBIOS', 'Overall', Error);
  BIOS_Form.sdBIOS.Title := LngFile.ReadString('DumpDreamcastBIOS', 'SaveDreamcastBIOSFilesTo', Error);
  BIOS_Form.bLog.Caption := ShowLogBtn;
  BiosInProgress := LngFile.ReadString('DumpDreamcastBIOS', 'InProgress', Error);
  BiosFailed := LngFile.ReadString('DumpDreamcastBIOS', 'Failed', Error);
  BiosSuccess := LngFile.ReadString('DumpDreamcastBIOS', 'Success', Error);
  BIOS_Form.Copyline1.Caption := Main_Form.Copyselectedtext1.Caption;
  BIOS_Form.Selectall1.Caption := Main_Form.Selectall1.Caption;
  BIOS_Form.Save1.Caption := LngFile.ReadString('FiltersConfiguration', 'Save', Error);
  BIOS_Form.SaveDialog.Title := LngFile.ReadString('DebugMenu', 'SaveDialogTitle', Error);
  BIOS_Form.SaveDialog.Filter := LngFile.ReadString('DebugMenu', 'SaveDialogFilter', Error);

  // ---< LINK TEST >---
  LinkTest_Form.Caption := LngFile.ReadString('LinkTest', 'Title', Error);
  LinkTest_Form.lDreamcastPCLinkTester.Caption := LngFile.ReadString('LinkTest', 'DreamcastPCLinkTester', Error);
  LinkTest_Form.bBegin.Caption := LngFile.ReadString('LinkTest', 'Begin', Error);
  LinkTest_Form.bCancel.Caption := CancelBtn;
  LinkTest_Form.gbOutput.Caption := ' ' + LngFile.ReadString('LinkTest', 'Outputs', Error) + ' ';
  LinkTest_Form.Copyline1.Caption := Main_Form.Copyselectedtext1.Caption;
  LinkTest_Form.Selectall1.Caption := Main_Form.Selectall1.Caption;
  LinkTest_Form.Save1.Caption := LngFile.ReadString('FiltersConfiguration', 'Save', Error);

  // ---< SET SIZE >---
  SetSize_Form.Caption := LngFile.ReadString('SetSizeWindow', 'Title', Error);
  SetSize_Form.OKButton.Caption := OKBtn;
  SetSize_Form.Cancel_Button.Caption := CancelBtn;
  SetSize_Form.Label1.Caption := LngFile.ReadString('SetSizeWindow', 'SetSizeTo', Error);
  SetSize_Form.SetTheSizeNowGroupBox.Caption := ' ' + LngFile.ReadString('SetSizeWindow', 'SetTheSizeNowGroupBox', Error) + ' ';
  SetSize_Form.Label2.Caption := LngFile.ReadString('SetSizeWindow', 'Bytes', Error);

  // ---< SET ADDRESS >---
  Address_Form.Caption := LngFile.ReadString('AddressWindow', 'Title', Error);
  Address_Form.OKButton.Caption := OKBtn;
  Address_Form.Cancel_Button.Caption := CancelBtn;
  Address_Form.PleaseSetTheNewAddressNowGroupBox.Caption := ' ' + LngFile.ReadString('AddressWindow', 'PleaseSetTheNewAddressNowGroupBox', Error) + ' ';
  Address_Form.DefBtn.Caption := DefaultBtn;
  Address_Form.Address.EditLabel.Caption := LngFile.ReadString('AddressWindow', 'SetAddressTo', Error);

  // ---< SET BAUDRATE >---
  SetBaudrate_Form.Caption := LngFile.ReadString('BaudrateWindow', 'Title', Error);
  SetBaudrate_Form.OKButton.Caption := OKBtn;
  SetBaudrate_Form.Cancel_Button.Caption := CancelBtn;
  SetBaudrate_Form.SetBaudrateToGroupBox.Caption := ' ' + LngFile.ReadString('BaudrateWindow', 'SetBaudrateToGroupBox', Error) + ' ';
  SetBaudrate_Form.SetBaudrateTo.Caption := LngFile.ReadString('BaudrateWindow', 'SetBaudrateTo', Error);
  SetBaudrate_Form.Baud_Label.Caption := LngFile.ReadString('BaudrateWindow', 'Bauds', Error);

  // ---< SET IP >---
  IP_Form.Caption := LngFile.ReadString('SetIP', 'Title', Error);
  IP_Form.DefBtn.Caption  := DefaultBtn;
  IP_Form.OKButton.Caption := OKBtn;
  IP_Form.Cancel_Button.Caption := CancelBtn;
  IP_Form.PleaseSetTheNewAddressNowGroupBox.Caption := ' ' + LngFile.ReadString('SetIP', 'PleaseSetTheNewAddressNow', Error) + ' ';
  IP_Form.EnterIPAdress.Caption := LngFile.ReadString('SetIP', 'EnterIPAddress', Error);
  IPAddressMustBeValidFormat0000To255255255255 := LngFile.ReadString('SetIP', 'IPAddressMustBeValidFormat0000To255255255255', Error);

  // ---< CONFIGURE FILTERS >---
  Filters_Form.Caption := LngFile.ReadString('FiltersConfiguration', 'Title', Error);
  Filters_Form.GroupBox1.Caption := ' ' + LngFile.ReadString('FiltersConfiguration', 'Filters', Error) + ' ';
  Filters_Form.Label1.Caption := LngFile.ReadString('FiltersConfiguration', 'FiltersLetYouToHideTheUselessLinesWhenYouMakeTransfer', Error);
  Filters_Form.bAdd.Caption := LngFile.ReadString('FiltersConfiguration', 'Add', Error);
  Filters_Form.bEdit.Caption := LngFile.ReadString('FiltersConfiguration', 'Edit', Error);
  Filters_Form.bDel.Caption := LngFile.ReadString('FiltersConfiguration', 'Delete', Error);
  Filters_Form.bDelAll.Caption := LngFile.ReadString('FiltersConfiguration', 'DeleteAll', Error);
  Filters_Form.bLoad.Caption := LngFile.ReadString('FiltersConfiguration', 'Load', Error);
  Filters_Form.bAppend.Caption := LngFile.ReadString('FiltersConfiguration', 'Append', Error);
  Filters_Form.bSave.Caption := LngFile.ReadString('FiltersConfiguration', 'Save', Error);
  Filters_Form.bApply.Caption := ApplyBtn; //LngFile.ReadString('FiltersConfiguration', 'Apply', Error);
  Filters_Form.bClose.Caption := CloseBtn;
  Filters_Form.Additem1.Caption := Filters_Form.bAdd.Caption;
  Filters_Form.Edititem1.Caption := Filters_Form.bEdit.Caption;
  Filters_Form.Deleteitem1.Caption := Filters_Form.bDel.Caption;
  Filters_Form.Deleteallitems1.Caption := Filters_Form.bDelAll.Caption;
  Filters_Form.Loadfromfile1.Caption := Filters_Form.bLoad.Caption;
  Filters_Form.Appendfromfile1.Caption := Filters_Form.bAppend.Caption;
  Filters_Form.Savelistas1.Caption := Filters_Form.bSave.Caption;
  Filters_Form.SaveDialog.Title := LngFile.ReadString('FiltersConfiguration', 'PleaseChooseYourFileNameDialogTitle', Error);
  Filters_Form.OpenDialog.Title := LngFile.ReadString('FiltersConfiguration', 'PleaseChooseYourFileNameDialogTitle', Error);
  Filters_Form.SaveDialog.Filter := LngFile.ReadString('FiltersConfiguration', 'DialogFilter', Error);
  Filters_Form.OpenDialog.Filter := LngFile.ReadString('FiltersConfiguration', 'DialogFilter', Error);

  // ---< ADD_FORM >---
  Add_Form.bAccept.Caption := AcceptBtn;
  Add_Form.bAbort.Caption := AbortBtn;

  // ---< FILTERED FORM >---
  Filtered_Form.Close1.Caption := CloseBtn;
  Filtered_Form.File1.Caption := Main_Form.File1.Caption;
  Filtered_Form.Saveas1.Caption := Main_Form.Savetofile1.Caption;
  Filtered_Form.Deletealloutputs1.Caption := Main_Form.Cleardebuglog1.Caption;
  Filtered_Form.Copyselectedtext1.Caption := Main_Form.Copyselectedtext1.Caption;
  Filtered_Form.Copyselectedtext2.Caption := Main_Form.Copyselectedtext1.Caption;
  Filtered_Form.Clear1.Caption := LngFile.ReadString('Events', 'ClearThisList', Error);
  Filtered_Form.Clearthislist1.Caption := Filtered_Form.Clear1.Caption;
  Filtered_Form.Search1.Caption := Main_Form.Findtext1.Caption;
  Filtered_Form.Search2.Caption := Main_Form.Findtext1.Caption;
  Filtered_Form.Edit1.Caption := Main_Form.Edit1.Caption;
  Filtered_Form.Selectall1.Caption := Main_Form.Selectall1.Caption;
  Filtered_Form.Selectall2.Caption := Main_Form.Selectall1.Caption;
  Filtered_Form.Deletealloutputs2.Caption := Main_Form.Cleardebuglog1.Caption;
  Filtered_Form.Saveas2.Caption := Main_Form.Savetofile1.Caption;
  Filtered_Form.Showmainwindow1.Caption := LngFile.ReadString('Events', 'ShowMainWindow', Error);
  Filtered_Form.Showmainform1.Caption := Filtered_Form.Showmainwindow1.Caption;
  Filtered_Form.Stayontop1.Caption := LngFile.ReadString('Events', 'StayOnTop', Error);
  Filtered_Form.Options1.Caption := Main_Form.Options1.Caption;
  Filtered_Form.SaveDialog.Title := LngFile.ReadString('DebugMenu', 'SaveDialogTitle', Error);
  Filtered_Form.SaveDialog.Filter :=LngFile.ReadString('DebugMenu', 'SaveDialogFilter', Error);
  //Hints
  Filtered_Form.Close1.Hint := LngFile.ReadString('Events', 'CloseThisWindowHint', Error);
  Filtered_Form.File1.Hint := Main_Form.File1.Hint;
  Filtered_Form.Saveas1.Hint := Main_Form.Savetofile1.Hint;
  Filtered_Form.Deletealloutputs1.Hint := Main_Form.Cleardebuglog1.Hint;
  Filtered_Form.Copyselectedtext1.Hint := Main_Form.Copyselectedtext1.Hint;
  Filtered_Form.Copyselectedtext2.Hint := Main_Form.Copyselectedtext1.Hint;
  Filtered_Form.Clear1.Hint := LngFile.ReadString('Events', 'ClearThisListHint', Error);
  Filtered_Form.Clearthislist1.Hint := Filtered_Form.Clear1.Hint;
  Filtered_Form.Search1.Hint := Main_Form.Findtext1.Hint;
  Filtered_Form.Search2.Hint := Main_Form.Findtext1.Hint;
  Filtered_Form.Edit1.Hint := Main_Form.Edit1.Hint;
  Filtered_Form.Selectall1.Hint := Main_Form.Selectall1.Hint;
  Filtered_Form.Selectall2.Hint := Main_Form.Selectall1.Hint;
  Filtered_Form.Deletealloutputs2.Hint := Main_Form.Cleardebuglog1.Hint;
  Filtered_Form.Saveas2.Hint := Main_Form.Savetofile1.Hint;
  Filtered_Form.Showmainwindow1.Hint := LngFile.ReadString('Events', 'ShowMainWindowHint', Error);
  Filtered_Form.Showmainform1.Hint := Filtered_Form.Showmainwindow1.Hint;
  Filtered_Form.Stayontop1.Hint := LngFile.ReadString('Events', 'StayOnTopHint', Error);
  Filtered_Form.Options1.Hint := Main_Form.Options1.Hint;

  // ---< ADVANCED OPTIONS >---
  Advanced_Form.Caption := LngFile.ReadString('AdvancedWindow', 'AdvancedOptionsTitle', Error);
  Advanced_Form.gbChroot.Caption := ' ' + LngFile.ReadString('AdvancedWindow', 'ChrootToDirectory', Error) + ' ';
  Advanced_Form.cbChroot.Caption := LngFile.ReadString('AdvancedWindow', 'EnableChrootToPath', Error);
  Advanced_Form.gbISO.Caption := ' ' + LngFile.ReadString('AdvancedWindow', 'CdfsISORedirection', Error) + ' ';
  Advanced_Form.cbISO.Caption := LngFile.ReadString('AdvancedWindow', 'EnableCDFSRedirectionWithanISOImage', Error);
  Advanced_Form.JvBrowseForFolderDialog.Title := LngFile.ReadString('AdvancedWindow', 'PleaseSelectTheFolder', Error);
  InvalidPathPleaseVerifyTheDirectory := LngFile.ReadString('AdvancedWindow', 'InvalidPathPleaseVerifyTheDirectory', Error);
  Advanced_Form.OpenDialog.Title := LngFile.ReadString('AdvancedWindow', 'IsoOpenDialogTitle', Error);
  Advanced_Form.OpenDialog.Filter :=  LngFile.ReadString('AdvancedWindow', 'IsoOpenDialogFilter', Error);
  Advanced_Form.bCancel.Caption := CancelBtn;
  Advanced_Form.bOK.Caption := OKBtn;

  // ---< WIZARD CONFIGURATION >---
  Wizard_Form.P1_Prev.Caption := PrevBtn;
  Wizard_Form.prChoice.Caption := PrevBtn;
  Wizard_Form.prSerial.Caption := PrevBtn;
  Wizard_Form.prBBA.Caption := PrevBtn;
  Wizard_Form.prFinish.Caption := PrevBtn;
  Wizard_Form.ntChoice.Caption := NextBtn;
  Wizard_Form.ntSerial.Caption := NextBtn;
  Wizard_Form.P1_Next.Caption := NextBtn;
  Wizard_Form.ntBBA.Caption := NextBtn;
  Wizard_Form.ntFinish.Caption := FinishBtn;
  Wizard_Form.BitBtn4.Caption := CancelBtn;
  Wizard_Form.cbAlternate.Caption := LngFile.ReadString('WizardConfig', 'EnableAlternate115200', Error);
  Wizard_Form.Caption := LngFile.ReadString('WizardConfig', 'Title', Error);
  Wizard_Form.lHelloTitle.Caption := LngFile.ReadString('WizardConfig', 'HelloDearUserTitle', Error);
  Wizard_Form.lHelloTip1.Caption := LngFile.ReadString('WizardConfig', 'WelcomeTip', Error);
  Wizard_Form.lHelloTip2.Caption := LngFile.ReadString('WizardConfig', 'PleaseClickOnNextButton', Error);
  Wizard_Form.lLinkTypeTitle.Caption := LngFile.ReadString('WizardConfig', 'SelectYourLinkTypeTitle', Error);
  Wizard_Form.lLinkTypeTip1.Caption := LngFile.ReadString('WizardConfig', 'LinkTypeTip', Error);
  Wizard_Form.gbLinkType.Caption := LngFile.ReadString('WizardConfig', 'LinkType', Error);
  Wizard_Form.lSerialTitle.Caption := LngFile.ReadString('WizardConfig', 'SerialCodersCableTitle', Error);
  Wizard_Form.rbSerial.Caption := LngFile.ReadString('WizardConfig', 'CodersCable', Error);
  Wizard_Form.rbBBA.Caption := LngFile.ReadString('WizardConfig', 'BroadBandAdapter', Error);
  Wizard_Form.rbNothing.Caption := LngFile.ReadString('WizardConfig', 'Nothing', Error);
  Wizard_Form.lSerialTitle.Caption := LngFile.ReadString('WizardConfig', 'SerialCodersCableTitle', Error);
  Wizard_Form.lSerialTip1.Caption := LngFile.ReadString('WizardConfig', 'SerialCodersCableTip1', Error);
  Wizard_Form.lSerialTip2.Caption := LngFile.ReadString('WizardConfig', 'SerialCodersCableTip2', Error);
  Wizard_Form.gbChooseBaudrate.Caption := ' ' + LngFile.ReadString('WizardConfig', 'ChooseYourBaudrate', Error) + ' ';
  Wizard_Form.gbChooseCOM.Caption := ' ' + LngFile.ReadString('WizardConfig', 'ChooseYourCOMPort', Error) + ' ';
  Wizard_Form.lbauds.Caption := LngFile.ReadString('BaudrateWindow', 'Bauds', Error);
  Wizard_Form.lBBATitle.Caption := LngFile.ReadString('WizardConfig', 'BroadBandAdapterTitle', Error);
  Wizard_Form.lBBATip1.Caption := LngFile.ReadString('WizardConfig', 'BroadBandAdapterTip1', Error);
  Wizard_Form.lBBATip2.Caption := LngFile.ReadString('WizardConfig', 'BroadBandAdapterTip2', Error);
  Wizard_Form.gbEnterIP.Caption := ' ' + LngFile.ReadString('WizardConfig', 'EnterIPHere', Error) + ' ';
  Wizard_Form.lForInfoPort31313.Caption := LngFile.ReadString('WizardConfig', 'ForInfoPort31313IsUsed', Error);
  Wizard_Form.lFinishedTitle.Caption := LngFile.ReadString('WizardConfig', 'FinishedTitle', Error);
  Wizard_Form.lFinishedTip1.Caption := LngFile.ReadString('WizardConfig', 'FinishedTip1', Error);
  Wizard_Form.lFinishedTip2.Caption := LngFile.ReadString('WizardConfig', 'FinishedTip2', Error);
  AreYouSureToCloseTheDialogWizard := LngFile.ReadString('WizardConfig', 'AreYouSureToCloseTheDialogWizard', Error);
  ThisIsAJoke := LngFile.ReadString('WizardConfig', 'ThisIsAJoke', Error);

  // ---< DC-TOOL LOCATION >---
  Dctool_Form.Caption := LngFile.ReadString('DctoolLocationWindow', 'Title', Error);
  Dctool_Form.DCTOOL_GroupBox.Caption := ' ' + LngFile.ReadString('DctoolLocationWindow', 'DCToolLocationGroupBox', Error) + ' ';
  Dctool_Form.Internal_RadioButton.Caption := LngFile.ReadString('DctoolLocationWindow', 'InternalDCTool', Error);
  Dctool_Form.External_RadioButton.Caption := LngFile.ReadString('DctoolLocationWindow', 'ExternalDCTool', Error);
  Dctool_Form.Location_Label.Caption := LngFile.ReadString('DctoolLocationWindow', 'Location', Error);
  Dctool_Form.Info_Label.Caption := LngFile.ReadString('DctoolLocationWindow', 'DCTOOLInternalVersionIsVersion103', Error);
  Dctool_Form.OK.Caption := OKBtn;
  Dctool_Form.OpenDialog.Title := LngFile.ReadString('DctoolLocationWindow', 'TitleOpenDialog', Error);
  Dctool_Form.OpenDialog.Filter := LngFile.ReadString('DctoolLocationWindow', 'FilterOpenDialog', Error);
  Dctool_Form.Cancel.Caption := CancelBtn;
  Dctool_Form.GroupBox1.Caption := ' ' + LngFile.ReadString('DctoolLocationWindow', 'DCToolType', Error) + ' ';
  Dctool_Form.Serial_RadioButton.Caption := LngFile.ReadString('WizardConfig', 'CodersCable', Error);
  Dctool_Form.BBA_RadioButton.Caption := LngFile.ReadString('WizardConfig', 'BroadBandAdapter', Error);

  // ---< CYGWIN LOCATION >---
{  Cygwin_Form.Caption := LngFile.ReadString('CygwinWindow', 'ConfigureCygwinLibrariesTitle', Error);
  Cygwin_Form.rbInternal.Caption := LngFile.ReadString('CygwinWindow', 'InternalCygwinDLL', Error);
  Cygwin_Form.rbExternal.Caption := LngFile.ReadString('CygwinWindow', 'UseCygwinInstalledPackage', Error);
  Cygwin_Form.Info_Label.Caption := LngFile.ReadString('CygwinWindow', 'NoteCygwinDLLAreCygwin1andCygintlv1003_22_0_0', Error);
  Cygwin_Form.gbCygwin.Caption := LngFile.ReadString('CygwinWindow', 'ConfigureCygwinLibrariesTitle', Error);
  Cygwin_Form.OK.Caption := OKBtn;
  Cygwin_Form.Cancel.Caption := CancelBtn;  } //Moved parce que ca bug (à cause de Delphi!)

  // ---< BINCHECK >---
{  BinCheck_Form.bOK.Caption := OKBtn;
  BinCheck_Form.bCancel.Caption := CancelBtn;
  BinCheck_Form.Caption := LngFile.ReadString('BinCheckModuleWindow', 'BinCheckModuleConfigurationTitle', Error);
  BinCheck_Form.gbBINCheckModuleConfiguration.Caption := ' ' + LngFile.ReadString('BinCheckModuleWindow', 'BinCheckModuleConfigurationTitle', Error) + ' : ';
  BinCheck_Form.rbAskOnlyBeforeUnscrambling.Caption := LngFile.ReadString('BinCheckModuleWindow', 'AskOnlyBeforeUnscramblingTheBinIfTheBinIsScrambled', Error);
  BinCheck_Form.rbAskAlways.Caption := LngFile.ReadString('BinCheckModuleWindow', 'AlwaysConfirmTheResultOfBinDetection', Error);
  BinCheck_Form.rbDoNotAskAnyThing.Caption := LngFile.ReadString('BinCheckModuleWindow', 'UnscrambleAutoOntheBinDirectoryWithoutPrompt', Error);
  BinCheck_Form.rbDoNotUseThis.Caption := LngFile.ReadString('BinCheckModuleWindow', 'DontUseTheBinCheckModuleThanks', Error); }

  // ---< OPTIONS >---
  Options_Form.Caption := LngFile.ReadString('OptionsWindow', 'OptionsTitle', Error);
  Options_Form.GroupBox1.Caption := ' ' + LngFile.ReadString('OptionsWindow', 'Options', Error) + ' ';
  Options_Form.BitBtn1.Caption := OKBtn;
  Options_Form.BitBtn2.Caption := CancelBtn;
  Options_Form.cbAllowLongFileNames.Caption := LngFile.ReadString('OptionsWindow', 'AllowLongFilesNameInDebugView', Error);
  Options_Form.cbHideSplashForm.Caption := LngFile.ReadString('OptionsWindow', 'DisableTheStartupSplashScreen', Error);
  Options_Form.cbDisableAutoExpandTree.Caption := LngFile.ReadString('OptionsWindow', 'DisableAutoExpandTreeAfterOperation', Error);
  Options_Form.cbWarnIfAddressNotDefault.Caption := LngFile.ReadString('OptionsWindow', 'DisableWarningIfTheAddressIsNotSetAt0x8C10000ForUpload', Error);

  // ---< HISTORY >---
  History_Form.Caption := LngFile.ReadString('HistoryWindow', 'HistoryManager', Error);
  History_Form.gbHistory.Caption := ' ' + LngFile.ReadString('HistoryWindow', 'HistoryGroupBox', Error) + ' ';
  History_Form.bDelete.Caption := LngFile.ReadString('FiltersConfiguration', 'Delete', Error);
  History_Form.bDeleteAll.Caption := LngFile.ReadString('FiltersConfiguration', 'DeleteAll', Error);
  History_Form.bClose.Caption := CloseBtn;
  History_Form.bClear.Caption := LngFile.ReadString('HistoryWindow', 'Clean', Error);
  History_Form.Delete1.Caption := History_Form.bDelete.Caption;
  History_Form.Deleteall1.Caption := History_Form.bDeleteAll.Caption;
  History_Form.Clean1.Caption := History_Form.bClear.Caption;

  // ---< PROGRESS >---
  UpProgress_Form.Caption := LngFile.ReadString('ProgressWindow', 'UploadingFile', Error);
  UpProgress_Form.Stop_Button.Caption := LngFile.ReadString('ProgressWindow', 'StopButton', Error);
  UpProgress_Form.Info_Label.Caption := LngFile.ReadString('ProgressWindow', 'WorkInProgressPleaseWait', Error);
  DownProgress_Form.Caption := LngFile.ReadString('ProgressWindow', 'DownloadingFile', Error);
  DownProgress_Form.Stop_Button.Caption := UpProgress_Form.Stop_Button.Caption;
  DownProgress_Form.Info_Label.Caption := UpProgress_Form.Info_Label.Caption;
  UpProgress_Form.lSaveTo.Caption := LngFile.ReadString('ProgressWindow', 'TargetFile', Error);
  DownProgress_Form.lSaveTo.Caption := UpProgress_Form.lSaveTo.Caption;

  // ---< DELFLASH >---
  DelFlash_Form.Caption := LngFile.ReadString('DelFlashWindow', 'Title', Error);
  //DelFlash_Form.lDelFlashTitle.Caption := LngFile.ReadString('DelFlashWindow', 'DelFlashTitle', Error);
  //DelFlash_Form.Label1.Caption := LngFile.ReadString('DelFlashWindow', 'PoweredByDCFlashromResetToolByAngelaSCHMIDT', Error);
  DelFlash_Form.bBegin.Caption := LngFile.ReadString('LinkTest', 'Begin', Error);
  DelFlash_Form.bCancel.Caption := CancelBtn;
  DelFlash_Form.gbOutput.Caption := ' ' + LngFile.ReadString('LinkTest', 'Outputs', Error) + ' ';
  DelFlash_Form.Copyline1.Caption := Main_Form.Copyselectedtext1.Caption;
  DelFlash_Form.Selectall1.Caption := Main_Form.Selectall1.Caption;
  DelFlash_Form.Save1.Caption := LngFile.ReadString('FiltersConfiguration', 'Save', Error);

  // ---< SEND CMD >---
  SendCmd_Form.Caption := LngFile.ReadString('SendCmdWindow', 'SendACommandToDCTOOL', Error);
  SendCmd_Form.gbCommand.Caption := ' ' + LngFile.ReadString('SendCmdWindow', 'Command', Error) + ' ';
  SendCmd_Form.gbType.Caption := ' ' + LngFile.ReadString('DctoolLocationWindow', 'DCToolType', Error) + ' ';
  SendCmd_Form.Serial_RadioButton.Caption := LngFile.ReadString('WizardConfig', 'CodersCable', Error);
  SendCmd_Form.BBA_RadioButton.Caption := LngFile.ReadString('WizardConfig', 'BroadBandAdapter', Error);
  SendCmd_Form.bBegin.Caption := LngFile.ReadString('SendCmdWindow', 'RunButton', Error);
  SendCmd_Form.bCancel.Caption := CancelBtn;
  SendCmd_Form.cbConsole.Caption := LngFile.ReadString('SendCmdWindow', 'DisplayTheOriginalDOSConsole', Error);
  SendCmd_Form.gbOutput.Caption := ' ' + LngFile.ReadString('LinkTest', 'Outputs', Error) + ' ';
  SendCmd_Form.Copyline1.Caption := Main_Form.Copyselectedtext1.Caption;
  SendCmd_Form.Selectall1.Caption := Main_Form.Selectall1.Caption;
  SendCmd_Form.Save1.Caption := LngFile.ReadString('FiltersConfiguration', 'Save', Error);

  // ---< EVENTS >---
  //ReplaceCygWinDLL := LngFile.ReadString('Events', 'ReplaceCygWinDLL', Error);
  InformationCaption := LngFile.ReadString('Events', 'Information', Error);
  ErrorCaption := LngFile.ReadString('Events', 'Error', Error);
  QuestionCaption := LngFile.ReadString('Events', 'Question', Error);
  WarningCaption := LngFile.ReadString('Events', 'Warning', Error);
  PleaseSpecifyTheFile := LngFile.ReadString('Events', 'PleaseSpecifyTheFile', Error);
  ErrorFileNotFound := LngFile.ReadString('Events', 'ErrorFileNotFound', Error);
  InputPathEmpty := LngFile.ReadString('Events', 'InputPathEmpty', Error);
  SizeIsIncorrect := LngFile.ReadString('Events', 'SizeIsIncorrect', Error);
  BaudrateIsIncorrect := LngFile.ReadString('Events', 'BaudrateIsIncorrect', Error);
  FileExistsDoYouWantToReplaceIt := LngFile.ReadString('Events', 'FileExistsDoYouWantToReplaceIt', Error);
  SizeCantBeZero := LngFile.ReadString('Events', 'SizeCantBeZero', Error);
  WarningBIOSMessage := LngFile.ReadString('DumpDreamcastBIOS', 'WarningDumpingYourBiosIsAllowedOnlyIfItIsYourDreamcast', Error);
  WarningGDRipMessage := LngFile.ReadString('Events', 'WarningThisIsNotAWarezTool', Error);
  AreYouSureToStopDumpingYourBIOS := LngFile.ReadString('Events', 'AreYouSureToStopDumpingYourBIOS', Error);
  PleaseInsertTheDCLOADDiscAndRebootConsole := LngFile.ReadString('Events', 'PleaseInsertTheDCLOADDiscAndRebootConsole', Error);
  YourLinkIsCorrectlySetAndActive := LngFile.ReadString('Events', 'YourLinkIsCorrectlySetAndActive', Error);
  AreYouSureToCancelTheLinkTest := LngFile.ReadString('Events', 'AreYouSureToCancelTheLinkTest', Error);
  AreYouSureToResetDCTOOL := LngFile.ReadString('Events', 'AreYouSureToResetDCTOOL', Error);
  TextNotFoundOrAllOccurencesFound := LngFile.ReadString('Events', 'TextNotFoundOrAllOccurencesFound', Error);
  Removed := LngFile.ReadString('Events', 'Removed', Error);
  PleaseSelectANode := LngFile.ReadString('Events', 'PleaseSelectANode', Error);
  AreYouSureToDeleteOutputs := LngFile.ReadString('Events', 'AreYouSureToDeleteOutputs', Error);
  ThereAreCurrentlyAProcessDoYouWantToAbortIt := LngFile.ReadString('Events', 'ThereAreCurrentlyAProcessDoYouWantToAbortIt', Error);
  CloseWithoutSavingChanges := LngFile.ReadString('Events', 'CloseWithoutSavingChanges', Error);
  AddANewItem := LngFile.ReadString('Events', 'AddANewItem', Error);
  EnterTheStringHere := ' ' + LngFile.ReadString('Events', 'EnterTheStringHere', Error) + ' ';
  EditCurrentItem := LngFile.ReadString('Events', 'EditCurrentItem', Error);
  PleaseEnterTheCorrectedItemHere := ' ' + LngFile.ReadString('Events', 'PleaseEnterTheCorrectedItemHere', Error) + ' ';
  CantBeEmpty := LngFile.ReadString('Events', 'CantBeEmpty', Error);
  PleaseSelectAItem := LngFile.ReadString('Events', 'PleaseSelectAItem', Error);
  AreYouSureToDeleteThisKeyword := LngFile.ReadString('Events', 'AreYouSureToDeleteThisKeyword', Error);
  AreYouSureToDeleteAllFilters := LngFile.ReadString('Events', 'AreYouSureToDeleteAllFilters', Error);
  AreYouSureToRemplaceAllFilters := LngFile.ReadString('Events', 'AreYouSureToRemplaceAllFilters', Error);
  NothingWasAddedToTheListBecauseThereIsNothingToAdd := LngFile.ReadString('Events', 'NothingWasAddedToTheListBecauseThereIsNothingToAdd', Error);
  ThereIs := LngFile.ReadString('Events', 'ThereIs', Error);
  ItemsAdded := LngFile.ReadString('Events', 'ItemsAdded', Error);
  AreYouSureToClearTheList := LngFile.ReadString('Events', 'AreYouSureToClearTheList', Error);
  DoYouWantToDeleteAll := LngFile.ReadString('Events', 'DoYouWantToDeleteAll', Error);
  PleaseSelectAnItemBefore := LngFile.ReadString('Events', 'PleaseSelectAnItemBefore', Error);
  DoYouWantToCleanInvalidFilenames := LngFile.ReadString('Events', 'DoYouWantToCleanInvalidFilenames', Error);
  AbortOperation := LngFile.ReadString('Events', 'AbortOperation', Error);
  DumpingDreamcastBIOSoperationCompleted := LngFile.ReadString('Events', 'DumpingDreamcastBIOSoperationCompleted', Error);
  TheBiosFilenameExistsInThisDirectory := LngFile.ReadString('Events', 'TheBiosFilenameExistsInThisDirectory', Error);
  TheFlashFilenameExistsInThisDirectory := LngFile.ReadString('Events', 'TheFlashFilenameExistsInThisDirectory', Error);
  OverWriteIt := LngFile.ReadString('Events', 'OverWriteIt', Error);
  WarningAddressIsNotTheDefaultAddress := LngFile.ReadString('Events', 'WarningAddressIsNotTheDefaultAddress', Error);
  DoYouWantToContinueAnyway := LngFile.ReadString('Events', 'DoYouWantToContinueAnyway', Error);
  ErrorWhenUnscramblingTheBINAborted := LngFile.ReadString('Events', 'ErrorWhenUnscramblingTheBINAborted', Error);
  TheBinIsScrambledUnscrambleIt := LngFile.ReadString('Events', 'TheBinIsScrambledUnscrambleIt', Error);
  UploadAnyWay := LngFile.ReadString('Events', 'UploadAnyWay', Error);
  UploadThisScrambledFileNotRecommended := LngFile.ReadString('Events', 'UploadThisScrambledFileNotRecommended', Error);
  WarningDCLOADCanCrashAfterExecutingThisFile := LngFile.ReadString('Events', 'WarningDCLOADCanCrashAfterExecutingThisFile', Error);
  TheBinWasDetected := LngFile.ReadString('Events', 'TheBinWasDetected', Error);
  Scrambled := LngFile.ReadString('Events', 'Scrambled', Error);
  Unscrambled := LngFile.ReadString('Events', 'Unscrambled', Error);
  YouMustUnscrambleIt := LngFile.ReadString('Events', 'YouMustUnscrambleIt', Error);
  TheFileIsCorrect := LngFile.ReadString('Events', 'TheFileIsCorrect', Error);
  DoYouAgree := LngFile.ReadString('Events', 'DoYouAgree', Error);
  AreYouSureToUnscrambleTheFileAndRenameThisFileasScrambledBin := LngFile.ReadString('Events', 'AreYouSureToUnscrambleTheFileAndRenameThisFileasScrambledBin', Error);
  WarningThisIsNotRecommendedClickOnTheNoButtonToUploadTheFile := LngFile.ReadString('Events', 'WarningThisIsNotRecommendedClickOnTheNoButtonToUploadTheFile', Error);
  PleaseRebootYourDreamcastNowIfYouMustSetTheDateTimeTheFLASHResetIsCompleted := LngFile.ReadString('Events', 'PleaseRebootYourDreamcastNowIfYouMustSetTheDateTimeTheFLASHResetIsCompleted', Error);
  WarningResetingYourFLASHMemoryEraseAllDatasYourISPSettingsWithDreamkey := LngFile.ReadString('Events', 'WarningResetingYourFLASHMemoryEraseAllDatasYourISPSettingsWithDreamkey', Error);
  DateTimeAndLanguageSelectionYourDreamcastIsSetAsFactoryVMUIsNotDeleted := LngFile.ReadString('Events', 'DateTimeAndLanguageSelectionYourDreamcastIsSetAsFactoryVMUIsNotDeleted', Error);
  AreYouSureToCancelTheFLASHReset := LngFile.ReadString('Events', 'AreYouSureToCancelTheFLASHReset', Error);
  WhenTheUploadIsFinishedTheScreensBorderShouldBecomeRedThenGreen := LngFile.ReadString('Events', 'WhenTheUploadIsFinishedTheScreensBorderShouldBecomeRedThenGreen', Error);
  ItIsRedWhileErasingTheFlashAndTurnGreenWhenItsDone := LngFile.ReadString('Events', 'ItIsRedWhileErasingTheFlashAndTurnGreenWhenItsDone', Error);
  ItsVeryQuickItTakesApproxMidSecond := LngFile.ReadString('Events', 'ItsVeryQuickItTakesApproxMidSecond', Error);
  AreYouSureToCancel := LngFile.ReadString('Events', 'AreYouSureToCancel', Error);

  //----< Traduction >----------
  About_Form.Trad_Label.Caption := GetTradInfos(LangID);
  About_Form.Close_Button.Caption := StringReplace(CloseBtn, '&', '', []);
  
  //Fermer le fichier.
  LngFile.Free;
end;

{-------------------------------< PROCEDURE LoadEnglish >------------------------------------------------------------------------------------------------------------------ }

procedure LoadEnglish;
begin
  //ReplaceCygWinDLL := 'If you want to replace CYGWIN DLLs, just replace DLLs on the DC-TOOL GUI folder.';
  InformationCaption := 'Information';
  ErrorCaption := 'Error';
  QuestionCaption := 'Question';
  WarningCaption := 'Warning';
  PleaseSpecifyTheFile := 'Please specify the file !';
  ErrorFileNotFound := 'Error : File not found.';
  InputPathEmpty := 'Input Path empty !';
  SizeIsIncorrect := 'Size is incorrect.';
  BaudrateIsIncorrect := 'Baudrate is incorrect.';
  FileExistsDoYouWantToReplaceIt := 'File already exists. Do you want to remplace it?';
  SizeCantBeZero := 'Size can''t be zero.';
  WarningBIOSMessage := 'WARNING : Dumping your BIOS is allowed *ONLY* if you don''t distribute it. If you distribute it, I could not be responsible.';
  WarningGDRipMessage := 'WARNING : Dumping your original GD-ROM is allowed *ONLY* if you are the *OWNER* of the GD-ROM to backup. You *MUSTN''T* distribute it. THIS IS *NOT* A WAREZ TOOL!!!';
  ShowLogBtn := '&Show log >>';
  HideLogBtn :=  '&Hide log <<';
  AreYouSureToStopDumpingYourBIOS := 'Are you sure to stop dumping BIOS ?';
  PleaseInsertTheDCLOADDiscAndRebootConsole := 'Please insert the DC-LOAD disc in the Dreamcast and reboot the console.';
  BiosInProgress := 'IN PROGRESS...';
  BiosFailed := 'FAILED!';
  BiosSuccess := 'SUCCESS';
  YourLinkIsCorrectlySetAndActive := 'Your link is correctly set and active.';
  AreYouSureToCancelTheLinkTest := 'Are you sure to cancel the test ?';
  AreYouSureToResetDCTOOL := 'Are you sure to reset DC-TOOL ?';
  TextNotFoundOrAllOccurencesFound := 'Text not found or all occurences found.';
  Removed := 'Removed.';
  PleaseSelectANode := 'Please select a node.';
  AreYouSureToDeleteOutputs := 'Are you sure to delete outputs ?';
  ThereAreCurrentlyAProcessDoYouWantToAbortIt := 'There are currently a process. Do you want to abort it ?';
  IPAddressMustBeValidFormat0000To255255255255 := 'IP address must be valid. Format : ''0.0.0.0'' to ''255.255.255.255''.';
  CloseWithoutSavingChanges := 'Close without saving changes ?';
  AddANewItem := 'Add a new item';
  EnterTheStringHere := ' ' + 'Enter the string here :' + ' ';
  EditCurrentItem := 'Edit current item';
  PleaseEnterTheCorrectedItemHere := ' ' + 'Please enter the corrected item here :' + ' ';
  CantBeEmpty := 'Can''t be empty.';
  PleaseSelectAItem := 'Please select an item.';
  AreYouSureToDeleteThisKeyword := 'Are you sure to delete this keyword ?';
  AreYouSureToDeleteAllFilters := 'Are you sure to delete all filters ???';
  AreYouSureToRemplaceAllFilters := 'Are you sure to remplace all filters ???';
  NothingWasAddedToTheListBecauseThereIsNothingToAdd := 'Nothing was added to the list, because there is nothing to add.';
  ThereIs := 'There is';
  ItemsAdded := 'item(s) added.';
  AreYouSureToClearTheList := 'Are you sure to clear the list ?';
  InvalidPathPleaseVerifyTheDirectory := 'Invalid path! Please verify the directory.';
  AreYouSureToCloseTheDialogWizard := 'Are you sure to close the dialog wizard ?';
  ThisIsAJoke := 'Huh! Well, how do you want to do that, then? Do you have BlueTooth or WiFi? This is a joke ^^';
  DoYouWantToDeleteAll := 'Do you want to delete all ?';
  PleaseSelectAnItemBefore := 'Please select an item before.';
  DoYouWantToCleanInvalidFilenames := 'Do you want to clean invalid filenames ?';
  AbortOperation := 'Abort operation ?';
  DumpingDreamcastBIOSoperationCompleted := 'Dumping Dreamcast BIOS operation completed.';
  TheBiosFilenameExistsInThisDirectory := 'The BIOS filename exists in this directory.';
  TheFlashFilenameExistsInThisDirectory := 'The FLASH filename exists in this directory.';
  OverWriteIt := 'Overwrite it?';
  WarningAddressIsNotTheDefaultAddress := 'Warning : Address isn''t the Default address.';
  DoYouWantToContinueAnyway := 'Do you want to continue anyway ?';
  ErrorWhenUnscramblingTheBINAborted := 'Error when Unscrambling the BIN. Aborted.';
  TheBinIsScrambledUnscrambleIt := 'The BIN is scrambled. Unscramble it ?';
  UploadAnyway := 'Upload anyway ?';
  UploadThisScrambledFileNotRecommended := 'Upload this ''scrambled'' file (not recommended) ?';
  WarningDCLOADCanCrashAfterExecutingThisFile := 'WARNING : DC-LOAD can crash after executing this file.';
  TheBinWasDetected := 'The BIN was detected :';
  Scrambled := 'SCRAMBLED';
  Unscrambled := 'UNSCRAMBLED';
  YouMustUnscrambleIt := 'You must unscramble it. Do you agree ?';
  TheFileIsCorrect := 'The file is correct.';
  DoYouAgree := 'Do you agree ?';
  AreYouSureToUnscrambleTheFileAndRenameThisFileasScrambledBin := 'Are you sure to unscramble the file and rename this file as ''scrambled.bin'' ?';
  WarningThisIsNotRecommendedClickOnTheNoButtonToUploadTheFile := 'WARNING : This isn''t recommended! Click on the ''No'' button to upload the file.';
  PleaseRebootYourDreamcastNowIfYouMustSetTheDateTimeTheFLASHResetIsCompleted := 'Please reboot your Dreamcast now. If you must set the date/time, the FLASH reset is completed.';
  WarningResetingYourFLASHMemoryEraseAllDatasYourISPSettingsWithDreamkey := 'WARNING : Reseting your FLASH memory erase ALL datas, your ISP settings (with DreamKey),';
  DateTimeAndLanguageSelectionYourDreamcastIsSetAsFactoryVMUIsNotDeleted := 'Date/Time and Language selection. Your Dreamcast will be as exit of factory. Your VMU aren''t deleted.';
  AreYouSureToCancelTheFLASHReset := 'Are you sure to cancel the FLASH reset ?';
  WhenTheUploadIsFinishedTheScreensBorderShouldBecomeRedThenGreen := 'When the upload is finished, the screen''s border should become red, then green.';
  ItIsRedWhileErasingTheFlashAndTurnGreenWhenItsDone := 'It is red while erasing the flash, and turn green when it''s done.';
  ItsVeryQuickItTakesApproxMidSecond := 'It''s very quick, it takes approx 1/2 second.';
  AreYouSureToCancel := 'Are you sure to cancel ?';
end;

{---------------------------------< ConfigureApplicationLanguage >--------------------------------------------------------------------------------------------------------------------------------- }

procedure ConfigureApplicationLanguage;
var
  LangID : string;
  
begin
  if ChooseLang = False then Exit;

  LangID := Ini.ReadString('Config', 'LangID', LangID);

  if UpperCase(LangID) = 'ENGLISH' then
  begin
    LoadEnglish;
    ChooseLang := False;
    Exit;
  end;

  if LangID <> '' then
  begin
    LoadLang(LangID);
    ChooseLang := False;
    Exit;
  end;

  if LangID = '' then
  begin

    if DirectoryExists(ExtractFilePath(Application.ExeName) + 'lang') = False then
    begin
      MsgBox(Main_Form.Handle, 'Directory "' + ExtractFilePath(Application.ExeName) + 'lang' + '" not found, so default language (english) were used.', 'Fatal Error - Oh dear :-/ -- GOD WERE ARE YOU ??', 48);
      Ini.WriteString('Config', 'LangID', 'English');
      LoadEnglish;
      Exit;
    end;

    ScruteLangFile;

    //if FileExists(Ini.FileName) = False then
    //begin
    Lang_Form.ShowModal;
    ChooseLang := False;
    Exit;
    //end;
  end;

  if LangID <> '' then LoadLang(LangID);

  ChooseLang := False;
end;

{ var
  LangID : string;  //Déplacé de Main_Form.Activate
  
begin
{  if ChooseLang = False then Exit;

  LangID := Ini.ReadString('Config', 'LangID', LangID);

  if UpperCase(LangID) = 'ENGLISH' then
  begin
    LoadEnglish;
    ChooseLang := False;
    Exit;
  end;

  if LangID <> '' then
  begin
    LoadLang(LangID);
    ChooseLang := False;
    Exit;
  end;

  if LangID = '' then
  begin

    if DirectoryExists(ExtractFilePath(Application.ExeName) + 'lang') = False then
    begin
      MsgBox(Main_Form.Handle, 'Directory "' + ExtractFilePath(Application.ExeName) + 'lang' + '" not found, so default language (english) were used.', 'Fatal Error - Oh dear :-/ -- GOD WERE ARE YOU ??', 48);
      Ini.WriteString('Config', 'LangID', 'English');
      LoadEnglish;
      Exit;
    end;

    ScruteLangFile;

    //if FileExists(Ini.FileName) = False then
    //begin
    Lang_Form.ShowModal;
    ChooseLang := False;
    Exit;
    //end;
  end;

  if LangID <> '' then LoadLang(LangID);

  ChooseLang := False; }

{---------------------------------< TranslateCygwinDialog >--------------------------------------------------------------------------------------------------------------------------------- }

procedure TranslateCygwinDialog;
var
  LangID, LngDir, Error : string;

begin
  LangID := Ini.ReadString('Config', 'LangID', LangID);
  if UpperCase(LangID) = 'ENGLISH' then Exit;
  Error := '<Error>';

  //Ouvrir le fichier voulu.
  LngDir := ExtractFilePath(Application.ExeName) + 'LANG\';
  LngFile := TIniFile.Create(LngDir + LangID);

  if FileExists(LngDir + LangID) = False then
  begin
    MsgBox(Main_Form.Handle, 'Damn! File "' + LngDir + LangID + '" not found !' + WrapStr + 'So the default language (English of course) will be used.', 'OOPS!', 48);
    LoadEnglish;
    Ini.WriteString('Config', 'LangID', 'English');
    Exit;
  end;

  // ---< CYGWIN LOCATION >---
  Cygwin_Form.Caption := LngFile.ReadString('CygwinWindow', 'ConfigureCygwinLibrariesTitle', Error);
  Cygwin_Form.rbInternal.Caption := LngFile.ReadString('CygwinWindow', 'InternalCygwinDLL', Error);
  Cygwin_Form.rbExternal.Caption := LngFile.ReadString('CygwinWindow', 'UseCygwinInstalledPackage', Error);
  Cygwin_Form.Info_Label.Caption := LngFile.ReadString('CygwinWindow', 'NoteCygwinDLLAreCygwin1andCygintlv1003_22_0_0', Error);
  Cygwin_Form.gbCygwin.Caption := ' ' + LngFile.ReadString('CygwinWindow', 'ConfigureCygwinLibrariesTitle', Error) + ' : ';
  Cygwin_Form.OK.Caption := LngFile.ReadString('Buttons', 'OK', Error);
  Cygwin_Form.Cancel.Caption := LngFile.ReadString('Buttons', 'Cancel', Error);
end;

{---------------------------------< TranslateBinCheckDialog >--------------------------------------------------------------------------------------------------------------------------------- }
//C'est malin, delphi, il m'oblige à faire séparé (a cause du bug de la case fermer qui fait ok a
//la place de annuler...

procedure TranslateBinCheckDialog;
var
  LangID, LngDir, Error : string;

begin
  LangID := Ini.ReadString('Config', 'LangID', LangID);
  if UpperCase(LangID) = 'ENGLISH' then Exit;
  Error := '<Error>';

  //Ouvrir le fichier voulu.
  LngDir := ExtractFilePath(Application.ExeName) + 'LANG\';
  LngFile := TIniFile.Create(LngDir + LangID);

  if FileExists(LngDir + LangID) = False then
  begin
    MsgBox(Main_Form.Handle, 'Damn! File "' + LngDir + LangID + '" not found !' + WrapStr + 'So the default language (English of course) will be used.', 'OOPS!', 48);
    LoadEnglish;
    Ini.WriteString('Config', 'LangID', 'English');
    Exit;
  end;

  // ---< BINCHECK >---
  BinCheck_Form.bOK.Caption := LngFile.ReadString('Buttons', 'OK', Error);
  BinCheck_Form.bCancel.Caption := LngFile.ReadString('Buttons', 'Cancel', Error);
  BinCheck_Form.Caption := LngFile.ReadString('BinCheckModuleWindow', 'BinCheckModuleConfigurationTitle', Error);
  BinCheck_Form.gbBINCheckModuleConfiguration.Caption := ' ' + LngFile.ReadString('BinCheckModuleWindow', 'BinCheckModuleConfigurationTitle', Error) + ' : ';
  BinCheck_Form.rbAskOnlyBeforeUnscrambling.Caption := LngFile.ReadString('BinCheckModuleWindow', 'AskOnlyBeforeUnscramblingTheBinIfTheBinIsScrambled', Error);
  BinCheck_Form.rbAskAlways.Caption := LngFile.ReadString('BinCheckModuleWindow', 'AlwaysConfirmTheResultOfBinDetection', Error);
  BinCheck_Form.rbDoNotAskAnyThing.Caption := LngFile.ReadString('BinCheckModuleWindow', 'UnscrambleAutoOntheBinDirectoryWithoutPrompt', Error);
  BinCheck_Form.rbDoNotUseThis.Caption := LngFile.ReadString('BinCheckModuleWindow', 'DontUseTheBinCheckModuleThanks', Error);
end;

{-------------------------------< FIN DES PROCEDURES >--------------------------------------------------------------------------------------------------------------------------------- }

end.
