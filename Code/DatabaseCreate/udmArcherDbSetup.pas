unit udmArcherDbSetup;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.IBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.IB, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Comp.Script;

type
  TdmArcher = class(TDataModule)
    fdArcherDB: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    fdArcherTables: TFDScript;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateDatabase(const aFilename : string; aScript : TStrings);

  end;

var
  dmArcher: TdmArcher;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmArcher }

procedure TdmArcher.CreateDatabase(const aFilename: string; aScript : TStrings);
begin
  fdArcherDB.Params.Clear;
  fdArcherDB.Params.Add('DriverID=IB');
  fdArcherDB.Params.Add(format('Database= %s', [aFilename]));
  fdArcherDB.Params.Add('User_Name=SYSDBA');
  fdArcherDB.Params.Add('Password=masterkey');
  fdArcherDB.Params.Add('OpenMode=Create');

  fdArcherDB.Connected := True;

  fdArcherTables.SQLScripts.Clear;
  fdArcherTables.SQLScripts.Add.SQL.Assign(aScript);
  fdArcherTables.ExecuteAll;

end;

end.
