import 'dart:convert';
import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/document/document.dart';
import 'package:http/http.dart' as http;

class DocumentApi {
  static Future<Document> get(String id) async {
    http.Response response = await http.get(
      Uri.parse("http://localhost:3000/documents/$id"),
      headers: await AuthApi.defaultHeaders,
    );
    if (response.isOK) {
      return Document.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }
}
