import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/pages/auth/register/register_cred.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingCallToAction extends StatelessWidget {
  const LandingCallToAction({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      radius: Radius.circular(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Gagnez du temps, simplifiez vos démarches.", style: h2),
              Text(
                "Centralisez vos documents et partagez-les en un clic.",
                style: p1,
              ),
              CustomButton(
                onPressed: () => context.go(RegisterCred.route),
                type: ButtonType.primary,
                padding: EdgeInsets.all(16),
                child: Text("Inscription"),
              ),
            ],
          ),
          Image(image: AssetImage("assets/empty_list.png")),
        ],
      ),
    );
  }
}
