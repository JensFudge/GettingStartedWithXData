unit CountryService;

interface

uses
  XData.Service.Common,
  uCountry;

type
  [ServiceContract]
  ICountryService = interface(IInvokable)
    ['{B0CFA585-529F-4625-906A-33841D3D4044}']

    [HttpGet]
    function GetCountry(ID : TGUID) : TCountry;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(ICountryService));

end.
