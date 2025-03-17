import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum DocumentType {
  identityDocuments,
  proofOfAddress,
  taxNotice,
  employmentContract,
  lastThreePayslips,
  pensionCertificate,
  apprenticeshipForm,
  schoolEnrollmentCertificate,
  areCertificate,
  jobOffer,
  employerCertificate,
  registrationSirene,
  financialStatement,
}

extension DocumentTypeExtension on DocumentType {
  String get str {
    switch (this) {
      case DocumentType.identityDocuments:
        return "identityDocuments";
      case DocumentType.proofOfAddress:
        return "proofOfAddress";
      case DocumentType.taxNotice:
        return "taxNotice";
      case DocumentType.employmentContract:
        return "employmentContract";
      case DocumentType.lastThreePayslips:
        return "lastThreePayslips";
      case DocumentType.pensionCertificate:
        return "pensionCertificate";
      case DocumentType.apprenticeshipForm:
        return "apprenticeshipForm";
      case DocumentType.schoolEnrollmentCertificate:
        return "schoolEnrollmentCertificate";
      case DocumentType.areCertificate:
        return "areCertificate";
      case DocumentType.jobOffer:
        return "jobOffer";
      case DocumentType.employerCertificate:
        return "employerCertificate";
      case DocumentType.registrationSirene:
        return "registrationSirene";
      case DocumentType.financialStatement:
        return "financialStatement";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case DocumentType.identityDocuments:
        return locale.identityDocuments;
      case DocumentType.proofOfAddress:
        return locale.proofOfAddress;
      case DocumentType.taxNotice:
        return locale.taxNotice;
      case DocumentType.employmentContract:
        return locale.employmentContract;
      case DocumentType.lastThreePayslips:
        return locale.lastThreePayslips;
      case DocumentType.pensionCertificate:
        return locale.pensionCertificate;
      case DocumentType.apprenticeshipForm:
        return locale.apprenticeshipForm;
      case DocumentType.schoolEnrollmentCertificate:
        return locale.schoolEnrollmentCertificate;
      case DocumentType.areCertificate:
        return locale.areCertificate;
      case DocumentType.jobOffer:
        return locale.jobOffer;
      case DocumentType.employerCertificate:
        return locale.employerCertificate;
      case DocumentType.registrationSirene:
        return locale.registrationSirene;
      case DocumentType.financialStatement:
        return locale.financialStatement;
    }
  }
}
