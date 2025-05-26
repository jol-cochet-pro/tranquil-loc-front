import 'package:tranquil_loc/shared/models/occupant.dart';
import 'package:tranquil_loc/shared/models/user.dart';
import 'package:tranquil_loc/shared/models/warrantor.dart';

class SharedInfos {
  final UserContact user;
  final List<Occupant> occupants;
  final List<Warrantor> warrantors;

  const SharedInfos({
    required this.user,
    required this.occupants,
    required this.warrantors,
  });

  factory SharedInfos.fromApi(Map<String, dynamic> data) {
    return switch (data) {
      {
        "user": UserContact user,
        "occupants": List<Occupant> occupants,
        "warrantors": List<Warrantor> warrantors,
      } =>
        SharedInfos(user: user, occupants: occupants, warrantors: warrantors),
      _ => throw const FormatException("Failed to load SharedInfos"),
    };
  }
}
