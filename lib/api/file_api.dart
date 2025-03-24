import 'package:dossier_locataire/shared/models/file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:uuid/uuid.dart';

class FileApi {
  static Future<List<File>> add(
    Pair<String, List<PlatformFile>> document,
    String folder,
  ) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    Uuid uuid = Uuid();
    List<File> refs = [];
    for (final file in document.last) {
      String filename = "${document.first}-${uuid.v4()}.${file.extension}";
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

  static Future<void> remove(Pair<String, List<File>> document) async {
    for (final file in document.last) {
      await FirebaseStorage.instance.refFromURL(file.url).delete();
    }
  }
}
