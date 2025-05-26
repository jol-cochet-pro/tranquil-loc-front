// ignore_for_file: constant_identifier_names

import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

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
        return "IDENTITY_DOCUMENTS";
      case DocumentType.PROOF_OF_ADDRESS:
        return "PROOF_OF_ADDRESS";
      case DocumentType.TAX_NOTICE:
        return "TAX_NOTICE";
      case DocumentType.EMPLOYMENT_CONTRACT:
        return "EMPLOYMENT_CONTRACT";
      case DocumentType.LAST_THREE_PAYSLIPS:
        return "LAST_THREE_PAYSLIPS";
      case DocumentType.PENSION_CERTIFICATE:
        return "PENSION_CERTIFICATE";
      case DocumentType.APPRENTICESHIP_FORM:
        return "APPRENTICESHIP_FORM";
      case DocumentType.SCHOOL_ENROLLMENT_CERTIFICATE:
        return "SCHOOL_ENROLLMENT_CERTIFICATE";
      case DocumentType.ARE_CERTIFICATE:
        return "ARE_CERTIFICATE";
      case DocumentType.JOB_OFFER:
        return "JOB_OFFER";
      case DocumentType.EMPLOYER_CERTIFICATE:
        return "EMPLOYER_CERTIFICATE";
      case DocumentType.REGISTRATION_SIRENE:
        return "REGISTRATION_SIRENE";
      case DocumentType.FINANCIAL_STATEMENT:
        return "FINANCIAL_STATEMENT";
      case DocumentType.OTHER:
        return "OTHER";
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
