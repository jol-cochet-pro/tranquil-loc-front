// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get dashboard => 'Dashboard';

  @override
  String get occupants => 'Occupants';

  @override
  String get warrantors => 'Garants';

  @override
  String get my_account => 'Mon compte';

  @override
  String get my_profile => 'Mon profil';

  @override
  String get settings => 'Paramètres';

  @override
  String get logout => 'Déconnexion';

  @override
  String get occupant => 'Occupant';

  @override
  String hey_username(Object username) {
    return 'Hey $username !';
  }

  @override
  String get happy_to_see_you => 'Content de vous revoir !';

  @override
  String get mail_openned_percentage => 'Pourcentage de mails ouverts';

  @override
  String get share_my_folder => 'Partager mon dossier';

  @override
  String get found_appartement => 'J\'ai trouvé un appartement !';

  @override
  String get search_state => 'État recherche';

  @override
  String get searching => 'En recherche';

  @override
  String get paused => 'En pause';

  @override
  String get future_occupants => 'Futur occupants';

  @override
  String get no_future_occupants_saved =>
      'Pas de futur occupants enregistrés...';

  @override
  String get no_warrantors_saved => 'Pas de garants enregistrés...';

  @override
  String n_days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String n_weeks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semaine',
      one: '1 semaine',
    );
    return '$_temp0';
  }

  @override
  String n_months(Object count) {
    return '$count mois';
  }

  @override
  String get my_shares => 'Mes partages';

  @override
  String get no_shares_saved => 'Pas de partages enregistrés...';

  @override
  String get days => 'jours';

  @override
  String get weeks => 'semaines';

  @override
  String get months => 'mois';

  @override
  String get share => 'Partager';

  @override
  String get share_dialog_description =>
      'Ici vous pouvez ajouter des partages pour faire en sorte\nque votre dossier soit vu par d’autre personnes. (changer ce texte)';

  @override
  String get description => 'Description';

  @override
  String get description_hint => 'Jean Dupont';

  @override
  String get email => 'Email';

  @override
  String get email_hint => 'jean.dupont@email.com';

  @override
  String get the_email => 'L\'email';

  @override
  String get the_description => 'La description';

  @override
  String get the_duration => 'La durée';

  @override
  String get duration_of_share => 'Durée du partage';

  @override
  String get permissions => 'Permissions';

  @override
  String get read_infos => 'Lecture infos';

  @override
  String get read_files => 'Lecture fichiers';

  @override
  String get canceled => 'Annuler';

  @override
  String get write => 'Écriture';

  @override
  String get add_future_occupant => 'Ajouter un futur occupant';

  @override
  String get update_future_occupant => 'Modifier un futur occupant';

  @override
  String get update_warrantor => 'Modifier un garant';

  @override
  String get add_warrantor => 'Ajouter un garant';

  @override
  String get monthly_income => 'Revenus mensuels';

  @override
  String get the_monthly_income => 'Le revenus mensuels';

  @override
  String get situation => 'Situation';

  @override
  String get pro_situation => 'Situation professionnelle';

  @override
  String get home_situation => 'Situation de domicile';

  @override
  String get personal_infos => 'Informations personnelles';

  @override
  String get cdd => 'CDD';

  @override
  String get cdi => 'CDI';

  @override
  String get retired => 'Retraité';

  @override
  String get apprentice => 'Alternant';

  @override
  String get unemployed => 'Chômeur';

  @override
  String get student => 'Étudiant';

  @override
  String get official => 'Fonctionnaire';

  @override
  String get freelance => 'Indépendant';

  @override
  String get identityDocuments => 'Document d\'identité';

  @override
  String get proofOfAddress => 'Justificatif de domicile';

  @override
  String get taxNotice => 'Avis d\'imposition';

  @override
  String get employmentContract => 'Contrat de travail';

  @override
  String get lastThreePayslips => 'Bulletins de salaires (3 derniers)';

  @override
  String get pensionCertificate => 'Certificat de pension de retraite';

  @override
  String get apprenticeshipForm => 'CERFA d\'alternance';

  @override
  String get schoolEnrollmentCertificate => 'Certificat de scolarité';

  @override
  String get areCertificate => 'Attestation ARE';

  @override
  String get jobOffer => 'Promesse d\'embauche';

  @override
  String get employerCertificate => 'Attestation employeur';

  @override
  String get registrationSirene => 'Situation au repertoire sirène';

  @override
  String get financialStatement => 'Bilan comptable';

  @override
  String get phone => 'Téléphone';

  @override
  String get the_phone => 'Le numéro de téléphone';

  @override
  String get the_date_of_birth => 'La date de naissance';

  @override
  String get phone_hint => '01 01 01 01 01';

  @override
  String get contact_details => 'Coordonnées';

  @override
  String get documents => 'Documents';

  @override
  String get complete => 'Complet';

  @override
  String get incomplete => 'Incomplet';

  @override
  String get mistake_happens => 'Un oubli, ça arrive !';

  @override
  String get an_email_will_be_sent =>
      'un e-mail va vous êtes envoyé pour modifier votre mot de passe';

  @override
  String get no_account => 'Pas encore de compte ?';

  @override
  String get password => 'Mot de passe';

  @override
  String get the_otp_code => 'Le code d\'authentification';

  @override
  String get forgotten_password => 'Mot de passe oublié ?';

  @override
  String get lets_go => 'C\'est parti !';

  @override
  String get login => 'Connexion';

  @override
  String get send_mail => 'Envoyer le mail';

  @override
  String get i_remember => 'Je m\'en souviens ?';

  @override
  String get register => 'Inscription';

  @override
  String get happy_to_welcome => 'Heureux de vous accueillir !';

  @override
  String get confirm_password => 'Confirmation du mot de passe';

  @override
  String get already_has_account => 'J\'ai déjà un compte ?';

  @override
  String get the_password => 'Le mot de passe';

  @override
  String get the_confirm_password => 'La confirmation du mot de passe';

  @override
  String get firstname => 'Prénom';

  @override
  String get the_firstname => 'Le prénom';

  @override
  String get firstname_hint => 'Jean';

  @override
  String get lastname => 'Nom';

  @override
  String get the_lastname => 'Le nom';

  @override
  String get lastname_hint => 'Dupont';

  @override
  String get date_of_birth => 'Date de naissance';

  @override
  String get type => 'Qui suis-je ?';

  @override
  String get other => 'Autre';

  @override
  String get warrantor => 'Garant';

  @override
  String get select_a_date => 'Sélectionner une date';

  @override
  String get save => 'Sauvegarder';

  @override
  String get tenant => 'Locataire';

  @override
  String get owner => 'Propriétaire';

  @override
  String get upload_your_file_here => 'Téléverser vos fichiers ici';

  @override
  String get verify_email => 'Vérifier votre email !';

  @override
  String get your_email_needs_verif =>
      'Vous avez reçu un mail pour faire la vérification de votre email. Récupérer le code envoyé par email pour finaliser votre inscription !';

  @override
  String get go_to_dashboard => 'Aller au dashboard';

  @override
  String get go_to_login => 'Retour à la connexion';

  @override
  String get expired_verif_code => 'le code de vérification à expiré.';

  @override
  String get invalid_verif_code =>
      'le code de vérification à déjà été utilisé.';

  @override
  String get invalid_phone_number =>
      'le numéro de téléphone n\'est pas valide.';

  @override
  String get user_not_found => 'l\'utilisateur n\'a pas été trouvé.';

  @override
  String get email_already_used => 'L\'adresse email est déjà utilisée.';

  @override
  String get account_deactivated => 'Le compte a été désactivé.';

  @override
  String get invalid_email_or_password =>
      'L\'email ou le mot de passe est invalide.';

  @override
  String get invalid_otp_code => 'Le code d\'authentification est invalide.';

  @override
  String get email_not_sent => 'L\'email n\'a pas été envoyé.';

  @override
  String get email_already_verified => 'L\'email a déjà été vérifié.';

  @override
  String get confirm_password_must_match =>
      'La confirmation du mot de passe est incorrecte.';

  @override
  String get password_is_weak =>
      'Le mot de passe doit contenir un combinaisons contenant minimum 8 lettres, une majuscule, une minuscule, un chiffre et un caractère spécial.';

  @override
  String cant_be_empty(Object what) {
    return '$what ne peut pas être vide.';
  }

  @override
  String must_be_well_formatted(Object what) {
    return '$what doit être correctement formatté.';
  }

  @override
  String must_be_a_number(Object what) {
    return '$what doit être un nombre';
  }

  @override
  String must_be_superior_or_equal_than(Object how_much, Object what) {
    return '$what doit être supérieure ou égale à $how_much';
  }

  @override
  String must_be_inferior_or_equal_than(Object how_much, Object what) {
    return '$what doit être inférieure ou égale à $how_much';
  }

  @override
  String get must_have_at_least_one_perm =>
      'Vous devez avoir au moins une permission pour partager votre dossier.';

  @override
  String get must_has_extension => 'Formats acceptés : .jpg, .png, .pdf.';

  @override
  String already_exists(Object file) {
    return '$file existe déjà.';
  }
}
