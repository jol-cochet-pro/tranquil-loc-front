import 'package:dossier_locataire/shared/enums/home_situation.dart';
import 'package:dossier_locataire/shared/enums/pro_situation.dart';
import 'package:dossier_locataire/shared/models/file.dart';

class Occupant {
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

  Occupant({
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

  static Occupant get empty {
    return Occupant(
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
  // TODO FIREBASE REPLACEMENT
  // factory Occupant.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  // ) {
  //   Map<String, dynamic>? data = snapshot.data();
  //   if (data == null) return Occupant.defaultOccupant;
  //   ProSituation proSituation = ProSituation.unemployed;
  //   try {
  //     proSituation = ProSituation.values.byName(data["proSituation"]);
  //   } catch (_) {
  //     proSituation = ProSituation.unemployed;
  //   }
  //   HomeSituation homeSituation = HomeSituation.tenant;
  //   try {
  //     homeSituation = HomeSituation.values.byName(data["proSituation"]);
  //   } catch (_) {
  //     homeSituation = HomeSituation.tenant;
  //   }
  //   Map<String, List<File>> documents = {};
  //   for (final entry in data["documents"].entries) {
  //     List<String> refs =
  //         (entry.value as JSArray).toDart.map((el) => el.toString()).toList();
  //     documents[entry.key] =
  //         refs.map((ref) => File(name: ref.split('/').last, url: ref)).toList();
  //   }
  //   return Occupant(
  //     id: snapshot.id,
  //     firstname: data["firstname"] ?? "",
  //     lastname: data["lastname"] ?? "",
  //     dateOfBirth: data["dateOfBirth"].toDate(),
  //     income: data["income"] ?? 0,
  //     proSituation: proSituation,
  //     homeSituation: homeSituation,
  //     email: data["email"] ?? "",
  //     phone: data["phone"] ?? "",
  //     documents: documents,
  //   );
  // }

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
