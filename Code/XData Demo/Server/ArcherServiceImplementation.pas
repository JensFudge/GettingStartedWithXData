unit ArcherServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  Aurelius.Types.Nullable,
  ArcherService,
  uBowType,
  uArcher;

type
  [ServiceImplementation]
  TArcherService = class(TInterfacedObject, IArcherService)
    function GetArcher(ID : TGUID) : TArcher;
  end;

implementation

uses
  uArcherDB,
  System.SysUtils,
  XData.Sys.Exceptions;


{ TArcherService }


function TArcherService.GetArcher(ID: TGUID): TArcher;
begin
  Result := TArcher.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);

  if not TArcherDB.GetArcherFromDB(ID, Result) then
    raise EXDataHttpException.Create(404, format('Archer %s not found',[GuidToString(ID)]));    //Uses XData.Sys.Exceptions
end;

initialization
  RegisterServiceType(TArcherService);

end.
