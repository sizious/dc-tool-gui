object Form1: TForm1
  Left = 198
  Top = 114
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 120
    Top = 56
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 368
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 264
    Top = 264
    Width = 150
    Height = 17
    TabOrder = 2
  end
  object DCTool1: TDCTool
    DosComm.CommandLine = 'gcc'
    DosComm.InputToOutput = False
    DosComm.MaxTimeAfterBeginning = 0
    DosComm.MaxTimeAfterLastOutput = 0
    DosComm.ShowWindow = swHIDE
    DosComm.CreationFlag = fCREATE_NEW_CONSOLE
    DosComm.ReturnCode = rcCRLF
    DosComm.OnNewLine = DCTool1NewLine
    UploadOptions.ExecuteAfterUpload = False
    DownloadOptions.FileSize = 0
    IsoRedirection.Enabled = False
    ChRoot.Enabled = False
    Options.UseDumbTerminal = False
    Options.AttachFileServer = False
    Options.ClrScrBeforeDownload = False
    Serial.ComPort = cpCOM1
    Serial.Baudrate = b57600
    Serial.AlternateBaudrate = False
    ConnectionType = ctSerial
    ProgressBar = ProgressBar1
    OnNewLine = DCTool1NewLine
    Left = 32
    Top = 16
  end
end
