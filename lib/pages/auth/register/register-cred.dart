import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/components/text-field.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/auth/register/register-info.dart';
import 'package:dossier_locataire/shared/models/register-user.dart';
import 'package:dossier_locataire/shared/string-extensions.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:dossier_locataire/shared/types/form-errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class RegisterCred extends StatefulWidget {
  const RegisterCred({super.key});

  static const route = '/auth/register/credentials';

  @override
  State<RegisterCred> createState() => _RegisterCredState();
}

class _RegisterCredState extends State<RegisterCred> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegisterUserCred user = RegisterUserCred(email: "", password: "");
  final FormErrors errors = FormErrors();

  void submit(AppLocalizations locale) async {
    setState(() => errors.clear());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          )
          .then((userCred) => userCred.user?.sendEmailVerification());
      context.go(RegisterInfos.route);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'weak-password':
          setState(() => errors["password"] = locale.password_is_weak);
          break;
        case 'email-already-in-use':
          setState(() => errors["email"] = locale.email_already_used);
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
                    Text(locale.register, style: h1),
                    Text(locale.happy_to_welcome, style: p1),
                  ],
                ),
                CustomTextField(
                  label: locale.email,
                  onChanged: (newValue) => user.email = newValue!,
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
                  errorText: errors["email"],
                ),
                CustomTextField(
                  label: locale.password,
                  onChanged: (newValue) => user.password = newValue!,
                  validator: (value) {
                    if (value == null || value == "") {
                      return locale.cant_be_empty(locale.the_password);
                    }
                    if (!value.isStrongPassword()) {
                      return locale.password_is_weak;
                    }
                    return null;
                  },
                  hint: "●●●●●●●●",
                  isRequired: true,
                  type: TextFieldType.password,
                  errorText: errors["password"],
                ),
                CustomTextField(
                  label: locale.confirm_password,
                  validator: (value) {
                    if (value == null || value == "") {
                      return locale.cant_be_empty(locale.the_confirm_password);
                    }
                    if (value != user.password) {
                      return locale.confirm_password_must_match;
                    }
                    return null;
                  },
                  onChanged: (_) {},
                  hint: "●●●●●●●●",
                  isRequired: true,
                  type: TextFieldType.password,
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
                        child: Text(locale.lets_go),
                      ),
                      GestureDetector(
                        onTap: () => context.go(Login.route),
                        child: Text(
                          locale.already_has_account,
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
