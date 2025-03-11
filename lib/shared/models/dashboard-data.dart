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

  static DashboardData fromSnapshot(Map<String, dynamic> data) {
    SearchState state = SearchState.searching;
    try {
      state = SearchState.values.byName(data["searchState"]);
    } catch (_) {
      state = SearchState.searching;
    }
    return DashboardData(
      firstname: data["firstname"],
      opennedMail: data["opennedMail"],
      searchState: state,
    );
  }
}
