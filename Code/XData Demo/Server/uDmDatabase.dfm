object dmArcherySystem: TdmArcherySystem
  Height = 480
  Width = 640
  object fdConArcherySystem: TFDConnection
    Params.Strings = (
      
        'Database=C:\Data\EKON\EKON 2026 (30)\GettingStartedWithXData_Pri' +
        'vate\ARCHERYSYSTEM.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    LoginPrompt = False
    Left = 304
    Top = 224
  end
end
