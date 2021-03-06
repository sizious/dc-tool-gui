object Download_Form: TDownload_Form
  Left = 310
  Top = 285
  BorderStyle = bsDialog
  Caption = 'Download a file from the dreamcast'
  ClientHeight = 105
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FileName_Label: TLabel
    Left = 128
    Top = 72
    Width = 49
    Height = 13
    Caption = 'FILENAME'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object FileInfo_GroupBox: TGroupBox
    Left = 8
    Top = 8
    Width = 430
    Height = 57
    Caption = ' Parameters : '
    TabOrder = 0
    object Input_Label: TLabel
      Left = 4
      Top = 23
      Width = 82
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Output file:'
    end
    object Output_Edit: TComboBox
      Left = 88
      Top = 20
      Width = 305
      Height = 21
      ItemHeight = 13
      TabOrder = 0
    end
    object InputFile_SpeedButton: TBitBtn
      Left = 396
      Top = 19
      Width = 23
      Height = 21
      TabOrder = 1
      OnClick = InputFile_SpeedButtonClick
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF10779F10779F10779F10779F10779F10779F10779F10779F10779F1077
        9FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF77777777777777777777777777
        7777777777777777777777777777777777FF00FFFF00FFFF00FFFF00FFFF00FF
        1097BF1097BF1097BF1097BF1097BF1097BF1097BF1097BF1097BF1097BF1097
        BF10779FFF00FFFF00FFFF00FFFF00FF94949494949494949494949494949494
        9494949494949494949494949494949494777777FF00FFFF00FFFF00FF1098C0
        1098C09FFFFF60D7FF60D7FF60D7FF60D7FF60D7FF60D7FF60D7FF60D7FF60D7
        FF2097BF0F70A0FF00FFFF00FF959595959595F4F4F4D5D5D5D5D5D5D5D5D5D5
        D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5D5959595737373FF00FFFF00FF1098C0
        1098C070E0EF9FFFFF70E0FF70E0FF70E0FF70E0FF70E0FF70E0FF70E0FF70DF
        FF3FB0DF0F70A0FF00FFFF00FF959595959595D8D8D8F4F4F4DCDCDCDCDCDCDC
        DCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCB1B1B1737373FF00FFFF00FF1098C0
        20A0CF3FB7D09FFFFF80E8FF80E8FF80E8FF80E8FF80E8FF80E8FF80E8FF80E7
        FF3FB8EF0F70A0FF00FFFF00FF959595A0A0A0B1B1B1F4F4F4E3E3E3E3E3E3E3
        E3E3E3E3E3E3E3E3E3E3E3E3E3E3E2E2E2BBBBBB737373FF00FFFF00FF1098C0
        3FB0DF1F9FC0A0FFFF90F7FF90F7FF90F7FF90F7FF90F7FF90F7FF90F7FF90F7
        FF4FBFE050B8CF0F70A0FF00FF959595B1B1B19A9A9AF4F4F4EEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEBCBCBCB3B3B3737373FF00FF1098C0
        6FD0FF1098C080EFF09FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFFFF9FFF
        FF50C7FF90F7F00F70A0FF00FF959595D3D3D3959595E3E3E3F4F4F4F4F4F4F4
        F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4CACACAE9E9E9737373FF00FF1098C0
        80D7FF1098C060BFD0FFFFFFFFFFFFF0F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF80E7FFFFFFFF0F70A0FF00FF959595D9D9D9959595B9B9B9FFFFFFFFFFFFF9
        F9F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2E2E2FFFFFF737373FF00FF1098C0
        80E8FF4FBFDF1098C01098C01098C01098C01098C01098C01098C01098C01098
        C01098C01098C00F70A0FF00FF959595E3E3E3BCBCBC95959595959595959595
        9595959595959595959595959595959595959595959595737373FF00FF1098C0
        9FF0FF8FF0FF8FF0FF8FF0FF8FF0FF8FF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF1098C010789FFF00FFFF00FF959595EBEBEBE9E9E9E9E9E9E9E9E9E9E9E9E9
        E9E9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF959595787878FF00FFFF00FF1098C0
        FFFFFF9FFFFF9FFFFF9FFFFF9FFFFFFFFFFF1098C01098C01098C01098C01098
        C01098C0FF00FFFF00FFFF00FF959595FFFFFFF4F4F4F4F4F4F4F4F4F4F4F4FF
        FFFF959595959595959595959595959595959595FF00FFFF00FFFF00FFFF00FF
        1FA0CFFFFFFFFFFFFFFFFFFFFFFFFF1098C0FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9F9FFFFFFFFFFFFFFFFFFFFFFFFF95
        9595FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF1FA0CF1FA0CF1FA0CF1FA0CFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9F9F9F9F9F9F9F9F9F9F9FFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 2
    end
  end
  object SetSizeBtn: TBitBtn
    Left = 8
    Top = 72
    Width = 115
    Height = 25
    Caption = '&Set Size...'
    TabOrder = 1
    OnClick = SetSizeBtnClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      1800000000000006000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF004152004152004152004152004152004152FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3F3F3F3F3F3F3F3F3F3F
      3F3F3F3F3F3F3F3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF004152
      004152004152006C820092AC009EB9009EB9009EB9009EB90041524A270FFF00
      FFFF00FFFF00FFFF00FFFF00FF3F3F3F3F3F3F3F3F3F6767678A8A8A95959595
      95959595959595953F3F3F242424FF00FFFF00FFFF00FFFF00FFFF00FF004152
      0098B2009EB9009EB9009EB9009EB9009EB9009EB9009EB90041525A2F124A27
      0F4A270FFF00FFFF00FFFF00FF3F3F3F8F8F8F95959595959595959595959595
      95959595959595953F3F3F2B2B2B242424242424FF00FFFF00FFFF00FF004152
      008EA7009EB9009EB9009EB9009EB90099B30091AA0072870041526B38157C41
      186B38154A270FFF00FFFF00FF3F3F3F86868695959595959595959595959590
      90908989896C6C6C3F3F3F3333333B3B3B333333242424FF00FF5A2F12525143
      00799100879F006377004D5F004D5F004D5F004A5C0041522135336B38157C41
      188C491B7B40184A270F2B2B2B4D4D4D7373737F7F7F5E5E5E4A4A4A4A4A4A4A
      4A4A4747473F3F3F3232323333333B3B3B4343433A3A3A2424245A2F12845F3F
      00415200586C0A95AD21B9CC42E8F54BF4FF4BF4FF45CFD72534314A270F6B38
      158C491B8C491B4A270F2B2B2B5959593F3F3F5454548D8D8DAEAEAEDADADAE5
      E5E5E5E5E5C2C2C23131312424243333334343434343432424245A2F12A46032
      2D3D382EA4B33FE4F54BF4FF47F0FF44EDFF4DEBF654A3A0305556834F2D4A27
      0F4A270F7C41184A270F2B2B2B5A5A5A3A3A3A9C9C9CD7D7D7E5E5E5E2E2E2E0
      E0E0DDDDDD9999995151514B4B4B2424242424243B3B3B2424245A2F126B3815
      A5673E004D5F3FA7B23CE6FF3CE6FF3CE6FF4ADEED004D5FAE805CFCAB79DC92
      629D643E4A270F4A270F2B2B2B3333336262624A4A4A9F9F9FDBDBDBDBDBDBDB
      DBDBD2D2D24A4A4A7A7A7AA5A5A58C8C8C5F5F5F2424242424245A2F12AA693E
      E99965C88153004D5F3FA7B229D6EF29D6EF4AACB3565C4FE89A69FCAB79FCAB
      79FCAB79AA6E454A270F2B2B2B6363639292927B7B7B4A4A4A9F9F9FCACACACA
      CACAA3A3A3575757949494A5A5A5A5A5A5A5A5A56868682424246B3815D78954
      E99965E99965C57F50004A5B3FA7B233C1D4004D5FC17C4FF3A26FF3A26FFCAB
      79FCAB79EA9D6E5B30123333338282829292929292927979794747479F9F9FB7
      B7B74A4A4A7676769C9C9C9C9C9CA5A5A5A5A5A59797972C2C2C7B4018C47946
      E99965E99965E99965C37D4D0047583FA7B2565C4FDA8F5FF3A26FF3A26FF3A2
      6FFCAB79FCAB796B38153A3A3A7272729292929292929292927676764444449F
      9F9F5757578989899C9C9C9C9C9C9C9C9CA5A5A5A5A5A53333338C491BA86131
      E0915BE99965E99965E99965C37D4D004152CE8452E99965E99965F3A26FF3A2
      6FF1A16EC67A498C491B4343435A5A5A8989899292929292929292927676763F
      3F3F7D7D7D9292929292929C9C9C9C9C9C9B9B9B747474434343FF00FF8C491B
      A86131D28551E0915BE99965E99965BC7849E99965E99965E99965E99965E192
      5FB36B3B8C491BFF00FFFF00FF4343435A5A5A7E7E7E89898992929292929271
      71719292929292929292929292928B8B8B656565434343FF00FFFF00FFFF00FF
      8C491B8C491BB66D3BCD814DE0915BE0915BE0915BE0915BCD814DB66D3B8C49
      1B8C491BFF00FFFF00FFFF00FFFF00FF4343434343436666667A7A7A89898989
      89898989898989897A7A7A666666434343434343FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF8C491B8C491B8C491B8C491B8C491B8C491B8C491B8C491BFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF43434343434343434343
      4343434343434343434343434343FF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  object OK: TBitBtn
    Left = 200
    Top = 72
    Width = 115
    Height = 25
    Caption = '&Download'
    TabOrder = 2
    OnClick = OKClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      1800000000000006000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF3B653728341DFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF53
      53532C2C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FF3B65373FCC423E973D28341DFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF53535393
      93937272722C2C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF3B65373FCC4273FD7644C6463E973D28341DFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF535353939393C5
      C5C59191917272722C2C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF3B65373ED640BCFEBE55DD573FCC423FBA413E973D28341DFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF535353989898E4E4E4A6
      A6A69393938888887272722C2C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF3B65373ED640FFFFFF5DE45F3FCC423FCC423FCC423FBA413E973D2834
      1DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF535353989898FFFFFFADADAD93
      93939393939393938888887272722C2C2CFF00FFFF00FFFF00FFFF00FFFF00FF
      3B65373ED640C9FFCA61E9633FCC423FCC423FCC423FCC423FCC423FBA413E97
      3D28341DFF00FFFF00FFFF00FFFF00FF535353989898E9E9E9B2B2B293939393
      93939393939393939393938888887272722C2C2CFF00FFFF00FFFF00FF3B6537
      3ED64084FE873FFC433FFC433FFC433FCC423FCC423FCC423E973D3E973D3E97
      3D3E973D28341DFF00FFFF00FF535353989898CDCDCDB0B0B0B0B0B0B0B0B093
      93939393939393937272727272727272727272722C2C2CFF00FF3B65373B6537
      3B65373B65373B65373ED6403FFC433FCC423FCC423FCC423E973D28341D2834
      1D28341D28341D28341D535353535353535353535353535353989898B0B0B093
      93939393939393937272722C2C2C2C2C2C2C2C2C2C2C2C2C2C2CFF00FFFF00FF
      FF00FFFF00FF3B65373ED6403FFC433FCC423FCC423FCC423E973D28341DFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF535353989898B0B0B093
      93939393939393937272722C2C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF3B65373ED6403FFC433FCC423FCC423FCC423E973D28341DFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF535353989898B0B0B093
      93939393939393937272722C2C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF3B65373ED6403FFC433FCC423FCC423FCC423E973D28341DFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF535353989898B0B0B093
      93939393939393937272722C2C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF3B65373ED6403FCC423E973D3E973D3E973D3E973D28341DFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF53535398989893939372
      72727272727272727272722C2C2CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF3B65373B65373B65373B65373B65373B65373B6537324D2AFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF53535353535353535353
      5353535353535353535353404040FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  object Cancel: TBitBtn
    Left = 320
    Top = 72
    Width = 115
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      1800000000000006000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FF5F61725F61726568826568825F6172FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF65656565
      65656F6F6F6F6F6F656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF6568824553B91F35DB0E24CC0A1EB74652B064698B6A6A6A5F61
      72FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6F6F6F70707064646453
      53534949496C6C6C7272726A6A6A656565FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF656882122BEB142EF5142EF5142EF5142EF5132DF00E24CC4A56AA6568
      82656882FF00FFFF00FFFF00FFFF00FFFF00FF6F6F6F61616166666666666666
      66666666666464645353536D6D6D6F6F6F6F6F6FFF00FFFF00FFFF00FFFF00FF
      142EF5142EF5142EF5223BF50F26D60F26D60E25D1142EF5142EF50F26D64F5A
      A76D6D6DFF00FFFF00FFFF00FFFF00FF66666666666666666670707058585858
      58585656566666666666665858586F6F6F6D6D6DFF00FFFF00FFFF00FFFF00FF
      142EF5142EF5142EF5FF00FFFF00FFFF00FFFF00FF223AF5142EF5142EF50D22
      C65F6172656882FF00FFFF00FFFF00FF666666666666666666FF00FFFF00FFFF
      00FFFF00FF6F6F6F6666666666665050506565656F6F6FFF00FFFF00FF142EF5
      142EF50F26D6FF00FFFF00FFFF00FFFF00FF223AF5132DF0142EF5142EF5122B
      EB5760A55F6172FF00FFFF00FF666666666666585858FF00FFFF00FFFF00FFFF
      00FF6F6F6F646464666666666666616161737373656565FF00FFFF00FF233BF6
      142EF50F26D6FF00FFFF00FFFF00FF223AF5132DF0233BF6FF00FF0F26D6142E
      F54553B9656882FF00FFFF00FF707070666666585858FF00FFFF00FFFF00FF6F
      6F6F646464707070FF00FF5858586666667070706F6F6FFF00FFFF00FF142EF5
      142EF50F26D6FF00FFFF00FF223AF5142EF5233BF6FF00FFFF00FF0F26D6142E
      F55561BF656882FF00FFFF00FF666666666666585858FF00FFFF00FF6F6F6F66
      6666707070FF00FFFF00FF5858586666667B7B7B6F6F6FFF00FFFF00FF142EF5
      142EF50E25D1FF00FF223AF5142EF5233BF6FF00FFFF00FFFF00FF0F26D6142E
      F55763BCFF00FFFF00FFFF00FF666666666666565656FF00FF6F6F6F66666670
      7070FF00FFFF00FFFF00FF5858586666667C7C7CFF00FFFF00FFFF00FF142EF5
      142EF5142EF5223AF5132DF0233BF6FF00FFFF00FFFF00FFFF00FF142EF5132D
      F0656882FF00FFFF00FFFF00FF6666666666666666666F6F6F646464707070FF
      00FFFF00FFFF00FFFF00FF6666666464646F6F6FFF00FFFF00FFFF00FFFF00FF
      142EF5142EF5142EF5132DF0FF00FFFF00FFFF00FFFF00FF233BF6142EF5142E
      F5FF00FFFF00FFFF00FFFF00FFFF00FF666666666666666666646464FF00FFFF
      00FFFF00FFFF00FF707070666666666666FF00FFFF00FFFF00FFFF00FFFF00FF
      142EF5142EF5142EF50F26D60F26D60C21C10F26D6142EF5142EF5142EF5FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF6666666666666666665858585858584E
      4E4E585858666666666666666666FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF142EF5142EF5142EF5142EF5142EF5142EF5142EF5142EF5FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF66666666666666666666666666
      6666666666666666666666FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF142EF5142EF5142EF5142EF5FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF66666666666666
      6666666666FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    NumGlyphs = 2
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'bin'
    Filter = 'Binary files (*.bin)|*.bin|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save file from the dreamcast to'
    Left = 16
    Top = 24
  end
end
