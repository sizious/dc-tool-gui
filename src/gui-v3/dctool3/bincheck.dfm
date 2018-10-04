object BinCheck_Form: TBinCheck_Form
  Left = 329
  Top = 303
  BorderStyle = bsDialog
  Caption = 'BIN Check detection module config'
  ClientHeight = 137
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bOK: TBitBtn
    Left = 8
    Top = 104
    Width = 121
    Height = 25
    Caption = '&OK'
    TabOrder = 0
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
  object rgBinCheck: TRadioGroup
    Left = 8
    Top = 8
    Width = 393
    Height = 89
    Caption = ' BIN Check Module Configuration : '
    ItemIndex = 0
    Items.Strings = (
      '&Ask only before unscrambling the BIN if the BIN is scrambled'
      'A&lways confirm the result of BIN detection'
      '&Unscramble auto on the BIN directory without prompt'
      '&Don'#39't use the BIN check module, thanks')
    TabOrder = 2
  end
end
