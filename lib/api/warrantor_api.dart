import 'package:dossier_locataire/shared/models/warrantor.dart';
import 'package:dossier_locataire/shared/models/storage.dart';

class WarrantorApi {
  static Future<String> add(Warrantor warrantor) async {
    return await Storage.warrantors.add(warrantor).then((value) => value.id);
  }

  static Future<void> update(String id, Warrantor warrantor) async {
    await Storage.warrantor(id).set(warrantor);
  }

  static Future<Warrantor?> get(String id) async {
    return await Storage.warrantor(id).get().then((value) => value.data());
  }

  static Future<List<Warrantor>> getAll() async {
    return await Storage.warrantors.get().then(
      (value) => value.docs.map((doc) => doc.data()).toList(),
    );
  }
}
