object ServerContainer: TServerContainer
  Height = 210
  Width = 431
  object SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher
    Left = 72
    Top = 16
  end
  object XDataServer: TXDataServer
    BaseUrl = 'http://+:2001/tms/xdata'
    Dispatcher = SparkleHttpSysDispatcher
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerOptions.AuthMode = Jwt
    SwaggerUIOptions.Enabled = True
    Left = 216
    Top = 16
    object XDataServerJWT: TSparkleJwtMiddleware
      Secret = 'ArcheryIsAVeryCoolSportAndILoveIt'
    end
  end
end
