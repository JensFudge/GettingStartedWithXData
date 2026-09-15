unit HelloWorldServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  HelloWorldService;

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
  Result := 'Hello from XData server';
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
