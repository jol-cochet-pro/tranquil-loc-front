import 'package:dossier_locataire/shared/models/warrantor.dart';

class WarrantorApi {
  static Future<Warrantor> add(Warrantor warrantor) async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.warrantors.add(warrantor).then((value) => value.id);
    return Warrantor.empty;
  }

  static Future<Warrantor> update(String id, Warrantor warrantor) async {
    // TODO FIREBASE REPLACEMENT
    // await Storage.warrantor(id).set(warrantor);
    return Warrantor.empty;
  }

  static Future<Warrantor?> get(String id) async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.warrantor(id).get().then((value) => value.data());
    return Warrantor.empty;
  }

  static Future<List<Warrantor>> getAll() async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.warrantors.get().then(
    //   (value) => value.docs.map((doc) => doc.data()).toList(),
    // );
    return [];
  }
}
