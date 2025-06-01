import 'dart:convert';
import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/occupant.dart';
import 'package:http/http.dart' as http;

class OccupantApi {
  static Future<Occupant> add(Occupant occupant) async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.occupants.add(occupant).then((value) => value.id);
    return Occupant.empty;
  }

  static Future<Occupant> update(String id, Occupant occupant) async {
    // TODO FIREBASE REPLACEMENT
    // await Storage.occupant(id).set(occupant);
    return Occupant.empty;
  }

  static Future<Occupant?> get(String id) async {
    http.Response response = await http.get(
      Uri.parse('http://localhost:3000/occupants/$id'),
      headers: await AuthApi.defaultHeaders,
    );
    if (response.isOK) {
      return Occupant.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }

  static Future<List<Occupant>> getAll() async {
    http.Response response = await http.get(
      Uri.parse('http://localhost:3000/occupants'),
      headers: await AuthApi.defaultHeaders,
    );
    if (response.isOK) {
      return jsonDecode(
        response.body,
      ).map<Occupant>((data) => Occupant.fromApi(data)).toList();
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }
}
