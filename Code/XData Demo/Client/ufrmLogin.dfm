object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 163
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object edUser: TLabeledEdit
    Left = 40
    Top = 40
    Width = 337
    Height = 23
    EditLabel.Width = 23
    EditLabel.Height = 15
    EditLabel.Caption = 'User'
    TabOrder = 0
    Text = ''
  end
  object edPass: TLabeledEdit
    Left = 40
    Top = 88
    Width = 337
    Height = 23
    EditLabel.Width = 50
    EditLabel.Height = 15
    EditLabel.Caption = 'Password'
    PasswordChar = '*'
    TabOrder = 1
    Text = ''
  end
  object btnOK: TButton
    Left = 213
    Top = 122
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 302
    Top = 122
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
