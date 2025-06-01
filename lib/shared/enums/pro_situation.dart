// ignore_for_file: constant_identifier_names

import 'package:tranquil_loc/shared/enums/document_type.dart';
import 'package:file_picker/file_picker.dart';
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

  Map<DocumentType, List<PlatformFile>> get documents {
    Map<DocumentType, List<PlatformFile>> documents = {
      DocumentType.IDENTITY_DOCUMENTS: [],
      DocumentType.PROOF_OF_ADDRESS: [],
      DocumentType.TAX_NOTICE: [],
      DocumentType.OTHER: [],
    };
    switch (this) {
      case ProSituation.CDD:
      case ProSituation.CDI:
        documents[DocumentType.EMPLOYMENT_CONTRACT] = [];
        documents[DocumentType.LAST_THREE_PAYSLIPS] = [];
        break;
      case ProSituation.RETIRED:
        documents[DocumentType.PENSION_CERTIFICATE] = [];
        break;
      case ProSituation.APPRENTICE:
        documents[DocumentType.APPRENTICESHIP_FORM] = [];
        documents[DocumentType.SCHOOL_ENROLLMENT_CERTIFICATE] = [];
        break;
      case ProSituation.UNEMPLOYED:
        documents[DocumentType.ARE_CERTIFICATE] = [];
        documents[DocumentType.JOB_OFFER] = [];
        break;
      case ProSituation.STUDENT:
        documents[DocumentType.SCHOOL_ENROLLMENT_CERTIFICATE] = [];
        break;
      case ProSituation.OFFICIAL:
        documents[DocumentType.EMPLOYER_CERTIFICATE] = [];
        break;
      case ProSituation.FREELANCE:
        documents[DocumentType.REGISTRATION_SIRENE] = [];
        documents[DocumentType.FINANCIAL_STATEMENT] = [];
        break;
      case ProSituation.OTHER:
        break;
    }
    return documents;
  }
}
