// ignore: constant_identifier_names
enum SearchState { SEARCHING, PAUSED }

extension SearchStateExtension on SearchState {
  String get str {
    switch (this) {
      case SearchState.PAUSED:
        return "PAUSED";
      case SearchState.SEARCHING:
        return "SEARCHING";
    }
  }
}
