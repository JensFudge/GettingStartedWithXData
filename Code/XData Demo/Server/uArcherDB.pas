unit uArcherDB;

interface

uses
  Bcl.Types.Nullable,
  uArcher, uDmDatabase, uBowType;

Type

  TArcherDB = class(TObject)
    private

    public
    class function GetArcherFromDB(aArcherID : TGUID; aArcher : TArcher) : Boolean;
    class procedure GetArchersFromDB(aArchers : TArchers) overload;
    class procedure GetArchersFromDB(aArchers : TArchers; aCountryID : TGUID); overload;

//    class function SaveArcherToDb(aArchername : string; aBowType : TBowType; aCountryID : Nullable<TGUID>) : TGUID;
    class function InsertArcherInDb(aArchername : string; aBowType : TBowType;  aCountryID : Nullable<TGUID>): TGUID;
    class function UpdateArcherInDb(aArcherID: TGUID;
      aArcherValues: TUpdateArcherDTO; aCountryID : Nullable<TGUID>): boolean;

    class function ArcherExists(aArcherID : TGUID) : boolean;

    class function DeleteArcher(aArcherID : TGUID) : boolean;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Stan.Param,
  Data.DB
  ;

{ TArcherDB }

class function TArcherDB.ArcherExists(aArcherID: TGUID): boolean;
begin
  var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('SELECT 1 ');
    lQry.SQL.Add('FROM');
    lQry.SQL.Add('ARCHER');
    lQry.SQL.Add('WHERE');
    lQry.SQL.Add('ARCHERID = :archerId');
    lQry.ParamByName('archerId').AsString := GuidToString(aArcherID);
    lQry.Open;
    Result := not(lQry.IsEmpty);
    lQry.Close;
  finally
    lQry.Free;
  end;
end;

class function TArcherDB.DeleteArcher(aArcherID: TGUID): boolean;
begin
  var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('DELETE FROM ARCHER');
    lQry.SQL.Add('WHERE');
    lQry.SQL.Add('ARCHERID = :archerId');
    lQry.ParamByName('archerId').AsString := GuidToString(aArcherID);
    lQry.ExecSQL;
    result := lQry.RowsAffected = 1;
  finally
    lQry.Free;
  end;
end;

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


class function TArcherDB.InsertArcherInDb(aArchername : string; aBowType : TBowType;  aCountryID : Nullable<TGUID>): TGUID;
begin
  Result := TGUID.NewGuid;
  var lQry := dmArcherySystem.GetQuery;
  try
    lQry.SQL.Add('INSERT INTO ARCHER');
    lQry.SQL.Add('(ARCHERID, ARCHERNAME, BOWTYPE, COUNTRYID)');
    lQry.SQL.Add('VALUES');
    lQry.SQL.Add('(:archerID, :archerName, :bowType, :countryID)');

    lQry.ParamByName('archerID').AsString := GUIDToString(Result);
    lQry.ParamByName('archerName').AsString := aArcherName;
    lQry.ParamByName('bowType').AsInteger := Ord(aBowType);

    if aCountryID.HasValue then
      lQry.ParamByName('countryID').AsString :=
        GUIDToString(aCountryID.Value)
    else
      lQry.ParamByName('countryID').Clear;
    lQry.ExecSQL;
  finally
    lQry.Free;
  end;
end;

class function TArcherDB.UpdateArcherInDb(aArcherID: TGUID;
  aArcherValues: TUpdateArcherDTO; aCountryID : Nullable<TGUID>): boolean;
begin
   Result := False;
   var lQry := dmArcherySystem.GetQuery;
   try
     lQry.SQL.Add('UPDATE ARCHER');
     lQry.SQL.Add('SET ARCHERNAME = :archername, ');
     lQry.SQL.Add('BOWTYPE = :bowType, ');
     lQry.ParamByName('archername').AsString := aArcherValues.ArcherName;
     lQry.ParamByName('bowtype').AsInteger := ord(aArcherValues.bowType);
     if aCountryID.HasValue then
     begin
       lQry.SQL.Add('COUNTRYID = :countryID');
       lQry.ParamByName('countryID').AsString := GUIDToString(aCountryID.Value);
     end
     else
     begin
       lQry.SQL.Add('COUNTRYID = NULL');
     end;
     lQry.SQL.Add('WHERE');
     lQry.SQL.Add('ARCHERID = :archerId');
     lQry.ParamByName('archerId').AsString := GUIDToString(aArcherID);
     lQry.ExecSQL;
     Result := lQry.RowsAffected = 1;
   finally
     lQry.Free;
   end;
end;


{
class function TArcherDB.SaveArcherToDb(aArchername : string; aBowType : TBowType;  aCountryID : Nullable<TGUID>): TGUID;
begin
  //SaveArcherToDb can either update an existing archer or create a new one
  Result := TGuid.Empty;

  var lQry := dmArcherySystem.GetQuery;
  try

    lQry.SQL.Add('SELECT ARCHERID, ARCHERNAME, BOWTYPE, COUNTRYID');
    lQry.SQL.Add('FROM ARCHER');
    lQry.SQL.Add('WHERE');
    lQry.SQL.Add('ARCHERID = :archerId');
    lQry.ParamByName('archerId').AsString := GUIDToString(aArcher.ArcherID);
    lQry.Open;
    if lQry.IsEmpty then
    begin
      lQry.Insert;
      lQry.FieldByName('ARCHERID').asString := GUIDToString(TGUID.NewGuid);
    end
    else
    begin
      lQry.Edit;
    end;
    lQry.FieldByName('ARCHERNAME').asString := aArcher.ArcherName;
    lQry.FieldByName('BOWTYPE').AsInteger := ord(aArcher.BowType);
    if aArcher.CountryID.HasValue then
      lQry.FieldByName('COUNTRYID').AsString := GUIDToString(aArcher.CountryID.Value);
    lQry.post;
    Result := StringToGUID(lQry.FieldByName('ARCHERID').AsString);
  finally
    lQry.Free;
  end;

end;
}

end.
