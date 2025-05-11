import 'package:dossier_locataire/shared/models/share.dart';

class ShareApi {
  static Future<List<Share>> getAll() async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.shares.get().then(
    //   (value) => value.docs.map((doc) => doc.data()).toList(),
    // );
    return [];
  }

  static Future<Share> add(Share share) async {
    // TODO FIREBASE REPLACEMENT
    // await Storage.shares.add(share);
    return Share.empty;
  }
}
