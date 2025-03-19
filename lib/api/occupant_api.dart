import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/models/storage.dart';

class OccupantApi {
  static Future<void> add(Occupant occupant) async {
    await Storage.occupants.add(occupant);
  }

  static Future<void> update(String id, Occupant occupant) async {
    await Storage.occupant(id).set(occupant);
  }
}
