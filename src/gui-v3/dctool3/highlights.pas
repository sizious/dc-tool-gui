unit highlights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  THighlights_Form = class(TForm)
    pcMain: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lbKeywords: TListBox;
    GroupBox3: TGroupBox;
    clrFore: TColorBox;
    GroupBox4: TGroupBox;
    cbBold: TCheckBox;
    cbUnderline: TCheckBox;
    cbStrikeOut: TCheckBox;
    cbItalic: TCheckBox;
    GroupBox5: TGroupBox;
    pReDemo: TPanel;
    bReFont: TBitBtn;
    GroupBox6: TGroupBox;
    eGlitDigitCount: TEdit;
    Label1: TLabel;
    GroupBox7: TGroupBox;
    cbxReColor: TColorBox;
    Label2: TLabel;
    eRePos: TEdit;
    Label3: TLabel;
    cbGlitter: TCheckBox;
    cbRightEdge: TCheckBox;
    GroupBox8: TGroupBox;
    pGlitFontDemo: TPanel;
    bGlitFont: TBitBtn;
    eGlitSize: TEdit;
    Label4: TLabel;
    Bevel1: TBevel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    cbDebugLogOutput: TCheckBox;
    cbDebugLogOutputTag: TCheckBox;
    cbDebugLogStateTag: TCheckBox;
    cbDebugLogCommandTag: TCheckBox;
    gbDebugLogStandardFont: TGroupBox;
    pLog: TPanel;
    bChangeStandardFont: TBitBtn;
    cbDebugLogCommand: TCheckBox;
    cbDebugLogState: TCheckBox;
    clrBack: TColorBox;
    Label5: TLabel;
    Label6: TLabel;
    FontDlg: TFontDialog;
    GroupBox13: TGroupBox;
    cbDebugLogAutoScroll: TCheckBox;
    pDebugLogCommand: TPanel;
    bDebugLogCommandFont: TBitBtn;
    Bevel2: TBevel;
    Bevel3: TBevel;
    bDebugLogOutputFont: TBitBtn;
    pDebugLogOutput: TPanel;
    pDebugLogState: TPanel;
    bDebugLogStateFont: TBitBtn;
    Bevel4: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure lbKeywordsClick(Sender: TObject);
    procedure bChangeStandardFontClick(Sender: TObject);
    procedure cbDebugLogCommandClick(Sender: TObject);
    procedure cbDebugLogOutputClick(Sender: TObject);
    procedure cbDebugLogStateClick(Sender: TObject);
    procedure bDebugLogCommandFontClick(Sender: TObject);
    procedure bDebugLogOutputFontClick(Sender: TObject);
    procedure bDebugLogStateFontClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure cbGlitterClick(Sender: TObject);
    procedure cbRightEdgeClick(Sender: TObject);
    procedure bGlitFontClick(Sender: TObject);
    procedure bReFontClick(Sender: TObject);
    procedure clrForeChange(Sender: TObject);
    procedure clrBackChange(Sender: TObject);
    procedure cbBoldClick(Sender: TObject);
    procedure cbStrikeOutClick(Sender: TObject);
    procedure cbUnderlineClick(Sender: TObject);
    procedure cbItalicClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Déclarations privées }
    function IsDebugLogConfigModified : boolean;
    function IsFontEqual(Font1, Font2 : TFont) : boolean;
  public
    { Déclarations publiques }
    procedure LoadWindowState;
    procedure SaveWindowState;
  end;

var
  Highlights_Form: THighlights_Form;

implementation

uses
  Main, SynEditHighlighter, utils;

{$R *.dfm}

procedure THighlights_Form.FormShow(Sender: TObject);
var
  i : integer;

begin
  pcMain.ActivePageIndex := 0;
  
  lbKeywords.Clear;

  for i := 0 to Main_Form.seOutputs.Highlighter.AttrCount - 1 do
    lbKeywords.Items.Add(Main_Form.seOutputs.Highlighter.Attribute[i].Name);
  if lbKeywords.Items.Count > 0 then
  begin
    lbKeywords.ItemIndex := 0;
    lbKeywordsClick(Sender);
  end;
end;

