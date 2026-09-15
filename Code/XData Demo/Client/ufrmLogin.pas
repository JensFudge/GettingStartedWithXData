unit ufrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmLogin = class(TForm)
    edUser: TLabeledEdit;
    edPass: TLabeledEdit;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetLogin(var aUser, aPass : string) : boolean;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

{ TfrmLogin }

function TfrmLogin.GetLogin(var aUser, aPass: string): boolean;
begin
  self.ShowModal;
  if self.modalResult = mrOK then
  begin
     aUser := edUser.Text;
     aPass := edPass.Text;
     Result := true;
  end
  else
    Result := false;
end;

end.
