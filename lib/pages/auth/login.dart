import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/components/text-field.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      hideNavbar: true,
      child: Center(
        child: ShadowContainer(
          constraints: BoxConstraints.loose(Size(500, double.infinity)),
          padding: EdgeInsets.all(48),
          radius: Radius.circular(10),
          child: Column(
            spacing: 32,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Connexion", style: h1),
                  Text("Heureux de vous revoir !", style: p1),
                ],
              ),
              CustomTextField(
                label: "Email",
                onSaved: (_) {
                  print("ici");
                },
                hint: "jean@dupont.com",
                isRequired: false,
                type: TextFieldType.text,
                helpLabel: "Pas encore de compte ?",
                onHelpTap: () {
                  print("cheh");
                },
              ),
              CustomTextField(
                label: "Mot de passe",
                onSaved: (_) {
                  print("ici");
                },
                hint: "●●●●●●●●",
                isRequired: false,
                type: TextFieldType.password,
                helpLabel: "Mot de passe oublié ?",
                onHelpTap: () {
                  print("cheh");
                },
              ),
              Center(
                child: CustomButton(
                  onPressed: () {
                    print("c'est parti!");
                  },
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  type: ButtonType.primary,
                  child: Text("C'est parti !"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
