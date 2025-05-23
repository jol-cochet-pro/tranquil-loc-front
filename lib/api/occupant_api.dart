import 'dart:convert';
import 'package:dossier_locataire/api/auth_api.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/models/api_exception.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
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
    // TODO FIREBASE REPLACEMENT
    // return await Storage.occupant(id).get().then((value) => value.data());
    return Occupant.empty;
  }

  static Future<List<Occupant>> getAll() async {
    http.Response response = await http.get(
      Uri.parse('http://localhost:3000/occupants'),
      headers: await AuthApi.defaultHeaders,
    );
    if (response.isOK) {
      return jsonDecode(response.body).map((data) => Occupant.fromApi(data));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }
}
