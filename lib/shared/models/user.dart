import 'package:tranquil_loc/shared/enums/search_state.dart';
import 'package:tranquil_loc/shared/enums/user_type.dart';

class User {
  String id;
  String email;
  String password;
  String firstname;
  String lastname;
  String phone;
  DateTime dateOfBirth;
  int opennedEmail;
  SearchState searchState;
  UserType type;
  bool emailVerified;
  bool infosFilled;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.dateOfBirth,
    required this.opennedEmail,
    required this.searchState,
    required this.type,
    required this.infosFilled,
    required this.emailVerified,
  });

  static User get empty {
    return User(
      id: "",
      email: "",
      password: "",
      firstname: "",
      lastname: "",
      phone: "",
      dateOfBirth: DateTime.now(),
      opennedEmail: 0,
      searchState: SearchState.SEARCHING,
      type: UserType.OTHER,
      emailVerified: false,
      infosFilled: false,
    );
  }

  factory User.fromApi(Map<String, dynamic>? data) {
    return switch (data) {
      {
        "id": String id,
        "email": String email,
        "firstname": String firstname,
        "lastname": String lastname,
        "dateOfBirth": String dateOfBirth,
        "phone": String phone,
        "opennedEmail": int opennedEmail,
        "searchState": String searchState,
        "type": String type,
        "emailVerified": bool emailVerified,
        "infosFilled": bool infosFilled,
      } =>
        User(
          id: id,
          email: email,
          password: "",
          firstname: firstname,
          lastname: lastname,
          phone: phone,
          dateOfBirth: DateTime.parse(dateOfBirth),
          opennedEmail: opennedEmail,
          searchState: SearchState.values.byName(searchState),
          type: UserType.values.byName(type),
          emailVerified: emailVerified,
          infosFilled: infosFilled,
        ),
      _ => throw const FormatException("Failed to load User"),
    };
  }

  static Map<String, String> toApi(User user) {
    return {
      "firstname": user.firstname,
      "lastname": user.lastname,
      "phone": user.phone,
      "dateOfBirth": user.dateOfBirth.toIso8601String(),
      "opennedMail": user.opennedEmail.toString(),
      "searchState": user.type.str,
      "type": user.type.str,
    };
  }
}

class UserContact {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String phone;

  const UserContact({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
  });

  static UserContact get empty {
    return UserContact(
      id: '',
      firstname: '',
      lastname: '',
      email: '',
      phone: '',
    );
  }

  factory UserContact.fromApi(Map<String, dynamic> data) {
    return switch (data) {
      {
        "id": String id,
        "firstname": String firstname,
        "lastname": String lastname,
        "email": String email,
        "phone": String phone,
      } =>
        UserContact(
          id: id,
          firstname: firstname,
          lastname: lastname,
          email: email,
          phone: phone,
        ),
      _ => throw const FormatException("Failed to load UserContact"),
    };
  }
}
