// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get dashboard => 'Dashboard';

  @override
  String get occupants => 'Occupants';

  @override
  String get warrantors => 'Warrantors';

  @override
  String get my_account => 'My account';

  @override
  String get my_profile => 'My profile';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get occupant => 'Occupant';

  @override
  String hey_username(Object username) {
    return 'Hey $username!';
  }

  @override
  String get happy_to_see_you => 'Happy to see you again!';

  @override
  String get mail_openned_percentage => 'Opened emails percentage';

  @override
  String get share_my_folder => 'Share my file';

  @override
  String get found_appartement => 'I found an apartment!';

  @override
  String get search_state => 'Search status';

  @override
  String get searching => 'Searching';

  @override
  String get paused => 'Paused';

  @override
  String get future_occupants => 'Future occupants';

  @override
  String get no_future_occupants_saved => 'No future occupants saved...';

  @override
  String get no_warrantors_saved => 'No warrantors saved...';

  @override
  String n_days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String n_weeks(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks',
      one: '1 week',
    );
    return '$_temp0';
  }

  @override
  String n_months(Object count) {
    return '$count months';
  }

  @override
  String get my_shares => 'My shares';

  @override
  String get no_shares_saved => 'No shares saved...';

  @override
  String get days => 'days';

  @override
  String get weeks => 'weeks';

  @override
  String get months => 'months';

  @override
  String get share => 'Share';

  @override
  String get share_dialog_description =>
      'Here you can add shares to make your file visible to other people. (edit this text)';

  @override
  String get description => 'Description';

  @override
  String get description_hint => 'John Doe';

  @override
  String get email => 'Email';

  @override
  String get email_hint => 'john.doe@email.com';

  @override
  String get the_email => 'The email';

  @override
  String get the_description => 'The description';

  @override
  String get the_duration => 'The duration';

  @override
  String get duration_of_share => 'Share duration';

  @override
  String get permissions => 'Permissions';

  @override
  String get read_infos => 'Read info';

  @override
  String get read_files => 'Read files';

  @override
  String get canceled => 'Cancel';

  @override
  String get write => 'Write';

  @override
  String get add_future_occupant => 'Add a future occupant';

  @override
  String get update_future_occupant => 'Edit future occupant';

  @override
  String get update_warrantor => 'Edit warrantor';

  @override
  String get add_warrantor => 'Add a warrantor';

  @override
  String get monthly_income => 'Monthly income';

  @override
  String get the_monthly_income => 'The monthly income';

  @override
  String get situation => 'Situation';

  @override
  String get pro_situation => 'Work situation';

  @override
  String get home_situation => 'Home situation';

  @override
  String get personal_infos => 'Personal information';

  @override
  String get cdd => 'Fixed-term contract';

  @override
  String get cdi => 'Permanent contract';

  @override
  String get retired => 'Retired';

  @override
  String get apprentice => 'Apprentice';

  @override
  String get unemployed => 'Unemployed';

  @override
  String get student => 'Student';

  @override
  String get official => 'Civil servant';

  @override
  String get freelance => 'Freelancer';

  @override
  String get identityDocuments => 'Identity document';

  @override
  String get proofOfAddress => 'Proof of address';

  @override
  String get taxNotice => 'Tax notice';

  @override
  String get employmentContract => 'Employment contract';

  @override
  String get lastThreePayslips => 'Last 3 payslips';

  @override
  String get pensionCertificate => 'Pension certificate';

  @override
  String get apprenticeshipForm => 'Apprenticeship form (CERFA)';

  @override
  String get schoolEnrollmentCertificate => 'Enrollment certificate';

  @override
  String get areCertificate => 'ARE certificate';

  @override
  String get jobOffer => 'Job offer';

  @override
  String get employerCertificate => 'Employer certificate';

  @override
  String get registrationSirene => 'SIRENE registration';

  @override
  String get financialStatement => 'Financial statement';

  @override
  String get phone => 'Phone';

  @override
  String get the_phone => 'Phone number';

  @override
  String get the_date_of_birth => 'Date of birth';

  @override
  String get phone_hint => '01 01 01 01 01';

  @override
  String get contact_details => 'Contact details';

  @override
  String get documents => 'Documents';

  @override
  String get complete => 'Complete';

  @override
  String get incomplete => 'Incomplete';

  @override
  String get mistake_happens => 'Mistakes happen!';

  @override
  String get an_email_will_be_sent =>
      'An email will be sent to change your password';

  @override
  String get no_account => 'No account yet?';

  @override
  String get password => 'Password';

  @override
  String get the_otp_code => 'The authentication code';

  @override
  String get forgotten_password => 'Forgot password?';

  @override
  String get lets_go => 'Let\'s go!';

  @override
  String get login => 'Login';

  @override
  String get send_mail => 'Send email';

  @override
  String get i_remember => 'I remember?';

  @override
  String get register => 'Sign up';

  @override
  String get happy_to_welcome => 'Happy to have you!';

  @override
  String get confirm_password => 'Confirm password';

  @override
  String get already_has_account => 'Already have an account?';

  @override
  String get the_password => 'The password';

  @override
  String get the_confirm_password => 'Password confirmation';

  @override
  String get firstname => 'First name';

  @override
  String get the_firstname => 'The first name';

  @override
  String get firstname_hint => 'John';

  @override
  String get lastname => 'Last name';

  @override
  String get the_lastname => 'The last name';

  @override
  String get lastname_hint => 'Doe';

  @override
  String get date_of_birth => 'Date of birth';

  @override
  String get type => 'Who am I?';

  @override
  String get other => 'Other';

  @override
  String get warrantor => 'Warrantor';

  @override
  String get select_a_date => 'Select a date';

  @override
  String get save => 'Save';

  @override
  String get tenant => 'Tenant';

  @override
  String get owner => 'Owner';

  @override
  String get upload_your_file_here => 'Upload your files here';

  @override
  String get verify_email => 'Verify your email!';

  @override
  String get your_email_needs_verif =>
      'You’ve received an email to verify your email address. Get the code sent by email to finalize your inscription!';

  @override
  String get go_to_dashboard => 'Go to dashboard';

  @override
  String get go_to_login => 'Back to login';

  @override
  String get expired_verif_code => 'Verification code has expired.';

  @override
  String get invalid_verif_code => 'Verification code has already been used.';

  @override
  String get invalid_phone_number => 'Phone number is not valid.';

  @override
  String get user_not_found => 'User not found.';

  @override
  String get email_already_used => 'Email is already used.';

  @override
  String get account_deactivated => 'The account has been deactivated.';

  @override
  String get invalid_email_or_password => 'Email or password is invalid.';

  @override
  String get invalid_otp_code => 'The authentication code is invalid.';

  @override
  String get email_not_sent => 'The email hasn\'t been sent.';

  @override
  String get email_already_verified => 'The email has already been verified.';

  @override
  String get confirm_password_must_match =>
      'Password confirmation does not match.';

  @override
  String get password_is_weak =>
      'Password must be at least 8 characters long and contain an uppercase, lowercase, number, and special character.';

  @override
  String cant_be_empty(Object what) {
    return '$what can\'t be empty.';
  }

  @override
  String must_be_well_formatted(Object what) {
    return '$what must be properly formatted.';
  }

  @override
  String must_be_a_number(Object what) {
    return '$what must be a number';
  }

  @override
  String must_be_superior_or_equal_than(Object how_much, Object what) {
    return '$what must be greater than or equal to $how_much';
  }

  @override
  String must_be_inferior_or_equal_than(Object how_much, Object what) {
    return '$what must be less than or equal to $how_much';
  }

  @override
  String get must_have_at_least_one_perm =>
      'You must have at least one permission to share your file.';

  @override
  String get must_has_extension => 'Accepted formats: .jpg, .png, .pdf.';

  @override
  String already_exists(Object file) {
    return '$file already exists.';
  }
}
