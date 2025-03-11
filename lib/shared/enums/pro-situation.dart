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
  String get str {
    switch (this) {
      case ProSituation.cdd:
        return "cdd";
      case ProSituation.cdi:
        return "cdi";
      case ProSituation.retired:
        return "retired";
      case ProSituation.coopStudent:
        return "coopStudent";
      case ProSituation.unemployed:
        return "unemployed";
      case ProSituation.student:
        return "student";
      case ProSituation.official:
        return "official";
      case ProSituation.freelance:
        return "freelance";
      case ProSituation.none:
        return "none";
    }
  }

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
