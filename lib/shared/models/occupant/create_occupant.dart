import 'package:tranquil_loc/shared/enums/home_situation.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/models/occupant/occupant.dart';
import 'package:tranquil_loc/shared/models/person/create_person.dart';

class CreateOccupant extends CreatePerson {
  CreateOccupant({
    required super.firstname,
    required super.lastname,
    required super.dateOfBirth,
    required super.income,
    required super.proSituation,
    required super.homeSituation,
    required super.email,
    required super.phone,
    required super.documents,
    required super.removedDocumentIds,
  });

  static CreateOccupant get empty {
    return CreateOccupant(
      firstname: "",
      lastname: "",
      dateOfBirth: DateTime.now(),
      income: 0,
      proSituation: ProSituation.OTHER,
      homeSituation: HomeSituation.TENANT,
      email: "",
      phone: "",
      documents: [],
      removedDocumentIds: [],
    );
  }

  factory CreateOccupant.fromOccupant(Occupant occupant) {
    return CreateOccupant(
      firstname: occupant.firstname,
      lastname: occupant.lastname,
      dateOfBirth: occupant.dateOfBirth,
      income: occupant.income,
      proSituation: occupant.proSituation,
      homeSituation: occupant.homeSituation,
      email: occupant.email,
      phone: occupant.phone,
      documents: [],
      removedDocumentIds: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "dateOfBirth": dateOfBirth.toIso8601String(),
      "income": income,
      "proSituation": proSituation.str,
      "homeSituation": homeSituation.str,
      "email": email,
      "phone": phone,
      "documents": documents,
      "removedDocumentIds": removedDocumentIds,
    };
  }
}
