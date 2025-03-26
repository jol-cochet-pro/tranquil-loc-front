import 'package:dossier_locataire/shared/models/storage.dart';
import 'package:dossier_locataire/shared/models/user.dart';

class UserApi {
  static Future<void> update(String id, User user) async {
    await Storage.user(id).set(user);
  }

  static Future<User?> get(String id) async {
    return Storage.user(id).get().then((value) => value.data()!);
  }
}
