// ignore_for_file: constant_identifier_names

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum DocumentType {
  IDENTITY_DOCUMENTS,
  PROOF_OF_ADDRESS,
  TAX_NOTICE,
  EMPLOYMENT_CONTRACT,
  LAST_THREE_PAYSLIPS,
  PENSION_CERTIFICATE,
  APPRENTICESHIP_FORM,
  SCHOOL_ENROLLMENT_CERTIFICATE,
  ARE_CERTIFICATE,
  JOB_OFFER,
  EMPLOYER_CERTIFICATE,
  REGISTRATION_SIRENE,
  FINANCIAL_STATEMENT,
  OTHER,
}

extension DocumentTypeExtension on DocumentType {
  String get str {
    switch (this) {
      case DocumentType.IDENTITY_DOCUMENTS:
        return "identityDocuments";
      case DocumentType.PROOF_OF_ADDRESS:
        return "proofOfAddress";
      case DocumentType.TAX_NOTICE:
        return "taxNotice";
      case DocumentType.EMPLOYMENT_CONTRACT:
        return "employmentContract";
      case DocumentType.LAST_THREE_PAYSLIPS:
        return "lastThreePayslips";
      case DocumentType.PENSION_CERTIFICATE:
        return "pensionCertificate";
      case DocumentType.APPRENTICESHIP_FORM:
        return "apprenticeshipForm";
      case DocumentType.SCHOOL_ENROLLMENT_CERTIFICATE:
        return "schoolEnrollmentCertificate";
      case DocumentType.ARE_CERTIFICATE:
        return "areCertificate";
      case DocumentType.JOB_OFFER:
        return "jobOffer";
      case DocumentType.EMPLOYER_CERTIFICATE:
        return "employerCertificate";
      case DocumentType.REGISTRATION_SIRENE:
        return "registrationSirene";
      case DocumentType.FINANCIAL_STATEMENT:
        return "financialStatement";
      case DocumentType.OTHER:
        return "other";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case DocumentType.IDENTITY_DOCUMENTS:
        return locale.identityDocuments;
      case DocumentType.PROOF_OF_ADDRESS:
        return locale.proofOfAddress;
      case DocumentType.TAX_NOTICE:
        return locale.taxNotice;
      case DocumentType.EMPLOYMENT_CONTRACT:
        return locale.employmentContract;
      case DocumentType.LAST_THREE_PAYSLIPS:
        return locale.lastThreePayslips;
      case DocumentType.PENSION_CERTIFICATE:
        return locale.pensionCertificate;
      case DocumentType.APPRENTICESHIP_FORM:
        return locale.apprenticeshipForm;
      case DocumentType.SCHOOL_ENROLLMENT_CERTIFICATE:
        return locale.schoolEnrollmentCertificate;
      case DocumentType.ARE_CERTIFICATE:
        return locale.areCertificate;
      case DocumentType.JOB_OFFER:
        return locale.jobOffer;
      case DocumentType.EMPLOYER_CERTIFICATE:
        return locale.employerCertificate;
      case DocumentType.REGISTRATION_SIRENE:
        return locale.registrationSirene;
      case DocumentType.FINANCIAL_STATEMENT:
        return locale.financialStatement;
      case DocumentType.OTHER:
        return locale.other;
    }
  }
}
