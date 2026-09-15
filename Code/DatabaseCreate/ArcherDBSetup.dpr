program ArcherDBSetup;

uses
  Vcl.Forms,
  uMainDbSetup in 'uMainDbSetup.pas' {frmMainDBSetup},
  udmArcherDbSetup in 'udmArcherDbSetup.pas' {dmArcher: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainDBSetup, frmMainDBSetup);
  Application.CreateForm(TdmArcher, dmArcher);
  Application.Run;
end.
