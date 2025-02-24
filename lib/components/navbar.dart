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

  ButtonStyle navButtonStyle(int index) => TextButton.styleFrom(
    padding: EdgeInsets.all(10),
    backgroundColor:
        (selected == index)
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
    foregroundColor:
        (selected == index) ? Colors.white : Color.fromARGB(255, 1, 15, 29),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
    splashFactory: NoSplash.splashFactory,
    fixedSize: Size(120, 44),
  );

  TextButton navButton(int index, String text) => TextButton(
    style: navButtonStyle(index),
    onPressed: () {
      setState(() {
        selected = index;
      });
    },
    child: Text(text, style: h3),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(image: NetworkImage('https://fakeimg.pl/40/')),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                color: Color(0x40AEAEAE),
                blurRadius: 8,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            spacing: 4,
            children: [
              navButton(0, "Dashboard"),
              navButton(1, "Candidat"),
              navButton(2, "Garant"),
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
                      Text("Candidat", style: p2),
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
