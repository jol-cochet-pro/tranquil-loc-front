import 'dart:convert';
import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/occupant/create_occupant.dart';
import 'package:tranquil_loc/shared/models/occupant/occupant.dart';
import 'package:http/http.dart' as http;

class OccupantApi {
  static Future<Occupant> add(CreateOccupant occupant) async {
    http.Response response = await http.post(
      Uri.parse("http://localhost:3000/occupants"),
      headers: await AuthApi.defaultHeaders,
      body: jsonEncode(occupant),
    );
    if (response.isOK) {
      return Occupant.fromApi(jsonDecode(response.body));
    }
    throw ApiException.fromApi(jsonDecode(response.body));
  }

  static Future<Occupant> update(String id, CreateOccupant occupant) async {
    final headers = await AuthApi.defaultHeaders;
    http.Response response = await http.patch(
      Uri.parse("http://localhost:3000/occupants/$id"),
      headers: headers,
      body: jsonEncode(occupant),
    );
    if (!response.isOK) {
      throw ApiException.fromApi(jsonDecode(response.body));
    }
    final result = Occupant.fromApi(jsonDecode(response.body));
    for (final document in occupant.documents) {
      final documentId =
          result.documents
              .where((resdocument) => resdocument.name == document.name)
              .first
              .id; // TODO Make this better
      http.MultipartRequest request = http.MultipartRequest(
        'PUT',
        Uri.parse('http://localhost:3000/documents/$documentId/file'),
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
    return result;
  }

  static Future<Occupant> get(String id) async {
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
