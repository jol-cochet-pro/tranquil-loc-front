import 'package:dossier_locataire/shared/models/occupant.dart';

class OccupantApi {
  static Future<Occupant> add(Occupant occupant) async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.occupants.add(occupant).then((value) => value.id);
    return Occupant.empty;
  }

  static Future<Occupant> update(String id, Occupant occupant) async {
    // TODO FIREBASE REPLACEMENT
    // await Storage.occupant(id).set(occupant);
    return Occupant.empty;
  }

  static Future<Occupant?> get(String id) async {
    // TODO FIREBASE REPLACEMENT
    // return await Storage.occupant(id).get().then((value) => value.data());
    return Occupant.empty;
  }

  static Future<List<Occupant>> getAll() async {
    // TODO FIREBASE REPLACEMENT
    //   return await Storage.occupants.get().then(
    // (value) => value.docs.map((doc) => doc.data()).toList(),
    // );
    return [];
  }
}
