unit uMainDbSetup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmMainDBSetup = class(TForm)
    btnCreateDatabase: TButton;
    sdDatabase: TFileSaveDialog;
    mmoCreate: TMemo;
    Label1: TLabel;
    procedure btnCreateDatabaseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainDBSetup: TfrmMainDBSetup;

implementation

uses
  udmArcherDbSetup;

{$R *.dfm}

procedure TfrmMainDBSetup.btnCreateDatabaseClick(Sender: TObject);
begin
  var lFileType := sdDatabase.FileTypes.Add;
  lFileType.DisplayName := 'Interbase files';
  lFileType.FileMask := '*.gdb';
  sdDatabase.DefaultExtension := 'gdb';
  sdDatabase.FileName := 'Archer';
  if sdDatabase.Execute then
  begin
    dmArcher.CreateDatabase(sdDatabase.FileName, mmoCreate.Lines);
  end;
end;

end.
