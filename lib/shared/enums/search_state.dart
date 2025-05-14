// ignore: constant_identifier_names
enum SearchState { SEARCHING, PAUSED }

extension SearchStateExtension on SearchState {
  String get str {
    switch (this) {
      case SearchState.PAUSED:
        return "paused";
      case SearchState.SEARCHING:
        return "searching";
    }
  }
}
