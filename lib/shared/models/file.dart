import 'package:dossier_locataire/shared/enums/document_type.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class File {
  final String name;
  final String url;

  const File({required this.name, required this.url});

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

  Future<void> download() async {
    Reference ref = FirebaseStorage.instance.refFromURL(url);
    String dlUrl = await ref.getDownloadURL();
    launchUrl(Uri.parse(dlUrl));
  }
}
