import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class VerifiyEmail extends StatefulWidget {
  final String? actionCode;

  const VerifiyEmail({super.key, this.actionCode});

  static const route = "/auth/verify-email";

  @override
  State<VerifiyEmail> createState() => _VerifiyEmailState();
}

class _VerifiyEmailState extends State<VerifiyEmail> {
  String whyError = "";

  Future<void> retrieveData(AppLocalizations locale) async {
    // TODO FIREBASE REPLACEMENT
    // try {
    //   if (widget.actionCode != null) {
    //     await FirebaseAuth.instance.applyActionCode(widget.actionCode!);
    //     await FirebaseAuth.instance.currentUser?.reload();
    //   } else {
    //     setState(() => whyError = locale.invalid_verif_code);
    //   }
    // } on FirebaseAuthException catch (error) {
    //   switch (error.code) {
    //     case 'expired-action-code':
    //       setState(() => whyError = locale.expired_verif_code);
    //     case 'invalid-action-code':
    //       setState(() => whyError = locale.invalid_verif_code);
    //     default:
    //       setState(() => whyError = locale.user_not_found);
    //   }
    // }
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
          child: FutureBuilder(
            future: retrieveData(locale),
            builder: (context, snapshot) {
              return Column(
                spacing: 32,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children:
                        whyError.isEmpty
                            ? [
                              Text(locale.email_verified, style: h2),
                              Text(
                                locale.your_email_has_been_verified,
                                style: p2,
                              ),
                            ]
                            : [
                              Text(locale.email_not_verified, style: h2),
                              Text(
                                locale.your_email_has_not_been_verify(whyError),
                                style: p2,
                              ),
                            ],
                  ),
                  CustomButton(
                    onPressed: () {
                      whyError.isEmpty
                          ? context.go(Dashboard.route)
                          : context.go(Login.route);
                    },
                    padding: EdgeInsets.all(12),
                    type: ButtonType.primary,
                    child: Text(
                      whyError.isEmpty
                          ? locale.go_to_dashboard
                          : locale.go_to_login,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
