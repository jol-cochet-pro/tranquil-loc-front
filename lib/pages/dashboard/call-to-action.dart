import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/icon-with-state.dart';
import 'package:dossier_locataire/components/loader.dart';
import 'package:dossier_locataire/pages/dashboard/components/action-card.dart';
import 'package:dossier_locataire/pages/dashboard/share-dialog.dart';
import 'package:dossier_locataire/shared/enums/search-state.dart';
import 'package:dossier_locataire/shared/models/dashboard-data.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CallToAction extends StatelessWidget {
  final AsyncSnapshot<DashboardData> snapshot;
  final void Function() reload;

  const CallToAction({super.key, required this.snapshot, required this.reload});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Row(
      spacing: 12,
      children: [
        ActionCard(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(locale.mail_openned_percentage, style: p1),
              Expanded(
                child:
                    snapshot.hasData
                        ? Row(
                          spacing: 24,
                          children: [
                            Icon(Icons.mark_email_read_outlined),
                            Text("${snapshot.data!.opennedMail}%", style: h2),
                          ],
                        )
                        : Loader(),
              ),
            ],
          ),
        ),
        if (MediaQuery.of(context).size.width > 1008)
          ActionCard(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  type: ButtonType.primary,
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => ShareDialog(),
                    );
                    reload();
                  },
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Text(locale.share_my_folder),
                ),
                CustomButton(
                  type: ButtonType.success,
                  onPressed: () {
                    print("Found flat.");
                  },
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Text(locale.found_appartement),
                ),
              ],
            ),
          ),
        ActionCard(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(locale.search_state, style: p1),
              Expanded(
                child:
                    snapshot.hasData
                        ? Row(
                          spacing: 24,
                          children:
                              snapshot.data!.searchState == SearchState.paused
                                  ? [
                                    IconWithState(state: IconState.pause),
                                    Text(locale.paused, style: h2),
                                  ]
                                  : [
                                    IconWithState(state: IconState.valid),
                                    Text(locale.searching, style: h2),
                                  ],
                        )
                        : Loader(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
