import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pubg_companion/models/weapon.dart';

class WeaponsApi {
  static Future<List<Weapon>> fetchWeapons(String family) async {
    final response = await http.get(
        'http://gsx2json.com/api?id=1KJ8vCdNnksEtZFY7vDgS4kAt7bAAq8ZTK7WMQ58hWh0&sheet=1&columns=false&q=$family');
    final responseJson = json.decode(response.body)['rows'];

    return weaponsList(responseJson);
  }

  static List<Weapon> weaponsList(responseBody) {
    final parsed = responseBody;

    return parsed.map<Weapon>((json) => new Weapon.fromJson(json)).toList();
  }
}
