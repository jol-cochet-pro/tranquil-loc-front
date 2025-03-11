import 'package:dossier_locataire/shared/enums/pro-situation.dart';
import 'package:dossier_locataire/shared/models/document.dart';

class Occupant {
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final int income;
  final ProSituation proSituation;
  final String email;
  final String phone;
  final List<Document> documents;

  Occupant({
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.income,
    required this.proSituation,
    required this.email,
    required this.phone,
    required this.documents,
  });

  bool getIsCompleted() {
    return (email.isNotEmpty &&
        phone.isNotEmpty &&
        !documents.any((document) => document.url == null));
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
        return !documents.any((document) => document.url == null);
      default:
        return false;
    }
  }

  static Occupant fromSnapshot(Map<String, dynamic> data) {
    ProSituation situation = ProSituation.unemployed;
    try {
      situation = ProSituation.values.byName(data["proSituation"]);
    } catch (_) {
      situation = ProSituation.unemployed;
    }
    return Occupant(
      firstname: data["firstname"],
      lastname: data["lastname"],
      dateOfBirth: DateTime.fromMillisecondsSinceEpoch(
        (data["dateOfBirth"].seconds * 1000 +
                data["dateOfBirth"].nanoseconds / 1000)
            .round(),
      ),
      income: data["income"],
      proSituation: situation,
      email: data["email"],
      phone: data["phone"],
      documents: [],
    );
  }
}
