unit ufrmNewArcher;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBowType, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls,
  Aurelius.Types.Nullable;

type
  TfrmNewArcher = class(TForm)
    edArcherName: TLabeledEdit;
    edCountryAbbreviation: TLabeledEdit;
    cbBowType: TComboBox;
    Label1: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetNewArcher(var aName : string; var aBowType : TBowType;
                          var aCountryAbbreviation : Nullable<string>): boolean;
  end;

var
  frmNewArcher: TfrmNewArcher;

implementation

{$R *.dfm}

{ TfrmNewArcher }

function TfrmNewArcher.GetNewArcher(var aName : string; var aBowType : TBowType;
 var aCountryAbbreviation : Nullable<string>): boolean;
begin
  self.ShowModal;
  if self.modalResult = mrOK then
  begin
     aName := edArcherName.Text;
     aBowType := TBowType(cbBowType.ItemIndex);
     if edCountryAbbreviation.Text <> '' then
       aCountryAbbreviation.Value := edCountryAbbreviation.Text;
     Result := true;
  end
  else
    Result := False;
end;

end.
