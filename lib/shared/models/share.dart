import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/shared/enums/share_duration_period.dart';
import 'package:dossier_locataire/shared/enums/share_permission.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Share {
  String id;
  String description;
  String email;
  int durationNum;
  ShareDurationPeriod durationPeriod;
  SharePermission warrantorPermission;
  SharePermission occupantPermission;

  Share({
    required this.id,
    required this.description,
    required this.email,
    required this.durationNum,
    required this.durationPeriod,
    required this.warrantorPermission,
    required this.occupantPermission,
  });

  String shareDurationToString(AppLocalizations locale) {
    switch (durationPeriod) {
      case ShareDurationPeriod.day:
        return locale.n_days(durationNum);
      case ShareDurationPeriod.week:
        return locale.n_weeks(durationNum);
      case ShareDurationPeriod.month:
        return locale.n_months(durationNum);
    }
  }

  factory Share.fromFirestore(Map<String, dynamic>? data) {
    ShareDurationPeriod durationPeriod = ShareDurationPeriod.day;
    try {
      durationPeriod = ShareDurationPeriod.values.byName(
        data?["durationPeriod"],
      );
    } catch (_) {
      durationPeriod = ShareDurationPeriod.day;
    }
    SharePermission occupantPerm = SharePermission.none;
    try {
      occupantPerm = SharePermission.values.byName(data?["occupantPermission"]);
    } catch (_) {
      occupantPerm = SharePermission.none;
    }
    SharePermission warrantorPerm = SharePermission.none;
    try {
      warrantorPerm = SharePermission.values.byName(
        data?["warrantorPermission"],
      );
    } catch (_) {
      warrantorPerm = SharePermission.none;
    }
    return Share(
      id: data?["key"] ?? "",
      description: data?["description"] ?? "",
      email: data?["email"] ?? "",
      durationNum: data?["durationNum"] ?? 0,
      durationPeriod: durationPeriod,
      occupantPermission: occupantPerm,
      warrantorPermission: warrantorPerm,
    );
  }

  static Map<String, Object?> toFirestore(Share share) {
    return {
      "description": share.description,
      "email": share.email,
      "durationNum": share.durationNum,
      "durationPeriod": share.durationPeriod.str,
      "occupantPermission": share.occupantPermission.str,
      "warrantorPermission": share.warrantorPermission.str,
    };
  }
}
