import 'package:dossier_locataire/shared/enums/home_situation.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';
import 'package:dossier_locataire/shared/models/file.dart';

class Occupant {
  String id;
  String firstname;
  String lastname;
  int income;
  DateTime dateOfBirth;
  ProSituation proSituation;
  HomeSituation homeSituation;
  String email;
  String phone;
  Map<String, List<File>> documents;

  Occupant({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.income,
    required this.dateOfBirth,
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

  static Occupant get empty {
    return Occupant(
      id: "",
      firstname: "",
      lastname: "",
      income: 0,
      dateOfBirth: DateTime.now(),
      proSituation: ProSituation.OTHER,
      homeSituation: HomeSituation.TENANT,
      email: "",
      phone: "",
      documents: {},
    );
  }

  factory Occupant.fromApi(Map<String, dynamic> data) {
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
        Occupant(
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
    // Map<String, List<File>> documents = {};
    // for (final entry in data["documents"].entries) {
    //   List<String> refs =
    //       (entry.value as JSArray).toDart.map((el) => el.toString()).toList();
    //   documents[entry.key] =
    //       refs.map((ref) => File(name: ref.split('/').last, url: ref)).toList();
    // }
  }

  // static Map<String, Object?> toFirestore(Occupant occupant) {
  //   return {
  //     "firstname": occupant.firstname,
  //     "lastname": occupant.lastname,
  //     "dateOfBirth": Timestamp.fromDate(occupant.dateOfBirth),
  //     "income": occupant.income,
  //     "proSituation": occupant.proSituation.str,
  //     "homeSituation": occupant.homeSituation.str,
  //     "email": occupant.email,
  //     "phone": occupant.phone,
  //     "documents": occupant.documents.map(
  //       (key, values) => MapEntry(key, values.map((value) => value.url)),
  //     ),
  //   };
  // }
}
