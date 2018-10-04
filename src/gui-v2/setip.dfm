object IP_Form: TIP_Form
  Left = 329
  Top = 323
  BorderStyle = bsDialog
  Caption = 'Set IP address'
  ClientHeight = 104
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PleaseSetTheNewAddressNowGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 57
    Caption = ' Set the IP address to communicate with the DC here : '
    TabOrder = 0
    object EnterIPAdress: TLabel
      Left = 11
      Top = 28
      Width = 90
      Height = 13
      Alignment = taRightJustify
      Caption = 'Enter IP address : '
    end
    object DefBtn: TButton
      Left = 208
      Top = 24
      Width = 65
      Height = 21
      Caption = 'Default'
      TabOrder = 0
      OnClick = DefBtnClick
    end
    object eIP: TEdit
      Left = 104
      Top = 24
      Width = 97
      Height = 21
      MaxLength = 15
      TabOrder = 1
      Text = '000.000.000.000'
    end
  end
  object OKButton: TBitBtn
    Left = 72
    Top = 72
    Width = 105
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object Cancel_Button: TBitBtn
    Left = 184
    Top = 72
    Width = 105
    Height = 25
    Caption = '&Cancel'
    TabOrder = 2
    Kind = bkCancel
  end
end
