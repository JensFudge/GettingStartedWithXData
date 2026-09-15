unit ufrmArcher;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBowType, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls,
  Bcl.Types.Nullable;

type
  TfrmArcher = class(TForm)
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
    function EditArcher(var aName : string; var aBowType : TBowType;
                          var aCountryAbbreviation : Nullable<string>): boolean;
  end;

var
  frmArcher: TfrmArcher;

implementation

{$R *.dfm}

{ TfrmNewArcher }

function TfrmArcher.EditArcher(var aName : string; var aBowType : TBowType;
 var aCountryAbbreviation : Nullable<string>): boolean;
begin
  edArcherName.Text := aName;
  cbBowType.ItemIndex := ord(aBowType);
  if aCountryAbbreviation.HasValue then
    edCountryAbbreviation.Text := aCountryAbbreviation.Value
  else
    edCountryAbbreviation.Text := '';
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
