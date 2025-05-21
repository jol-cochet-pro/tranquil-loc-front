import 'dart:convert';
import 'dart:io';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/models/api_exception.dart';
import 'package:dossier_locataire/shared/models/credentials.dart';
import 'package:dossier_locataire/shared/models/user.dart';
import 'package:dossier_locataire/shared/models/user_jwt.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {

  static Future<Map<String, String>?> get defaultHeaders async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    if (token == null) {
      return null;  
    }
    return {
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
  }

  static Future<User> register(User user) async {
    http.Response response = await http.post(
      Uri.parse("http://localhost:3000/auth/register"),
      body: User.toApi(user),
      headers: await AuthApi.defaultHeaders,
    );
    
    if (response.isOK) {
      return User.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }

  static Future<void> preRegister(Credentials credentials) async {
    http.Response response = await http.post(
      Uri.parse("http://localhost:3000/auth/pre-register"),
      body: Credentials.toApi(credentials)
    );
    if (response.isOK) {
      final userJwt = UserJwt.fromApi(jsonDecode(response.body));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("accessToken", userJwt.accessToken);
      return ;
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }

  static Future<UserJwt> getMe() async {
    final headers = await AuthApi.defaultHeaders;
    if (headers == null) {
      throw Exception("headers not found");
    }
    http.Response response = await http.get(
      Uri.parse("http://localhost:3000/auth/me"),
      headers: await AuthApi.defaultHeaders
    );
    if (response.isOK) {
      return UserJwt.fromApi(jsonDecode(response.body));
    }
    throw Exception(response.body);
  }
}
