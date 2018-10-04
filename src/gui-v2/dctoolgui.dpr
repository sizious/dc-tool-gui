{
  DC-TOOL GUI v1.2 -> v2.0
  ATTENTION AUX FORMS QUE MET DELPHI!!!
  IL LES MET N'IMPORTE OU!
}

//Lire la remarque à ce sujet dans le main.pas
//{$DEFINE SPECIAL_RIP_GD}

program dctoolgui;

uses
  Windows,
  IdGlobal,
  SysUtils,
  IniFiles,
  Forms,
  main in 'main.pas' {Main_Form},
  dctool_cfg in 'dctool_cfg.pas' {Dctool_Form},
  about in 'about.pas' {AboutBox},
  upload in 'upload.pas' {Upload_Form},
  tools in 'tools.pas',
  progress in 'progress.pas' {UpProgress_Form},
  download in 'download.pas' {Download_Form},
  setsize in 'setsize.pas' {SetSize_Form},
  address in 'address.pas' {Address_Form},
  baudrate in 'baudrate.pas' {SetBaudrate_Form},
  lang in 'lang.pas' {Lang_Form},
  utils in 'utils.pas',
  ab_dct in 'ab_dct.pas' {About_Form},
  r_colors in 'r_colors.pas',
  history in 'history.pas' {History_Form},
  u_hist in 'u_hist.pas',
  commands in 'commands.pas',
  u_progress in 'u_progress.pas',
  re_execute in 're_execute.pas',
  setip in 'setip.pas' {IP_Form},
  bba in 'bba.pas',
  bba_commands in 'bba_commands.pas',
  wizard in 'wizard.pas' {Wizard_Form},
  u_wizard in 'u_wizard.pas',
  filters in 'filters.pas' {Filters_Form},
  sh_listb in 'sh_listb.pas',
  u_filters in 'u_filters.pas',
  addbox in 'addbox.pas' {Add_Form},
  filtered in 'filtered.pas' {Filtered_Form},
  advanced in 'advanced.pas' {Advanced_Form},
  u_ctrls in 'u_ctrls.pas',
  getproc in 'getproc.pas',
  u_kill_dctool in 'u_kill_dctool.pas',
  u_dctool_manager in 'u_dctool_manager.pas',
  binchk in 'binchk.pas' {BINCheck_Form},
  u_advanced in 'u_advanced.pas',
  u_binchk in 'u_binchk.pas',
  com_spec in 'com_spec.pas',
  bios in 'bios.pas' {BIOS_Form},
  u_progress_dl in 'u_progress_dl.pas',
  warning in 'warning.pas' {Warning_Form},
  dl_progress in 'dl_progress.pas' {DownProgress_Form},
  MiniFMOD in 'MiniFMOD.pas',
  options in 'options.pas' {Options_Form},
  cygwin in 'cygwin.pas' {Cygwin_Form},
  splash in 'splash.pas' {SplashScreen_Form},
  ripgd in 'ripgd.pas',
  gd_ripper in 'gd_ripper.pas' {RipGD_Form},
  ext_track in 'ext_track.pas',
  ripgauge in 'ripgauge.pas',
  mutex in 'mutex.pas',
  linktest in 'linktest.pas' {LinkTest_Form},
  u_linktest in 'u_linktest.pas',
  delflash in 'delflash.pas' {DelFlash_Form},
  openhelp in 'openhelp.pas',
  sendcmd in 'sendcmd.pas' {SendCmd_Form},
  u_lang in 'u_lang.pas';

{$R *.res}

{ var
  CygWin1DLL : string; }

const
  DCTOOL_EXE    : string = 'DC-TOOL.EXE';
  DCTOOLIP_EXE  : string = 'DC-TOOL-IP.EXE';
  
var
  SplashForm    : TSplashScreen_Form;
  DCTOOLGUI_EXE : string;

