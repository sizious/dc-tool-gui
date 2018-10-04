object IPCfg_Form: TIPCfg_Form
  Left = 400
  Top = 313
  BorderStyle = bsDialog
  Caption = 'IP Config'
  ClientHeight = 105
  ClientWidth = 265
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
  object Bevel1: TBevel
    Left = 8
    Top = 64
    Width = 249
    Height = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 49
    Caption = ' Set the IP : '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 114
      Height = 13
      Caption = 'The port 31313 is used.'
    end
    object eIP: TEdit
      Left = 136
      Top = 16
      Width = 105
      Height = 21
      TabOrder = 0
      Text = '000.000.000.000'
    end
  end
  object BitBtn1: TBitBtn
    Left = 104
    Top = 72
    Width = 73
    Height = 25
    Caption = 'O&K'
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 184
    Top = 72
    Width = 73
    Height = 25
    Caption = '&Cancel'
    TabOrder = 2
    Kind = bkCancel
  end
end
