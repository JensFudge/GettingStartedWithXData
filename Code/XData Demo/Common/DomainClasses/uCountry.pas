unit uCountry;

interface

Type
  TCountry = class(TObject)
    private
    fCountryID: TGUID;
    fCountryName: string;
    fCountryAbbreviation: string;
    public
    property CountryName : string read fCountryName write fCountryName;
    property CountryAbbreviation : string read fCountryAbbreviation write fCountryAbbreviation;
    property CountryID : TGUID read fCountryID write fCountryID;
  end;

implementation

end.
