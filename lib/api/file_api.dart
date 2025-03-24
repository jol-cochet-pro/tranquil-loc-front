import 'package:dossier_locataire/shared/models/file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:analyzer_plugin/utilities/pair.dart';

class FileApi {
  static Future<List<File>> add(
    Pair<String, List<PlatformFile>> document,
    String folder,
    int startIndex,
  ) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    List<File> refs = [];
    for (final (index, file) in document.last.indexed) {
      String filename =
          "${document.first}${startIndex + index}.${file.extension}";
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref("$userUid/$folder/$filename")
          .putData(file.bytes!);
      String bucket = "gs://${FirebaseStorage.instance.bucket}";
      refs.add(
        File(
          name: snapshot.ref.fullPath.split('/').last,
          url: "$bucket/${snapshot.ref.fullPath}",
        ),
      );
    }
    return refs;
  }

  static Future<ListResult> getAll(String folder) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseStorage.instance.ref("$userUid/$folder").listAll();
  }

  static Future<void> remove(Pair<String, List<File>> document) async {
    for (final file in document.last) {
      await FirebaseStorage.instance.refFromURL(file.url).delete();
    }
  }
}
