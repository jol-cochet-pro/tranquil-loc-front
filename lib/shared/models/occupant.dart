import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/shared/enums/pro-situation.dart';
import 'package:dossier_locataire/shared/models/document.dart';
import 'package:dossier_locataire/shared/models/firebase-data.dart';

abstract class Occupant implements FirebaseData {
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

  @override
  Occupant fromFirestore(Map<String, dynamic>? data) {
    ProSituation situation = ProSituation.unemployed;
    try {
      situation = ProSituation.values.byName(data?["proSituation"]);
    } catch (_) {
      situation = ProSituation.unemployed;
    }
    return Occupant(
      firstname: data?["firstname"],
      lastname: data?["lastname"],
      dateOfBirth: DateTime.fromMillisecondsSinceEpoch(
        (data?["dateOfBirth"].seconds * 1000 +
                data?["dateOfBirth"].nanoseconds / 1000)
            .round(),
      ),
      income: data?["income"],
      proSituation: situation,
      email: data?["email"],
      phone: data?["phone"],
      documents:
          data?["documents"]
              .map<Document>((document) => Document.fromFirestore(document))
              .toList(),
    );
  }

  @override
  Map<String, Object?> toFirestore(Occupant occupant) {
    return {
      "firstname": occupant.firstname,
      "lastname": occupant.lastname,
      "dateOfBirth": Timestamp.fromDate(occupant.dateOfBirth).toString(),
      "income": occupant.income,
      "proSituation": occupant.proSituation.str,
      "email": occupant.email,
      "phone": occupant.phone,
      "documents":
          occupant.documents
              .map((document) => Document.toFirestore(document))
              .toList(),
    };
  }
}
