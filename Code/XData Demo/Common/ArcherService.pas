unit ArcherService;

interface

uses
  XData.Service.Common,
  XData.Security.Attributes,
  Aurelius.Types.Nullable,
  uArcher,
  uBowType;

type
  [ServiceContract]
  IArcherService = interface(IInvokable)
    ['{6DBA2655-A014-40BD-B685-04EBB9FCC2DE}']

    [HttpGet]
    function GetArcher(ID : TGUID) : TArcher;

    [HttpGet]
    function GetArchers : TArchers;

    [Authorize]
    [HttpPost]
    function NewArcher(ArcherName : string; BowType : TBowType; CountryAbbreviation : Nullable<string>) : TArcher;

    [Authorize]
    [HttpPut]
    function updateArcher(ArcherID : TGUID; ArcherValues : TUpdateArcherDTO) : TArcher;

    [Authorize]
    [HttpDelete]
    procedure DeleteArcher(ArcherID : TGUID);

  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IArcherService));

end.
