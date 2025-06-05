// ignore_for_file: constant_identifier_names

import 'package:tranquil_loc/shared/enums/document_type.dart';
import 'package:tranquil_loc/generated/l10n/app_localizations.dart';

enum ProSituation {
  CDD,
  CDI,
  RETIRED,
  APPRENTICE,
  UNEMPLOYED,
  STUDENT,
  OFFICIAL,
  FREELANCE,
  OTHER,
}

extension ProSituationExtension on ProSituation {
  String get str {
    switch (this) {
      case ProSituation.CDD:
        return "CDD";
      case ProSituation.CDI:
        return "CDI";
      case ProSituation.RETIRED:
        return "RETIRED";
      case ProSituation.APPRENTICE:
        return "APPRENTICE";
      case ProSituation.UNEMPLOYED:
        return "UNEMPLOYED";
      case ProSituation.STUDENT:
        return "STUDENT";
      case ProSituation.OFFICIAL:
        return "OFFICIAL";
      case ProSituation.FREELANCE:
        return "FREELANCE";
      case ProSituation.OTHER:
        return "OTHER";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case ProSituation.CDD:
        return locale.cdd;
      case ProSituation.CDI:
        return locale.cdi;
      case ProSituation.RETIRED:
        return locale.retired;
      case ProSituation.APPRENTICE:
        return locale.apprentice;
      case ProSituation.UNEMPLOYED:
        return locale.unemployed;
      case ProSituation.STUDENT:
        return locale.student;
      case ProSituation.OFFICIAL:
        return locale.official;
      case ProSituation.FREELANCE:
        return locale.freelance;
      case ProSituation.OTHER:
        return locale.other;
    }
  }

  List<DocumentType> get documents {
    List<DocumentType> documents = [
      DocumentType.IDENTITY_DOCUMENTS,
      DocumentType.PROOF_OF_ADDRESS,
      DocumentType.TAX_NOTICE,
      DocumentType.OTHER,
    ];
    switch (this) {
      case ProSituation.CDD:
      case ProSituation.CDI:
        documents.add(DocumentType.EMPLOYMENT_CONTRACT);
        documents.add(DocumentType.LAST_THREE_PAYSLIPS);
        break;
      case ProSituation.RETIRED:
        documents.add(DocumentType.PENSION_CERTIFICATE);
        break;
      case ProSituation.APPRENTICE:
        documents.add(DocumentType.APPRENTICESHIP_FORM);
        documents.add(DocumentType.SCHOOL_ENROLLMENT_CERTIFICATE);
        break;
      case ProSituation.UNEMPLOYED:
        documents.add(DocumentType.ARE_CERTIFICATE);
        documents.add(DocumentType.JOB_OFFER);
        break;
      case ProSituation.STUDENT:
        documents.add(DocumentType.SCHOOL_ENROLLMENT_CERTIFICATE);
        break;
      case ProSituation.OFFICIAL:
        documents.add(DocumentType.EMPLOYER_CERTIFICATE);
        break;
      case ProSituation.FREELANCE:
        documents.add(DocumentType.REGISTRATION_SIRENE);
        documents.add(DocumentType.FINANCIAL_STATEMENT);
        break;
      case ProSituation.OTHER:
        break;
    }
    return documents;
  }
}
