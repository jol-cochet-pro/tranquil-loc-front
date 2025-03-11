import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum UserType { warrantor, occupant, other }

extension SearchStateExtension on UserType {
  String get str {
    switch (this) {
      case UserType.occupant:
        return "occupant";
      case UserType.warrantor:
        return "warrantor";
      case UserType.other:
        return "other";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case UserType.occupant:
        return locale.occupant;
      case UserType.warrantor:
        return locale.warrantor;
      case UserType.other:
        return locale.other;
    }
  }
}
