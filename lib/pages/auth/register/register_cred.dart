import 'package:dossier_locataire/api/auth_api.dart';
import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/components/text_field.dart';
import 'package:dossier_locataire/layout/page_layout.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/auth/register/register_info.dart';
import 'package:dossier_locataire/shared/models/api_errors.dart';
import 'package:dossier_locataire/shared/models/credentials.dart';
import 'package:dossier_locataire/shared/extensions.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:dossier_locataire/shared/types/form_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  final Credentials cred = Credentials(email: "", password: "");
  final FormErrors errors = FormErrors();

  void submit(AppLocalizations locale) async {
    setState(() => errors.clear());
    try {
      await AuthApi.preRegister(cred);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(RegisterInfos.route);
      });
    } on ApiException catch (err) {
      switch (err.response.code) {
        case "conflict":
            setState(() => errors["email"] = locale.email_already_used);
            break ;
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
                    Text(locale.register, style: h2),
                    Text(locale.happy_to_welcome, style: p2),
                  ],
                ),
                CustomTextField(
                  label: locale.email,
                  onChanged: (newValue) => cred.email = newValue!,
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
                  onChanged: (newValue) => cred.password = newValue!,
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
                    if (value != cred.password) {
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
