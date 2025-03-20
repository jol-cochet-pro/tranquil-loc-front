import 'package:dossier_locataire/components/file_input.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/shared/enums/document_type.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/models/file.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentsInfoForm extends StatefulWidget {
  final Occupant occupant;
  final Map<String, List<PlatformFile>> newDocuments;
  final Map<String, List<File>>? rmDocuments;

  const DocumentsInfoForm({
    super.key,
    required this.occupant,
    required this.newDocuments,
    required this.rmDocuments,
  });

  @override
  State<DocumentsInfoForm> createState() => _DocumentsInfoFormState();
}

class _DocumentsInfoFormState extends State<DocumentsInfoForm> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return ShadowContainer(
      radius: Radius.circular(10),
      padding: EdgeInsets.all(20),
      child: Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text(locale.documents, style: h2)],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 24,
                clipBehavior: Clip.hardEdge,
                children:
                    widget.newDocuments.entries.map((entry) {
                      return CustomFileInput(
                        label: DocumentType.values
                            .byName(entry.key)
                            .locale(locale),
                        initialFiles:
                            widget.occupant.documents[entry.key] ?? [],
                        files: entry.value,
                        onAdd: (file) => entry.value.addAll(file),
                        onRemove:
                            (file) => entry.value.removeWhere(
                              (wfile) => wfile.name == file.name,
                            ),
                        onInitialRemove:
                            (file) =>
                                widget.rmDocuments?.createAdd(entry.key, file),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
