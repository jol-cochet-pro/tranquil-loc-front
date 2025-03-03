import 'package:dossier_locataire/components/icon-button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-card.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ShareDurationPeriod { day, week, month }

class Share {
  final String id;
  final String description;
  final String email;
  final int durationNum;
  final ShareDurationPeriod durationPeriod;

  Share({
    required this.id,
    required this.description,
    required this.email,
    required this.durationNum,
    required this.durationPeriod,
  });

  String shareDurationToString(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    switch (durationPeriod) {
      case ShareDurationPeriod.day:
        return locale.n_days(durationNum);
      case ShareDurationPeriod.week:
        return locale.n_weeks(durationNum);
      case ShareDurationPeriod.month:
        return locale.n_months(durationNum);
    }
  }
}

class SharesCard extends StatelessWidget {
  SharesCard({super.key});

  final List<Share> shares = [
    Share(
      id: "1",
      description: "Serge Cochet",
      email: "serge.cochet@gmail.com",
      durationNum: 3,
      durationPeriod: ShareDurationPeriod.day,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return DashCard(
      title: locale.my_shares,
      emptyInfo: locale.no_shares_saved,
      onAdd: () {
        print("add shares.");
      },
      items: shares,
      itemBuilder:
          (context, index) => ShadowContainer(
            radius: Radius.circular(10),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shares[index].description,
                  overflow: TextOverflow.ellipsis,
                  style: h3,
                ),
                Row(
                  spacing: 4,
                  children: [
                    Icon(Icons.hourglass_empty_outlined),
                    Text(
                      shares[index].shareDurationToString(context),
                      style: p2,
                    ),
                  ],
                ),
                Text(shares[index].description, style: p2),
                CustomIconButton(
                  onPressed: () {
                    print("id of the share ${shares[index].id}");
                  },
                  icon: Icons.settings_outlined,
                ),
              ],
            ),
          ),
    );
  }
}
