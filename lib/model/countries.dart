class Countries {
  final String name;
  final String capital;
  final int population;
  final List<double> coordinate;
  final List<Currencies> currencies;
  final List<Language> languages;
  final String flag;
  final String region;
  final String subregion;

  Countries(
      {this.name,
      this.capital,
      this.population,
      this.coordinate,
      this.currencies,
      this.languages,
      this.flag,
      this.region,
      this.subregion});
  factory Countries.fromMap(Map<String, dynamic> map) {
    List<Currencies> currencyList = [];
    List<Language> languageList = [];
    List<double> coordinateList = [];
    map['latlng'].forEach((coordinate) => coordinateList.add(coordinate));
    map['currencies']
        .forEach((currency) => currencyList.add(Currencies.fromMap(currency)));
    map['languages']
        .forEach((lang) => languageList.add(Language.fromMap(lang)));
    return Countries(
        name: map['name'],
        capital: map['capital'],
        population: map['population'],
        region: map['region'],
        subregion: map['subregion'],
        coordinate: coordinateList,
        currencies: currencyList,
        languages: languageList,
        flag: map['flag']);
  }
}

class Currencies {
  final String name;
  final String symbol;
  Currencies({this.name, this.symbol});

  factory Currencies.fromMap(Map<String, dynamic> map) {
    return Currencies(name: map['name'], symbol: map['symbol']);
  }

  @override
  String toString() => 'Currencies(name: $name, symbol: $symbol)';
}

class Language {
  final String name;
  Language({
    this.name,
  });

  @override
  String toString() => 'Languages(name: $name)';

  factory Language.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Language(
      name: map['name'],
    );
  }
}
