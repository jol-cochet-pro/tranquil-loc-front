import 'dart:io';

import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/components/text_field.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/dashboard/dashboard.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/otp.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:tranquil_loc/shared/types/form_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class NeedEmailVerification extends StatefulWidget {
  const NeedEmailVerification({super.key});

  static const route = "/auth/need-email-verification";

  @override
  State<NeedEmailVerification> createState() => _NeedEmailVerificationState();
}

class _NeedEmailVerificationState extends State<NeedEmailVerification> {
  final FormErrors errors = FormErrors();
  final Otp otp = Otp.empty;

  void submit(AppLocalizations locale) async {
    setState(() => errors.clear());
    try {
      await AuthApi.checkEmail(otp);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(Dashboard.route);
      });
    } on ApiException catch (err) {
      switch (err.statusCode) {
        case HttpStatus.notFound:
          setState(() => errors["otp"] = locale.email_not_sent);
          break;
        case HttpStatus.forbidden:
          setState(() => errors["otp"] = locale.email_already_verified);
          break;
        case HttpStatus.badRequest:
          setState(() => errors["otp"] = locale.invalid_otp_code);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    Text(locale.verify_email, style: h2),
                    Text(locale.your_email_needs_verif, style: p2),
                  ],
                ),
                CustomTextField(
                  initialValue: null,
                  hint: "111111",
                  onChanged:
                      (newValue) => otp.code = (int.tryParse(newValue) ?? -1),
                  isRequired: false,
                  type: TextFieldType.number,
                  validator: (value) {
                    if (value == null) {
                      return locale.cant_be_empty(locale.the_otp_code);
                    }
                    int? code = int.tryParse(value);
                    if (code == null || code < 10000 || code > 99999) {
                      return locale.invalid_otp_code;
                    }
                    return null;
                  },
                  errorText: errors["otp"],
                ),
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      submit(locale);
                    }
                  },
                  padding: EdgeInsets.all(12),
                  type: ButtonType.primary,
                  child: Text(locale.lets_go),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
