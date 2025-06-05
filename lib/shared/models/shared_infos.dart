import 'package:tranquil_loc/shared/models/occupant/occupant.dart';
import 'package:tranquil_loc/shared/models/user.dart';
import 'package:tranquil_loc/shared/models/warrantor/warrantor.dart';

class SharedInfos {
  final UserContact user;
  final List<Occupant> occupants;
  final List<Warrantor> warrantors;
  final String zipUrl;

  const SharedInfos({
    required this.user,
    required this.occupants,
    required this.warrantors,
    required this.zipUrl,
  });

  static SharedInfos get empty {
    return SharedInfos(
      user: UserContact.empty,
      occupants: [],
      warrantors: [],
      zipUrl: "",
    );
  }

  factory SharedInfos.fromApi(Map<String, dynamic> data) {
    try {
      final user = UserContact.fromApi(data["user"]);
      final occupants =
          data["occupants"]
              .map<Occupant>((occupant) => Occupant.fromApi(occupant))
              .toList();
      final warrantors =
          data["warrantors"]
              .map<Warrantor>((warrantor) => Warrantor.fromApi(warrantor))
              .toList();
      return SharedInfos(
        user: user,
        occupants: occupants,
        warrantors: warrantors,
        zipUrl: data["zipUrl"],
      );
    } catch (err) {
      throw const FormatException("Failed to load SharedInfos");
    }
  }
}
