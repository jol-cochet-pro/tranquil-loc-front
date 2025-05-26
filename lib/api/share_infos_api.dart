import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/shared_infos.dart';

class ShareInfosApi {
  static Future<SharedInfos> get(String token) async {
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    http.Response response = await http.get(
      Uri.parse("http://localhost:3000/shared-infos"),
      headers: headers,
    );
    if (response.isOK) {
      return SharedInfos.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }
}
