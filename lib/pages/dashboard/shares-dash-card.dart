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

  String shareDurationToString(int num, ShareDurationPeriod period) {
    switch (period) {
      case ShareDurationPeriod.day:
        return num > 1 ? "$num jours" : "$num jour";
      case ShareDurationPeriod.month:
        return "$num mois";
      case ShareDurationPeriod.year:
        return num > 1 ? "$num années" : "$num année";
    }
  }

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
                Text(
                  shareDurationToString(
                    shares[index].durationNum,
                    shares[index].durationPeriod,
                  ),
                  style: p2,
                ),
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
