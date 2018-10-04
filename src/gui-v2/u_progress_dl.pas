{
   [big_fury]
   888888888     8888   888888888888   8888       888888888      8888      8888     888888888
 8888888888888   8888   888888888888   8888     8888888888888    8888      8888   8888888888888
 8888     8888                88888            8888       8888   8888      8888   8888     8888
 888888888       8888       888888     8888   8888         8888  8888      8888   888888888
   8888888888    8888      88888       8888   8888         8888  8888      8888     88888888888
        888888   8888    88888         8888   8888         8888  8888      8888           888888
 8888      8888  8888   88888          8888    8888       8888   8888      8888   8888      8888
 8888888888888   8888  88888888888888  8888     8888888888888     888888888888    8888888888888
   8888888888    8888  88888888888888  8888       888888888        8888888888       8888888888

  Project     : DC-TOOL GUI
  Version     : v1.2
  Module      : U_Progress_DL.pas
  Short Desc  : Permet de gérer le remplissage de la ProgressBar pour le dumping du bios, et du
                Download en général.

}

unit u_progress_dl;

interface

uses
  Windows, SysUtils, ComCtrls, Messages, Forms;
  
const
   //MaxProgressStr : string  = 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC';
   MinProgress    : string  = 'recv_data: ';
   //MaxProgress    : integer = 68; //Taille du bin en kilo / 8 = nb de c
   //MaxProgress : string = 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCU';

var
  DlInProgress  : boolean;
  MaxProgress : integer;
  
function DlIsInProgress(NewLine : string) : boolean;
function DlPerformProgress(NewLine : string ; ProgressBar : TProgressBar) : integer;
procedure DlInitProgressBar(ProgressBar : TProgressBar ; SizeToDownload : integer);
function DlIsProgressCompleted(NewLine : string ; ProgressBar : TProgressBar) : boolean;
function ExtractFileSize(FileName : string) : integer;

implementation

uses main, progress, tools;

//---ExtractFileSize---
function ExtractFileSize(FileName : string) : integer;
var
  F : file of Byte;

begin
  if FileExists(FileName) = False then
  begin
    Result := 0;
    Exit;
  end;

  AssignFile(F, FileName);
  try
    Reset(F);
  except
    MessageBoxA(0, PChar('File "' + FileName + '" is in use.'), 'Error', 48);
    raise;
    Result := 0;
    Exit;
  end;

  Result := FileSize(F);
  CloseFile(F);
end;

//---Droite---
function Droite(substr : string ; s : string) : string;
begin
  if pos(substr,s)=0 then result:='' else
    result:=copy(s, pos(substr, s)+length(substr), length(s)-pos(substr, s)+length(substr));
end;

//---NbSousChaine---
function NbSousChaine(substr: string; s: string): integer;
begin
  result:=0;
  while pos(substr,s)<>0 do
  begin
    S:=droite(substr,s);
    inc(result);
  end;
end;

//---IsInString---
function DlIsInString(SubStr : string ; S : string) : boolean;
begin
  if NbSousChaine(SubStr, S) > 0 then
    Result := True
  else Result := False;
end;

//---IsInProgress---
function DlIsInProgress(NewLine : string) : boolean;
var
  UpNewLine, UpMinProgress : string;

begin
  UpNewLine := UpperCase(NewLine);
  UpMinProgress := UpperCase(MinProgress);
  Application.ProcessMessages;

  if IsInString(UpMinProgress, UpNewLine) = True then
  //begin
    Result := True
    //ShowMessage('FOUND');
  //end
  else Result := False;
end;

//---PerformProgress---
function DlPerformProgress(NewLine : string ; ProgressBar : TProgressBar) : integer;
var
  Progress, Step : integer;

begin
  Result := 0;
  if DlIsInProgress(NewLine) = False then Exit;
  Progress := Length(Droite(MinProgress, NewLine));  //Avoir la longueur des "C".

  Application.ProcessMessages;

  //ShowMessage(IntToStr(Progress));

  Step := Progress - ProgressBar.Position;  //les "C" - la Position
  Result := Step;

  Application.ProcessMessages;
  //ShowMessage(IntToStr(Step));

  ProgressBar.Position := ProgressBar.Position + Step;
  Application.ProcessMessages;
  //ProgressBar.Position := ProgressBar.Position + 1;
end;

//---InitProgressBar---
procedure DlInitProgressBar(ProgressBar : TProgressBar ; SizeToDownload : integer);
begin
  Application.ProcessMessages;
  //MessageBoxA(0, Pchar(IntToStr(MaxProgress)), '', 0);
  ProgressBar.Position := 0;
  MaxProgress := SizeToDownload div 8192;
  ProgressBar.Max := MaxProgress; //Pour le MAX de la pbar;
  Application.ProcessMessages;
end;

//---IsProgressCompleted---
function DlIsProgressCompleted(NewLine : string ; ProgressBar : TProgressBar) : boolean;
begin
  Result := False;
  Application.ProcessMessages;
  
  if IsInString(MinProgress, NewLine) = False then
    Result := True;
    
  if Length(Droite(MinProgress, NewLine)) >= MaxProgress then
    Result := True;
    
  if Result = True then
  begin
    ProgressBar.Position := ProgressBar.Max;
    Application.ProcessMessages;
    //Cacher la boite
    //MinimizeForm(Progress_Form);
  end;
end;

end.
