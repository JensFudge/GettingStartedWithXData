unit uArcheryClient;

interface

uses
  XData.Client,
  Aurelius.types.Nullable,
  Sparkle.http.client,
  ArcherService,
  LoginService,
  uArcher,
  uBowtype;

Type
  TArcheryClient = class(TObject)
     private
       fClient : TXDataClient;
       fToken : string;
       procedure ClientHttpClientSendingRequest(ARequest : THttpRequest);
     public
       property Token: string read FToken;
       constructor Create(aBaseUrl : string);
       destructor Destroy; override;
       function GetArchers: TArchers;
       function NewArcher(aName : string; aBowtype : TBowType; aCountryAbbreviation : Nullable<string>) : TArcher;
       procedure Login(aUser, aPass : string);
  end;

implementation

{ TArcheryClient }

procedure TArcheryClient.ClientHttpClientSendingRequest(ARequest: THttpRequest);
begin
  if fToken <> '' then
    ARequest.Headers.SetValue('Authorization', 'Bearer ' + fToken);
end;

constructor TArcheryClient.Create(aBaseUrl : string);
begin
  fClient := TXDataClient.Create;
  fClient.Uri := aBaseUrl;
  fClient.HttpClient.OnSendingRequest :=  ClientHttpClientSendingRequest;
end;

destructor TArcheryClient.Destroy;
begin
  fClient.Free;
  inherited;
end;

function TArcheryClient.GetArchers: TArchers;
begin
  var lArcherService : IArcherService;
  lArcherService := fClient.Service<IArcherService>;
  Result := lArcherService.GetArchers;
end;


procedure TArcheryClient.Login(aUser, aPass: string);
begin
   var lLoginService : ILoginService;
   lLoginService := fClient.Service<ILoginService>;
   fToken := lLoginService.Login(aUser, aPass);



end;

function TArcheryClient.NewArcher(aName: string; aBowtype: TBowType;
  aCountryAbbreviation: Nullable<string>): TArcher;
begin
  var lArcherService : IArcherService;
  lArcherService := fClient.Service<IArcherService>;
  Result := lArcherService.NewArcher(aName, aBowType, aCountryAbbreviation);
end;

end.
