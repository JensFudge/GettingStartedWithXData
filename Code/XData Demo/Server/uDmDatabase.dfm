object dmArcherySystem: TdmArcherySystem
  Height = 480
  Width = 640
  object fdConArcherySystem: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    LoginPrompt = False
    Left = 304
    Top = 224
  end
end
