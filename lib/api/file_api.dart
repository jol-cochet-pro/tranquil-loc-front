import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:analyzer_plugin/utilities/pair.dart';

class FileApi {
  static Future<List<String>> add(
    Pair<String, List<PlatformFile>> document,
  ) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    List<String> refs = [];
    for (final (index, file) in document.last.indexed) {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref("$userUid/${document.first}$index.${file.extension}")
          .putData(file.bytes!);
      refs.add(snapshot.ref.fullPath);
    }
    return refs;
  }

  static Future<void> remove(Pair<String, List<String>> document) async {
    for (final file in document.last) {
      await FirebaseStorage.instance.refFromURL(file).delete();
    }
  }
}
