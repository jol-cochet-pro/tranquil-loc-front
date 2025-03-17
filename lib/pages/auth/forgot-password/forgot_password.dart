import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/components/text_field.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:dossier_locataire/shared/types/form_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ResetEmail {
  String email;

  ResetEmail({required this.email});
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static const route = "/auth/forgot-password";

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ResetEmail resetEmail = ResetEmail(email: "");
  final FormErrors errors = FormErrors();

  void submit(AppLocalizations locale) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: resetEmail.email,
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'auth/invalid-email':
          setState(
            () =>
                errors["email"] = locale.must_be_well_formatted(
                  locale.the_email,
                ),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return PageLayout(
      hideNavbar: true,
      child: Center(
        child: ShadowContainer(
          constraints: BoxConstraints.loose(Size(500, double.infinity)),
          padding: EdgeInsets.all(48),
          radius: Radius.circular(10),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 32,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(locale.mistake_happens, style: h1),
                    Text(locale.an_email_will_be_sent, style: p1),
                  ],
                ),
                CustomTextField(
                  label: locale.email,
                  validator: (value) {
                    if (value == null || value == "") {
                      return locale.cant_be_empty(locale.the_email);
                    }
                    if (!value.isEmail()) {
                      return locale.must_be_well_formatted(locale.the_email);
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) =>
                          setState(() => resetEmail.email = newValue!),
                  hint: locale.email_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                  errorText: errors["email"],
                ),
                Center(
                  child: Column(
                    spacing: 8,
                    children: [
                      CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            submit(locale);
                          }
                        },
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        type: ButtonType.primary,
                        child: Text(locale.send_mail),
                      ),
                      GestureDetector(
                        onTap: () => context.go(Login.route),
                        child: Text(
                          locale.i_remember,
                          style: TextStyle(color: colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
