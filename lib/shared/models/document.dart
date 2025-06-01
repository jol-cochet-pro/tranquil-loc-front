import 'package:tranquil_loc/shared/enums/document_type.dart';

class Document {
  String id;
  DocumentType type;
  String name;
  String url;

  Document({
    required this.id,
    required this.type,
    required this.name,
    required this.url,
  });

  factory Document.fromApi(Map<String, dynamic> data) {
    return switch (data) {
      {
        "id": String id,
        "type": String type,
        "name": String name,
        "url": String url,
      } =>
        Document(
          id: id,
          type: DocumentType.values.byName(type),
          name: name,
          url: url,
        ),
      {"id": String id, "type": String type, "name": String name} => Document(
        id: id,
        type: DocumentType.values.byName(type),
        name: name,
        url: "",
      ),
      _ => throw const FormatException("Failed to load Document"),
    };
  }
}
