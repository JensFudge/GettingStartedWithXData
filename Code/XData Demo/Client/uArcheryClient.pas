unit uArcheryClient;

interface

uses
  System.Classes,
  XData.Client,
  Bcl.types.Nullable,
  Sparkle.http.client,
  ArcherService,
  CountryService,
  LoginService,
  uArcher,
  uCountry,
  uBowtype;

Type
  TArcheryClient = class(TObject)
     private
       fClient : TXDataClient;
       fToken : string;
       fHistory : TStringList;
       procedure ClientHttpClientSendingRequest(ARequest : THttpRequest);
       procedure ClientHttpClientReceivingResponse(ARequest: THttpRequest; var AResponse: THttpResponse);
     public
       property Token: string read FToken;
       property History : TStringList read fHistory;
       constructor Create(aBaseUrl : string);
       destructor Destroy; override;
       function GetArchers: TArchers;
       function NewArcher(aName : string; aBowtype : TBowType; aCountryAbbreviation : Nullable<string>) : TArcher;
       function UpdateArcher(aArcherID : TGUID; aArcherValues : TUpdateArcherDTO) : TArcher;
       procedure DeleteArcher(aArcherID : TGUID);
       function GetCountryAndArchers(aCountryAbbreviation : string) : TCountryArchersDTO;
       procedure Login(aUser, aPass : string);
  end;

implementation

{ TArcheryClient }
uses
  System.SysUtils;

procedure TArcheryClient.ClientHttpClientSendingRequest(ARequest: THttpRequest);
begin
  if fToken <> '' then
    ARequest.Headers.SetValue('Authorization', 'Bearer ' + fToken);
end;


procedure TArcheryClient.ClientHttpClientReceivingResponse(ARequest: THttpRequest; var AResponse: THttpResponse);
begin
  var lLine : string;
  fHistory.Add(ARequest.Uri);
  lLine := DateTimeToStr(now) + ' - ' + ARequest.Method + ' - ' + IntToStr(AResponse.StatusCode) + ' ' + AResponse.StatusReason;
  fHistory.Add(lLine);
end;

constructor TArcheryClient.Create(aBaseUrl : string);
begin
  fClient := TXDataClient.Create;
  fClient.Uri := aBaseUrl;
  fClient.HttpClient.OnSendingRequest :=  ClientHttpClientSendingRequest;
  fHistory := TStringList.Create;
  fClient.HttpClient.OnResponseReceived := ClientHttpClientReceivingResponse;
end;

procedure TArcheryClient.DeleteArcher(aArcherID: TGUID);
begin
  var lArcherService : IArcherService;
  lArcherService := fClient.Service<IArcherService>;
  lArcherService.DeleteArcher(aArcherID);
end;

destructor TArcheryClient.Destroy;
begin
  fHistory.Free;
  fClient.Free;
  inherited;
end;

function TArcheryClient.GetArchers: TArchers;
begin
  var lArcherService : IArcherService;
  lArcherService := fClient.Service<IArcherService>;
  Result := lArcherService.GetArchers;
end;


function TArcheryClient.GetCountryAndArchers(
  aCountryAbbreviation: string): TCountryArchersDTO;
begin
  var lCountryService : ICountryService;
  lCountryService := fClient.Service<ICountryService>;
  Result := lCountryService.GetCountryAndArchers(aCountryAbbreviation);
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

function TArcheryClient.UpdateArcher(aArcherID: TGUID;
  aArcherValues: TUpdateArcherDTO): TArcher;
begin
  var lArcherService : IArcherService;
  lArcherService := fClient.Service<IArcherService>;
  Result := lArcherService.updateArcher(aArcherID, aArcherValues);
end;

end.
