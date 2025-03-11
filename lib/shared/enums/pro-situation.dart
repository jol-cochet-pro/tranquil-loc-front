import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ProSituation {
  cdd,
  cdi,
  retired,
  coopStudent,
  unemployed,
  student,
  official,
  freelance,
  none,
}

extension ProSituationExtension on ProSituation {
  String locale(AppLocalizations locale) {
    switch (this) {
      case ProSituation.cdd:
        return locale.cdd;
      case ProSituation.cdi:
        return locale.cdi;
      case ProSituation.retired:
        return locale.retired;
      case ProSituation.coopStudent:
        return locale.coopStudent;
      case ProSituation.unemployed:
        return locale.unemployed;
      case ProSituation.student:
        return locale.student;
      case ProSituation.official:
        return locale.official;
      case ProSituation.freelance:
        return locale.freelance;
      case ProSituation.none:
        return "";
    }
  }
}
