import 'package:tranquil_loc/shared/enums/home_situation.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/models/person/create_person.dart';
import 'package:tranquil_loc/shared/models/warrantor/warrantor.dart';

class CreateWarrantor extends CreatePerson {
  CreateWarrantor({
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

  static CreateWarrantor get empty {
    return CreateWarrantor(
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

  factory CreateWarrantor.fromWarrantor(Warrantor warrantor) {
    return CreateWarrantor(
      firstname: warrantor.firstname,
      lastname: warrantor.lastname,
      dateOfBirth: warrantor.dateOfBirth,
      income: warrantor.income,
      proSituation: warrantor.proSituation,
      homeSituation: warrantor.homeSituation,
      email: warrantor.email,
      phone: warrantor.phone,
      documents: [],
      removedDocumentIds: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "dateOfBirth": dateOfBirth,
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
