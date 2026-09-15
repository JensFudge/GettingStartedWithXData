program XDataServerArcheryDemo;

uses
  Vcl.Forms,
  uServerContainer in 'uServerContainer.pas' {ServerContainer: TDataModule},
  ufrmMain in 'ufrmMain.pas' {MainForm},
  HelloWorldService in '..\Common\HelloWorldService.pas',
  HelloWorldServiceImplementation in 'HelloWorldServiceImplementation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
