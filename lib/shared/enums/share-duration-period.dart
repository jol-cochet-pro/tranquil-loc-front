import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ShareDurationPeriod { day, week, month }

extension ShareDurationPeriodExtension on ShareDurationPeriod {
  String locale(AppLocalizations locale) {
    switch (this) {
      case ShareDurationPeriod.day:
        return locale.days;
      case ShareDurationPeriod.week:
        return locale.weeks;
      case ShareDurationPeriod.month:
        return locale.months;
    }
  }
}
