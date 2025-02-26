import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-card.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

enum ShareDurationPeriod { month, day, year }

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

  String shareDurationToString() {
    switch (durationPeriod) {
      case ShareDurationPeriod.day:
        return durationNum > 1 ? "$durationNum jours" : "$durationNum jour";
      case ShareDurationPeriod.month:
        return "$durationNum mois";
      case ShareDurationPeriod.year:
        return durationNum > 1 ? "$durationNum années" : "$durationNum année";
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
    return DashCard(
      title: "Mes partages",
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
                Text(shares[index].shareDurationToString(), style: p2),
                Text(shares[index].description, style: p2),
                IconButton(
                  onPressed: () {
                    print("id of the share ${shares[index].id}");
                  },
                  icon: Icon(Icons.settings_outlined),
                  style: ButtonStyle(
                    side: WidgetStatePropertyAll(
                      BorderSide(color: Color(0xFFF1F5F9)),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
