import 'package:dossier_locataire/shared/enums/search_state.dart';
import 'package:dossier_locataire/shared/enums/user_type.dart';

class User {
  String firstname;
  String lastname;
  String phone;
  DateTime dateOfBirth;
  int opennedMail;
  SearchState searchState;
  UserType type;

  User({
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.dateOfBirth,
    required this.opennedMail,
    required this.searchState,
    required this.type,
  });

  static User get empty {
    return User(
      firstname: "",
      lastname: "",
      phone: "",
      dateOfBirth: DateTime.now(),
      opennedMail: 0,
      searchState: SearchState.searching,
      type: UserType.other,
    );
  }
  // TODO FIREBASE REPLACEMENT

  // factory User.fromFirestore(Map<String, dynamic>? data) {
  //   UserType type = UserType.other;
  //   try {
  //     type = UserType.values.byName(data?["type"]);
  //   } catch (_) {
  //     type = UserType.other;
  //   }
  //   SearchState searchState = SearchState.searching;
  //   try {
  //     searchState = SearchState.values.byName(data?["searchState"]);
  //   } catch (_) {
  //     searchState = SearchState.searching;
  //   }
  //   return User(
  //     firstname: data?["firstname"] ?? "",
  //     lastname: data?["lastname"] ?? "",
  //     phone: data?["phone"],
  //     dateOfBirth: data?["dateOfBirth"].toDate(),
  //     opennedMail: data?["opennedMail"],
  //     searchState: searchState,
  //     type: type,
  //   );
  // }

  // static Map<String, dynamic> toFirestore(User user) {
  //   return {
  //     "firstname": user.firstname,
  //     "lastname": user.lastname,
  //     "phone": user.phone,
  //     "dateOfBirth": Timestamp.fromDate(user.dateOfBirth),
  //     "opennedMail": user.opennedMail,
  //     "searchState": user.type.str,
  //     "type": user.type.str,
  //   };
  // }
}
