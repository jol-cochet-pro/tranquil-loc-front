import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/shared/enums/pro-situation.dart';

class Warrantor {
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final int income;
  final ProSituation proSituation;
  final String email;
  final String phone;
  final Map<String, List<String>> documents;

  Warrantor({
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

  factory Warrantor.fromFirestore(Map<String, dynamic>? data) {
    ProSituation situation = ProSituation.unemployed;
    try {
      situation = ProSituation.values.byName(data?["proSituation"]);
    } catch (_) {
      situation = ProSituation.unemployed;
    }
    Map<String, List<String>> documents = {};
    for (final entry in data?["documents"].entries) {
      documents[entry.key] =
          (entry.value as JSArray).toDart.map((el) => el.toString()).toList();
    }
    return Warrantor(
      firstname: data?["firstname"],
      lastname: data?["lastname"],
      dateOfBirth: data?["dateOfBirth"].toDate(),
      income: data?["income"],
      proSituation: situation,
      email: data?["email"],
      phone: data?["phone"],
      documents: documents,
    );
  }

  static Map<String, Object?> toFirestore(Warrantor warrantor) {
    return {
      "firstname": warrantor.firstname,
      "lastname": warrantor.lastname,
      "dateOfBirth": Timestamp.fromDate(warrantor.dateOfBirth),
      "income": warrantor.income,
      "proSituation": warrantor.proSituation.str,
      "email": warrantor.email,
      "phone": warrantor.phone,
      "documents": warrantor.documents,
    };
  }
}
