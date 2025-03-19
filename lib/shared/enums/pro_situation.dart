import 'package:dossier_locataire/shared/enums/document_type.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ProSituation {
  cdd,
  cdi,
  retired,
  apprentice,
  unemployed,
  student,
  official,
  freelance,
  other,
}

extension ProSituationExtension on ProSituation {
  String get str {
    switch (this) {
      case ProSituation.cdd:
        return "cdd";
      case ProSituation.cdi:
        return "cdi";
      case ProSituation.retired:
        return "retired";
      case ProSituation.apprentice:
        return "coopStudent";
      case ProSituation.unemployed:
        return "unemployed";
      case ProSituation.student:
        return "student";
      case ProSituation.official:
        return "official";
      case ProSituation.freelance:
        return "freelance";
      case ProSituation.other:
        return "other";
    }
  }

  String locale(AppLocalizations locale) {
    switch (this) {
      case ProSituation.cdd:
        return locale.cdd;
      case ProSituation.cdi:
        return locale.cdi;
      case ProSituation.retired:
        return locale.retired;
      case ProSituation.apprentice:
        return locale.apprentice;
      case ProSituation.unemployed:
        return locale.unemployed;
      case ProSituation.student:
        return locale.student;
      case ProSituation.official:
        return locale.official;
      case ProSituation.freelance:
        return locale.freelance;
      case ProSituation.other:
        return locale.other;
    }
  }

  Map<String, List<PlatformFile>> get documents {
    Map<String, List<PlatformFile>> documents = {
      DocumentType.identityDocuments.str: [],
      DocumentType.proofOfAddress.str: [],
      DocumentType.taxNotice.str: [],
      DocumentType.other.str: [],
    };
    switch (this) {
      case ProSituation.cdd:
      case ProSituation.cdi:
        documents[DocumentType.employmentContract.str] = [];
        documents[DocumentType.lastThreePayslips.str] = [];
        break;
      case ProSituation.retired:
        documents[DocumentType.pensionCertificate.str] = [];
        break;
      case ProSituation.apprentice:
        documents[DocumentType.apprenticeshipForm.str] = [];
        documents[DocumentType.schoolEnrollmentCertificate.str] = [];
        break;
      case ProSituation.unemployed:
        documents[DocumentType.areCertificate.str] = [];
        documents[DocumentType.jobOffer.str] = [];
        break;
      case ProSituation.student:
        documents[DocumentType.schoolEnrollmentCertificate.str] = [];
        break;
      case ProSituation.official:
        documents[DocumentType.employerCertificate.str] = [];
        break;
      case ProSituation.freelance:
        documents[DocumentType.registrationSirene.str] = [];
        documents[DocumentType.financialStatement.str] = [];
        break;
      case ProSituation.other:
        break;
    }
    return documents;
  }
}
