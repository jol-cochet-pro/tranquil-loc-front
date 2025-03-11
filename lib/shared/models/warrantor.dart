class Warrantor {
  final String id;
  final String firstname;
  final String lastname;
  final DateTime dateOfBirth;
  final bool hasIncomeFilled;
  final bool hasPersonalInfoFilled;
  final bool hasEmailFilled;
  final bool hasPhoneFilled;
  final bool hasAllDocumentsFilled;

  Warrantor({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.hasIncomeFilled,
    required this.hasPersonalInfoFilled,
    required this.hasEmailFilled,
    required this.hasPhoneFilled,
    required this.hasAllDocumentsFilled,
  });
}