begin
  Application.Initialize;
  Application.Title := 'DC-TOOL GUI - Loading...';

  //Init de l'INI. Permet de l'ouvrir et de créer l'objet Ini.
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

  //Permet de fermer l'application si elle est déjà lancée (car on kill tous les DC-TOOL!)
{  if FindWindow('TApplication', 'Delphi 7') = 0 then //Uniquement si Delphi 7 est pas lancé...
  begin
    if IsApplicationRunning('TMain_Form', 'DC-TOOL GUI', 'by [big_fury]SiZiOUS') = True then
    begin
      MsgBox(Application.Handle, 'DC-TOOL GUI is already running.', 'Error', 48);
      Halt(255);
    end;
  end; } //BUG AVEC CHOOSE LANGUAGE! LANG.EXE!!!!

  //DC-TOOL GUI ne peut pas s'appeller DC-TOOL.EXE ou DC-TOOL-IP.EXE
  DCTOOLGUI_EXE := ExtractFileName(Application.ExeName);
  if (UpperCase(DCTOOLGUI_EXE) = UpperCase(DCTOOL_EXE))
  or (UpperCase(DCTOOLGUI_EXE) = UpperCase(DCTOOLIP_EXE)) then
  begin
    MsgBox(Application.Handle, 'DC-TOOL GUI executable can''t be renamed in ''dc-tool.exe'' or ''dc-tool-ip.exe''.', 'Error', 16);
    Exit;
  end;

  //Afficher le splash ?
  if Ini.ReadBool('Options', 'HideSplash', False) = False then
  begin

    //Creer le splash
    SplashForm := TSplashScreen_Form.Create(Application);
    SSHandle := SplashForm.Handle;
    Application.ProcessMessages;

    //Center le Splash
    SplashForm.Left := 0;
    SplashForm.Position := poScreenCenter;

    //AnimateWindow(SSHandle, 100, AW_CENTER);

    SplashForm.Show; // affichage de la fiche
    SplashForm.Update; // force la fiche à se dessiner complètement
    Delay(1800);
    //SplashForm.FormStyle := fsStayOnTop;

    try
      Application.CreateForm(TMain_Form, Main_Form);
  //Creer la main form qd meme..
      SplashForm.Close;
    finally
      SplashForm.Free;// libération de la mémoire
    end;

  end else Application.CreateForm(TMain_Form, Main_Form); //Le Splash n'est pas activé.
                                                          //On va créer la Main_Form.

  //Forms
  //Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(TDctool_Form, Dctool_Form);

  //****DEBUT DIRECTIVE CONDITIONNELLE****

  {$IFDEF SPECIAL_RIP_GD}
    Application.CreateForm(TRipGD_Form, RipGD_Form); //[Enlevé car ca fait trop chier.]
  {$ENDIF}

  //****FIN DIRECTIVE CONDITIONNELLE****

  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TAbout_Form, About_Form);
  Application.CreateForm(TUpload_Form, Upload_Form);
  Application.CreateForm(TUpProgress_Form, UpProgress_Form);
  Application.CreateForm(TDownload_Form, Download_Form);
  Application.CreateForm(TSetSize_Form, SetSize_Form);
  Application.CreateForm(TAddress_Form, Address_Form);
  Application.CreateForm(TSetBaudrate_Form, SetBaudrate_Form);
  Application.CreateForm(TLang_Form, Lang_Form);
  Application.CreateForm(THistory_Form, History_Form);
  Application.CreateForm(TIP_Form, IP_Form);
  Application.CreateForm(TWizard_Form, Wizard_Form);
  Application.CreateForm(TFilters_Form, Filters_Form);
  Application.CreateForm(TAdd_Form, Add_Form);
  Application.CreateForm(TFiltered_Form, Filtered_Form);
  Application.CreateForm(TAdvanced_Form, Advanced_Form);
  Application.CreateForm(TBINCheck_Form, BINCheck_Form);
  Application.CreateForm(TBIOS_Form, BIOS_Form);
  Application.CreateForm(TWarning_Form, Warning_Form);
  Application.CreateForm(TDownProgress_Form, DownProgress_Form);
  Application.CreateForm(TOptions_Form, Options_Form);
  Application.CreateForm(TCygwin_Form, Cygwin_Form);
  Application.CreateForm(TSplashScreen_Form, SplashScreen_Form);
  Application.CreateForm(TLinkTest_Form, LinkTest_Form);
  Application.CreateForm(TDelFlash_Form, DelFlash_Form);
  Application.CreateForm(TSendCmd_Form, SendCmd_Form);
  ConfigureApplication;

  //Vérification si y'a lang.exe dans le dossier courant...
  if FileExists(ExtractFilePath(Application.ExeName) + 'lang.exe') = False then
    ExtractLangExe(PChar(ExtractFilePath(Application.ExeName)));

  //Afficher le Wizard si y'a besoin.
  if ShowWizard = True then Wizard_Form.ShowModal;

  //Lance l'appli.
  Application.Run;

  //NORMALEMENT, A PLACER AVANT... MAIS CE CODE EST INUTILE.
    //Verification DLLS
{  CygWin1DLL := ExtractFilePath(Application.ExeName) + 'cygwin1.dll';
  if FileExists(CygWin1DLL) = True then
  CopyFileTo(CygWin1DLL, GetTempDir + 'cygwin1.dll')
  else begin
    MsgBox(Application.Handle, 'ERROR! File not found :' + WrapStr + '"' + CygWin1DLL + '".', 'Error', 16);
    Halt(1);
  end;

  if FileExists(ExtractFilePath(Application.ExeName) + 'cygintl.dll') = True then
  CopyFileTo(ExtractFilePath(Application.ExeName) + 'cygintl.dll', GetTempDir + 'cygintl.dll')
  else begin
    MessageBoxA(Application.Handle, PChar('ERROR! File "' + ExtractFilePath(Application.ExeName) + 'cygintl.dll' + '" not found!!!'), 'Error', 16);
    Halt(1);
  end;  }
end.
