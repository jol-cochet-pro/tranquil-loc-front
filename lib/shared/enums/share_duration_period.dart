import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: constant_identifier_names
enum ShareDurationPeriod { DAY, WEEK, MONTH }

extension ShareDurationPeriodExtension on ShareDurationPeriod {
  String get str {
    switch (this) {
      case ShareDurationPeriod.DAY:
        return "day";
      case ShareDurationPeriod.WEEK:
        return "week";
      case ShareDurationPeriod.MONTH:
        return "month";
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
