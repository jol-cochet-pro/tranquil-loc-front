import 'package:tranquil_loc/shared/models/person.dart';

class Warrantor extends Person {
  Warrantor({
    required super.id,
    required super.firstname,
    required super.lastname,
    required super.dateOfBirth,
    required super.income,
    required super.proSituation,
    required super.homeSituation,
    required super.email,
    required super.phone,
    required super.documents,
  });

  static Warrantor get empty {
    return Person.empty as Warrantor;
  }

  factory Warrantor.fromApi(Map<String, dynamic> data) {
    return Person.fromApi(data) as Warrantor;
  }
}
