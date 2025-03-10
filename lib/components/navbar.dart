import 'package:dossier_locataire/components/nav-button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/pages/warrantors/warrantors.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  static int selected = 0;
  bool profileOpen = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(image: NetworkImage('https://fakeimg.pl/40/')),
        ShadowContainer(
          radius: Radius.circular(100),
          child: Row(
            spacing: 4,
            children: [
              NavButton(
                isSelected: selected == 0,
                onPressed: () {
                  setState(() {
                    selected = 0;
                  });
                  context.go(Dashboard.route);
                },
                child: Text(locale.dashboard),
              ),
              NavButton(
                isSelected: selected == 1,
                onPressed: () {
                  setState(() {
                    selected = 1;
                  });
                  context.go(Occupants.route);
                },
                child: Text(locale.occupants),
              ),
              NavButton(
                isSelected: selected == 2,
                onPressed: () {
                  setState(() {
                    selected = 2;
                  });
                  context.go(Warrantors.route);
                },
                child: Text(locale.warrantors),
              ),
            ],
          ),
        ),
        MenuBar(
          style: MenuStyle(
            shadowColor: WidgetStatePropertyAll<Color>(Colors.transparent),
            backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
          ),
          children: [
            SubmenuButton(
              style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
              ),
              alignmentOffset: Offset(8, 8),
              menuChildren: [
                Container(
                  width: 150,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(locale.my_account, style: p1),
                      Divider(height: 1, color: colorScheme.outline),
                      TextButton.icon(
                        label: Text(locale.my_profile, style: p2),
                        icon: Icon(Icons.person_outline, size: 16),
                        onPressed: () {
                          print("my profile");
                        },
                      ),
                      TextButton.icon(
                        label: Text(locale.settings, style: p2),
                        icon: Icon(Icons.settings_outlined, size: 16),
                        onPressed: () {
                          print("my profile");
                        },
                      ),
                      Divider(height: 1, color: colorScheme.outline),
                      TextButton.icon(
                        label: Text(locale.logout, style: p2),
                        icon: Icon(Icons.exit_to_app, size: 16),
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then(
                            (_) => context.go(Login.route),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
              child: Row(
                spacing: 8,
                children: [
                  Image(image: NetworkImage('https://fakeimg.pl/40/')),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jolan Cochet", style: h3),
                      Text(locale.occupant, style: p2),
                    ],
                  ),
                  Icon(
                    !profileOpen
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.black,
                  ),
                ],
              ),
              onClose: () => setState(() => profileOpen = false),
              onOpen: () => setState(() => profileOpen = true),
            ),
          ],
        ),
      ],
    );
  }
}
