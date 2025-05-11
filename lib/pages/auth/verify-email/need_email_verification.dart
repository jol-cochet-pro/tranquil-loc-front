import 'dart:async';

import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class NeedEmailVerification extends StatefulWidget {
  const NeedEmailVerification({super.key});

  static const route = "/auth/need-email-verification";

  @override
  State<NeedEmailVerification> createState() => _NeedEmailVerificationState();
}

class _NeedEmailVerificationState extends State<NeedEmailVerification> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // TODO FIREBASE REPLACEMENT
    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
    //   await FirebaseAuth.instance.currentUser?.reload();
    //   if (FirebaseAuth.instance.currentUser != null) {
    //     SchedulerBinding.instance.addPostFrameCallback((_) {
    //       context.go(Dashboard.route);
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;

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
                  Text(locale.email_not_verified, style: h2),
                  Text(locale.your_email_needs_verif, style: p2),
                ],
              ),
              CustomButton(
                onPressed: () async {
                  // TODO FIREBASE REPLACEMENT
                  // await FirebaseAuth.instance.signOut();
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    context.go(Login.route);
                  });
                },
                padding: EdgeInsets.all(12),
                type: ButtonType.primary,
                child: Text(locale.go_to_login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
