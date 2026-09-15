unit HelloWorldService;

interface

uses
  XData.Service.Common;

type
  [ServiceContract]
  IHelloWorldService = interface(IInvokable)
    ['{40459B83-626F-44E6-A0CC-141EFC1EBD45}']
    [HttpGet]
    function Sum(A, B: double): double;
    // By default, any service operation responds to (is invoked by)
    //a POST request from the client.
    function EchoString(Value: string): string;

    [HttpGet]
    function HelloWorld : string;

  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IHelloWorldService));

end.
