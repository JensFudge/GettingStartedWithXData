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


{ TArcherService }
//   ['{E9EB4A14-0E49-40E5-94F8-DA6015582D11}']

function TArcherService.GetArcher(ID: TGUID): TArcher;
begin
  Result := TArcher.Create;
  TXDataOperationContext.Current.Handler.ManagedObjects.Add(Result);
  Result.ArcherID := ID;
  Result.ArcherName := 'Jens Fudge';
  Result.BowType := TBowType.btOlympicRecurve;
end;

initialization
  RegisterServiceType(TArcherService);

end.
