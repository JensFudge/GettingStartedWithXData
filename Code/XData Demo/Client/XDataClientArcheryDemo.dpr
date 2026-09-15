program XDataClientArcheryDemo;

uses
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  ArcherService in '..\Common\ArcherService.pas',
  CountryService in '..\Common\CountryService.pas',
  HelloWorldService in '..\Common\HelloWorldService.pas',
  LoginService in '..\Common\LoginService.pas',
  uArcher in '..\Common\DomainClasses\uArcher.pas',
  uBowtype in '..\Common\DomainClasses\uBowtype.pas',
  uCountry in '..\Common\DomainClasses\uCountry.pas',
  uArcheryClient in 'uArcheryClient.pas',
  ufrmNewArcher in 'ufrmNewArcher.pas' {frmNewArcher},
  ufrmLogin in 'ufrmLogin.pas' {frmLogin};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmNewArcher, frmNewArcher);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
