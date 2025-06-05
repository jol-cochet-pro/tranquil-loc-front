import 'package:flutter/material.dart';
import 'package:tranquil_loc/components/person/person_card.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:tranquil_loc/shared/models/person/person.dart';
import 'package:tranquil_loc/shared/scroll_controller.dart';
import 'package:tranquil_loc/shared/text_styles.dart';

class PersonsInfos extends StatefulWidget {
  final List<Person> persons;

  const PersonsInfos({super.key, required this.persons});

  @override
  State<PersonsInfos> createState() => _PersonsInfosState();
}

class _PersonsInfosState extends State<PersonsInfos> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: 200,
          maxHeight: 400,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text("${locale.future_occupants}:", style: h4w),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: DragScrollBehavior(),
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: widget.persons.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:
                      (context, index) => PersonCard(
                        person: widget.persons[index],
                        isSmall: true,
                      ),
                  separatorBuilder: (context, index) => SizedBox(width: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
