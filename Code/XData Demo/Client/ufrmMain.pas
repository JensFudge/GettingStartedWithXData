unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uArcheryClient, Vcl.ComCtrls, uArcher;

type
  TfrmMain = class(TForm)
    btnGetArchers: TButton;
    lvArchers: TListView;
    btnNewArcher: TButton;
    btnLogin: TButton;
    edToken: TEdit;
    btnEditArcher: TButton;
    btnDeleteArcher: TButton;
    btnCountryArchers: TButton;
    lblCountryName: TLabel;
    edCountry: TEdit;
    mmoHistory: TMemo;
    BtnRefreshHistory: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGetArchersClick(Sender: TObject);
    procedure btnNewArcherClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnEditArcherClick(Sender: TObject);
    procedure btnDeleteArcherClick(Sender: TObject);
    procedure btnCountryArchersClick(Sender: TObject);
    procedure BtnRefreshHistoryClick(Sender: TObject);
  private
    { Private declarations }
    fClient : TArcheryClient;
    fArchers : TArchers;
    procedure RefreshArchers;
    procedure EditArcher;
    procedure DeleteArcher;
    procedure GetCountryAndArchers;
    procedure UpdateHistory;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uBowType, ufrmArcher, Bcl.Types.Nullable, ufrmLogin;

procedure TfrmMain.btnCountryArchersClick(Sender: TObject);
begin
  GetCountryAndArchers;
end;

procedure TfrmMain.GetCountryAndArchers;
begin
  var lCountryAndArchersDTO :=  fClient.GetCountryAndArchers(edCountry.Text);
  lvArchers.Clear;
  fArchers.free;
  fArchers := TArchers.Create;
  fArchers.Assign( lCountryAndArchersDTO.Archers);
  for var lArcher in fArchers do
  begin
    var lLItem := lvArchers.Items.Add;
    lLItem.Data := lArcher;
    lLItem.Caption :=  (GUIDToString(lArcher.ArcherID));
    lLItem.SubItems.Add(lArcher.ArcherName);
    lLItem.SubItems.Add(BowTypeToString(lArcher.BowType));
    lLItem.SubItems.Add(lArcher.CountryAbbreviation.ValueOrDefault);
    lLItem.SubItems.Add(lArcher.CountryName.ValueOrDefault);
  end;

  lblCountryName.Caption := lCountryAndArchersDTO.Country.CountryName;
  UpdateHistory;
end;

procedure TfrmMain.btnDeleteArcherClick(Sender: TObject);
begin
  DeleteArcher;
end;

procedure TfrmMain.DeleteArcher;
begin
  if lvArchers.Items.Count < 1 then
   begin
     showMessage('You must get the archers first');
     Exit;
   end;
   if lvArchers.ItemIndex < 0 then
   begin
     ShowMessage('You must choose an archer first');
     Exit;
   end;

   var lArcher := TArcher(lvArchers.Items[lvArchers.ItemIndex].Data);
   fClient.DeleteArcher(lArcher.ArcherID);
   RefreshArchers;
end;

procedure TfrmMain.btnEditArcherClick(Sender: TObject);
begin
  EditArcher;
end;

procedure TfrmMain.EditArcher;
begin
  if lvArchers.Items.Count < 1 then
   begin
     showMessage('You must get the archers first');
     Exit;
   end;
   if lvArchers.ItemIndex < 0 then
   begin
     ShowMessage('You must choose an archer first');
     Exit;
   end;

  var lArcherName : string;
  var lBowType : TBowType;
  var lCountryAbbreviation : Nullable<string>;

  var lArcher := TArcher(lvArchers.Items[lvArchers.ItemIndex].Data);
  lArcherName := lArcher.ArcherName;
  lBowType := lArcher.BowType;
  lCountryAbbreviation := lArcher.CountryAbbreviation;
  if frmArcher.EditArcher(lArcherName, lBowType, lCountryAbbreviation) then
  begin
    var lArcherDto := TUpdateArcherDTO.Create;
    try
       lArcherDto.ArcherName := lArcherName;
       lArcherDto.BowType := lBowType;
       lArcherDto.CountryAbbreviation := lCountryAbbreviation;
       var lModifiedArcher := fClient.UpdateArcher(lArcher.ArcherID, lArcherDto);
       RefreshArchers;
    finally
       lArcherDTO.Free;
    end;
  end;
  UpdateHistory;
end;

procedure TfrmMain.RefreshArchers;
begin
  lvArchers.Items.Clear;
  fArchers.Free;
  fArchers := nil;
  fArchers := fClient.GetArchers;
  for var lArcher in fArchers do
  begin
    var lLItem := lvArchers.Items.Add;
    lLItem.Data := lArcher;
    lLItem.Caption :=  (GUIDToString(lArcher.ArcherID));
    lLItem.SubItems.Add(lArcher.ArcherName);
    lLItem.SubItems.Add(BowTypeToString(lArcher.BowType));
    lLItem.SubItems.Add(lArcher.CountryAbbreviation.ValueOrDefault);
    lLItem.SubItems.Add(lArcher.CountryName.ValueOrDefault);
  end;
  UpdateHistory;
end;

procedure TfrmMain.btnGetArchersClick(Sender: TObject);
begin
  RefreshArchers;
end;

procedure TfrmMain.UpdateHistory;
begin
  mmoHistory.Lines.Assign(fClient.History);
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
  UpdateHistory;
end;

procedure TfrmMain.btnNewArcherClick(Sender: TObject);
begin
  var lArcherName : string;
  var lBowType : TBowType;
  var lCountryAbbreviation : Nullable<string>;
  if frmArcher.EditArcher(lArcherName, lBowType, lCountryAbbreviation) then
  begin
   try
   var lArcher : TArcher := fClient.NewArcher(lArcherName, lBowType, lCountryAbbreviation);
   // I am not actually going to use the lArcher
   // It's time to refresh from the server, as not to have stale data

   finally
     RefreshArchers;
   end;
  end;
end;

procedure TfrmMain.BtnRefreshHistoryClick(Sender: TObject);
begin
  UpdateHistory;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  fClient := TArcheryClient.Create('http://localhost:2001/tms/xdata');
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  fClient.Free;
  fArchers.Free;
end;


end.
