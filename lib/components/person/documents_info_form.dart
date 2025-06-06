import 'package:tranquil_loc/api/document_api.dart';
import 'package:tranquil_loc/components/file_input.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/shared/enums/document_type.dart';
import 'package:tranquil_loc/shared/enums/pro_situation.dart';
import 'package:tranquil_loc/shared/models/document/create_document.dart';
import 'package:tranquil_loc/shared/models/file.dart';
import 'package:tranquil_loc/shared/models/person/create_person.dart';
import 'package:tranquil_loc/shared/models/person/person.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentsInfoForm extends StatefulWidget {
  final Person oldPerson;
  final CreatePerson person;

  const DocumentsInfoForm({
    super.key,
    required this.oldPerson,
    required this.person,
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
              child: AnimatedBuilder(
                animation: widget.person,
                builder: (context, _) => Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  children:
                      widget.person.proSituation.documents.map((documentType) {
                        return CustomFileInput(
                          label: documentType.locale(locale),
                          initialFiles:
                              widget.oldPerson.documents
                                  .where(
                                    (document) => document.type == documentType,
                                  )
                                  .map(
                                    (document) => File(
                                      id: document.id,
                                      name: document.name,
                                    ),
                                  )
                                  .toList(),
                          files:
                              widget.person.documents
                                  .where(
                                    (document) => document.type == documentType,
                                  )
                                  .map((document) => document.file)
                                  .toList(),
                          onClick: (file) async {
                            try {
                              final document = await DocumentApi.get(file.id);
                              launchUrl(Uri.parse(document.url));
                            } catch (_) {
                              // TODO DO THIS
                            }
                          },
                          onAdd:
                              (files) => setState(
                                () => widget.person.documents.addAll(
                                  files.map(
                                    (file) => CreateDocument(
                                      type: documentType,
                                      name: file.name,
                                      file: file,
                                    ),
                                  ),
                                ),
                              ),
                          onRemove:
                              (file) => setState(
                                () => widget.person.documents.removeWhere(
                                  (document) => document.file.bytes == file.bytes,
                                ),
                              ),
                          onInitialRemove:
                              (file) => setState(() {
                                widget.person.removedDocumentIds.add(file.id);
                                widget.oldPerson.documents.removeWhere(
                                  (document) => document.id == file.id,
                                );
                              }),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
