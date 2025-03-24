import 'package:dossier_locataire/shared/models/file.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomFileInput extends StatefulWidget {
  final String? label;
  final List<File> initialFiles;
  final List<PlatformFile> files;
  final void Function(List<PlatformFile>) onAdd;
  final void Function(File) onDownload;
  final void Function(PlatformFile) onRemove;
  final void Function(File) onInitialRemove;

  const CustomFileInput({
    super.key,
    this.label,
    required this.initialFiles,
    required this.files,
    required this.onDownload,
    required this.onAdd,
    required this.onRemove,
    required this.onInitialRemove,
  });

  @override
  State<CustomFileInput> createState() => _FileInputState();
}

class _FileInputState extends State<CustomFileInput> {
  final List<String> errors = [];
  final List<File> removed = [];
  Future<void> pickFiles(AppLocalizations locale) async {
    setState(() => errors.clear());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
    if (result == null) {
      return;
    }
    widget.onAdd(
      result.files.where((file) {
        if (!["pdf", "png", "jpg"].contains(file.extension)) {
          setState(() => errors.add(locale.must_has_extension));
          return false;
        }
        if (widget.files.any((wfile) => wfile.name == file.name)) {
          setState(() => errors.add(locale.already_exists(file.name)));
          return false;
        }
        return true;
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        if (widget.label != null) Text(widget.label!, style: p1),
        GestureDetector(
          onTap: () => pickFiles(locale),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: colorScheme.outline),
            ),
            child: Column(
              spacing: 8,
              children: [
                Icon(
                  Icons.upload_file_outlined,
                  size: 70,
                  color: colorScheme.outline,
                ),
                Text(
                  locale.upload_your_file_here,
                  style: TextStyle(color: colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
        Column(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.initialFiles
                .where(
                  (file) =>
                      !removed.map((file) => file.name).contains(file.name),
                )
                .map(
                  (file) => Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4,
                    children: [
                      GestureDetector(
                        onTap: () => widget.onDownload(file),
                        child: Text(
                          file.locale(locale),
                          style: TextStyle(
                            color: colorScheme.primary,
                            decoration: TextDecoration.underline,
                            decorationColor: colorScheme.primary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:
                            () => setState(() {
                              removed.add(file);
                              widget.onInitialRemove(file);
                            }),
                        child: Icon(
                          Icons.delete_outline,
                          size: 15,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
            ...widget.files.map(
              (file) => Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Text(file.name, style: TextStyle(color: colorScheme.primary)),
                  GestureDetector(
                    onTap: () => setState(() => widget.onRemove(file)),
                    child: Icon(
                      Icons.delete_outline,
                      size: 15,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children:
              errors
                  .map(
                    (error) =>
                        Text(error, style: TextStyle(color: colorScheme.error)),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
