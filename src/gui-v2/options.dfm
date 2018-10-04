object Options_Form: TOptions_Form
  Left = 141
  Top = 198
  BorderStyle = bsDialog
  Caption = 'Options : '
  ClientHeight = 137
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 425
    Height = 89
    Caption = ' Options : '
    TabOrder = 0
    object cbAllowLongFileNames: TCheckBox
      Left = 8
      Top = 64
      Width = 409
      Height = 17
      Caption = '&Allow long files name in debug view'
      Enabled = False
      TabOrder = 0
    end
    object cbHideSplashForm: TCheckBox
      Left = 8
      Top = 32
      Width = 409
      Height = 17
      Caption = '&Disable the startup Splash Screen'
      TabOrder = 1
    end
    object cbDisableAutoExpandTree: TCheckBox
      Left = 8
      Top = 48
      Width = 409
      Height = 17
      Caption = '&Disable auto-expand tree after operation'
      TabOrder = 2
    end
    object cbWarnIfAddressNotDefault: TCheckBox
      Left = 8
      Top = 16
      Width = 409
      Height = 17
      Caption = 
        '&Disable warning if the address isn'#39't set at 0x8C10000 for uploa' +
        'd'
      TabOrder = 3
    end
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 104
    Width = 121
    Height = 25
    Caption = '&OK'
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 312
    Top = 104
    Width = 121
    Height = 25
    Caption = '&Cancel'
    TabOrder = 2
    Kind = bkCancel
  end
end
