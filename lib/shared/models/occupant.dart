import 'package:tranquil_loc/shared/models/person.dart';

class Occupant extends Person {
  Occupant({
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

  static Occupant get empty {
    return Person.empty as Occupant;
  }

  factory Occupant.fromApi(Map<String, dynamic> data) {
    return Person.fromApi(data) as Occupant;
  }
}
