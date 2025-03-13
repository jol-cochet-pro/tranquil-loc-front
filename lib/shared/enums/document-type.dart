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
}
