unit LoginServiceImplementation;

interface

uses
  XData.Server.Module,
  XData.Service.Common,
  LoginService;

type
  [ServiceImplementation]
  TLoginService = class(TInterfacedObject, ILoginService)

  function Login(UserID, Password : string) : string;
  end;

implementation


uses
  System.DateUtils,
  System.SysUtils,
  XData.Sys.Exceptions,
  Bcl.jose.Core.Builder,
  Bcl.jose.Core.JWT;

{ TLoginService }


{
function TLoginService.Login(UserID, Password: string): string;
begin
  //uses
  // System.SysUtils,
  // XData.Sys.Exceptions,
  // Bcl.jose.Core.Builder,
  // Bcl.jose.Core.JWT;

  if UserID <> '' then
  begin
    var lToken := TJWT.Create;
    try
      Result := TJOSE.SHA256CompactToken('ArcheryIsAVeryCoolSportAndILoveIt', lToken );
    finally
      lToken.Free;
    end;
  end
  else
  begin
    raise EXDataHttpUnauthorized.Create(
      'Blank User is not permitted'
    );
  end;
end;

}


function TLoginService.Login(UserID, Password: string): string;
begin
  //uses
  // System.SysUtils,
  // XData.Sys.Exceptions,
  // Bcl.jose.Core.Builder,
  // Bcl.jose.Core.JWT;


  if UserID <> '' then
  begin
    var lToken := TJWT.Create;
    try
      //Add a claim to the token. In this case add the UserID
      lToken.Claims.SetClaimOfType<String>('UserID', UserID);

      //There are also some predefined claims that you can access
      //For example who and when is issuing the token and the expiration time
      lToken.Claims.Issuer := 'Archersoft Aps';
      lToken.Claims.IssuedAt := TDateTime.NowUTC;
      lToken.Claims.Expiration := TDateTime.NowUTC.IncDay(3); //and now the token will expire after 3 days


      lToken.Claims.SetClaimOfType<Boolean>('admin', Password = 'Admin');



      Result := TJOSE.SHA256CompactToken('ArcheryIsAVeryCoolSportAndILoveIt', lToken);
    finally
      lToken.Free;
    end;
  end
  else
  begin
    raise EXDataHttpUnauthorized.Create(format('User %s is not authorised',[UserID]));
  end;
end;



initialization
  RegisterServiceType(TLoginService);

end.
