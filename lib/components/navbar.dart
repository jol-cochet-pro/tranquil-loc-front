import 'package:dossier_locataire/components/nav-button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selected = 0;
  bool profileOpen = false;

  @override
  Widget build(BuildContext context) {
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
                  print("dashboard");
                },
                child: Text("Dashboard"),
              ),
              NavButton(
                isSelected: selected == 1,
                onPressed: () {
                  setState(() {
                    selected = 1;
                  });
                  print("occupant");
                },
                child: Text("Occupant"),
              ),
              NavButton(
                isSelected: selected == 2,
                onPressed: () {
                  setState(() {
                    selected = 2;
                  });
                  print("warrantor");
                },
                child: Text("Garant"),
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
              menuStyle: MenuStyle(
                shadowColor: WidgetStatePropertyAll<Color>(Color(0x40AEAEAE)),
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
                      Text("Mon compte", style: p1),
                      Divider(height: 1, color: Color(0xFFF1F5F9)),
                      Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.person_outline, size: 16),
                          Text("Mon profile", style: p2),
                        ],
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.settings_outlined, size: 16),
                          Text("Paramètres", style: p2),
                        ],
                      ),
                      Divider(height: 1, color: Color(0xFFF1F5F9)),
                      Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.exit_to_app, size: 16),
                          Text("Deconnexion", style: p2),
                        ],
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
                      Text("Occupant", style: p2),
                    ],
                  ),
                  Icon(
                    !profileOpen
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                  ),
                ],
              ),
              onClose: () {
                setState(() {
                  profileOpen = false;
                });
              },
              onOpen: () {
                setState(() {
                  profileOpen = true;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