procedure THighlights_Form.lbKeywordsClick(Sender: TObject);
var
  CurrAttr : TSynHighlighterAttributes;

begin
  CurrAttr := Main_Form.seOutputs.Highlighter.Attribute[lbKeywords.ItemIndex];
  
  clrFore.Selected := CurrAttr.Foreground;
  clrBack.Selected := CurrAttr.Background;

  cbBold.Checked := (fsBold in CurrAttr.Style);
  cbItalic.Checked := (fsItalic in CurrAttr.Style);
  cbStrikeOut.Checked := (fsStrikeOut in CurrAttr.Style);
  cbUnderline.Checked := (fsUnderline in CurrAttr.Style);
end;

procedure THighlights_Form.bChangeStandardFontClick(Sender: TObject);
begin
  with FontDlg do
  begin
    Font := pLog.Font;
    if Execute then pLog.Font := Font;
  end;
end;

procedure THighlights_Form.LoadWindowState;
begin
  //Onglet RichEdit
  Self.cbRightEdge.Checked := Main_Form.seOutputs.RightEdge > 0;
  Self.cbxReColor.Selected := Main_Form.seOutputs.RightEdgeColor;
  Self.eRePos.Text := IntToStr(Main_Form.seOutputs.RightEdge);

  Self.cbGlitter.Checked := Main_Form.seOutputs.Gutter.Visible;
  Self.eGlitSize.Text := IntToStr(Main_Form.seOutputs.Gutter.Width);
  Self.eGlitDigitCount.Text := IntToStr(Main_Form.seOutputs.Gutter.DigitCount);
  Self.pGlitFontDemo.Font := Main_Form.seOutputs.Gutter.Font;

  Self.pReDemo.Font := Main_Form.seOutputs.Font;

  //Onglet Debug Log
  pLog.Font := Main_Form.reLog.Font;
  cbDebugLogAutoScroll.Checked := Main_Form.reLog.AutoScroll.Enabled;

  pDebugLogCommand.Font := Main_Form.reLog.LinesType.Command.Font;
  pDebugLogOutput.Font := Main_Form.reLog.LinesType.Log.Font;
  pDebugLogState.Font := Main_Form.reLog.LinesType.State.Font;

  Self.cbDebugLogCommand.Checked := Main_Form.reLog.LinesType.Command.Enabled;
  Self.cbDebugLogOutput.Checked := Main_Form.reLog.LinesType.Log.Enabled;
  Self.cbDebugLogState.Checked := Main_Form.reLog.LinesType.State.Enabled;

  Self.cbDebugLogCommandTag.Checked := Main_Form.reLog.LinesType.Command.ShowTag;
  Self.cbDebugLogOutputTag.Checked := Main_Form.reLog.LinesType.Log.ShowTag;
  Self.cbDebugLogStateTag.Checked := Main_Form.reLog.LinesType.State.ShowTag;
end;

//------------------------------------------------------------------------------

procedure THighlights_Form.SaveWindowState;
var
  CanDo : integer;

