object Form1: TForm1
  Left = 309
  Top = 219
  Width = 337
  Height = 235
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 153
    Height = 25
    Caption = 'IsImmediatePresetExec'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 40
    Width = 153
    Height = 25
    Caption = 'Create ELF and BIN'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 104
    Width = 153
    Height = 25
    Caption = 'Register ELF and BIN Menu'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 168
    Top = 40
    Width = 153
    Height = 25
    Caption = 'Create DPD and DPU'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 168
    Top = 104
    Width = 153
    Height = 25
    Caption = 'Register DPD and DPU Menu'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 168
    Top = 8
    Width = 153
    Height = 25
    Caption = 'IsImmediateBinariesExec'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 136
    Width = 153
    Height = 25
    Caption = 'Unregister ELF and BIN Menu'
    TabOrder = 6
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 168
    Top = 136
    Width = 153
    Height = 25
    Caption = 'Unregister DPD and DPU Menu'
    TabOrder = 7
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 72
    Width = 153
    Height = 25
    Caption = 'Unregister ELF and BIN'
    TabOrder = 8
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 168
    Top = 72
    Width = 153
    Height = 25
    Caption = '&Unregister DPD and DPU'
    TabOrder = 9
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 8
    Top = 168
    Width = 153
    Height = 25
    Caption = 'IsAlreadySet BIN && ELF'
    TabOrder = 10
    OnClick = Button11Click
  end
end
