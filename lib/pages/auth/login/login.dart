import 'dart:io';

import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/components/text_field.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/auth/forgot-password/forgot_password.dart';
import 'package:tranquil_loc/pages/auth/register/register_cred.dart';
import 'package:tranquil_loc/pages/dashboard/dashboard.dart';
import 'package:tranquil_loc/shared/extensions.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/credentials.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:tranquil_loc/shared/types/form_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
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
  final Credentials user = Credentials.empty;
  final FormErrors errors = FormErrors();

  void submit(AppLocalizations locale) async {
    setState(() => errors.clear());

    try {
      await AuthApi.signIn(user);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(Dashboard.route);
      });
    } on ApiException catch (error) {
      switch (error.statusCode) {
        case HttpStatus.unauthorized:
          setState(() {
            errors["email"] = locale.invalid_email_or_password;
            errors["password"] = locale.invalid_email_or_password;
          });
          break;
        case HttpStatus.badRequest:
          setState(() {
            errors["password"] = locale.password_is_weak;
          });
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
                    Text(locale.login, style: h2),
                    Text(locale.happy_to_see_you, style: p2),
                  ],
                ),
                CustomTextField(
                  label: locale.email,
                  onChanged:
                      (newValue) => setState(() => user.email = newValue),
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
                      (newValue) => setState(() => user.password = newValue),
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
