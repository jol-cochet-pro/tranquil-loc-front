import 'package:dossier_locataire/shared/enums/share-duration-period.dart';

enum SharePermission { write, readFile, readInfo, none }

class ShareCreation {
  String description;
  String email;
  int durationNum;
  ShareDurationPeriod durationPeriod;
  SharePermission warrantorPermission;
  SharePermission occupantPermission;

  ShareCreation({
    required this.description,
    required this.email,
    required this.durationNum,
    required this.durationPeriod,
    required this.warrantorPermission,
    required this.occupantPermission,
  });
}
