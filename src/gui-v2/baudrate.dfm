object SetBaudrate_Form: TSetBaudrate_Form
  Left = 367
  Top = 321
  BorderStyle = bsDialog
  Caption = 'Set baudrate to'
  ClientHeight = 104
  ClientWidth = 296
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
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Baudrate_Label: TLabel
    Left = 8
    Top = 80
    Width = 6
    Height = 13
    Caption = '7'
    Transparent = False
    Visible = False
  end
  object SetBaudrateToGroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 281
    Height = 57
    Caption = ' Please set the baudrate now : '
    TabOrder = 0
    object SetBaudrateTo: TLabel
      Left = 72
      Top = 27
      Width = 86
      Height = 13
      Alignment = taRightJustify
      Caption = 'Set baudrate to : '
    end
    object Baud_Label: TLabel
      Left = 246
      Top = 27
      Width = 29
      Height = 13
      Caption = 'Bauds'
    end
    object Baudrate: TComboBox
      Left = 160
      Top = 24
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 7
      TabOrder = 0
      Text = '57600'
      Items.Strings = (
        '300'
        '1200'
        '2400'
        '4800'
        '9600'
        '19200'
        '38400'
        '57600'
        '115200')
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
    OnClick = OKButtonClick
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
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
end
