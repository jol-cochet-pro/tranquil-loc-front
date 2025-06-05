import 'package:file_picker/file_picker.dart';
import 'package:tranquil_loc/shared/enums/document_type.dart';

class CreateDocument {
  DocumentType type;
  String name;
  PlatformFile file;

  CreateDocument({required this.type, required this.name, required this.file});

  Map<String, dynamic> toJson() {
    return {"type": type.str, "name": name};
  }
}
