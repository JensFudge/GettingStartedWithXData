unit uCountryDB;

interface

uses
  uCountry, uDmDatabase;

Type

  TCountryDB = class(TObject)
    private
    public
    class function GetCountryFromDB(aCountryID : TGUID; aCountry : TCountry) : Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TCountryDB }

class function TCountryDB.GetCountryFromDB(aCountryID: TGUID;
  aCountry: TCountry): Boolean;
begin
  var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('SELECT COUNTRYID, COUNTRYNAME, COUNTRYABBREVIATION');
    lQry.SQL.Add('FROM');
    lQry.SQL.Add('WHERE');
    lQry.SQL.Add('COUNTRYID = :countryId');
    lQry.ParamByName('countryId').asString := GuidToString(aCountryID);
    lQry.Open;
    if not lQry.IsEmpty then
    begin
      aCountry.CountryName := lQry.FieldByName('COUNTRYNAME').AsString;
      aCountry.CountryAbbreviation := lQry.FieldByName('COUNTRYABBREVIATION').asString;
      aCountry.CountryID := aCountryID;
    end;
    Result := not lQry.IsEmpty;
    lQry.Close;
  finally
    lQry.Free;
  end;
end;

end.
