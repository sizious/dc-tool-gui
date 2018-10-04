object Add_Form: TAdd_Form
  Left = 321
  Top = 318
  BorderStyle = bsDialog
  Caption = 'Item manager'
  ClientHeight = 95
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbQuestion: TGroupBox
    Left = 8
    Top = 8
    Width = 345
    Height = 49
    Caption = ' Question : '
    TabOrder = 0
    object eResp: TEdit
      Left = 8
      Top = 16
      Width = 329
      Height = 21
      TabOrder = 0
    end
  end
  object bAccept: TBitBtn
    Left = 8
    Top = 64
    Width = 97
    Height = 25
    Caption = '&Accept'
    TabOrder = 1
    OnClick = bAcceptClick
    Kind = bkOK
  end
  object bAbort: TBitBtn
    Left = 256
    Top = 64
    Width = 97
    Height = 25
    Caption = '&Abort'
    TabOrder = 2
    Kind = bkCancel
  end
end
