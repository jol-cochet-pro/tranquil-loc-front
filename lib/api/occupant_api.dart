import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/models/storage.dart';

class OccupantApi {
  static Future<String> add(Occupant occupant) async {
    return await Storage.occupants.add(occupant).then((value) => value.id);
  }

  static Future<void> update(String id, Occupant occupant) async {
    await Storage.occupant(id).set(occupant);
  }

  static Future<Occupant?> get(String id) async {
    return await Storage.occupant(id).get().then((value) => value.data());
  }

  static Future<List<Occupant>> getAll() async {
    return await Storage.occupants.get().then(
      (value) => value.docs.map((doc) => doc.data()).toList(),
    );
  }
}
