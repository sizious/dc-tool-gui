object Address_Form: TAddress_Form
  Left = 352
  Top = 289
  BorderStyle = bsDialog
  Caption = 'Set address to'
  ClientHeight = 104
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Address_Label: TLabel
    Left = 8
    Top = 72
    Width = 70
    Height = 13
    Caption = 'Address_Label'
    Transparent = False
    Visible = False
  end
  object PleaseSetTheNewAddressNowGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 57
    Caption = ' Please set the new address now : '
    TabOrder = 0
    object Address: TLabeledEdit
      Left = 120
      Top = 24
      Width = 81
      Height = 21
      EditLabel.Width = 77
      EditLabel.Height = 13
      EditLabel.Caption = 'Set address to :'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = '0x8C010000'
      OnKeyPress = AddressKeyPress
    end
    object DefBtn: TButton
      Left = 208
      Top = 24
      Width = 65
      Height = 21
      Caption = 'Default'
      TabOrder = 1
      OnClick = DefBtnClick
    end
  end
  object OKButton: TBitBtn
    Left = 72
    Top = 72
    Width = 105
    Height = 25
    Caption = '&OK'
    TabOrder = 1
    OnClick = OKButtonClick
    Kind = bkOK
  end
  object Cancel_Button: TBitBtn
    Left = 184
    Top = 72
    Width = 105
    Height = 25
    Caption = '&Cancel'
    TabOrder = 2
    OnClick = Cancel_ButtonClick
    Kind = bkCancel
  end
end
