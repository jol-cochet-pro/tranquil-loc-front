import 'dart:convert';
import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/warrantor/create_warrantor.dart';
import 'package:tranquil_loc/shared/models/warrantor/warrantor.dart';
import 'package:http/http.dart' as http;

class WarrantorApi {
  static Future<Warrantor> add(CreateWarrantor warrantor) async {
    http.Response response = await http.post(
      Uri.parse("http://localhost/warrantors"),
      headers: await AuthApi.defaultHeaders,
      body: jsonEncode(warrantor),
    );
    if (response.isOK) {
      return Warrantor.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }

  static Future<Warrantor> update(String id, CreateWarrantor warrantor) async {
    http.Response response = await http.patch(
      Uri.parse("http://localhost/warrantors/$id"),
      headers: await AuthApi.defaultHeaders,
      body: jsonEncode(warrantor),
    );
    if (response.isOK) {
      return Warrantor.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }

  static Future<Warrantor> get(String id) async {
    http.Response response = await http.get(
      Uri.parse('http://localhost:3000/warrantors/$id'),
      headers: await AuthApi.defaultHeaders,
    );
    if (response.isOK) {
      return Warrantor.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
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
