import 'package:tranquil_loc/shared/enums/home_situation.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/models/file.dart';

class Warrantor {
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

  Warrantor({
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

  static Warrantor get empty {
    return Warrantor(
      id: "",
      firstname: "",
      lastname: "",
      dateOfBirth: DateTime.now(),
      income: 0,
      proSituation: ProSituation.OTHER,
      homeSituation: HomeSituation.TENANT,
      email: "",
      phone: "",
      documents: {},
    );
  }

  factory Warrantor.fromApi(Map<String, dynamic> data) {
    return switch (data) {
      {
        "id": String id,
        "firstname": String firstname,
        "lastname": String lastname,
        "email": String email,
        "homeSituation": String homeSituation,
        "proSituation": String proSituation,
        "income": int income,
        "dateOfBirth": String dateOfBirth,
        "phone": String phone,
      } =>
        Warrantor(
          id: id,
          firstname: firstname,
          lastname: lastname,
          income: income,
          dateOfBirth: DateTime.parse(dateOfBirth),
          proSituation: ProSituation.values.byName(proSituation),
          homeSituation: HomeSituation.values.byName(homeSituation),
          email: email,
          phone: phone,
          documents: {},
        ),
      _ => throw const FormatException("Failed to load Occupant"),
    };
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
