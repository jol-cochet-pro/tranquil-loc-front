import 'package:cloud_functions/cloud_functions.dart';
import 'package:dossier_locataire/api/share_api.dart';
import 'package:dossier_locataire/components/icon_button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash_card.dart';
import 'package:dossier_locataire/shared/models/share.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SharesCard extends StatefulWidget {
  const SharesCard({super.key});

  @override
  State<SharesCard> createState() => _SharesCardState();
}

class _SharesCardState extends State<SharesCard> {
  late Future<List<Share>> shares;

  @override
  void initState() {
    shares = ShareApi.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return FutureBuilder(
      future: shares,
      builder:
          (context, snapshot) => DashCard(
            title: locale.my_shares,
            emptyInfo: locale.no_shares_saved,
            onAdd: () async {
              final result = await FirebaseFunctions.instance
                  .httpsCallable("send")
                  .call({"email": "jolan.cochet@yopmail.com"});
              print(result.data);
            },
            hasData: snapshot.hasData,
            items: snapshot.data,
            itemBuilder:
                (context, index) => ShadowContainer(
                  radius: Radius.circular(10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          snapshot.data![index].description,
                          overflow: TextOverflow.ellipsis,
                          style: h3,
                        ),
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.hourglass_empty_outlined),
                          Text(
                            snapshot.data![index].shareDurationToString(locale),
                            style: p2,
                          ),
                        ],
                      ),
                      Text(snapshot.data![index].email, style: p2),
                      CustomIconButton(
                        onPressed: () {
                          // TODO ADD THIS
                        },
                        icon: Icons.settings_outlined,
                      ),
                    ],
                  ),
                ),
          ),
    );
  }
}
