import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

// ignore: constant_identifier_names
enum ShareDurationPeriod { DAY, WEEK, MONTH }

extension ShareDurationPeriodExtension on ShareDurationPeriod {
  String get str {
    switch (this) {
      case ShareDurationPeriod.DAY:
        return "DAY";
      case ShareDurationPeriod.WEEK:
        return "WEEK";
      case ShareDurationPeriod.MONTH:
        return "MONTH";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case ShareDurationPeriod.DAY:
        return locale.days;
      case ShareDurationPeriod.WEEK:
        return locale.weeks;
      case ShareDurationPeriod.MONTH:
        return locale.months;
    }
  }
}
