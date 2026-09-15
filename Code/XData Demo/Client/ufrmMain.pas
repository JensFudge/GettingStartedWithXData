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
    btnNewArcher: TButton;
    btnLogin: TButton;
    edToken: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGetArchersClick(Sender: TObject);
    procedure btnNewArcherClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
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
  uBowType, ufrmNewArcher, aurelius.Types.Nullable, uArcher, ufrmLogin;

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

procedure TfrmMain.btnLoginClick(Sender: TObject);
begin
  var lUser : string;
  var lPass : string;
  if frmLogin.GetLogin(lUser, lPass) then
  begin
    fClient.Login(lUser, lPass);
    edToken.Text := fClient.Token;
  end;
end;

procedure TfrmMain.btnNewArcherClick(Sender: TObject);
begin
  var lArcherName : string;
  var lBowType : TBowType;
  var lCountryAbbreviation : Nullable<string>;
  if frmNewArcher.GetNewArcher(lArcherName, lBowType, lCountryAbbreviation) then
  begin
   var lArcher : TArcher := fClient.NewArcher(lArcherName, lBowType, lCountryAbbreviation);
   try
     var lLItem := lvArchers.Items.Add;
     lLItem.Caption :=  (GUIDToString(lArcher.ArcherID));
     lLItem.SubItems.Add(lArcher.ArcherName);
     lLItem.SubItems.Add(BowTypeToString(lArcher.BowType));
     lLItem.SubItems.Add(lArcher.CountryAbbreviation.ValueOrDefault);
     lLItem.SubItems.Add(lArcher.CountryName.ValueOrDefault);
   finally
     lArcher.Free;
   end;
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