begin
  //Onglet RichEdit
  if Self.cbRightEdge.Checked then
    Main_Form.seOutputs.RightEdge := StrToInt(eRePos.Text)
  else Main_Form.seOutputs.RightEdge := 0;
  
  Main_Form.seOutputs.RightEdgeColor := Self.cbxReColor.Selected;

  Main_Form.seOutputs.Gutter.Visible := Self.cbGlitter.Checked;
  Main_Form.seOutputs.Gutter.Width := StrToInt(Self.eGlitSize.Text);
  Main_Form.seOutputs.Gutter.DigitCount := StrToInt(Self.eGlitDigitCount.Text);
  Main_Form.seOutputs.Gutter.Font := Self.pGlitFontDemo.Font;

  Main_Form.seOutputs.Font.Assign(Self.pReDemo.Font);
  Main_Form.multiSyn.UpdateSynEdits;

  //Debug log
  Main_Form.reLog.Font := pLog.Font;
  Main_Form.reLog.AutoScroll.Enabled := cbDebugLogAutoScroll.Checked;

  if IsDebugLogConfigModified then
  begin
    CanDo := MsgBox(Handle, 'Are you sure to apply the modifications ?'
      + WrapStr + 'The debug log''ll be cleared.', 'Warning', 48 + MB_YESNOCANCEL);
    case CanDo of
      IDNO      : Exit;    //EXIT DE LA PROCEDURE
      IDCANCEL  : begin
                    ModalResult := mrNone;
                    Exit;
                  end;
    end;

    Main_Form.reLog.InitLog.DoInitLog;
  
    Main_Form.reLog.LinesType.Command.Font := pDebugLogCommand.Font;
    Main_Form.reLog.LinesType.Log.Font := pDebugLogOutput.Font;
    Main_Form.reLog.LinesType.State.Font := pDebugLogState.Font;

    Main_Form.reLog.LinesType.Command.Enabled := cbDebugLogCommand.Checked;
    Main_Form.reLog.LinesType.Log.Enabled := cbDebugLogOutput.Checked;
    Main_Form.reLog.LinesType.State.Enabled := cbDebugLogState.Checked;

    Main_Form.reLog.LinesType.Command.ShowTag := cbDebugLogCommandTag.Checked;
    Main_Form.reLog.LinesType.Log.ShowTag := cbDebugLogOutputTag.Checked;
    Main_Form.reLog.LinesType.State.ShowTag := cbDebugLogStateTag.Checked;
  end;
end;

//------------------------------------------------------------------------------

procedure THighlights_Form.cbDebugLogCommandClick(Sender: TObject);
begin
  bDebugLogCommandFont.Enabled := cbDebugLogCommand.Checked;
  cbDebugLogCommandTag.Enabled := cbDebugLogCommand.Checked;
end;

procedure THighlights_Form.cbDebugLogOutputClick(Sender: TObject);
begin
  bDebugLogOutputFont.Enabled := cbDebugLogOutput.Checked;
  cbDebugLogOutputTag.Enabled := cbDebugLogOutput.Checked;
end;

procedure THighlights_Form.cbDebugLogStateClick(Sender: TObject);
begin
  bDebugLogStateFont.Enabled := cbDebugLogState.Checked;
  cbDebugLogStateTag.Enabled := cbDebugLogState.Checked;
end;

procedure THighlights_Form.bDebugLogCommandFontClick(Sender: TObject);
begin
  with FontDlg do
  begin
    Font := pDebugLogCommand.Font;
    if Execute then pDebugLogCommand.Font := Font;
  end;
end;

procedure THighlights_Form.bDebugLogOutputFontClick(Sender: TObject);
begin
  with FontDlg do
  begin
    Font := pDebugLogOutput.Font;
    if Execute then pDebugLogOutput.Font := Font;
  end;
end;

procedure THighlights_Form.bDebugLogStateFontClick(Sender: TObject);
begin
  with FontDlg do
  begin
    Font := pDebugLogState.Font;
    if Execute then pDebugLogState.Font := Font;
  end;
end;

function THighlights_Form.IsDebugLogConfigModified: boolean;
begin
  Result := cbDebugLogCommand.Checked <> Main_Form.reLog.LinesType.Command.Enabled;
  Result := Result or (cbDebugLogOutput.Checked <> Main_Form.reLog.LinesType.Log.Enabled);
  Result := Result or (cbDebugLogState.Checked <> Main_Form.reLog.LinesType.State.Enabled);
  Result := Result or (cbDebugLogCommandTag.Checked <> Main_Form.reLog.LinesType.Command.ShowTag);
  Result := Result or (cbDebugLogOutputTag.Checked <> Main_Form.reLog.LinesType.Log.ShowTag);
  Result := Result or (cbDebugLogStateTag.Checked <> Main_Form.reLog.LinesType.State.ShowTag);

  Result := Result or (not IsFontEqual(pDebugLogCommand.Font, Main_Form.reLog.LinesType.Command.Font));
  Result := Result or (not IsFontEqual(pDebugLogOutput.Font, Main_Form.reLog.LinesType.Log.Font));
  Result := Result or (not IsFontEqual(pDebugLogState.Font, Main_Form.reLog.LinesType.State.Font));
end;

