unit CountryServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  CountryService,
  uCountry;

type
  [ServiceImplementation]
  TCountryService = class(TInterfacedObject, ICountryService)
  function GetCountry(ID : TGUID) : TCountry;
  end;

implementation

uses
  uCountryDB,
  System.SysUtils,
  XData.Sys.Exceptions;

{ TCountryService }

function TCountryService.GetCountry(ID: TGUID): TCountry;
begin
   //Uses XData.Sys.Exceptions

  Result := TCountry.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);

  if not TCountryDB.GetCountryFromDB(ID, Result) then
    raise EXDataHttpException.Create(404, format('Country %s not found',[GuidToString(ID)]));
end;

initialization
  RegisterServiceType(TCountryService);

end.
