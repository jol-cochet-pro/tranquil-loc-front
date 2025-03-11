import 'package:dossier_locataire/shared/enums/share-duration-period.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Share {
  final String id;
  final String description;
  final String email;
  final int durationNum;
  final ShareDurationPeriod durationPeriod;

  Share({
    required this.id,
    required this.description,
    required this.email,
    required this.durationNum,
    required this.durationPeriod,
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
}
