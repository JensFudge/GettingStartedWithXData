unit uArcher;

interface

uses
  uBowType, Aurelius.Types.Nullable, system.Generics.Collections;

Type

  TArcher = class(TObject)
    private
    fCountryID: Nullable<TGUID>;
    fArcherName: string;
    fBowType: TBowType;
    fArcherID: TGUID;
    fCountryName: Nullable<String>;
    fCountryAbbreviation: Nullable<String>;
    public
    property ArcherID : TGUID read fArcherID write fArcherID;
    property ArcherName : string read fArcherName write fArcherName;
    property BowType : TBowType read fBowType write fBowType;
    property CountryID : Nullable<TGUID> read fCountryID write fCountryID;
    property CountryName : Nullable<String> read fCountryName write fCountryName;
    property CountryAbbreviation : Nullable<String> read fCountryAbbreviation write fCountryAbbreviation;

  end;

  TArchers = class(TObjectList<TArcher>)
  end;

  TUpdateArcherDTO = class(TObject)
    ArcherName : string;
    BowType : TBowType;
    CountryAbbreviation : Nullable<string>;
  end;

implementation

end.
