import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: constant_identifier_names
enum UserType { WARRANTOR, OCCUPANT, OTHER }

extension SearchStateExtension on UserType {
  String get str {
    switch (this) {
      case UserType.WARRANTOR:
        return "occupant";
      case UserType.OCCUPANT:
        return "warrantor";
      case UserType.OTHER:
        return "other";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case UserType.OCCUPANT:
        return locale.occupant;
      case UserType.WARRANTOR:
        return locale.warrantor;
      case UserType.OTHER:
        return locale.other;
    }
  }
}
