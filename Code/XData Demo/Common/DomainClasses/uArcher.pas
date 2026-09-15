unit uArcher;

interface

uses
  uBowType, Aurelius.Types.Nullable;

Type

  TArcher = class(TObject)
    private
    fCountryID: Nullable<TGUID>;
    fArcherName: string;
    fBowType: TBowType;
    fArcherID: TGUID;
    public
    property ArcherID : TGUID read fArcherID write fArcherID;
    property ArcherName : string read fArcherName write fArcherName;
    property BowType : TBowType read fBowType write fBowType;
    property CountryID : Nullable<TGUID> read fCountryID write fCountryID;
  end;

implementation

end.
