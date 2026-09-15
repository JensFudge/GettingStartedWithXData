unit ArcherServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  Bcl.Types.Nullable,
  ArcherService,
  uBowType,
  uArcher;

type
  [ServiceImplementation]
  TArcherService = class(TInterfacedObject, IArcherService)
  private
    procedure RequireAdmin(aOperationName : string);
   function GetCountryID(aCountryAbbreviation : Nullable<string>) : Nullable<TGUID>;
  public
    function GetArcher(ID : TGUID) : TArcher;
    function GetArchers : TArchers;
    function NewArcher(ArcherName : string; BowType : TBowType; CountryAbbreviation : Nullable<string>) : TArcher;

    function updateArcher(ArcherID : TGUID; ArcherValues : TUpdateArcherDTO) : TArcher;
    procedure DeleteArcher(ArcherID : TGUID);
  end;

implementation

uses
  uArcherDB,
  uCountryDB,
  System.SysUtils,
  XData.Sys.Exceptions;


{ TArcherService }




function TArcherService.GetArcher(ID: TGUID): TArcher;
begin
  Result := TArcher.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);

  if not TArcherDB.GetArcherFromDB(ID, Result) then
    raise EXDataHttpException.Create(404, 'Not Found', format('Archer %s not found',[GuidToString(ID)]));    //Uses XData.Sys.Exceptions
end;

function TArcherService.GetArchers: TArchers;
begin
  Result := TArchers.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);
  TArcherDB.GetArchersFromDB(Result);
end;

procedure TArcherService.RequireAdmin(aOperationName : string);
begin
   if TXDataOperationContext.Current.Request.User.Claims.Exists('admin') then
   begin
     var isAdmin :=  TXDataOperationContext.Current.Request.User.Claims['admin'].asBoolean;
     if not isAdmin then
       Raise EXDataHttpForbidden.Create(format('You must have administrator privileges to perform %s',[aOperationName]))
   end
   else
     Raise EXDataHttpForbidden.Create(format('You must have administrator privileges to perform %s',[aOperationName]))
end;


function TArcherService.GetCountryID(aCountryAbbreviation : Nullable<string>) : Nullable<TGUID>;
begin

  Result := SNull;

  if aCountryAbbreviation.HasValue then
  begin
    var lCountryID := TCountryDB.GetCountryIDFromDB(aCountryAbbreviation);
    if lCountryID.HasValue then
    begin
      Result := lCountryID;
    end
    else
      Raise EXDataHttpException.Create(404, 'Not Found', format('Country %s not found',[aCountryAbbreviation.Value]));
  end;

end;


function TArcherService.NewArcher(ArcherName : string; BowType : TBowType; CountryAbbreviation : Nullable<string>) : TArcher;
begin
   //Will raise an exception if the user isn't admin
   RequireAdmin('NewArcher');

   //We need to make sure if the user passed a country, that the country is valid
   var lCountryID  := GetCountryID(CountryAbbreviation);


   var lArcherID : TGUID := TArcherDB.InsertArcherInDb(ArcherName, BowType, lCountryID);

   Result := TArcher.Create;
   TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);
   TArcherDB.GetArcherFromDB(lArcherID, Result);

end;

function TArcherService.updateArcher(ArcherID: TGUID;
  ArcherValues: TUpdateArcherDTO): TArcher;
begin

  RequireAdmin('updateArcher');

  if not TArcherDB.ArcherExists(ArcherID) then
    Raise EXDataHttpException.Create(404, 'Not Found', format('Archer %s not found',[GuidToString( ArcherId)]));

  var lCountryID  := GetCountryID(ArcherValues.CountryAbbreviation);

  if not TArcherDB.UpdateArcherInDb(ArcherID, ArcherValues, lCountryID) then
    Raise EXDataHttpException.Create(500, 'Internal Server Error', format('Archer %s could not be updated',[GuidToString( ArcherId)]));

  Result := TArcher.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);
  TArcherDB.GetArcherFromDB(ArcherId, Result);
end;

procedure TArcherService.DeleteArcher(ArcherID: TGUID);
begin
  RequireAdmin('DeleteArcher');

  if not TArcherDB.ArcherExists(ArcherID) then
    Raise EXDataHttpException.Create(404, 'Not Found', format('Archer %s not found',[GuidToString( ArcherId)]));

  if not TArcherDB.DeleteArcher(ArcherID) then
    Raise EXDataHttpException.Create(500, 'Internal Server Error', format('Archer %s was not deleted',[GuidToString( ArcherId)]));

end;


initialization
  RegisterServiceType(TArcherService);

end.
