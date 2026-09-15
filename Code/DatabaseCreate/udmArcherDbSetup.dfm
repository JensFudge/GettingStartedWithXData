object dmArcher: TdmArcher
  Height = 332
  Width = 529
  object fdArcherDB: TFDConnection
    LoginPrompt = False
    Left = 56
    Top = 48
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 248
    Top = 152
  end
  object fdArcherTables: TFDScript
    SQLScripts = <>
    Connection = fdArcherDB
    Params = <>
    Macros = <>
    Left = 304
    Top = 48
  end
end
