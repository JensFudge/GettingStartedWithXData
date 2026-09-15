program XDataServerArcheryDemo;

uses
  Vcl.Forms,
  uServerContainer in 'uServerContainer.pas' {ServerContainer: TDataModule},
  ufrmMain in 'ufrmMain.pas' {MainForm},
  HelloWorldService in '..\Common\HelloWorldService.pas',
  HelloWorldServiceImplementation in 'HelloWorldServiceImplementation.pas',
  uCountry in '..\Common\DomainClasses\uCountry.pas',
  uArcher in '..\Common\DomainClasses\uArcher.pas',
  uBowtype in '..\Common\DomainClasses\uBowtype.pas',
  ArcherService in '..\Common\ArcherService.pas',
  ArcherServiceImplementation in 'ArcherServiceImplementation.pas',
  uDmDatabase in 'uDmDatabase.pas' {dmArcherySystem: TDataModule},
  uArcherDB in 'uArcherDB.pas',
  uCountryDB in 'uCountryDB.pas',
  CountryService in '..\Common\CountryService.pas',
  CountryServiceImplementation in 'CountryServiceImplementation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TdmArcherySystem, dmArcherySystem);
  Application.Run;
end.
