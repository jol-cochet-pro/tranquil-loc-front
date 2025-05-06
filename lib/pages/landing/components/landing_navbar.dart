import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/auth/register/register_cred.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingNavbar extends StatefulWidget {
  const LandingNavbar({super.key});

  @override
  _LandingNavbarState createState() => _LandingNavbarState();
}

class _LandingNavbarState extends State<LandingNavbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Tranquil'loc", style: h1),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            CustomButton(
              onPressed: () => context.go(Login.route),
              type: ButtonType.secondary,
              padding: EdgeInsets.all(16),
              child: Text("Connexion"),
            ),
            CustomButton(
              onPressed: () => context.go(RegisterCred.route),
              type: ButtonType.primary,
              padding: EdgeInsets.all(16),
              child: Text("Inscription"),
            ),
          ],
        ),
      ],
    );
  }
}
