import 'package:country_info/model/countries.dart';
import 'package:country_info/network/network_request.dart';
import 'package:flutter/cupertino.dart';

class CountryListProvider extends ChangeNotifier {
  List<Countries> countriesList = [];

  fetchListOfCountries() {
    Future<List<Countries>> listOfCountry = NetworkRequest.getCountries();
    listOfCountry.then((countries) {
      countriesList = countries;
      notifyListeners();
    });
  }
}
