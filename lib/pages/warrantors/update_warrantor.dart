import 'package:tranquil_loc/api/warrantor_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/components/person/documents_info_form.dart';
import 'package:tranquil_loc/components/person/personal_infos_form.dart';
import 'package:tranquil_loc/pages/warrantors/warrantors.dart';
import 'package:tranquil_loc/shared/models/warrantor/create_warrantor.dart';
import 'package:tranquil_loc/shared/models/warrantor/warrantor.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class UpdateWarrantor extends StatefulWidget {
  final String warrantorId;

  const UpdateWarrantor({super.key, required this.warrantorId});

  static const route = "/warrantors/update/:id";
  static String routeId(String id) => "/warrantors/update/$id";

  @override
  State<UpdateWarrantor> createState() => _UpdateWarrantorState();
}

class _UpdateWarrantorState extends State<UpdateWarrantor> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Future<CreateWarrantor> createWarrantor;
  late Warrantor warrantor;
  bool isLoading = false;

  Future<CreateWarrantor> _loadWarrantor() async {
    warrantor = await WarrantorApi.get(widget.warrantorId);
    return CreateWarrantor.fromWarrantor(warrantor);
  }

  @override
  void initState() {
    createWarrantor = _loadWarrantor();
    super.initState();
  }

  void submit(AppLocalizations locale) async {
    CreateWarrantor loadedWarrantor = await createWarrantor;
    try {
      setState(() => isLoading = true);
      await WarrantorApi.update(widget.warrantorId, loadedWarrantor);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(Warrantors.route);
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
                Text(locale.update_warrantor, style: h2),
                !isLoading
                    ? Row(
                      spacing: 8,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          onPressed: () => context.go(Warrantors.route),
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
              future: createWarrantor,
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
                                  oldPerson: warrantor,
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
