unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uArcheryClient, Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    btnGetArchers: TButton;
    lvArchers: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGetArchersClick(Sender: TObject);
  private
    { Private declarations }
    fClient : TArcheryClient;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uBowType;

procedure TfrmMain.btnGetArchersClick(Sender: TObject);
begin
  lvArchers.Items.Clear;
  var lArchers := fClient.GetArchers;
  try
    for var lArcher in lArchers do
    begin
      var lLItem := lvArchers.Items.Add;
      lLItem.Caption :=  (GUIDToString(lArcher.ArcherID));
      lLItem.SubItems.Add(lArcher.ArcherName);
      lLItem.SubItems.Add(BowTypeToString(lArcher.BowType));
      lLItem.SubItems.Add(lArcher.CountryAbbreviation.ValueOrDefault);
      lLItem.SubItems.Add(lArcher.CountryName.ValueOrDefault);

    end;
  finally
    lArchers.Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  fClient := TArcheryClient.Create('http://localhost:2001/tms/xdata');
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  fClient.Free;
end;


end.
