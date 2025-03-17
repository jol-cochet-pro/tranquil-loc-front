import 'package:dossier_locataire/components/file_input.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/models/occupant.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentsInfoForm extends StatefulWidget {
  final Map<String, List<PlatformFile>> files;
  final Occupant occupant;

  const DocumentsInfoForm({
    super.key,
    required this.files,
    required this.occupant,
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
                alignment: WrapAlignment.spaceAround,
                spacing: 24,
                clipBehavior: Clip.hardEdge,
                children:
                    widget.files.entries
                        .map(
                          (entry) => CustomFileInput(
                            label: entry.key,
                            files: entry.value,
                            onAdd:
                                (addFiles) => setState(
                                  () => widget.files.createAddAll(
                                    entry.key,
                                    addFiles,
                                  ),
                                ),
                            onRemove:
                                (removeFile) => setState(
                                  () => entry.value.removeWhere(
                                    (file) => file.bytes == removeFile.bytes,
                                  ),
                                ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
