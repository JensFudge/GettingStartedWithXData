object frmMainDBSetup: TfrmMainDBSetup
  Left = 0
  Top = 0
  Caption = 'Create Archer database'
  ClientHeight = 653
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 66
    Height = 15
    Caption = 'Create script'
  end
  object btnCreateDatabase: TButton
    Left = 24
    Top = 620
    Width = 497
    Height = 25
    Caption = 'Create demo database'
    TabOrder = 0
    OnClick = btnCreateDatabaseClick
  end
  object mmoCreate: TMemo
    Left = 24
    Top = 24
    Width = 497
    Height = 561
    Lines.Strings = (
      'CREATE TABLE COUNTRY ('
      '    COUNTRYID CHAR(38) NOT NULL,'
      '    COUNTRYNAME VARCHAR(100) NOT NULL,'
      '    COUNTRYABBREVIATION CHAR(3) NOT NULL,'
      '    CONSTRAINT PK_COUNTRY PRIMARY KEY (COUNTRYID)'
      ');'
      ''
      'CREATE TABLE ARCHER ('
      '    ARCHERID CHAR(38) NOT NULL,'
      '    ARCHERNAME VARCHAR(100) NOT NULL,'
      '    BOWTYPE INTEGER NOT NULL,'
      '    COUNTRYID CHAR(38),'
      '    CONSTRAINT PK_ARCHER PRIMARY KEY (ARCHERID),'
      '    CONSTRAINT FK_ARCHER_COUNTRY'
      '        FOREIGN KEY (COUNTRYID)'
      '        REFERENCES COUNTRY (COUNTRYID)'
      ');'
      ''
      'INSERT INTO COUNTRY'
      '    (COUNTRYID, COUNTRYNAME, COUNTRYABBREVIATION)'
      'VALUES'
      
        '    ('#39'{A1B2C3D4-1111-4444-8888-000000000001}'#39', '#39'Denmark'#39', '#39'DEN'#39')' +
        ';'
      ''
      'INSERT INTO COUNTRY'
      '    (COUNTRYID, COUNTRYNAME, COUNTRYABBREVIATION)'
      'VALUES'
      
        '    ('#39'{A1B2C3D4-2222-4444-8888-000000000002}'#39', '#39'Germany'#39', '#39'GER'#39')' +
        ';'
      ''
      'INSERT INTO COUNTRY'
      '    (COUNTRYID, COUNTRYNAME, COUNTRYABBREVIATION)'
      'VALUES'
      
        '    ('#39'{A1B2C3D4-3333-4444-8888-000000000003}'#39', '#39'Great Britain'#39', ' +
        #39'GBR'#39');'
      ''
      ''
      'INSERT INTO ARCHER'
      '    (ARCHERID, ARCHERNAME, BOWTYPE, COUNTRYID)'
      'VALUES'
      '    ('#39'{B1C2D3E4-1111-4444-8888-000000000001}'#39','
      '     '#39'Anna Jensen'#39','
      '     1,'
      '     '#39'{A1B2C3D4-1111-4444-8888-000000000001}'#39');'
      ''
      'INSERT INTO ARCHER'
      '    (ARCHERID, ARCHERNAME, BOWTYPE, COUNTRYID)'
      'VALUES'
      '    ('#39'{B1C2D3E4-2222-4444-8888-000000000002}'#39','
      '     '#39'Peter Nielsen'#39','
      '     2,'
      '     '#39'{A1B2C3D4-1111-4444-8888-000000000001}'#39');'
      ''
      'INSERT INTO ARCHER'
      '    (ARCHERID, ARCHERNAME, BOWTYPE, COUNTRYID)'
      'VALUES'
      '    ('#39'{B1C2D3E4-3333-4444-8888-000000000003}'#39','
      '     '#39'Michael Schmidt'#39','
      '     3,'
      '     '#39'{A1B2C3D4-2222-4444-8888-000000000002}'#39');'
      ''
      'INSERT INTO ARCHER'
      '    (ARCHERID, ARCHERNAME, BOWTYPE, COUNTRYID)'
      'VALUES'
      '    ('#39'{B1C2D3E4-4444-4444-8888-000000000004}'#39','
      '     '#39'Sarah Williams'#39','
      '     3,'
      '     '#39'{A1B2C3D4-3333-4444-8888-000000000003}'#39');'
      ''
      'INSERT INTO ARCHER'
      '    (ARCHERID, ARCHERNAME, BOWTYPE, COUNTRYID)'
      'VALUES'
      '    ('#39'{B1C2D3E4-5555-4444-8888-000000000005}'#39','
      '     '#39'Thomas M'#252'ller'#39','
      '     4,'
      '     '#39'{A1B2C3D4-2222-4444-8888-000000000002}'#39');')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object sdDatabase: TFileSaveDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 416
    Top = 336
  end
end
