import 'package:tranquil_loc/shared/enums/home_situation.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/models/document/create_document.dart';

class CreatePerson {
  String firstname;
  String lastname;
  String email;
  HomeSituation homeSituation;
  ProSituation proSituation;
  int income;
  DateTime dateOfBirth;
  String phone;
  List<CreateDocument> documents;
  List<String> removedDocumentIds;

  CreatePerson({
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.income,
    required this.proSituation,
    required this.homeSituation,
    required this.email,
    required this.phone,
    required this.documents,
    required this.removedDocumentIds,
  });
}
