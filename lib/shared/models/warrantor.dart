import 'dart:js_interop';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/shared/enums/home_situation.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';
import 'package:dossier_locataire/shared/models/file.dart';

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

  static Warrantor get defaultWarrantor {
    return Warrantor(
      id: "",
      firstname: "",
      lastname: "",
      dateOfBirth: DateTime.now(),
      income: 0,
      proSituation: ProSituation.other,
      homeSituation: HomeSituation.tenant,
      email: "",
      phone: "",
      documents: {},
    );
  }

  factory Warrantor.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic>? data = snapshot.data();
    if (data == null) return Warrantor.defaultWarrantor;
    ProSituation proSituation = ProSituation.unemployed;
    try {
      proSituation = ProSituation.values.byName(data["proSituation"]);
    } catch (_) {
      proSituation = ProSituation.unemployed;
    }
    HomeSituation homeSituation = HomeSituation.tenant;
    try {
      homeSituation = HomeSituation.values.byName(data["proSituation"]);
    } catch (_) {
      homeSituation = HomeSituation.tenant;
    }
    Map<String, List<File>> documents = {};
    for (final entry in data["documents"].entries) {
      List<String> refs =
          (entry.value as JSArray).toDart.map((el) => el.toString()).toList();
      documents[entry.key] =
          refs.map((ref) => File(name: ref.split('/').last, url: ref)).toList();
    }
    return Warrantor(
      id: snapshot.id,
      firstname: data["firstname"] ?? "",
      lastname: data["lastname"] ?? "",
      dateOfBirth: data["dateOfBirth"].toDate(),
      income: data["income"] ?? 0,
      proSituation: proSituation,
      homeSituation: homeSituation,
      email: data["email"] ?? "",
      phone: data["phone"] ?? "",
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
      "homeSituation": warrantor.homeSituation.str,
      "email": warrantor.email,
      "phone": warrantor.phone,
      "documents": warrantor.documents.map(
        (key, values) => MapEntry(key, values.map((value) => value.url)),
      ),
    };
  }
}
