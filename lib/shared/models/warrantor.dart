import 'package:tranquil_loc/shared/enums/home_situation.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
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
    return Warrantor(
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

  factory Warrantor.fromApi(Map<String, dynamic> data) {
    return switch (data) {
      {
        "id": String id,
        "firstname": String firstname,
        "lastname": String lastname,
        "email": String email,
        "homeSituation": String homeSituation,
        "proSituation": String proSituation,
        "income": int income,
        "dateOfBirth": String dateOfBirth,
        "phone": String phone,
      } =>
        Warrantor(
          id: id,
          firstname: firstname,
          lastname: lastname,
          income: income,
          dateOfBirth: DateTime.parse(dateOfBirth),
          proSituation: ProSituation.values.byName(proSituation),
          homeSituation: HomeSituation.values.byName(homeSituation),
          email: email,
          phone: phone,
          documents: {},
        ),
      _ => throw const FormatException("Failed to load Occupant"),
    };
  }
}
