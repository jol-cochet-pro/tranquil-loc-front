import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/components/text-field.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/pages/auth/forgot-password/forgot-password.dart';
import 'package:dossier_locataire/pages/auth/register/register-cred.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:dossier_locataire/shared/types/form-errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginUser {
  String email;
  String password;

  LoginUser({required this.email, required this.password});
}

class Login extends StatefulWidget {
  const Login({super.key});

  static const route = "/auth/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoginUser user = LoginUser(email: "", password: "");
  final FormErrors errors = FormErrors();

  void submit(AppLocalizations locale) async {
    setState(() => errors.clear());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      context.go(Dashboard.route);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'user-disabled':
          setState(() => errors["email"] = locale.account_deactivated);
          break;
        case 'invalid-credential':
        case 'user-not-found':
          setState(() {
            errors["email"] = locale.invalid_email_or_password;
            errors["password"] = locale.invalid_email_or_password;
          });
          break;
        case 'invalid-email':
          setState(
            () => errors["email"] = locale.must_be_well_formatted(locale.email),
          );
          break;
      }
    }
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
                    Text(locale.login, style: h1),
                    Text(locale.happy_to_see_you, style: p1),
                  ],
                ),
                CustomTextField(
                  label: locale.email,
                  onChanged:
                      (newValue) => setState(() => user.email = newValue!),
                  validator: (value) {
                    if (value == null || value == "") {
                      return locale.cant_be_empty(locale.the_email);
                    }
                    if (!value.isEmail()) {
                      return locale.must_be_well_formatted(locale.the_email);
                    }
                    return null;
                  },
                  hint: locale.email_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                  helpLabel: locale.no_account,
                  onHelpTap: () => context.go(RegisterCred.route),
                  errorText: errors["email"],
                ),
                CustomTextField(
                  label: locale.password,
                  onChanged:
                      (newValue) => setState(() => user.password = newValue!),
                  validator: (value) {
                    if (value == null || value == "") {
                      return locale.cant_be_empty(locale.the_password);
                    }
                    return null;
                  },
                  hint: "●●●●●●●●",
                  isRequired: true,
                  type: TextFieldType.password,
                  helpLabel: locale.forgotten_password,
                  onHelpTap: () => context.go(ForgotPassword.route),
                  errorText: errors["password"],
                ),
                Center(
                  child: CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        submit(locale);
                      }
                    },
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    type: ButtonType.primary,
                    child: Text(locale.lets_go),
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
