unit uArcheryClient;

interface

uses
  XData.Client,
  ArcherService,
  uArcher;

Type
  TArcheryClient = class(TObject)
     private
       fClient : TXDataClient;
     public
       constructor Create(aBaseUrl : string);
       destructor Destroy; override;
       function GetArchers: TArchers;
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


end.
