import 'package:dossier_locataire/shared/models/share.dart';
import 'package:dossier_locataire/shared/models/storage.dart';

class ShareApi {
  static Future<List<Share>> getAll() async {
    return await Storage.shares.get().then(
      (value) => value.docs.map((doc) => doc.data()).toList(),
    );
  }

  static Future<void> add(Share share) async {
    await Storage.shares.add(share);
  }
}
