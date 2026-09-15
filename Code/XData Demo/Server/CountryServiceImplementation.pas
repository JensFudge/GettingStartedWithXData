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
  function GetCountryAndArchers(CountryAbbreviation : string) : TCountryArchersDTO;
  end;

implementation

uses
  uCountryDB,
  uArcher,
  uArcherDB,
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

function TCountryService.GetCountryAndArchers(
  CountryAbbreviation: string): TCountryArchersDTO;
begin
  Result :=  TCountryArchersDTO.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);
  Result.Country := TCountry.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result.Country);
  if not TCountryDB.GetCountryFromDB(CountryAbbreviation, Result.Country) then
    raise EXDataHttpException.Create(404, format('Country %s not found',[CountryAbbreviation]));
  Result.Archers := TArchers.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result.Archers);
  TArcherDB.GetArchersFromDB(Result.Archers, Result.Country.CountryID);
end;

initialization
  RegisterServiceType(TCountryService);

end.
