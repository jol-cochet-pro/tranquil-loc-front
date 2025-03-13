import 'package:dossier_locataire/shared/enums/user-type.dart';

class RegisterUserCred {
  // TODO Remove this to User
  String email;
  String password;

  RegisterUserCred({required this.email, required this.password});
}

class RegisterUserInfo {
  String firstname;
  String lastname;
  String phone;
  DateTime dateOfBirth;
  UserType type;

  RegisterUserInfo({
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.dateOfBirth,
    required this.type,
  });
}
