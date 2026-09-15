unit LoginService;

interface

uses
  XData.Service.Common;

type
  [ServiceContract]
  ILoginService = interface(IInvokable)
    ['{835726D1-45BC-48C1-A82D-C0C8C37CE7B6}']

    [HttpPost]
      //The returned string is the JWT token
    function Login(UserID, Password : string) : string;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(ILoginService));

end.
