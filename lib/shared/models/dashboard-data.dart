import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dossier_locataire/shared/enums/search-state.dart';

class DashboardData {
  final String firstname;
  final int opennedMail;
  final SearchState searchState;

  const DashboardData({
    required this.firstname,
    required this.opennedMail,
    required this.searchState,
  });

  static Future<DashboardData> fromSnapshot(
    Future<DocumentSnapshot<Map<String, dynamic>>> data,
  ) {
    return data.then(
      (value) => DashboardData(
        firstname: value["firstname"],
        opennedMail: value["opennedMail"],
        searchState: value["searchState"],
      ),
    );
  }
}
