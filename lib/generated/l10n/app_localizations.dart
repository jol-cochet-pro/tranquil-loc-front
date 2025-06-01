import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fr')
  ];

  /// No description provided for @dashboard.
  ///
  /// In fr, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @occupants.
  ///
  /// In fr, this message translates to:
  /// **'Occupants'**
  String get occupants;

  /// No description provided for @warrantors.
  ///
  /// In fr, this message translates to:
  /// **'Garants'**
  String get warrantors;

  /// No description provided for @my_account.
  ///
  /// In fr, this message translates to:
  /// **'Mon compte'**
  String get my_account;

  /// No description provided for @my_profile.
  ///
  /// In fr, this message translates to:
  /// **'Mon profil'**
  String get my_profile;

  /// No description provided for @settings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In fr, this message translates to:
  /// **'Déconnexion'**
  String get logout;

  /// No description provided for @occupant.
  ///
  /// In fr, this message translates to:
  /// **'Occupant'**
  String get occupant;

  /// No description provided for @folder_of.
  ///
  /// In fr, this message translates to:
  /// **'Dossier de {firstname} {lastname}'**
  String folder_of(Object firstname, Object lastname);

  /// No description provided for @transmit_folder.
  ///
  /// In fr, this message translates to:
  /// **'Un candidat à la location vous a transmis son dossier ! Vous trouverez ici l’ensemble des documents nécessaires à l’étude de sa candidature : pièces d’identité, justificatifs de revenus, documents liés à l’emploi, etc. Vous pouvez, via cet espace télécharger tous les documents pour chacun des futur occupants / garants.'**
  String get transmit_folder;

  /// No description provided for @hey_username.
  ///
  /// In fr, this message translates to:
  /// **'Hey {username} !'**
  String hey_username(Object username);

  /// No description provided for @happy_to_see_you.
  ///
  /// In fr, this message translates to:
  /// **'Content de vous revoir !'**
  String get happy_to_see_you;

  /// No description provided for @mail_openned_percentage.
  ///
  /// In fr, this message translates to:
  /// **'Pourcentage de mails ouverts'**
  String get mail_openned_percentage;

  /// No description provided for @share_my_folder.
  ///
  /// In fr, this message translates to:
  /// **'Partager mon dossier'**
  String get share_my_folder;

  /// No description provided for @found_appartement.
  ///
  /// In fr, this message translates to:
  /// **'J\'ai trouvé un appartement !'**
  String get found_appartement;

  /// No description provided for @search_state.
  ///
  /// In fr, this message translates to:
  /// **'État recherche'**
  String get search_state;

  /// No description provided for @searching.
  ///
  /// In fr, this message translates to:
  /// **'En recherche'**
  String get searching;

  /// No description provided for @paused.
  ///
  /// In fr, this message translates to:
  /// **'En pause'**
  String get paused;

  /// No description provided for @future_occupants.
  ///
  /// In fr, this message translates to:
  /// **'Futur occupants'**
  String get future_occupants;

  /// No description provided for @no_future_occupants_saved.
  ///
  /// In fr, this message translates to:
  /// **'Pas de futur occupants enregistrés...'**
  String get no_future_occupants_saved;

  /// No description provided for @no_warrantors_saved.
  ///
  /// In fr, this message translates to:
  /// **'Pas de garants enregistrés...'**
  String get no_warrantors_saved;

  /// No description provided for @n_days.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 jour} other{{count} jours}}'**
  String n_days(num count);

  /// No description provided for @n_weeks.
  ///
  /// In fr, this message translates to:
  /// **'{count, plural, =1{1 semaine} other{{count} semaine}}'**
  String n_weeks(num count);

  /// No description provided for @n_months.
  ///
  /// In fr, this message translates to:
  /// **'{count} mois'**
  String n_months(Object count);

  /// No description provided for @my_shares.
  ///
  /// In fr, this message translates to:
  /// **'Mes partages'**
  String get my_shares;

  /// No description provided for @no_shares_saved.
  ///
  /// In fr, this message translates to:
  /// **'Pas de partages enregistrés...'**
  String get no_shares_saved;

  /// No description provided for @days.
  ///
  /// In fr, this message translates to:
  /// **'jours'**
  String get days;

  /// No description provided for @weeks.
  ///
  /// In fr, this message translates to:
  /// **'semaines'**
  String get weeks;

  /// No description provided for @months.
  ///
  /// In fr, this message translates to:
  /// **'mois'**
  String get months;

  /// No description provided for @share.
  ///
  /// In fr, this message translates to:
  /// **'Partager'**
  String get share;

  /// No description provided for @share_dialog_description.
  ///
  /// In fr, this message translates to:
  /// **'Ici vous pouvez ajouter des partages pour faire en sorte\nque votre dossier soit vu par d’autre personnes. (changer ce texte)'**
  String get share_dialog_description;

  /// No description provided for @description.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @description_hint.
  ///
  /// In fr, this message translates to:
  /// **'Jean Dupont'**
  String get description_hint;

  /// No description provided for @email.
  ///
  /// In fr, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @email_hint.
  ///
  /// In fr, this message translates to:
  /// **'jean.dupont@email.com'**
  String get email_hint;

  /// No description provided for @the_email.
  ///
  /// In fr, this message translates to:
  /// **'L\'email'**
  String get the_email;

  /// No description provided for @the_description.
  ///
  /// In fr, this message translates to:
  /// **'La description'**
  String get the_description;

  /// No description provided for @the_duration.
  ///
  /// In fr, this message translates to:
  /// **'La durée'**
  String get the_duration;

  /// No description provided for @duration_of_share.
  ///
  /// In fr, this message translates to:
  /// **'Durée du partage'**
  String get duration_of_share;

  /// No description provided for @permissions.
  ///
  /// In fr, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @read_infos.
  ///
  /// In fr, this message translates to:
  /// **'Lecture infos'**
  String get read_infos;

  /// No description provided for @read_files.
  ///
  /// In fr, this message translates to:
  /// **'Lecture fichiers'**
  String get read_files;

  /// No description provided for @canceled.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get canceled;

  /// No description provided for @write.
  ///
  /// In fr, this message translates to:
  /// **'Écriture'**
  String get write;

  /// No description provided for @add_future_occupant.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un futur occupant'**
  String get add_future_occupant;

  /// No description provided for @update_future_occupant.
  ///
  /// In fr, this message translates to:
  /// **'Modifier un futur occupant'**
  String get update_future_occupant;

  /// No description provided for @update_warrantor.
  ///
  /// In fr, this message translates to:
  /// **'Modifier un garant'**
  String get update_warrantor;

  /// No description provided for @add_warrantor.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un garant'**
  String get add_warrantor;

  /// No description provided for @monthly_income.
  ///
  /// In fr, this message translates to:
  /// **'Revenus mensuels'**
  String get monthly_income;

  /// No description provided for @the_monthly_income.
  ///
  /// In fr, this message translates to:
  /// **'Le revenus mensuels'**
  String get the_monthly_income;

  /// No description provided for @situation.
  ///
  /// In fr, this message translates to:
  /// **'Situation'**
  String get situation;

  /// No description provided for @pro_situation.
  ///
  /// In fr, this message translates to:
  /// **'Situation professionnelle'**
  String get pro_situation;

  /// No description provided for @home_situation.
  ///
  /// In fr, this message translates to:
  /// **'Situation de domicile'**
  String get home_situation;

  /// No description provided for @personal_infos.
  ///
  /// In fr, this message translates to:
  /// **'Informations personnelles'**
  String get personal_infos;

  /// No description provided for @cdd.
  ///
  /// In fr, this message translates to:
  /// **'CDD'**
  String get cdd;

  /// No description provided for @cdi.
  ///
  /// In fr, this message translates to:
  /// **'CDI'**
  String get cdi;

  /// No description provided for @retired.
  ///
  /// In fr, this message translates to:
  /// **'Retraité'**
  String get retired;

  /// No description provided for @apprentice.
  ///
  /// In fr, this message translates to:
  /// **'Alternant'**
  String get apprentice;

  /// No description provided for @unemployed.
  ///
  /// In fr, this message translates to:
  /// **'Chômeur'**
  String get unemployed;

  /// No description provided for @student.
  ///
  /// In fr, this message translates to:
  /// **'Étudiant'**
  String get student;

  /// No description provided for @official.
  ///
  /// In fr, this message translates to:
  /// **'Fonctionnaire'**
  String get official;

  /// No description provided for @freelance.
  ///
  /// In fr, this message translates to:
  /// **'Indépendant'**
  String get freelance;

  /// No description provided for @identityDocuments.
  ///
  /// In fr, this message translates to:
  /// **'Document d\'identité'**
  String get identityDocuments;

  /// No description provided for @proofOfAddress.
  ///
  /// In fr, this message translates to:
  /// **'Justificatif de domicile'**
  String get proofOfAddress;

  /// No description provided for @taxNotice.
  ///
  /// In fr, this message translates to:
  /// **'Avis d\'imposition'**
  String get taxNotice;

  /// No description provided for @employmentContract.
  ///
  /// In fr, this message translates to:
  /// **'Contrat de travail'**
  String get employmentContract;

  /// No description provided for @lastThreePayslips.
  ///
  /// In fr, this message translates to:
  /// **'Bulletins de salaires (3 derniers)'**
  String get lastThreePayslips;

  /// No description provided for @pensionCertificate.
  ///
  /// In fr, this message translates to:
  /// **'Certificat de pension de retraite'**
  String get pensionCertificate;

  /// No description provided for @apprenticeshipForm.
  ///
  /// In fr, this message translates to:
  /// **'CERFA d\'alternance'**
  String get apprenticeshipForm;

  /// No description provided for @schoolEnrollmentCertificate.
  ///
  /// In fr, this message translates to:
  /// **'Certificat de scolarité'**
  String get schoolEnrollmentCertificate;

  /// No description provided for @areCertificate.
  ///
  /// In fr, this message translates to:
  /// **'Attestation ARE'**
  String get areCertificate;

  /// No description provided for @jobOffer.
  ///
  /// In fr, this message translates to:
  /// **'Promesse d\'embauche'**
  String get jobOffer;

  /// No description provided for @employerCertificate.
  ///
  /// In fr, this message translates to:
  /// **'Attestation employeur'**
  String get employerCertificate;

  /// No description provided for @registrationSirene.
  ///
  /// In fr, this message translates to:
  /// **'Situation au repertoire sirène'**
  String get registrationSirene;

  /// No description provided for @financialStatement.
  ///
  /// In fr, this message translates to:
  /// **'Bilan comptable'**
  String get financialStatement;

  /// No description provided for @phone.
  ///
  /// In fr, this message translates to:
  /// **'Téléphone'**
  String get phone;

  /// No description provided for @the_phone.
  ///
  /// In fr, this message translates to:
  /// **'Le numéro de téléphone'**
  String get the_phone;

  /// No description provided for @the_date_of_birth.
  ///
  /// In fr, this message translates to:
  /// **'La date de naissance'**
  String get the_date_of_birth;

  /// No description provided for @phone_hint.
  ///
  /// In fr, this message translates to:
  /// **'01 01 01 01 01'**
  String get phone_hint;

  /// No description provided for @contact_details.
  ///
  /// In fr, this message translates to:
  /// **'Coordonnées'**
  String get contact_details;

  /// No description provided for @documents.
  ///
  /// In fr, this message translates to:
  /// **'Documents'**
  String get documents;

  /// No description provided for @complete.
  ///
  /// In fr, this message translates to:
  /// **'Complet'**
  String get complete;

  /// No description provided for @incomplete.
  ///
  /// In fr, this message translates to:
  /// **'Incomplet'**
  String get incomplete;

  /// No description provided for @mistake_happens.
  ///
  /// In fr, this message translates to:
  /// **'Un oubli, ça arrive !'**
  String get mistake_happens;

  /// No description provided for @an_email_will_be_sent.
  ///
  /// In fr, this message translates to:
  /// **'un e-mail va vous êtes envoyé pour modifier votre mot de passe'**
  String get an_email_will_be_sent;

  /// No description provided for @no_account.
  ///
  /// In fr, this message translates to:
  /// **'Pas encore de compte ?'**
  String get no_account;

  /// No description provided for @password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe'**
  String get password;

  /// No description provided for @the_otp_code.
  ///
  /// In fr, this message translates to:
  /// **'Le code d\'authentification'**
  String get the_otp_code;

  /// No description provided for @forgotten_password.
  ///
  /// In fr, this message translates to:
  /// **'Mot de passe oublié ?'**
  String get forgotten_password;

  /// No description provided for @lets_go.
  ///
  /// In fr, this message translates to:
  /// **'C\'est parti !'**
  String get lets_go;

  /// No description provided for @login.
  ///
  /// In fr, this message translates to:
  /// **'Connexion'**
  String get login;

  /// No description provided for @send_mail.
  ///
  /// In fr, this message translates to:
  /// **'Envoyer le mail'**
  String get send_mail;

  /// No description provided for @download_complete_folder.
  ///
  /// In fr, this message translates to:
  /// **'Télécharger le dossier locatif complet'**
  String get download_complete_folder;

  /// No description provided for @i_remember.
  ///
  /// In fr, this message translates to:
  /// **'Je m\'en souviens ?'**
  String get i_remember;

  /// No description provided for @register.
  ///
  /// In fr, this message translates to:
  /// **'Inscription'**
  String get register;

  /// No description provided for @happy_to_welcome.
  ///
  /// In fr, this message translates to:
  /// **'Heureux de vous accueillir !'**
  String get happy_to_welcome;

  /// No description provided for @confirm_password.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation du mot de passe'**
  String get confirm_password;

  /// No description provided for @already_has_account.
  ///
  /// In fr, this message translates to:
  /// **'J\'ai déjà un compte ?'**
  String get already_has_account;

  /// No description provided for @the_password.
  ///
  /// In fr, this message translates to:
  /// **'Le mot de passe'**
  String get the_password;

  /// No description provided for @the_confirm_password.
  ///
  /// In fr, this message translates to:
  /// **'La confirmation du mot de passe'**
  String get the_confirm_password;

  /// No description provided for @firstname.
  ///
  /// In fr, this message translates to:
  /// **'Prénom'**
  String get firstname;

  /// No description provided for @the_firstname.
  ///
  /// In fr, this message translates to:
  /// **'Le prénom'**
  String get the_firstname;

  /// No description provided for @firstname_hint.
  ///
  /// In fr, this message translates to:
  /// **'Jean'**
  String get firstname_hint;

  /// No description provided for @lastname.
  ///
  /// In fr, this message translates to:
  /// **'Nom'**
  String get lastname;

  /// No description provided for @the_lastname.
  ///
  /// In fr, this message translates to:
  /// **'Le nom'**
  String get the_lastname;

  /// No description provided for @lastname_hint.
  ///
  /// In fr, this message translates to:
  /// **'Dupont'**
  String get lastname_hint;

  /// No description provided for @date_of_birth.
  ///
  /// In fr, this message translates to:
  /// **'Date de naissance'**
  String get date_of_birth;

  /// No description provided for @type.
  ///
  /// In fr, this message translates to:
  /// **'Qui suis-je ?'**
  String get type;

  /// No description provided for @other.
  ///
  /// In fr, this message translates to:
  /// **'Autre'**
  String get other;

  /// No description provided for @warrantor.
  ///
  /// In fr, this message translates to:
  /// **'Garant'**
  String get warrantor;

  /// No description provided for @select_a_date.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionner une date'**
  String get select_a_date;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Sauvegarder'**
  String get save;

  /// No description provided for @tenant.
  ///
  /// In fr, this message translates to:
  /// **'Locataire'**
  String get tenant;

  /// No description provided for @owner.
  ///
  /// In fr, this message translates to:
  /// **'Propriétaire'**
  String get owner;

  /// No description provided for @upload_your_file_here.
  ///
  /// In fr, this message translates to:
  /// **'Téléverser vos fichiers ici'**
  String get upload_your_file_here;

  /// No description provided for @verify_email.
  ///
  /// In fr, this message translates to:
  /// **'Vérifier votre email !'**
  String get verify_email;

  /// No description provided for @your_email_needs_verif.
  ///
  /// In fr, this message translates to:
  /// **'Vous avez reçu un mail pour faire la vérification de votre email. Récupérer le code envoyé par email pour finaliser votre inscription !'**
  String get your_email_needs_verif;

  /// No description provided for @go_to_dashboard.
  ///
  /// In fr, this message translates to:
  /// **'Aller au dashboard'**
  String get go_to_dashboard;

  /// No description provided for @go_to_login.
  ///
  /// In fr, this message translates to:
  /// **'Retour à la connexion'**
  String get go_to_login;

  /// No description provided for @expired_verif_code.
  ///
  /// In fr, this message translates to:
  /// **'le code de vérification à expiré.'**
  String get expired_verif_code;

  /// No description provided for @invalid_verif_code.
  ///
  /// In fr, this message translates to:
  /// **'le code de vérification à déjà été utilisé.'**
  String get invalid_verif_code;

  /// No description provided for @invalid_phone_number.
  ///
  /// In fr, this message translates to:
  /// **'le numéro de téléphone n\'est pas valide.'**
  String get invalid_phone_number;

  /// No description provided for @user_not_found.
  ///
  /// In fr, this message translates to:
  /// **'l\'utilisateur n\'a pas été trouvé.'**
  String get user_not_found;

  /// No description provided for @email_already_used.
  ///
  /// In fr, this message translates to:
  /// **'L\'adresse email est déjà utilisée.'**
  String get email_already_used;

  /// No description provided for @account_deactivated.
  ///
  /// In fr, this message translates to:
  /// **'Le compte a été désactivé.'**
  String get account_deactivated;

  /// No description provided for @invalid_email_or_password.
  ///
  /// In fr, this message translates to:
  /// **'L\'email ou le mot de passe est invalide.'**
  String get invalid_email_or_password;

  /// No description provided for @invalid_otp_code.
  ///
  /// In fr, this message translates to:
  /// **'Le code d\'authentification est invalide.'**
  String get invalid_otp_code;

  /// No description provided for @email_not_sent.
  ///
  /// In fr, this message translates to:
  /// **'L\'email n\'a pas été envoyé.'**
  String get email_not_sent;

  /// No description provided for @email_already_verified.
  ///
  /// In fr, this message translates to:
  /// **'L\'email a déjà été vérifié.'**
  String get email_already_verified;

  /// No description provided for @confirm_password_must_match.
  ///
  /// In fr, this message translates to:
  /// **'La confirmation du mot de passe est incorrecte.'**
  String get confirm_password_must_match;

  /// No description provided for @password_is_weak.
  ///
  /// In fr, this message translates to:
  /// **'Le mot de passe doit contenir un combinaisons contenant minimum 8 lettres, une majuscule, une minuscule, un chiffre et un caractère spécial.'**
  String get password_is_weak;

  /// No description provided for @cant_be_empty.
  ///
  /// In fr, this message translates to:
  /// **'{what} ne peut pas être vide.'**
  String cant_be_empty(Object what);

  /// No description provided for @must_be_well_formatted.
  ///
  /// In fr, this message translates to:
  /// **'{what} doit être correctement formatté.'**
  String must_be_well_formatted(Object what);

  /// No description provided for @must_be_a_number.
  ///
  /// In fr, this message translates to:
  /// **'{what} doit être un nombre'**
  String must_be_a_number(Object what);

  /// No description provided for @must_be_superior_or_equal_than.
  ///
  /// In fr, this message translates to:
  /// **'{what} doit être supérieure ou égale à {how_much}'**
  String must_be_superior_or_equal_than(Object how_much, Object what);

  /// No description provided for @must_be_inferior_or_equal_than.
  ///
  /// In fr, this message translates to:
  /// **'{what} doit être inférieure ou égale à {how_much}'**
  String must_be_inferior_or_equal_than(Object how_much, Object what);

  /// No description provided for @must_have_at_least_one_perm.
  ///
  /// In fr, this message translates to:
  /// **'Vous devez avoir au moins une permission pour partager votre dossier.'**
  String get must_have_at_least_one_perm;

  /// No description provided for @must_has_extension.
  ///
  /// In fr, this message translates to:
  /// **'Formats acceptés : .jpg, .png, .pdf.'**
  String get must_has_extension;

  /// No description provided for @already_exists.
  ///
  /// In fr, this message translates to:
  /// **'{file} existe déjà.'**
  String already_exists(Object file);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
