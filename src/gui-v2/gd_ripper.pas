{
  Unit : gd_ripper
  By   : [big_fury]SiZiOUS
  For  : DC-TOOL GUI v1.2
  Notes: Utilisation de DreamRip de BERO.
         Beaucoup plus simple à lire que dans le debug du DC-TOOL GUI !

         Fonction a peu près terminée & opérationnelle le 30/06/2004 à 13:48 !

         Utilise ext_track (pour lire track.txt) et ripgd (Upload de DREAMRIP).
}

unit gd_ripper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DosCommand, StdCtrls, Buttons, ComCtrls, JvRichEdit, ExtCtrls,
  JvBaseDlg, JvBrowseFolder, Gauges, ImgList, XPMenu, Menus;

type
  TRipGD_Form = class(TForm)
    dcRIP: TDosCommand;
    bRip: TBitBtn;
    rdRip: TJvRichEdit;
    bCancel: TBitBtn;
    odSaveTo: TJvBrowseForFolderDialog;
    GroupBox2: TGroupBox;
    ePath: TEdit;
    bBrowse: TBitBtn;
    GroupBox3: TGroupBox;
    TreeView: TTreeView;
    ListView: TListView;
    Label2: TLabel;
    lGameName: TLabel;
    Shape1: TShape;
    Label1: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Bevel1: TBevel;
    GroupBox1: TGroupBox;
    lTrackName: TLabel;
    lSize: TLabel;
    Panel1: TPanel;
    Gauge: TGauge;
    Bevel2: TBevel;
    bLog: TBitBtn;
    ilCDROM: TImageList;
    SaveDialog: TSaveDialog;
    PopupMenu: TPopupMenu;
    Copyline1: TMenuItem;
    Selectall1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    XPMenu: TXPMenu;
    procedure bRipClick(Sender: TObject);
    procedure dcRIPNewLine(Sender: TObject; NewLine: String;
      OutputType: TOutputType);
    procedure dcRIPTerminated(Sender: TObject; ExitCode: Cardinal);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bBrowseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bLogClick(Sender: TObject);
    procedure Copyline1Click(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Déclarations privées }
    procedure WMSYSCOMMAND(var msg : TWMSysCommand) ; message WM_SYSCOMMAND; //Permet de reduire l'appli lors du reduce win.
  public
    { Déclarations publiques }
  end;

var
  RipGD_Form: TRipGD_Form;

implementation

uses ext_track, ripgd, tools, u_progress, r_colors, u_ctrls, utils,
     u_kill_dctool, ripgauge, u_dctool_manager, main;

{$R *.dfm}

//Permet de réduire l'application, au lieu de la fenetre.
procedure TRipGD_Form.WMSYSCOMMAND(var msg: TWMSysCommand);
begin
  if msg.CmdType = SC_MINIMIZE then
  begin
    Application.Minimize;
    inherited; //faut minimizer la fenetre qd meme !
  end else inherited;  //Pour tout

  if msg.CmdType = SC_RESTORE then
  begin
    Application.Restore;
    inherited; //faut restaurer la fenetre qd meme !
  end else inherited;  //Pour tout
end;

//---InitGDRipper---
procedure InitGDRipper;
begin
  RipGD_Form.rdRip.Clear;
  RipGD_Form.ListView.Clear;
  RipGD_Form.TreeView.Items.Clear;
  RipGD_Form.lGameName.Caption := '';
  RipGD_Form.lTrackName.Caption := '';
  RipGD_Form.lSize.Caption := '';
  RipGD_Form.Gauge.Progress := 0;
  IsRipping := False;
  //IsErronous := False;
end;

//---DisactiveAllRIPControls---
procedure DisactiveAllRIPControls;
begin
  RipGD_Form.bRip.Enabled := False;
  RipGD_Form.ePath.Enabled := False;
  RipGD_Form.bBrowse.Enabled := False;
end;

//---ActiveAllRIPControls---
procedure ActiveAllRIPControls;
begin
  RipGD_Form.bRip.Enabled := True;
  RipGD_Form.ePath.Enabled := True;
  RipGD_Form.bBrowse.Enabled := True;
  Application.Title := Main_Form.Caption;
end;

//---StopRipping---
procedure StopRipping;
begin
  RipGD_Form.dcRIP.Stop;
  KillAllRunningDCTOOL;
end;

