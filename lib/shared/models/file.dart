import 'package:tranquil_loc/shared/enums/document_type.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

class File {
  final String id;
  final String name;

  const File({required this.id, required this.name});

  String locale(AppLocalizations locale) {
    for (final value in DocumentType.values) {
      if (name.contains(value.str)) {
        return name
            .replaceFirst(value.str, value.locale(locale))
            .replaceFirst(RegExp(r'-[^\.]*'), '');
      }
    }
    return name;
  }
}
