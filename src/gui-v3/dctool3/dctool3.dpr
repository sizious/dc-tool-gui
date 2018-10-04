program dctool3;

uses
  Windows,
  SysUtils,
  Messages,
  Dialogs,
  Forms,
  main in 'main.pas' {Main_Form},
  upload in 'upload.pas' {Upload_Form},
  options in 'options.pas' {Options_Form},
  utils in 'utils.pas',
  ipcfg in 'ipcfg.pas' {IPCfg_Form},
  u_config in 'u_config.pas',
  excptlog in 'excptlog.pas' {Except_Form},
  u_history in 'u_history.pas',
  history in 'history.pas' {Histories_Form},
  histmgr in 'histmgr.pas',
  download in 'download.pas' {Download_Form},
  u_preset in 'u_preset.pas',
  highlights in 'highlights.pas' {Highlights_Form},
  dct_loc in 'dct_loc.pas' {DcToolLoc_Form},
  u_dctool_wrapper in 'u_dctool_wrapper.pas',
  cygwin in 'cygwin.pas' {Cygwin_Form},
  config in 'config.pas',
  u_dctool_binchk in 'u_dctool_binchk.pas',
  bincheck in 'bincheck.pas' {BinCheck_Form},
  parammgr in 'parammgr.pas',
  u_shellext_wrapper in 'u_shellext_wrapper.pas',
  dlgSearchText in 'dlgSearchText.pas' {TextSearchDialog},
  u_search in 'u_search.pas',
  SynDcTool in 'SynDcTool.pas',
  Splash in 'splash.pas' {Splashfrm},
  about in 'about\About.pas' {AboutBox},
  MiniFMOD in 'about\MiniFMOD.pas',
  aboutprg in 'about\aboutprg.pas' {About_Form};

{$R *.res}

var
  ParamFile,
  ParamSwitchs  : Atom;
  Hwd           : THandle;
  pSwap         : TParamSwap;
  
begin
  CreateMutex(nil, False, PChar(ExtractFileName(Application.ExeName)));

  if (GetLastError = ERROR_ALREADY_EXISTS) then
    begin

      //si un paramètre d'entrée est détecté.
      if HasParams then
        begin
          //On va recuperer tous les paramètres (GetParamsList)

          pSwap := GetParamsList;

          //Création des atoms pour stocker les paramètres en mémoire.
          ParamFile := GlobalAddAtom(PChar(pSwap.FileName));
          ParamSwitchs := GlobalAddAtom(PChar(pSwap.Switchs));

          //Transmission à l'application active des paramètres.
          Hwd := FindWindow(nil, PChar(MAIN_FORM_CAPTION));
          SendMessage(Hwd, WM_PARAMETRE, ParamSwitchs, ParamFile);
        end

      else
        begin
          //L'application est déjà lancée et elle est relancée sans paramètres.
          MessageBoxA(0, 'Only one instance can be launched !', 'FATAL !', MB_ICONERROR
            + MB_SYSTEMMODAL);
          Exit;
        end;

    end

  else
  begin
    Application.Initialize;
    Application.Title := 'DC-TOOL GUI 3 - Engine';

    //Affichage de l'écran Splash
    if IsSplashEnabled then
    begin

      SplashFrm := TSplashFrm.Create(Application);
      try
        SplashFrm.Show;
        SplashFrm.DoFade(100);

        { Le mieux aurait été de charger ici. Mais comme le splash est désactivable,
          ca serait très con de créer la form pour se rendre compte que finalement,
          on va pas l'afficher... }
      finally
        SplashFrm.Free;
      end;

    end;

    //Création des forms.
    Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(TOptions_Form, Options_Form);
  Application.CreateForm(THighlights_Form, Highlights_Form);
  Application.CreateForm(TSplashfrm, Splashfrm);
  //Application.CreateForm(TAboutBox, AboutBox);
    //Application.CreateForm(TAboutBox_Form, AboutBox_Form);
    //Application.CreateForm(TBinCheck_Form, BinCheck_Form);
    //Application.CreateForm(TCygwin_Form, Cygwin_Form);
    //Application.CreateForm(TDcToolLoc_Form, DcToolLoc_Form);
    //Application.CreateForm(TIPCfg_Form, IPCfg_Form);
    Application.CreateForm(TUpload_Form, Upload_Form);
    Application.CreateForm(TExcept_Form, Except_Form);
    //Application.CreateForm(THistories_Form, Histories_Form);
    Application.CreateForm(TDownload_Form, Download_Form);

    //Configurer l'application
    ConfigureApplication;

    //Lancement
    Application.Run;
  end;
end.
