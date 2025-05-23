import 'dart:convert';

import 'package:dossier_locataire/api/auth_api.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/models/api_exception.dart';
import 'package:dossier_locataire/shared/models/warrantor.dart';
import 'package:http/http.dart' as http;

class WarrantorApi {
  static Future<Warrantor> add(Warrantor warrantor) async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.warrantors.add(warrantor).then((value) => value.id);
    return Warrantor.empty;
  }

  static Future<Warrantor> update(String id, Warrantor warrantor) async {
    // TODO FIREBASE REPLACEMENT
    // await Storage.warrantor(id).set(warrantor);
    return Warrantor.empty;
  }

  static Future<Warrantor?> get(String id) async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.warrantor(id).get().then((value) => value.data());
    return Warrantor.empty;
  }

  static Future<List<Warrantor>> getAll() async {
    http.Response response = await http.get(
      Uri.parse('http://localhost:3000/warrantors'),
      headers: await AuthApi.defaultHeaders,
    );
    if (response.isOK) {
      return jsonDecode(
        response.body,
      ).map<Warrantor>((data) => Warrantor.fromApi(data)).toList();
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }
}
