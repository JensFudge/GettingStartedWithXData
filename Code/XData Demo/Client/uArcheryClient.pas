unit uArcheryClient;

interface

uses
  XData.Client,
  Aurelius.types.Nullable,
  ArcherService,
  LoginService,
  uArcher,
  uBowtype;

Type
  TArcheryClient = class(TObject)
     private
       fClient : TXDataClient;
       fToken : string;
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

constructor TArcheryClient.Create(aBaseUrl : string);
begin
  fClient := TXDataClient.Create;
  fClient.Uri := aBaseUrl;
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
