import 'package:dossier_locataire/components/button.dart';
import 'package:dossier_locataire/components/date-picker.dart';
import 'package:dossier_locataire/components/dropdown.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/components/text-field.dart';
import 'package:dossier_locataire/layout/page-layout.dart';
import 'package:dossier_locataire/pages/auth/login/login.dart';
import 'package:dossier_locataire/pages/dashboard/dashboard.dart';
import 'package:dossier_locataire/shared/enums/search-state.dart';
import 'package:dossier_locataire/shared/enums/user-type.dart';
import 'package:dossier_locataire/shared/models/register-user.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:dossier_locataire/shared/types/form-errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class RegisterInfos extends StatefulWidget {
  const RegisterInfos({super.key});

  static const route = '/auth/register/infos';

  @override
  State<RegisterInfos> createState() => _RegisterInfosState();
}

class _RegisterInfosState extends State<RegisterInfos> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegisterUserInfo user = RegisterUserInfo(
    firstname: "",
    lastname: "",
    phone: "",
    dateOfBirth: DateTime.now(),
    type: UserType.other,
  );
  final FormErrors errors = FormErrors();

  void submit(AppLocalizations locale) async {
    setState(() => errors.clear());
    try {
      CollectionReference users = FirebaseFirestore.instance.collection(
        "users",
      );
      users.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'firstname': user.firstname,
        'lastname': user.lastname,
        'phone': user.phone,
        'dateOfBirth': user.dateOfBirth,
        'type': user.type.locale(locale),
        'opennedMail': 0,
        'searchState': SearchState.searching.str,
      });
      context.go(Dashboard.route);
    } catch (error) {
      print(error.toString());
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
                  label: locale.firstname,
                  onChanged: (newValue) => user.firstname = newValue!,
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
                  onChanged: (newValue) => user.lastname = newValue!,
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
                CustomTextField(
                  label: locale.phone,
                  validator: (value) {
                    if (value == null || value == "") {
                      return locale.cant_be_empty(locale.the_phone);
                    }
                    return null;
                  },
                  onChanged:
                      (newValue) => setState(() => user.phone = newValue!),
                  hint: locale.phone_hint,
                  isRequired: true,
                  type: TextFieldType.phone,
                  errorText: errors["phone"],
                ),
                CustomDatePicker(
                  label: locale.date_of_birth,
                  onChanged:
                      (newValue) => setState(() => user.dateOfBirth = newValue),
                  isRequired: true,
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
                  defaultValue: UserType.other,
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
