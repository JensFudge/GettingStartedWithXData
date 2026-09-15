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
    fdConArcherySystem: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetQuery : TFDQuery;
  end;

var
  dmArcherySystem: TdmArcherySystem;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmArcher }

function TdmArcherySystem.GetQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := self.fdConArcherySystem;
end;

end.