//---AddRipDebug---
procedure AddRipDebug(Msg : string);
begin
  AddFormattedText(Msg, RipGD_Form.rdRip, clBlue);
end;

//---AddFatalError---
procedure AddFatalError(Msg : string);
begin
  AddFormattedText(Msg, RipGD_Form.rdRip, clRed, 8, 'Tahoma', [fsBold]);
end;

//---AddStateInfo---
procedure AddStateInfo(Msg : string);
begin
  AddFormattedText(Msg, RipGD_Form.rdRip, clGreen);
end;

//---AddRipTitle---
procedure AddRipTitle(Msg : string);
begin
  AddFormattedText(Msg, RipGD_Form.rdRip, clBlue, 8, 'Tahoma', [fsBold]);
end;

procedure TRipGD_Form.bRipClick(Sender: TObject);
var
  CanDo : integer;

begin
  if DirectoryExists(ePath.Text) = False then
  begin
    MsgBox(Handle, 'Please select a valid path.', 'Error', 48);
    Exit;
  end;

  CanDo := MsgBox(Handle, 'Please insert your GD-ROM on the Dreamcast, and press OK to continue.' + WrapStr + 'Make sure you are running DC-LOAD.', 'Start ripping...', 48 + MB_DEFBUTTON2 + MB_OKCANCEL);
  if CanDo = IDCANCEL then Exit;
  
  DisactiveAllRIPControls;
  InitGDRipper; //Tout effacer
  AddStateInfo('Launching DreamRip v2.01 by BERO...');
  AddRipTitle('Uploading with DC-TOOL...');

  ExtractDreamRip;
  DoUploadCommand(GetTempDir + 'DREAMRIP.BIN', ePath.Text);
end;

procedure TRipGD_Form.dcRIPNewLine(Sender: TObject; NewLine: String;
  OutputType: TOutputType);
var
  TrackList     : string;
  TrackNameInfo : string;

begin
  TrackNameInfo := ''; //Init de TrackNameInfo. Permet de ne pas afficher 2x la meme ligne dans le rich edit (info sur le trackxx.iso rippé).
  if NewLine = '' then Exit;
  if NbSousChaine(MinProgress, NewLine) > 0 then Exit; //DreamRIP est trop petit pour une progress bar..
  TrackList := GetSelectedDir + ORIGINAL_TRACKLIST;

  //FINALEMENT, on va voir à chaque ligne si y'a une erreur!
  //***GEREMENT DES ERREURS DE DREAMRIP !***
  if DreamHaveRipError(NewLine) = True then
  begin
    ShowRightDreamRipError(Handle); //afficher une msg box correspondante.
    AddFatalError(NewLine);  //ajouter en rouge/gras la ligne correspondante (qui a indiqué l'erreur!).
    //IsErronous := False;
    NewLine := '';
    Exit;
  end;
  {  IsErronous := False;
    //end;
  end;  }

  //Essayer de lire le fichier texte que le prog crée ici...?
  if TreeView.Items.Count = 0 then //On la pas rempli encore donc on va essayer de le faire.
  begin
    if FileExists(TrackList) = True then //le fichier existe?
    begin //oui, on remplit.
      AddStateInfo('> Please wait...trying to open ''track.txt'' in 3 sec...');
      Delay(3000); //On attend! Parce que la, il est trop rapide, il a meme pas fini de creer le fichier!

      //FICHIER EN UTILISATION FAUT LE COPIER DANS TEMP.
      lGameName.Caption := ReadGameName(TrackList);
      if IsFileInUse(TrackList) = False then
        ReadTrackList(ListView, TreeView);
    end;
  end;

  //DreamRip v2.01 by BERO
  if IsDreamRipRunning(NewLine) = True then
  begin
    AddRipTitle(NewLine);
    //IsErronous := True; //Pour savoir si il va lancer le RIP
    NewLine := '';
    Exit;
  end;

  //Si on a trouvé par exemple trackXX.iso, on va lancer le download!
  //A chaque nouvelle piste.
  if IsRippingTrack(NewLine, Gauge) = True then
  begin
    RipGD_Form.lTrackName.Caption := GetTrackName(NewLine); //Avoir le nom de la piste rippée
    if IsRipping = False then AddStateInfo('> Starting GD-ROM ripping...'); //Première fois qu'on va ripper

    //Ajouter le nom du track rippé (protection anti 2x !)
    TrackNameInfo := 'Ripping current track : ' + GetTrackName(NewLine);//Voici la ligne a ajouter
    if GetLastRichEditLine(rdRIP) <> TrackNameInfo then //Si c'est different de la derniere ligne on l'ajoute 1x !
      AddStateInfo(TrackNameInfo); //Affiche le nom du track rippé (apparait 2 fois... comment faire? ... voir TrackNameInfo! [Au dessus])

    InitTrackRip(GetTrackName(NewLine)); //Permet d'initialiser les controles en fonction du track.
    
    { if FileExists(GetSelectedDir + NewLine) = True then
    begin
      MsgBox(Handle, 'Warning : The file going to be ripped already exists.' + WrapStr
        + 'File : "' + GetSelectedDir + NewLine + '".' + WrapStr + 'Ripping Aborted.', 'Fatal Error !', 16);
      StopRipping;
      Exit;
    end; }

    IsRipping := True;  //il est en train de ripper trackXX.iso !
    //RipGD_Form.lSize.Caption := PerformProgressAndGiveSize(NewLine, Gauge); //lire les infos!
    NewLine := '';
    Exit;
  end;

  if IsRipping = True then
  begin
    RipGD_Form.lSize.Caption := PerformProgressAndGiveSize(NewLine, Gauge); //lire les infos!
    Application.Title := 'Ripping GD [' + RipGD_Form.lTrackName.Caption + '] - ' + RipGD_Form.lSize.Caption + ' - ' + IntToStr(RipGD_Form.Gauge.Progress) + '%';
    NewLine := '';
    Exit;  //ne pas afficher le texte dans le debug!
  end;

  //Afficher le texte.
  if OutputType = otEntireLine then
    AddRipDebug(NewLine);

  Application.ProcessMessages;
  NewLine := '';
