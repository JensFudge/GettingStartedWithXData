object frmArcher: TfrmArcher
  Left = 0
  Top = 0
  Caption = 'Archer Editor'
  ClientHeight = 244
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 85
    Width = 50
    Height = 15
    Caption = 'Bow Type'
  end
  object edArcherName: TLabeledEdit
    Left = 40
    Top = 48
    Width = 337
    Height = 23
    EditLabel.Width = 68
    EditLabel.Height = 15
    EditLabel.Caption = 'Archer name'
    TabOrder = 0
    Text = ''
  end
  object edCountryAbbreviation: TLabeledEdit
    Left = 40
    Top = 168
    Width = 337
    Height = 23
    EditLabel.Width = 114
    EditLabel.Height = 15
    EditLabel.Caption = 'Country Abbreviation'
    TabOrder = 1
    Text = ''
  end
  object cbBowType: TComboBox
    Left = 40
    Top = 104
    Width = 337
    Height = 23
    ItemIndex = 0
    TabOrder = 2
    Text = 'None'
    Items.Strings = (
      'None'
      'Longbow'
      'Traditional'
      'Barebow'
      'Olympic Recurve'
      'Compound')
  end
  object btnOK: TButton
    Left = 213
    Top = 211
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 302
    Top = 211
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
