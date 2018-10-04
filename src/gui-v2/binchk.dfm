object BINCheck_Form: TBINCheck_Form
  Left = 227
  Top = 232
  BorderStyle = bsDialog
  Caption = 'BIN Check Module Configuration'
  ClientHeight = 137
  ClientWidth = 408
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
  PixelsPerInch = 96
  TextHeight = 13
  object bOK: TBitBtn
    Left = 8
    Top = 104
    Width = 121
    Height = 25
    Caption = '&OK'
    TabOrder = 0
    OnClick = bOKClick
    Kind = bkOK
  end
  object bCancel: TBitBtn
    Left = 280
    Top = 104
    Width = 121
    Height = 25
    Caption = '&Cancel'
    TabOrder = 1
    Kind = bkCancel
  end
  object gbBINCheckModuleConfiguration: TGroupBox
    Left = 8
    Top = 8
    Width = 393
    Height = 89
    Caption = ' BIN Check Module Configuration : '
    TabOrder = 2
    object rbAskOnlyBeforeUnscrambling: TRadioButton
      Left = 8
      Top = 16
      Width = 377
      Height = 17
      Caption = '&Ask only before unscrambling the BIN if the BIN is scrambled'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbAskAlways: TRadioButton
      Left = 8
      Top = 32
      Width = 377
      Height = 17
      Caption = '&Always confirm the result of BIN detection'
      TabOrder = 1
    end
    object rbDoNotAskAnyThing: TRadioButton
      Left = 8
      Top = 48
      Width = 377
      Height = 17
      Caption = '&Unscramble auto on the BIN directory without prompt'
      TabOrder = 2
    end
    object rbDoNotUseThis: TRadioButton
      Left = 8
      Top = 64
      Width = 377
      Height = 17
      Caption = '&Don'#39't use the BIN check module, thanks'
      TabOrder = 3
    end
  end
end
