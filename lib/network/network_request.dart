import 'dart:convert';

import 'package:country_info/model/countries.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static final String url = 'https://restcountries.eu/rest/v2/all';

  static Future<List<Countries>> getCountries() async {
    List<Countries> countries = [];
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<dynamic> data = result;
        data.forEach((map) => countries.add(Countries.fromMap(map)));
        return countries;
      } else {
        print('${response.statusCode} ${response.reasonPhrase} ');
      }
    } catch (e) {
      throw (e);
    }
    return countries;
  }
}
