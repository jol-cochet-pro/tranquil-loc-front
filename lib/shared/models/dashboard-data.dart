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

  factory DashboardData.fromFirestore(Map<String, dynamic>? data) {
    SearchState state = SearchState.searching;
    try {
      state = SearchState.values.byName(data?["searchState"]);
    } catch (_) {
      state = SearchState.searching;
    }
    return DashboardData(
      firstname: data?["firstname"],
      opennedMail: data?["opennedMail"],
      searchState: state,
    );
  }

  static Map<String, Object?> toFirestore(DashboardData dashboardData) {
    return {
      "firstname": dashboardData.firstname,
      "opennedMail": dashboardData.opennedMail,
      "searchState": dashboardData.searchState.str,
    };
  }
}
