import 'package:tranquil_loc/shared/enums/home_situation.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/models/file.dart';

class Person {
  String id;
  String firstname;
  String lastname;
  DateTime dateOfBirth;
  int income;
  ProSituation proSituation;
  HomeSituation homeSituation;
  String email;
  String phone;
  Map<String, List<File>> documents;

  Person({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.income,
    required this.proSituation,
    required this.homeSituation,
    required this.email,
    required this.phone,
    required this.documents,
  });

  bool get isCompleted {
    return (email.isNotEmpty &&
        phone.isNotEmpty &&
        documents.values.every((value) => value.isNotEmpty));
  }

  bool getInfoCompleted(String info) {
    switch (info) {
      case "hasIncomeFilled":
        return income != 0;
      case "hasPersonalInfoFilled":
        return firstname != "" && lastname != "";
      case "hasEmailFilled":
        return email != "";
      case "hasPhoneFilled":
        return phone != "";
      case "hasAllDocumentsFilled":
        return documents.values.every((value) => value.isNotEmpty);
      default:
        return false;
    }
  }

  // static Map<String, Object?> toFirestore(Warrantor warrantor) {
  //   return {
  //     "firstname": warrantor.firstname,
  //     "lastname": warrantor.lastname,
  //     "dateOfBirth": Timestamp.fromDate(warrantor.dateOfBirth),
  //     "income": warrantor.income,
  //     "proSituation": warrantor.proSituation.str,
  //     "homeSituation": warrantor.homeSituation.str,
  //     "email": warrantor.email,
  //     "phone": warrantor.phone,
  //     "documents": warrantor.documents.map(
  //       (key, values) => MapEntry(key, values.map((value) => value.url)),
  //     ),
  //   };
  // }
}
