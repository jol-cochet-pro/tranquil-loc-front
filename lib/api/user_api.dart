import 'package:dossier_locataire/shared/models/user.dart';

class UserApi {
  static Future<User> update(String id, User user) async {
    // TODO FIREBASE REPLACEMENT
    // await Storage.user(id).set(user);

    return User.empty;
  }

  static Future<User?> get(String id) async {
    // TODO FIREBASE REPLACEMENT
    // return Storage.user(id).get().then((value) => value.data()!);
    return null;
  }
}
