import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/shared/enums/home_situation.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';

class Occupant {
  String firstname;
  String lastname;
  DateTime dateOfBirth;
  int income;
  ProSituation proSituation;
  HomeSituation homeSituation;
  String email;
  String phone;
  Map<String, List<String>> documents;

  Occupant({
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

  bool getIsCompleted() {
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

  factory Occupant.fromFirestore(Map<String, dynamic>? data) {
    ProSituation proSituation = ProSituation.unemployed;
    try {
      proSituation = ProSituation.values.byName(data?["proSituation"]);
    } catch (_) {
      proSituation = ProSituation.unemployed;
    }
    HomeSituation homeSituation = HomeSituation.tenant;
    try {
      homeSituation = HomeSituation.values.byName(data?["proSituation"]);
    } catch (_) {
      homeSituation = HomeSituation.tenant;
    }
    Map<String, List<String>> documents = {};
    for (final entry in data?["documents"].entries) {
      documents[entry.key] =
          (entry.value as JSArray).toDart.map((el) => el.toString()).toList();
    }
    return Occupant(
      firstname: data?["firstname"] ?? "",
      lastname: data?["lastname"] ?? "",
      dateOfBirth: data?["dateOfBirth"].toDate(),
      income: data?["income"] ?? 0,
      proSituation: proSituation,
      homeSituation: homeSituation,
      email: data?["email"] ?? "",
      phone: data?["phone"] ?? "",
      documents: documents,
    );
  }

  static Map<String, Object?> toFirestore(Occupant occupant) {
    return {
      "firstname": occupant.firstname,
      "lastname": occupant.lastname,
      "dateOfBirth": Timestamp.fromDate(occupant.dateOfBirth),
      "income": occupant.income,
      "proSituation": occupant.proSituation.str,
      "homeSituation": occupant.homeSituation.str,
      "email": occupant.email,
      "phone": occupant.phone,
      "documents": occupant.documents,
    };
  }
}
