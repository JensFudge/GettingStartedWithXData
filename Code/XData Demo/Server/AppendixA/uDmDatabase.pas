unit uDmDatabase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAc.DApt,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TdmArcherySystem = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure SetupManager;
  public
    { Public declarations }
    function GetQuery : TFDQuery;
  end;

var
  dmArcherySystem: TdmArcherySystem;

  {
  This implementation uses FireDAC connection pooling.

  XData also provides its own connection pooling mechanism. I have
  chosen the FireDAC approach for the example in Appendix A because
  this is the approach I have personally used in production.

  For information about the XData approach, see these discussions
  by Wagner Landgraf in the TMS Support Center:

  https://support.tmssoftware.com/t/getting-access-to-the-connection-pool-components/12927/2

  https://support.tmssoftware.com/t/get-tfdconnection-in-thread-from-a-connectionpool-thread-safety/20310
}

implementation

const
  ARCHERYSYSTEM_POOLED = 'ARCHERYSYSTEM_POOLED';

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmArcher }

procedure TdmArcherySystem.DataModuleCreate(Sender: TObject);
begin
    SetupManager;
end;

procedure TdmArcherySystem.DataModuleDestroy(Sender: TObject);
begin
  FDManager.CloseConnectionDef(ARCHERYSYSTEM_POOLED);
end;

function TdmArcherySystem.GetQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  var lConnection := TFDConnection.Create(Result);
  lConnection.ConnectionDefName := ARCHERYSYSTEM_POOLED;
  Result.Connection := lConnection;
end;

procedure TdmArcherySystem.SetupManager;
begin
  FDManager.Active := True;

  if FDManager.IsConnectionDef(ARCHERYSYSTEM_POOLED) then
    Exit;

  var lParams := TStringList.Create;
  try
    lParams.Add('Protocol=TCPIP');
    lParams.Add('Database=localhost:c:\Data\EKON\EKON 2026 (30)\GettingStartedWithXData_Private\ARCHERYSYSTEM.GDB');
    lParams.Add('User_Name=SYSDBA');
    lParams.Add('Password=masterkey');
    lParams.Add('DriverID=IB');
    lParams.Add('Pooled=True');
    FDManager.AddConnectionDef(ARCHERYSYSTEM_POOLED, 'IB', lParams);
  finally
    lParams.Free;
  end;

end;



end.
