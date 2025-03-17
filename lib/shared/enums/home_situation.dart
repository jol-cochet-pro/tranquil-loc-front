import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum HomeSituation { tenant, owner, other }

extension HomeSituationExtension on HomeSituation {
  String get str {
    switch (this) {
      case HomeSituation.tenant:
        return "tenant";
      case HomeSituation.owner:
        return "owner";
      case HomeSituation.other:
        return "other";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case HomeSituation.tenant:
        return locale.tenant;
      case HomeSituation.owner:
        return locale.owner;
      case HomeSituation.other:
        return locale.other;
    }
  }
}