procedure THighlights_Form.BitBtn4Click(Sender: TObject);
begin
  //Main_Form.seOutputs.Highlighter.Attribute[i].InternalSaveDefaultValues
  
  SaveWindowState;
end;

function THighlights_Form.IsFontEqual(Font1, Font2: TFont): boolean;
begin
  Result := (Font1.Name = Font2.Name)
  and (Font1.PixelsPerInch = Font2.PixelsPerInch)
  and (Font1.Charset = Font2.Charset)
  and (Font1.Color = Font2.Color)
  and (Font1.Height = Font2.Height)
  and (Font1.Pitch = Font2.Pitch)
  and (Font1.Size = Font2.Size)
  and (Font1.Style = Font2.Style);
end;

procedure THighlights_Form.cbGlitterClick(Sender: TObject);
begin
  eGlitDigitCount.Enabled := cbGlitter.Checked;
  eGlitSize.Enabled := cbGlitter.Checked;
  bGlitFont.Enabled := cbGlitter.Checked;
end;

procedure THighlights_Form.cbRightEdgeClick(Sender: TObject);
begin
  cbxReColor.Enabled := cbRightEdge.Checked;
  eRePos.Enabled := cbRightEdge.Checked;
  //bReFont.Enabled := cbRightEdge.Checked;
end;

procedure THighlights_Form.bGlitFontClick(Sender: TObject);
begin
  with FontDlg do
  begin
    Font.Assign(pGlitFontDemo.Font);
    
    if Execute then
      pGlitFontDemo.Font.Assign(Font);
  end;
end;

procedure THighlights_Form.bReFontClick(Sender: TObject);
begin
  with FontDlg do
  begin
    Font.Assign(pReDemo.Font);
    
    if Execute then
      pReDemo.Font.Assign(Font);
  end;
end;

procedure THighlights_Form.clrForeChange(Sender: TObject);
begin
  Main_Form.seOutputs.Highlighter.Attribute[lbKeywords.ItemIndex].Foreground := clrFore.Selected; 
end;

procedure THighlights_Form.clrBackChange(Sender: TObject);
begin
  Main_Form.seOutputs.Highlighter.Attribute[lbKeywords.ItemIndex].Background := clrBack.Selected;
end;

procedure THighlights_Form.cbBoldClick(Sender: TObject);
var
  Curr : TSynHighlighterAttributes;

begin
  Curr := Main_Form.seOutputs.Highlighter.Attribute[lbKeywords.ItemIndex];

  if (Sender as TCheckBox).Checked then
    Curr.Style := Curr.Style + [fsBold]
  else Curr.Style := Curr.Style - [fsBold];
end;

procedure THighlights_Form.cbStrikeOutClick(Sender: TObject);
var
  Curr : TSynHighlighterAttributes;

begin
  Curr := Main_Form.seOutputs.Highlighter.Attribute[lbKeywords.ItemIndex];

  if (Sender as TCheckBox).Checked then
    Curr.Style := Curr.Style + [fsStrikeOut]
  else Curr.Style := Curr.Style - [fsStrikeOut];
end;

procedure THighlights_Form.cbUnderlineClick(Sender: TObject);
var
  Curr : TSynHighlighterAttributes;

begin
  Curr := Main_Form.seOutputs.Highlighter.Attribute[lbKeywords.ItemIndex];

  if (Sender as TCheckBox).Checked then
    Curr.Style := Curr.Style + [fsUnderline]
  else Curr.Style := Curr.Style - [fsUnderline];
end;

procedure THighlights_Form.cbItalicClick(Sender: TObject);
var
  Curr : TSynHighlighterAttributes;

begin
  Curr := Main_Form.seOutputs.Highlighter.Attribute[lbKeywords.ItemIndex];

  if (Sender as TCheckBox).Checked then
    Curr.Style := Curr.Style + [fsItalic]
  else Curr.Style := Curr.Style - [fsItalic];
end;

procedure THighlights_Form.BitBtn1Click(Sender: TObject);
var
  i : integer;
  hg : TSynCustomHighlighter;

begin
  hg := Main_Form.seOutputs.Highlighter;
  for i := 0 to hg.AttrCount - 1 do
    hg.Attribute[i].InternalSaveDefaultValues;
end;

end.
