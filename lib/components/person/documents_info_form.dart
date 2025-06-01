import 'package:tranquil_loc/api/document_api.dart';
import 'package:tranquil_loc/components/file_input.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/shared/enums/document_type.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/file.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentsInfoForm extends StatefulWidget {
  final Map<DocumentType, List<File>> initialFiles;
  final Map<DocumentType, List<PlatformFile>> newDocuments;
  final Map<DocumentType, List<File>>? rmDocuments;

  const DocumentsInfoForm({
    super.key,
    required this.initialFiles,
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
                        label: entry.key.locale(locale),
                        initialFiles: widget.initialFiles[entry.key] ?? [],
                        files: entry.value,
                        onClick: (file) async {
                          final document = await DocumentApi.get(file.id);
                          launchUrl(Uri.parse(document.url));
                        },
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
