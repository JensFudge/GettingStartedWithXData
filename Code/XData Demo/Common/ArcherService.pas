unit ArcherService;

interface

uses
  XData.Service.Common,
  uArcher;

type
  [ServiceContract]
  IArcherService = interface(IInvokable)
    ['{6DBA2655-A014-40BD-B685-04EBB9FCC2DE}']

    [HttpGet]
    function GetArcher(ID : TGUID) : TArcher;

    [HttpGet]
    function GetArchers : TArchers;

  end;

implementation

initialization
  RegisterServiceType(TypeInfo(IArcherService));

end.
