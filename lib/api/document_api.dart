import 'dart:convert';
import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/document/create_document.dart';
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

  static Future<void> createFile(String id, CreateDocument document) async {
    final headers = await AuthApi.defaultHeaders;
    http.MultipartRequest request = http.MultipartRequest(
      'PUT',
      Uri.parse('http://localhost:3000/documents/$id/file'),
    );
    request.headers.addAll(headers!);
    http.MultipartFile file = http.MultipartFile.fromBytes(
      'file',
      document.file.bytes!,
      filename: document.name,
    );
    request.files.add(file);
    request.send().catchError(
      (err) => throw Exception("Failed to upload file"),
    );
  }
}
