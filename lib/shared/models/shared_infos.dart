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

  static SharedInfos get empty {
    return SharedInfos(
      user: UserContact(
        id: "",
        firstname: "",
        lastname: "",
        email: "",
        phone: "",
      ),
      occupants: [],
      warrantors: [],
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
      );
    } catch (err) {
      throw const FormatException("Failed to load SharedInfos");
    }
  }
}
