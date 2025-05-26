import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/icon_with_state.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/pages/dashboard/components/action_card.dart';
import 'package:tranquil_loc/pages/dashboard/share_dialog.dart';
import 'package:tranquil_loc/shared/enums/search_state.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

class CallToAction extends StatelessWidget {
  const CallToAction({super.key});

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
              Text(locale.mail_openned_percentage, style: p2),
              Expanded(
                child:
                    AuthApi.user != null
                        ? Row(
                          spacing: 24,
                          children: [
                            Icon(Icons.mark_email_read_outlined),
                            Text("${AuthApi.user!.opennedEmail}%", style: h3),
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
                  },
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Text(locale.share_my_folder),
                ),
                CustomButton(
                  type: ButtonType.success,
                  onPressed: () {
                    // TODO ADD THIS
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
              Text(locale.search_state, style: p2),
              Expanded(
                child:
                    AuthApi.user != null
                        ? Row(
                          spacing: 24,
                          children:
                              AuthApi.user!.searchState == SearchState.PAUSED
                                  ? [
                                    IconWithState(state: IconState.pause),
                                    Text(locale.paused, style: h3),
                                  ]
                                  : [
                                    IconWithState(state: IconState.valid),
                                    Text(locale.searching, style: h3),
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
