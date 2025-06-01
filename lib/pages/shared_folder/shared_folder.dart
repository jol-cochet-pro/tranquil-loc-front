import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tranquil_loc/api/share_infos_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/components/person/person_info_card.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/auth/login/login.dart';
import 'package:tranquil_loc/pages/shared_folder/components/persons_infos.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/shared_infos.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;

class SharedFolder extends StatefulWidget {
  final String? token;

  const SharedFolder({super.key, this.token});

  static final route = "/shared-folder";

  @override
  State<SharedFolder> createState() => _SharedFolderState();
}

class _SharedFolderState extends State<SharedFolder> {
  late Future<SharedInfos> sharedInfos;

  @override
  void initState() {
    if (widget.token == null) {
      context.go(Login.route);
    }
    sharedInfos = ShareInfosApi.get(widget.token!).catchError((err) {
      if (err is ApiException) {
        switch (err.statusCode) {
          default:
            context.go(Login.route);
        }
      }
      return SharedInfos.empty;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return PageLayout(
      isScrollable: true,
      hideNavbar: true,
      child: ShadowContainer(
        padding: EdgeInsets.all(32),
        child: FutureBuilder(
          future: sharedInfos,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loader();
            }
            final user = snapshot.data!.user;
            final occupants = snapshot.data!.occupants;
            final warrantors = snapshot.data!.warrantors;
            return Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 48,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      "${locale.folder_of(user.firstname, user.lastname)} 👋",
                      style: h2,
                    ),
                    Text(locale.transmit_folder, style: p2),
                  ],
                ),
                ShadowContainer(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    spacing: 24,
                    children: [
                      PersonsInfos(persons: occupants),
                      SizedBox(
                        height: 400,
                        child: VerticalDivider(color: colorScheme.outline),
                      ),
                      PersonsInfos(persons: warrantors),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (MediaQuery.of(context).size.width > 1250)
                      Image(image: AssetImage("assets/file_bundle.png")),
                    Column(
                      spacing: 64,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 500,
                            maxHeight: 150,
                          ),
                          child: PersonInfoCard(
                            first: PersonInfo(
                              icon: Icons.email_outlined,
                              name: locale.email,
                              info: user.email,
                            ),
                            second: PersonInfo(
                              icon: Icons.phone_outlined,
                              name: locale.phone,
                              info: user.phone,
                            ),
                            title: locale.contact_details,
                            flex: 0,
                          ),
                        ),
                        CustomButton(
                          onPressed: () {
                            html.AnchorElement anchorElement =
                                html.AnchorElement(href: snapshot.data!.zipUrl);
                            anchorElement.download = snapshot.data!.zipUrl;
                            anchorElement.click();
                          },
                          type: ButtonType.primary,
                          padding: EdgeInsets.all(24),
                          child: Text(locale.download_complete_folder),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
