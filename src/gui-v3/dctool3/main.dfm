object Main_Form: TMain_Form
  Left = 226
  Top = 121
  Width = 669
  Height = 562
  Caption = 'DC-TOOL GUI 3 SERIES - by [big_fury]SiZiOUS'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 34
    Width = 661
    Height = 2
    Align = alTop
  end
  object Image2: TImage
    Left = 0
    Top = 36
    Width = 2
    Height = 356
    Align = alLeft
  end
  object Image3: TImage
    Left = 659
    Top = 36
    Width = 2
    Height = 356
    Align = alRight
  end
  object Image4: TImage
    Left = 0
    Top = 487
    Width = 661
    Height = 2
    Align = alBottom
  end
  object Image5: TImage
    Left = 0
    Top = 32
    Width = 661
    Height = 2
    Align = alTop
  end
  object HSplitter: TSplitter
    Left = 0
    Top = 392
    Width = 661
    Height = 3
    Cursor = crSizeNS
    Align = alBottom
    AutoSnap = False
  end
  object VSplitter: TSplitter
    Left = 169
    Top = 36
    Height = 356
    Cursor = crSizeWE
    AutoSnap = False
  end
  object cbMain: TCoolBar
    Left = 0
    Top = 0
    Width = 661
    Height = 32
    AutoSize = True
    Bands = <
      item
        BorderStyle = bsSingle
        Break = False
        Control = tbrMain
        FixedSize = True
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 24
        Width = 657
      end>
    object tbrMain: TToolBar
      Left = 0
      Top = 2
      Width = 657
      Height = 24
      Align = alNone
      Caption = 'Main Menu'
      EdgeBorders = []
      Images = ilMenu
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 2
        Width = 8
        Caption = 'ToolButton1'
        Style = tbsSeparator
      end
      object tbUpload: TToolButton
        Left = 8
        Top = 2
        Hint = 'Upload a file to the Dreamcast.'
        Caption = '&Upload...'
        ImageIndex = 0
        OnClick = miUploadClick
      end
      object tbDownload: TToolButton
        Left = 31
        Top = 2
        Hint = 'Dump RAM parts of your Dreamcast to your disk.'
        Caption = '&Download...'
        ImageIndex = 1
        OnClick = miDownloadClick
      end
      object ToolButton4: TToolButton
        Left = 54
        Top = 2
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object tbReexcuteLast: TToolButton
        Left = 62
        Top = 2
        Hint = 
          'Re-execute last action. Only with Upload, Download and Reset ope' +
          'ration.'
        Caption = '&Re-execute last'
        Enabled = False
        ImageIndex = 12
        OnClick = miReexcuteLastClick
      end
      object ToolButton7: TToolButton
        Left = 85
        Top = 2
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 0
        Style = tbsSeparator
      end
      object tbReset: TToolButton
        Left = 93
        Top = 2
        Hint = 
          'Reset DC-TOOL GUI. If you have the BBA, it also send the "Reset"' +
          ' command.'
        Caption = '&Reset DC-TOOL...'
        ImageIndex = 2
        OnClick = miResetClick
      end
      object tbAbortOperation: TToolButton
        Left = 116
        Top = 2
        Hint = 
          'Abort current operation. After doing it, you must restart your D' +
          'reamcast.'
        Caption = '&Abort operation'
        Enabled = False
        ImageIndex = 3
        OnClick = miAbortOperationClick
      end
      object ToolButton13: TToolButton
        Left = 139
        Top = 2
        Width = 8
        Caption = 'ToolButton13'
        ImageIndex = 17
        Style = tbsSeparator
      end
      object tbCloseCurrent: TToolButton
        Left = 147
        Top = 2
        Hint = 'Close the current tab.'
        Caption = 'tbCloseCurrent'
        ImageIndex = 23
        OnClick = miCloseTabClick
      end
      object ToolButton11: TToolButton
        Left = 170
        Top = 2
        Width = 8
        Caption = 'ToolButton11'
        ImageIndex = 19
        Style = tbsSeparator
      end
      object tbCopyText: TToolButton
        Left = 178
        Top = 2
        Hint = 'Copy the selected text to the clipboard.'
        Caption = '&Copy selected text'
        ImageIndex = 15
        OnClick = miCopyTextClick
      end
      object tbSelectAll: TToolButton
        Left = 201
        Top = 2
        Hint = 'Select the whole text.'
        Caption = '&Select all'
        ImageIndex = 14
        OnClick = miSelectAllClick
      end
      object ToolButton6: TToolButton
        Left = 224
        Top = 2
        Width = 8
        Caption = 'ToolButton6'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object tbSearchText: TToolButton
        Left = 232
        Top = 2
        Hint = 'Search a word in the text.'
        Caption = '&Find text...'
        ImageIndex = 17
        OnClick = miFindTextClick
      end
      object tbSearchBackward: TToolButton
        Left = 255
        Top = 2
        Hint = 'Search forward in the text.'
        Caption = 'tbSearchBackward'
        ImageIndex = 25
        OnClick = miSearchBackwardClick
      end
      object tbSearchForward: TToolButton
        Left = 278
        Top = 2
        Hint = 'Search backward in the text.'
        Caption = 'tbSearchForward'
        ImageIndex = 26
        OnClick = miSearchForwardClick
      end
      object ToolButton9: TToolButton
        Left = 301
        Top = 2
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 7
        Style = tbsSeparator
      end
      object tbSaveFile: TToolButton
        Left = 309
        Top = 2
        Hint = 'Save the current debug log to a file.'
        Caption = 'S&ave debug log as...'
        ImageIndex = 18
        OnClick = miSaveLogClick
      end
      object ToolButton2: TToolButton
        Left = 332
        Top = 2
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 25
        Style = tbsSeparator
      end
      object tbClearDebug: TToolButton
        Left = 340
        Top = 2
        Hint = 'Clear the debug log at the top of this window.'
        Caption = 'C&lear debug log...'
        ImageIndex = 24
        OnClick = miClearDebugLogClick
      end
      object ToolButton3: TToolButton
        Left = 363
        Top = 2
        Width = 8
        Caption = 'ToolButton3'
        ImageIndex = 24
        Style = tbsSeparator
      end
      object ToolButton8: TToolButton
        Left = 371
        Top = 2
        Hint = 'Configure highlighters colors.'
        Caption = '&Highlighters config...'
        ImageIndex = 27
        OnClick = Highlighterconfig1Click
      end
      object ToolButton5: TToolButton
        Left = 394
        Top = 2
        Hint = 'Customize the program.'
        Caption = '&Options...'
        ImageIndex = 21
        OnClick = Options1Click
      end
      object ToolButton10: TToolButton
        Left = 417
        Top = 2
        Width = 8
        Caption = 'ToolButton10'
        ImageIndex = 22
        Style = tbsSeparator
      end
      object ToolButton12: TToolButton
        Left = 425
        Top = 2
        Hint = 'Open the main help.'
        Caption = '&Main help'
        ImageIndex = 29
        OnClick = Mainhelp1Click
      end
      object ToolButton14: TToolButton
        Left = 448
        Top = 2
        Hint = 'About this cool proggy... ;)'
        Caption = '&About...'
        ImageIndex = 30
        OnClick = About1Click
      end
    end
  end
  object sbMain: TStatusBar
    Left = 0
    Top = 489
    Width = 661
    Height = 19
    Panels = <
      item
        Text = 'Status :'
        Width = 50
      end
      item
        Text = 'Idle...'
        Width = 150
      end
      item
        Text = 'ProgressBar'
        Width = 150
      end
      item
        Text = '100%'
        Width = 40
      end
      item
        Width = 400
      end>
  end
  object pLeft: TPanel
    Left = 2
    Top = 36
    Width = 167
    Height = 356
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object pcMain: TPageControl
      Left = 0
      Top = 0
      Width = 167
      Height = 356
      ActivePage = tsBookmarks
      Align = alClient
      TabOrder = 0
      object tsBookmarks: TTabSheet
        Caption = 'Bookmarks'
        object SynBookMarkView: TSynBookMarkView
          Left = 0
          Top = 0
          Width = 159
          Height = 328
          Align = alClient
          Checkboxes = True
          Columns = <
            item
              Caption = '#'
            end
            item
              AutoSize = True
              Caption = 'Location'
            end>
          ColumnClick = False
          GridLines = True
          Items.Data = {
            0C0100000A00000000000000FFFFFFFFFFFFFFFF010000000000000002233000
            00000000FFFFFFFFFFFFFFFF01000000000000000223310000000000FFFFFFFF
            FFFFFFFF01000000000000000223320000000000FFFFFFFFFFFFFFFF01000000
            000000000223330000000000FFFFFFFFFFFFFFFF010000000000000002233400
            00000000FFFFFFFFFFFFFFFF01000000000000000223350000000000FFFFFFFF
            FFFFFFFF01000000000000000223360000000000FFFFFFFFFFFFFFFF01000000
            000000000223370000000000FFFFFFFFFFFFFFFF010000000000000002233800
            00000000FFFFFFFFFFFFFFFF010000000000000002233900FFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF}
          ReadOnly = True
          RowSelect = True
          PopupMenu = pmBookMarks
          TabOrder = 0
          ViewStyle = vsReport
          OnContextPopup = SynBookMarkViewContextPopup
          Active = False
        end
      end
      object tsHistory: TTabSheet
        Caption = 'History'
        ImageIndex = 1
        object DcToolHistoryView: TDcToolHistoryView
          Left = 0
          Top = 0
          Width = 159
          Height = 328
          Align = alClient
          Images = ilHistoryView
          Indent = 19
          PopupMenu = pmHistory
          ReadOnly = True
          TabOrder = 0
          OnContextPopup = DcToolHistoryViewContextPopup
          DCTool = DCTool
          AddConnectionType = True
          DoReExecuteActions = False
          OnReReset = DcToolHistoryViewReReset
          OnReUpload = DcToolHistoryViewReUpload
          OnReDownload = DcToolHistoryViewReDownload
        end
      end
      object tsELF: TTabSheet
        Caption = 'ELF'
        ImageIndex = 2
        object tvELF: TTreeView
          Left = 0
          Top = 0
          Width = 159
          Height = 328
          Align = alClient
          Images = ilELF
          Indent = 19
          TabOrder = 0
        end
      end
    end
  end
  object pBottom: TPanel
    Left = 0
    Top = 395
    Width = 661
    Height = 92
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Image6: TImage
      Left = 0
      Top = 0
      Width = 2
      Height = 92
      Align = alLeft
    end
    object Image7: TImage
      Left = 659
      Top = 0
      Width = 2
      Height = 92
      Align = alRight
    end
    object reLog: TDcToolLogRichEdit
      Left = 2
      Top = 0
      Width = 657
      Height = 92
      Align = alClient
      PopupMenu = pmDebugLog
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
      LinesType.Command.Font.Charset = DEFAULT_CHARSET
      LinesType.Command.Font.Color = clGreen
      LinesType.Command.Font.Height = -11
      LinesType.Command.Font.Name = 'Tahoma'
      LinesType.Command.Font.Style = []
      LinesType.State.Font.Charset = DEFAULT_CHARSET
      LinesType.State.Font.Color = clRed
      LinesType.State.Font.Height = -11
      LinesType.State.Font.Name = 'Tahoma'
      LinesType.State.Font.Style = []
      LinesType.Log.Font.Charset = DEFAULT_CHARSET
      LinesType.Log.Font.Color = clBlue
      LinesType.Log.Font.Height = -11
      LinesType.Log.Font.Name = 'Tahoma'
      LinesType.Log.Font.Style = []
      InitLog.Enabled = False
      InitLog.InitFont.Charset = DEFAULT_CHARSET
      InitLog.InitFont.Color = clWindowText
      InitLog.InitFont.Height = -11
      InitLog.InitFont.Name = 'Tahoma'
      InitLog.InitFont.Style = [fsBold]
      AutoScroll.Enabled = True
    end
  end
  object pbTransfer: TProgressBar
    Left = 16
    Top = 280
    Width = 137
    Height = 17
    TabOrder = 4
  end
  object seOutputs: TSynEdit
    Left = 16
    Top = 304
    Width = 137
    Height = 65
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 5
    Visible = False
    Gutter.DigitCount = 3
    Gutter.Font.Charset = ANSI_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.ShowLineNumbers = True
    Gutter.Width = 20
    MaxScrollWidth = 1
    Options = [eoAutoSizeMaxScrollWidth, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabsToSpaces]
    ReadOnly = True
  end
  object multiSyn: TMultiSynPageControl
    Left = 172
    Top = 36
    Width = 487
    Height = 356
    Align = alClient
    PopupMenu = pmMultiSyn
    TabOrder = 6
    OnContextPopup = multiSynContextPopup
    SourceSynEdit = seOutputs
    SynBookMarkView = SynBookMarkView
  end
  object mmMain: TMainMenu
    Images = ilMenu
    OwnerDraw = True
    Left = 96
    Top = 120
    object File1: TMenuItem
      Caption = '&File'
      object miUpload: TMenuItem
        Caption = '&Upload...'
        Hint = 'Upload a file to the Dreamcast.'
        ImageIndex = 0
        ShortCut = 16469
        OnClick = miUploadClick
      end
      object miDownload: TMenuItem
        Caption = '&Download...'
        Hint = 'Dump RAM parts of your Dreamcast to your disk.'
        ImageIndex = 1
        ShortCut = 16452
        OnClick = miDownloadClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miReexcuteLast: TMenuItem
        Caption = '&Re-execute last'
        Enabled = False
        Hint = 
          'Re-execute last action. Only with Upload, Download and Reset ope' +
          'ration.'
        ImageIndex = 12
        ShortCut = 120
        OnClick = miReexcuteLastClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object miSendACommand: TMenuItem
        Caption = '&Send a command...'
        Hint = 
          'Send a personalised command to DC-TOOL. It won'#39't be added to the' +
          ' history (not the same thread).'
        ImageIndex = 4
        OnClick = miSendACommandClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miReset: TMenuItem
        Caption = '&Reset DC-TOOL...'
        Hint = 
          'Reset DC-TOOL GUI. If you have the BBA, it also send the "Reset"' +
          ' command.'
        ImageIndex = 2
        ShortCut = 16466
        OnClick = miResetClick
      end
      object miAbortOperation: TMenuItem
        Caption = '&Abort operation'
        Enabled = False
        Hint = 
          'Abort current operation. After doing it, you must restart your D' +
          'reamcast.'
        ImageIndex = 3
        ShortCut = 16474
        OnClick = miAbortOperationClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        Hint = 'Hey ! Where you want to go ! :p'
        ImageIndex = 5
        ShortCut = 16465
        OnClick = Exit1Click
      end
    end
    object Debug1: TMenuItem
      Caption = '&Edit'
      object miCopyText: TMenuItem
        Caption = '&Copy selected text'
        Hint = 'Copy the selected text to the clipboard.'
        ImageIndex = 15
        ShortCut = 16451
        OnClick = miCopyTextClick
      end
      object miSelectAll: TMenuItem
        Caption = '&Select all'
        Hint = 'Select the whole text.'
        ImageIndex = 14
        ShortCut = 16449
        OnClick = miSelectAllClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object miFindText: TMenuItem
        Caption = '&Find text...'
        Hint = 'Search a word in the text.'
        ImageIndex = 17
        ShortCut = 16454
        OnClick = miFindTextClick
      end
      object miSearchForward: TMenuItem
        Caption = '&Search forward'
        Hint = 'Search forward in the text.'
        ImageIndex = 26
        ShortCut = 114
        OnClick = miSearchForwardClick
      end
      object miSearchBackward: TMenuItem
        Caption = 'Search backward'
        Hint = 'Search backward in the text.'
        ImageIndex = 25
        OnClick = miSearchBackwardClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object miSaveLog: TMenuItem
        Caption = 'S&ave debug log as...'
        Hint = 'Save the current debug log to a file.'
        ImageIndex = 18
        ShortCut = 16467
        OnClick = miSaveLogClick
      end
    end
    object Debug2: TMenuItem
      Caption = '&View'
      object miCloseCurrent: TMenuItem
        Caption = '&Close'
        Hint = 'Close the current tab.'
        ImageIndex = 23
        OnClick = miCloseTabClick
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object miCloseAllTabs: TMenuItem
        Caption = 'C&lose all tabs'
        Hint = 'Close all tabs in the view.'
        OnClick = miCloseAllTabsClick
      end
      object miCloseUselessTabs: TMenuItem
        Caption = '&Close useless tabs'
        Hint = 'Close all tabs but keep the last open.'
        OnClick = miCloseUselessTabsClick
      end
      object N25: TMenuItem
        Caption = '-'
      end
      object miClearDebugLog: TMenuItem
        Caption = 'C&lear debug log...'
        Hint = 'Clear the debug log at the top of this window.'
        ImageIndex = 24
        ShortCut = 49220
        OnClick = miClearDebugLogClick
      end
    end
    object Filters1: TMenuItem
      Caption = '&Filters'
      Enabled = False
      object Configure1: TMenuItem
        Caption = '&Configure...'
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object Viewfilteredoutputs1: TMenuItem
        Caption = '&View filtered outputs'
      end
    end
    object Options2: TMenuItem
      Caption = '&Options'
      object miUseDumbTerminal: TMenuItem
        Caption = '&Use Dumb Terminal'
        Hint = 'Use dumb terminal rather than console/fileserver.'
        OnClick = miAttachConsoleAndFileserverClick
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object miClearScreenBeforeDownload: TMenuItem
        Tag = 2
        Caption = '&Clear screen before download'
        Checked = True
        Hint = 'Clear screen before download.'
        OnClick = miAttachConsoleAndFileserverClick
      end
      object miAttachConsoleAndFileserver: TMenuItem
        Tag = 1
        Caption = '&Attach console and fileserver'
        Checked = True
        Hint = 'Attach console and fileserver.'
        OnClick = miAttachConsoleAndFileserverClick
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object miFileInUseProtectionForUpload: TMenuItem
        Tag = 3
        Caption = 'File in use &protection for upload'
        Checked = True
        Hint = 
          'Copy the binary uploaded file to a temp file. It allow you to mo' +
          'dify your source when a transfer'#39's in progress...'
        OnClick = miAttachConsoleAndFileserverClick
      end
    end
    object Config1: TMenuItem
      Caption = '&Config'
      object Edit1: TMenuItem
        Caption = '&Connection'
        Hint = 'Configure your connection.'
        ImageIndex = 20
        object Wizardconfig1: TMenuItem
          Caption = 'Wizard config...'
          Hint = 'Open the link wizard configuration.'
          ImageIndex = 22
          ShortCut = 113
          OnClick = miSendACommandClick
        end
        object Linktest1: TMenuItem
          Caption = '&Link test...'
          Hint = 'Test your link.'
          ImageIndex = 13
          ShortCut = 16468
          OnClick = miSendACommandClick
        end
        object N10: TMenuItem
          Caption = '-'
        end
        object Linktype: TMenuItem
          Caption = '&Link type'
          Hint = 'Select your link type right here.'
          ImageIndex = 19
          object LinkType0: TMenuItem
            Caption = '&Serial'
            Checked = True
            Hint = 'Serial MAX2322 based.'
            OnClick = LinkType0Click
          end
          object LinkType1: TMenuItem
            Tag = 1
            Caption = '&Broadband Adapter'
            Hint = 'Broadband (HIT-400) or LAN (HIT-300) Adapters.'
            OnClick = LinkType0Click
          end
          object LinkType2: TMenuItem
            Tag = 2
            Caption = '&USB'
            Enabled = False
            Hint = 'Axlen'#39' USB prototype cable... Waiting for it ! ;)'
            OnClick = LinkType0Click
          end
        end
        object N4: TMenuItem
          Caption = '-'
        end
        object Setdeviceport: TMenuItem
          Caption = '&Set device port'
          Hint = 'Select the device port.'
          ImageIndex = 6
          object COM0: TMenuItem
            Caption = '&COM1'
            Checked = True
            Hint = 'COM1'
            OnClick = COM0Click
          end
          object COM1: TMenuItem
            Tag = 1
            Caption = 'C&OM2'
            Hint = 'COM2'
            OnClick = COM0Click
          end
          object COM2: TMenuItem
            Tag = 2
            Caption = 'CO&M3'
            Hint = 'COM3'
            OnClick = COM0Click
          end
          object COM3: TMenuItem
            Tag = 3
            Caption = 'COM&4'
            Hint = 'COM4'
            OnClick = COM0Click
          end
        end
        object Setbaudrate: TMenuItem
          Caption = 'Set &baudrate'
          Hint = 'Select your baudrate.'
          ImageIndex = 10
          object Baudrate8: TMenuItem
            Tag = 8
            Caption = '115200'
            OnClick = Baudrate8Click
          end
          object Baudrate7: TMenuItem
            Tag = 7
            Caption = '57600'
            Checked = True
            OnClick = Baudrate8Click
          end
          object Baudrate6: TMenuItem
            Tag = 6
            Caption = '38400'
            OnClick = Baudrate8Click
          end
          object Baudrate5: TMenuItem
            Tag = 5
            Caption = '19200'
            OnClick = Baudrate8Click
          end
          object Baudrate4: TMenuItem
            Tag = 4
            Caption = '9600'
            OnClick = Baudrate8Click
          end
          object Baudrate3: TMenuItem
            Tag = 3
            Caption = '4800'
            OnClick = Baudrate8Click
          end
          object Baudrate2: TMenuItem
            Tag = 2
            Caption = '2400'
            OnClick = Baudrate8Click
          end
          object Baudrate1: TMenuItem
            Tag = 1
            Caption = '1200'
            OnClick = Baudrate8Click
          end
          object Baudrate0: TMenuItem
            Caption = '300'
            OnClick = Baudrate8Click
          end
        end
        object miAlternateBaudrate: TMenuItem
          Caption = '&Use alternate baudrate'
          Enabled = False
          Hint = 'Enable 115200 alternate baudrate.'
          OnClick = miAlternateBaudrateClick
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object SetBBAIP: TMenuItem
          Caption = 'Set BB&A IP...'
          Enabled = False
          Hint = 'Set the IP for the BBA / LAN. Info : The port is 31313.'
          ImageIndex = 11
          OnClick = SetBBAIPClick
        end
      end
      object N24: TMenuItem
        Caption = '-'
      end
      object DCTOOLlocation1: TMenuItem
        Caption = '&DC-TOOL location...'
        Hint = 'Configure the DC-TOOL engine.'
        ImageIndex = 32
        OnClick = DCTOOLlocation1Click
      end
      object Cygwinlibraries1: TMenuItem
        Caption = '&Cygwin libraries...'
        Hint = 'Configure Cygwin binaries used with the DC-TOOL engine.'
        ImageIndex = 33
        OnClick = Cygwinlibraries1Click
      end
      object BINstatedetection1: TMenuItem
        Caption = '&BIN state detection...'
        Hint = 
          'Configure the BIN state detection (scrambled/unscrambled) used w' +
          'hen uploading a program.'
        ImageIndex = 35
        OnClick = BINstatedetection1Click
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object Highlighterconfig1: TMenuItem
        Caption = '&Highlighters config...'
        Hint = 'Configure highlighters colors.'
        ImageIndex = 27
        OnClick = Highlighterconfig1Click
      end
      object Historiesconfig1: TMenuItem
        Caption = '&Histories manager...'
        Hint = 'Manage histories used in the Upload/Download dialogs.'
        ImageIndex = 28
        OnClick = Historiesconfig1Click
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object Options1: TMenuItem
        Caption = '&Options...'
        Hint = 'Customize the program.'
        ImageIndex = 21
        OnClick = Options1Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object Language1: TMenuItem
        Caption = '&Language...'
        Enabled = False
        Hint = 'Change the current language. The app must be restarted.'
        ImageIndex = 31
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object Mainhelp1: TMenuItem
        Caption = '&Main help'
        Hint = 'Open the main help.'
        ImageIndex = 29
        ShortCut = 112
        OnClick = Mainhelp1Click
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object Submitbugsreport1: TMenuItem
        Caption = '&Submit bugs report...'
        Hint = 'Submit a bugs report with your mail client to the author.'
        ImageIndex = 34
        OnClick = Submitbugsreport1Click
      end
      object Websites1: TMenuItem
        Caption = '&Websites...'
        Hint = 'Open websites in your browser.'
        ImageIndex = 37
        object DCTOOLGUI1: TMenuItem
          Caption = '&DC-TOOL GUI'
          Hint = 'SiZiOUS'#39's SBI Builder Domain.'
          ImageIndex = 42
          OnClick = DCTOOLGUI1Click
        end
        object DCTOOL1: TMenuItem
          Caption = 'DC-&TOOL'
          Hint = 'ADK / Napalm-X website.'
          ImageIndex = 43
          OnClick = DCTOOL1Click
        end
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object About1: TMenuItem
        Caption = '&About...'
        Hint = 'About this cool proggy... ;)'
        ImageIndex = 30
        ShortCut = 123
        OnClick = About1Click
      end
    end
  end
  object DCTool: TDCTool
    DosComm.InputToOutput = False
    DosComm.MaxTimeAfterBeginning = 0
    DosComm.MaxTimeAfterLastOutput = 0
    DosComm.ShowWindow = swHIDE
    DosComm.CreationFlag = fCREATE_NEW_CONSOLE
    DosComm.ReturnCode = rcCRLF
    DosComm.OnNewLine = DCToolNewLine
    DosComm.OnTerminated = DCToolTerminated
    UploadOptions.ExecuteAddress = '0x8C010000'
    UploadOptions.ExecuteAfterUpload = True
    UploadOptions.FileInUseProtection = True
    DownloadOptions.FileSize = 0
    DownloadOptions.Address = '0x8C010000'
    IsoRedirection.Enabled = False
    ChRoot.Enabled = False
    Options.UseDumbTerminal = False
    Options.AttachFileServer = True
    Options.ClrScrBeforeDownload = True
    Serial.ComPort = cpCOM1
    Serial.Baudrate = b57600
    Serial.AlternateBaudrate = False
    BroadBand.IPAddress = '000.000.000.000'
    ConnectionType = ctSerial
    ProgressBar = pbTransfer
    ElfTreeView = tvELF
    ShowTextProgress = False
    OnNewLine = DCToolNewLine
    OnNewDcToolLine = DCToolNewDcToolLine
    OnTerminated = DCToolTerminated
    OnProgressBegin = DCToolProgressBegin
    OnProgressEnd = DCToolProgressEnd
    OnDetectingFileFormat = DCToolDetectingFileFormat
    OnCreateCommandLine = DCToolCreateCommandLine
    OnStart = DCToolStart
    OnEndDcToolLines = DCToolEndDcToolLines
    OnReseting = DCToolReseting
    OnReseted = DCToolReseted
    OnAborting = DCToolAborting
    OnAborted = DCToolAborted
    Left = 64
    Top = 184
  end
  object ilMenu: TImageList
    Left = 64
    Top = 152
    Bitmap = {
      494C01012C003100040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000D0000000010020000000000000D0
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000246E80000051660000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E8D1C300E8D1C300E8D1
      C300E8D1C300E8D1C300E8D0BF00E8CEBC00E8CFC000E8D1C300E8D1C300E8D1
      C300E8D1C300E8D1C300E8D1C300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003B8EA1000051660000516600000000000000
      000000000000000000000000000000000000000000000000FF00000080000000
      80008080800000000000000000000000000000000000000000000000FF008080
      800000000000000000000000000000000000E8D1C300FFFFFF00FCFDFD00F9F9
      F800E3CBBE00CCA38B00BC8A6F00BB8A6C00C0917600D6BBAB00F6F3EF00FBFF
      FD00FFFFFF00FFFFFF00FFFFFF00E8D1C3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000516600005166000051660005A3BE0007ADC700005166000000
      000000000000000000000000000000000000000000000000FF00000080000000
      800000008000808080000000000000000000000000000000FF00000080000000
      800080808000000000000000000000000000E8D1C300FFFFFF00EBE3DC00BF87
      6B00BA876800D3B29B00DBCDB800E0CABC00DBBCAB00C18C7000B67E5A00E0CB
      BF00FDFDFD00FFFFFF00FFFFFF00E8D1C300D59B6B008A3F1D00843A17008439
      1700843A1700843B1700843B1700843B1700843B1700833B1700833B1700833B
      1700833B1700833B1700833B17006D351C000000000000000000000000000000
      0000000000000051660021B5CE000CD2F00000DDFB0001D1F10003AFCB000051
      660000000000000000000000000000000000000000000000FF00000080000000
      8000000080000000800080808000000000000000FF0000008000000080000000
      800000008000808080000000000000000000E7D0C300F4E9E300B5816200D4B3
      A200FAF8F700F1E7E100E5CCC200E2D2C300F2EEEA00FBFBF800DCC6B700B97D
      5A00E1D1C200FFFFFF00FFFFFF00E8D1C300D59B6B00FFFFFF00FFFFFF00FFFF
      FF00FAFFFF00FBFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FDFFFF00C99773000000000000000000000000000000
      0000000000000084A50000516600008FAE0030E4FC000BDEFB0020D6EF0006B2
      CD000051660000000000000000000000000000000000000000000000FF000000
      8000000080000000800000008000808080000000800000008000000080000000
      800000008000808080000000000000000000E8D0C300C9A38900CCA28800F8F8
      F800D0AF9900B47C5B00C6977C00C0957700B8785F00D3B59C00FAFAF800D9B8
      A900BC866900FEFCFD00FFFFFF00E8D1C300D59B6B00FFFFFF00FCFFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FCFFFF00C89473000000000000000000000000000000
      000000637B0000637B002BA5BB0032D7EE0030E4FC0022BBD200005166000051
      6600005166000051660000000000000000000000000000000000000000000000
      FF00000080000000800000008000000080000000800000008000000080000000
      800080808000000000000000000000000000E2C3B000B3775700EEE5DB00DFCA
      B900BB806000F1EBE200F9FBFA00FAF5EF00F2E5DF00BE866700DDC0B600F0F0
      E600B4785300F0E9E400FFFFFF00E8D1C300D59B6B00FFFFFF00FBFFFF00FCFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FBFFFF00CC967100000000000000000000637B000063
      7B00009CBE0000ABD5002CDFF9004AEFFF004AEFFF004AEFFF002AD9F1000051
      6600000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000000080000000800000008000000080008080
      800000000000000000000000000000000000C7A38500BB816100FAFBFA00CA9E
      8300DDC0B100EDE0D800BA836000B3775600E2DAD200CCA79500CDA68D00F7EF
      EC00B0765500EBE4DB00FFFFFF00E8D1C300D59B6B00FFFFFF00F9FFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FBFFFF00D0996D000000000000637B00008FAE0003AF
      CB0000B2D70001B5DD0016CDED0056EBFD006BF7FF0046C0CF000051660000AB
      D500005166000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000808080000000
      000000000000000000000000000000000000C0907300C6917200FDFFFC00BB86
      6A00EBDFD200CCA79200D4AB9400F9F6F200F7F8FB00C69A7F00D7B4A000E9DE
      D600B4785500F9F6F100F0EBE100C99C8100D59B6B00FFFFFF00F9FFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FBFFFF00D59B6B00000000000000000000637B0001B5
      DD0001B5DD0000BDE20000BDE20048E7FD008EFAFF008EFAFF0058E2F4000051
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800000008000808080000000
      000000000000000000000000000000000000C5987A00C48C6D00FFFEFD00C293
      7700E1CEBD00DAB8A700C1917A00EADAD000D0B4A300AF7A5900EDDFD900D8B7
      A300BE8B6C00FBFBFC00D1B29900BD775200D59B6B00FFFFFF00F9FFFF00FAFF
      FF00F9FFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00D79C6A00000000000000000000637B00008F
      AE0000BDE20000BDE20000BDE2001DCDED0000DDFB00C5FDFF00A5FAFF0062EE
      F900005166000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000000080000000800000008000808080000000
      000000000000000000000000000000000000DAB6A200B5795900F6F0EE00D5BA
      A500C18E7300F6F1EA00CEA38F00BE846600C8977B00EAD5CA00F3EEE900B982
      6200D5B4A200FBFAFB00C0896A00BE856600D59B6B00FFFFFF00F9FFFF00FCFF
      FF00FBFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FFFFFF00DB9E68000000000000000000000000000063
      7B0000BDE20000BDE20001B5DD0001B5DD0000ABD50001B5DD0005CEF0002CE3
      FC0068FFFF000051660000000000000000000000000000000000000000000000
      FF00000080000000800000008000808080000000800000008000000080008080
      800000000000000000000000000000000000E5CFBD00C5947800DCB8A500F5F5
      F500BF8F7800C59A8200ECE5DB00FBF9FA00F4FAF800E9DDD300C38B6F00BE88
      6D00F2F1EF00E4D1C600B2795300D9B6A500D59B6B00FFFFFF00F9FFFF00F9FF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00F9FFFF00FAFFFF00FAFF
      FF00FDFFFF00FEFFFF00FFFFFF00DFA265000000000000000000000000000063
      7B0000BDE20001B5DD0000ABD50000ABD50000ABD50000ABD50000A3D00001B5
      DD000BBEE5001DBFD900005166000000000000000000000000000000FF000000
      8000000080000000800080808000000000000000FF0000008000000080000000
      800080808000000000000000000000000000E7D1C300EBD8D300B67D5A00E8DD
      D200F4F2EF00CFAA9300BB7A5A00BA846400BD846500B57A5800C8A08900F3EE
      EC00F2ECE600B8815F00CFAB9B00E5CEC100D59B6B00FFFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FFFFFF00E2A362000000000000000000000000000063
      7B0000637B000087A80000ABD50000ABD50000ABD50000A3D00000A3D000009E
      CF00008DB30000516600000000000000000000000000000000000000FF000000
      800000008000808080000000000000000000000000000000FF00000080000000
      800000008000808080000000000000000000E8D1C300FDFDFD00D9BFB100BC7D
      5E00DAC1B300FBFCFA00F0E9E700E1D0C500E7DCD200F4EFED00FDFDFA00EBE0
      D800BC8C6C00BC8D6F00FAF5F200E8D1C300D59B6B00DCDFCE00D9D2B900DAD3
      B900DAD2B900DAD3B900DAD3B900D9D3B900D9D2B900DAD2B900D9D2B900D8CF
      B600D9D1B700D8CFB400E3D2AA00D48D37000000000000000000000000000000
      00000000000000637B0000637B000087A80000A3D00000A3D000009ECF000084
      A500005166000000000000000000000000000000000000000000000000000000
      FF000000800000000000000000000000000000000000000000000000FF000000
      800000008000000080000000000000000000E8D1C300FFFFFF00FBFEFE00E7D5
      CA00BE876C00BD8D7200DBBBAA00E1CFC700DBC4BA00D8B6A200C6937A00B87B
      5600CB9F8A00F6EDEB00FFFFFF00E8D1C300D59B6B00CB6B0000D16B0000D06E
      0000D16D0000D2720300D1710500D16E0000CF6D0000D16E0000CF6F0000E597
      4000CF6A0000F6A244002E6AFD00CF6F00000000000000000000000000000000
      000000000000000000000000000000637B0000637B000084A5000084A5000051
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000FF000000000000000000E8D1C300FFFFFF00FFFFFF00FBFC
      FE00FCFAF700E2CFC100CCA18900BD886C00C28E7000C69B8000D8BCAA00F0E6
      DF00FAFDF900FFFEFF00FFFFFF00E8D1C30000000000D4780B00DC801600DB7B
      0D00DB7A0A00DB7A0900DC7C0E00DC7D0F00D97F1900D87B1100D87A0F00D674
      0700D8790D00D6750700E57D0600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000637B0000586D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9B19B00E8D0C300E8D0C300E8D0
      C300E8D0C300E7D0C300E8D0C200E8CEBD00E8D0C000E8D0C300E8D0C300E8D0
      C300E8D0C300E8D0C300E8D0C300D9B19B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE9E9C00CAA29F00CA9CA000E8BCC10000000000000000000000
      0000000000000000000000000000000000000000000000000000F6D1C300F6D1
      C300F6D1C300F6D1C300F6D1C300F6D1C300F6D1C300F6D1C300F6D1C300F6D1
      C300F6D1C300F6D1C30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000070707000727272000000000000000000000000000000000000000000F4C9
      D000CA9A9200E8B18300F1E4D000EFE1CA00DFC5B100CDA29B00CE9D9F00DFB1
      B500E8BCC1000000000000000000000000000000000000000000ECA98D00F8DB
      D000F8D7CA00F7D5C800F7D3C500F6D1C300F6CFC100F5CDBE00F5CBBC00F4C9
      B900F4C8B800E79A8600000000000000000000000000000000006E6E6E006E6E
      6E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000058585800656565005858
      5800585858005858580058585800585858005858580058585800746766008D80
      A0006182A8005858580000000000000000000000000000000000F1C6CC00DBAE
      9D00EEC18F00ECB98800F3EADC00F1E4D000EFE1CA00B58F8B00AE7C7C00B784
      8400D1AE9700C5A08A00C1958F00E0B5BA000000000000000000D0A79500FFF6
      EF00800000008000000080000000800000008000000080000000800000008000
      0000FED0AF00FADFD300000000000000000000000000795FEA002900DF003F28
      A600656565000000000000000000000000000000000000000000000000000000
      00006250B2002E07D80000000000000000002389BC001C82B5001A80B300177D
      B000157BAE001278AB000F75A8000C72A5000A70A3003A789E008E81A000498D
      DC00349CDE004D4F5000000000000000000000000000F0C4CA00E0B9A000F2CD
      9B00F0C69400EEC18F00F4ECE000F3E9DB00F0E3CE00B58F8B009B696900A06E
      6E00D8BBA000E6CFA600E4CCA000C99A9E00000000002626260026262600FEF8
      F400FDE1D400FCD2C400FCC9B500FCC0A500FCC1A500FCBFA200FCBD9F00FCCC
      BB00FEE1CE00FEEDE100A26E5F000000000000000000795FEA002900DF00300A
      DB00534E6A006565650000000000000000000000000000000000000000004629
      C3002900DF005A46B60000000000000000001E84B70044AADD00D5F8FF0079D7
      FF006ED4FF006ED4FF006ED4FF006ED4FF007EC9ED009488A8004B8CD80051BB
      FF000A70A6002B516400727272000000000000000000D1AB9600F5DAA700F3D3
      A000F2CD9B00F0C69400F8F3EB00F4ECE000F2E9DA00B58F8B00996767009967
      6700D6BBA300E8D3AF00E6CFA600C99A9E0000000000262626000000FF002626
      2600FEEFE700FCD7CB00FDDACC00FDCEB600FCC8AE00FCC7AB00FDC7AA00FDC8
      AC00FED1B200FEEDE200A5746600000000000000000000000000795FEA002900
      DF003D1CD2005F5F5F00000000000000000000000000000000003A18CD002E07
      D8005A46B6000000000000000000000000002389BC00298FC200D9FCFF00AFEC
      FF0096C8D800CACCC100C5C7B600ADB9B80093A5B2005D93D00053BDFF0074DA
      FF001379AC000F5E86005D5D5D000000000000000000D1AB9600F7E1AE00F5DA
      A700F3D2A000F2CD9B00F9F6F000F8F3EB00F4EBDF00B58F8B00996767009967
      6700D7BEA900EAD7B600E8D3AF00C99A9E0000000000262626000000FF000000
      FF00262626008000000080000000800000008000000080000000800000008000
      0000FED8BC00FAE3D800A6867C00000000000000000000000000000000000000
      00002900DF005238C3006464640000000000000000003A18CD002E07D8005A46
      B60000000000000000000000000000000000278DC0002D93C60086CFF300CCC7
      C900F4EEE500FFFFEA00FFFFD900FFF5C300DCB5990090C5DA007EE6FF0085EB
      FF00369CCF001A80AB00515151000000000000000000D1AB9600F8E6B400E6CA
      A10090A4BD009F9FAB00FFFEFE00F9F6F000F7F2E900D9C0AE00B58F8B00A97E
      7A00D9C0AE00ECDBBF00EAD6B500C99A9E0000000000262626000000FF002626
      2600FDDACA00FCC7B100FCC5AE00FCC8B100FCC6AD00FCC5AD00FCBFA400FCC0
      A300FEDFC600F5D0C400AC989100000000000000000000000000000000000000
      0000000000002900DF005137C30053505E003312C7002C06D7005A46B6000000
      000000000000000000000000000000000000298FC2004BB1E4003B9FD100DAC8
      B200FFFFFC00FFFFF900FFFFE000FFF4C000FFE9B700B0CECD0091F7FF0091F7
      FF0056BCEF00147AA70034505E007272720000000000D1AB9600D5CAAE0054AF
      F7003A9FFF003792F30091BCEF00FFFEFE00F9F6F000F7F2E900F3EBDE00F2E7
      D700F0E2CD00EEDFC600ECDBBF00C99A9E00000000002626260026262600FFFD
      FC00FDE8E000FDE8E100FDE9E200FDDED100FDD8C500FDD9C500FDD6C000FDD5
      BE00FFE8D500EEB4A100AC989100000000000000000000000000000000000000
      000000000000795FEA002900DF002C06D7002B05D6006A628C00000000000000
      0000000000000000000000000000000000002C92C5006BD1FC002389BC00E3D2
      B200FFFFE600FFFFE800FFFFD900FFEDB800FFEDBE00D9D2BB0099FFFF0099FF
      FF005FC5F80046ACC800145D81004D4D4D00F7CFD600A5B7D00066CBFF005ABF
      FF004BB0FF003DA2FF003694F700B5D4F700FEFEFD00F8F5ED00F7F2E900F3EB
      DE00F2E7D700F0E2CD00D1B7B100D1A5AA000000000000000000FDEEE500FEF5
      F100800000008000000080000000800000008000000080000000800000008000
      0000FFF0E500C9907D0000000000000000000000000000000000000000000000
      000000000000000000002F08D9002900DF00472BC4006A628C00000000000000
      0000000000000000000000000000000000002E94C7007AE0FF0045ABD500DEC5
      A500FFFFD000FFF9C900FFF4C200FFE9C200FFF7D100E8CFC300FFFFFF00FFFF
      FF0080E6FF0078DEE90005659700595959004FB4FF004FB4FF005CC1FF0065CA
      FF005DC2FF004EB3FF003EA3FF003796F800B4D5F800FEFDFB00F8F5ED00F6F0
      E600F3EADD00C7BEC4009A87A500EAC3CD0000000000CAB4A600FEFDFC00FEFB
      FA00FEF3F000FEEFEA00FEEFEB00FEF2EF00FFFFFF00FFF9F400FFEFE200FFEB
      DB00FEF4EC00AC84760000000000000000000000000000000000000000000000
      0000000000003A18CD002E07D8005A46B600360FE000593DD6006A628C000000
      0000000000000000000000000000000000003096C90085EBFF006ED4F200828B
      9400FCE8B600FFEDB600FFF0C000FFFFF700EBDCD100508FB4002389BC001F85
      B8001B81B4001A80B300046A9D0000000000EDCDDA0064AFF7004DB2FF005ABF
      FF0065CAFF005EC3FF004FB4FF0041A6FF003697FB00B4D5F800FEFDFB00F8F5
      ED00B6BCD1006E76AC00E2C0CE000000000000000000D9B29E00F6DAD300F6DA
      D300F6DAD300F6DAD300F9E5E000FFFFFF00FFFFFF00FFFFFF00FFFEFE00FFFB
      F700FAE5DD00AC98910000000000000000000000000000000000000000000000
      00003A18CD002900DF005A46B6000000000000000000431FE2004A28DD006A62
      8C00000000000000000000000000000000003298CB0091F7FF008EF4FF0090EA
      F400B9BFB800EBCDAD00E6CCA900DDC5B800E8D9D900FFFFFF00FFFFFF00FFFF
      FF00157BAE0070707000000000000000000000000000EDCDDA007AB3F2004CB1
      FF0059BEFF0065CAFF0061C6FF0052B7FF0042A7FF00379AFC00B4D6FB00B7CD
      EC005275BC00D8BCCF00000000000000000000000000C9B4A900F5C2AA00F0B3
      9B00EBA48C00E0795C00EFBEB200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFE
      FE00F7D8CB00AC98910000000000000000000000000000000000000000003917
      CC002900DF005A46B600000000000000000000000000000000005F40E700350E
      DF006A628C000000000000000000000000003399CC00FFFFFF0099FFFF0099FF
      FF0099FFFF0099FFFF00FFFFFF00248ABD002187BA001E84B7001C82B5001A80
      B300177DB00000000000000000000000000000000000000000000000000086B6
      F00049AEFF0056BBFF0063C8FF0062C7FF0053B8FF0045AAFF00379BFE00398A
      EB00D6C1D7000000000000000000000000000000000000000000D0CCCA00FFF2
      E900FFEDDE00EEAF9A00F1C4B800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FE00F7D4C500AC989100000000000000000000000000000000003917CC002900
      DF005A46B6000000000000000000000000000000000000000000000000005F40
      E7002900DF00000000000000000000000000000000003399CC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00298FC200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000083B3F00048ADFF0055BAFF0062C7FF0064C9FF0051AFF9002F76DF003269
      E800000000000000000000000000000000000000000000000000000000000000
      0000FFF0E400F4C4B100F0BEB100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFE
      FE00F9DBCE00AC989100000000000000000000000000411DE0002900DF004629
      C300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003399CC003298
      CB003096C9002E94C70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008FB6ED0074B6F500A7C6EC00DDCFDF00BA9CC70001019900305D
      E300000000000000000000000000000000000000000000000000000000000000
      000000000000ECD6CB00EDAE9900FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FCEFE900A28D82000000000000000000000000003610E1004D2CE1000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D9B6CC007C689F009B82
      AC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6AA9E00CCB2A200CDB3A300CCB1A100CBAF9F00CBAD
      9C00CAA89700B7A1960000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600666666006666660066666600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000808080008080800080808000808080008080800080808000C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AE7B6E00D9AD
      9D00D6A89A00D3A69800D2A49700CCA19900C99E9700C69C9600C4999500C196
      9300B6918B00B88E8B0066666600000000008181810059595900595959005959
      5900595959005959590059595900595959005959590059595900595959005959
      590059595900595959004B4B4B00818181000000000000000000404040000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004040400080808000C0C0C000000000000000000000000000000000000000
      00000000000085B9D40075B3D0007AA4BB006B839200687B890071808B00687D
      8D00788188000000000000000000000000000000000000000000B5827200FCE1
      CB00FBE0C800FBDEC400FBDCC200FADABE00FAD8BB00FBD7B800FAD4B400F9D2
      B100FAD0AE00EEBDA50066666600000000004B4B4B00D9A77D00CB8C4400CB8C
      4400CB8C4400CB8C4400CB8C4400CB8C4400CB8C4400CB8C4400CB8C4400CB8C
      4400CB8C4400CB8C4400CB8C44004B4B4B0000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004040400080808000C0C0C000000000000000000000000000CEA89B000000
      000084868C008CD8F50074DEFE006CC0DE006BA3B90066A4BE006ABAE00077C9
      F3006DBAE600768FA20000000000000000000000000000000000BB887500FCE4
      CF00FCE2CC00FBE0C900FBDEC600A30E62003050000097135300FAD6B800FAD5
      B500FAD3B100EFBFA80066666600000000007F5B0000FFFFCC00D9A77D00D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A7
      7D00D9A77D00D9A77D00CB8C44004B4B4B000000000080808000000000000000
      0000000000008080800080808000808080008080800080808000C0C0C0000000
      00000000000000000000000000000000000000000000ECBFAD00F8D8CB00F8C4
      AF00B69F9D0098E0F50077DAF500638999005595B50058BCEC004FB3E7004FBA
      EF0057C1F6008197A50000000000000000000000000000000000C28F7900FCE7
      D400FCE4D100FCE3CE0099135800126F0200008000000C75010092154E00FBD7
      B900FBD5B600F0C1AB0066666600000000007F5B0000FFFFCC00D9A77D00D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A7
      7D00D9A77D00D9A77D00CB8C44004B4B4B000000000080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FCE8DC00FFF7
      E700C6D3DA0098E4F5007FE2F900998792005E434B004289AA004DAFE20059B6
      EB006CC6F7007E909D0000000000000000000000000000000000C8957C00FCE8
      D800FCE6D50092154F0017690000008D000000A6000000800000146C00008B19
      4900FAD8BB00F0C3AF0066666600000000007F5B0000FFFFCC00D9A77D00D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A7
      7D00D9A77D00D9A77D00CB8C44004B4B4B000000000080808000000000000000
      0000808080000000000080FF800000FF000040FF400080FF8000C0FFC0000000
      0000000000000000000000000000000000000000000000000000FDECE300FFEF
      E400C3C7D00096EAF60088EEFF008793A00090484A002A2328005CAED60073B8
      AD0081AA96007687970000000000000000000000000000000000CF9C8000FCEB
      DD00FDEADA000B860000008E0000499E4900FCE2CC000BA00B0000800000433D
      0000FADBBF00F1C5B10066666600000000007F5B0000FFFFCC00D9A77D00D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A7
      7D00D9A77D00D9A77D00CB8C44004B4B4B000000000080808000000000000000
      000080808000000000000000000040FF400000FF000000FF000000FF000000FF
      000040FF400080FF8000C0FFC0000000000000000000E7C2B100FFF5EE00FFE1
      D200C2CCD600A1F6FC009CFBFF0077B1BD009A5F650061323400465F6C0075B5
      B90082A69F0084919B0000000000000000000000000000000000D5A28300FDEE
      E000FDECDD005A935A004B9A4B00FCE6D300FCE4D100FBE2CD0000A900000080
      00005B351E00F2C8B50066666600000000007F5B0000FFFFCC00D9A77D00D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A7
      7D00D9A77D00D9A77D00CB8C44004B4B4B000000000080808000000000000000
      000080808000000000000000000040FF400000FF000000FF000000FF000000FF
      000040FF400080FF8000C0FFC0000000000000000000F0CCB800FFFAF500FFDD
      CE00C3C5CB00B7DAE200BBDEE600B1D9E3007E6E740099585D00372424007F8A
      A400879CC2000000000000000000000000000000000000000000DCA98700FEF0
      E500FDEEE100FDECDF00FDEBDB00FDE9D800FCE6D500FCE5D100FBE3CE000BA3
      0B00067B00005339190066666600000000007F5B0000F6CACA00D9A77D00D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A7
      7D00D9A77D00D9A77D00CB8C44004B4B4B000000000080808000000000000000
      0000808080000000000080FF800000FF000040FF400080FF8000C0FFC0000000
      00000000000000000000000000000000000000000000FCE9DF00FFFCFB00FDDF
      D400FADACF00F4C9B900F5C2AD00FCC8B000CCB8A80091626800744443001D15
      38003B3F9D000000000000000000000000000000000000000000DCA98700FDF3
      EA00FDF1E600FDEFE300FDEDDF00FCEBDC00FDE9D900FDE7D600FCE5D300FCE4
      CF0007A80700008000004A3E1100000000007F5B0000F6CACA00F6CACA00FFFF
      CC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFFCC00FFFF
      CC00FFFFCC00FFFFCC00D9A77D004B4B4B000000000080808000000000000000
      0000808080000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F2D6C400FFFEFE00FFECE600FFDF
      D300FFDED200FEDACD00FED0BC00FFD5BC00F6E1D00090666300A9656D00492A
      21001A154D0058578A0000000000000000000000000000000000DCA98700FDF5
      ED00FEF3EA00FDF2E700FDEFE400FDEDE100FDECDE00FCEADA00FCE8D700FCE6
      D300FCE4D00008A90800047E000055381A007F5B0000A3760000A3760000A376
      0000A3760000A3760000A3760000A3760000A3760000A3760000A3760000A376
      0000A3760000A3760000A37600004B4B4B000000000080808000000000000000
      0000000000008080800080808000808080008080800080808000C0C0C0000000
      000000000000000000000000000000000000DEC5B200DFD9D600DCCBC600DEC8
      C000F0DFD900FEE8DF00FDE1D700FFEADF00EECBBA00927E7800885C60008E56
      5E001A134D002B2DA10000000000000000000000000000000000DCA98700FEF8
      F200FEF5EE00FDF4EC00FDF2E800FDF0E500FDEEE200FDECDE00FDEADA00FCE8
      D800FCE6D400F4C9BA0011A71100215F00007F5B0000AA9F0000F6CACA00A376
      00009DA900009DA90000AA9F00009DA900009DA900009DA90000A3760000F6CA
      CA00A3760000F6CACA00A37600004B4B4B0000000000C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004040400080808000C0C0C00000000000F6E1D000ECD2C400E6C5B800D08E
      7C00D1C9C700FFFFFF00FFFFFF00FFFFFF00DCB19F0000000000706B7A008667
      BA006E4C99005E4B710000000000000000000000000000000000DCA98700FFFA
      F700FEF8F300FEF6F000FEF4EC00FEF2E900FDF1E600FDEFE200FFD5CC00FFD5
      CC00F5B3AA00B3887E0066666600488F48007F5B0000AA9F0000AA9F0000AA9F
      0000AA9F0000AA9F0000AA9F0000AA9F0000AA9F0000AA9F0000AA9F0000AA9F
      0000AA9F0000AA9F0000AA9F00004B4B4B000000000000000000404040000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004040400080808000C0C0C0000000000000000000FDFDFD00FFF7E900E8B8
      A600DCCFCC00FFFFFF00FFFFFF00FFFFFF00CAA4940000000000000000004F3B
      73007F5048000000000000000000000000000000000000000000DCA98700FFFD
      FB00FFFBF700FEF9F400FEF7F100FEF5ED00FDF3EB00FDF1E700F7A64300F7A6
      4300E0924100666666000000000000000000A37600007F5B00007F5B00007F5B
      00007F5B00007F5B00007F5B00007F5B00007F5B00007F5B00007F5B00007F5B
      00007F5B00007F5B00004B4B4B0081818100000000000000000000000000C0C0
      C000808080008080800080808000808080008080800080808000C0C0C0000000
      0000000000000000000000000000000000000000000000000000FCFBF800EDCC
      BD00DBD2CE00FFFFFF00FFFFFF00FFFFFF00E0BAA90000000000000000000000
      0000000000000000000000000000000000000000000000000000DCA98700FFFF
      FF00FFFEFB00FFFBF800FEFAF500FEF8F100FEF6EE00FDF3EC00DCA98700EAB3
      7700666666000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E0C1AF00F4D9C700F0D3C300F0CEBC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DCA98700DCA9
      8700DCA98700DCA98700DCA98700DCA98700DEAB8800D6A38400DCA987006666
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000600060000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000000000004060600000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BBA6AA009F959600AA9B9B00B9A4A400AD989800BEA4A700D4B5
      BA00000000000000000000000000000000000000000000000000000000000000
      00000000000060006000600060008F00D0007F007F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080004040400080C0A0004040400080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009994950092929200A19C9200BAB59E00BAB79E00BEB5A200C1A8A500D4B0
      B000AF9A9D000000000000000000000000000000000000000000000000006000
      6000600060008F00D000CF67CF00D0E7E000BFBFBF007F007F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080A0A0004040400080A0A0004060400080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000739EDC000A71E500446EAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002F7F
      2D0085978100D6C7A400FFEFC600EFE9E000617EF600FFF8EB00F5F1D400AFA7
      9700DFB7B700C2A7AB0000000000000000000000000060006000600060008F00
      D000CF67CF00D0E7E000D0E7E000D0E7E000BFBFBF00BFBFBF007F007F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000002020008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000E79E8000088FC002C5FA3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000538F4C004DDF
      7A0022882700EFE5B500FFE7B800FFE0AD00FFDBA800FFE2BB00FFF6ED00FFFA
      E700B1A59800CDACAC0000000000000000007F007F008F00D000CF67CF00D0E7
      E000D0E7E000BFBFBF00BFBFBF007F007F00909790008FA7AF00BFBFBF007F00
      7F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080A0A000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001E6CC300009EFF000086F100386A9E00546D8F00767C88000000
      00000000000000000000000000000000000000000000569E59002CB44F004CE4
      7F0055EA8400468F3700FFE9B700FFE6B400FFE5B300FFDEAB00FFDAAA00FFF9
      F300ECE7C700CAABAB00C1A6AA00000000007F007F0090979000D0E7E000BFBF
      BF008FA7AF007F007F007F007F0090009000000000008087800090979000BFBF
      BF007F007F000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000404040000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000000000003275
      BD000B83DE00009EFF0000A6FE0000A6FE0000A6FE000099F600097ED9003161
      9E006A738200000000000000000000000000569E59002CB44F0032CA630041D9
      74004FE7810043CE690081B06500FFF7C400FFE2B000FFE2B000FFDEAC00FFE7
      C600FFFAE700C1AEA500B39C9E00000000007F007F0090979000BFBFBF007F00
      7F007F007F00CF00CF00CF00CF00CF00CF009000900000000000606760009097
      90008FA7AF007F007F0000000000000000000000000000000000000000000000
      000000000000808080004040400080C0A000408060004060600080A0A0000000
      0000000000000000000000000000000000000000000000000000097ED90000AA
      FE0000AFFF0000AFFF0000AFFF0000AFFF0000AFFF0000AFFF0000AFFF0000AA
      FE000B78D2005A6982000000000000000000187E1C00187E1C00187E1C0036CE
      68003BCC6700187E1C00469540008C9979005D5D5D008C7A640099866E009986
      6E00AFBDF10097949700C4AAAC00000000007F007F007F007F007F007F00CF00
      CF00CF00CF009000900090009000CF00CF00CF00CF0090009000000000006067
      600090979000808780007F007F00000000000000000000000000000000000000
      00000000000080A0A0004060400080808000FFC0C000406060004060600080A0
      A00000000000000000000000000000000000000000000F85E00000B9FE0000B9
      FE0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000B9FE0000B9
      FE0000AFFF001173C700797D8500000000000000000000000000187E1C0028C0
      4F000F841E00BFD9B900FFFFDE00BFBFA5007A7A7500413E3A00F2F2CF00E6C9
      9D00AFBAE8009B979A00BEA8AA00000000007F007F00FF97FF00CF00CF00CF00
      CF00CF00CF0000FFFF002FC8FF002F679000900090007F007F00900090000000
      000060676000909790007F007F00000000000000000000000000000000000000
      0000000000000000000080A0A0004060600080A0A000FFC0C000406060004060
      4000000000000000000000000000000000005E98D70000AAFE00006DD0000072
      D200006DD0000072D20000C0FF0000D1FD0000C0FF000077D500009CEB000072
      D200009BF00000AAFE0044709E00000000000000000000000000187E1C0028C0
      4F000F841E00AFCFAF00FFFFEB00FFFFE000F2F2CF005A5A5200816F5C00FFE4
      B800FFEFC4009C969300AC9C9E0000000000000000007F007F00FF97FF00CF00
      CF00CF00CF00CF00CF00CF00CF0000FFFF0000FFFF002FC8FF002F6790007F00
      7F0000000000606760007F007F00000000000000000000000000000000000000
      000000000000000000000000000080A0A0004060600080A0A000FFC0C0004060
      4000404040000000000000000000000000003E9BE00000C0FF00004BBC000061
      C600004EBE000061C60000D1FD0000DDF90000D1FD000065C9000065C9000065
      C9000072D20000B9FE003A73A80000000000000000000000000073936F000C90
      160028C04F000F841E00FFFFFF00FFFFF700FFFFE500F2F2C6005A5950009984
      6E00CDC0A00092929200C7AEB2000000000000000000000000007F007F00FF97
      FF00CF00CF00CF00CF00CF00CF00CF00CF00CF00CF002FC8FF0000FFFF006000
      60007F007F00000000007F007F00000000000000000000000000000000000000
      000080A0A00040606000000000000000000080A0A0004060600080C0A00080A0
      A00000000000000000000000000000000000459DDF0000CAFF00005DC5000065
      C9000061C6000065C90000EAFE0000EAFE0000C1F0000041B7000041B7000041
      B7000053C10000B9FE003A73A800000000000000000000000000000000005597
      56000C94180018A72F0046974A009FC69F00BFD9BF00AFCF9C00B9BF8F00DBC6
      A0009D9C99009994950000000000000000000000000000000000000000007F00
      7F00FF97FF00CF00CF00CF00CF0000FFFF0000FFFF0000FFFF002F97CF006000
      60007F007F007F007F0000000000000000000000000000000000000000000000
      000040404000808080008080800000000000000000004040400080A0A000FFFF
      C000000000000000000000000000000000000000000000C0FF0000C1F00000A2
      E30000C1F000009EDE0000EAFE0000F1FF0000DDF900008AD800008AD800007F
      D5000094E10000AFF4007992B300000000000000000000000000000000000000
      000089B68900278C2E00129023000F841E00187B190081A25700D3C2A200A9A7
      A400A4A2A2000000000000000000000000000000000000000000000000000000
      00007F007F00FF97FF00CF00CF00CF00CF002F6790002F679000600060007F00
      7F007F007F006000600000000000000000000000000000000000000000000020
      200080A0A000FFC0C00040606000002020000020200040606000FFC0C00080C0
      C00000202000000000000000000000000000000000002B96DC0000E5FE0000EA
      FE0000F1FF0000FDFF0000F1FF0000F1FF0000F1FF0000EAFE0000EAFE0000EA
      FE0000D1FD003D81C10000000000000000000000000000000000000000000000
      0000AFAFAF00AFAFAF00CCD9CC00B6C0B000D3CBC100B8B8B800C4C4C400AFAA
      AB00000000000000000000000000000000000000000000000000000000000000
      0000000000007F007F00FF97FF00CF00CF00CF00CF00CF00CF00900090006000
      60000000000000000000000000000000000000000000000000000000000080A0
      800040404000FFFFC000FFFFC00080C0C00080C0A000FFC0C000FFFFC0000040
      200080A0A0000000000000000000000000000000000000000000309CDC0000E5
      FE0000FDFF0000FDFF0000FDFF0000FDFF0000FDFF0000F1FF0000EAFE0000C1
      F000448BC8000000000000000000000000000000000000000000000000000000
      00000000000000000000AFAFAF00AFAFAF00AFAFAF00AFAFAF00AFAFAF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F007F00FF97FF00CF00CF0060006000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800040404000FFC0C000FFFFFF00FFFFFF00FFFFC000404040008080
      8000000000000000000000000000000000000000000000000000000000000000
      00003BAEE0000DCCEC0000EAFE0000EDF80002DDF6000DB9E50037A2D6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F007F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000075AFDB0075AFDB007AADDB0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E9AD
      8F00E9B29600C1998300A78E7D008F8781000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000678867004378440055775600667D6600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005D885D0029752B000A750D00097A0E000A750D001D7020003F6F4000797E
      7900000000000000000000000000000000000000000000000000000000000000
      00005864CD004953C1005A67C200000000000000000000000000000000000000
      0000000000007187980000000000000000000000000000000000E4AF9800FBE8
      DF00FFFFFF00FFEAD400DBA5A0006D60B200A0859900C1A185009F8D80008D88
      8400000000000000000000000000000000000000000000000000000000000000
      00005084510018771A00087F0E0004820A00077D0D000E7511002D6E2F006B77
      6B00000000000000000000000000000000000000000000000000000000001C79
      1E00078D1000099F160004A2120004A21200079C13000692100005880C001373
      16004F6E50000000000000000000000000000000000000000000000000000000
      00009098CE00BEC4DE008489C900000000000000000000000000000000004C7F
      A5003092D3002A8FD400347AAD00000000000000000000000000EEB8A100FFFF
      FF00FEE3D900A894BD002B51EA000030FF001942F000D3C7D800FFECCB00EEBD
      9900B29295009F8D80000000000000000000000000000000000000000000157D
      1900099B15000AA91A000AA91A000AA91A0000A4100001980C00058A0E000E75
      1100496D4A00000000000000000000000000000000000000000018881E0010B2
      220010B923000FBC220028C23B001ABC2D0000B1120008AE180004A212000692
      100004790800496D4A00000000000000000000000000BF593A00BA664600955C
      480086706A000000000000000000000000003A84BC002886C8003087C30051B8
      F10054BBF4003BA1E1004287BB00000000000000000000000000F9DED300FFFF
      FF00F7C1B3007789D0005CA0FF001E53FF000F48FF004466EF00C8AEC6005B5E
      CE00002DF4003C4DC90085808700000000000000000000000000158C1D0011B9
      260011B9260011B926000CB81F0001B4150036C03F0027BB340000A410000692
      1000077D0D005577560000000000000000000000000024852B001BBD320016C0
      2C000FBC22002EAE3700E8E1C300DCE9CA0051CC620000B1120006B2170009A5
      1600069210000A750D006977690000000000C6492400E15F3C00FFDDCD00FDDF
      CC00ECAE9200D9825D009D5C3E001760B1002594F70050B2EA0052B9F1005AC0
      F7003E9AD40000000000000000000000000000000000E19F8800FEF4ED00FFFF
      FF00FBE8DF00D3A7AB0085B5ED00609DFF00295FFF002355F8001C44E6000B46
      FF000B46FF000030FF003D49B800000000000000000037913E0023C43D0018C0
      2E0018C02E000EBB260011B9260087CD7600F9DABB00DEE6C60013BA280000A4
      100006921000137216007E817E00000000007FAD7F0030BB4A0025CE41001CC1
      32000EB9270065B46100FFEADE00FFE4D100FFEADE0080D8890006B2170000B1
      120004A2120005880C00336C340000000000CC543200DF613E00FCE4D800FFFF
      F700BCB9DB005256C80059446E000E72B20008CCFF003DB2F40054B9F40055C2
      FA003C8BC10000000000000000000000000000000000E69E8400FFFCF700FEF4
      ED00FFFCF700FDE4D100C5A3AF005587F3003971FE00366DFE002D66FF002359
      FF00174CFF002D42C70000000000000000000000000035BE52002AD249001DC5
      360012C12D0032C44400BCDEAD00FFEADF00FFE0CA00F5EAD5001DBC320008B4
      1A0008A1140004820A004C724D0000000000479D500045E26C0020C63A0025CE
      410015BD2F006FBA6E00FFF1E900FFE9D800FFDFC600FFE6D800B9E4B40020C6
      3A0005A71400069210001373160000000000CE5C3900E1664200FBE3DA00FFFF
      F9009490CE00041AC800251F8900435A680008AACF0000A9F6000195FF004985
      BB000000000000000000000000000000000000000000EDAD9800FFFCF700FFF0
      E200FFF8EF00FFEED900CC9DA8003F67E9004984FF00467DFE003971FE002D66
      FF003343AF0000000000000000000000000071A9730042D867002ACF470021C9
      3E005FD07000E6F1DF00FFF9F400FFEFE300FFE8D700F1EDD9001DBC320008B4
      1A000AA91A00069210002B702D0000000000299838004BE7750029CD46002CD0
      4A001CC339006FBD7300FFF6F200FFF0E400FFEADE00FFDFC600FFDDC900D6E7
      C4001ABC2D0004A212000479080000000000D1654200E36C4800FAE2DC00FFFF
      FE009496D8000932EF001D3CE300493159003F282B00384963006691BD00B875
      600000000000000000000000000000000000E4AF9800F3BCA900FBE8DF00FFF0
      E200FFDBC600AA8BB100527DEC00609DFF00609DFF00558FFF00467DFE003971
      FE002C4BD0006B6B7B00000000000000000049984C004DEA78002AD2490049BF
      5A00FEFAFA00FEFAFA00FFF9F400FFF4ED00FFEFE300F1F1E00021C0360008B4
      1A0008B41A00099B15001F6F210000000000269634004EEA790033D5530033D5
      530025CE410071C07800FFFAFA00FFF1E900FFF0E400FFE9D800FFE2CF00E3E2
      BF001ABC2D0004A212000A7E100000000000D5714D00E5745000FAE3DD00FFFF
      FF0097A1E9003152EF006789FF005F6EDD00413EA30092788D00FFECCC00C57A
      5D000000000000000000000000000000000000000000F2A88D00FDC8AA00FDC8
      AA00F5AF97007184D10074BCFF0077B5FF00639AF5005886EA0066A2FF003971
      FE002D66FF002E46BE007979870000000000569F5A0058F1870035DA5A0041B0
      5000EBF0EA00FEFAFA00FEFAFA00FFF9F400FFF4ED00F1F1E00023C43D0011B9
      260008B41A00099B15002271240000000000319A3E0057F186003EDE64003EDE
      64002CD04F0073C27C00FFFAFA00FFFAFA00FFF1E900FFF1E900E0E5C6004EC4
      4F0006B2170008AE18000A7E100000000000DA7E5900E77E5900F8E0DA00FFFF
      FF009EB1FB00223EDF005F72E300778AEC007182EA00EAE3E200FFF8E500C178
      5D000000000000000000000000000000000000000000FBE8DF00FFF0E200F9D5
      C300F2987600D498930079A0E30076A6EE00ADA7CA00C499A6006595EE004984
      FF00366DFE001E53FF004653B600000000007EB37F0053E6800050F07E0031CF
      540049B25800CAE1CB00FEFAFA00FEFAFA00FEFAFA00F2F7EB0023C43D0011B9
      26000EB82100099B15003B783D000000000056A25A005EF58F0051EF7D0049E6
      730035D75B0078C78300FFFAFA00FFFAFA00FFFAFA00BFE7BA0033C544000FBC
      22000FBC220009A516001D70200000000000DE8C6800EA896500DB604000F19A
      7C009887C3002242E5002242E6001D3EE700899BF200FFFFF400FFF9EF00C178
      5E00000000000000000000000000000000000000000000000000FDE4D100FFFF
      FF00F6CDBD00FABA9700E4CAC500E6D1CD00FBE8DF00FFDDBD00AA8AAD002E62
      F7002359FF003C54D20000000000000000000000000033B54E0064FF990051EF
      7E003ADD63002FB14500A0CDA200FEFAFA00FEFAFA00F5F9F10027C43E0011B9
      26000EB82100058A0E006E8F6E00000000000000000041C9630068FF9F0057F1
      86003EDE640065BC7000FFFAFA00FFFAFA0094E4A00025CE410013C02D0013C0
      2D0010B92300089412005284530000000000E49E7900EE987400D3421E00E04A
      1C00863F6C001C33D1002439D4001333E2007C80DA00FFEAD800FFFFFC00C078
      610000000000000000000000000000000000000000000000000000000000FDE4
      D100FEE3D900FDC3A000FFDDBD00FFE1C300FFE4C900FBE8DF00FDC3A0006C58
      8E007A84BF00000000000000000000000000000000004C9C51005CF18C0063FE
      970051EF7E0041E46B0023B83E006FBB7600E5F1E5009DE6A70012C12D0013BA
      28000EAC1F00217A24000000000000000000000000003D9643005AEA880067FF
      9C004EEA79003BBB5300B1E4BA006DE1850022CD41001CC339001CC1320013C0
      2D0010B222001C791E000000000000000000E29C7600FFD4AE00EC8C6700E468
      4000C2554B00783B78004736A6003737BA0083498200F1744600EC8E7100BC64
      4700000000000000000000000000000000000000000000000000000000000000
      0000F9DACB00FDC3A000FDE4D100FFE4C900FFE1C300FFEAD400F6C4AF009E80
      76000000000000000000000000000000000000000000000000002B95370060F3
      910064FF99004DEA78003CE1630024C341002EC1440021C93E001DC536001DC5
      3600158C1D000000000000000000000000000000000000000000288D2F0058E7
      860067FF9C0057F1860038DF60002AD44D002CD04A0023C93D0028D045001CC1
      320018881E0000000000000000000000000000000000D7937400E5A58100F2AD
      8700F8A27800FF986A00E2735500D7624A00D85F4400E05F3A00E5633F00C15D
      3D00000000000000000000000000000000000000000000000000000000000000
      000000000000E6957E00E0877000EAA08900F5C7B400FFEAD400ECA99400BC9A
      8E00000000000000000000000000000000000000000000000000000000003E9D
      48004BD672005FF7910057F687004EF27C003CE163003ADD63002FC04C002A8D
      3200000000000000000000000000000000000000000000000000000000004D9C
      51003BBF590058E786005AF58B004EEA790049E6730043DD690034BE5000388D
      3E00000000000000000000000000000000000000000000000000000000000000
      0000DDAB9700D7856500E8876200F0815900E8704A00E2634000D1542F00BC81
      6D00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E28F7800DD7557000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000459C4C0033AA480040BA5A0033AA4800459C4C0080AE81000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000064A5660045A250002998380045A25000559C5A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D7937D00CB765C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000004A8C0000397300003973000039730000397300000000000039
      7300003973000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007070700070707000707070007070700070707000707070000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000004A8C000084FF00008BFC00127EC90000468E0000397300007F
      F9000055BE000039730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E1BCAE00DDB4
      A600CAA4960090837E000000000000000000000000000000000000000000434E
      AE002E3AAA006B6D840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000070707000707070007070
      7000707070000176A9000171A3000273A5000275A800016FA200707070007070
      700070707000707070007070700070707000000000000000000000529C00004A
      8C0000000000004A8C0025A4FD0033AEFE0044B9FE00007FF9000070CE0033AE
      FE001289EB000074DA0000397300000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7BFB100FFF0E200FFFA
      F200FFFFFB00E9CDC1009F847B000000000000000000747DC0001339E200073E
      FF000840FF002039C00073737B00000000000000000000000000000000000000
      0000000000000000000000000000000000002626260026262600262626002626
      26002626260015ADD9002BC1EB0029B9DE0028C0EA00057EAF00262626002626
      2600262626002626260026262600707070000000000000529C000079F300006E
      DD00004A8C001C80CD0093D7FF00B6E4FF0093D7FF0084D2FF0084D2FF0067C7
      FF0050BFFF00259FF0000039730000000000C8887300CC563200D7816200B367
      4C009558440086685E00878280000000000000000000E8B79D00FFE0C500FFE5
      CF00FFECDD00FFF0E200DFBAAA00000000007981D000578FFA00336DFF000840
      FF001248FF001248FF00333FA2000000000000000000000000006D72A8001A35
      CB004046950000000000000000000000000099999900FFF1DF00FFF1DF00FFF1
      DF00FFF1DF0024ACD70073D6EE007FE5FF006CD5F1000F87B700FFF1DF00FFF1
      DF00FFF1DF00FFF1DF00262626007070700000529C000088EF00008BFC004EBA
      FE0067C8FF0039B6FF0093D7FF007DCFFF0067C8FF0067C8FF0050BFFF0050BF
      FF0050BFFF00003A8E00005AB50000000000CA4E2C00E1613E00FACEBC00FFF5
      E900F9D2BD00EAA98D00D7816200A75B410095584400E2B79A00FFDDBA00FFD4
      B200FFE0C500FDD8C000D1A79700000000000000000080BCFE0080BCFE002960
      FE00194EFF001D53FF00194EFF00464C8F0063658400263CBF000938F4000038
      FF000330F0004D52890000000000000000009999990099999900999999009999
      9900999999004DB6D800DAEBEF00FFFFFF00D4EEF5001590BE00999999009999
      99009999990099999900999999000000000000529C00006DC60048BCFF00FFFF
      FF00B6E4FF0067C8FF00389CDA0000396B0000396B0000396B0000396B001F92
      DA0029B0FF0029B0FF0029B0FF0000397300CC563200E1613E00F7C9B800FFFA
      F200FFF8ED00FFF0E200FFF0E200FDD8C0009263520086685E00F7DEC800FFF0
      E200F5DEC600CF9D88000000000000000000000000008292D60095D6FF0070AA
      FD002960FE00265CFE00265CFE002147E7001A42E5001248FF001248FF00073E
      FF000038FF000C30E00067699E00000000000000000000000000000000000000
      00000000000025A7D20040B2D90034AED6002EABD50047AED200707070000000
      0000000000000000000000000000000000000000000000529C0000529C00B6E4
      FF007BCFFF002587C50000396B0000000000000000000000000000427B000039
      6B0029B0FF0029B0FF0029B0FF0000397300CF5D3A00E4674200EEC1B600EDF5
      FA00FFF5E900FFF5E900FFF0E200FFE5CF00644F4A0050373B00B57E7700F1BF
      B5008F736B000000000000000000000000000000000000000000789DE2008AC9
      FF00578FFA002960FE003168FF002960FE00265CFE001F54FE001248FF001248
      FF000038FF001433D9008485BD00000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      0000000000000000000000000000000000000000000000529C000070CE0081D1
      FF0058C2FF0000528C0000000000000000000000000000427B00004399000039
      6B0029B0FF0029B0FF00037BCE0000397300D4684400E56840007F8B9C005DCF
      FF00D6E6F300FFF5E900FFF8ED00E7BAA70051393900724D5400BC727A008855
      5D006A6C6E000000000000000000000000000000000000000000000000005981
      E3003A72FE003A72FE003A72FE00366EFE002960FE002960FE001F54FE00194E
      FF002F48CF000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      00000000000000000000000000000000000000529C00008EFF002AADFD0058C2
      FF004ABDFF00004E9400004A8C00004A8C0000427B000060B200004399000039
      6B0029B0FF00089CF6000033730000000000D9745000DE6C4800708DAD0053C9
      FF00D3E8F800FFFFFB00FFF5E900FCBDA200977366007B515800A56771007347
      4000000000000000000000000000000000000000000000000000000000003F53
      C4004079FF004D85FE004079FF004079FF00366EFE003168FF002455F600444D
      9E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      00000000000000000000000000000000000000529C0067C8FF0087D3FF004ABD
      FF0039B6FF0000529C00005DBC000084DE00008CF8000062C300004A8C001474
      B50008A3FF0008A3FF0008A3FF0000397300DA7F5B00E87B5400EAA79800DDEF
      FF00FFFFFB00FFFFFB00FEF5EF00FCBDA200F8C8AC00D4BBB300D3B2A400C578
      5C000000000000000000000000000000000000000000000000004C61C100578F
      FA005B95FF00578FFA00578FFA004079FF004079FF00366EFE00295BF5004D52
      8900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      00000000000000000000000000000000000000529C0058C2FF0054C0FF0029B0
      FF0029B0FF001F99E60000529C0000529C00004A8C00004A8C00147DC50008A3
      FF0008A3FF0008A3FF000181D30000397300DF8F6A00E8835E00DB583700EB86
      6800E09C89007EC6EB0070D3FF00D6DBE200F9D2BD00FFDECB00FFF8ED00CE89
      700000000000000000000000000000000000000000003C63E400609DFF0067A1
      FE00659FFE00659FFE005B95FF005088FE004079FF003A72FE003168FF002455
      F60059597C000000000000000000000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      0000000000000000000000000000000000000000000000529C0000529C000052
      9C0029B0FF0029B0FF0029B0FF0029B0FF0029B0FF0008A3FF0008A3FF000798
      F100046EB90008A3FF000039730000000000E6A17C00F09E7900D4452200DC45
      1D009B44390048D1F10068F4FF0091ACC800FDB39A00DBC2BD0094D4FA007EA4
      C500667F9600000000000000000000000000848CD40073B1FF007CB8FE0070AA
      FD0073B1FF006DA9FD005A8EF40070AAFD00659FFE003A72FE00336DFF002960
      FE002644CD006B6B7B0000000000000000000000000000000000000000000000
      0000000000000000000099999900999999009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000052
      9C0029B0FF0029B0FF0008A3FF0008A3FF0008A3FF0008A3FF0008A3FF00004A
      8C0000397300003973000000000000000000DE967300FFD6AF00F19C7700E673
      4D00C05031006E788A006B9FC200C55E4B00E65227008A5F590052E5FF0074F0
      FF005993B80000000000000000000000000000000000789DE20095D6FF008AC9
      FF0070AAFD00607CD1008A8BC1006A94E40073B1FF005088FE003168FF002960
      FE001F54FE003044B60081819700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000052
      9C0008A3FF0008A3FF0008A3FF0000529C000181D30008A3FF000DA8FF00004A
      8C000000000000000000000000000000000000000000D6987D00DE9A7800EEA9
      8200FAAA8200F28C6400E87B5400EC6A4300D84D22005B7694005EECFF0082EE
      FA0052ADE20000000000000000000000000000000000000000006B8CDB00779F
      E4008A8BC1000000000000000000000000005F97FB00578FFA00366EFE002960
      FE00265CFE001A42E5007376B200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000529C0000529C0000529C000000000000529C0000529C00004A8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D68E7100E3835F00EF835F00E76F4A00CA4E2C00736F75006EAB
      D500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007C89D7004079FF00336DFF00265C
      FE002049EA007D81C10000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D9968200CF725400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004B5CD1002147E700656E
      CA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002B007A002D017E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000828282008282
      82007B7A7A009C9C9C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006E6E6E006E6E
      6E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002A007D003E0AA4002D017E000000000000000000A7A7A7007373
      73007373730059595900595959004B4B4B004B4B4B003D3D3D00303030003030
      300030303000A7A7A70000000000000000000000000000000000FBE7C400F3C8
      9C00A98A730062605E0076767600878787008787870087878700878787008787
      87000000000000000000000000000000000000000000795FEA002900DF003F28
      A600656565000000000000000000000000000000000000000000000000000000
      00006250B2002E07D80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000029007C004C1FB400836BE300562FB50000000000A7A7A70063360000CDCD
      CD00E6E6E600C1C1C100C1C1C100CDCDCD00F0F0F000EDEDED00E6E6E600A7A7
      A7003333330030303000A7A7A700000000000000000000000000EAC8A900FEE4
      BC00FBD8AE00DAB18D00B8977900B8977900A98A7300A98A73008B786A008B78
      6A006C6B690087878700000000000000000000000000795FEA002900DF00300A
      DB00534E6A006565650000000000000000000000000000000000000000004629
      C3002900DF005A46B60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003818
      6D00562DBD00A699F600613BBD0000000000633600006336000063360000DADA
      DA00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600DADA
      DA00CB8C4400633600003030300030303000000000000000000000000000E4CA
      B700EBD3B400FADEB800FEDCB300FEDCB300FEDCB300FEDCB300FEDCB300F9D2
      A500CB9E7B007669600087878700000000000000000000000000795FEA002900
      DF003D1CD2005F5F5F00000000000000000000000000000000003A18CD002E07
      D8005A46B6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000042285800613B
      C800B6AEFD00623CBC00000000000000000063360000CB8C440063360000D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00CB8C4400CB8C4400CB8C4400CB8C
      4400CB8C4400633600007F5B0000303030000000000000000000000000000000
      000000000000E4CAB700EAD8C500E4CAB700D8C6B600D8C6B600EAC8A900EBD3
      B400FEE4BC00DAB18D0071717100000000000000000000000000000000000000
      00002900DF005238C3006464640000000000000000003A18CD002E07D8005A46
      B600000000000000000000000000000000000000000000000000000000000000
      0000000000006D5F50006D5F50006D5F500000000000523E50009277A500B6AE
      FD00633BC00000000000000000000000000063360000D9A77D0063360000D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00CB8C4400CB8C4400CB8C
      4400CB8C440063360000CB8C4400303030000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D3
      CC00F2D9B900FADEB80076767600000000000000000000000000000000000000
      0000000000002900DF005137C30053505E003312C7002C06D7005A46B6000000
      0000000000000000000000000000000000000000000000000000000000006D5F
      50006D5F5000B2A39700A7968B009E8D8300796B5F009E8D8300FBF7F3006F51
      AC000000000000000000000000000000000063360000D9A77D0063360000D9A7
      7D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00D9A77D00CB8C4400CB8C
      4400CB8C440063360000CB8C44003D3D3D000000000000000000000000000000
      000000000000000000000000000090847C007171710088888800A6A19D00A696
      8C00FBE7C400F4D6B1009A9A9A00000000000000000000000000000000000000
      000000000000795FEA002900DF002C06D7002B05D6006A628C00000000000000
      00000000000000000000000000000000000000000000000000006D5F5000C2B1
      A600E5D3C800DCCBC000BDAC9F008F7F700088796A0081726300C2B1A6000000
      00000000000000000000000000000000000063360000D9A77D0063360000AA3F
      2A00633600006336000063360000633600006336000063360000633600006336
      0000CB8C440063360000CB8C44004B4B4B000000000000000000000000000000
      00000000000000000000CFB18600E3AD8200B2896D00896E57008B786A00EBD3
      B400FDEDCB00C0A28A0000000000000000000000000000000000000000000000
      000000000000000000002F08D9002900DF00472BC4006A628C00000000000000
      000000000000000000000000000000000000000000006D5F5000DCCBBF00EEE0
      D700BFAEA4008F7D62009F896300D2B47500C4A871009F8862006D5F50000000
      00000000000000000000000000000000000063360000D9A77D00633600009A9A
      9A00AAFFFF0099F8FF0099F8FF0099F8FF0099F8FF0099F8FF0099F8FF0099F8
      FF006336000063360000CB8C44004B4B4B000000000000000000000000000000
      000000000000E6BC9300F8D7AB00E6B88E00E3AD8200EAC8A900FFFDE400FDF9
      D800C0A28A000000000000000000000000000000000000000000000000000000
      0000000000003A18CD002E07D8005A46B600360FE000593DD6006A628C000000
      0000000000000000000000000000000000006D5F5000BEB0A800EEE0D700B3A3
      9800A0854F00EECC7A00FDE6AB00FBDB8C00E6C78000B1986C00635549000000
      00000000000000000000000000000000000063360000D9A77D0063360000AAFF
      FF00CDCDCD00A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700C1C1
      C10099F8FF0063360000CB8C44004B4B4B000000000000000000000000000000
      0000E6BC9300ECC49B00F8D7AB00E6B88E00D3987400EBD3B400F5E3C400B897
      7900767676000000000000000000000000000000000000000000000000000000
      00003A18CD002900DF005A46B6000000000000000000431FE2004A28DD006A62
      8C00000000000000000000000000000000006D5F5000DFD0C700C0B2AA00A185
      4D00FCDD9100FFF3D300FBDB8C00FBDB8C00D8BA7900B1986C005A4C42000000
      00000000000000000000000000000000000063360000D9A77D007F5B0000AAFF
      FF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFF
      FF0099F8FF007F5B0000CB8C44004B4B4B00000000000000000000000000DAA7
      8100E6B88E00ECC49B00F9D2A500F1CEA800DAA78100DAA78100E3AD8200CB9E
      7B006C6B69000000000000000000000000000000000000000000000000003917
      CC002900DF005A46B600000000000000000000000000000000005F40E700350E
      DF006A628C000000000000000000000000006D5F5000EEE0D70094816300E9CD
      8A00FFF4D300FBEFD100FFE18F00E8C77A00BB9F6B005B4C4100000000000000
      00000000000000000000000000000000000063360000D9A77D007F5B0000AAFF
      FF00CDCDCD00A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700C1C1
      C10099F8FF007F5B0000CB8C44004B4B4B000000000000000000D3987400DAA7
      8100E6B88E00ECC49B00FEE4BC00FFF3CD00FEECC500F4D5AD00ECC49B00E6B8
      8E000000000000000000000000000000000000000000000000003917CC002900
      DF005A46B6000000000000000000000000000000000000000000000000005F40
      E7002900DF000000000000000000000000006B5D4E00B3A59D00A0854E00FFF1
      B600FBF7F300FDDC8800E6C57A00B3996B00917D6B005A4C4200000000000000
      00000000000000000000000000000000000063360000D9A77D0098989800AAFF
      FF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFF
      FF0099F8FF0098989800CB8C4400595959000000000000000000C68E6B00DAA7
      8100ECC49B00F5E3C400F5E3C400FDEDCB00FFF3CD00FFF3CD00FEECC5000000
      00000000000000000000000000000000000000000000411DE0002900DF004629
      C300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000685A4C00796B5F0098835E00D2B5
      7400E5C57B00B99E6C00A58E6D00917D6C005B4C410000000000000000000000
      00000000000000000000000000000000000063360000D9A77D00A6A6A600F6CA
      CA00CDCDCD00CB8C4400CB8C4400A7A7A700A7A7A700A7A7A700A7A7A700C1C1
      C10099F8FF00A6A6A600D9A77D00666666000000000000000000AB694A00F1CE
      A800F5E3C400EAC8A900E6BC9300E4BE9900F4D6B100F6DCB500000000000000
      000000000000000000000000000000000000000000003610E1004D2CE1000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000005A4C42007A6851009883
      5E0098835E00867255005B4C41005A4C42000000000000000000000000000000
      000000000000000000000000000000000000A7A7A700633600007F5B0000F6CA
      CA00F6CACA00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFFFF00AAFF
      FF00AAFFFF007F5B000063360000A7A7A700000000000000000057312100D8B4
      9500E4BE9900F3C89C00F9D2A500F3C89C00D8B4950000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A4C42005A4C
      42005A4C42005A4C420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A7A7A7006336
      0000633600006336000063360000633600006336000063360000633600006336
      0000633600009A9A9A0000000000000000000000000000000000000000002A06
      0000573121006C4D3C00A27D5E00B89779000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006600004D4D
      4D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800000008000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4A49004D4A49004D4A
      49004D4A49004D4A49004D4A4900000000000000000000000000000000000000
      000000000000A0756E0074434200744342007443420074434200744342007443
      4200744342007443420074434200000000000000000000000000006600000066
      00004D4D4D004D4D4D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      0000008000000080000080000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000057545400D19494009A7979004D4A
      49009E707000DD8888004D4A4900000000000000000000000000000000000000
      000000000000A0756E00FFF8E500F7EDD900F7EBD500F4E9D100F4E9D000F4E7
      CF00F6EAD000EEDDC40075444300000000000000000000000000006600000D90
      1A00026F0400165D0E004D4D4D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800000000080
      0000008000000080000000800000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6B6D008D6C6C00EEA5A500FFAB
      AB00AF7878004D4A49004D4D4D00000000000000000000000000000000000000
      000000000000A0756E00F7EDDC00F2D9BF00F2D7BB00F0D5BA00EFD4B500EED3
      B200EED9BF00E5D0BA00754443000000000000000000000000000066000014A0
      270016AB2B0007840F00056303004D4D4D004D4D4D0000000000000000000000
      0000000000000000000000000000000000000000000080000000008000000080
      0000008000000080000000800000008000008000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008B7F7F00E29F
      9F00524945004D4D4D0000000000000000000000000000000000000000000000
      000000000000A0756E00FAEFDE00FCC59100FCC59100FCC59100FCC59100FCC5
      9100FCC59100E3D1BC00754443000000000000000000000000000066000019A5
      32001CB5360017B02D000C951700016A02001A5C11004D4D4D00000000000000
      0000000000000000000000000000000000008000000000800000008000000080
      000000FF00000080000000800000008000000080000080000000000000000000
      000000000000000000000000000000000000000000004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D007E717000DD9F
      9F003E3028004D4D4D004D4D4D004D4D4D0000000000A0756E00744342007443
      420074434200A0756E00FCF4E700F6D9BA00F7D7B600F6D4B500F6D4B200F4D1
      AD00F0DCC200E6D3C00081524C00000000000000000000000000006600001FAB
      3D0022BB44001CB5360017B02D000FA51E0003790600096105004D4D4D000000
      00000000000000000000000000000000000000800000008000000080000000FF
      00000000000000FF000000800000008000000080000080000000000000000000
      00000000000000000000000000000000000068605C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0083787800DDA5
      A500564B4600FFFFFF00645C57004D4D4D0000000000A0756E00FFF8E500F7ED
      D900F7EBD500A0756E00FEF6EB00F8DABC00F8D9B800F8D8B700F7D5B600F7D4
      B200F3DEC700E7D7C50081524D000000000000000000000000000066000023B0
      460029C2520022BB44001CB5360017B02D000FA91F0005880B00016A01004D4D
      4D004D4D4D0000000000000000000000000000FF00000080000000FF00000000
      0000000000000000000000FF0000008000000080000000800000800000000000
      00000000000000000000000000000000000068605C00FFFFFF00B0360200B036
      0200B0360200B0360200B0360200B0360200B0360200FFFFFF00867C7C00DDA9
      A90060565100FFFFFF00645C57004D4D4D0000000000A0756E00F7EDDC00F2D9
      BF00F2D7BB00A0756E00FEFAF200FCC59100FCC59100FCC59100FCC59100FCC5
      9100FCC59100EBDDCF008F5F5A000000000000000000000000000066000026B3
      4D0030C9600029C2520022BB44001CB5360017B02D000FA91F00089B10000271
      030011610B004D4D4D0000000000000000000000000000FF0000000000000000
      000000000000000000000000000000FF00000080000000800000008000008000
      00000000000000000000000000000000000068605C00FFFFFF00B0360200B036
      0200B0360200B0360200B0360200B0360200B0360200FFFFFF00867D7D00DDAE
      AE0060565100FFFFFF00645C57004D4D4D0000000000A0756E00FAEFDE00FCC5
      9100FCC59100A0756E00FFFCFA00FCE3CC00FBE0C700FADEC600F8DEC400FCE2
      C600FCF0DE00E1D7CE008F5E59000000000000000000000000000066000027B3
      4D0033CC660030C9600029C2520022BB44001CB5360017B02D000EA41D00037D
      0600066404004D4D4D0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000000080
      00008000000000000000000000000000000068605C00FFFFFF00B0360200B036
      0200B0360200B0360200B0360200B0360200B0360200FFFFFF00877F7E00DDB2
      B20060565100FFFFFF00645C57004D4D4D0000000000A0756E00FCF4E700F6D9
      BA00F7D7B600A0756E00FFFFFF00FEFFFF00FBFBFB00FAF8F700FAFAF600E5D5
      D000C6B1AF00A79395009E675A00000000000000000000000000006600002DB9
      530035CE680033CC660030C9600029C2520022BB440015A12800036F0500165D
      0E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      00000080000080000000000000000000000068605C00FFFFFF00B0360200B036
      0200B0360200B0360200B0360200B0360200B0360200FFFFFF0087807F00DDB6
      B60060565100FFFFFF00645B57004D4D4D0000000000A0756E00FEF6EB00F8DA
      BC00F8D9B800A0756E00FFFFFF00FFFFFF00FFFEFE00FFFCF800FFFEFA00A075
      6E00A0756E00A0756E00A0756E000000000000000000000000000066000032BE
      58003CD56F0035CE680033CC660030C960001494280005630300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000080
      00000080000000800000800000000000000068605C00FFFFFF00B0360200B036
      0200B0360200B0360200B0360200B0360200B0360200FFFFFF0087818100DDBB
      BB005F544F00FFFFFF00645B56004D4D4D0000000000A0756E00FEFAF200FCC5
      9100FCC59100A0756E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A075
      6E00E5A15400B6735D00000000000000000000000000000000000066000036C2
      5C0043DC76003CD56F002BBB55000A7913000F5F090000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      00000080000000800000008000008000000068605C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAF9F900FFFFFF0087818100DDC0
      C0005C514B00FFFFFF00615853004D4D4D0000000000A0756E00FFFCFA00FCE3
      CC00FBE0C700A0756E00A0756E00A0756E00A0756E00A0756E00A0756E00A075
      6E00AA6D68000000000000000000000000000000000000000000006600003DC9
      630049E27C0025A84200046D07002D581E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000800000008000008000000068605C0068605C0068605C006860
      5C0068605C0068605C0068605C0068605C00655C5800574D4700817D7D00DDC5
      C5004E423D006E615A0068605C004D4D4D0000000000A0756E00FFFFFF00FEFF
      FF00FBFBFB00FAF8F700FAFAF600E5D5D000C6B1AF00A79395009E675A000000
      0000000000000000000000000000000000000000000000000000006600003CC5
      5F00158721000961050000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000800000008000000000000000000000000000000000
      000000000000000000000000000000000000000000005F5A570090888800FFE7
      E7005A595800544B47006C5F59000000000000000000A0756E00FFFFFF00FFFF
      FF00FFFEFE00FFFCF800FFFEFA00A0756E00A0756E00A0756E00A0756E000000
      0000000000000000000000000000000000000000000000000000006600000066
      0000245E19000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      00000000000000000000000000000000000084898B00F9F1F100D1C7C7006B67
      6700DDC8C800FFE2E2004E4B4B000000000000000000A0756E00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A0756E00E5A15400B6735D00000000000000
      000000000000000000000000000000000000000000000000000000660000245E
      1900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005B5D5D008086870080868700FFFF
      FF008086870080868700808687000000000000000000A0756E00A0756E00A075
      6E00A0756E00A0756E00A0756E00A0756E00AA6D680000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFBFB00AA948A00FCFBFB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000004A8C0000397300003973000039730000397300000000000039
      7300003973000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DAD2CE00D3A2700063382100FCFBFB000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000004A8C000084FF00008BFC00127EC90000468E0000397300007F
      F9000055BE000039730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A2A0
      9F00B6B4B4009A9998008C8B8A00807F7E008686850000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E4DEDB00BE916500F9CFA50068422E00FDFDFD000000
      000000000000000000000000000000000000000000000000000000529C00004A
      8C0000000000004A8C0025A4FD0033AEFE0044B9FE00007FF9000070CE0033AE
      FE001289EB000074DA0000397300000000000E0B9E0000005B0000005B000000
      5B000962A30000336300003363000033630000A0AB0000636700006367000063
      6700009B000018610000186100001861000000000000BAB8B700B0AFAD00D5D4
      D300E3E2E100E7E6E600E5E4E400E0E0E000C8C8C700A6A5A400929191008180
      800083828200000000000000000000000000000000000000000000000000F4F2
      F100A59086007E5A4500744A3100CCAA8900F4CBA2006335190069473800B4A1
      9800F7F5F4000000000000000000000000000000000000529C000079F300006E
      DD00004A8C001C80CD0093D7FF00B6E4FF0093D7FF0084D2FF0084D2FF0067C7
      FF0050BFFF00259FF00000397300000000000E0B9E000000FF000000FF000000
      5B000962A300008AFF00008AFF000033630000A0AB0000F2FF0000F2FF000063
      6700009B000000FF000000FF00001861000000000000B2B2B000C6C4C300CDCC
      CB00D7D6D500DCDCDB00E3E2E200ECEBEB00F3F3F300F8F8F800F6F6F600EFEE
      EE00D6D5D500B5B4B4007D7D7C00000000000000000000000000C9BBB400B18C
      6700C4AA8D00C7A68500CCAB8900E7C29F00F3CDA600CFAF9000C5A580007143
      260060392800D7CDC800000000000000000000529C000088EF00008BFC004EBA
      FE0067C8FF0039B6FF0093D7FF007DCFFF0067C8FF0067C8FF0050BFFF0050BF
      FF0050BFFF00003A8E00005AB500000000000E0B9E00FFFFFF006060FF000000
      5B000962A30040A7FF00008AFF000033630000A0AB0000F2FF0000F2FF000063
      6700009B000000FF000000FF00001861000000000000B7B6B500C9C8C600CAC9
      C800D3D1D000DAD9D800DCDBDA00E2E2E100F4F4F300F5F5F400F6F6F600F9F9
      F900FEFFFF00FFFFFF00C9C8C8000000000000000000C5B0A100C5B09800D6BA
      9E00F6D4B300F8D2B000FFD8B100F6CAA400FFE5BD00F7CDA700E8C5A100CFB1
      9100BE956F004D251100DBD1CD000000000000529C00006DC60048BCFF00FFFF
      FF00B6E4FF0067C8FF00389CDA0000396B0000396B0000396B0000396B001F92
      DA0029B0FF0029B0FF0029B0FF00003973000E0B9E000E0B9E000E0B9E000000
      5B000962A3007FC4FF00008AFF000033630000A0AB0060F7FF0000F2FF000063
      6700009B000080FF800000FF00001861000000000000BBB9B800D0CFCE00C7C5
      C400C8C7C600C7C6C400D9D8D700C9C9C800CDCDCC00DAD9D800E9E9E800F4F3
      F300F5F5F400FDFDFD00D9D8D70000000000F3F0EF00C2B09C00E3CAB100FFE7
      C800FFE3C500FFE8CA00893E1800A63E0A008D431C00FFE5C300FFE0BB00FEDA
      B600D4B79900C09A730068433300FBFAFA000000000000529C0000529C00B6E4
      FF007BCFFF002587C50000396B0000000000000000000000000000427B000039
      6B0029B0FF0029B0FF0029B0FF00003973000000000000000000000000000000
      00000962A300FFFFFF0060B6FF000033630000A0AB0080F9FF0000F2FF000063
      6700009B000080FF800000FF00001861000000000000BEBDBC00D7D6D500C5C4
      C300B8B6B5007B797800C8C6C500CCCBCA00CECCCB00C6C4C300D0CFCE00EEED
      ED00F8F8F700FCFCFC00D3D3D20000000000D6C0A700DFC9B400FFE9D100FFE6
      CD00FFE5CB00FFE9CE009B613E009C300000CA977400FFE3C600FFE1C200FFE0
      C000FDDDBB00D7BFA300693B2000D0C4BE000000000000529C000070CE0081D1
      FF0058C2FF0000528C0000000000000000000000000000427B00004399000039
      6B0029B0FF0029B0FF00037BCE00003973000000000000000000000000000000
      00000962A3000962A3000962A3000033630000A0AB007FF8FF0000F2FF000063
      6700009B000080FF800000FF00001861000000000000C3C1BF00DFDFDE00C0BF
      BD00BEBDBC00B5B4B300CAC9C800C4C3C200C2C1C000C6C5C300DBD9D900EBEA
      E900BFBEBE00E4E4E300D3D2D10000000000CDBFB200FCE9D200FFEAD500FFEA
      D200FFE7D200FFEDD5009B6241009D300000C8977700FFE7CD00FFE4C900FFE2
      C800FFE5C900EBCFB400D8B69300B19D940000529C00008EFF002AADFD0058C2
      FF004ABDFF00004E9400004A8C00004A8C0000427B000060B200004399000039
      6B0029B0FF00089CF60000337300000000000000000000000000000000000000
      00000000000000000000000000000000000000A0AB00FFFFFF0000F2FF000063
      6700009B0000BFFFBF0000FF00001861000000000000C5C4C400E8E7E700BDBC
      BA00B8B7B500C4C2C100C7C7C500CBCAC900C7C6C500C3C2C100C8C7C600E6E6
      E50092909000C4C3C200D3D2D10000000000D6C8BC00FFF3E100FFEEDC00FFED
      DB00FFEDD900FFF0DC009B6343009C300000C89A7B00FFEBD300FFE8D000FFE8
      CD00FFE7CD00F9E0C700E6CFB700B09D930000529C0067C8FF0087D3FF004ABD
      FF0039B6FF0000529C00005DBC000084DE00008CF8000062C300004A8C001474
      B50008A3FF0008A3FF0008A3FF00003973000000000000000000000000000000
      00000000000000000000000000000000000000A0AB00FFFFFF007FF8FF000063
      6700009B0000BFFFBF0000FF00001861000000000000CAC9C800F2F1F100B7B6
      B400B0AEAD00BAB8B700C0BFBD00C7C7C500D0CFCE00D7D6D500DAD9D800DFDE
      DD00E7E6E600EDECEC00CCCACA0000000000D7CDC300FFF7EA00FFF2E400FFF1
      E300FFF2E200FFFFF50093471F009F300000C99C7F00FFEEDB00FFECD700FFEB
      D400FFE9D300F9E4CE00E6D4BD00B6A49C0000529C0058C2FF0054C0FF0029B0
      FF0029B0FF001F99E60000529C0000529C00004A8C00004A8C00147DC50008A3
      FF0008A3FF0008A3FF000181D300003973000000000000000000000000000000
      00000000000000000000000000000000000000A0AB0000A0AB0000A0AB000063
      6700009B0000FFFFFF0000FF00001861000000000000D2D1D100FDFCFC00C6C5
      C300A8A6A500B1AFAC00B9B7B400C0BFBE00C8C7C500CECDCC00D4D3D200DAD9
      D900E0DFDE00E9E8E800C9C7C70000000000DDD8D200FFFBF200FFF4EB00FFF3
      EA00FFF7EB00A781690084492B006D331300BD9C8800FFF1E300FFEFDD00FFEE
      DC00FFF3E100F9E5D300E1C7AC00EBE6E3000000000000529C0000529C000052
      9C0029B0FF0029B0FF0029B0FF0029B0FF0029B0FF0008A3FF0008A3FF000798
      F100046EB90008A3FF0000397300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009B0000FFFFFF0000FF00001861000000000000C8C6C500F9F7F800F7F6
      F600DEDDDC00CDCCCB00C2C1C000BEBDBC00C1C0BE00C8C6C500CECDCC00D5D4
      D300DADAD900E3E3E200C7C6C60000000000DED4CB00F1EBE400FFFFFF00FFF7
      F000FFF9F000FFFCF300FFFFFF00FFFFF700FFFFF700FFF4E800FFF4E600FFF2
      E100FFFFFF00F6EADE00A2877900000000000000000000000000000000000052
      9C0029B0FF0029B0FF0008A3FF0008A3FF0008A3FF0008A3FF0008A3FF00004A
      8C00003973000039730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009B0000FFFFFF0090FF900018610000000000000000000000000000CFCE
      CD00D4D2D200DDDCDB00E2E2E100DFDEDD00D8D8D700D1CFCE00CECCCB00D0CE
      CD00D6D5D400E3E2E100C1C0BE000000000000000000E2E3E300F9F4F100FFFF
      FF00FFFAF500FFFFFF0062080000DF864E00D4AE9900FFF9F100FFFAF100FFFF
      FF00F5EBE100DAC3AE00FCFCFC00000000000000000000000000000000000052
      9C0008A3FF0008A3FF0008A3FF0000529C000181D30008A3FF000DA8FF00004A
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009B0000009B0000009B0000186100000000000000000000000000000000
      0000000000000000000000000000C7C5C400C3C2C200C8C8C600D1D0CE00CFCE
      CC00CCCBC900B5B2B100000000000000000000000000FEFEFE00E7E7E800F6F5
      F400FFFFFF00FFFFFF0078523D003D000000FAFAF700FFFFFF00FFFFFC00F9F6
      F200DBCABC000000000000000000000000000000000000000000000000000000
      000000529C0000529C0000529C000000000000529C0000529C00004A8C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CAC8
      C700BFBEBD00000000000000000000000000000000000000000000000000DDD3
      CD00F2F4F500F5F6F700FFFFFF00FFFFFF00FFFFFE00F7F8F800FDFAF400EDE8
      E600000000000000000000000000000000000000000000000000000000000000
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
      00000000000066594B00CEC9C400B8B1AA009C918600584D4100413930000000
      0000000000000000000000000000000000000000000000000000D4CECB00C0B8
      B400BFB7B300BFB7B300BFB7B300BFB7B300BFB7B300BFB7B300BFB7B300BFB7
      B300C0B8B400D3CECB00FAFAF900000000000000000073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      730073737300737373007373730073737300000000008097DF000F2FB0001037
      B0001037B0001037B0001037B0001037B0000F37BF000F30BF000030BF00002F
      BF000028BF000027B0007F8FCF00000000000000000000000000000000000000
      8C0000008C0000008700000087000000870000007A0000007A0000007A000000
      7A0000005A000000000000000000000000000000000000000000DBA79B00D8A4
      9900D6A39800D3A09700D19D9600D19D9600D19D9600D09C9600D09C9600D09C
      9600D09C95007E6F6600F1EEED00000000007F4F3300553520005A3823005A38
      23005A3823005A3823005A3823005A3823005A3823005A3823005A3823005A38
      23005A38230058382400743E1F0073737300000000000F37D0001F40D0002048
      D0002F4FD0002F4FD0002F4FD000204FDF00204FDF001F48DF001047DF000F40
      DF000038DF000030D0000027B0000000000000000000000000000000A2002121
      D0005656FF004343FF004343FF003A3AF3003636ED003232E7002121BC000000
      7A000000860000005A0000000000000000000000000000000000F9ECDB00FFE9
      D300FFE6CD00FFE3C700FFE1C300FFDEBD00FFDBB700FFD8B100FFD6AC00FFD3
      A700FDD2BF0073615800EFEDEC0000000000614B410000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000522915007373730000000000103FDF002F4FDF003057
      DF004060E0007F90EF00DFE7F000FFFFFF00FFFFFF00DFE0F0006F90EF000F48
      E0000040E0000037DF000028BF0000000000000000000000A2002121D0003636
      ED000000D0000000B3000000B3000000B3000000B3000000D0001919E5002121
      BC0000007A0000008A0000005A00000000000000000000000000F9EDE000FFEB
      D800FFE9D300FFE6CD00FFE3C700FFE1C300FFDEBD00F9C89700FFD8B100FFD6
      AC00FDD2BF0073615800EFEDEC00000000005F493D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005128130073737300000000001F47DF003058DF003F60
      E0009FB0EF00FFFFFF00B0C7F0006F8FEF006F8FEF00B0C8F000FFFFFF0090AF
      F0000F47E000003FDF00002FBF0000000000000000000000A2005656FF007373
      FF008A8AFF00A1A1FF00A1A1FF00A1A1FF00A1A1FF008A8AFF006464F3003232
      E70000007A0000009A0000008A0000005A000000000000000000FAF1E600FFEE
      DE00FFEBD800FFE9D300FFE6CD00CE9B6E0007488F00BE855100A5877500F9C6
      9300FDD2BF0073615800EFEDEC00000000005F493D000000000048484800FFFF
      FF00FFFFFF00484848000000000000000000000000000000000048484800FFFF
      FF0000000000000000005128130073737300000000002F4FDF003F5FE000809F
      EF00FFFFFF007F97EF004067E0003F67E0003060E0002F58E0006F90EF00FFFF
      FF006088EF000F40DF000030BF0000000000000000000000A2005656FF002D2D
      EC000000D0000000B3000000B3000000B3000000B3000000D0001919E5003232
      E70000007A000000A20000009A0000005A000000000000000000FAF4EB00FFF1
      E300FFEEDE00FFEBD80095AFB8003299D0003BB7EA000E6EAC0017A3D700F2B5
      7900FDD2BF0073615800EFEDEC00000000005F493D0000000000FFFFFF004848
      480048484800FFFFFF0000000000FFFFFF000000000000000000FFFFFF004848
      480000000000000000005128130073737300000000003057DF004067E000E0EF
      FF00B0C7F0004F68E0004068E000FFFFFF00FFFFFF002F58E0002057E000B0C7
      F000D0E0F0001047DF000F37BF0000000000000000000000A2005656FF007070
      FF008484FF009595FF009595FF009595FF009595FF008484FF006161F3003232
      E70000007A000000AA0000009A0000005A000000000000000000FBF7F100FFF4
      E800FFF1E300FFEEDE000C60A0004BBFF20052B9E400249ED300149ED300004E
      9100FDD2BF0073615800EFEDEC00000000005B453A0000000000FFFFFF000000
      0000000000000000000000000000000000000000000048484800FFFFFF000000
      000000000000000000005128130073737300000000003F5FE0004F6FE000FFFF
      FF007F90EF004F68E0004067E000FFFFFF00FFFFFF002F57E0001F50E0006087
      EF00FFFFFF001F48DF001038BF0000000000000000000000A2005656FF005656
      FF005656FF004343FF004343FF003A3AF3003636ED003232E7003232E7003232
      E70000007A000000AA0000009A0000005A000000000000000000FBFAF700FFF7
      EE00FFF4E800FFF1E3004EBAD70049BEF100CCCCCC0028648200129FD300189B
      C800FDD2BF0073615800EFEDEC00000000005B453A0000000000FFFFFF004848
      480048484800FFFFFF0000000000FFFFFF0000000000FFFFFF00484848000000
      000000000000000000005128130073737300000000004060E0005070E000FFFF
      FF007F90EF004F68E0004067E000FFFFFF00FFFFFF002F50E000204FE0006080
      EF00FFFFFF00204FDF001F3FBF0000000000000000000000A2000000A2000000
      A2000000A200000097000000970000008C0000008C0000008C0000008C000000
      8C0000007A000000920000009A0000005A000000000000000000FCFDFD00FFFA
      F400007F000075872F0031CA4A0048BDF000CCCCCC0030748E0013A3D600FFE3
      C700FDD2BF0073615800EFEDEC00000000005F493D000000000048484800FFFF
      FF00FFFFFF0048484800000000000000000000000000FFFFFF00000000000000
      000000000000000000005128130073737300000000004F68E0005F78E000EFEF
      FF00B0C0F0004F68E0004060E000FFFFFF00FFFFFF002F50DF00204FDF00AFBF
      F000DFE7F000204FDF001F3FBF0000000000000000000000A2002121EC005656
      FF002121EC007572E1001414D0001414D0004343FF002121EC007572E1001414
      D0000A0AA50000007A0000008A0000005A000000000000000000FCFFFF00B0CD
      A7004CE4730042DB630030CA49001EB82E00638B4000E3B98F00FFE9D300FFE6
      CD00FDD2BF0073615800EFEDEC00000000005E4A400000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005129140073737300000000004F6FE0006F80E00090A7
      EF00FFFFFF007F90EF004F67E0003F5FE0003058DF002F50DF006F87E000FFFF
      FF006F88EF002F4FDF001F40BF000000000000000000000000000000A2002121
      EC0062599600E0DAD40050498800000083000000DA0062599600E0DAD4005049
      8800000083000000830000005A0000005A000000000000000000FDFFFF0058F0
      840052EB7B00A8E4B5006A6A6A00008B00000AA41000FCD4AC00FFEBD800FFE9
      D300FDD2BF0073615800EFEDEC0000000000A0754400705A3100765D3300765D
      3300765D3300765D3300765D3300765D3300765D3300765D3300765F3900765F
      3800765F39006C5E410084502A0073737300000000005F77E000708FEF006F87
      E000A0B0EF00FFFFFF00AFB8F0006F87E0006080E000AFB8F000FFFFFF0090A7
      EF002F50DF002F50D0001F40BF00000000000000000000000000000000000000
      A20075665600E0DAD400584D410000002D0000005A0075665600E0DAD400584D
      410000002D0000005A0000005A00000000000000000000000000FDFFFF00FFFF
      FF0044DB6600D1EAD6006A6A6A001AB32700CBAD6300FFF1E300FFEEDE00FFEB
      D800FDD2BF0073615800EFEDEC0000000000D9761300F08C1700ED8A1700ED8A
      1700ED8A1700ED8A1700ED8A1700ED8A1700ED8A1700ED891600FAB35B00FBAD
      4F00F8B35F00A38E9600A15C390073737300000000006080E0008F9FEF007F97
      EF006F87E00090A7EF00EFEFFF00FFFFFF00FFFFFF00E0E8FF008098EF003F60
      E0003058DF002F50DF001F3FBF00000000000000000000000000000000000000
      000075665600F0EDEA00584D4100000000000000000075665600F0EDEA00584D
      4100000000000000000000000000000000000000000000000000FEFFFF00FFFF
      FF00FFFFFF00E0CAB30051515100FFFAF400FFF7EE00FFF4E800FFF0E100FFED
      DB00FDD2BF007C6C6300F0EEEC00000000008A450D00B7692E00BB6B3100BA6A
      3000BA6A3000BA6A3000BA6A3000BA6A3000BA6A3000BA6A3000BD6F3600BD6E
      3500BE703700B06B3B00854918000000000000000000708FEF009FAFEF008F9F
      EF00708FEF006F87E0006080E000607FE0005F78E0005F77E0005070E0004F68
      E0003F60E0002F50D0001037B000000000000000000000000000000000000000
      000075665600FFFFFF00584D4100000000000000000075665600FFFFFF00584D
      4100000000000000000000000000000000000000000000000000FEFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFDFB00FFFAF600FFF7F000FFF5EB00E5B69100E795
      3800D5823500BAAFA900F9F8F800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AFBFF0007088EF00607F
      E0005077E000506FE0004F68E0004067E0004067E0004060E0003F5FDF003058
      DF002F50DF001F47D0008098DF00000000000000000000000000000000000000
      000075665600BAB2AA00584D4100000000000000000075665600BAB2AA00584D
      4100000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFDFB00FFFAF600FFF7F000EBC7A800FEB5
      5400B9AAA100F4F1F000FEFEFE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000075665600584D410000000000000000000000000075665600584D
      4100000000000000000000000000000000000000000000000000FFFFFF00FDFF
      FF00FCFFFF00FBFFFF00FAFEFF00F8FCFF00F7F9FB00F5F6F600EED1B000A898
      8E00F3F2F000FEFEFE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000654637006546370065463700654637006546370065463700654637004D31
      2A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003B65370028341D0000000000000000000000
      0000000000000000000000000000000000000000000011751100167A16001F81
      1F001F811F001F811F001C821C001983190016861600138A13000D880D000A87
      0A0005860500027D020000000000000000000000000000000000000000000000
      000000000000000000005F6172005F61720065688200656882005F6172000000
      0000000000000000000000000000000000000000000000000000000000000000
      000065463700D67F3E00CC7C3F0097613D0097613D0097613D0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000000000
      000000000000000000003B6537003FCC42003E973D0028341D00000000000000
      0000000000000000000000000000000000000C840C001C8E1C00299329002F98
      2F002F982F002C982C002C982C0092CB92005BB75B001EA21E0016AA16000EAB
      0E0005A205000299020002800200000000000000000000000000000000000000
      0000656882004553B9001F35DB000E24CC000A1EB7004652B00064698B006A6A
      6A005F6172000000000000000000000000000000000000000000000000000000
      000065463700D67F3E00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000000000
      0000000000003B6537003FCC420073FD760044C646003E973D0028341D000000
      0000000000000000000000000000000000001288120029932900369A36003FA0
      3F003FA03F003FA03F0036A63600FEFEFE0099D3990024B0240022AD220013B1
      13000FB30F0005A2050007840700000000000000000000000000000000006568
      8200122BEB00142EF500142EF500142EF500142EF500132DF0000E24CC004A56
      AA00656882006568820000000000000000000000000000000000000000000000
      000065463700D67F3E00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000000000
      00003B6537003ED64000BCFEBE0055DD57003FCC42003FBA41003E973D002834
      1D0000000000000000000000000000000000188E1800369A360042A14200A4D1
      A400D2E8D20042A1420040A84000FEFEFE0099D499002AB32A005BC55B00FEFE
      FE000FB30F0008A8080010891000000000000000000000000000142EF500142E
      F500142EF500223BF5000F26D6000F26D6000E25D100142EF500142EF5000F26
      D6004F5AA7006D6D6D0000000000000000000000000000000000000000000000
      000065463700D67F3E00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000003B65
      37003ED64000FFFFFF005DE45F003FCC42003FCC42003FCC42003FBA41003E97
      3D0028341D00000000000000000000000000229122003C9E3C004BA54B004EA6
      4E00D1E8D100D1E8D10042A1420099D8990067C3670064C36400FEFEFE0054C2
      540013B113000EAB0E0013871300000000000000000000000000142EF500142E
      F500142EF50000000000000000000000000000000000223AF500142EF500142E
      F5000D22C6005F61720065688200000000006546370065463700654637006546
      370065463700D67F3E00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D00341D
      1E00341D1E00341D1E00341D1E00341D1E0000000000000000003B6537003ED6
      4000C9FFCA0061E963003FCC42003FCC42003FCC42003FCC42003FCC42003FBA
      41003E973D0028341D0000000000000000002694260048A3480051A8510051A8
      510051A85100A4D1A40048A348003CA23C0036A6360062BF620059C1590022AD
      220018B01800179E1700168816000000000000000000142EF500142EF5000F26
      D60000000000000000000000000000000000223AF500132DF000142EF500142E
      F500122BEB005760A5005F617200000000000000000065463700D67F3E00FEB9
      8400FC913F00FC913F00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D009761
      3D0097613D0097613D00341D1E0000000000000000003B6537003ED6400084FE
      87003FFC43003FFC43003FFC43003FCC42003FCC42003FCC42003E973D003E97
      3D003E973D003E973D0028341D0000000000329C32004EA64E00ABD5AB00ABD5
      AB00A8D3A8004BA54B0042A1420039A0390033A433002FAA2F005ABC5A0090D6
      90008ED08E0058B65800198919000000000000000000233BF600142EF5000F26
      D600000000000000000000000000223AF500132DF000233BF600000000000F26
      D600142EF5004553B9006568820000000000000000000000000065463700D67F
      3E00FFE0C900E99B6100CC7C3F00CC7C3F00CC7C3F00CC7C3F00CC7C3F00BA74
      3F0097613D00341D1E0000000000000000003B6537003B6537003B6537003B65
      37003B6537003ED640003FFC43003FCC42003FCC42003FCC42003E973D002834
      1D0028341D0028341D0028341D0028341D00329C320054A95400FFFFFF00FEFE
      FE00FEFEFE004BA54B0045A2450039A0390033A433002FA52F0091D09100FEFE
      FE00FEFEFE0092CB92001C891C000000000000000000142EF500142EF5000F26
      D6000000000000000000223AF500142EF500233BF60000000000000000000F26
      D600142EF5005561BF0065688200000000000000000000000000000000006546
      3700D67F3E00FFFFFF00E4975D00CC7C3F00CC7C3F00CC7C3F00BA743F009761
      3D00341D1E000000000000000000000000000000000000000000000000000000
      00003B6537003ED640003FFC43003FCC42003FCC42003FCC42003E973D002834
      1D00000000000000000000000000000000003B9E3B0057AB57005BAD5B005BAD
      5B0051A851004BA54B0042A14200399C3900339C33002C9C2C0026982600229D
      220020982000269826001F851F000000000000000000142EF500142EF5000E25
      D10000000000223AF500142EF500233BF6000000000000000000000000000F26
      D600142EF5005763BC0000000000000000000000000000000000000000000000
      000065463700D67F3E00FED9BC00DD8F5500CC7C3F00BA743F0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000000000
      00003B6537003ED640003FFC43003FCC42003FCC42003FCC42003E973D002834
      1D000000000000000000000000000000000042A0420067B4670067B467005BAD
      5B0081C08100FEFEFE0042A142003C9E3C00369A360099CB9900C8E5C8002698
      260026982600299829001F811F000000000000000000142EF500142EF500142E
      F500223AF500132DF000233BF60000000000000000000000000000000000142E
      F500132DF0006568820000000000000000000000000000000000000000000000
      00000000000065463700CC7C3F00FDAF7300C67C440097613D00341D1E000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B6537003ED640003FFC43003FCC42003FCC42003FCC42003E973D002834
      1D000000000000000000000000000000000048A348006FB86F006BB66B0089C4
      8900FEFEFE007ABC7A0048A34800FEFEFE009BCD9B0033983300CCE5CC00C8E5
      C8002C982C002C982C001F811F00000000000000000000000000142EF500142E
      F500142EF500132DF00000000000000000000000000000000000233BF600142E
      F500142EF5000000000000000000000000000000000000000000000000000000
      0000000000000000000065463700CC7C3F0097613D00341D1E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B6537003ED640003FCC42003E973D003E973D003E973D003E973D002834
      1D000000000000000000000000000000000050A850007CC17C0078BC780091C8
      910088C4880057AB570051A85100FEFEFE00A1D0A1003C9E3C00399C39009CCD
      9C0033983300339833001F811F00000000000000000000000000142EF500142E
      F500142EF5000F26D6000F26D6000C21C1000F26D600142EF500142EF500142E
      F500000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000065463700341D1E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B6537003B6537003B6537003B6537003B6537003B6537003B653700324D
      2A00000000000000000000000000000000005EAF5E008FD38F0084CB840078BC
      78006BB66B0067B467005FAF5F00FEFEFE00ABD5AB0051A8510051A8510045A2
      450042A14200369A36001F811F0000000000000000000000000000000000142E
      F500142EF500142EF500142EF500142EF500142EF500142EF500142EF5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000068B4680096D596008FD38F0078BC
      780073BA730067B4670067B4670063B163005FAF5F005BAD5B0057AB57004EA6
      4E0042A142002F982F001F811F00000000000000000000000000000000000000
      000000000000142EF500142EF500142EF500142EF50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000061B1610057AC570049A3
      490045A1450042A0420042A042003F9E3F003B9E3B00389E380032973200329C
      3200269126001D8B1D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000D00000000100010000000000800600000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FE7FCFFF8001FFFFFE3F87CF0000FFFF
      F81F838700000000F80F810300000000F807C00300000000F003E00700000000
      C00FF00F000000008007F81F00000000C00FF81F00000000C007F01F00000000
      E003E00F00000000E001C10700000000E003C38300000000F807E7C300000000
      FE0FFFE300008001FF9FFFFF0000FFFFFFFFF87FC003FFFFFFF3E007C003CFFF
      8003C000C00387F300038000800183E3000180008001C3C7000180008001F18F
      000180008001F81F000080008001F83F00000000C003FC3F000000008003F81F
      000100018003F18F000380038003E3C70007E007C003C7E781FFF00FF0038FFF
      C3FFF80FF8039FFFFFFFFF8FFC03FFFFFFFFFFFFFFFFE001FFFFE01FFFFFC001
      0000C001F807C00100008001D003C0010000801F8003C001000087FFC003C001
      0000841FC003C001000086018003C001000086018007C0010000841F8007C001
      000087FF0003C0000000801F0003C000000080010043C0000000C0018067C003
      0000E01FC07FC007FFFFFFFFF0FFC00FFFFFFE7FFC7FFFFFF80FF83FF83FFFFF
      F007E01FF83FF1FFE003800FFC7FF8FFC0030007FC3FF81F80010003F83FE007
      00010001F81FC00300010000F80F8001C0010000FC0F0001C0018001FE070001
      C001C001F3070001E003E000F1878001F007F001E0078003F00FF807E007C007
      FC1FFC1FF00FF01FFFFFFE7FF81FFC7FFFFFFFFFFFFFFFFFE0FFFC3FF00FF1FB
      C00FF00FE007F1E1C003E007C0038701C001C003800100078001800100010007
      800380010001000F800700010001000F000300010001000F800100010001000F
      800100010001000FC00380018001000FE00780038003000FF00FC007C007800F
      F80FE00FE00FF00FFF9FF81FF83FFF3FFFFFF827FFFFFFFFF81FF803FFC3E3FF
      8000C801FF8181FF00008001018101C700000001000180030001000000038001
      F81F81C00007C001FC3F83800007E007FC3F0001000FE00FFC3F0000000FC00F
      FC3F0000000F8007FC3F800100070003FC7FE00300078001FFFFE00F8007C701
      FFFFF11FF80FFF03FFFFFFFFFF3FFF8FFFFFFFFCFFFFC3FFCFFFFFF8C003C00F
      87F3FFF08001C00383E3FFE10000E001C3C7FFC30000F801F18FF8870000FFE1
      F81FE00F0000FE01F83FC01F0000FC03FC3F801F0000F807F81F001F0000F007
      F18F001F0000E007E3C7003F0000C00FC7E7003F0000C01F8FFF007F0000C03F
      9FFF80FF0000C07FFFFFC3FFC003E0FFCFFFF3FFFF81F801C3FFE1FFFF01F801
      C1FFC0FFFF01F801C07F807FFFC3F801C03F003F80008001C01F083F00008001
      C0071C1F00008001C003BE0F00008001C003FF0700008001C00FFF8300008001
      C03FFFC100008003C07FFFE000008007C0FFFFF00000801FC3FFFFF8FF81801F
      C7FFFFFDFF01803FCFFFFFFFFF01807FFF1FF827FFFFFFFFFE1FF803FFFFE07F
      FC1FC80100008007E007800100008001C0030001000080018001000000008001
      000081C0F000800100008380F000800100000001FF00800100000000FF008001
      00000000FF00800100008001FFF080010001E003FFF0E0018001E00FFFF0FE03
      8007F11FFFFFFFE7E00FFFFFFFFFFFFFFFFFFFFFF81FC00180008001E007C001
      00008001C003C001000080018001C001000080018000C001000080018000C001
      000080018000C001000080018000C001000080018000C001000080018000C001
      00008001C000C00100008001E001C00100008001F18FC00100018001F18FC001
      FFFF8001F18FC001FFFFFFFFF9CFC003FFFFFFFFFFFFFFFFF00FFE7F8003FC1F
      F00FFC3F0001F007F00FF81F0001E003F00FF00F0001C003F00FE0070001C781
      0000C00300018F018001800100018E21C003000000018C61E007F00F000188E3
      F00FF00F000181E3F81FF00F0001C3C7FC3FF00F0001C00FFE7FF00F0001E01F
      FFFFFFFF0001F87FFFFFFFFF8003FFFF00000000000000000000000000000000
      000000000000}
  end
  object tPercent: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tPercentTimer
    Left = 96
    Top = 88
  end
  object aeMain: TApplicationEvents
    OnException = aeMainException
    OnHint = aeMainHint
    Left = 64
    Top = 88
  end
  object pmBookMarks: TPopupMenu
    Images = ilMenu
    OwnerDraw = True
    Left = 96
    Top = 152
    object miBmGoto: TMenuItem
      Caption = '&Goto'
      Default = True
      ImageIndex = 38
      OnClick = miBmGotoClick
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object miBmEnabled: TMenuItem
      Caption = '&Defined'
      OnClick = miBmEnabledClick
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object miBmDelete: TMenuItem
      Caption = '&Clear all...'
      ImageIndex = 39
      OnClick = miBmDeleteClick
    end
  end
  object ilHistoryView: TImageList
    Left = 96
    Top = 184
    Bitmap = {
      494C010117001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000246E80000051660000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000004152000041520000415200004152000041520000415200000000000000
      00000000000000000000000000000000000000000000000000009C1818009C18
      18009C1818009C1818009C1818009C1818009C1818009C1818009C1818009C18
      18009C1818009C1818009C181800000000000000000000000000000000000000
      00000000000000000000000000003B8EA1000051660000516600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000415200004152000041
      5200006C82000092AC00009EB900009EB900009EB900009EB900004152004A27
      0F000000000000000000000000000000000000000000B5181C00B5181C00B518
      1C00B5181C00B5181C00B5181C00B5181C00B5181C00B5181C00B5181C00B518
      1C00B5181C00B5181C00B5181C009C1818000000000000000000000000000000
      00000000000000516600005166000051660005A3BE0007ADC700005166000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000004152000098B200009E
      B900009EB900009EB900009EB900009EB900009EB900009EB900004152005A2F
      12004A270F004A270F000000000000000000BD313700FF6D6300B5181C00FF9C
      B600FF6C6B00FF6C6B00FF6C6B00FF6C6B00FF6C6B00FF6C6B00FF6C6B00FF6C
      6B00DE3A3900FF9CAA00B5181C009C1818000000000000000000000000000000
      0000000000000051660021B5CE000CD2F00000DDFB0001D1F10003AFCB000051
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000415200008EA700009E
      B900009EB900009EB900009EB9000099B3000091AA0000728700004152006B38
      15007C4118006B3815004A270F0000000000BD313700FF6D6300B5181C00FF9C
      B600FF7B8200FF7B8200FF7B8200FF7B8200FF7B8200FF7B8200FF7B8200FF7B
      7E00DE444200FF9CB600B5181C009C1818000000000000000000000000000000
      0000000000000084A50000516600008FAE0030E4FC000BDEFB0020D6EF0006B2
      CD00005166000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A2F120052514300007991000087
      9F0000637700004D5F00004D5F00004D5F00004A5C0000415200213533006B38
      15007C4118008C491B007B4018004A270F00BD313700FF6D6300B5181C00FF9C
      B600FF848D00FF848D00FF848D00FF848D00FF848D00FF848D00FF848D00FF84
      9100DE4B4A00FFA5B400B5181C009C1818000000000000000000000000000000
      000000637B0000637B002BA5BB0032D7EE0030E4FC0022BBD200005166000051
      6600005166000051660000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A2F1200845F3F00004152000058
      6C000A95AD0021B9CC0042E8F5004BF4FF004BF4FF0045CFD700253431004A27
      0F006B3815008C491B008C491B004A270F00BD313700FF6D6300B5181C00FF9C
      B600FF94AD00FF94AD00FF94AD00FF94AD00FF94AD00FF94AD00FF94AD00FF8C
      9F00E7535200FF9CB600B5181C009C181800000000000000000000637B000063
      7B00009CBE0000ABD5002CDFF9004AEFFF004AEFFF004AEFFF002AD9F1000051
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A2F1200A46032002D3D38002EA4
      B3003FE4F5004BF4FF0047F0FF0044EDFF004DEBF60054A3A00030555600834F
      2D004A270F004A270F007C4118004A270F00BD313700FF706B00B5181C00FF9C
      B600FF9CB600FF9CB600FF9CB600FFA5B400FF9CB600FF9CB600FF9CB600FF9C
      B600FF6D6300FF9CB600B5181C009C1818000000000000637B00008FAE0003AF
      CB0000B2D70001B5DD0016CDED0056EBFD006BF7FF0046C0CF000051660000AB
      D500005166000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A2F12006B381500A5673E00004D
      5F003FA7B2003CE6FF003CE6FF003CE6FF004ADEED00004D5F00AE805C00FCAB
      7900DC9262009D643E004A270F004A270F00BD313700FF7B7E00B5181C00FFFF
      FF00FFF9F700FFF9F700FFF9F700FFF9F700FFF9F700FFFFFF00FFFFFF00FFFF
      FF00F7858400FFF9F700B5181C009C181800000000000000000000637B0001B5
      DD0001B5DD0000BDE20000BDE20048E7FD008EFAFF008EFAFF0058E2F4000051
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A2F1200AA693E00E9996500C881
      5300004D5F003FA7B20029D6EF0029D6EF004AACB300565C4F00E89A6900FCAB
      7900FCAB7900FCAB7900AA6E45004A270F00BD313700FF849100FF848D00B518
      1C00B5181C00B5181C00B5181C00B5181C00B5181C00B5181C00B5181C00B518
      1C00B5181C00B5181C00B5181C0000000000000000000000000000637B00008F
      AE0000BDE20000BDE20000BDE2001DCDED0000DDFB00C5FDFF00A5FAFF0062EE
      F900005166000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B381500D7895400E9996500E999
      6500C57F5000004A5B003FA7B20033C1D400004D5F00C17C4F00F3A26F00F3A2
      6F00FCAB7900FCAB7900EA9D6E005B301200BD313700FF9CAA00FF8CA300FF8C
      A300FF8CA300FF8CA300FF8C9F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A51011000000000000000000000000000000000000000000000000000063
      7B0000BDE20000BDE20001B5DD0001B5DD0000ABD50001B5DD0005CEF0002CE3
      FC0068FFFF000051660000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B401800C4794600E9996500E999
      6500E9996500C37D4D00004758003FA7B200565C4F00DA8F5F00F3A26F00F3A2
      6F00F3A26F00FCAB7900FCAB79006B381500BD313700FFFFFF00FF9CB600FF9C
      B600FF9CB600FF9CB600FFFFFF00B5181C00B5181C00B5181C00B5181C00B518
      1C00A51011000000000000000000000000000000000000000000000000000063
      7B0000BDE20001B5DD0000ABD50000ABD50000ABD50000ABD50000A3D00001B5
      DD000BBEE5001DBFD90000516600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008C491B00A8613100E0915B00E999
      6500E9996500E9996500C37D4D0000415200CE845200E9996500E9996500F3A2
      6F00F3A26F00F1A16E00C67A49008C491B0000000000BD313700FFFFFF00FFFF
      FF00FFFFFF00FFF9F700BD313700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000063
      7B0000637B000087A80000ABD50000ABD50000ABD50000A3D00000A3D000009E
      CF00008DB3000051660000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008C491B00A8613100D285
      5100E0915B00E9996500E9996500BC784900E9996500E9996500E9996500E999
      6500E1925F00B36B3B008C491B00000000000000000000000000BD313700BD31
      3700BD313700BD31370000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000637B0000637B000087A80000A3D00000A3D000009ECF000084
      A500005166000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000008C491B008C49
      1B00B66D3B00CD814D00E0915B00E0915B00E0915B00E0915B00CD814D00B66D
      3B008C491B008C491B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000637B0000637B000084A5000084A5000051
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008C491B008C491B008C491B008C491B008C491B008C491B008C491B008C49
      1B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000637B0000586D000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000018799C001879
      9C0018799C0018799C0018799C0018799C0018799C0018799C0018799C001879
      9C0018799C0018799C0018799C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001A189C001A18
      9C001A189C001A189C001A189C001A189C001A189C001A189C001A189C001A18
      9C001A189C001A189C001A189C00000000000000000000000000000000001077
      9F0010779F0010779F0010779F0010779F0010779F0010779F0010779F001077
      9F0010779F0000000000000000000000000000000000188EB500188EB500188E
      B500188EB500188EB500188EB500188EB500188EB500188EB500188EB500188E
      B500188EB500188EB500188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001819B5001819B5001819
      B5001819B5001819B5001819B5001819B5001819B5001819B5001819B5001819
      B5001819B5001819B5001819B5001A189C0000000000000000001097BF001097
      BF001097BF001097BF001097BF001097BF001097BF001097BF001097BF001097
      BF001097BF0010779F000000000000000000319EBD0063CBFF00188EB5009CFF
      FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7
      FF0039B2DE009CF3FF00188EB50018799C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003135BD007063FF001819B5009CB5
      FF006E6BFF006E6BFF006E6BFF006E6BFF006E6BFF006E6BFF006E6BFF006E6B
      FF003C39DE009CA9FF001819B5001A189C00000000001098C0001098C0009FFF
      FF0060D7FF0060D7FF0060D7FF0060D7FF0060D7FF0060D7FF0060D7FF0060D7
      FF0060D7FF002097BF000F70A00000000000319EBD0063CBFF00188EB5009CFF
      FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BDF
      FF0042B2DE009CFFFF00188EB50018799C000000000000000000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003135BD007063FF001819B5009CB5
      FF007B80FF007B80FF007B80FF007B80FF007B80FF007B80FF007B80FF007B7C
      FF004742DE009CB5FF001819B5001A189C00000000001098C0001098C00070E0
      EF009FFFFF0070E0FF0070E0FF0070E0FF0070E0FF0070E0FF0070E0FF0070E0
      FF0070DFFF003FB0DF000F70A00000000000319EBD0063CBFF00188EB5009CFF
      FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF0084EB
      FF004AB6DE00A5F7FF00188EB50018799C000000000000000000000000000080
      0000000000000000000000000000000000000000000000000000008000000080
      0000008000000000000000000000000000003135BD007063FF001819B5009CB5
      FF00848BFF00848BFF00848BFF00848BFF00848BFF00848BFF00848BFF00848F
      FF004D4ADE00A5B3FF001819B5001A189C00000000001098C00020A0CF003FB7
      D0009FFFFF0080E8FF0080E8FF0080E8FF0080E8FF0080E8FF0080E8FF0080E8
      FF0080E7FF003FB8EF000F70A00000000000319EBD0063CBFF00188EB5009CFF
      FF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF0094FBFF008CF3
      FF0052BEE7009CFFFF00188EB50018799C000000000000000000008000000080
      0000008000000000000000000000000000000000000000800000000000000000
      0000000000000080000000000000000000003135BD007063FF001819B5009CB5
      FF0094ABFF0094ABFF0094ABFF0094ABFF0094ABFF0094ABFF0094ABFF008C9D
      FF005552E7009CB5FF001819B5001A189C00000000001098C0003FB0DF001F9F
      C000A0FFFF0090F7FF0090F7FF0090F7FF0090F7FF0090F7FF0090F7FF0090F7
      FF0090F7FF004FBFE00050B8CF000F70A000319EBD006BD3FF00188EB5009CFF
      FF009CFFFF009CFFFF009CFFFF00A5F7FF009CFFFF009CFFFF009CFFFF009CFF
      FF0063CBFF009CFFFF00188EB50018799C000000000000000000000000000000
      0000000000000080000000000000000000000000000000800000000000000000
      0000000000000080000000000000000000003135BD00726BFF001819B5009CB5
      FF009CB5FF009CB5FF009CB5FF00A5B3FF009CB5FF009CB5FF009CB5FF009CB5
      FF007063FF009CB5FF001819B5001A189C00000000001098C0006FD0FF001098
      C00080EFF0009FFFFF009FFFFF009FFFFF009FFFFF009FFFFF009FFFFF009FFF
      FF009FFFFF0050C7FF0090F7F0000F70A000319EBD007BDFFF00188EB500FFFF
      FF00F7FBFF00F7FBFF00F7FBFF00F7FBFF00F7FBFF00FFFFFF00FFFFFF00FFFF
      FF0084D7F700F7FBFF00188EB50018799C000000000000000000000000000080
      0000008000000000000000000000000000000000000000800000000000000000
      0000000000000080000000000000000000003135BD007B7CFF001819B500FFFF
      FF00F9F7FF00F9F7FF00F9F7FF00F9F7FF00F9F7FF00FFFFFF00FFFFFF00FFFF
      FF008784F700F9F7FF001819B5001A189C00000000001098C00080D7FF001098
      C00060BFD000FFFFFF00FFFFFF00F0F8FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080E7FF00FFFFFF000F70A000319EBD0084EBFF0084E7FF00188E
      B500188EB500188EB500188EB500188EB500188EB500188EB500188EB500188E
      B500188EB500188EB500188EB500000000000000000000000000008000000000
      0000000000000000000000000000000000000000000000800000000000000000
      0000000000000080000000000000000000003135BD00848FFF00848BFF001819
      B5001819B5001819B5001819B5001819B5001819B5001819B5001819B5001819
      B5001819B5001819B5001819B50000000000000000001098C00080E8FF004FBF
      DF001098C0001098C0001098C0001098C0001098C0001098C0001098C0001098
      C0001098C0001098C0001098C0000F70A000319EBD009CF3FF008CF7FF008CF7
      FF008CF7FF008CF7FF008CF3FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00107DA5000000000000000000000000000000000000000000000000000080
      0000008000000080000000000000000000000000000000800000000000000000
      0000000000000080000000000000000000003135BD009CA9FF008CA1FF008CA1
      FF008CA1FF008CA1FF008C9DFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF001210A500000000000000000000000000000000001098C0009FF0FF008FF0
      FF008FF0FF008FF0FF008FF0FF008FF0FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF001098C00010789F0000000000319EBD00FFFFFF009CFFFF009CFF
      FF009CFFFF009CFFFF00FFFFFF00188EB500188EB500188EB500188EB500188E
      B500107DA5000000000000000000000000000000000000000000000000000000
      0000008000000000000000000000000000000000000000000000008000000080
      0000008000000000000000000000000000003135BD00FFFFFF009CB5FF009CB5
      FF009CB5FF009CB5FF00FFFFFF001819B5001819B5001819B5001819B5001819
      B5001210A500000000000000000000000000000000001098C000FFFFFF009FFF
      FF009FFFFF009FFFFF009FFFFF00FFFFFF001098C0001098C0001098C0001098
      C0001098C0001098C000000000000000000000000000319EBD00FFFFFF00FFFF
      FF00FFFFFF00F7FBFF00319EBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003135BD00FFFFFF00FFFF
      FF00FFFFFF00F9F7FF003135BD00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001FA0CF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF001098C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000319EBD00319E
      BD00319EBD00319EBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003135BD003135
      BD003135BD003135BD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001FA0
      CF001FA0CF001FA0CF001FA0CF00000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008888880088888800696969005B5B5B00696969007D7D7D007D7D
      7D00000000000000000000000000000000000000000000000000060606001919
      1900191919001919190019191900191919001919190019191900191919001919
      1900191919001919190000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000079797900736F6F009C8F8F00AFA8AC009C8F8F00706B6B00525252005252
      52007D7D7D000000000000000000000000000000000000000000DCB2A400E4B6
      A700E2B5A600E1B3A500E0B2A500E0B2A500E0B2A500E0B2A500E0B2A500E0B2
      A500E0B09B009E7D770000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008277
      7700CFB4B400FFDDDD00FFE0E000FFE8E800FFEEEE00FFF2F200CFCFCF007979
      79004C4C4C00706B6B0000000000000000000000000000000000D6CBC500FBE0
      C900FBDEC600FADCC300FADBC000FAD9BD00FAD7B900F9D5B700F9D4B400F9D2
      B100FBD1B7009D7C760000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000857B7B00F5C7
      C700FFD2D200FFD8D800FFDDDD00FFE0E000FFE8E800FFF4FC00FFFFFF00F5F5
      F5009D9D9D004C4C4C007D7D7D00000000000000000000000000D9CEC800FBE2
      CD00FBE0CA00FBDFC700FBDDC400FADBC100FAD9BE00FAD8BB00FAD6B800FAD4
      B500FBD2B8009D7C76000000000000000000000000000000000000000000A24C
      4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C
      4C00A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C
      4C00A24C4C000000000000000000000000000000000088838300F5CDCD00FFCF
      CF00FFCDCD00FFD2D200FFD8D800FFDDDD00FFE0E000FFF8F800FFFFFF00FFFF
      FF00F5F5F5007979790052525200000000000000000000000000BCB0AA00998D
      85008F868100666666008B847E00FBDDC500FADCC200FBDABF00FAD8BC00FAD6
      B900FBD4BB009D7C76000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C0000000000000000000000000098989800C6B1B100FFD8D800FFD4
      DB00FFCFCF00FFCDCD00FFD4DB00FFD7E200FFE4EA00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CFCFCF0052525200888888000000000006060600C9B3A600FDEB
      DD00FDF1E800F8E9DD009A9794008B847E00FBDEC600FBDDC400FBDBC000FAD9
      BE00FBD4BD009D7C76000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C0000000000000000000000000098989800FFE0E000FFE0E000FFD8
      D800FFD4DB00FFE0E700FFDEFF00FFD1F300FFE2FC00FFF8FF00FFFFFF00EFDF
      DF00DCB9B900CC99990069616100696969000A090800D9C4B600FCD7C400FDDD
      CC00FDEEE200FCEBDD00FAE9DA00857F7A00E7CFBB00FBDFC700FADDC400FADC
      C100FBD6BF009D7C76000000000000000000000000000000000000000000A24C
      4C00FFFFFF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C000000000000000000000000009D979700FFE8E800FFE0E000FFE0
      E000FFE0E000FFEFFC00B3A0A30069696900AFA8AC00FCF0F900D6ACAC00CC99
      9900CC999900CC999900807171005E5E5E002A262300FDEEE200FCE9DA00E9E1
      DB00CBC3BF00F1E5DE00D6B8AE0099827B00B1A49A00FBE1CC00FBE0C900FBDE
      C600FCD7C1009D7C76000000000000000000000000000000000000000000A24C
      4C00000000000000000000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C000000000000000000000000009E8C8C00E6C0C000EFC2C200F3C5
      C500F9D6D600FFE9F300827777004C4C4C0069696900F9E8EC00ECCACA00E6BA
      BA00E9BEBE00E6C0C000A6949400696969002A262300E2C6B400F5D3C400CDC5
      C10077737000F9EBE000F1DBCA00CDBBAF00C2B2A600FBE4D000FBE2CD00FBE0
      CA00FCD8C3009D7C76000000000000000000000000000000000000000000A24C
      4C00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C000000000000000000000000009C8F8F00DBA8A800E3B0B000EAB7
      B700F3CDCD00FFEFFC00C5BCC200706B6B00B3A0A300FFF6FF00FFD8D800FFD8
      D800FFDDDD00FFE0E00088838300888888000A090800E4CCC100F2E9E200FEF9
      F500FEF4ED00FDDECE00FDD7C500A49A9400E7D4C500FCE6D400FBE4D100FBE3
      CE00FCD9C5009D7C76000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C0000000000000000000000000098989800D5A2A200E7C4C400F7E7
      E700FFFFFF00FFF8FF00FFDEFF00FFD2F500FFE2FC00FFE0E700FFCDCD00FFD2
      D200FFD8D800FFDDDD006969690088888800000000006D676300F1ECE700FEF7
      F200FDEEE200FCE8D900D2BCAC00D7CAC000FCEADB00FCE8D800FCE7D500FCE5
      D200FCDBC7009D7C76000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C0000000000000000000000000000000000C3BFBF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFECF100FFDBE700FFD7E200FFD4DB00FFCFCF00FFCD
      CD00FFD2D200C6ADAD0079797900000000000000000000000000DBCCC000D4C9
      C100D4C6BC00DBCBC100E8DBD000FDEEE200FDECDF00FCEBDC00FCE9D900FCE7
      D600FCDCC9009D7C76000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00A24C4C000000000000000000000000000000000098989800F5F5F500FFFF
      FF00FFFFFF00FFFFFF00FFE8E800FFE0E000FFE0E000FFD8D800FFD4DB00FFCF
      CF00F5C7C7008277770000000000000000000000000000000000F5E9DF00FEF8
      F200FEF6F000FEF4EC00FDF3E900FDF1E600FDEFE300FDEDE000FCEBDE00F9CC
      C400F9BDB4009E7B74000000000000000000000000000000000000000000A24C
      4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C
      4C00A24C4C00000000000000000000000000000000000000000000000000A24C
      4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C4C00A24C
      4C00A24C4C0000000000000000000000000000000000000000008D8D8D00F5F5
      F500FFFFFF00FFF8F800FFECF100FFE8E800FFE0E000FFE0E000FFD8D800F5CD
      CD00857B7B000000000000000000000000000000000000000000F9EDE100FEFB
      F700FEF9F400FEF7F100FEF5EE00FDF3EA00FEF2E800FDF0E500F2D4BD00F4A7
      4400DE8F3800483F3A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009898
      9800C6C6C600FFF8F800FFF2F200FFECF100FFE8E800FFE0E000C6B1B1008E8A
      8A00000000000000000000000000000000000000000000000000FCF0E400FFFD
      FB00FEFBF800FEF9F500FEF8F200FEF6EF00FDF4EC00FDF2E800F4DEC800F1BD
      78004D4339000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A6A6A600A6A4A4008E8A8A00A49F9F00A2A1A100000000000000
      0000000000000000000000000000000000000000000000000000FEE5CE00FBE9
      D900F6E6D600F2E1D300EEDECF00EAD9CC00E7D5C900E2D2C500E4CCB8005950
      4700000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000066594B00CEC9C400B8B1AA009C918600584D4100413930000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007070700070707000707070007070700070707000707070000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8C0000008C0000008700000087000000870000007A0000007A0000007A000000
      7A0000005A00000000000000000000000000000000000000000000000000A0A0
      A000B4B4B400999999008B8B8B007F7F7F008686860000000000000000000000
      0000000000000000000000000000000000000000000070707000707070007070
      7000707070000176A9000171A3000273A5000275A800016FA200707070007070
      7000707070007070700070707000707070000E0B9E0000005B0000005B000000
      5B000962A30000336300003363000033630000A0AB0000636700006367000063
      6700009B000018610000186100001861000000000000000000000000A2002121
      D0005656FF004343FF004343FF003A3AF3003636ED003232E7002121BC000000
      7A000000860000005A00000000000000000000000000B8B8B800AFAFAF00D4D4
      D400E2E2E200E6E6E600E4E4E400E0E0E000C8C8C800A5A5A500919191008080
      8000828282000000000000000000000000002626260026262600262626002626
      26002626260015ADD9002BC1EB0029B9DE0028C0EA00057EAF00262626002626
      2600262626002626260026262600707070000E0B9E000000FF000000FF000000
      5B000962A300008AFF00008AFF000033630000A0AB0000F2FF0000F2FF000063
      6700009B000000FF000000FF000018610000000000000000A2002121D0003636
      ED000000D0000000B3000000B3000000B3000000B3000000D0001919E5002121
      BC0000007A0000008A0000005A000000000000000000B1B1B100C4C4C400CCCC
      CC00D6D6D600DCDCDC00E2E2E200EBEBEB00F3F3F300F8F8F800F6F6F600EEEE
      EE00D5D5D500B4B4B4007D7D7D000000000099999900FFF1DF00FFF1DF00FFF1
      DF00FFF1DF0024ACD70073D6EE007FE5FF006CD5F1000F87B700FFF1DF00FFF1
      DF00FFF1DF00FFF1DF0026262600707070000E0B9E00FFFFFF006060FF000000
      5B000962A30040A7FF00008AFF000033630000A0AB0000F2FF0000F2FF000063
      6700009B000000FF000000FF000018610000000000000000A2005656FF007373
      FF008A8AFF00A1A1FF00A1A1FF00A1A1FF00A1A1FF008A8AFF006464F3003232
      E70000007A0000009A0000008A0000005A0000000000B6B6B600C8C8C800C9C9
      C900D1D1D100D9D9D900DBDBDB00E2E2E200F4F4F400F5F5F500F6F6F600F9F9
      F900FFFFFF00FFFFFF00C8C8C800000000009999990099999900999999009999
      9900999999004DB6D800DAEBEF00FFFFFF00D4EEF5001590BE00999999009999
      9900999999009999990099999900000000000E0B9E000E0B9E000E0B9E000000
      5B000962A3007FC4FF00008AFF000033630000A0AB0060F7FF0000F2FF000063
      6700009B000080FF800000FF000018610000000000000000A2005656FF002D2D
      EC000000D0000000B3000000B3000000B3000000B3000000D0001919E5003232
      E70000007A000000A20000009A0000005A0000000000B9B9B900CFCFCF00C5C5
      C500C7C7C700C6C6C600D8D8D800C9C9C900CDCDCD00D9D9D900E9E9E900F3F3
      F300F5F5F500FDFDFD00D8D8D800000000000000000000000000000000000000
      00000000000025A7D20040B2D90034AED6002EABD50047AED200707070000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000962A300FFFFFF0060B6FF000033630000A0AB0080F9FF0000F2FF000063
      6700009B000080FF800000FF000018610000000000000000A2005656FF007070
      FF008484FF009595FF009595FF009595FF009595FF008484FF006161F3003232
      E70000007A000000AA0000009A0000005A0000000000BDBDBD00D6D6D600C4C4
      C400B6B6B60079797900C6C6C600CBCBCB00CCCCCC00C4C4C400CFCFCF00EDED
      ED00F8F8F800FCFCFC00D3D3D300000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000962A3000962A3000962A3000033630000A0AB007FF8FF0000F2FF000063
      6700009B000080FF800000FF000018610000000000000000A2005656FF005656
      FF005656FF004343FF004343FF003A3AF3003636ED003232E7003232E7003232
      E70000007A000000AA0000009A0000005A0000000000C1C1C100DFDFDF00BFBF
      BF00BDBDBD00B4B4B400C9C9C900C3C3C300C1C1C100C5C5C500D9D9D900EAEA
      EA00BEBEBE00E4E4E400D2D2D200000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000A0AB00FFFFFF0000F2FF000063
      6700009B0000BFFFBF0000FF000018610000000000000000A2000000A2000000
      A2000000A200000097000000970000008C0000008C0000008C0000008C000000
      8C0000007A000000920000009A0000005A0000000000C4C4C400E7E7E700BCBC
      BC00B7B7B700C2C2C200C6C6C600CACACA00C6C6C600C2C2C200C7C7C700E6E6
      E60090909000C3C3C300D2D2D200000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000A0AB00FFFFFF007FF8FF000063
      6700009B0000BFFFBF0000FF000018610000000000000000A2002121EC005656
      FF002121EC007572E1001414D0001414D0004343FF002121EC007572E1001414
      D0000A0AA50000007A0000008A0000005A0000000000C9C9C900F1F1F100B6B6
      B600AEAEAE00B8B8B800BFBFBF00C6C6C600CFCFCF00D6D6D600D9D9D900DEDE
      DE00E6E6E600ECECEC00CACACA00000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000A0AB0000A0AB0000A0AB000063
      6700009B0000FFFFFF0000FF00001861000000000000000000000000A2002121
      EC0062599600E0DAD40050498800000083000000DA0062599600E0DAD4005049
      8800000083000000830000005A0000005A0000000000D1D1D100FCFCFC00C5C5
      C500A6A6A600AEAEAE00B6B6B600BFBFBF00C7C7C700CDCDCD00D3D3D300D9D9
      D900DFDFDF00E8E8E800C7C7C700000000000000000000000000000000000000
      0000000000000000000099999900FFF1DF002626260070707000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009B0000FFFFFF0000FF0000186100000000000000000000000000000000
      A20075665600E0DAD400584D410000002D0000005A0075665600E0DAD400584D
      410000002D0000005A0000005A000000000000000000C6C6C600F8F8F800F6F6
      F600DDDDDD00CCCCCC00C1C1C100BDBDBD00C0C0C000C6C6C600CDCDCD00D4D4
      D400DADADA00E3E3E300C6C6C600000000000000000000000000000000000000
      0000000000000000000099999900999999009999990000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009B0000FFFFFF0090FF9000186100000000000000000000000000000000
      000075665600F0EDEA00584D4100000000000000000075665600F0EDEA00584D
      410000000000000000000000000000000000000000000000000000000000CECE
      CE00D2D2D200DCDCDC00E2E2E200DEDEDE00D8D8D800CFCFCF00CCCCCC00CECE
      CE00D5D5D500E2E2E200C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000009B0000009B0000009B0000186100000000000000000000000000000000
      000075665600FFFFFF00584D4100000000000000000075665600FFFFFF00584D
      4100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C5C5C500C2C2C200C7C7C700D0D0D000CECE
      CE00CBCBCB00B2B2B20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000075665600BAB2AA00584D4100000000000000000075665600BAB2AA00584D
      4100000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C8C8
      C800BEBEBE000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000075665600584D410000000000000000000000000075665600584D
      4100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000070707000404040007070
      7000707070000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000070707000404040007070
      7000707070000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000004A8C0000397300003973000039730000397300000000000039
      7300003973000000000000000000000000000000000000000000828282008282
      82007B7A7A009C9C9C0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A69C9900A99C9B00766A
      6A005B5454004B4747004E4E4E00717171000000000000000000000000000000
      00000000000000000000000000000000000000000000A69C9900A99C9B00766A
      6A005B5454004B4747004E4E4E00717171000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000004A8C000084FF00008BFC00127EC90000468E0000397300007F
      F9000055BE000039730000000000000000000000000000000000FBE7C400F3C8
      9C00A98A730062605E0076767600878787008787870087878700878787008787
      870000000000000000000000000000000000D7C7BA00D2C0AD00FAF4EF00FAF4
      EF00E1E2E400D2CDCD00B0A5A60087736E00584D4A0089848200000000000000
      000000000000000000000000000000000000D7C7BA00D2C0AD00FAF4EF00FAF4
      EF00E1E2E400D2CDCD00B0A5A60087736E00584D4A0089848200000000000000
      000000000000000000000000000000000000000000000000000000529C00004A
      8C0000000000004A8C0025A4FD0033AEFE0044B9FE00007FF9000070CE0033AE
      FE001289EB000074DA0000397300000000000000000000000000EAC8A900FEE4
      BC00FBD8AE00DAB18D00B8977900B8977900A98A7300A98A73008B786A008B78
      6A006C6B6900878787000000000000000000D0BDB200E6DED400F5EDDB00F9F4
      E800FCFAF600FFFFFF00FAF4EF00EDEDEB00CFB9B4004E474600656565000000
      000000000000000000000000000000000000D0BDB200E6DED400F5EDDB00F9F4
      E800FCFAF600FFFFFF00FAF4EF00EDEDEB00CFB9B4004E474600656565000000
      0000000000000000000000000000000000000000000000529C000079F300006E
      DD00004A8C001C80CD0093D7FF00B6E4FF0093D7FF0084D2FF0084D2FF0067C7
      FF0050BFFF00259FF0000039730000000000000000000000000000000000E4CA
      B700EBD3B400FADEB800FEDCB300FEDCB300FEDCB300FEDCB300FEDCB300F9D2
      A500CB9E7B00766960008787870000000000E4CBB400E7E0D800EFE2C700F3E9
      D400F7F0E200FBF7F000FEFDFB00FFFFFF00FFFFFF00B4A4A5008B8B8B000000
      000000000000000000000000000000000000E4CBB400E7E0D800EFE2C700F3E9
      D400F7F0E200FBF7F000FEFDFB00FFFFFF00FFFFFF00B4A4A5008B8B8B000000
      00000000000000000000000000000000000000529C000088EF00008BFC004EBA
      FE0067C8FF0039B6FF0093D7FF007DCFFF0067C8FF0067C8FF0050BFFF0050BF
      FF0050BFFF00003A8E00005AB500000000000000000000000000000000000000
      000000000000E4CAB700EAD8C500E4CAB700D8C6B600D8C6B600EAC8A900EBD3
      B400FEE4BC00DAB18D007171710000000000ECD9C700F1E4CB00EAD9B400EDDF
      BF00F1E6CD00F5EDDB00F9F4E800FCFAF600CAC9CC0073676700000000000000
      000000000000000000000000000000000000ECD9C700F1E4CB00EAD9B400EDDF
      BF00F1E6CD00F5EDDB00F9F4E800FCFAF600CAC9CC0073676700000000000000
      00000000000000000000000000000000000000529C00006DC60048BCFF00FFFF
      FF00B6E4FF0067C8FF00389CDA0000396B0000396B0000396B0000396B001F92
      DA0029B0FF0029B0FF0029B0FF00003973000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D9D3
      CC00F2D9B900FADEB8007676760000000000EFE4D800F9E6BE00E9D7B000E9D7
      B000ECDCB900EFE2C700F3E9D400F7F0E200B3AAAB0046444400525151004B4B
      4B0063636300898482000000000000000000EFE4D800F9E6BE00E9D7B000E9D7
      B000ECDCB900EFE2C700F3E9D400F7F0E200B3AAAB0046444400525151004B4B
      4B00636363008984820000000000000000000000000000529C0000529C00B6E4
      FF007BCFFF002587C50000396B0000000000000000000000000000427B000039
      6B0029B0FF0029B0FF0029B0FF00003973000000000000000000000000000000
      000000000000000000000000000090847C007171710088888800A6A19D00A696
      8C00FBE7C400F4D6B1009A9A9A000000000075A6F4005C80E7007E90D900B0AE
      C800DACAC200DFCBBF00D3B9B000B4A69D0089848200827876008B7D7D008A77
      75004C46470040404000707070000000000075A6F4005C80E7007E90D900B0AE
      C800DACAC200DFCBBF00D3B9B000B4A69D0089848200827876008B7D7D008A77
      75004C4647004040400070707000000000000000000000529C000070CE0081D1
      FF0058C2FF0000528C0000000000000000000000000000427B00004399000039
      6B0029B0FF0029B0FF00037BCE00003973000000000000000000000000000000
      00000000000000000000CFB18600E3AD8200B2896D00896E57008B786A00EBD3
      B400FDEDCB00C0A28A0000000000000000000000000000000000388FFE003285
      FF003380FF003F87FF008089B500998D8000CABEA000CBC8C7009AA6D900E4DD
      C900BEA79D005E53540040404000898482000000000000000000388FFE003285
      FF003380FF003F87FF008089B500998D8000CABEA000CBC8C7009AA6D900E4DD
      C900BEA79D005E535400404040008984820000529C00008EFF002AADFD0058C2
      FF004ABDFF00004E9400004A8C00004A8C0000427B000060B200004399000039
      6B0029B0FF00089CF60000337300000000000000000000000000000000000000
      000000000000E6BC9300F8D7AB00E6B88E00E3AD8200EAC8A900FFFDE400FDF9
      D800C0A28A000000000000000000000000000000000000000000000000000000
      000000000000000000008F97AA00E0D2AA00FFF6C200FFECC000FBE2BE00FFF4
      D500EEEAD600B59E940042404000707070000000000000000000000000000000
      000000000000000000008F97AA00E0D2AA00FFF6C200FFECC000FBE2BE00FFF4
      D500EEEAD600B59E9400424040007070700000529C0067C8FF0087D3FF004ABD
      FF0039B6FF0000529C00005DBC000084DE00008CF8000062C300004A8C001474
      B50008A3FF0008A3FF0008A3FF00003973000000000000000000000000000000
      0000E6BC9300ECC49B00F8D7AB00E6B88E00D3987400EBD3B400F5E3C400B897
      7900767676000000000000000000000000000000000000000000000000000000
      00000000000000000000C3BDAE00F5F5CC00FFFBCD00F3EAB900E0CA9D00ECCC
      9900FBEDD000C3BDB70062595900707070000000000000000000000000000000
      00000000000000000000C3BDAE00F5F5CC00FFFBCD00F3EAB900E0CA9D00ECCC
      9900FBEDD000C3BDB700625959007070700000529C0058C2FF0054C0FF0029B0
      FF0029B0FF001F99E60000529C0000529C00004A8C00004A8C00147DC50008A3
      FF0008A3FF0008A3FF000181D30000397300000000000000000000000000DAA7
      8100E6B88E00ECC49B00F9D2A500F1CEA800DAA78100DAA78100E3AD8200CB9E
      7B006C6B69000000000000000000000000000000000000000000000000000000
      00000000000000000000BDC1C500BADAF700FFFFED00D9DABA0062605C007264
      5000E1D4BC00848EC5006B646300707070000000000000000000000000000000
      00000000000000000000BDC1C500BADAF700FFFFED00D9DABA0062605C007264
      5000E1D4BC00848EC5006B646300707070000000000000529C0000529C000052
      9C0029B0FF0029B0FF0029B0FF0029B0FF0029B0FF0008A3FF0008A3FF000798
      F100046EB90008A3FF0000397300000000000000000000000000D3987400DAA7
      8100E6B88E00ECC49B00FEE4BC00FFF3CD00FEECC500F4D5AD00ECC49B00E6B8
      8E00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CAC300FDF6F100FFFFFD00FFFEE800CAC9AA007B70
      5D00E8D9AE00C1B69F0056545500707070000000000000000000000000000000
      00000000000000000000D1CAC300FDF6F100FFFFFD00FFFEE800CAC9AA007B70
      5D00E8D9AE00C1B69F0056545500707070000000000000000000000000000052
      9C0029B0FF0029B0FF0008A3FF0008A3FF0008A3FF0008A3FF0008A3FF00004A
      8C00003973000039730000000000000000000000000000000000C68E6B00DAA7
      8100ECC49B00F5E3C400F5E3C400FDEDCB00FFF3CD00FFF3CD00FEECC5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ECDDCE00EEE1D300FFFBF600FAFFFF00F1FDF900CFCC
      A300A8987E008F8C860070707000000000000000000000000000000000000000
      00000000000000000000ECDDCE00EEE1D300FFFBF600FAFFFF00F1FDF900CFCC
      A300A8987E008F8C860070707000000000000000000000000000000000000052
      9C0008A3FF0008A3FF0008A3FF0000529C000181D30008A3FF000DA8FF00004A
      8C00000000000000000000000000000000000000000000000000AB694A00F1CE
      A800F5E3C400EAC8A900E6BC9300E4BE9900F4D6B100F6DCB500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ECDDCE00ECDDCE00D6DADE00AEC6DC00E8DC
      BB00A9A59F0099999A0099999A00000000000000000000000000000000000000
      0000000000000000000000000000ECDDCE00ECDDCE00D6DADE00AEC6DC00E8DC
      BB00A9A59F0099999A0099999A00000000000000000000000000000000000000
      000000529C0000529C0000529C000000000000529C0000529C00004A8C000000
      000000000000000000000000000000000000000000000000000057312100D8B4
      9500E4BE9900F3C89C00F9D2A500F3C89C00D8B4950000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECDDCE00D5D3D000CFCBC800BEBE
      BF0099999A0099999A0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECDDCE00D5D3D000CFCBC800BEBE
      BF0099999A0099999A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002A06
      0000573121006C4D3C00A27D5E00B89779000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000654637006546370065463700654637006546370065463700654637004D31
      2A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003B65370028341D0000000000000000000000
      0000000000000000000000000000000000000000000011751100167A16001F81
      1F001F811F001F811F001C821C001983190016861600138A13000D880D000A87
      0A0005860500027D020000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000065463700D67F3E00CC7C3F0097613D0097613D0097613D0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000000000
      000000000000000000003B6537003FCC42003E973D0028341D00000000000000
      0000000000000000000000000000000000000C840C001C8E1C00299329002F98
      2F002F982F002C982C002C982C0092CB92005BB75B001EA21E0016AA16000EAB
      0E0005A205000299020002800200000000000000000000000000000000000000
      0000413E9C002218A8001E10AC00231CA60039348F00605E7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000065463700D67F3E00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000000000
      0000000000003B6537003FCC420073FD760044C646003E973D0028341D000000
      0000000000000000000000000000000000001288120029932900369A36003FA0
      3F003FA03F003FA03F0036A63600FEFEFE0099D3990024B0240022AD220013B1
      13000FB30F0005A2050007840700000000000000000000000000615FA4001F19
      B2001C13C1002044CD002870DA002B56CE001E27C8001B10BA003C3889007C7C
      7F00000000000000000000000000000000000000000000000000000000000000
      000065463700D67F3E00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000000000
      00003B6537003ED64000BCFEBE0055DD57003FCC42003FBA41003E973D002834
      1D0000000000000000000000000000000000188E1800369A360042A14200A4D1
      A400D2E8D20042A1420040A84000FEFEFE0099D499002AB32A005BC55B00FEFE
      FE000FB30F0008A808001089100000000000000000004C49A5001C16B9001E1B
      C8003295E10054F2FC0064F8FC00D1B9990090ACAE00237EE4001D1AC8003531
      91007C7C80000000000000000000000000000000000000000000000000000000
      000065463700D67F3E00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000003B65
      37003ED64000FFFFFF005DE45F003FCC42003FCC42003FCC42003FBA41003E97
      3D0028341D00000000000000000000000000229122003C9E3C004BA54B004EA6
      4E00D1E8D100D1E8D10042A1420099D8990067C3670064C36400FEFEFE0054C2
      540013B113000EAB0E001387130000000000000000001814A7001F10CA00296E
      DD006DFFFF008FFAFF0092F7FE00C5DBCD00B5DCCB0052F6FE00278BDB001D17
      C5003C3889000000000000000000000000006546370065463700654637006546
      370065463700D67F3E00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D00341D
      1E00341D1E00341D1E00341D1E00341D1E0000000000000000003B6537003ED6
      4000C9FFCA0061E963003FCC42003FCC42003FCC42003FCC42003FCC42003FBA
      41003E973D0028341D0000000000000000002694260048A3480051A8510051A8
      510051A85100A4D1A40048A348003CA23C0036A6360062BF620059C1590022AD
      220018B01800179E170016881600000000004C49AD001C17B8001C1BD6005A9C
      D100AFE3D800AFF8FE00B2FDFF00A1FEFF0079D0DC005A636B00607982002772
      DB001C11BB006262800000000000000000000000000065463700D67F3E00FEB9
      8400FC913F00FC913F00FC913F00CC7C3F00CC7C3F00CC7C3F0097613D009761
      3D0097613D0097613D00341D1E0000000000000000003B6537003ED6400084FE
      87003FFC43003FFC43003FFC43003FCC42003FCC42003FCC42003E973D003E97
      3D003E973D003E973D0028341D0000000000329C32004EA64E00ABD5AB00ABD5
      AB00A8D3A8004BA54B0042A1420039A0390033A433002FAA2F005ABC5A0090D6
      90008ED08E0058B6580019891900000000003735A9001F18C2001921DF00839E
      BF00FAB18600C7F5F800ADE4E800536B760034353D005B3538007AA4A8003EE5
      FD001E32CD003E398F000000000000000000000000000000000065463700D67F
      3E00FFE0C900E99B6100CC7C3F00CC7C3F00CC7C3F00CC7C3F00CC7C3F00BA74
      3F0097613D00341D1E0000000000000000003B6537003B6537003B6537003B65
      37003B6537003ED640003FFC43003FCC42003FCC42003FCC42003E973D002834
      1D0028341D0028341D0028341D0028341D00329C320054A95400FFFFFF00FEFE
      FE00FEFEFE004BA54B0045A2450039A0390033A433002FA52F0091D09100FEFE
      FE00FEFEFE0092CB92001C891C00000000003A37AD001F1AC6001D15DA005595
      DF00CEE7D700D0FEFF00A1CBCF00573639003E2B30006EA9B70098F1F10089D8
      CD002C68D30031299D0000000000000000000000000000000000000000006546
      3700D67F3E00FFFFFF00E4975D00CC7C3F00CC7C3F00CC7C3F00BA743F009761
      3D00341D1E000000000000000000000000000000000000000000000000000000
      00003B6537003ED640003FFC43003FCC42003FCC42003FCC42003E973D002834
      1D00000000000000000000000000000000003B9E3B0057AB57005BAD5B005BAD
      5B0051A851004BA54B0042A14200399C3900339C33002C9C2C0026982600229D
      220020982000269826001F851F00000000005B5ABA001F1AC4002215DD002E52
      DE00ABFDFF00D1FFFF00CAFCFE008AA6A900352B2E00508EA500ABE5E600F4C3
      94004870C1002821A40000000000000000000000000000000000000000000000
      000065463700D67F3E00FED9BC00DD8F5500CC7C3F00BA743F0097613D00341D
      1E00000000000000000000000000000000000000000000000000000000000000
      00003B6537003ED640003FFC43003FCC42003FCC42003FCC42003E973D002834
      1D000000000000000000000000000000000042A0420067B4670067B467005BAD
      5B0081C08100FEFEFE0042A142003C9E3C00369A360099CB9900C8E5C8002698
      260026982600299829001F811F0000000000000000001D18BB00241DDA001F17
      DD005EA0E600C9FFFF00CEFEFF00C9FFFF0081979C004832390060B6CC007CF4
      EA003275D2002C22A10000000000000000000000000000000000000000000000
      00000000000065463700CC7C3F00FDAF7300C67C440097613D00341D1E000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B6537003ED640003FFC43003FCC42003FCC42003FCC42003E973D002834
      1D000000000000000000000000000000000048A348006FB86F006BB66B0089C4
      8900FEFEFE007ABC7A0048A34800FEFEFE009BCD9B0033983300CCE5CC00C8E5
      C8002C982C002C982C001F811F0000000000000000003532B300221CCF00251B
      E1002027DB0064B6EB00B3FFFD00E9CAB000C6CEC300817377006B626A003ADA
      F4001E3FCC00362F9D0000000000000000000000000000000000000000000000
      0000000000000000000065463700CC7C3F0097613D00341D1E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B6537003ED640003FCC42003E973D003E973D003E973D003E973D002834
      1D000000000000000000000000000000000050A850007CC17C0078BC780091C8
      910088C4880057AB570051A85100FEFEFE00A1D0A1003C9E3C00399C39009CCD
      9C0033983300339833001F811F000000000000000000000000001C17B600231E
      D500241AE1001F20DB003E81E000ABB3AD00B2CBBA0068DCE500618398002355
      C8001B12BB005957A10000000000000000000000000000000000000000000000
      000000000000000000000000000065463700341D1E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003B6537003B6537003B6537003B6537003B6537003B6537003B653700324D
      2A00000000000000000000000000000000005EAF5E008FD38F0084CB840078BC
      78006BB66B0067B467005FAF5F00FEFEFE00ABD5AB0051A8510051A8510045A2
      450042A14200369A36001F811F00000000000000000000000000000000001C18
      B700221DD000241CDC002015DB001F2AD500284FD7002459DD001A31CF001D12
      BC003532A7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000068B4680096D596008FD38F0078BC
      780073BA730067B4670067B4670063B163005FAF5F005BAD5B0057AB57004EA6
      4E0042A142002F982F001F811F00000000000000000000000000000000000000
      0000302DB2001E19BE00201BC8002019CE001F14CB001E11C1001B14B600615F
      B000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000061B1610057AC570049A3
      490045A1450042A0420042A042003F9E3F003B9E3B00389E380032973200329C
      3200269126001D8B1D0000000000000000000000000000000000000000000000
      00000000000000000000504EB7002C29AB002E2BA8005755B200000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFE7F0000F03FC001FE3F0000
      800F8000F81F000080030000F80F000080010000F807000000000000F0030000
      00000000C00F0000000000008007000000000000C00F000000000001C0070000
      00000007E003000000000007E0010000000081FFE00300008001C3FFF8070000
      C003FFFFFE0F0000F00FFFFFFF9F0000FFFFFFFFFFFFFFFFFFFFC001FFFFC001
      E0078000FFFF8000C0030000FFFF000080010000EFFF000080010000EFC70000
      80010000C7BB000080000000FBBB000080000000E7BB000080000001DFBB0001
      80000007E3BB000780010007F7C70007800381FFFFFF81FFC0FFC3FFFFFFC3FF
      E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF80FC003FFFFFFFFF007C003FFFFFFFF
      E003C003FFFFFFFFC001C003E007E0078001C003E007E00700008003E007E007
      00000003E007E00700000003E007E00700000003E007E00700000003E007E007
      00008003E007E0078001C003E003E0078003C003E005E007C007C003FFFFFFFF
      E00FC007FFFFFFFFF83FC00FFFFFFFFFFFFFFFFFF81FFFFFF81FFFFFE007E07F
      80000000C0038007000000008001800100000000800080010001000080008001
      F81FF00080008001FC3FF00080008001FC3FFF0080008001FC3FFF0080008001
      FC3FFF00C0008001FC3FFFF0E0018001FC7FFFF0F18FE001FFFFFFF0F18FFE03
      FFFFFFFFF18FFFE7FFFFFFFFF9CFFFFF87FF87FFF827C3FF80FF80FFF803C00F
      003F003FC801C003001F001F8001E001001F001F0001F801003F003F0000FFE1
      0003000381C0FE01000100018380FC03C000C0000001F807FC00FC000000F007
      FC00FC000000E007FC00FC008001C00FFC00FC00E003C01FFC01FC01E00FC03F
      FE01FE01F11FC07FFF03FF03FFFFE0FFFFFFFFFFFFFFFFFFF00FFE7F8003FFFF
      F00FFC3F0001F03FF00FF81F0001C00FF00FF00F00018007F00FE00700018007
      0000C003000100038001800100010003C003000000010003E007F00F00010003
      F00FF00F00018003F81FF00F00018003FC3FF00F0001C003FE7FF00F0001E007
      FFFFFFFF0001F00FFFFFFFFF8003FC3F00000000000000000000000000000000
      000000000000}
  end
  object pmHistory: TPopupMenu
    Images = ilMenu
    OwnerDraw = True
    Left = 64
    Top = 216
    object miHistReExecute: TMenuItem
      Caption = '&Re-execute'
      ImageIndex = 40
      OnClick = miHistReExecuteClick
    end
    object miHistDelete: TMenuItem
      Caption = '&Delete'
      ImageIndex = 41
      OnClick = miHistDeleteClick
    end
    object N27: TMenuItem
      Caption = '-'
    end
    object miOpenDir: TMenuItem
      Caption = '&Open directory...'
      ImageIndex = 36
      OnClick = miOpenDirClick
    end
    object N21: TMenuItem
      Caption = '-'
    end
    object Clearall1: TMenuItem
      Caption = '&Clear all...'
      ImageIndex = 39
      OnClick = Clearall1Click
    end
  end
  object ilELF: TImageList
    Left = 96
    Top = 216
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      6600666666006666660066666600666666006666660066666600666666006666
      6600666666006666660066666600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000949494007F7F7F007E7E
      7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E007D7D7D00848484007D7D7D000000000000000000AE7B6E00D9AD
      9D00D6A89A00D3A69800D2A49700CCA19900C99E9700C69C9600C4999500C196
      9300B6918B00B88E8B0066666600000000000000000000000000000000000000
      0000004152000041520000415200004152000041520000415200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BA806200945939008C5132008C51
      32008B5132008C5132008C5132008C5132008C5132008C5132008C5132008C51
      3200894F31008E51330073503F007D7D7D000000000000000000B5827200FCE1
      CB00FBE0C800FBDEC400FBDCC200FADABE00FAD8BB00FBD7B800FAD4B400F9D2
      B100FAD0AE00EEBDA50066666600000000000000000000415200004152000041
      5200006C82000092AC00009EB900009EB900009EB900009EB900004152004A27
      0F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D7B29B00FAF5F300F9F5F200F8F5
      F200F7F5F200F9F5F200F9F5F200F9F5F200F9F5F200F9F5F200F9F5F200F9F5
      F200FAF5F300F9F5F200855E47007D7D7D000000000000000000BB887500FCE4
      CF00FCE2CC00FBE0C900FBDEC600FBDCC300FBDABF00FBD9BC00FAD6B800FAD5
      B500FAD3B100EFBFA800666666000000000000000000004152000098B200009E
      B900009EB900009EB900009EB900009EB900009EB900009EB900004152005A2F
      12004A270F004A270F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DBB9A300FFFFFF00FDFFFF00FDFF
      FF00FCFFFF00FCFFFF00FCFFFF00FCFFFF00FCFFFF00FCFFFF00FCFFFF00FCFF
      FF00FDFFFF00FEFFFF00855E47007D7D7D000000000000000000C28F7900FCE7
      D400FCE4D100FCE3CE00FCE1CA00FBDFC700FBDCC400FBDBC000FADABC00FBD7
      B900FBD5B600F0C1AB0066666600000000000000000000415200008EA700009E
      B900009EB900009EB900009EB9000099B3000091AA0000728700004152006B38
      15007C4118006B3815004A270F00000000000000000000000000000000000080
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DDB99F00FFFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FBFFFF00FDFFFE00886045007D7D7D000000000000000000C8957C00FCE8
      D800FCE6D500FCE5D200FCE3CE00FBE1CB00FBE0C800FBDEC400FADCC100FBD9
      BE00FAD8BB00F0C3AF0066666600000000005A2F120052514300007991000087
      9F0000637700004D5F00004D5F00004D5F00004A5C0000415200213533006B38
      15007C4118008C491B007B4018004A270F000000000000000000000000000080
      0000000000000000000000000000000000000000000000000000008000000080
      000000800000000000000000000000000000E0BB9D00FFFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FBFFFF00FDFFFE008A6245007D7D7D000000000000000000CF9C8000FCEB
      DD00FDEADA00FCE7D600FCE6D300FCE4CF00FCE2CC00FBE0C900FBDEC600FBDC
      C200FADBBF00F1C5B10066666600000000005A2F1200845F3F00004152000058
      6C000A95AD0021B9CC0042E8F5004BF4FF004BF4FF0045CFD700253431004A27
      0F006B3815008C491B008C491B004A270F000000000000000000008000000080
      0000008000000000000000000000000000000000000000800000000000000000
      000000000000008000000000000000000000E3BC9C00FFFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FBFFFF00FCFFFE008D6345007D7D7D000000000000000000D5A28300FDEE
      E000FDECDD00FCEADB00FCE8D700FCE6D300FCE4D100FBE2CD00FBE1CA00FBDF
      C600FBDDC300F2C8B50066666600000000005A2F1200A46032002D3D38002EA4
      B3003FE4F5004BF4FF0047F0FF0044EDFF004DEBF60054A3A00030555600834F
      2D004A270F004A270F007C4118004A270F000000000000000000000000000000
      0000000000000080000000000000000000000000000000800000000000000000
      000000000000008000000000000000000000E5BE9A00FFFFFF00FAFFFF00FBFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFF
      FF00FAFFFF00FEFFFD008F6544007D7D7D000000000000000000DCA98700FEF0
      E500FDEEE100FDECDF00FDEBDB00FDE9D800FCE6D500FCE5D100FBE3CE00FCE1
      CA00FBDFC700F2C9B70066666600000000005A2F12006B381500A5673E00004D
      5F003FA7B2003CE6FF003CE6FF003CE6FF004ADEED00004D5F00AE805C00FCAB
      7900DC9262009D643E004A270F004A270F000000000000000000000000000080
      0000008000000000000000000000000000000000000000800000000000000000
      000000000000008000000000000000000000E7BF9800FFFFFF00FAFFFF00FAFF
      FF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FAFFFF00FBFF
      FF00FBFFFF00FEFFFD00926744007D7D7D000000000000000000DCA98700FDF3
      EA00FDF1E600FDEFE300FDEDDF00FCEBDC00FDE9D900FDE7D600FCE5D300FCE4
      CF00FCE1CB00F3CCBA0066666600000000005A2F1200AA693E00E9996500C881
      5300004D5F003FA7B20029D6EF0029D6EF004AACB300565C4F00E89A6900FCAB
      7900FCAB7900FCAB7900AA6E45004A270F000000000000000000008000000000
      0000000000000000000000000000000000000000000000800000000000000000
      000000000000008000000000000000000000EDC39C00FFFFFF00FFFFFF00FEFF
      FF00FEFFFF00FEFFFF00FEFFFF00FFFFFF00FEFFFF00FEFFFF00FEFFFF00FEFF
      FF00FFFFFF00FFFFFF00956640007D7D7D000000000000000000DCA98700FDF5
      ED00FEF3EA00FDF2E700FDEFE400FDEDE100FDECDE00FCEADA00FCE8D700FCE6
      D300FCE4D000F3CDBD0066666600000000006B381500D7895400E9996500E999
      6500C57F5000004A5B003FA7B20033C1D400004D5F00C17C4F00F3A26F00F3A2
      6F00FCAB7900FCAB7900EA9D6E005B3012000000000000000000000000000080
      0000008000000080000000000000000000000000000000800000000000000000
      000000000000008000000000000000000000E0B48400E5E0D700E4DCCF00E5DD
      D000E5DCD000E5DCD000E4DDD000E5DCD000E5DCD000E4DCD000E3DACB00E3DA
      CC00E7DBC900ECDABD009B7A5A007D7D7D000000000000000000DCA98700FEF8
      F200FEF5EE00FDF4EC00FDF2E800FDF0E500FDEEE200FDECDE00FDEADA00FCE8
      D800FCE6D400F4C9BA0066666600000000007B401800C4794600E9996500E999
      6500E9996500C37D4D00004758003FA7B200565C4F00DA8F5F00F3A26F00F3A2
      6F00F3A26F00FCAB7900FCAB79006B3815000000000000000000000000000000
      0000008000000000000000000000000000000000000000000000008000000080
      000000800000000000000000000000000000BC670E00BD641000BC630D00BD64
      0D00BD640D00BD640E00BC630D00BC620B00BC630B00BC630C00C8782800CA73
      2000B36F37007C575200AE9478007D7D7D000000000000000000DCA98700FFFA
      F700FEF8F300FEF6F000FEF4EC00FEF2E900FDF1E600FDEFE200FFD5CC00FFD5
      CC00F5B3AA00B3887E0066666600000000008C491B00A8613100E0915B00E999
      6500E9996500E9996500C37D4D0000415200CE845200E9996500E9996500F3A2
      6F00F3A26F00F1A16E00C67A49008C491B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E09A4900E5943600E7923000E790
      2D00E6912B00E68F2C00E6922F00E6902D00E68F2600E48C2400E78F2B00E990
      2A00E3913400CE873E00E3913400000000000000000000000000DCA98700FFFD
      FB00FFFBF700FEF9F400FEF7F100FEF5ED00FDF3EB00FDF1E700F7A64300F7A6
      4300E0924100666666000000000000000000000000008C491B00A8613100D285
      5100E0915B00E9996500E9996500BC784900E9996500E9996500E9996500E999
      6500E1925F00B36B3B008C491B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DCA98700FFFF
      FF00FFFEFB00FFFBF800FEFAF500FEF8F100FEF6EE00FDF3EC00DCA98700EAB3
      77006666660000000000000000000000000000000000000000008C491B008C49
      1B00B66D3B00CD814D00E0915B00E0915B00E0915B00E0915B00CD814D00B66D
      3B008C491B008C491B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DCA98700DCA9
      8700DCA98700DCA98700DCA98700DCA98700DEAB8800D6A38400DCA987006666
      6600000000000000000000000000000000000000000000000000000000000000
      00008C491B008C491B008C491B008C491B008C491B008C491B008C491B008C49
      1B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFE001FFFFFFFF8000C001F03FFFFF
      0000C001800FFFFF0000C0018003FFFF0000C0018001EFFF0000C0010000EFC7
      0000C0010000C7BB0000C0010000FBBB0000C0010000E7BB0000C0010000DFBB
      0000C0010000E3BB0000C0010000F7C70000C0010000FFFF0001C0038001FFFF
      FFFFC007C003FFFFFFFFC00FF00FFFFF00000000000000000000000000000000
      000000000000}
  end
  object pmMultiSyn: TPopupMenu
    Images = ilMenu
    OwnerDraw = True
    Left = 96
    Top = 248
    object pmCloseTab: TMenuItem
      Caption = '&Close'
      ImageIndex = 23
      OnClick = miCloseTabClick
    end
    object N23: TMenuItem
      Caption = '-'
    end
    object miSeCopyText: TMenuItem
      Caption = '&Copy'
      ImageIndex = 15
      ShortCut = 16451
      OnClick = miCopyTextClick
    end
    object miSeSelectAll: TMenuItem
      Caption = '&Select all'
      ImageIndex = 14
      ShortCut = 16449
      OnClick = miSelectAllClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object miSeFindText: TMenuItem
      Caption = '&Find text...'
      ImageIndex = 17
      ShortCut = 16454
      OnClick = miFindTextClick
    end
    object miSeSearchForward: TMenuItem
      Caption = 'Search forward'
      ImageIndex = 26
      ShortCut = 114
      OnClick = miSearchForwardClick
    end
    object miSeSearchBackward: TMenuItem
      Caption = 'Search backward'
      ImageIndex = 25
      OnClick = miSearchBackwardClick
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object miSeSave: TMenuItem
      Caption = '&Save...'
      ImageIndex = 18
      ShortCut = 16467
      OnClick = miSaveLogClick
    end
  end
  object DcToolCygWinCfg: TDcToolCygWinCfg
    Config = ccInternal
    DcTool = DCTool
    Left = 128
    Top = 88
  end
  object sdLog: TSaveDialog
    DefaultExt = 'rtf'
    Filter = 
      'RTF files (*.rtf)|*.rtf|Text files (*.txt;*.log)|*.txt;*.log|All' +
      ' files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save log to...'
    Left = 128
    Top = 120
  end
  object sdSyn: TSaveDialog
    DefaultExt = 'log'
    Filter = 'Text files (*.log;*.txt)|*.log;*.txt|All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save log to...'
    Left = 128
    Top = 152
  end
  object tiUpdateApp: TTimer
    Interval = 1
    OnTimer = tiUpdateAppTimer
    Left = 128
    Top = 184
  end
  object SynEditSearch: TSynEditSearch
    Left = 128
    Top = 216
  end
  object SynEditRegexSearch: TSynEditRegexSearch
    Left = 128
    Top = 248
  end
  object FindDialog: TFindDialog
    Options = [frDown, frHideUpDown]
    OnFind = FindDialogFind
    Left = 64
    Top = 248
  end
  object pmDebugLog: TPopupMenu
    Images = ilMenu
    OwnerDraw = True
    Left = 64
    Top = 280
    object Copy1: TMenuItem
      Caption = '&Copy'
      ImageIndex = 15
      ShortCut = 16451
      OnClick = miCopyTextClick
    end
    object Selectall1: TMenuItem
      Caption = '&Select all'
      ImageIndex = 14
      ShortCut = 16449
      OnClick = miSelectAllClick
    end
    object N28: TMenuItem
      Caption = '-'
    end
    object Findtext1: TMenuItem
      Caption = 'Find text...'
      ImageIndex = 17
      ShortCut = 16454
      OnClick = miFindTextClick
    end
    object Searchforward1: TMenuItem
      Caption = '&Search forward'
      ImageIndex = 26
      ShortCut = 114
      OnClick = miSearchForwardClick
    end
    object N29: TMenuItem
      Caption = '-'
    end
    object Save1: TMenuItem
      Caption = '&Save...'
      ImageIndex = 18
      ShortCut = 16467
      OnClick = miSaveLogClick
    end
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = True
    XPContainers = []
    XPControls = [xcMainMenu, xcPopupMenu]
    Active = True
    Left = 64
    Top = 120
  end
end
