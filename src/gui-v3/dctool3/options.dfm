object Options_Form: TOptions_Form
  Left = 323
  Top = 225
  BorderStyle = bsDialog
  Caption = 'Misc options'
  ClientHeight = 296
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 256
    Width = 385
    Height = 2
  end
  object pcOptions: TPageControl
    Left = 8
    Top = 8
    Width = 385
    Height = 241
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = '&General'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 361
        Height = 73
        Caption = ' General Options : '
        TabOrder = 0
        object CheckBox4: TCheckBox
          Left = 8
          Top = 32
          Width = 321
          Height = 17
          Caption = '&Prompt when application is closed'
          Enabled = False
          TabOrder = 0
        end
        object CheckBox5: TCheckBox
          Left = 8
          Top = 48
          Width = 321
          Height = 17
          Caption = 'P&rompt when the application is closed but still a transfert'
          Enabled = False
          TabOrder = 1
        end
        object cbxShowSplash: TCheckBox
          Left = 8
          Top = 16
          Width = 305
          Height = 17
          Caption = '&Show splash screen at start-up'
          TabOrder = 2
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 88
        Width = 361
        Height = 121
        Caption = ' Shell integration : '
        TabOrder = 1
        object cbRegisterBinariesMenus: TCheckBox
          Left = 8
          Top = 32
          Width = 345
          Height = 17
          Caption = '&Include this app in the context menu for binaries'
          TabOrder = 0
          OnClick = cbRegisterBinariesMenusClick
        end
        object cbRegisterBinariesExts: TCheckBox
          Left = 8
          Top = 16
          Width = 345
          Height = 17
          Caption = 'Cre&ate raw binaries and sh-elf files type extensions in Windows'
          TabOrder = 1
          OnClick = cbRegisterBinariesExtsClick
        end
        object cbRegisterPresetsExts: TCheckBox
          Left = 8
          Top = 64
          Width = 345
          Height = 17
          Caption = 'C&reate upload and download presets extensions in Windows'
          TabOrder = 2
          OnClick = cbRegisterPresetsExtsClick
        end
        object cbRegisterPresetsMenus: TCheckBox
          Left = 8
          Top = 80
          Width = 345
          Height = 17
          Caption = 'I&nclude this app in the context menu for presets'
          TabOrder = 3
          OnClick = cbRegisterPresetsMenusClick
        end
        object cbBinExec: TCheckBox
          Left = 24
          Top = 48
          Width = 329
          Height = 17
          Caption = '&Prompt before proceed'
          Enabled = False
          TabOrder = 4
        end
        object cbPrtExec: TCheckBox
          Left = 24
          Top = 96
          Width = 329
          Height = 17
          Caption = 'P&rompt before proceed'
          Enabled = False
          TabOrder = 5
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Defaults'
      ImageIndex = 1
      OnShow = TabSheet2Show
      object rgUploadTabs: TRadioGroup
        Left = 8
        Top = 8
        Width = 177
        Height = 73
        Caption = ' Upload tabs : '
        ItemIndex = 0
        Items.Strings = (
          '&Open "Target File" tab'
          'O&pen "Preset" tab'
          '&Keep the tab...')
        TabOrder = 0
      end
      object rgDownloadTabs: TRadioGroup
        Left = 192
        Top = 8
        Width = 177
        Height = 73
        Caption = ' Download tabs : '
        ItemIndex = 0
        Items.Strings = (
          'Open "Target File" ta&b'
          'Ope&n "Preset" tab'
          'Ke&ep the tab...')
        TabOrder = 1
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 136
        Width = 361
        Height = 73
        Caption = ' Default transfert working directory : '
        TabOrder = 2
        object Label1: TLabel
          Left = 8
          Top = 20
          Width = 328
          Height = 13
          Caption = 
            'If you add a new path, it won'#39't be saved on the Working Dir hist' +
            'ory.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object cbxWorkDir: TComboBox
          Left = 8
          Top = 40
          Width = 313
          Height = 21
          ItemHeight = 13
          TabOrder = 0
        end
        object bWorkDir: TBitBtn
          Left = 328
          Top = 40
          Width = 25
          Height = 21
          TabOrder = 1
          OnClick = bWorkDirClick
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
      object cbxUploadClean: TCheckBox
        Left = 8
        Top = 104
        Width = 161
        Height = 17
        Caption = '&Don'#39't clean "upload" controls'
        TabOrder = 3
      end
      object cbxDownloadClean: TCheckBox
        Left = 192
        Top = 104
        Width = 169
        Height = 17
        Caption = '&Don'#39't clean "download" controls'
        TabOrder = 4
      end
    end
    object TabSheet3: TTabSheet
      Caption = '&Tray Icon'
      ImageIndex = 2
      TabVisible = False
      object RadioGroup1: TRadioGroup
        Left = 48
        Top = 52
        Width = 265
        Height = 81
        Caption = ' Tray icon : '
        ItemIndex = 0
        Items.Strings = (
          'Put in tray when the application is minimized'
          'Put in tray when the application is closed'
          'Don'#39't use tray icon, thanks')
        TabOrder = 0
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 264
    Width = 123
    Height = 25
    Caption = '&OK'
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 270
    Top = 264
    Width = 123
    Height = 25
    Caption = '&Cancel'
    TabOrder = 2
    Kind = bkCancel
  end
  object od: TJvBrowseForFolderDialog
    RootDirectory = fdRootFolder
    Left = 340
    Top = 40
  end
end
