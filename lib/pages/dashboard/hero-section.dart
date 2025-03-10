import 'package:dossier_locataire/components/loader.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeroSection extends StatelessWidget {
  final AsyncSnapshot<DashboardData> snapshot;

  const HeroSection({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy');
    final String date = formatter.format(DateTime.now());
    return ShadowContainer(
      radius: Radius.circular(10),
      padding: EdgeInsets.all(12),
      child:
          snapshot.hasData
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.hey_username(snapshot.data!.firstname),
                            style: h1,
                          ),
                          Text(locale.happy_to_see_you, style: p1),
                        ],
                      ),
                      Text("👋", style: h1),
                    ],
                  ),
                  Text(
                    date.replaceFirst(date[0], date[0].toUpperCase()),
                    style: p1,
                  ),
                ],
              )
              : Loader(),
    );
  }
}
