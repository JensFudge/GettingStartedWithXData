unit HelloWorldServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  HelloWorldService,
  System.SysUtils;

type
  [ServiceImplementation]
  THelloWorldService = class(TInterfacedObject, IHelloWorldService)
  private
    function Sum(A, B: double): double;
    function EchoString(Value: string): string;
    function HelloWorld : string;
  end;

implementation

function THelloWorldService.HelloWorld: string;
begin
  var lUserID : string := 'unknown';

  if TXDataOperationContext.Current.Request.User.Claims.Exists('UserID') then
    lUserID := TXDataOperationContext.Current.Request.User.Claims['UserID'].asString;

  var lExpiresD := TXDataOperationContext.Current.Request.User.Claims['exp'].asEpoch;
  var lExpiresS := DateTimeTostr(lExpiresD);
  Result := format('Hello %s from XData server. Your token will expire at %s',[lUserID, lExpiresS]);
end;

function THelloWorldService.Sum(A, B: double): double;
begin
  Result := A + B;
end;

function THelloWorldService.EchoString(Value: string): string;
begin
  Result := Value;
end;

initialization
  RegisterServiceType(THelloWorldService);

end.
