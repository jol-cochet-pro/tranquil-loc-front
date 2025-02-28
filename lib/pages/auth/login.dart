import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      hideNavbar: true,
      child: ShadowContainer(
        padding: EdgeInsets.all(10),
        radius: Radius.circular(10),
        child: Column(
          children: [
            Row(children: [Text("Connexion", style: h1)]),
          ],
        ),
      ),
    );
  }
}
