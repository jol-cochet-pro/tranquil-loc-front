import 'package:dossier_locataire/components/nav_button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/pages/warrantors/warrantors.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class Navbar extends StatefulWidget {
  static int selected = 0;
  static void setSelected(String location) {
    String path = "/${location.split('/')[1]}";
    switch (path) {
      case Warrantors.route:
        Navbar.selected = 2;
      case Occupants.route:
        Navbar.selected = 1;
      default:
        Navbar.selected = 0;
    }
  }

  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool profileOpen = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Tranquil'loc", style: h1),
        ShadowContainer(
          radius: Radius.circular(100),
          child: Row(
            spacing: 4,
            children: [
              NavButton(
                isSelected: Navbar.selected == 0,
                onPressed: () => context.go(Dashboard.route, extra: "occupant"),
                child: Text(locale.dashboard),
              ),
              NavButton(
                isSelected: Navbar.selected == 1,
                onPressed: () => context.go(Occupants.route),
                child: Text(locale.occupants),
              ),
              NavButton(
                isSelected: Navbar.selected == 2,
                onPressed: () => context.go(Warrantors.route),
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
                      Text(locale.my_account, style: p2),
                      Divider(height: 1, color: colorScheme.outline),
                      TextButton.icon(
                        label: Text(locale.my_profile, style: p3),
                        icon: Icon(Icons.person_outline, size: 16),
                        onPressed: () {
                          // TODO ADD THIS
                        },
                      ),
                      TextButton.icon(
                        label: Text(locale.settings, style: p3),
                        icon: Icon(Icons.settings_outlined, size: 16),
                        onPressed: () {
                          // TODO ADD THIS
                        },
                      ),
                      Divider(height: 1, color: colorScheme.outline),
                      TextButton.icon(
                        label: Text(locale.logout, style: p3),
                        icon: Icon(Icons.exit_to_app, size: 16),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            context.go(Login.route);
                          });
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
                      Text("Jolan Cochet", style: h4),
                      Text(locale.occupant, style: p3),
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
