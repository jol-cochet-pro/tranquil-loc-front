import 'package:tranquil_loc/components/file_input.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/shared/enums/document_type.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/file.dart';
import 'package:tranquil_loc/shared/models/occupant.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

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
            children: [Text(locale.documents, style: h3)],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 24,
                runSpacing: 12,
                children:
                    widget.newDocuments.entries.map((entry) {
                      return CustomFileInput(
                        label: DocumentType.values
                            .byName(entry.key)
                            .locale(locale),
                        initialFiles:
                            widget.occupant.documents[entry.key] ?? [],
                        files: entry.value,
                        onDownload: (file) => file.download(),
                        onAdd:
                            (file) => setState(() => entry.value.addAll(file)),
                        onRemove:
                            (file) => setState(
                              () => entry.value.removeWhere(
                                (wfile) => wfile.bytes == file.bytes,
                              ),
                            ),
                        onInitialRemove:
                            (file) => setState(() {
                              widget.rmDocuments?.createAdd(entry.key, file);
                            }),
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