end;

procedure TRipGD_Form.dcRIPTerminated(Sender: TObject; ExitCode: Cardinal);
{ var
  LastNum, LastTrack : string; }

begin
  //fini?
{  LastNum := ListView.Items.Item[ListView.Items.Count - 1].Caption;
  LastTrack := 'track' + LastNum;
  if NbSousChaine(LastTrack, GetLastRichEditLine(rdRIP)) > 0 then
    AddStateInfo('The RIP may be finished...'); }

  AddFormattedText('DreamRIP Processus completed on ' + DateToStr(Date) + ' - ' + TimeToStr(Now) + ', Exit Code : ' + IntToStr(ExitCode), rdRip, clRed);
  ActiveControls;
  ActiveAllRIPControls;
  DeleteDreamRip;
  //InitGDRipper;
end;

procedure TRipGD_Form.FormClose(Sender: TObject; var Action: TCloseAction);
var
  CanDo : integer;

begin
  if dcRIP.Active = True then
  begin
    CanDo := MsgBox(Handle, 'Are you sure to cancel the rip ?' + WrapStr + 'The rip can''t be resumed!' + WrapStr + 'ALL DATA WILL BE LOST!', ErrorCaption, 48 + MB_DEFBUTTON2 + MB_YESNO);
    if CanDo = IDNO then
    begin
      Action := caNone;
      Exit;
    end;

    StopRipping;
    MsgBox(RipGD_Form.Handle, 'Please insert the DC-LOAD disc in the Dreamcast and reboot the console.', 'Information', 64);
  end;
end;

procedure TRipGD_Form.bBrowseClick(Sender: TObject);
begin
  if odSaveTo.Execute = True then
    ePath.Text := odSaveTo.Directory;
end;

procedure TRipGD_Form.FormShow(Sender: TObject);
begin
  InitGDRipper;
end;

procedure TRipGD_Form.bLogClick(Sender: TObject);
begin
  if bLog.Caption = '&Show log >>' then
  begin
    bLog.Caption := '&Hide Log <<';
    RipGD_Form.Height := 560;
  end else begin
    bLog.Caption := '&Show log >>';
    RipGD_Form.Height := 448;
  end;
end;

procedure TRipGD_Form.Copyline1Click(Sender: TObject);
begin
  rdRIP.CopyToClipboard;    
end;

procedure TRipGD_Form.Selectall1Click(Sender: TObject);
begin
  rdRIP.SelectAll;
end;

procedure TRipGD_Form.Save1Click(Sender: TObject);
begin
  SaveRichEditTo(rdRIP, SaveDialog);
end;

procedure TRipGD_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0;
    Close;
  end;
end;

end.
