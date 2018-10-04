object Cygwin_Form: TCygwin_Form
  Left = 353
  Top = 294
  BorderStyle = bsDialog
  Caption = 'Configure Cygwin libraries'
  ClientHeight = 144
  ClientWidth = 288
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
  object gbCygwin: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 97
    Caption = ' Configure Cygwin libraries : '
    TabOrder = 0
    object Info_Label: TLabel
      Left = 8
      Top = 19
      Width = 253
      Height = 30
      AutoSize = False
      Caption = 
        'Note : Cygwin DLL are cygwin1.dll and cygintl.dll (v1003.22.0.0)' +
        '.'
      WordWrap = True
    end
    object rbInternal: TRadioButton
      Left = 8
      Top = 52
      Width = 257
      Height = 17
      Caption = '&Internal Cygwin DLL'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbExternal: TRadioButton
      Left = 8
      Top = 68
      Width = 257
      Height = 17
      Caption = '&Use Cygwin installed package'
      TabOrder = 1
    end
  end
  object OK: TBitBtn
    Left = 8
    Top = 112
    Width = 97
    Height = 25
    Caption = '&OK'
    TabOrder = 1
    Kind = bkOK
  end
  object Cancel: TBitBtn
    Left = 184
    Top = 112
    Width = 97
    Height = 25
    Caption = '&Cancel'
    TabOrder = 2
    Kind = bkCancel
  end
end
