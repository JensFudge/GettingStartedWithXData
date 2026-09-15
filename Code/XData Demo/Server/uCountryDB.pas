unit uCountryDB;

interface

uses
  uCountry, uDmDatabase,
  Aurelius.Types.Nullable;

Type

  TCountryDB = class(TObject)
    private
    public
    class function GetCountryFromDB(aCountryID : TGUID; aCountry : TCountry) : Boolean;  overload;
    class function GetCountryFromDB(aCountryAbbreviation : String; aCountry : TCountry) : Boolean;  overload;
    class function GetCountryIDFromDB(aCountryAbbreviation : string) : nullable<TGUID>;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Param,
  Data.DB;

{ TCountryDB }

class function TCountryDB.GetCountryFromDB(aCountryID: TGUID;
  aCountry: TCountry): Boolean;
begin
  var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('SELECT COUNTRYID, COUNTRYNAME, COUNTRYABBREVIATION');
    lQry.SQL.Add('FROM COUNTRY');
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

class function TCountryDB.GetCountryFromDB(aCountryAbbreviation: String;
  aCountry: TCountry): Boolean;
begin
   var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('SELECT COUNTRYID, COUNTRYNAME, COUNTRYABBREVIATION');
    lQry.SQL.Add('FROM COUNTRY');
    lQry.SQL.Add('WHERE');
    lQry.SQL.Add('COUNTRYABBREVIATION = :CountryAbbreviation');
    lQry.ParamByName('CountryAbbreviation').asString := aCountryAbbreviation;
    lQry.Open;
    if not lQry.IsEmpty then
    begin
      aCountry.CountryName := lQry.FieldByName('COUNTRYNAME').AsString;
      aCountry.CountryAbbreviation := lQry.FieldByName('COUNTRYABBREVIATION').asString;
      aCountry.CountryID := StringToGUID(lQry.FieldByName('COUNTRYID').asString);
    end;
    Result := not lQry.IsEmpty;
    lQry.Close;
  finally
    lQry.Free;
  end;
end;

class function TCountryDB.GetCountryIDFromDB(
  aCountryAbbreviation: string): nullable<TGUID>;
begin
  Result := SNull;
  var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('SELECT COUNTRYID');
    lQry.SQL.Add('FROM COUNTRY');
    lQry.SQL.Add('WHERE');
    lQry.SQL.Add('COUNTRYABBREVIATION = :CountryAbbreviation');
    lQry.ParamByName('CountryAbbreviation').asString := aCountryAbbreviation;
    lQry.Open;
    if not lQry.IsEmpty then
    begin
      Result := StringToGUID(lQry.FieldByName('COUNTRYID').asString);
    end;
    lQry.Close;
  finally
    lQry.Free;
  end;
end;

end.
