import 'package:tranquil_loc/shared/enums/share_duration_period.dart';
import 'package:tranquil_loc/shared/enums/share_permission.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

class Share {
  String id;
  String description;
  String email;
  int durationNum;
  ShareDurationPeriod durationPeriod;
  SharePermission warrantorPermission;
  SharePermission occupantPermission;
  DateTime createdAt;

  Share({
    required this.id,
    required this.description,
    required this.email,
    required this.durationNum,
    required this.durationPeriod,
    required this.warrantorPermission,
    required this.occupantPermission,
    required this.createdAt,
  });

  static Share get empty {
    return Share(
      id: "",
      description: "",
      durationNum: -1,
      durationPeriod: ShareDurationPeriod.DAY,
      email: "",
      occupantPermission: SharePermission.NONE,
      warrantorPermission: SharePermission.NONE,
      createdAt: DateTime.now(),
    );
  }

  String shareDurationToString(AppLocalizations locale) {
    switch (durationPeriod) {
      case ShareDurationPeriod.DAY:
        return locale.n_days(durationNum);
      case ShareDurationPeriod.WEEK:
        return locale.n_weeks(durationNum);
      case ShareDurationPeriod.MONTH:
        return locale.n_months(durationNum);
    }
  }

  factory Share.fromApi(Map<String, dynamic>? data) {
    return switch (data) {
      {
        "id": String id,
        "description": String description,
        "email": String email,
        "durationNum": int durationNum,
        "durationPeriod": String durationPeriod,
        "warrantorPermission": String warrantorPermission,
        "occupantPermission": String occupantPermission,
        "createdAt": String createdAt,
      } =>
        Share(
          id: id,
          description: description,
          email: email,
          durationNum: durationNum,
          durationPeriod: ShareDurationPeriod.values.byName(durationPeriod),
          warrantorPermission: SharePermission.values.byName(
            warrantorPermission,
          ),
          occupantPermission: SharePermission.values.byName(occupantPermission),
          createdAt: DateTime.parse(createdAt),
        ),
      _ => throw const FormatException("Failed to load Share"),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "email": email,
      "durationNum": durationNum,
      "durationPeriod": durationPeriod.str,
      "occupantPermission": occupantPermission.str,
      "warrantorPermission": warrantorPermission.str,
    };
  }
}
