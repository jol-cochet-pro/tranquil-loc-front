import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final DateFormat formatter = DateFormat(
      'EEEE, dd MMMM yyyy',
      locale.localeName,
    );
    final String date = formatter.format(DateTime.now());
    return ShadowContainer(
      radius: Radius.circular(10),
      padding: EdgeInsets.all(12),
      child:
          AuthApi.user != null
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
                            locale.hey_username(AuthApi.user!.firstname),
                            style: h2,
                          ),
                          Text(locale.happy_to_see_you, style: p2),
                        ],
                      ),
                      Text("👋", style: h2),
                    ],
                  ),
                  Text(
                    date.replaceFirst(date[0], date[0].toUpperCase()),
                    style: p2,
                  ),
                ],
              )
              : Loader(),
    );
  }
}
