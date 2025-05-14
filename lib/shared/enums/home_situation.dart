import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: constant_identifier_names
enum HomeSituation { TENANT, OWNER, OTHER }

extension HomeSituationExtension on HomeSituation {
  String get str {
    switch (this) {
      case HomeSituation.TENANT:
        return "TENANT";
      case HomeSituation.OWNER:
        return "OWNER";
      case HomeSituation.OTHER:
        return "OTHER";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case HomeSituation.TENANT:
        return locale.tenant;
      case HomeSituation.OWNER:
        return locale.owner;
      case HomeSituation.OTHER:
        return locale.other;
    }
  }
}
