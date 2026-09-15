object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Archery application'
  ClientHeight = 334
  ClientWidth = 972
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object lblCountryName: TLabel
    Left = 512
    Top = 112
    Width = 11
    Height = 15
    Caption = ' - '
  end
  object btnGetArchers: TButton
    Left = 125
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Get Archers'
    TabOrder = 0
    OnClick = btnGetArchersClick
  end
  object lvArchers: TListView
    Left = 24
    Top = 72
    Width = 473
    Height = 225
    Columns = <
      item
        AutoSize = True
        Caption = 'ID'
      end
      item
        AutoSize = True
        Caption = 'Name'
      end
      item
        AutoSize = True
        Caption = 'Bowtype'
      end
      item
        AutoSize = True
        Caption = 'CountryAbb'
      end
      item
        AutoSize = True
        Caption = 'Country'
      end>
    TabOrder = 1
    ViewStyle = vsReport
  end
  object btnNewArcher: TButton
    Left = 221
    Top = 24
    Width = 75
    Height = 25
    Caption = 'New Archer'
    TabOrder = 2
    OnClick = btnNewArcherClick
  end
  object btnLogin: TButton
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 3
    OnClick = btnLoginClick
  end
  object edToken: TEdit
    Left = 24
    Top = 303
    Width = 473
    Height = 23
    TabOrder = 4
  end
  object btnEditArcher: TButton
    Left = 320
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Edit Archer'
    TabOrder = 5
    OnClick = btnEditArcherClick
  end
  object btnDeleteArcher: TButton
    Left = 416
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Delete Archer'
    TabOrder = 6
    OnClick = btnDeleteArcherClick
  end
  object btnCountryArchers: TButton
    Left = 512
    Top = 24
    Width = 153
    Height = 25
    Caption = 'Country && Archers'
    TabOrder = 7
    OnClick = btnCountryArchersClick
  end
  object edCountry: TEdit
    Left = 512
    Top = 72
    Width = 121
    Height = 23
    TabOrder = 8
    Text = 'DEN'
  end
  object mmoHistory: TMemo
    Left = 688
    Top = 72
    Width = 265
    Height = 254
    ScrollBars = ssVertical
    TabOrder = 9
  end
  object BtnRefreshHistory: TButton
    Left = 688
    Top = 24
    Width = 265
    Height = 25
    Caption = 'Refresh History'
    TabOrder = 10
    OnClick = BtnRefreshHistoryClick
  end
end
