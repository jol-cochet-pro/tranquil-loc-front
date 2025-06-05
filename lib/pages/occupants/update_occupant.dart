import 'package:tranquil_loc/api/occupant_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/components/person/documents_info_form.dart';
import 'package:tranquil_loc/components/person/personal_infos_form.dart';
import 'package:tranquil_loc/pages/occupants/occupants.dart';
import 'package:tranquil_loc/shared/models/occupant/create_occupant.dart';
import 'package:tranquil_loc/shared/models/occupant/occupant.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class UpdateOccupant extends StatefulWidget {
  final String occupantId;

  const UpdateOccupant({super.key, required this.occupantId});

  static const route = "/occupants/update/:id";
  static String routeId(String id) => "/occupants/update/$id";

  @override
  State<UpdateOccupant> createState() => _UpdateOccupantState();
}

class _UpdateOccupantState extends State<UpdateOccupant> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Future<CreateOccupant> createOccupant;
  late Occupant occupant;
  bool isLoading = false;

  Future<CreateOccupant> _loadOccupant() async {
    occupant = await OccupantApi.get(widget.occupantId);
    return CreateOccupant.fromOccupant(occupant);
  }

  @override
  void initState() {
    createOccupant = _loadOccupant();
    super.initState();
  }

  void submit(AppLocalizations locale) async {
    CreateOccupant loadedOccupant = await createOccupant;
    try {
      // setState(() => isLoading = true); TODO UNCOMMENT THIS
      await OccupantApi.update(widget.occupantId, loadedOccupant);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(Occupants.route);
      });
    } catch (error) {
      // TODO ADD THIS
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return PageLayout(
      child: Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadowContainer(
            radius: Radius.circular(10),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(locale.update_future_occupant, style: h2),
                !isLoading
                    ? Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          onPressed: () => context.go(Occupants.route),
                          type: ButtonType.secondary,
                          padding: EdgeInsets.all(16),
                          child: Text(locale.canceled),
                        ),
                        CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              submit(locale);
                            }
                          },
                          type: ButtonType.success,
                          padding: EdgeInsets.all(16),
                          child: Text(locale.save),
                        ),
                      ],
                    )
                    : Loader(showImediately: true),
              ],
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: createOccupant,
              builder: (context, snapshot) {
                return Form(
                  key: formKey,
                  child:
                      snapshot.hasData
                          ? Row(
                            spacing: 24,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: PersonalInfoForm(person: snapshot.data!),
                              ),
                              Expanded(
                                child: DocumentsInfoForm(
                                  oldPerson: occupant,
                                  person: snapshot.data!,
                                ),
                              ),
                            ],
                          )
                          : Loader(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
