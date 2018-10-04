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
  Module      : U_Progress.pas
  Short Desc  : Permet de gérer le remplissage de la ProgressBar.

}

unit u_progress;

interface

uses
  Windows, SysUtils, ComCtrls, Messages;
  
const
   //MaxProgressStr : string  = 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC';
   MinProgress    : string  = 'send_data: ';
   //MaxProgress    : integer = 68; //Taille du bin en kilo / 8 = nb de c
   //MaxProgress : string = 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCU';

var
  InProgress  : boolean;
  MaxProgress : integer;
  
function IsInProgress(NewLine : string) : boolean;
procedure PerformProgress(NewLine : string ; ProgressBar : TProgressBar);
procedure InitProgressBar(ProgressBar : TProgressBar);
function IsProgressCompleted(NewLine : string ; ProgressBar : TProgressBar) : boolean;
function ExtractFileSize(FileName : string) : integer;
function NbSousChaine(substr: string; s: string): integer;

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
function IsInString(SubStr : string ; S : string) : boolean;
begin
  if NbSousChaine(SubStr, S) > 0 then
    Result := True
  else Result := False;
end;

//---IsInProgress---
function IsInProgress(NewLine : string) : boolean;
var
  UpNewLine, UpMinProgress : string;

begin
  UpNewLine := UpperCase(NewLine);
  UpMinProgress := UpperCase(MinProgress);

  if IsInString(UpMinProgress, UpNewLine) = True then
  //begin
    Result := True
    //ShowMessage('FOUND');
  //end
  else Result := False;
end;

//---PerformProgress---
procedure PerformProgress(NewLine : string ; ProgressBar : TProgressBar);
var
  Progress, Step : integer;

begin
  if IsInProgress(NewLine) = False then Exit;
  Progress := Length(Droite(MinProgress, NewLine));  //Avoir la longueur des "C".

  //ShowMessage(IntToStr(Progress));

  Step := Progress - ProgressBar.Position;  //les "C" - la Position

  //ShowMessage(IntToStr(Step));

  ProgressBar.Position := ProgressBar.Position + Step;
  //ProgressBar.Position := ProgressBar.Position + 1;
end;

//---InitProgressBar---
procedure InitProgressBar(ProgressBar : TProgressBar);
begin
  //MessageBoxA(0, Pchar(IntToStr(MaxProgress)), '', 0);
  ProgressBar.Position := 0;
  ProgressBar.Max := MaxProgress;
end;

//---IsProgressCompleted---
function IsProgressCompleted(NewLine : string ; ProgressBar : TProgressBar) : boolean;
begin
  Result := False;

  //if ProgressBar.Max >= MaxProgress then
  //  Result := True;

  //if IsInProgress(NewLine) = False then
  //  Result := True;

  if IsInString(MinProgress, NewLine) = False then
    Result := True;
    
  if Length(Droite(MinProgress, NewLine)) >= MaxProgress then
    Result := True;
    
  if Result = True then
  begin
    ProgressBar.Position := ProgressBar.Max;
  end;

  //PostMessage(Progress_Form.Handle, SC_MINIMIZE, 0, 0);
  //if Result = True then SHOWMESSAGE('COMPLETED');
end;

//ProgressBarManage
//Code à mettre dans le Timer, ou le DosCommand
{
if NewLine = '' then Exit;
  
  if InProgress = True then
  begin

    PerformProgress(NewLine, ProgressBar1);
    if IsProgressCompleted(NewLine, ProgressBar1) = True then
      InProgress := False else NewLine := '';
    Exit;
  end;

  if IsInProgress(NewLine) = True then
  begin
    InProgress := True;
    InitProgressBar(ProgressBar1);
    PerformProgress(NewLine, ProgressBar1);
    
    ShowMessage('IN PROGRESS');

    NewLine := '';
    Exit;
  end;

  m.Lines.Add(edit1.Text);
  NewLine := '';
}

end.
