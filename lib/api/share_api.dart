import 'dart:convert';
import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:http/http.dart' as http;
import 'package:tranquil_loc/shared/models/share.dart';

class ShareApi {
  static Future<List<Share>> getAll() async {
    http.Response response = await http.get(
      Uri.parse('http://localhost:3000/shares'),
      headers: await AuthApi.defaultHeaders,
    );
    if (response.isOK) {
      return jsonDecode(
        response.body,
      ).map<Share>((data) => Share.fromApi(data)).toList();
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }

  static Future<Share> add(Share share) async {
    http.Response response = await http.post(
      Uri.parse('http://localhost:3000/shares'),
      headers: await AuthApi.defaultHeaders,
      body: jsonEncode(Share.toApi(share)),
    );
    if (response.isOK) {
      return Share.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }
}
