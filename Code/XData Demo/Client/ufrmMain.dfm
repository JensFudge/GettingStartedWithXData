object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Archery application'
  ClientHeight = 334
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object btnGetArchers: TButton
    Left = 24
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
end
