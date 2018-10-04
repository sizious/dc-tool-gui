object History_Form: THistory_Form
  Left = 262
  Top = 233
  BorderStyle = bsDialog
  Caption = 'History manager'
  ClientHeight = 208
  ClientWidth = 489
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
  object gbHistory: TGroupBox
    Left = 8
    Top = 8
    Width = 473
    Height = 161
    Caption = ' History : '
    TabOrder = 0
    object lbHistory: TListBox
      Left = 8
      Top = 16
      Width = 457
      Height = 137
      ItemHeight = 13
      PopupMenu = PopupMenu
      TabOrder = 0
      OnContextPopup = lbHistoryContextPopup
    end
  end
  object bDelete: TBitBtn
    Left = 8
    Top = 176
    Width = 113
    Height = 25
    Caption = '&Delete...'
    TabOrder = 1
    OnClick = bDeleteClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF00FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF00FF00000000008000008000008000008000008000008000
      0080000080000080000080000080000080000000000000FF00FF000000000080
      0000800000800000800000800000800000800000800000800000800000800000
      80000000000000FF00FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object bDeleteAll: TBitBtn
    Left = 128
    Top = 176
    Width = 113
    Height = 25
    Caption = '&Delete all...'
    TabOrder = 2
    OnClick = bDeleteAllClick
    Glyph.Data = {
      26040000424D2604000000000000360000002800000012000000120000000100
      180000000000F003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF5F61725F6172656882656882
      5F6172FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
      FF00FFFF00FF6568824553B91F35DB0E24CC0A1EB74652B064698B6A6A6A5F61
      72FF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FF656882122B
      EB142EF5142EF5142EF5142EF5132DF00E24CC4A56AA656882656882FF00FFFF
      00FFFF00FFFF00FF0000FF00FFFF00FF142EF5142EF5142EF5223BF50F26D60F
      26D60E25D1142EF5142EF50F26D64F5AA76D6D6DFF00FFFF00FFFF00FFFF00FF
      0000FF00FFFF00FF142EF5142EF5142EF5FF00FFFF00FFFF00FFFF00FF223AF5
      142EF5142EF50D22C65F6172656882FF00FFFF00FFFF00FF0000FF00FF142EF5
      142EF50F26D6FF00FFFF00FFFF00FFFF00FF223AF5132DF0142EF5142EF5122B
      EB5760A55F6172FF00FFFF00FFFF00FF0000FF00FF233BF6142EF50F26D6FF00
      FFFF00FFFF00FF223AF5132DF0233BF6FF00FF0F26D6142EF54553B9656882FF
      00FFFF00FFFF00FF0000FF00FF142EF5142EF50F26D6FF00FFFF00FF223AF514
      2EF5233BF6FF00FFFF00FF0F26D6142EF55561BF656882FF00FFFF00FFFF00FF
      0000FF00FF142EF5142EF50E25D1FF00FF223AF5142EF5233BF6FF00FFFF00FF
      FF00FF0F26D6142EF55763BCFF00FFFF00FFFF00FFFF00FF0000FF00FF142EF5
      142EF5142EF5223AF5132DF0233BF6FF00FFFF00FFFF00FFFF00FF142EF5132D
      F0656882FF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF142EF5142EF5142E
      F5132DF0FF00FFFF00FFFF00FFFF00FF233BF6142EF5142EF5FF00FFFF00FFFF
      00FFFF00FFFF00FF0000FF00FFFF00FF142EF5142EF5142EF50F26D60F26D60C
      21C10F26D6142EF5142EF5142EF5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      0000FF00FFFF00FFFF00FF142EF5142EF5142EF5142EF5142EF5142EF5142EF5
      142EF5FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FF
      FF00FFFF00FFFF00FF142EF5142EF5142EF5142EF5FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF0000}
  end
  object bClose: TBitBtn
    Left = 368
    Top = 176
    Width = 113
    Height = 25
    Caption = '&Close'
    ModalResult = 1
    TabOrder = 3
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object bClear: TBitBtn
    Left = 248
    Top = 176
    Width = 113
    Height = 25
    Caption = '&Clean...'
    TabOrder = 4
    OnClick = bClearClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      1800000000000006000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF6B6B6B6B6B6B6B6B6B6666666B6B6B6B6B6BFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6B6B6B6B6B6B6B66
      66666B6B6B6B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF6B6B6BD3D3B9D0C3A5D0C3A5D0C3A5A8A89770706F6B6B6BFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6BCBCBCBBBBBBBBBBBBBBB
      BBBBA3A3A37070706B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      6B6B6BFFF6D2FFE7BEF5D5B2DDB9B0E4BBBBEBC5ADFFE8BFE2DEC36B6B6B6464
      62FF00FFFF00FFFF00FFFF00FFFF00FF6B6B6BECECECDDDDDDCECECEBABABAC0
      C0C0C2C2C2DEDEDED6D6D66B6B6B636363FF00FFFF00FFFF00FFFF00FFFF00FF
      EBC5ADF9EFC4FBDFBBE2C4C4E7D0D0009900BFE4B5BFE4B5BFE4B5FFFCDAB8B8
      A46B6B6BFF00FFFF00FFFF00FFFF00FFC2C2C2E3E3E3D7D7D7C7C7C7D3D3D35A
      5A5AD2D2D2D2D2D2D2D2D2F2F2F2B2B2B26B6B6BFF00FFFF00FFFF00FFFF00FF
      E5C293F8C899EEDDDDE7D0D0E7D0D00099000099000099000099009FD79EFFEC
      C46B6B6BFF00FFFF00FFFF00FFFF00FFB8B8B8BFBFBFDFDFDFD3D3D3D3D3D35A
      5A5A5A5A5A5A5A5A5A5A5AC0C0C0E2E2E26B6B6BFF00FFFF00FFFF00FFFF00FF
      F9C48AFDF5EBF6ECECEBD8D8DFB3B300990000990050B950CFE3CA40B340FAD1
      9C7D7D7BFF00FFFF00FFFF00FFFF00FFB8B8B8F3F3F3EDEDEDDADADAB8B8B85A
      5A5A5A5A5A8E8E8ED9D9D9848484C6C6C67C7C7CFF00FFFF00FFFF00FFECD9CF
      FBDFBBFFFFFEFFFFFFD6ACABE4BBBB8FD28FBFE4B540B340AFDDABAFDDABD1C0
      9E9191856B6B6BFF00FFFF00FFD8D8D8D7D7D7FFFFFFFFFFFFB0B0B0C0C0C0B7
      B7B7D2D2D2848484C9C9C9C9C9C9B8B8B88D8D8D6B6B6BFF00FFFF00FFEFDEB3
      FEF8DDFFFFF5EBD8D8D0A2A2E4BBBB40B340FFFFF570C670009900009900FFE0
      B39191856B6B6BFF00FFFF00FFD3D3D3F1F1F1FCFCFCDADADAA7A7A7C0C0C084
      8484FCFCFCA3A3A35A5A5A5A5A5AD6D6D68D8D8D6B6B6BFF00FFFF00FFFBDFBB
      FFFFE9FFFFEDECD9CFE7D0D0E5CAC5B8B8A4109F1029A929009900009900FFEA
      C1D0C3A56B6B6BFF00FFFF00FFD7D7D7F8F8F8FAFAFAD8D8D8D3D3D3CBCBCBB2
      B2B26464647575755A5A5A5A5A5AE0E0E0BBBBBB6B6B6BFF00FFFF00FFFBDFBB
      FFFFDEFFFFE2FFFFE6FFFFEAE7F8FEF2E6E6AFDDAB9FD79E70C670009900FEF4
      DAD1CCB06B6B6BFF00FFFF00FFD7D7D7F5F5F5F6F6F6F8F8F8F9F9F9F8F8F8E7
      E7E7C9C9C9C0C0C0A3A3A35A5A5AEDEDEDC4C4C46B6B6BFF00FFFF00FFFBDFBB
      FFFFDEFFFFDEFFFFE2E2FFF7E2FFF7DFFEFAFDF9F9FDF9F9FFFFFDFFFFF3FFFF
      EFFFFFDE6B6B6BFF00FFFF00FFD7D7D7F5F5F5F5F5F5F6F6F6F9F9F9F9F9F9F9
      F9F9F9F9F9F9F9F9FEFEFEFBFBFBFAFAFAF5F5F56B6B6BFF00FFFF00FFFF00FF
      FBDFBBFBDFBBDCEFD3DCEFD3DCEFD3DCEFD3DCEFD3DCEFD3E3F2F2FAE4B6FFFA
      D8FFFFDE6B6B6BFF00FFFF00FFFF00FFD7D7D7D7D7D7E5E5E5E5E5E5E5E5E5E5
      E5E5E5E5E5E5E5E5F0F0F0D9D9D9F0F0F0F5F5F56B6B6BFF00FFFF00FFFF00FF
      FF00FFFF00FFA3DDFAE6FFFFDBFFFFDBFFFFDBFFFFE6FFFFA7DEF7F9C389FFCC
      99FFF4CF6B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFDFDFDFFCFCFCFBFBFBFB
      FBFBFBFBFBFCFCFCDFDFDFB8B8B8C2C2C2EAEAEA6B6B6BFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFA7DEF7A7DEF7A7DEF7C0FFFFC0FFFFA7DEF7FCC790FECA
      96FFD09E6B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFDFDFDFDFDFDFDF
      DFDFF8F8F8F8F8F8DFDFDFBCBCBCC0C0C0C6C6C66B6B6BFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7DEF7A7DEF7A7DEF7FECA96FDC8
      92FDC892FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFDFDFDFDFDFDFDFDFDFC0C0C0BEBEBEBEBEBEFF00FFFF00FF}
    NumGlyphs = 2
  end
  object PopupMenu: TPopupMenu
    Images = ImageList
    OwnerDraw = True
    Left = 24
    Top = 32
    object Delete1: TMenuItem
      Caption = '&Delete...'
      ImageIndex = 0
      OnClick = bDeleteClick
    end
    object Deleteall1: TMenuItem
      Caption = '&Delete all...'
      ImageIndex = 2
      OnClick = bDeleteAllClick
    end
    object Clean1: TMenuItem
      Caption = '&Clean...'
      ImageIndex = 1
      OnClick = bClearClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
  end
  object ImageList: TImageList
    Left = 56
    Top = 32
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B6B6B006B6B6B006B6B6B00666666006B6B6B006B6B6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005F6172005F61720065688200656882005F6172000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B6B
      6B00D3D3B900D0C3A500D0C3A500D0C3A500A8A8970070706F006B6B6B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000656882004553B9001F35DB000E24CC000A1EB7004652B00064698B006A6A
      6A005F6172000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B00FFF6
      D200FFE7BE00F5D5B200DDB9B000E4BBBB00EBC5AD00FFE8BF00E2DEC3006B6B
      6B00646462000000000000000000000000000000000000000000000000006568
      8200122BEB00142EF500142EF500142EF500142EF500132DF0000E24CC004A56
      AA00656882006568820000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EBC5AD00F9EF
      C400FBDFBB00E2C4C400E7D0D00000990000BFE4B500BFE4B500BFE4B500FFFC
      DA00B8B8A4006B6B6B0000000000000000000000000000000000142EF500142E
      F500142EF500223BF5000F26D6000F26D6000E25D100142EF500142EF5000F26
      D6004F5AA7006D6D6D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E5C29300F8C8
      9900EEDDDD00E7D0D000E7D0D000009900000099000000990000009900009FD7
      9E00FFECC4006B6B6B0000000000000000000000000000000000142EF500142E
      F500142EF50000000000000000000000000000000000223AF500142EF500142E
      F5000D22C6005F61720065688200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F9C48A00FDF5
      EB00F6ECEC00EBD8D800DFB3B300009900000099000050B95000CFE3CA0040B3
      4000FAD19C007D7D7B00000000000000000000000000142EF500142EF5000F26
      D60000000000000000000000000000000000223AF500132DF000142EF500142E
      F500122BEB005760A5005F617200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      8000000080000000800000008000000080000000800000008000000080000000
      80000000800000000000000000000000000000000000ECD9CF00FBDFBB00FFFF
      FE00FFFFFF00D6ACAB00E4BBBB008FD28F00BFE4B50040B34000AFDDAB00AFDD
      AB00D1C09E00919185006B6B6B000000000000000000233BF600142EF5000F26
      D600000000000000000000000000223AF500132DF000233BF600000000000F26
      D600142EF5004553B90065688200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008000000080000000
      8000000080000000800000008000000080000000800000008000000080000000
      80000000800000000000000000000000000000000000EFDEB300FEF8DD00FFFF
      F500EBD8D800D0A2A200E4BBBB0040B34000FFFFF50070C67000009900000099
      0000FFE0B300919185006B6B6B000000000000000000142EF500142EF5000F26
      D6000000000000000000223AF500142EF500233BF60000000000000000000F26
      D600142EF5005561BF0065688200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBDFBB00FFFFE900FFFF
      ED00ECD9CF00E7D0D000E5CAC500B8B8A400109F100029A92900009900000099
      0000FFEAC100D0C3A5006B6B6B000000000000000000142EF500142EF5000E25
      D10000000000223AF500142EF500233BF6000000000000000000000000000F26
      D600142EF5005763BC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBDFBB00FFFFDE00FFFF
      E200FFFFE600FFFFEA00E7F8FE00F2E6E600AFDDAB009FD79E0070C670000099
      0000FEF4DA00D1CCB0006B6B6B000000000000000000142EF500142EF500142E
      F500223AF500132DF000233BF60000000000000000000000000000000000142E
      F500132DF0006568820000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBDFBB00FFFFDE00FFFF
      DE00FFFFE200E2FFF700E2FFF700DFFEFA00FDF9F900FDF9F900FFFFFD00FFFF
      F300FFFFEF00FFFFDE006B6B6B00000000000000000000000000142EF500142E
      F500142EF500132DF00000000000000000000000000000000000233BF600142E
      F500142EF5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FBDFBB00FBDF
      BB00DCEFD300DCEFD300DCEFD300DCEFD300DCEFD300DCEFD300E3F2F200FAE4
      B600FFFAD800FFFFDE006B6B6B00000000000000000000000000142EF500142E
      F500142EF5000F26D6000F26D6000C21C1000F26D600142EF500142EF500142E
      F500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A3DDFA00E6FFFF00DBFFFF00DBFFFF00DBFFFF00E6FFFF00A7DEF700F9C3
      8900FFCC9900FFF4CF006B6B6B0000000000000000000000000000000000142E
      F500142EF500142EF500142EF500142EF500142EF500142EF500142EF5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A7DEF700A7DEF700A7DEF700C0FFFF00C0FFFF00A7DEF700FCC7
      9000FECA9600FFD09E006B6B6B00000000000000000000000000000000000000
      000000000000142EF500142EF500142EF500142EF50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7DEF700A7DEF700A7DEF700FECA
      9600FDC89200FDC8920000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFF03FFC1F0000
      FFFFE01FF0070000FFFFC007E0030000FFFFC003C00300008001C003C7810000
      0001C0038F010000000180018E210000000180018C6100000003800188E30000
      FFFF800181E30000FFFF8001C3C70000FFFFC001C00F0000FFFFF001E01F0000
      FFFFF801F87F0000FFFFFF03FFFF000000000000000000000000000000000000
      000000000000}
  end
  object XPMenu: TXPMenu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Color = clWhite
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clBtnFace
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = False
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = True
    Active = True
    Left = 88
    Top = 32
  end
end