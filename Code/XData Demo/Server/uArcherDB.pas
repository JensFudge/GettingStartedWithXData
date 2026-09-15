unit uArcherDB;

interface

uses
  uArcher, uDmDatabase;

Type

  TArcherDB = class(TObject)
    private
    public
    class function GetArcherFromDB(aArcherID : TGUID; aArcher : TArcher) : Boolean;
    class procedure GetArchersFromDB(aArchers : TArchers) overload;
    class procedure GetArchersFromDB(aArchers : TArchers; aCountryID : TGUID); overload;

  end;

implementation

uses
  System.SysUtils,
  uBowType,
  FireDAC.Stan.Param,
  Data.DB
  ;

{ TArcherDB }

class function TArcherDB.GetArcherFromDB(aArcherID : TGUID; aArcher : TArcher) : Boolean;
begin
  var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('SELECT');
    lQry.SQL.Add('A.ARCHERID, A.ARCHERNAME, A.BOWTYPE, A.COUNTRYID,');
    lQry.SQL.Add('C.COUNTRYNAME,  C.COUNTRYABBREVIATION');
    lQry.SQL.Add('FROM');
    lQry.SQL.Add('ARCHER A');
    lQry.SQL.Add('LEFT JOIN COUNTRY C ON C.COUNTRYID = A.COUNTRYID');
    lQry.SQL.Add('WHERE');
    lQry.SQL.Add('A.ARCHERID = :archerId');
    lQry.ParamByName('archerId').AsString :=  GUidToString( aArcherID);
    lQry.Open;
    if not lQry.IsEmpty then
    begin
      aArcher.ArcherID := aArcherID;
      aArcher.ArcherName := lQry.FieldByName('ARCHERNAME').AsString;
      aArcher.BowType := TBowType(lQry.FieldByName('BOWTYPE').AsInteger);
      if not lQry.FieldByName('COUNTRYID').IsNull then
      begin
        aArcher.CountryID.Value := StringToGuid(lQry.FieldByName('COUNTRYID').asString);
        aArcher.CountryName.Value := lQry.FieldByName('COUNTRYNAME').asString;
        aArcher.CountryAbbreviation.Value := lQry.FieldByName('COUNTRYABBREVIATION').asString;
      end;
    end;
    Result := not lQry.IsEmpty;
    lQry.Close;
  finally
    lQry.Free;
  end;
end;

class procedure TArcherDB.GetArchersFromDB(aArchers: TArchers);
begin
   GetArchersFromDB(aArchers, TGuid.Empty);
end;

class procedure TArcherDB.GetArchersFromDB(aArchers: TArchers; aCountryID : TGuid);
begin
  var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('SELECT');
    lQry.SQL.Add('A.ARCHERID, A.ARCHERNAME, A.BOWTYPE, A.COUNTRYID,');
    lQry.SQL.Add('C.COUNTRYNAME,  C.COUNTRYABBREVIATION');
    lQry.SQL.Add('FROM');
    lQry.SQL.Add('ARCHER A');
    lQry.SQL.Add('LEFT JOIN COUNTRY C ON C.COUNTRYID = A.COUNTRYID');
    if not aCountryID.IsEmpty then
    begin
      lQry.SQL.Add('WHERE');
      lQry.SQL.Add('C.COUNTRYID = :countryID');
      lQry.ParamByName('countryID').asString := GuidToString(aCountryID);
    end;

    lQry.Open;
    while not lQry.eof  do
    begin
      var lArcher := TArcher.Create;
      lArcher.ArcherID := StringToGuid( lQry.FieldByName('ARCHERID').AsString);
      lArcher.ArcherName := lQry.FieldByName('ARCHERNAME').AsString;
      lArcher.BowType := TBowType(lQry.FieldByName('BOWTYPE').AsInteger);
      if not lQry.FieldByName('COUNTRYID').IsNull then
      begin
        lArcher.CountryID.Value := StringToGuid(lQry.FieldByName('COUNTRYID').asString);
        lArcher.CountryName.Value := lQry.FieldByName('COUNTRYNAME').asString;
        lArcher.CountryAbbreviation.Value := lQry.FieldByName('COUNTRYABBREVIATION').asString;
      end;
      aArchers.Add(lArcher);
      lQry.next;
    end;
  finally
    lQry.Free;
  end;
end;



end.
