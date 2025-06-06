import 'package:tranquil_loc/api/auth_api.dart';
import 'package:tranquil_loc/components/button.dart';
import 'package:tranquil_loc/components/date_field.dart';
import 'package:tranquil_loc/components/dropdown.dart';
import 'package:tranquil_loc/components/phone_field.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/components/text_field.dart';
import 'package:tranquil_loc/layout/page_layout.dart';
import 'package:tranquil_loc/pages/auth/login/login.dart';
import 'package:tranquil_loc/pages/dashboard/dashboard.dart';
import 'package:tranquil_loc/shared/enums/user_type.dart';
import 'package:tranquil_loc/shared/models/api_exception.dart';
import 'package:tranquil_loc/shared/models/user.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:tranquil_loc/shared/types/form_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class RegisterInfos extends StatefulWidget {
  const RegisterInfos({super.key});

  static const route = '/auth/register/infos';

  @override
  State<RegisterInfos> createState() => _RegisterInfosState();
}

class _RegisterInfosState extends State<RegisterInfos> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final User user = User.empty;
  final FormErrors errors = FormErrors();

  void submit(AppLocalizations locale) async {
    setState(() => errors.clear());
    try {
      await AuthApi.register(user);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go(Dashboard.route);
      });
    } on ApiException catch (err) {
      print(err.message);
    }
    //   if (user.type == UserType.occupant) {
    //     await OccupantApi.add(
    //       Occupant(
    //         id: "",
    //         firstname: user.firstname,
    //         lastname: user.lastname,
    //         dateOfBirth: user.dateOfBirth,
    //         income: 0,
    //         proSituation: ProSituation.other,
    //         homeSituation: HomeSituation.other,
    //         email: currentUser.email!,
    //         phone: user.phone,
    //         documents: {},
    //       ),
    //     );
    //   }
    //   if (user.type == UserType.warrantor) {
    //     await WarrantorApi.add(
    //       Warrantor(
    //         id: "",
    //         firstname: user.firstname,
    //         lastname: user.lastname,
    //         dateOfBirth: user.dateOfBirth,
    //         income: 0,
    //         proSituation: ProSituation.other,
    //         homeSituation: HomeSituation.other,
    //         email: currentUser.email!,
    //         phone: user.phone,
    //         documents: {},
    //       ),
    //     );
    //   }
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
                  label: locale.firstname,
                  onChanged: (newValue) => user.firstname = newValue,
                  validator: (value) {
                    if (value == null || value == "") {
                      return locale.cant_be_empty(locale.the_firstname);
                    }
                    return null;
                  },
                  hint: locale.firstname_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                  errorText: errors["firstname"],
                ),
                CustomTextField(
                  label: locale.lastname,
                  onChanged: (newValue) => user.lastname = newValue,
                  validator: (value) {
                    if (value == null || value == "") {
                      return locale.cant_be_empty(locale.the_lastname);
                    }
                    return null;
                  },
                  hint: locale.lastname_hint,
                  isRequired: true,
                  type: TextFieldType.text,
                  errorText: errors["lastname"],
                ),
                CustomPhoneField(
                  label: locale.phone,
                  validator: (value) {
                    try {
                      if (value == null) {
                        throw Error();
                      }
                      value.isValidNumber();
                      return null;
                    } catch (_) {
                      return locale.invalid_phone_number;
                    }
                  },
                  onChanged:
                      (newValue) =>
                          setState(() => user.phone = newValue.completeNumber),
                  isRequired: true,
                  errorText: errors["phone"],
                ),
                CustomDateField(
                  label: locale.date_of_birth,
                  onChanged:
                      (newValue) => setState(() => user.dateOfBirth = newValue),
                  isRequired: true,
                  validator: (value) {
                    if (value == null) {
                      return locale.cant_be_empty(locale.date_of_birth);
                    }
                    return null;
                  },
                ),
                CustomDropDown(
                  label: locale.type,
                  items:
                      UserType.values.map((el) {
                        return DropdownMenuEntry(
                          value: el,
                          label: el.locale(locale),
                        );
                      }).toList(),
                  isRequired: true,
                  onSelected:
                      (newValue) => setState(() => user.type = newValue!),
                  initialValue: UserType.OTHER,
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
