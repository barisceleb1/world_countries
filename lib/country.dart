class Country {
  late String countryCode;
  late String name;
  late dynamic capital;
  late String region;
  late int population;
  late String flag;
  late String language;

  Country.fromMap(Map<String, dynamic> countryMap) {
    countryCode = countryMap["alpha2Code"];
    name = countryMap["name"];
    capital = countryMap["capital"];
    region = countryMap["region"];
    population = countryMap["population"];
    flag = countryMap["flag"];
    language = countryMap["languages"][0]["name"];
  }
}
