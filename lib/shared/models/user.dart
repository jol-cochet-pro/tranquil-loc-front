import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/shared/enums/user-type.dart';

class User {
  String firstname;
  String lastname;
  String phone;
  DateTime dateOfBirth;
  UserType type;

  User({
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.dateOfBirth,
    required this.type,
  });

  factory User.fromFirebase(Map<String, dynamic>? data) {
    UserType type = UserType.other;
    try {
      type = UserType.values.byName(data?["type"]);
    } catch (_) {
      type = UserType.other;
    }
    return User(
      firstname: data?["firstname"] ?? "",
      lastname: data?["lastname"] ?? "",
      phone: data?["phone"],
      dateOfBirth: data?["dateOfBirth"].toDate(),
      type: type,
    );
  }

  static Map<String, dynamic> toFirebase(User user) {
    return {
      "firstname": user.firstname,
      "lastname": user.lastname,
      "phone": user.phone,
      "dateOfBirth": Timestamp.fromDate(user.dateOfBirth),
      "type": user.type.str,
    };
  }
}
